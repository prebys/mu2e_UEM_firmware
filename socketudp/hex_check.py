#!/usr/bin python3
import sys
import os
import unittest

from collections import Counter
from dataclasses import field, dataclass
from typing import Optional

import matplotlib.pyplot
import numpy as np
import pandas
from matplotlib import pyplot as plt, figure
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
        self.panda_frame: Optional[pandas.DataFrame] = None  # buffer of raw data events in a pandas DataFrame
        
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
            
            log_number_limit = 3000
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
        
        self.panda_frame = pd.DataFrame(panda_entry,
                                        columns=["event_number",
                                                 "internal_event_number",
                                                 "sub_event_number",
                                                 "channel_number",
                                                 "data"])
        
        group_by_event = self.panda_frame.groupby(["internal_event_number", "channel_number"])
        # show number of data points per event
        for (_event_number, _channel_number), group in group_by_event:
            print(f"Event {_event_number} (ch{_channel_number}): {len(group)} data points, "
                  f"mean value: {convert_voltage(group['data'].mean()):.3f} V")
        
        if plot:
            self.plot_data(config.n_events, config.n_subevents, show_plots=config.show_plots)
        
        return self.event_counts
    
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
    
    def plot_data(self, n_events=3, n_subevents=3, show_plots: bool = True):
        """Plot nevents number of events from the data_log dictionary.
        Save them in ./img/ folder."""
        print("Starting plotting of data")
        if not os.path.exists("img"):
            os.mkdir("img")
        if not os.path.exists(f"img/{self.folder_name}"):
            os.mkdir(f"img/{self.folder_name}")
        
        # Group by internal_event_number and sub_event_number
        grouped = self.panda_frame.groupby(["internal_event_number", "sub_event_number"])
        # looks like:
        # {('internal_event_number', 'sub_event_number'): DataFrame}
        # so for example, calling grouped[0, 0] will give you the DataFrame for the first internal event and sub-event
        # doing for (internal_event, sub_event), group in grouped: will iterate over each group
        # Iterate over each group
        for (internal_event, sub_event), group in grouped:
            if sub_event + 1 > n_subevents or internal_event > n_events:
                continue
            if internal_event > 5:
                pass
            # print(group.describe())
            # if sub_event > n_subevents:
            #     if internal_event < n_events:
            #         continue
            #     else:
            #         break
            
            # above loop does:
            # (0, 0), DataFrame ... (0, 1), DataFrame ... (0, 2), DataFrame ... [ ... ]
            # (1, 0), DataFrame ... (1, 1), DataFrame ... (1, 2), DataFrame ... [ ... ]
            # (2, 0), DataFrame ... (2, 1), DataFrame ... (2, 2), DataFrame ... [ ... ]
            # [ ... ]
            
            # Create a 2x2 grid
            fig, axes = plt.subplots(2, 2, figsize=(10, 8))
            fig: matplotlib.figure.Figure
            axes: np.ndarray[plt.Axes]
            time_str = self.file_creation_date.strftime("%Y-%m-%d %H:%M:%S")
            title = f"Event {internal_event}, Sub-Event {sub_event}"
            if self.mode != 's12':
                title += f" (Mode: {self.mode})"
            title += f"\n{self.file_name} ({time_str})"
            
            fig.suptitle(title, fontsize=14)
            
            # Plot each channel in its respective subplot
            i: int
            ax: plt.Axes
            channel: int
            
            # this will be set to True if a cosmic event is found (significant data in channels 1, 2, or 3)
            # if False, it will not plot/save the current plot
            if config.search_for_cosmics:
                found_cosmic_event = False
            else:
                found_cosmic_event = True
            for i, (ax, channel) in enumerate(zip(axes.flatten(), [1, 2, 3, 4])):
                # above loop does:
                # 0, (ax_0, 1) ... 1, (ax_1, 2) ... 2, (ax_2, 3) ... 3, (ax_3, 4)
                # Filter data for the current channel
                channel_number_bool_array = (group["channel_number"] == channel)  # True or False for each row
                channel_data = group[channel_number_bool_array]
                
                if not channel_data.empty:
                    ax.plot(channel_data["data"].values, label=f"Channel {channel}")
                    ax.set_title(f"Channel {channel}")
                    ax.legend()
                    
                    # get max and min values for y-axis
                    # VALUE refers to the matplotlib values / the raw data values in the code
                    # VOLTAGE refers to the converted voltage values / the values shown on the y-axis
                    max_value = max(channel_data["data"].values)
                    min_value = min(channel_data["data"].values)
                    max_voltage = convert_voltage(max_value)
                    min_voltage = convert_voltage(min_value)
                    voltage_range = max_voltage - min_voltage
                    value_range = max_value - min_value
                    if channel != 5:
                        if config.plotting_units == "raw":
                            print(internal_event, sub_event, channel, min_value, max_value, value_range)
                        else:
                            print(internal_event, sub_event, channel, min_voltage, max_voltage, voltage_range)
                    
                    if channel < 4 and voltage_range > 0.5:
                        found_cosmic_event = True
                        if config.search_for_cosmics:
                            print(f"Found cosmic event in event {internal_event}, sub-event {sub_event}")
                    
                    # Below underscore values for printing only
                    if config.plotting_units == "volts":
                        _max = max_voltage
                        _min = min_voltage
                        _range = voltage_range
                        _offset = _range * 0.5 or max_voltage * 0.5
                    elif config.plotting_units == "raw":
                        _max = max_value
                        _min = min_value
                        _range = max_value - min_value
                        _offset = _range * 0.5 or max_value * 0.5
                    else:
                        raise ValueError("Invalid plotting_units. Please choose 'raw' or 'volts'.")
                    
                    # even if using volts for the units, the internal values will be the raw values
                    value_offset = value_range * 0.5 or abs(max_value) * 0.5
                    
                    # this will be used for setting the y-axis limits
                    # examples:
                    # points between -15 and -20, zero_dist=20, range=5, zero_dist > range, y-axis is -21 to -14
                    # points between 3 and -4, zero_dist=4, range=7, zero_dist < range, y-axis could be -5.4 to 4.4
                    #     but let it just be something like -5.4 to 5.4 for better readability
                    distance_to_zero = max(abs(max_value), abs(min_value))
                    if distance_to_zero > value_range * 3:
                        # center y-axis around points rather than zero
                        ax.set_ylim(min_value - value_offset, max_value + value_offset)
                    else:
                        # center y-axis around zero
                        ax.set_ylim(-distance_to_zero - value_offset, distance_to_zero + value_offset)
                    
                    # if 0 < voltage_range < 0.01:
                    #     print(f"Channel {channel} has a small range of values, "
                    #           f"setting y-axis to "
                    #           f"{_min - _offset:.3} ~ {_max + _offset:.3}.")
                    #     ax.set_ylim(min_value - value_offset, max_value + value_offset)
                    # elif voltage_range == 0:
                    #     print(f"Plotting constant value {_max} for channel {channel}, "
                    #           f"setting y-axis to "
                    #           f"{_min - _offset:.3}~{_max + _offset:.3}.")
                    #     ax.set_ylim(min_value - value_offset, max_value + value_offset)
                    
                    # find number of decimal places to show by converting voltage range to scientific notation
                    num_decimal_places = int(f'{_offset:e}'.split('e')[-1])  # for example, 1e-3 gives -3
                    if num_decimal_places < 0:
                        # if negative decimals, for example, 1e-4, record "4"
                        num_decimal_places = -num_decimal_places
                    else:
                        num_decimal_places = 1
                    
                    def formatter_func(v, _):
                        # takes in two arguments, voltage and time
                        s = f"{convert_voltage(v):.{num_decimal_places + 2}f}"
                        return s
                    
                    # format y-axis in terms of volts
                    # number of decimal places on y-axis based on above calculation
                    if config.plotting_units == "volts":
                        if num_decimal_places < 3:
                            # for example, 1e-4, or 0.0001, show all decimal places
                            formatter = plt.FuncFormatter(formatter_func)
                            # formatter.set_offset_string(f"{_max:.{num_decimal_places}f}")
                            ax.yaxis.set_major_formatter(formatter)
                        else:
                            # for example, 1e-3, or 0.001, show 3 decimal places every time
                            formatter = plt.FuncFormatter(lambda v, t:
                                                          f"{convert_voltage(v) * 10 ** num_decimal_places:.3f}")
                            formatter.set_offset_string(f"{1 / 10 ** num_decimal_places:.0e}")
                            ax.yaxis.set_major_formatter(formatter)
                    else:
                        pass  # Just let matplotlib format its own axis
                
                else:
                    ax.text(0.5, 0.5, "No Data", fontsize=12, ha="center", va="center")
                    ax.set_title(f"Channel {channel}")
                
                ax.grid(True)
                
                # Add x-labels only for the bottom row
                if i >= 2:  # Bottom row indices are 2 and 3
                    ax.set_xlabel("Time (ns)")
                
                # Add y-labels only for the left column
                if i % 2 == 0:  # Left column indices are 0 and 2
                    if config.plotting_units == "raw":
                        ax.set_ylabel("Raw Data")
                    elif config.plotting_units == "volts":
                        ax.set_ylabel("Voltage (V)")
                    else:
                        raise ValueError("Invalid plotting_units. Please choose 'raw' or 'volts'.")
            
            # Adjust layout
            if found_cosmic_event:
                plt.tight_layout(rect=(0, 0.03, 1, 0.95))
                plt.savefig(f"img/{self.folder_name}/event_{internal_event}.{sub_event}.png")
                
                if show_plots:
                    plt.show()




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
    
