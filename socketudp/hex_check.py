#!/usr/bin python3
import functools
import struct
import sys
import os
import re
import time
import unittest

from collections import Counter
from typing import Optional, Union

import matplotlib.pyplot
import numpy as np
import pandas
from matplotlib import pyplot as plt, figure
import pandas as pd

from datetime import datetime

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

# set "desired_file" to None to use the most recent data file in the directory
# setting to a name will search for any files with that name in the directory
# consider searching for the names 'diag_0x1', 'diag_0x2', 'diag_0x3', 'diag_0x5', 'diag_0x9', 'diag_0xF'
# desired_file = "test20241112_145129.dat"
desired_file = None

# set to "1" to use the newest file in the directory
# "2" for example will use the second-newest file
to_use_file_index = 1

# data processing mode
# s12: 12-bit signed integer (normal ADC operation, split 32-bits into two 16-bit values, take top 12-bits)
# s16: 16-bit signed integer (split 32-bits into two 16-bit values, take all 16-bits)
# s32: 32-bit signed integer (take all 32-bits as one data point)
_mode = 's12'

# show plots
# set to True to visually display plots as they are created, or False to just save them and not display them
# in an SSH client, "False" is recommended
_show_plots = True

# set number of events and subevents
_n_events = 20
_n_subevents = 5

# search for cosmic events
# set to True to only plot subevents where the voltage range in one of the three channels is greater than 0.5V
_search_for_cosmics = False

# plotting units
# volts: standard operation, plot data in volts (convert from raw values)
# raw: plot data in raw values (no conversion)
plotting_units = "volts"  # "volts" or "raw"
assert plotting_units in ["volts", "raw"], "Invalid plotting_units. Please choose 'volts' or 'raw'."

# if True, will print all event types regardless of the "only_show" list below
show_all = False

# if True, will print NO EVENTS regardless of the "only_show" list
show_nothing = False

# if this contains entries, then this code will only print the events in this list
only_show = ["begin_event"]  # , "event_number_evn"] # , "sub_event_number_evn"]
# set to empty list [] to use the "show" attribute of the name_to_event dictionary

# #############################################################################
# #############################################################################
# #############################################################################
# ################### *END* FILE CONFIGURATION SETTINGS #######################
# #############################################################################
# #############################################################################
# #############################################################################

class EventType:
    """Class describing an event type, for example, begin_event or raw_data"""
    
    def __init__(self, regex_pattern: str, next_event: list[str], show: bool = False):
        self.regex_pattern = regex_pattern
        self._next_event = next_event  # list of strings like ['raw_data', 'end_of_channel']
        self._name = None  # name of the variable of this instance
        # ^ but if called, return property "next_event" which is list of actual event types
        
        self._show = show
        
        try:
            start_index = regex_pattern.index(".")
        except ValueError:
            start_index = None
        try:
            end_index = regex_pattern.rindex(".") + 1
        except ValueError:
            end_index = None
        
        if not start_index and not end_index:
            self.data_chars = [0, 0]
        else:
            self.data_chars = [start_index, end_index]
    
    @functools.cached_property
    def name(self):
        """Return name of the variable of this instance"""
        return [name for name, event_type in name_to_event.items() if event_type is self][0]
    
    @functools.cached_property
    def show(self):
        """Return whether this event type should be shown in the output"""
        if show_all and show_nothing:
            raise ValueError("Both show_all and show_nothing are True. Please set one to False.")
        if show_all:
            return True
        if show_nothing:
            return False
        if self.name in only_show:
            return True
        return self._show
    
    @functools.cached_property
    def next_event(self) -> list["EventType"]:
        """Replace list of ['begin_event'] with list of actual EventType objects [begin_event]"""
        # the reversed() is very subtle, but it will prioritize later events over earlier ones
        # this is important for events like RawData, which can be followed by itself or End
        # by prioritizing "End", it'll end properly rather than recognizing the "End" event as another "RawData" event
        ret = [event_type for name, event_type in reversed(name_to_event.items()) if name in self._next_event]
        assert len(ret) == len(self._next_event), f"Expected {len(self._next_event)} events, got {len(ret)}."
        if "raw_data" in self._next_event:
            assert ret[-1] == raw_data, f"Expected last event to be raw_data, got {ret}."
        return ret
    
    def __eq__(self, other: Union[str, "EventType"]):
        """Allow comparison of EventType and string event type names.
        For example, begin_event<EventType> == "begin_event"<str> would return True. """
        if isinstance(other, str):
            return self.name == other
        elif isinstance(other, EventType):
            return self.name == other.name
        else:
            raise ValueError("Can only compare an EventType with other EventTypes or strings.")
    
    def __repr__(self):
        return f"<EventType '{self.name}', regex '{self.regex_pattern}'>"
    
    def __hash__(self):
        return hash(self.name)


class Event:
    """An Event object that contains the current hex value and the previous event type."""
    def __init__(self, new_hex: str, previous_event: "Event" = None, current_event_type: EventType = None):
        """Create an Event object with the current hex value and the previous event type."""
        global hex_check
        self.hex_check = hex_check
        self.hex = new_hex
        self._previous_event: PrevEvent = PrevEvent(previous_event) if previous_event else None
        if not current_event_type:
            self.matched, self.type = self.detect_current_event_type()
        else:
            self.matched = True
            self.type = current_event_type
        
        # event_number (each event contains multiple sub_events)
        # -- sub_event_number (each sub_event contains four channels worth of data)
        # -- event_number and sub_event_number increment *with each other*, when one goes up so does the other
        # -- but event_number is offset by some internal FPGA amount randomly
        # -- -- channel_number (each channel contains a waveform)

        if self.previous_event:
            if self.type == begin_event:
                self.internal_event_number = self.previous_event.internal_event_number + 1
            else:
                self.internal_event_number = self.previous_event.internal_event_number
        else:
            if self.hex == 'ffffffff':
                # standard operation: first event of dataset is start_event
                self.internal_event_number = 1
            else:
                # for rare datasets where the first event is not start_event. this will be incremented to 1 later.
                self.internal_event_number = 0
    
    @functools.cached_property
    def event_number(self) -> int:
        """Return the event number of the event."""
        return self.get_event_channel_number("event_number", event_number_evn)
    
    @functools.cached_property
    def sub_event_number(self) -> int:
        """Return the sub-event number of the event."""
        if self.type == begin_event:
            return 0
        return self.get_event_channel_number("sub_event_number", sub_event_number_evn)
    
    @functools.cached_property
    def channel_number(self) -> int:
        """Return the channel number of the event."""
        if self.type == begin_event:
            return 0
        return self.get_event_channel_number("channel_number", channel_header)

    @functools.cached_property
    def previous_event(self) -> Optional["PrevEvent"]:
        """Return the previous event object."""
        if not self._previous_event:
            return None
        else:
            return self._previous_event
    
    def get_data_str(self) -> Optional[str]:
        """Returns the string of data as received in the UDP packet"""
        data_chars = self.type.data_chars
        data_str = self.hex[data_chars[0]:data_chars[1]]
        return data_str if data_str else None
    
    def get_data_bytes(self) -> Optional[bytes]:
        """Returns the string of data in byte form as received in the UDP packet"""
        data_str = self.get_data_str()
        data_str = f"{data_str:08}" if data_str else None  # ensure it's 8 characters long
        return bytes.fromhex(data_str) if data_str else None
    
    @functools.cached_property
    def data(self) -> int:
        """Returns integer value of data packet in little-endian format (re-convert f4f3f2f1 to f1f2f3f4)
        For processing raw_data events, call raw_data property instead."""
        if self.type != raw_data:
            data_bytes = self.get_data_bytes()
            return struct.unpack("<I", data_bytes)[0] if data_bytes else None
        else:
            raise ValueError("This event is a raw_data event.")
    
    @functools.cached_property
    def raw_data(self) -> list[int]:
        """Returns the raw data as a list of integers, processed by process_hex_raw_data"""
        if self.type == raw_data:
            return self.process_hex_raw_data(mode=self.hex_check.mode)
        else:
            raise ValueError("This event is not a raw_data event.")
    
    def get_event_channel_number(self, number_type: str, event_type: EventType) -> int:
        if self.type == event_type:
            if event_type == channel_header:
                return self.data + 1  # change range of channels from 0~3 to 1~4
            else:
                return self.data
        else:
            return getattr(self.previous_event, number_type, 0)
    
    def detect_current_event_type(self) -> tuple[bool, Optional[EventType]]:
        # if the current event is one of the data streams, check the rest of the checks and check directly
        # for another data event (avoid regex)
        
        # first event should be checked as potentially "begin_event"
        if not self.previous_event:
            next_event_candidates = [self.hex_check.name_to_event['begin_event']]
        else:
            next_event_candidates = self.previous_event.type.next_event
        for potential_event_type in next_event_candidates:
            if '.' not in potential_event_type.regex_pattern:
                search = potential_event_type.regex_pattern == self.hex
            else:
                search = re.match(potential_event_type.regex_pattern, self.hex)
            if search:
                matched = True
                current_event_type = potential_event_type
                return matched, current_event_type
            
        return False, None

    def process_hex_raw_data(self, mode) -> list[int]:
        # FOR HELP UNDERSTANDING ABOUT SIGNED VS UNSIGNED INTEGERS IN PYTHON:
        # See /documentation_texts/signed_vs_unsigned_tests.ipynb
        # Short summary:
        # - Python does not distinguish between signed and unsigned integers.
        # - In memory, all numbers are stored as binary, and the sign is determined by the leftmost bit.
        # - Example: 13 = 0b1101, -13 = 0b1011 (two's complement)
        # - But, looking past the fourth bit, 13 = 0b0_1101, -13 = 0b1_1011 (sign bit is 1)
        # - Below, it does not matter whether you use 'I' or 'i' in the struct.unpack() function.
        # - They will produce the same binary in memory, only the interpretation of that binary number will differ
        # - In the last step is where we choose to interpret it as a signed integer.
        
        # Input: Hexadecimal string
        
        # MODES:
        # s12: 12-bit signed integer (normal ADC operation, split 32-bits into two 16-bit values, take top 12-bits)
        # s16: 16-bit signed integer (split 32-bits into two 16-bit values, take all 16-bits)
        # s32: 32-bit signed integer (take all 32-bits as one data point)
        if mode not in ["s12", "s16", "s32"]:
            raise ValueError("Invalid mode. Please choose 's12', 's16', or 's32'.")
        
        # Step 1: Convert the hex string to bytes
        # Each pair of characters in the hex string represents a byte.
        # Use `bytes.fromhex` to parse the string.
        byte_data = bytes.fromhex(self.hex)
        
        # Step 2: Reconstruct the 32-bit word in little-endian order
        # Use the unpack function from the struct module to interpret the bytes in little-endian format.
        try:
            # '<' = little-endian, 'f4f3f2f1' would first get converted to 'f1f2f3f4' before being converted to int
            # 'I' = unsigned integer (4-byte, 8 hex chars), 'i' = signed int (4-byte, 8 hex chars)
            # 'H' = unsigned short (2-byte, 4 hex chars), 'h' = signed short (2-byte, 4 hex chars)
            # https://docs.python.org/3/library/struct.html#format-characters
            word: int = struct.unpack('<I', byte_data)[0]  # unpack() returns tuple, here with one element only
            # word is the signed interpretation of the full 32-bit word, f1f2f3f4 --> -235736076, NOT simply -0xf1f2f3f4
        except struct.error:
            print(f"Error: {self.hex} could not be converted to a 32-bit word.")
            raise
        
        if mode == 's12':
            # Step 3: Extract the first ADC value (upper 16 bits of `word`)
            adcvalue1: int = (((word >> 16) & 0xFFF0) >> 4)  # Shift right 16 bits, mask, then shift right 4 again
            adcvalue1 = signed(adcvalue1, 12)
            
            # Step 4: Extract the second ADC value (lower 16 bits of `word`)
            adcvalue2: int = ((word & 0xFFF0) >> 4)  # Get upper 12 bits, shift right by 4 to be lowest 12 bits
            adcvalue2 = signed(adcvalue2, 12)
            
            ret_val: list[int] = [adcvalue1, adcvalue2]
        elif mode == 's16':
            # Step 3: Extract the first ADC value (upper 16 bits of `word`)
            adcvalue1: int = word >> 16  # Shift right 16 bits
            adcvalue1 = signed(adcvalue1, 16)
            
            # Step 4: Extract the second ADC value (lower 16 bits of `word`)
            adcvalue2: int = word & 0xFFFF  # Get upper 12 bits, shift right by 4 to be lowest 12 bits
            adcvalue2 = signed(adcvalue2, 16)
            
            ret_val = [adcvalue1, adcvalue2]
        else:  # mode == 's32'
            ret_val = [signed(word, 32)]
        
        return ret_val
    
    def __eq__(self, other: "Event"):
        return self.__hash__() == other.__hash__()
    
    def __hash__(self):
        return hash((self.hex, self.type, self.event_number, self.sub_event_number, self.channel_number))
    
    def __repr__(self):
        if hasattr(self, "event_number"):
            ret = (f"<Event {self.hex} "
                   f"#{self.event_number}-{self.internal_event_number}-{self.sub_event_number}-{self.channel_number} "
                   f"({self.type.name})")
        elif hasattr(self, "type"):
            return f"<Event {self.hex} ({self.type.name})>"
        else:
            return f"<Event {self.hex} (UnknownType)>"
        
        if self.type == raw_data:
            ret += f" = {self.raw_data}>"
        else:
            if self.data is not None:
                ret += f" = {self.data}>"
            else:
                ret += ">"
        return ret


class PrevEvent:
    """This class will maintain just the important information about the previous event, to prevent every
    event from having a chain to all previous events."""
    
    def __init__(self, event_in: Event):
        self.hex = event_in.hex
        self.type = event_in.type
        self.event_number = event_in.event_number
        self.sub_event_number = event_in.sub_event_number
        self.channel_number = event_in.channel_number
        self.internal_event_number = event_in.internal_event_number
        self._previous_event = None
        
        self.__repr__ = event_in.__repr__
        self.__str__ = event_in.__str__
        self.__hash__ = event_in.__hash__
        self.__eq__ = event_in.__eq__


begin_event = EventType('ffffffff', ['begin_event', 'begin_sub_event'])
begin_sub_event = EventType('00ffffff', ['byte_order'])
byte_order = EventType('f4f3f2f1', ['fmc228_number'])
fmc228_number = EventType('..ccccfc', ['sub_event_number_evn'])
sub_event_number_evn = EventType('........', ['event_number_evn'])
event_number_evn = EventType('........', ['begin_raw_data'])
begin_raw_data = EventType('fdfdfdfd', ['byte_order2'])
byte_order2 = EventType('f4f3f2f1', ['event_number_evn2'])
event_number_evn2 = EventType('........', ['channel_header'])
channel_header = EventType('fafa..fa', ['waveform'])
waveform = EventType('ffff....', ['fragment_trig_mask'])
fragment_trig_mask = EventType('0000....', ['stat'])
stat = EventType('........', ['status_word'])
status_word = EventType('........', ['bco_low'])
bco_low = EventType('........', ['bco_high'])
bco_high = EventType('........', ['end_of_channel', 'raw_data'])
raw_data = EventType('........', ['end_of_channel', 'raw_data'])
end_of_channel = EventType('fbfbfbfb', ['end_raw_data', 'channel_header'])
end_raw_data = EventType('fefefefe', ['begin_peak_data'])
begin_peak_data = EventType('efefefef', ['channel_number'])
channel_number = EventType('eeee....', ['peak_finding_header'])
peak_finding_header = EventType('aaaaaaaa', ['peak_height_header'])
peak_height_header = EventType('cccccccc', ['peak_height_end', 'peak_height_data'])
peak_height_data = EventType('........', ['peak_height_end', 'peak_height_data'])
peak_height_end = EventType('cececece', ['peak_area_header'])
peak_area_header = EventType('dddddddd', ['peak_area_end', 'peak_area_data'])
peak_area_data = EventType('........', ['peak_area_end', 'peak_area_data'])
peak_area_end = EventType('dededede', ['end_peak_data'])
end_peak_data = EventType('bbbbbbbb', ['end_peak_channel'])
end_peak_channel = EventType('ecececec', ['end_peak_stream_data', 'channel_number'])
end_peak_stream_data = EventType('edededed', ['end_sub_event'])
end_sub_event = EventType('00fcfcfc', ['end_event', 'begin_sub_event', 'begin_event'])
end_event = EventType('fcfcfcfc', ['begin_event'])
name_to_event = {name: event for name, event in globals().items() if isinstance(event, EventType)}


def convert_voltage(v):
    # ADC peak-to-peak is 1.34V (+/- 0.67V), so 0.67V = 2047, -0.67V = -2048
    # Voltage at FMC228 transformer is 2.52V, ratio is 2.52V / 1.34V = 1.88V
    # Therefore, values at FMC228 pins are 1.88 * ADC values
    # 2047 = 0.67 * 1.88 = 1.26V, -2048 = -0.67 * 1.88 = -1.26V
    # Max voltage is +/- 1.26V
    if _mode == 's12':
        return v * 1.26 / 2047
    elif _mode == 's16':
        return v * 1.26 / (2047 / 2**11 * 2**15)
    elif _mode == 's32':
        return v * 1.26 / (2047 / 2**11 * 2**31)
    
    
def convert_voltage_reverse(v):
    if _mode == 's12':
        return v * 2047 / 1.26
    elif _mode == 's16':
        return v * (2047 / 2**11 * 2**15) / 1.26
    elif _mode == 's32':
        return v * (2047 / 2**11 * 2**31) / 1.26
    

def signed(value: int, width: int) -> int:
    """Converts an unsigned value to a signed value."""
    if value >= 2 ** width:
        raise ValueError(f"Value must be at most {width}-bit{f' ({width // 4} bytes)' if width % 4 == 0 else ''}. "
                         f"Your value {value} / {hex(value)} had {len(bin(value)) - 2} bits.")
    width = width - 1  # example: for four bit number, shift "1" over 4-1=3 to get 1000 (the desired sign bit)
    return -(value & (1 << width)) | (value & ((1 << width) - 1))


class HexCheck:
    def __init__(self):
        self.name_to_event: dict[str, EventType] = {}
        self.event_counts: dict[EventType, int] = Counter()
        self.event_buffer: list[Event] = []  # buffer of all events
        self.raw_data_buffer: list[Event] = []  # buffer of just raw data events
        self.panda_frame: Optional[pandas.DataFrame] = None  # buffer of raw data events in a pandas DataFrame
        self.dir_name: str = os.path.dirname(os.path.realpath(__file__)).replace("\\", "/")  # Directory of the script
        self.file_name: str = self.find_data_file()  # Name of the data file
        self.full_hex_data, self.file_creation_date = self.read_data_file()  # Full hex data and file creation date
        self.date_str = self.file_creation_date.strftime('%Y.%m.%d_%H.%M.%S')
        self.folder_name = f"{self.date_str}_{self.file_name}"  # folder name inside /img directory
        
        # set mode for data processing
        self.mode = _mode
        if self.mode != 's12':
            self.folder_name += f"_{self.mode}"
        
        # full_hex_data is a list of strings, each string is 8 characters long (4 bytes)
        # one "byte" in hex is two characters, for example, "ff"
    
    def get_event_types(self):
        """Get all EventType objects from the global name_to_event dictionary
        and store them in the name_to_event dictionary."""
        global name_to_event
        self.name_to_event = name_to_event
    
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
            if current_event.type == raw_data:
                self.raw_data_buffer.append(current_event)
            
            if current_event.type.show and number_of_printed_logs < 1000:
                number_of_printed_logs += 1
                print(current_event)
        
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
            self.plot_data(_n_events, _n_subevents, show_plots=_show_plots)
        
        return self.event_counts
    
    def find_data_file(self) -> str:
        global desired_file
        
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
            input_file_name = dat_files[-to_use_file_index]
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
            if sub_event > n_subevents or internal_event > n_events:
                pass
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
            if _search_for_cosmics:
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
                    if channel < 4:
                        ax.set_title(f"Channel {channel} (PMT {channel})")
                    else:
                        ax.set_title(f"Channel {channel} (DC Ramp)")
                    ax.legend()
                    
                    # get max and min values for y-axis
                    # VALUE refers to the matplotlib values / the raw data values in the code
                    # VOLTAGE refers to the converted voltage values / the values shown on the y-axis
                    max_value = max(channel_data["data"].values)
                    min_value = min(channel_data["data"].values)
                    max_voltage = convert_voltage(max_value)
                    min_voltage = convert_voltage(min_value)
                    voltage_range = max_voltage - min_voltage
                    print(internal_event, sub_event, channel, voltage_range)

                    if channel < 4 and voltage_range > 0.5:
                        found_cosmic_event = True
                        if _search_for_cosmics:
                            print(f"Found cosmic event in event {internal_event}, sub-event {sub_event}")

                    # Below underscore values for printing only
                    if plotting_units == "volts":
                        _max = max_voltage
                        _min = min_voltage
                        _range = voltage_range
                        _offset = _range * 0.5 or max_voltage * 0.5
                    elif plotting_units == "raw":
                        _max = max_value
                        _min = min_value
                        _range = max_value - min_value
                        _offset = _range * 0.5 or max_value * 0.5
                    else:
                        raise ValueError("Invalid plotting_units. Please choose 'raw' or 'volts'.")
                    
                    # even if using volts for the units, the internal values will be the raw values
                    value_range = max_value - min_value
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
                        num_decimal_places = -num_decimal_places
                    else:
                        num_decimal_places = 1
                    
                    # format y-axis in terms of volts
                    # number of decimal places on y-axis based on above calculation
                    if plotting_units == "volts":
                        if num_decimal_places < 3:
                            formatter = plt.FuncFormatter(lambda v, t: f"{convert_voltage(v):.{num_decimal_places}f}")
                            # formatter.set_offset_string(f"{_max:.{num_decimal_places}f}")
                            ax.yaxis.set_major_formatter(formatter)
                        else:
                            formatter = plt.FuncFormatter(lambda v, t:
                                                          f"{convert_voltage(v)*10**num_decimal_places:.2f}")
                            formatter.set_offset_string(f"{1/10**num_decimal_places:.0e}")
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
                    if plotting_units == "raw":
                        ax.set_ylabel("Raw Data")
                    elif plotting_units == "volts":
                        ax.set_ylabel("Voltage (V)")
                    else:
                        raise ValueError("Invalid plotting_units. Please choose 'raw' or 'volts'.")
            
            # Adjust layout
            if found_cosmic_event:
                plt.tight_layout(rect=(0, 0.03, 1, 0.95))
                plt.savefig(f"img/{self.folder_name}/event_{internal_event}.{sub_event}.png")

                if show_plots:
                    plt.show()


hex_check = HexCheck()
hex_check.get_event_types()  # populate internal event type dictionary

if __name__ == "__main__":
    # small tests
    tests = unittest.TestCase()
    # 12-bit tests
    tests.assertEqual(signed(0x7FF, 12), 0x7FF)
    tests.assertEqual(signed(0x800, 12), -0x800)
    # 16-bit tests
    tests.assertEqual(signed(0x7FFF, 16), 0x7FFF)
    tests.assertEqual(signed(0x8000, 16), -0x8000)
    # 32-bit tests
    tests.assertEqual(signed(0x7FFFFFFF, 32), 0x7FFFFFFF)
    tests.assertEqual(signed(0x80000000, 32), -0x80000000)
    # misc. size
    tests.assertEqual(signed(0b100000, 6), -0b100000)
    tests.assertRaises(ValueError, signed, 0b11111111111111111111111, 12)
    
    # process_hex_raw_data tests
    # s12: f4f3f2f1 > f1f2f3f4 > [f1f2, f3f4], [_f1f, _f3f], signed(12-bit) --> [-225, -193]
    #      78563412 > 12345678 > [1234, 5678], [_123, _567], signed(12-bit) --> [291, 1383]
    tests.assertEqual(Event("f4f3f2f1", current_event_type=raw_data).process_hex_raw_data(mode='s12'), [-225, -193])
    tests.assertEqual(Event("78563412", current_event_type=raw_data).process_hex_raw_data(mode='s12'), [291, 1383])
    # s16: f4f3f2f1 > f1f2f3f4 > [f1f2, f3f4], signed(16-bit) --> [-3598, -3084]
    #      78563412 > 12345678 > [1234, 5678], signed(16-bit) --> [4660, 22136]
    tests.assertEqual(Event("f4f3f2f1", current_event_type=raw_data).process_hex_raw_data(mode='s16'), [-3598, -3084])
    tests.assertEqual(Event("78563412", current_event_type=raw_data).process_hex_raw_data(mode='s16'), [4660, 22136])
    # s32: f4f3f2f1 > f1f2f3f4 > [f1f2f3f4], signed(32-bit) --> [-235736076]
    #      78563412 > 12345678 > [12345678], signed(32-bit) --> [305419896]
    tests.assertEqual(Event("f4f3f2f1", current_event_type=raw_data).process_hex_raw_data(mode='s32'), [-235736076])
    tests.assertEqual(Event("78563412", current_event_type=raw_data).process_hex_raw_data(mode='s32'), [305419896])
    
    # getting data from events
    tests.assertEqual(Event("01000000", current_event_type=event_number_evn).data, 1)
    tests.assertEqual(Event("ff0f0000", current_event_type=event_number_evn).data, 4095)
    tests.assertEqual(Event("ffffffff", current_event_type=event_number_evn).data, 4294967295)
    print("All tests passed.")
    
    hex_check.main(plot=True)