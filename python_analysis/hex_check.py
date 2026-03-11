#!/usr/bin python3
import logging
import os
from time import perf_counter

from collections import Counter
from typing import Optional

import pandas as pd

from python_analysis.hex_check_config import config
from python_analysis.event_types import EventType, name_to_event
from python_analysis.dat_io import read_data_file, find_data_file
from python_analysis.hex_check_classes import Event
from python_analysis.event_utils import iter_event_bytes, split_logical_events_on_subevent_reset

file_path = os.path.dirname(os.path.realpath(__file__))
os.chdir(file_path)


# sample of beginning of file:
# ffffffff 00ffffff f4f3f2f1 00ccccfc
# 00000000 2804ac00 fdfdfdfd f4f3f2f1
# 2804ac00 fafa03fa ffff9c10 00000000 ...


class HexCheck:
    def __init__(self, to_use_index_increment: int = 0, desired_file_path: str = None):
        self.name_to_event: dict[str, EventType] = {}
        self.event_counts: dict[EventType, int] = Counter()
        self.events: list[Event] = []  # buffer of all events
        self.raw_data_dataframe: Optional[pd.DataFrame] = None  # buffer of raw data events in a pandas DataFrame
        self.peak_height_dataframe: Optional[pd.DataFrame] = None  # buffer of peak height events in a DataFrame
        self.headers = []  # list of headers from the data file
        
        # if __name__ == "__main__":
        self.dir_name: str = os.path.dirname(os.path.realpath(__file__)).replace("\\", "/")  # Directory of the script
        if desired_file_path:
            config.desired_file_path = desired_file_path
            print(f"WARNING: Overriding desired_file_path in hex_check_config.py "
                  f"to {desired_file_path} from extinction_measurement.ipynb")
        self.file_name: str = find_data_file(config.desired_file_path, to_use_index_increment)  # Name of the data file
        self.full_hex_data, self.file_creation_date, self.headers = read_data_file(self.dir_name, self.file_name)  # Full byte payload and file creation date
        self.date_str = self.file_creation_date.strftime('%Y.%m.%d_%H.%M.%S')
        self.folder_name = f"{self.date_str}_{self.file_name}"  # folder name inside /img directory
        if not os.path.exists(f"img/{self.folder_name}"):
            os.makedirs(f"img/{self.folder_name}")
        # end commented if statement
        
        # value of how many raw data points are remaining to be sent in current run of raw data
        # will only have value for raw_data event types
        self.raw_data_remaining = None
        self.adc_length = None
        
        # set mode for data processing
        if config.integer_mode != 's12':
            self.folder_name += f"_{config.integer_mode}"
        
        # full_hex_data is the raw byte payload for the whole file.
    
    def get_event_types(self, _name_to_event):
        """Get all EventType objects from the global name_to_event dictionary
        and store them in the name_to_event dictionary."""
        self.name_to_event = _name_to_event


    def main(self):
        logger = logging.getLogger(self.__class__.__name__)
        print(f"Using input file {self.file_name}")
        for header in self.headers:
            print(header)
            if header.startswith("# Peakfinding Length: "):
                self.adc_length_header = int(header.split(": ")[1])
                print(f"Expected ADC length: {self.adc_length_header}")
            elif header.startswith("# Number of subevents: "):
                self.n_subevents_header = int(header.split(": ")[1])
                print(f"Expected number of subevents: {self.n_subevents_header}")
            elif header.startswith("# Peak height event count: "):
                # example, 100 peak height events means 50 peaks because each is two
                self.peak_height_event_count_header = int(int(header.split(": ")[1]) / 2)
                print(f"Expected number of peak height events: {self.peak_height_event_count_header}")


        number_of_printed_logs = 0
        hex_reg = []
        for marker in (b"\xff\xff\xff\xff", b"\xff\xff\xff\x11"):
            start_idx = self.full_hex_data.find(marker)
            if start_idx != -1:
                if start_idx > 0:
                    ignored_prefix = self.full_hex_data[:start_idx]
                    print(f"Found {len(ignored_prefix)} bytes before first event marker, ignoring.")
                self.full_hex_data = self.full_hex_data[start_idx:]
                break
                
        # each event starts with timestamp header, like
        # \n#TS event=123 epoch_us=1738141234567890 utc=2026-01-29T07:12:03Z\n
        # "\n#TS " = 0a 23 54 53 20
        # "Z\n" = 5a 0a
        
        # Use the shared event iterator to find events in the hex string
        raw_events = list(iter_event_bytes(self.full_hex_data))
        events = []
        split_count = 0
        for raw_event in raw_events:
            logical_events = split_logical_events_on_subevent_reset(raw_event)
            if len(logical_events) > 1:
                split_count += len(logical_events) - 1
            events.extend(logical_events)
        print(f"Found {len(raw_events)} regex-matched events in the file.")
        if split_count:
            print(f"Split {split_count} additional logical events at subevent-number resets.")
        print(f"Processing {len(events)} logical events.")
        
        # events: list[Event] = [Event(i+1, data_str) for i, data_str in enumerate(events)]
        self.events: list[Event] = []
        num_valid_events = 0
        for data_str in events:
            num_valid_events += 1
            if not (config.event_range[0] <= num_valid_events < config.event_range[1]):
                continue
            event = Event(num_valid_events, data_str)
            if event.empty_event:
                logger.info(f"SKIPPING empty event {num_valid_events}")
                num_valid_events -= 1
                continue
            logger.info(f"APPENDING {event} with {len(event.sub_events)} subevents")
            self.events.append(event)
        # print(events)

        raw_data_panda = []
        peak_height_panda = []
        for event in self.events:
            for i, sub_event in enumerate(event.sub_events):
                if i >= config.n_subevents:
                    break
                for c in sub_event.channels:
                    for data in c.raw_data_list:
                        raw_data_panda.append((c.internal_event_number, c.sub_event_number,
                                              c.channel_number, data))
                        
                    for peak in c.peak_height_list:
                        peak_height_panda.append((c.internal_event_number, c.channel_number,
                                                  c.sub_event_number, peak.time_ns, peak.height))
                                
        self.raw_data_dataframe = pd.DataFrame(raw_data_panda,
                                   columns=["internal_event_number",
                                            "sub_event_number",
                                            "channel_number",
                                            "data"])
        
        self.peak_height_dataframe = pd.DataFrame(peak_height_panda,
                                                  columns=["internal_event_number",
                                                           "channel_number",
                                                           "sub_event_number",
                                                           "time_ns",
                                                           "height"])


def build_hex_check(desired_file_path=None) -> HexCheck:
    """Build and return a HexCheck object to be used in the Jupyter notebook"""
    try:
        _hex_check: Optional[HexCheck] = HexCheck(desired_file_path=desired_file_path)
    except Exception as e:
        # print(f"Error initializing HexCheck: {e}")
        # traceback.print_exc()
        raise
    else:
        _hex_check.get_event_types(name_to_event)
        
        # make hex_check available in hex_check_classes.py
        import python_analysis.hex_check_classes as hcc
        hcc.hex_check_state["hex_check"] = _hex_check  # set global variable to the current instance of HexCheck

        # result = unittest.TextTestRunner().run(unittest.defaultTestLoader.discover("tests"))
        
        # if result.wasSuccessful():
        #     print("\nAll tests passed. Running hex_check...")
        # else:
        #     print("\nTests failed. Exiting.")
        #     exit()
        
        try:
            t1 = perf_counter()
            _hex_check.main()
            t2 = perf_counter()
            print(f"Processing completed in {t2 - t1:.2f} seconds.")
        except Exception as e:
            print(f"Error processing file {_hex_check.file_name}: {e}")
            raise
        
        return _hex_check



if __name__ == "__main__":
    build_hex_check(desired_file_path=None)
  
hex_check: HexCheck
