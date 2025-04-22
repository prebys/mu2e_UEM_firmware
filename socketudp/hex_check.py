#!/usr/bin python3
import sys
import os
import unittest

from collections import Counter
from dataclasses import field, dataclass
from typing import Optional

import pandas
from matplotlib import pyplot as plt
import pandas as pd

from datetime import datetime

from hex_check_classes import Event, EventType, convert_voltage, name_to_event

file_path = os.path.dirname(os.path.realpath(__file__))
os.chdir(file_path)


# sample of beginning of file:
# ffffffff 00ffffff f4f3f2f1 00ccccfc
# 00000000 2804ac00 fdfdfdfd f4f3f2f1
# 2804ac00 fafa03fa ffff9c10 00000000 ...

# #############################################################################
# #############################################################################
# #############################################################################
# ################### *START* FILE CONFIGURATION SETTINGS #####################
# #############################################################################
# #############################################################################
# #############################################################################

@dataclass
class Config:
    # set "desired_file" to None to use the most recent data file in the directory
    # setting to a name will search for any files with that name in the directory
    # consider searching for the names 'diag_0x1', 'diag_0x2', 'diag_0x3', 'diag_0x5', 'diag_0x9', 'diag_0xF'
    # desired_file = "test20241112_145129.dat"
    desired_file: Optional[str] = None

    # set to "1" to use the newest file in the directory
    # "2" for example will use the second-newest file
    to_use_file_index: int = 10

    # data processing mode
    # s12: 12-bit signed integer (normal ADC operation, split 32-bits into two 16-bit values, take top 12-bits)
    # s16: 16-bit signed integer (split 32-bits into two 16-bit values, take all 16-bits)
    # s32: 32-bit signed integer (take all 32-bits as one data point)
    mode: str = 's12'

    # show plots
    # set to True to visually display plots as they are created, or False to just save them and not display them
    # in an SSH client, "False" is recommended
    show_plots: bool = True

    # set number of events and subevents
    n_events: int = 1
    n_subevents: int = 19

    # search for cosmic events
    # set to True to only plot subevents where the voltage range in one of the three channels is greater than 0.5V
    search_for_cosmics: bool = False

    # plotting units
    # volts: standard operation, plot data in volts (convert from raw values)
    # raw: plot data in raw values (no conversion)
    plotting_units: str = "volts"  # "volts" or "raw"

    # if True, will print all event types regardless of the "only_show" list below
    show_all: bool = False

    # if True, will print NO EVENTS regardless of the "only_show" list
    show_nothing: bool = False

    # if this contains entries, then this code will only print the events in this list
    only_show: list[str] = field(default_factory=lambda: ["peak_height_data", "raw_data"])  # , "event_number_evn", etc.
    # set to empty list [] to use the "show" attribute of the name_to_event dictionary

    def __post_init__(self):
        assert self.plotting_units in ["volts", "raw"], \
            "Invalid plotting_units. Please choose 'volts' or 'raw'."

# #############################################################################
# #############################################################################
# #############################################################################
# ################### *END* FILE CONFIGURATION SETTINGS #######################
# #############################################################################
# #############################################################################
# #############################################################################

config = Config()

class HexCheck:
    def __init__(self):
        self.name_to_event: dict[str, EventType] = {}
        self.event_counts: dict[EventType, int] = Counter()
        self.event_buffer: list[Event] = []  # buffer of all events
        self.raw_data_buffer: list[Event] = []  # buffer of just raw data events
        self.peak_height_buffer: list[Event] = []  # buffer of just peak height events
        self.raw_data_dataframe: Optional[pandas.DataFrame] = None  # buffer of raw data events in a pandas DataFrame
        self.peak_height_dataframe: Optional[pandas.DataFrame] = None  # buffer of peak height events in a DataFrame
        
        if __name__ == "__main__":
            self.dir_name: str = os.path.dirname(os.path.realpath(__file__)).replace("\\", "/")  # Directory of the script
            self.file_name: str = self.find_data_file()  # Name of the data file
            self.full_hex_data, self.file_creation_date = self.read_data_file()  # Full hex data and file creation date
            self.date_str = self.file_creation_date.strftime('%Y.%m.%d_%H.%M.%S')
            self.folder_name = f"{self.date_str}_{self.file_name}"  # folder name inside /img directory
        
        # value of how many raw data points are remaining to be sent in current run of raw data
        # will only have value for raw_data event types
        self.raw_data_remaining = None
        self.adc_length = None
        
        # set mode for data processing
        self.mode = config.mode
        if self.mode != 's12':
            self.folder_name += f"_{self.mode}"
        
        # full_hex_data is a list of strings, each string is 8 characters long (4 bytes)
        # one "byte" in hex is two characters, for example, "ff"
    
    def get_event_types(self, _name_to_event):
        """Get all EventType objects from the global name_to_event dictionary
        and store them in the name_to_event dictionary."""
        self.name_to_event = _name_to_event
    
    def main(self, plot=True):
        number_of_printed_logs = 0
        current_event = None
        print("\n\nStart printing of data")
        for current_event_hex in self.full_hex_data:
            # detect current event type
            current_event = Event(
                new_hex=current_event_hex,
                previous_event=current_event  # this "current_event" is the event from the previous loop
            )
            
            # current_event object contains:
            # - current_event.hex: the current hex value
            # - current_event.previous_event: the previous event object
            # - current_event.type: the current event type object
            # - current_event.matched: whether the current event type was matched
            # - current_event.event_number: the event number of the current event
            # - current_event.sub_event_number: the sub-event number of the current event
            # - current_event.channel_number: the channel number of the current event
            # - current_event.internal_event_number: the internal event number of the current event
            # - current_event.data: the data of the current event
            
            if not current_event.matched:
                print(f"Error: {current_event.hex} (unknown event). "
                      f"Will continue searching for first recognizable event.")
                continue
            
            self.event_counts[current_event.type] += 1
            self.event_buffer.append(current_event)
            if current_event.type == "raw_data":
                self.raw_data_buffer.append(current_event)
            elif current_event.type == "peak_height_data_2":
                self.peak_height_buffer.append(current_event)
            
            log_number_limit = 1000
            if current_event.type.show and number_of_printed_logs < log_number_limit:
                number_of_printed_logs += 1
                print(current_event)
                if number_of_printed_logs == log_number_limit:
                    print(f"[INFO] Printing of data has been limited to {log_number_limit} logs.")
        
        for _, event_type in self.name_to_event.items():
            count = self.event_counts.get(event_type, 0)
            print(f"{event_type}: {count}")
        
        print(f"Used input file {self.file_name}")
        print(f"Starting collection of data")
        
        # add raw data to the dataframe
        self.raw_data_dataframe = self.make_raw_data_dataframe()
        self.peak_height_dataframe = self.make_peak_height_dataframe()
        
        group_by_event = self.raw_data_dataframe.groupby(["internal_event_number", "channel_number"])
        # show number of data points per event
        # for (_event_number, _channel_number), group in group_by_event:
        #     print(f"Event {_event_number} (ch{_channel_number}): {len(group)} data points, "
        #           f"mean value: {convert_voltage(group['data'].mean()):.3f} V")
        
        if plot:
            # self.plot_raw_data()
            self.plot_peak_height()
        
        return self.event_counts
    
    def make_raw_data_dataframe(self):
        panda_entry = []
        if self.mode in ["s12", "s16"]:
            for event in self.raw_data_buffer:
                panda_entry.append((event.event_number, event.internal_event_number, event.sub_event_number,
                                    event.channel_number, event.raw_data[0]))
                panda_entry.append((event.event_number, event.internal_event_number, event.sub_event_number,
                                    event.channel_number, event.raw_data[1]))
        elif self.mode == "s32":
            for event in self.raw_data_buffer:
                panda_entry.append((event.event_number, event.internal_event_number, event.sub_event_number,
                                    event.channel_number, event.raw_data[0]))
        
        panda_frame = pd.DataFrame(panda_entry,
                                    columns=["event_number",
                                             "internal_event_number",
                                             "sub_event_number",
                                             "channel_number",
                                             "data"])
        return panda_frame
    
    def make_peak_height_dataframe(self):
        panda_entry = []
        for event in self.peak_height_buffer:
            panda_entry.append((event.event_number, event.internal_event_number, event.sub_event_number,
                                event.channel_number, event.peak_height))
        
        panda_frame = pd.DataFrame(panda_entry,
                                   columns=["event_number",
                                            "internal_event_number",
                                            "sub_event_number",
                                            "channel_number",
                                            "peak_height"])
        return panda_frame
    
    def find_data_file(self) -> str:
        desired_file = config.desired_file
        # get directory of the script
        
        # argv gets the command line arguments
        # ex: `python3 hex_check.py path_to_data_file.dat`
        # argv[0] = hex_check.py, argv[1] = path_to_data_file.dat
        # args = [sys.argv[0], file_name]
        if len(sys.argv) > 1:
            desired_file = sys.argv[1]
        
        if desired_file is None:
            desired_file = ""
        if desired_file.startswith("./"):
            desired_file = self.file_name[2:]
        
        # find the file ending in .dat in the current directory
        files = os.listdir(self.dir_name + "/data")
        dat_files = sorted([file for file in files if file.endswith(".dat") and desired_file in file],
                           key=lambda x: os.path.getctime(f"./data/{x}"))
        if len(dat_files) == 0:
            raise ValueError("No .dat files found in the current directory matching search")
        elif len(dat_files) > 1:
            print(f"Warning: Multiple .dat files found in the current directory. "
                  f"Picking the last one ({dat_files[-1]})")
            input_file_name = dat_files[-config.to_use_file_index]
        else:
            input_file_name = dat_files[0]  # only one result
        return input_file_name
    
    def read_data_file(self) -> tuple[list[str], datetime]:
        # open binary file, get binary data and file creation date
        assert self.dir_name, "Directory name is not set."
        assert self.file_name, "File name is not set."
        assert os.path.exists(os.path.join(self.dir_name, "data", self.file_name)), "File does not exist."
        with open(os.path.join(self.dir_name, "data", self.file_name), "rb") as file:
            binary_data = file.read()  # a "bytes" object
            file_creation_date = datetime.fromtimestamp(os.path.getctime(file.name))
        
        # convert to hex, should be a single string containing the entire file starting with "ffffffffffffff00" etc
        hex_data: str = binary_data.hex()
        assert len(hex_data) % 8 == 0, "Hex data length is not divisible by 8"
        hex_data_list = [hex_data[i:i + 8] for i in range(0, len(hex_data), 8)]
        
        return hex_data_list, file_creation_date
    
    # Inside your HexCheck class
    
    def plot_event_grid(self, grouped_data: list[list[float]], internal_event: int, title_prefix: str,
                        file_prefix: str):
        """
        Plots a 2x2 grid using the grouped data.

        Parameters:
            grouped_data: List of 4 lists (one per channel). Each list contains Y-axis values to plot.
            internal_event: Event number for labeling and saving.
            title_prefix: Title string prefix (e.g. "Raw Data - Event").
            file_prefix: File prefix for saved image (e.g. "raw").
        """
        fig, axes = plt.subplots(2, 2, figsize=(10, 8))
        fig.suptitle(f"{title_prefix} {internal_event}", fontsize=14)
        
        for i, (ax, channel_data) in enumerate(zip(axes.flatten(), grouped_data)):
            channel = i + 1
            if channel_data:
                ax.plot(channel_data, label=f"Channel {channel}")
                ax.set_title(f"Channel {channel}")
                ax.legend()
                ax.grid(True)
            else:
                ax.text(0.5, 0.5, "No Data", fontsize=12, ha="center", va="center")
                ax.set_title(f"Channel {channel}")
            
            if i >= 2:
                ax.set_xlabel("Time (ns)")
            if i % 2 == 0:
                ax.set_ylabel("Voltage (V)" if config.plotting_units == "volts" else "Raw Data")
        
        plt.tight_layout(rect=(0, 0.03, 1, 0.95))
        output_path = f"img/{self.folder_name}/{file_prefix}_{internal_event}.png"
        plt.savefig(output_path)
        if config.show_plots:
            plt.show()
    
    def plot_raw_data(self):
        grouped = self.raw_data_dataframe.groupby(["internal_event_number", "sub_event_number"])
        for (internal_event, sub_event), group in grouped:
            if sub_event + 1 > config.n_subevents or internal_event > config.n_events:
                continue
            channel_arrays = []
            for ch in [1, 2, 3, 4]:
                ch_data = group[group["channel_number"] == ch]["data"].values
                y_vals = convert_voltage(ch_data) if config.plotting_units == "volts" else ch_data
                channel_arrays.append(y_vals.tolist())
            self.plot_event_grid(channel_arrays, internal_event, "Raw Data - Event", "raw")
    
    def plot_peak_height(self):
        grouped = self.peak_height_dataframe.groupby("internal_event_number")
        for internal_event, group in grouped:
            if internal_event > config.n_events:
                continue
            channel_arrays = []
            for ch in [1, 2, 3, 4]:
                ch_data = group[group["channel_number"] == ch]["peak_height"].values
                y_vals = convert_voltage(ch_data) if config.plotting_units == "volts" else ch_data
                channel_arrays.append(y_vals.tolist())
            self.plot_event_grid(channel_arrays, internal_event, "Peak Height - Event", "peak")


if __name__ == "__main__":
    hex_check = HexCheck()
    hex_check.get_event_types(name_to_event)
    
    # make hex_check available in hex_check_classes.py
    from hex_check_classes import hex_check_state
    hex_check_state["hex_check"] = hex_check  # set global variable to the current instance of HexCheck
    result = unittest.TextTestRunner().run(unittest.defaultTestLoader.discover("tests"))
    
    if result.wasSuccessful():
        print("\nAll tests passed. Running hex_check...")
        hex_check.main(plot=True)
    else:
        print("\nTests failed. Exiting.")
        exit()
    
