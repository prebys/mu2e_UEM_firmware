#!/usr/bin python3
import logging
import re
import struct
from dataclasses import dataclass
from datetime import datetime
from typing import Optional, Union

from zoneinfo import ZoneInfo

import python_analysis.event_types as et
from python_analysis.event_types import EventType
from python_analysis.hex_check_config import config
from python_analysis.hex_check_helpers import (endian_conversion, signed, chunk,
                                               ParentHasEventNumber, ParentHasSubEventNumber,
                                               DoubleADCTupleWithCount, DoubleADCTuple, SingleADC,
                                               PeakHeaderTuple, PeakHeightTuple, convert_voltage)


if __name__ == "__main__":
    raise ImportError("This module is not meant to be run directly. Please use it as a library.")


def _decode_raw_data_word(hex_in: str = "", mode: str = 's12') -> Union[DoubleADCTupleWithCount, DoubleADCTuple, SingleADC]:
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
    elif mode == 's32':
        # this is already ordered in the right way, with the MSB being the newest data and the LSB being oldest
        # this was proven by doing a 32 bit ramp test and seeing the data increase in the expected way
        return SingleADC(signed(word, 32))
    else:
        raise ValueError("Invalid mode. Please choose 's12', 's16', or 's32'.")


def _decode_peak_height_header_word(hex_word: str) -> PeakHeaderTuple:
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
    word = endian_conversion(hex_word)
    
    # first word
    # 0x70, 0x60, 0x50, or 0x40
    first_word = (word & 0xF0000000) >> 28
    if first_word not in [0x7, 0x6, 0x5, 0x4]:
        raise ValueError(f"Invalid first word: {hex(first_word)} in {hex_word}. "
                         f"Expected one of [0x70, 0x60, 0x50, 0x40].")
    peak_location = first_word & 0b0011  # get the last two bits of the first word
    counter = (word & 0x0FFFFFFF)  # 28-bit counter value
    time = counter * 4  # time in ns
    return PeakHeaderTuple(peak_location, time)

def _decode_peak_height_value_word(hex_word: str) -> PeakHeightTuple:
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
    word = endian_conversion(hex_word)
    
    # top 16 bits are always 0x0000
    if (word & 0xFFFF0000) != 0:
        raise ValueError(
            f"Invalid second word: {hex(word)}. Expected top 16 bits to be 0x0000.")
    # bottom 16 bits are the signed peak height
    peak_height = signed(word & 0x0000FFFF, 16)
    
    # convert to hex string and pad with zeros
    hex_str = peak_height.to_bytes(2, byteorder='little', signed=True).hex().zfill(4)
    proper_height = _decode_raw_data_word(mode='s12', hex_in=hex_str + '0000')[0]  # convert to signed 12-bit
    return PeakHeightTuple(proper_height)

def _decode_peak_area(hex_word: str, 
                      peak_type: EventType) -> int:
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
    word = endian_conversion(hex_word)
    if peak_type == "peak_area_data_1":
        # examples before conversions: c7e51111, bee51111, cbe51111
        # example, "c7ef1111" becomes "0x11_11_e5_c7" after endian conversion
        # top bits are always 0x1111, bottom bits are the actual data
        top = (word >> 16) & 0xFFFF
        bottom = word & 0xFFFF
        if top != 0x1111:
            raise ValueError(
                f"Invalid peak_area_data_1 marker in {hex_word}: got 0x{top:04x}"
            )
        
        return bottom
    elif peak_type == "peak_area_data_2":
        # examples before conversions: 2c8bf9ff, c089f9ff, b48ef9ff
        return word
    elif peak_type == "peak_area_data_3":
        # examples before conversions: b089fdff, b821fdff
        return word
    elif peak_type in ["peak_area_data_4", "peak_area_data_5", "peak_area_data_6"]:
        # examples of different peak types before conversions: 
        # 4: 45170000, 78170000, db170000
        # 5: 89180000, b5110000, d2110000
        # 6: d4c0a000, e2c0a000, f0c0a000
        time_to_peak = (word & 0x0FFFFFFF) * 4  # multiply to convert clock counter to ns
        return time_to_peak
    else:
        raise ValueError(f"Invalid peak area data type: {hex_word}")
    

def _decode_eventtype_data_word(event_type: EventType, hex_word: str) -> Optional[int]:
    """
    Reuse the `EventType.data_chars` convention (nibble slice) without constructing an `Event`.

    Returns:
      - int if the regex has a `.` data region
      - None if the event has no data region
    """
    start, end = event_type.data_chars
    if start == 0 and end == 0:
        return None

    data_hex = hex_word[start:end]
    if not data_hex:
        return None

    # Pad to 8 chars (32 bits) like `Event.get_data_bytes()` does
    data_hex = f"{data_hex:0<8}"
    data_bytes = bytes.fromhex(data_hex)
    return struct.unpack("<I", data_bytes)[0]


def _parse_raw_data_channel(channel: "ChannelData", block: str) -> list["RawData"]:
    """Strip headers/trailer, convert packets to Events, flatten 2-word raw_data."""
    # inside each raw_data_channel, it starts with seven packets of headers
    # then raw data for unspecified length starting at the eight packet (i[8*7:])
    # then one packet (fbfbfbfb) of end_of_channel (skipped by i[:-8*1])
    # remove 7 header packets at start and 1 trailer packet at end
    PACKET_LENGTH = 8
    HEADER_LENGTH = 7
    FOOTER_LENGTH = 1
    payload = block[PACKET_LENGTH * HEADER_LENGTH: -PACKET_LENGTH * FOOTER_LENGTH]
    assert len(payload) % 8 == 0, f"Payload length {len(payload)} is not a multiple of 8."
    
    out: list[RawData] = []
    for hex_word in chunk(payload, size=PACKET_LENGTH):
        raw_data_result = _decode_raw_data_word(hex_in=hex_word, mode=config.integer_mode)
        
        if isinstance(raw_data_result, DoubleADCTupleWithCount):
            raw_data_result: DoubleADCTupleWithCount
            r1 = RawData(channel=channel, value=raw_data_result.adc1)
            r2 = RawData(channel=channel, value=raw_data_result.adc2)
            out.extend([r1, r2])
        elif isinstance(raw_data_result, DoubleADCTuple):
            raw_data_result: DoubleADCTuple
            r1 = RawData(channel=channel, value=raw_data_result.adc1)
            r2 = RawData(channel=channel, value=raw_data_result.adc2)
            out.extend([r1, r2])
        elif isinstance(raw_data_result, SingleADC):
            # not that I'll ever use this, but if in s16 / s32 mode, it'll be just one data point
            raw_data_result: SingleADC
            out.append(RawData(channel=channel, value=raw_data_result.adc))
        else:
            raise ValueError("Unexpected raw data result type.")
    return out


def _parse_peak_height_channel(channel: "ChannelData", block: str) -> list["PeakHeight"]:
    """Strip headers/trailer, convert packets to Events, flatten 2-word peak_height_data."""
    # aaaa is second half of overall peak_finding_header
    # cccc_cccc is peak height header
    # cece_cece = peak height end
    # dddd = first half of peak area header
    matches = re.findall(r'aaaacccccccc(.*?)cecececedddd', block)
    if not matches:
        return []
    
    payload: str = matches[0]
    assert len(payload) % 16 == 0, f"Payload length {len(payload)} is not a multiple of 16."
    out = []
    
    # make placeholder to take advantage of Event's regex matching on peak format
    # Event checks format if the "previous" arg is filled and "current" is not
    chunks = list(chunk(payload, size=16))
    # print(chunks)
    for pair in chunks:
        w1 = pair[:8]
        w2 = pair[8:]
        
        header = _decode_peak_height_header_word(w1)
        value = _decode_peak_height_value_word(w2)
        
        out.append(
            PeakHeight.from_header_and_value(channel, header, value)
        )
    return out


def _parse_peak_area_channel(channel: "ChannelData", block: str) -> list["PeakArea"]:
    """Strip headers/trailer, convert packets to Events, flatten 5-word peak_area_data."""
    # cece = peak height end
    # dddd_dddd = peak area header
    # dede_dede = peak area end
    # bbbb = first half of end peak data
    
    out = []
    match = re.findall(r'cecedddddddd(.*?)dedededebbbb', block)
    if not match:
        return []
    
    payload: str = match[0]
    try:
        assert len(
            payload) % 48 == 0, f"Payload length {len(payload)} ({block} -> {payload}) is not a multiple of 48."
    except AssertionError as e:
        print(e)
        return out
    
    chunks = list(chunk(payload, size=48))
    for h in chunks:
        data1 = _decode_peak_area(h[0:8], et.peak_area_data_1)
        data2 = _decode_peak_area(h[8:16], et.peak_area_data_2)
        data3 = _decode_peak_area(h[16:24], et.peak_area_data_3)
        data4 = _decode_peak_area(h[24:32], et.peak_area_data_4)
        data5 = _decode_peak_area(h[32:40], et.peak_area_data_5)
        data6 = _decode_peak_area(h[40:48], et.peak_area_data_6)
        peak_area = PeakArea.from_ints(channel, data1, data2, data3, data4, data5, data6)
        out.append(peak_area)
    
    return out


class Event:
    """Recreation of the Event class with a new method of storing previous event to save memory.

    This "Event" will be one Event in a data file, starting with 0xffffffff and ending with either
    0x00fcfcfc (end_sub_event) or 0xfcfcfcfc (end_event)

    Some new event types will also start with 0xff_ff_ff_f1 followed by an 8-byte unix timestamp"""

    def __init__(self, internal_event_number, data_str, verbosity=logging.INFO):
        logger = logging.getLogger(self.__class__.__name__)
        logger.setLevel(verbosity)
        # check for timestamp in beginning of event, first four bytes of data_str will be ffffff11
        logger.debug(f"Parsing Event #{internal_event_number}, data length {len(data_str)}.")
        logger.debug(f"data_str starts with {data_str[:20]}")
        if data_str.startswith('ffffff11'):
            self.timestamp = datetime.fromtimestamp(int(data_str[8:24], 16) / 1e6,
                                                    tz=ZoneInfo("America/Chicago"))
            # remove these 12 bytes from data_str
            logger.debug(f"Found timestamp: {self.timestamp}, skipping {data_str[:24]}")
            data_str = data_str[24:]
        else:
            self.timestamp = None

        self.event_number = _decode_eventtype_data_word(hex_word=data_str[8 * 5:8 * 6],
                                                        event_type=et.event_number_evn)
        self.internal_event_number: int = internal_event_number

        # print timestamp if available
        if self.timestamp:
            logger.debug(f"Event {self.event_number}-{self.internal_event_number} has timestamp {self.timestamp}")
        else:
            logger.debug(f"Event {self.event_number}-{self.internal_event_number} has no timestamp.")

        # get sub events
        r = (r'00ffffff'
             r'f4f3f2f1'
             r'.*?'
             r'edededed'
             r'00fcfcfc')
        sub_events: list[str] = re.findall(r, data_str)
        logger.debug(f"Event {self.event_number}-{self.internal_event_number} has {len(sub_events)} "
              f"sub-events.")
        self.sub_events = [SubEvent(self, sub_event_hex_str) for sub_event_hex_str in sub_events]

    def __repr__(self):
        return f"<Event #{self.event_number}-{self.internal_event_number}, {len(self.sub_events)} sub-events>"


class SubEvent(ParentHasEventNumber):
    def __init__(self, event: Event, data_str: str, verbosity=logging.INFO):
        # logging
        logger = logging.getLogger(self.__class__.__name__)
        logger.setLevel(verbosity)



        self.parent: Event = event
        self.sub_event_number = _decode_eventtype_data_word(
            hex_word=data_str[8*3:8*4],
            event_type=et.sub_event_number_evn
        )

        logger.debug(f"Parsing SubEvent for "
                     f"Event #{event.internal_event_number}-{self.sub_event_number}, "
                     f"hex length {len(data_str)}.")

        # RAW DATA
        # list of four hex strings, one for each of the channels
        raw_data_channels = re.findall(r'fafa....ffff.*?fbfbfbfb(?=fafa|fefe)', data_str)


        # PEAK DATA
        # list of four hex strings, one for each of the channels
        peak_channels = re.findall(r'eeee....aaaa.*?bbbbbbbbecececec', data_str)

        # logger.debug('\n'.join(peak_channels))

        self.channels: list[ChannelData] = []
        for i in range(4):
            channel_num = 4 - i  # starts with channel 4 and counts down to channel 1
            channel = ChannelData(self,
                channel_num,
                raw_data_channels[i],
                peak_channels[i],
                )
            self.channels.append(channel)
        self.channels = self.channels[::-1]  # reverse order so channel 1 is first

    def __repr__(self):
        return f"<SubEvent #{self.event_number}-{self.internal_event_number}-{self.sub_event_number}, " \
               f"{len(self.channels)} channels>"


class ChannelData(ParentHasSubEventNumber):
    """
    ChannelData contains all data for one channel within a SubEvent.

    Properties:
        - raw_data_list: list of RawData objects
        - peak_height_list: list of PeakHeight objects
        - peak_area_list: list of PeakArea objects
    """
    def __init__(self,
                 sub_event: SubEvent,
                 channel_num: int,
                 raw_data_hex_string: str,
                 peaks_hex_string: str,
                 verbosity = logging.INFO
                 ):

        logger = logging.getLogger(self.__class__.__name__)
        logger.setLevel(verbosity)
        
        self.parent = sub_event
        self.channel_number = channel_num
        self.event_num_string = f"{self.internal_event_number}-{self.sub_event_number}-{self.channel_number}"
        
        # RAW DATA
        self.raw_data_list = _parse_raw_data_channel(self, raw_data_hex_string)
        raw_data_length = len(self.raw_data_list)

        # PEAK HEIGHT
        self.peak_height_list = _parse_peak_height_channel(self, peaks_hex_string)
        height_counts = len(self.peak_height_list)

        # PEAK AREA
        self.peak_area_list = _parse_peak_area_channel(self, peaks_hex_string)  # four lists of PeakArea objects
        area_counts = len(self.peak_area_list)
    
        logger.debug("")
        logger.debug(f"[{self.event_num_string}] [RAW_DATA] length: {raw_data_length}.")
        logger.debug(self.raw_data_list)
        logger.debug(f"[{self.event_num_string}] [PEAK_HEIGHT] length: {height_counts}.")
        logger.debug(self.peak_height_list)
        logger.debug(f"[{self.event_num_string}] [PEAK_AREA] length: {area_counts}.")
        logger.debug(self.peak_area_list)
        

@dataclass(slots=True, frozen=True)
class RawData:
    """
    - channel: ChannelData
    - value: int
    """
    channel: "ChannelData"
    value: int

    @property
    def internal_event_number(self) -> int:
        return self.channel.internal_event_number

    @property
    def sub_event_number(self) -> int:
        return self.channel.sub_event_number

    @property
    def channel_number(self) -> int:
        return self.channel.channel_number


@dataclass(slots=True)
class PeakArea:
    channel: ChannelData
    max_peak: int
    area_begin_to_max: int
    area_total: int
    time_trig_to_max: int
    time_trig_to_begin: int
    time_trig_to_end: int
    
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
    def from_ints(cls,
                  channel: "ChannelData",
                  data1: int,
                  data2: int,
                  data3: int,
                  data4: int,
                  data5: int,
                  data6: int) -> "PeakArea":
        p = cls(
            channel=channel,
            max_peak=data1,
            area_begin_to_max=data2,
            area_total=data3,
            time_trig_to_max=data4,
            time_trig_to_begin=data5,
            time_trig_to_end=data6,
        )
        return p
    
    def __repr__(self):
        return (f"<PeakArea max_peak={self.max_peak}, "
                f"area_begin_to_max={self.area_begin_to_max}, "
                f"area_total={self.area_total}, "
                f"time_trig_to_max={self.time_trig_to_max}, "
                f"time_trig_to_begin={self.time_trig_to_begin}, "
                f"time_trig_to_end={self.time_trig_to_end}>")


@dataclass(slots=True)
class PeakHeight:
    channel: "ChannelData"
    position: int
    time_ns: int
    height: int
    
    @property
    def internal_event_number(self) -> int:
        return self.channel.internal_event_number

    @property
    def sub_event_number(self) -> int:
        return self.channel.sub_event_number

    @property
    def channel_number(self) -> int:
        return self.channel.channel_number
    
    @classmethod
    def from_header_and_value(
            cls,
            channel: ChannelData,
            header_event: PeakHeaderTuple,
            value_event: PeakHeightTuple
    ) -> "PeakHeight":
        """Create a Peak object from a PeakHeader and PeakHeight event."""
        return cls(channel=channel,
                   position=header_event.position,
                   time_ns=header_event.time_ns,
                   height=value_event.height)

    def __repr__(self):
        return (f"<Peak #{self.channel.event_num_string} pos={self.position}, "
                f"time={self.time_ns} ns, "
                f"height={self.height} "
                f"({convert_voltage(self.height, 3, config.integer_mode)
                if self.height is not None else 'N/A'} V)>")



hex_check_state = {}  # hex_check.py will put hex_check in here as hex_check_state["hex_check"]
# it will eventually be used in the Event class

# config = set_config()