#!/usr/bin python3
import functools
import os
import struct
import re
import sys
from dataclasses import field, dataclass
from datetime import datetime

from typing import NamedTuple, Optional, Union, Any
from hex_check_config import config

PeakHeader = NamedTuple("PeakHeader", [("position", int), ("time_ns", int)])
PeakHeight = NamedTuple("PeakHeight", [("height", int)])

DoubleADCTupleWithCount = NamedTuple("DoubleADCTupleWithCount", 
                                     [("adc1", int), ("adc2", int), ("count", int)])  # s12
DoubleADCTuple = NamedTuple("DoubleADCTuple", [("adc1", int), ("adc2", int)])  # s16 mode
SingleADC = NamedTuple("SingleADC", [("adc", int)])  # s32 mode
ADCTypes = Union[DoubleADCTupleWithCount, DoubleADCTuple, SingleADC]

if __name__ == "__main__":
    raise ImportError("This module is not meant to be run directly. Please use it as a library.")


def endian_conversion(hex_str: str) -> int:
    """Convert f4f3f2f1 to f1f2f3f4"""
    if len(hex_str) % 2 != 0:
        raise ValueError("Hex string length must be even.")
    
    # Step 1: Convert the hex string to bytes
    # Each pair of characters in the hex string represents a byte.
    # Use `bytes.fromhex` to parse the string.
    byte_data = bytes.fromhex(hex_str)
    
    # Step 2: Reconstruct the 32-bit word in little-endian order
    # Use the unpack function from the struct module to interpret the bytes in little-endian format.
    try:
        # '<' = little-endian, 'f4f3f2f1' would first get converted to 'f1f2f3f4' before being converted to int
        # 'I' = unsigned integer (4-byte, 8 hex chars), 'i' = signed int (4-byte, 8 hex chars)
        # 'H' = unsigned short (2-byte, 4 hex chars), 'h' = signed short (2-byte, 4 hex chars)
        # https://docs.python.org/3/library/struct.html#format-characters
        word: int = struct.unpack('<I', byte_data)[0]  # unpack() returns tuple, here with one element only
        # word is the signed interpretation of the full 32-bit word, f1f2f3f4 --> -235736076, NOT simply -0xf1f2f3f4
        # given f1f2f3f4, the least significant byte is f4, the most significant byte is f1
        # it's natural that the ADC will fill data in starting at the least significant byte
        # so f3f4 **is the older data** and f1f2 **is the newer data**
    except struct.error:
        print(f"Error: {hex_str} could not be converted to a 32-bit word.")
        raise
    
    return word



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
        if config.show_all and config.show_nothing:
            raise ValueError("Both show_all and show_nothing are True. Please set one to False.")
        if config.show_all:
            return True
        if config.show_nothing:
            return False
        for show_this_event_name in config.only_show:
            # allow partial matches, for example, "peak_height_data" will match both data events
            if show_this_event_name in self.name:
                return True
        return self._show
    
    @functools.cached_property
    def next_event(self) -> list["EventType"]:
        """Replace list of ['begin_event'] with list of actual EventType objects [begin_event]"""
        ret = [event_type for name, event_type in name_to_event.items() if name in self._next_event]
        assert len(ret) == len(self._next_event), f"Expected {len(self._next_event)} events, got {len(ret)}."
        for event in ret:
            # move all events with free regex patterns to end of list to be checked last (for cases like raw_data)
            # this is important because otherwise '........' will match ANY event
            if event.regex_pattern == '........':
                ret.append(event)  # add to end of list
                ret.remove(event)  # remove first instance from list
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
        # this should only happen if this module is imported from the unittest file rather than from hex_check.py
        # if 'hex_check' not in hex_check_state:
        #     from hex_check import HexCheck
        #     hex_check = HexCheck()
        #     hex_check_state['hex_check'] = hex_check
        
        self.hex_check = hex_check_state['hex_check']
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
        if self.type in [channel_header, channel_number]:
            return self.data + 1  # change range of channels from 0~3 to 1~4
        else:
            return getattr(self.previous_event, "channel_number", 0)
    
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
    def raw_data(self) -> ADCTypes:
        """Returns the raw data as a list of integers, processed by process_hex_raw_data"""
        if self.type == raw_data:
            # below gives (a, b, remaining_count), with a and b being raw data
            # the two data points:
            process_hex_raw_data_result = self.process_hex_raw_data(mode=config.integer_mode)
            # the remaining count of ADC points:
            self.hex_check.raw_data_remaining = process_hex_raw_data_result[2]
            
            return DoubleADCTuple(*process_hex_raw_data_result[:2])
        else:
            raise ValueError("This event is not a raw_data event.")
        
    @functools.cached_property
    def peak_height_data(self) -> PeakHeader | PeakHeight:
        """Returns the peak height data as some tuple, processed by process_peak_height_data"""
        if self.type == peak_height_data_1:
            return self.process_peak_height_header()
        elif self.type == peak_height_data_2:
            return self.process_peak_height()
        else:
            raise ValueError("This event is not a peak_height_data event.")
    
    @functools.cached_property
    def peak_area_data(self):
        """Returns the peak area data as an integer, processed by process_peak_area"""
        if self.type.name.startswith("peak_area_data_"):
            res = self.process_peak_area()
            # print(f"[{self.type.name}] {self.hex} -> {res}")
            return res
        else:
            raise ValueError("This event is not a peak_area_data event.")
    
    @functools.cached_property
    def peak_height_position(self) -> int:
        """Returns the peak height position as an integer (0-3)"""
        if self.type == peak_height_data_1:
            assert isinstance(self.peak_height_data, PeakHeader), f"Got {type(self.peak_height_data)}"
            return self.peak_height_data[0]
        else:
            raise ValueError("This event is not a peak_height_data event.")
        
    @functools.cached_property
    def peak_height_time(self) -> int:
        """Returns the peak height time as an integer (in ns)"""
        if self.type == peak_height_data_1:
            assert isinstance(self.peak_height_data, PeakHeader), f"Got {type(self.peak_height_data)}"
            return self.peak_height_data[1]  # time is in ns
        else:
            raise ValueError("This event is not a peak_height_data event.")
        
    @functools.cached_property
    def peak_height(self) -> int:
        """Returns the peak height as an integer (in ADC value)"""
        if self.type == peak_height_data_2:
            assert isinstance(self.peak_height_data, PeakHeight), f"Got {type(self.peak_height_data)}"
            return self.peak_height_data[0]
        else:
            raise ValueError("This event is not a peak_height_data event.")
    
    def get_event_channel_number(self,
                                 number_type: str,  # either event_number or sub_event_number
                                 event_type: EventType
                                 ) -> int:
        """This function can be used for event number or sub_event number."""
        # if the current event is one of the special ones, update channel number
        if self.type == event_type:
            return self.data
        # otherwise, return the previous event's channel number and carry it over
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
                
                # this should run the first time it sees an end_of_channel event to measure the length of one ADC event
                if current_event_type == 'end_of_channel':
                    # if not recorded before:
                    if not self.hex_check.adc_length:
                        self.hex_check.adc_length = len(self.hex_check.raw_data_buffer)
                        print(f"ADC length: {self.hex_check.adc_length}")
                    else:
                        if len(self.hex_check.raw_data_buffer) % self.hex_check.adc_length == 0:
                            pass  # this really is an "end_of_channel" event
                        else:
                            continue  # you got an event in raw data that just happened to look like end_of_channel
                return matched, current_event_type

        for potential_event_type in next_event_candidates:
            if potential_event_type.name.startswith("peak_area_data_"):
                # peak area data, but there's some error in the format so it wasn't detected.
                # return just the necessary elements of the data point, but with the other things "zero"
                matched = True
                current_event_type = potential_event_type
                print(f"Event {self} ({self.internal_event_number}-{self.sub_event_number}-{self.channel_number}): "
                      f"forcing through invalid {potential_event_type} with hex {self.hex}.")
                self.hex = potential_event_type.regex_pattern.replace('.', '0')  # replace all dots with zeros
                return matched, current_event_type
        
        raise Exception(f"Failed to detect the kind of event for {self.hex} "
                        f"with previous event {self.previous_event.type} "
                        f"and expected next events {next_event_candidates}.")
    
    def process_hex_raw_data(self, mode, hex_in: str = "") -> ADCTypes:
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
        allowed_types = ['raw_data', 'peak_height_data_1', 'peak_height_data_2']
        assert self.type in allowed_types, f"Expected one of {allowed_types}, got {self.type}"
        if not hex_in:
            hex_in = self.hex
        
        # Input: Hexadecimal string
        # Step 1: Convert hex string to bytes
        # Step 2: Reconstruct the 32-bit word in little-endian order
        word: int = endian_conversion(hex_in)
        
        # MODES:
        # s12: 12-bit signed integer (normal ADC operation, split 32-bits into two 16-bit values, take top 12-bits)
        # s16: 16-bit signed integer (split 32-bits into two 16-bit values, take all 16-bits)
        # s32: 32-bit signed integer (take all 32-bits as one data point)
        if mode not in ["s12", "s16", "s32"]:
            raise ValueError("Invalid mode. Please choose 's12', 's16', or 's32'.")
        
        if mode == 's12':
            # start with word =0xf1f2f3f4, LSB is f4, MSB is f1
            # LSB is the oldest, MSB is the newest
            # the "2" byte and "4" byte contain the remaining count of ADC points to be sent
            
            # Step 3: Extract the newer ADC value (upper 16 bits of `word`, f1f2)
            # word >> 16: 0xf1f2 = 61,938
            # adcvalue1: 0xf1f0 --> 0x0f1f = -225
            newer_adc_value: int = (((word >> 16) & 0xFFF0) >> 4)  # Shift right 16 bits, mask, then shift right 4 again
            upper_count = word >> 16 & 0xF  # Get upper 4 bits
            newer_adc_value = signed(newer_adc_value, 12)
            
            # Step 4: Extract the older ADC value (lower 16 bits of `word`)
            # word & 0xFFFF: 0xf3f4 = 62,452
            # adcvalue2: 0xf3f0 --> 0x0f3f = -193
            older_adc_value: int = ((word & 0xFFF0) >> 4)  # Get upper 12 bits, shift right by 4 to be lowest 12 bits
            lower_count = word & 0xF  # Get lower 4 bits
            older_adc_value = signed(older_adc_value, 12)
            
            # Step 5: Extract the final extra bits, the "2" and "4" in "f1f2f3f4"
            count = upper_count << 4 | lower_count
            
            return DoubleADCTupleWithCount(older_adc_value, newer_adc_value, count)
        elif mode == 's16':
            # Step 3: Extract the first ADC value (upper 16 bits of `word`)
            newer_adc_value: int = word >> 16  # Shift right 16 bits
            newer_adc_value = signed(newer_adc_value, 16)
            
            # Step 4: Extract the second ADC value (lower 16 bits of `word`)
            older_adc_value: int = word & 0xFFFF  # Get upper 12 bits, shift right by 4 to be lowest 12 bits
            older_adc_value = signed(older_adc_value, 16)
            
            return DoubleADCTuple(older_adc_value, newer_adc_value)
        else:  # mode == 's32'
            # this is already ordered in the right way, with the MSB being the newest data and the LSB being oldest
            # this was proven by doing a 32 bit ramp test and seeing the data increase in the expected way
            return SingleADC(signed(word, 32))
        
    def process_peak_height_header(self) -> PeakHeader:
        """
        Parse and return peak height header events.

        Each peak is encoded as two consecutive 32-bit words (8 bytes total). The header structure is:

        -------------------------------
        Word 1 (32 bits) - Peak Header (examples before endian order swap: 10080040, 27000050, 40000060, 9f220070)
        -------------------------------
        Bits 31–30: Constant binary "01" (identifies this as peak height data)
        Bits 29–28: Peak position code `xx` (binary):
                    - 00: latch_datain_org0 (first sample)
                    - 01: latch_datain_org1 (second sample)
                    - 10: latch_datain_org2 (third sample)
                    - 11: latch_datain_org3 (fourth sample)
        Bits 27–0 : 28-bit counter value (time from trigger, each clock cycle is 4ns)
        Time = (# of clock cycles) * 4ns

        Notes:
            - Data is received little-endian (f4f3f2f1) and must be reversed
            - MSB nibble is always one of: 0x7, 0x6, 0x5, 0x4
        """
        assert self.type == peak_height_data_1, f"Expected peak_height_data_1, got {self.type}"
        word = endian_conversion(self.hex)
        
        # first word
        # 0x70, 0x60, 0x50, or 0x40
        first_word = (word & 0xF0000000) >> 28
        if first_word not in [0x7, 0x6, 0x5, 0x4]:
            raise ValueError(f"Invalid first word: {hex(first_word)} in {self.hex}. "
                             f"Expected one of [0x70, 0x60, 0x50, 0x40].")
        peak_location = first_word & 0b0011  # get the last two bits of the first word
        counter = (word & 0x0FFFFFFF)  # 28-bit counter value
        time = counter * 4  # time in ns
        self.hex_check.second_peak_height = True  # prepare for next event
        return PeakHeader(peak_location, time)
    
    def process_peak_height(self):
        """
        Parse and return peak height events.

        Each peak is encoded as two consecutive 32-bit words (8 bytes total). The height structure is:

        -------------------------------
        Word 2 (32 bits) - Peak Value (examples before endian order swap: 06ca0000, 14ca0000, 4dca0000, 4bca0000)
        -------------------------------
        Bits 31–16: Constant 0x0000 (reserved)
        Bits 15–0 : 16-bit signed peak height (ADC value at peak)

        Notes:
            - Final byte is always 0x00 (lower 16 bits = 0x0000)
        """
        assert self.type == peak_height_data_2, f"Expected peak_height_data_2, got {self.type}"
        word = endian_conversion(self.hex)
        
        # top 16 bits are always 0x0000
        if (word & 0xFFFF0000) != 0:
            raise ValueError(f"Invalid second word: {hex(word)}. Expected top 16 bits to be 0x0000.")
        # bottom 16 bits are the signed peak height
        peak_height = signed(word & 0x0000FFFF, 16)
        
        # convert to hex string and pad with zeros
        hex_str = peak_height.to_bytes(2, byteorder='little', signed=True).hex().zfill(4)
        proper_height = self.process_hex_raw_data(mode='s12', hex_in=hex_str + '0000')[
            0]  # convert to signed 12-bit
        self.hex_check.second_peak_height = False
        return PeakHeight(proper_height)
    
    def process_peak_area(self):
        """
        Peak area data structure with one FMC228 card.
        +------------------+----------+--------------------------------------------------------------+
        | Bits field       | Bits     | Meaning                                                      |
        +------------------+----------+--------------------------------------------------------------+
        | 16-bit x"1111"   | 16 bits  | 16-bit word shows the maximum peak in the pulse.             |
        |           32 bits           | 32-bit word shows the area value from the beginning of the   |
        |                  |          | pulse to the maximum peak in the pulse.                      |
        |           32 bits           | 32-bit word shows the total area value of the pulse.         |
        | 4-bit x"0"       | 28 bits  | 28-bit word shows the time from the trigger to the maximum   |
        |                  |          | peak in the pulse.                                           |
        | 4-bit x"0"       | 28 bits  | 28-bit word shows the time from the trigger to the beginning |
        |                  |          | of the pulse.                                                |
        | 4-bit x"0"       | 28 bits  | 28-bit word shows the time from the trigger to the end of    |
        |                  |          | the pulse.                                                   |
        +------------------+----------+--------------------------------------------------------------+
        """
        word = endian_conversion(self.hex)
        if self.type.name == "peak_area_data_1":
            # examples before conversions: c7e51111, bee51111, cbe51111
            peak_area_1 = word & 0x0000FFFF
            return peak_area_1
        elif self.type.name == "peak_area_data_2":
            # examples before conversions: 2c8bf9ff, c089f9ff, b48ef9ff
            return word
        elif self.type.name == "peak_area_data_3":
            # examples before conversions: b089fdff, b821fdff
            return word
        elif self.type.name == "peak_area_data_4":
            # examples before conversions: 45170000, 78170000, db170000
            time_to_peak = (word & 0x0FFFFFFF) * 4  # multiply to convert clock counter to ns
            return time_to_peak
        elif self.type.name == "peak_area_data_5":
            # examples before conversions: 89180000, b5110000, d2110000
            time_to_start = (word & 0x0FFFFFFF) * 4
            return time_to_start
        elif self.type.name == "peak_area_data_6":
            # examples before conversions: d4c0a000, e2c0a000, f0c0a000
            time_to_end = (word & 0x0FFFFFFF) * 4
            return time_to_end
        else:
            raise ValueError(f"Invalid peak area data type: {self.type}")
    
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
            ex = f"{self.hex_check.raw_data_remaining} - {self.hex_check.raw_data_remaining:08b}"
            ret += f" = {self.raw_data} (extra bytes: {ex})>"
        elif self.type == peak_height_data_1:
            # data event 1 contains [peak_number (0-3), time (ns)]
            ret += f" = Peak #{self.peak_height_position} ({self.peak_height_time} ns)>"
        elif self.type == peak_height_data_2:
            # data event 2 contains [peak_height (ADC value)]
            ret += f" = {self.peak_height} ({convert_voltage(self.peak_height, 3)} V)>"
        else:
            if self.data is not None:
                ret += f" = {self.data}>"
            else:
                ret += ">"
        return ret


def chunk(s: str, size: int = 8):
    """Yield 8-char packets from s."""
    for i in range(0, len(s), size):
        yield s[i:i + size]


def parse_raw_data_channel(block: str) -> list[int]:
    """Strip headers/trailer, convert packets to Events, flatten 2-word raw_data."""
    # inside each raw_data_channel, it starts with seven packets of headers
    # then raw data for unspecified length starting at the eight packet (i[8*7:])
    # then one packet (fbfbfbfb) of end_of_channel (skipped by i[:-8*1])
    # remove 7 header packets at start and 1 trailer packet at end
    payload = block[8 * 7: -8 * 1]
    assert len(payload) % 8 == 0, f"Payload length {len(payload)} is not a multiple of 8."
    out = []
    for h in chunk(payload, size=8):
        evt = Event(h[:8], None, raw_data)
        # evt.raw_data is a 2-tuple/list -> extend both words
        # also has a third element, the *remaining count* of ADC points to be sent later
        out.append(evt.raw_data[0])
        out.append(evt.raw_data[1])
    return out


def parse_peak_height_channel(block: str) -> list["Peak"]:
    """Strip headers/trailer, convert packets to Events, flatten 2-word peak_height_data."""
    # aaaa is second half of overall peak_finding_header
    # cccc_cccc is peak height header
    # cece_cece = peak height end
    # dddd = first half of peak area header
    payload: str = re.findall(r'aaaacccccccc(.*?)cecececedddd', block)[0]
    assert len(payload) % 16 == 0, f"Payload length {len(payload)} is not a multiple of 16."
    out = []
    
    # make placeholder to take advantage of Event's regex matching on peak format
    # Event checks format if the "previous" arg is filled and "current" is not
    evt2 = Event("", None, peak_height_data_2)  # placeholder
    chunks = list(chunk(payload, size=16))
    # print(chunks)
    for h in chunks:
        evt1 = Event(h[:8], evt2)
        evt2 = Event(h[8:], evt1)
        # evt.raw_data is a 2-tuple/list -> extend both words
        peak = Peak.from_event(evt1)
        peak.height = evt2.peak_height
        out.append(peak)
    return out


def parse_peak_area_channel(block: str) -> list["PeakArea"]:
    """Strip headers/trailer, convert packets to Events, flatten 5-word peak_area_data."""
    # cece = peak height end
    # dddd_dddd = peak area header
    # dede_dede = peak area end
    # bbbb = first half of end peak data
    
    out = []
    payload: str = re.findall(r'cecedddddddd(.*?)dedededebbbb', block)[0]
    try:
        assert len(payload) % 48 == 0, f"Payload length {len(payload)} ({block} -> {payload}) is not a multiple of 48."
    except AssertionError as e:
        print(e)
        return out
    
    # make placeholder to take advantage of Event's regex matching on peak format
    data6 = Event("", None, peak_area_data_6)  # placeholder
    
    chunks = list(chunk(payload, size=48))
    # print(chunks)
    for h in chunks:
        data1 = Event(h[0:8], data6, peak_area_data_1)
        data2 = Event(h[8:16], data1, peak_area_data_2)
        data3 = Event(h[16:24], data2, peak_area_data_3)
        data4 = Event(h[24:32], data3, peak_area_data_4)
        data5 = Event(h[32:40], data4, peak_area_data_5)
        data6 = Event(h[40:48], data5, peak_area_data_6)
        peak_area = PeakArea.from_events(data1, data2, data3, data4, data5, data6)
        out.append(peak_area)
        
    return out


class HasEventNumber:
    parent: Any
    
    @property
    def event_number(self) -> int:
        return self.parent.event_number
    
    @property
    def internal_event_number(self) -> int:
        return self.parent.internal_event_number


class HasSubEventNumber(HasEventNumber):
    @property
    def sub_event_number(self) -> int:
        return self.parent.sub_event_number


class HasChannelNumber(HasSubEventNumber):
    @property
    def channel_number(self) -> int:
        return self.parent.channel_number


class NewEvent:
    """Recreation of the Event class with a new method of storing previous event to save memory.
    
    This "Event" will be one Event in a data file, starting with 0xffffffff and ending with either
    0x00fcfcfc (end_sub_event) or 0xfcfcfcfc (end_event)"""
    
    def __init__(self, internal_event_number, data_str):
        self.event_number_obj = Event(data_str[8*5:8*6], None, event_number_evn)
        self.event_number = self.event_number_obj.event_number
        self.internal_event_number: int = internal_event_number
        
        # get sub events
        r = (r'00ffffff'
             r'f4f3f2f1'
             r'.*?'
             r'edededed'
             r'00fcfcfc')
        sub_events = re.findall(r, data_str)
        print(f"Event {self.event_number}-{self.internal_event_number} has {len(sub_events)} "
              f"sub-events.")
        self.sub_events = [NewSubEvent(self, sub_event) for sub_event in sub_events]

    def __repr__(self):
        return f"<NewEvent #{self.event_number}-{self.internal_event_number}, {len(self.sub_events)} sub-events>"


class NewSubEvent(HasEventNumber):
    def __init__(self, event: NewEvent, data_str: str):
        self.parent: NewEvent = event
        # self.sub_event_number: int = None
        self.sub_event_number_obj = Event(data_str[8*3:8*4], None, sub_event_number_evn)
        self.sub_event_number = self.sub_event_number_obj.sub_event_number
        
        # RAW DATA
        raw_data_channels = re.findall(r'fafa....ffff.*?fbfbfbfb(?=fafa|fefe)', data_str)  # four items
        self.raw_data_list = [parse_raw_data_channel(b) for b in raw_data_channels]
        raw_data_lengths = [len(raw_data) for raw_data in self.raw_data_list]
        # print()
        # print(self.raw_data_list)
        # print(f"[{self.event_number}-{self.internal_event_number}-{self.sub_event_number}] "
        #       f"[RAW_DATA] {len(raw_data_channels)} channels, lengths {raw_data_lengths}.")
        
        # Channel number      x x x x e e e e
        # Peak finding header a a a a a a a a
        # Peak height header  c c c c c c c c
        # Peak height data    x x x x x x x x (4)
        # Peak height end     c e c e c e c e
        # Peak area header    d d d d d d d d
        # Peak area data      x x x x x x x x (5)
        # Peak area end       d e d e d e d e
        # End Peak data       b b b b b b b b
        # End Peak channel    e c e c e c e c
        # NOTE: The values in data_str are swapped in order, so f1f2f3f4-->f4f3f2f1 (little-endian)
        # All this above data is contained in each list element of peak_channels
        
        # xxxxeeee comes through as eeeexxxx, with xxxx being the channel number
        # aaaa = first half of overall peak_finding_header
        # bbbb_bbbb = end peak data
        # ecec_ecec = end peak channel
        peak_channels = re.findall(r'eeee....aaaa.*?bbbbbbbbecececec', data_str)  # list of four items, for each of the channels
        # print('\n'.join(peak_channels))
        
        # PEAK HEIGHT
        # peak_height starts with aaaa cccc_cccc and ends with cece_cece dddd
        # above regex will get just the first half of "peak height header: aaaa_aaaa"
        # second half is matched in parse_peak_height_channel()
        self.peak_height_list = [parse_peak_height_channel(b) for b in peak_channels]  # four lists of Peak objects
        height_counts = [len(peaks) for peaks in self.peak_height_list]
        print(f"[{self.event_number}-{self.internal_event_number}-{self.sub_event_number}] "
              f"[PEAK_HEIGHT] {len(peak_channels)} channels, lengths {height_counts}.")
        # print(self.peak_height_list)
        
        # PEAK AREA
        self.peak_area_list = [parse_peak_area_channel(b) for b in peak_channels]  # four lists of PeakArea objects
        area_counts = [len(areas) for areas in self.peak_area_list]
        print(f"[{self.event_number}-{self.internal_event_number}-{self.sub_event_number}] "
                f"[PEAK_AREA] {len(peak_channels)} channels, lengths {area_counts}.")
        # print(self.peak_area_list)
        
        self.channels: list[NewChannelData] = []
        for i in range(4):
            channel_num = 4 - i  # starts with channel 4 and counts down to channel 1
            channel = NewChannelData(channel_num, self.raw_data_list[i], self.peak_height_list[i], self)
            self.channels.append(channel)
        self.channels = self.channels[::-1]  # reverse order so channel 1 is first

    def __repr__(self):
        return f"<NewSubEvent #{self.event_number}-{self.internal_event_number}-{self.sub_event_number}, " \
               f"{len(self.channels)} channels>"

        
class NewChannelData(HasSubEventNumber):
    def __init__(self, channel_num: int,
                 raw_data_list: list[int],
                 peak_height_list: list["Peak"],
                 sub_event: NewSubEvent):
        self.parent = sub_event
        self.channel_number = channel_num
        self.raw_data = raw_data_list  # list of ADC values
        self.peak_heights = peak_height_list  # list of Peak objects
        # self.peak_areas: list[NewPeakArea] = None
        

# class NewRawData:
#     def __init__(self, channel):
#         self.channel: NewChannelData = channel
#         self.value: int = None
#
#
# class NewPeakHeight:
#     def __init__(self, channel):
#         self.channel: NewChannelData = channel
#         self.position: int = None  # 0-3
#         self.time_ns: int = None
#         self.height: int = None  # ADC value
#
#
@dataclass()
class PeakArea:
    channel: NewChannelData = None
    max_peak: int = None
    area_begin_to_max: int = None
    area_total: int = None
    time_trig_to_max: int = None
    time_trig_to_begin: int = None
    time_trig_to_end: int = None
    
    @property
    def peak_width(self) -> Optional[int]:
        """Calculate peak width as time from begin to end, in ns."""
        if self.time_trig_to_end is not None and self.time_trig_to_begin is not None:
            return self.time_trig_to_end - self.time_trig_to_begin
        else:
            return None
        
    @property
    def peak_area(self) -> Optional[int]:
        """Calculate peak area as total area - area from begin to max."""
        return self.area_total
        
    @classmethod
    def from_events(cls,
                    data1: Event,
                    data2: Event,
                    data3: Event,
                    data4: Event,
                    data5: Event,
                    data6: Event) -> "PeakArea":
        peak_area = cls()
        peak_area.max_peak = data1.peak_area_data
        peak_area.area_begin_to_max = data2.peak_area_data
        peak_area.area_total = data3.peak_area_data
        peak_area.time_trig_to_max = data4.peak_area_data
        peak_area.time_trig_to_begin = data5.peak_area_data
        peak_area.time_trig_to_end = data6.peak_area_data
        return peak_area
    
    def __repr__(self):
        return (f"<PeakArea max_peak={self.max_peak}, "
                f"area_begin_to_max={self.area_begin_to_max}, "
                f"area_total={self.area_total}, "
                f"time_trig_to_max={self.time_trig_to_max}, "
                f"time_trig_to_begin={self.time_trig_to_begin}, "
                f"time_trig_to_end={self.time_trig_to_end}>")

#
# class SingleHex:
#     def __init__(self, hex_str: str):
#         self.hex: str = hex_str
#         self.event_type: EventType = None
#         self.data: int = None
#         self.next_hex: "SingleHex" = None  # link to next SingleHex object
#         self.prev_hex: "SingleHex" = None  # link to previous SingleHex object



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


@dataclass
class Peak:
    position: int
    time_ns: int
    height: Optional[int] = field(default=None)  # initially unset
    event_number: int = 0
    internal_event_number: int = 0
    sub_event_number: int = 0
    channel_number: int = 0

    def is_complete(self) -> bool:
        return self.height is not None
    
    @classmethod
    def from_event(cls, event: Event) -> "Peak":
        """Create a Peak object from an Event object. If a _data_1 event, fill out event numbers as well."""
        if event.type == peak_height_data_1:
            return cls(event.peak_height_position, event.peak_height_time,
                       event_number=event.event_number,
                       internal_event_number=event.internal_event_number,
                       sub_event_number=event.sub_event_number,
                       channel_number=event.channel_number)
        else:
            raise ValueError("Event type is not a peak height header data event.")

    def __repr__(self):
        return (f"<Peak #{self.event_number}-{self.internal_event_number}-{self.sub_event_number}-"
                f"{self.channel_number} pos={self.position}, time={self.time_ns} ns, "
                f"height={self.height} ({convert_voltage(self.height, 3) if self.height is not None else 'N/A'} V)>")


def convert_voltage(v, round_n=None):
    # ADC peak-to-peak is 1.34V (+/- 0.67V), so 0.67V = 2047, -0.67V = -2048
    # Voltage at FMC228 transformer is 2.52V, ratio is 2.52V / 1.34V = 1.88V
    # Therefore, values at FMC228 pins are 1.88 * ADC values
    # 2047 = 0.67 * 1.88 = 1.26V, -2048 = -0.67 * 1.88 = -1.26V
    # Max voltage is +/- 1.26V
    if config.integer_mode == 's12':
        v_out = v * 1.26 / 2047
    elif config.integer_mode == 's16':
        v_out = v * 1.26 / (2047 / 2 ** 11 * 2 ** 15)
    elif config.integer_mode == 's32':
        v_out = v * 1.26 / (2047 / 2 ** 11 * 2 ** 31)
    else:
        raise ValueError("Invalid mode. Please choose 's12', 's16', or 's32'.")
    
    if round_n:
        return round(v_out, round_n)
    else:
        return v_out


def convert_voltage_reverse(v):
    if config.integer_mode == 's12':
        return v * 2047 / 1.26
    elif config.integer_mode == 's16':
        return v * (2047 / 2 ** 11 * 2 ** 15) / 1.26
    elif config.integer_mode == 's32':
        return v * (2047 / 2 ** 11 * 2 ** 31) / 1.26


def signed(value: int, width: int) -> int:
    """Converts an unsigned value to a signed value."""
    if value >= 2 ** width:
        raise ValueError(f"Value must be at most {width}-bit{f' ({width // 4} bytes)' if width % 4 == 0 else ''}. "
                         f"Your value {value} / {hex(value)} had {len(bin(value)) - 2} bits.")
    width = width - 1  # example: for four bit number, shift "1" over 4-1=3 to get 1000 (the desired sign bit)
    return -(value & (1 << width)) | (value & ((1 << width) - 1))


def find_data_file(desired_file_path, to_use_index_increment: int = 0) -> str:
    # get directory of the script
    
    # argv gets the command line arguments
    # ex: `python3 hex_check.py path_to_data_file.dat`
    # argv[0] = hex_check.py, argv[1] = path_to_data_file.dat
    # args = [sys.argv[0], file_name]

    # jupyter notebooks add three args
    if 'ipykernel' in sys.argv[0]:
        args = sys.argv[3:]
    else:
        args = sys.argv
    if len(args) > 1:
        desired_file_path = args[1]
    
    if desired_file_path is None:
        desired_file_path = ""
    if desired_file_path.startswith("./"):
        desired_file_path = desired_file_path[2:]
    
    # find the file ending in .dat in the current directory
    dir_name: str = os.path.dirname(os.path.realpath(__file__)).replace("\\", "/")  # Directory of the script
    files = os.listdir(dir_name + "/data")
    dat_files = sorted([file for file in files if file.endswith(".dat") and desired_file_path in file],
                       key=lambda x: os.path.getctime(f"./data/{x}"))
    if len(dat_files) == 0:
        raise ValueError("No .dat files found in the current directory matching search")
    elif len(dat_files) > 1:
        input_file_name = dat_files[-config.to_use_file_index - to_use_index_increment]
        # if not input_file_name.startswith("data_202507"):
        #     raise ValueError("Outside range of data_202507 files. Temporarily ignoring all other files.")
        print(f"ℹ️ℹ️ Info: Multiple .dat files found in the current directory. "
              f"Picking this one ({input_file_name}) ℹ️ℹ️")
    else:
        input_file_name = dat_files[0]  # only one result
    return input_file_name


def read_data_file(dir_name, file_name) -> tuple[list[str], datetime, list[str]]:
    # open binary file, get binary data and file creation date
    headers = []
    assert os.path.exists(os.path.join(dir_name, "data", file_name)), "File does not exist."
    with open(os.path.join(dir_name, "data", file_name), "rb") as file:
        for line in file:
            if line.startswith(b"#"):
                headers.append(line.decode().strip())
            else:
                break
        binary_data = line + file.read()  # a "bytes" object
        file_creation_date = datetime.fromtimestamp(os.path.getctime(file.name))
    
    # convert to hex, should be a single string containing the entire file starting with "ffffffffffffff00" etc
    hex_data: str = binary_data.hex()
    
    # assert len(hex_data) % 8 == 0, f"Hex data length is not divisible by 8 ({len(hex_data)})"
    if len(hex_data) % 8 != 0:
        # find last instance of 'ffffffff 00ffffff f4f3f2f1' and truncate everything after that
        pattern = r'(ffffffff00fffffff4f3f2f1)'
        matches = list(re.finditer(pattern, hex_data))
        if matches:
            last_match = matches[-1]
            cut_len = len(hex_data[last_match.end():])
            full_len = len(hex_data)
            hex_data = hex_data[:last_match.end()]
            print(f"⚠️⚠️ Truncated hex data to last valid event ending at index {last_match.end()}. "
                  f"Cut last {cut_len / full_len * 100:.2f}% of data. ⚠️⚠️")
    
    hex_data_list = [hex_data[i:i + 8] for i in range(0, len(hex_data), 8)]
    
    return hex_data_list, file_creation_date, headers


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
bco_high = EventType('........', ['data_length', 'end_of_channel', 'raw_data'])
data_length = EventType('....aaff', ['end_of_channel', 'raw_data'])
raw_data = EventType('........', ['end_of_channel', 'raw_data'])
end_of_channel = EventType('fbfbfbfb', ['end_raw_data', 'channel_header'])
end_raw_data = EventType('fefefefe', ['begin_peak_data'])
begin_peak_data = EventType('efefefef', ['channel_number'])
channel_number = EventType('eeee..ee', ['peak_finding_header'])
peak_finding_header = EventType('aaaaaaaa', ['peak_height_header'])
peak_height_header = EventType('cccccccc', ['peak_height_end', 'peak_height_data_1'])
peak_height_data_1 = EventType('......[4567].', ['peak_height_data_2'])
peak_height_data_2 = EventType('....0000', ['peak_height_end', 'peak_height_data_1'])
peak_height_end = EventType('cececece', ['peak_area_header'])
peak_area_header = EventType('dddddddd', ['peak_area_end', 'peak_area_data_1'])
peak_area_data_1 = EventType('....1111', ['peak_area_data_2'])
peak_area_data_2 = EventType('........', ['peak_area_data_3'])
peak_area_data_3 = EventType('........', ['peak_area_data_4'])
peak_area_data_4 = EventType('......0.', ['peak_area_data_5'])
peak_area_data_5 = EventType('......0.', ['peak_area_data_6'])
peak_area_data_6 = EventType('......0.', ['peak_area_end', 'peak_area_data_1'])
peak_area_end = EventType('dededede', ['end_peak_data'])
end_peak_data = EventType('bbbbbbbb', ['end_peak_channel'])
end_peak_channel = EventType('ecececec', ['end_peak_stream_data', 'channel_number'])
end_peak_stream_data = EventType('edededed', ['end_sub_event'])
end_sub_event = EventType('00fcfcfc', ['end_event', 'begin_sub_event', 'begin_event'])
end_event = EventType('fcfcfcfc', ['begin_event'])
name_to_event = {name: event for name, event in globals().items() if isinstance(event, EventType)}


# def set_config():
#     """Set the configuration for the hex_check module."""
#
#     return Config()

hex_check_state = {}  # hex_check.py will put hex_check in here as hex_check_state["hex_check"]
# it will eventually be used in the Event class

# config = set_config()