#!/usr/bin python3
import os
import re
import unittest
from time import perf_counter

from collections import Counter
from typing import Optional

import pandas as pd

from python_analysis.hex_check_config import config
from python_analysis.event_types import EventType, name_to_event
from python_analysis.dat_io import read_data_file, find_data_file
from python_analysis.hex_check_classes import Event, PeakHeight

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
        self.event_buffer: list[Event] = []  # buffer of all events
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
        self.full_hex_data, self.file_creation_date, self.headers = read_data_file(self.dir_name, self.file_name)  # Full hex data and file creation date
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
        
        # full_hex_data is a list of strings, each string is 8 characters long (4 bytes)
        # one "byte" in hex is two characters, for example, "ff"
    
    def get_event_types(self, _name_to_event):
        """Get all EventType objects from the global name_to_event dictionary
        and store them in the name_to_event dictionary."""
        self.name_to_event = _name_to_event


    def main(self):
        print(f"Using input file {self.file_name}")
        for header in self.headers:
            print(header)
        number_of_printed_logs = 0
        hex_reg = []
        for i, current_event_hex in enumerate(self.full_hex_data):
            if current_event_hex in ["ffffffff", 'ffffff11']:
                # discard all data before the first 0xffffffff
                self.full_hex_data = self.full_hex_data[i:]
                break
            else:
                print(f"Found {current_event_hex} before 0xffffffff, ignoring.")
                continue
                
        # each event starts with timestamp header, like
        # \n#TS event=123 epoch_us=1738141234567890 utc=2026-01-29T07:12:03Z\n
        # "\n#TS " = 0a 23 54 53 20
        # "Z\n" = 5a 0a
        
        r = re.compile(
            r'(?:ffffff11[0-9a-f]{16})?'  # optional timestamp packet
            r'ffffffff00ffffff.*?edededed00fcfcfc(?:fcfcfcfc)?'  # event payload (captured)
            r'(?=(?:ffffff11[0-9a-f]{16})?ffffffff00ffffff|$)',  # next record start or EOF
            re.DOTALL
        )
        hex_data_str = ''.join(self.full_hex_data)
        events = re.findall(r, hex_data_str)
        print(f"Found {len(events)} events in the file.")
        
        # events: list[NewEvent] = [NewEvent(i+1, data_str) for i, data_str in enumerate(events)]
        self.event_buffer: list[Event] = []
        for i, data_str in enumerate(events):
            if not (config.event_range[0] <= i < config.event_range[1]):
                continue
            event = Event(i + 1, data_str)
            self.event_buffer.append(event)
        # print(events)

        raw_data_panda = []
        peak_height_panda = []
        for event in self.event_buffer:
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
    

if __name__ == "__main__":
    try:
        hex_check: Optional[HexCheck] = HexCheck()
    except Exception as e:
        # print(f"Error initializing HexCheck: {e}")
        # traceback.print_exc()
        raise
    else:
        hex_check.get_event_types(name_to_event)
        
        # make hex_check available in hex_check_classes.py
        from hex_check_classes import hex_check_state
        
        hex_check_state[
            "hex_check"] = hex_check  # set global variable to the current instance of HexCheck
        
        # result = unittest.TextTestRunner().run(unittest.defaultTestLoader.discover("tests"))
        
        # if result.wasSuccessful():
        #     print("\nAll tests passed. Running hex_check...")
        # else:
        #     print("\nTests failed. Exiting.")
        #     exit()
        
        try:
            t1 = perf_counter()
            hex_check.main()
            t2 = perf_counter()
            print(f"Processing completed in {t2 - t1:.2f} seconds.")
        except Exception as e:
            print(f"Error processing file {hex_check.file_name}: {e}")
            raise


hex_check: HexCheck
