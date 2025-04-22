#!/usr/bin python3
import functools
import struct
import re

from typing import Optional, Union


if __name__ == "__main__":
    raise ImportError("This module is not meant to be run directly. Please use it as a library.")


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
        if self.name in config.only_show:
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
            process_hex_raw_data_result = self.process_hex_raw_data(mode=self.hex_check.mode)
            self.hex_check.raw_data_remaining = process_hex_raw_data_result[2]
            return process_hex_raw_data_result[:2]
        else:
            raise ValueError("This event is not a raw_data event.")
        
    @functools.cached_property
    def peak_height(self) -> list[int]:
        """Returns the peak height data as a list of integers, processed by process_peak_height_data"""
        if self.type == peak_height_data:
            return self.process_peak_height_data()
        else:
            raise ValueError("This event is not a peak_height_data event.")
    
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
        
        raise Exception(f"Failed to detect the kind of event for {self.hex} with previous event {self.previous_event} "
                        f"and expected next events {next_event_candidates}.")
    
    def process_hex_raw_data(self, mode, hex_in: str = "") -> list[int]:
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
        
        if not hex_in:
            hex_in = self.hex
        
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
        byte_data = bytes.fromhex(hex_in)
        
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
            print(f"Error: {self.hex} could not be converted to a 32-bit word.")
            raise
        
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
            
            count = upper_count << 4 | lower_count
            return [older_adc_value, newer_adc_value, count]
        elif mode == 's16':
            # Step 3: Extract the first ADC value (upper 16 bits of `word`)
            newer_adc_value: int = word >> 16  # Shift right 16 bits
            newer_adc_value = signed(newer_adc_value, 16)
            
            # Step 4: Extract the second ADC value (lower 16 bits of `word`)
            older_adc_value: int = word & 0xFFFF  # Get upper 12 bits, shift right by 4 to be lowest 12 bits
            older_adc_value = signed(older_adc_value, 16)
            
            return [older_adc_value, newer_adc_value]
        else:  # mode == 's32'
            # this is already ordered in the right way, with the MSB being the newest data and the LSB being oldest
            # this was proven by doing a 32 bit ramp test and seeing the data increase in the expected way
            return [signed(word, 32)]
    
    def process_peak_height_data(self) -> list[int]:
        """
        Parse and return peak height events as a DataFrame.

        Each peak is encoded as two consecutive 32-bit words (8 bytes total). The structure is:

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

        -------------------------------
        Word 2 (32 bits) - Peak Value (examples before endian order swap: 06ca0000, 14ca0000, 4dca0000, 4bca0000)
        -------------------------------
        Bits 31–16: Constant 0x0000 (reserved)
        Bits 15–0 : 16-bit signed peak height (ADC value at peak)

        Notes:
            - Final byte is always 0x00 (lower 16 bits = 0x0000)

        Returns:
            pd.DataFrame with columns:
                - internal_event_number
                - sub_event_number
                - channel_number
                - xxyy (2-bit peak position code: 0–3)
                - counter (28-bit peak time)
                - peak_height (signed 16-bit ADC value)
        """
        byte_data = bytes.fromhex(self.hex)
        try:
            # unpack data in little-endian format, so f4f3f2f1 becomes f1f2f3f4
            word: int = struct.unpack('<I', byte_data)[0]
        except struct.error:
            print(f"Error: {self.hex} could not be converted to a 32-bit word.")
            raise
        if not getattr(self.hex_check, "second_peak_height", False):
            # first word
            # 0x70, 0x60, 0x50, or 0x40
            first_word = (word & 0xF0000000) >> 28
            if first_word not in [0x7, 0x6, 0x5, 0x4]:
                raise ValueError(f"Invalid first word: {hex(first_word)}. Expected one of [0x70, 0x60, 0x50, 0x40].")
            peak_location = first_word & 0b0011  # get the last two bits of the first word
            counter = (word & 0x0FFFFFFF)  # 28-bit counter value
            time = counter * 4  # time in ns
            self.hex_check.second_peak_height = True  # prepare for next event
            return [peak_location, time]
        else:
            # top 16 bits are always 0x0000
            if (word & 0xFFFF0000) != 0:
                raise ValueError(f"Invalid second word: {hex(word)}. Expected top 16 bits to be 0x0000.")
            # bottom 16 bits are the signed peak height
            peak_height = signed(word & 0x0000FFFF, 16)
            
            # convert to hex string and pad with zeros
            hex_str = peak_height.to_bytes(2, byteorder='little', signed=True).hex().zfill(4)
            proper_height = self.process_hex_raw_data(mode='s12', hex_in=hex_str + '0000')[0] # convert to signed 12-bit
            self.hex_check.second_peak_height = False
            return [proper_height]
    
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
            ret += f" = {self.raw_data} (extra bytes: {self.hex_check.raw_data_remaining})>"
        elif self.type == peak_height_data:
            peak_height = self.peak_height
            if len(peak_height) > 1:
                # [peak_number (0-3), time (ns)]
                ret += f" = Peak #{peak_height[0]} ({peak_height[1]} ns)>"
            else:
                # [peak_height (ADC value)]
                ret += f" = {peak_height[0]} ({convert_voltage(peak_height[0], 3)} V)>"
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


def convert_voltage(v, round_n=None):
    # ADC peak-to-peak is 1.34V (+/- 0.67V), so 0.67V = 2047, -0.67V = -2048
    # Voltage at FMC228 transformer is 2.52V, ratio is 2.52V / 1.34V = 1.88V
    # Therefore, values at FMC228 pins are 1.88 * ADC values
    # 2047 = 0.67 * 1.88 = 1.26V, -2048 = -0.67 * 1.88 = -1.26V
    # Max voltage is +/- 1.26V
    if config.mode == 's12':
        v_out = v * 1.26 / 2047
    elif config.mode == 's16':
        v_out = v * 1.26 / (2047 / 2 ** 11 * 2 ** 15)
    elif config.mode == 's32':
        v_out = v * 1.26 / (2047 / 2 ** 11 * 2 ** 31)
    else:
        raise ValueError("Invalid mode. Please choose 's12', 's16', or 's32'.")
    
    if round_n:
        return round(v_out, round_n)
    else:
        return v_out


def convert_voltage_reverse(v):
    if config.mode == 's12':
        return v * 2047 / 1.26
    elif config.mode == 's16':
        return v * (2047 / 2 ** 11 * 2 ** 15) / 1.26
    elif config.mode == 's32':
        return v * (2047 / 2 ** 11 * 2 ** 31) / 1.26


def signed(value: int, width: int) -> int:
    """Converts an unsigned value to a signed value."""
    if value >= 2 ** width:
        raise ValueError(f"Value must be at most {width}-bit{f' ({width // 4} bytes)' if width % 4 == 0 else ''}. "
                         f"Your value {value} / {hex(value)} had {len(bin(value)) - 2} bits.")
    width = width - 1  # example: for four bit number, shift "1" over 4-1=3 to get 1000 (the desired sign bit)
    return -(value & (1 << width)) | (value & ((1 << width) - 1))


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


def set_config():
    """Set the configuration for the hex_check module."""
    from hex_check import Config
    return Config()

hex_check_state = {}  # hex_check.py will put hex_check in here as hex_check_state["hex_check"]
# it will eventually be used in the Event class

config = set_config()
