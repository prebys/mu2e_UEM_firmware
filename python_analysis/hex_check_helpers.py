import logging
import struct
from typing import NamedTuple, Union, Any


def setup_logging(level: int = logging.INFO) -> None:
    # Configure root handlers exactly once
    logging.basicConfig(
        level=level,
        format="%(name)s: %(message)s",
    )

# Call early (e.g. at start of main/new_main)
setup_logging(logging.INFO)


def convert_voltage(v, round_n=None, integer_mode='s12'):
    # ADC peak-to-peak is 1.34V (+/- 0.67V), so 0.67V = 2047, -0.67V = -2048
    # Voltage at FMC228 transformer is 2.52V, ratio is 2.52V / 1.34V = 1.88V
    # Therefore, values at FMC228 pins are 1.88 * ADC values
    # 2047 = 0.67 * 1.88 = 1.26V, -2048 = -0.67 * 1.88 = -1.26V
    # Max voltage is +/- 1.26V
    if integer_mode == 's12':
        v_out = v * 1.26 / 2047
    elif integer_mode == 's16':
        v_out = v * 1.26 / (2047 / 2 ** 11 * 2 ** 15)
    elif integer_mode == 's32':
        v_out = v * 1.26 / (2047 / 2 ** 11 * 2 ** 31)
    else:
        raise ValueError("Invalid mode. Please choose 's12', 's16', or 's32'.")
    
    if round_n:
        return round(v_out, round_n)
    else:
        return v_out


def convert_voltage_reverse(v, integer_mode='s12'):
    if integer_mode == 's12':
        return v * 2047 / 1.26
    elif integer_mode == 's16':
        return v * (2047 / 2 ** 11 * 2 ** 15) / 1.26
    elif integer_mode == 's32':
        return v * (2047 / 2 ** 11 * 2 ** 31) / 1.26
    else:
        raise ValueError("Invalid mode. Please choose 's12', 's16', or 's32'.")


def signed(value: int, width: int) -> int:
    """Converts an unsigned value to a signed value."""
    if value >= 2 ** width:
        raise ValueError(
            f"Value must be at most {width}-bit{f' ({width // 4} bytes)' if width % 4 == 0 else ''}. "
            f"Your value {value} / {hex(value)} had {len(bin(value)) - 2} bits.")
    width -= 1  # example: for four bit number, shift "1" over 4-1=3 to get 1000 (the desired sign bit)
    return -(value & (1 << width)) | (value & ((1 << width) - 1))


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
        word: int = struct.unpack('<I', byte_data)[
            0]  # unpack() returns tuple, here with one element only
        # word is the signed interpretation of the full 32-bit word, f1f2f3f4 --> -235736076, NOT simply -0xf1f2f3f4
        # given f1f2f3f4, the least significant byte is f4, the most significant byte is f1
        # it's natural that the ADC will fill data in starting at the least significant byte
        # so f3f4 **is the older data** and f1f2 **is the newer data**
    except struct.error:
        print(f"Error: {hex_str} could not be converted to a 32-bit word.")
        raise
    
    return word


def chunk(s: str, size: int = 8):
    """Yield 8-char packets from s."""
    for i in range(0, len(s), size):
        yield s[i:i + size]


class ParentHasEventNumber:
    """
    Mixin class for objects that have an event number. The "parent" attribute says
    "wherever this object is appearing, it must have a 'parent' attribute from which you
    can call the event number properties".
    Has: parent, event_number, internal_event_number
    """
    parent: Any
    
    @property
    def event_number(self) -> int:
        return self.parent.event_number
    
    @property
    def internal_event_number(self) -> int:
        return self.parent.internal_event_number


class ParentHasSubEventNumber(ParentHasEventNumber):
    """
    From "HasEventNumber", this class has a "parent" property.
    Has: parent, event_number, internal_event_number, sub_event_number
    """
    
    @property
    def sub_event_number(self) -> int:
        return self.parent.sub_event_number


class ParentHasChannelNumber(ParentHasSubEventNumber):
    """
    Has: parent (x2), event_number, internal_event_number, sub_event_number, channel_number
    """
    
    @property
    def channel_number(self) -> int:
        return self.parent.channel_number
    
    
PeakHeaderTuple = NamedTuple("PeakHeader", [("position", int), ("time_ns", int)])
PeakHeightTuple = NamedTuple("PeakHeight", [("height", int)])

DoubleADCTupleWithCount = NamedTuple("DoubleADCTupleWithCount",
                                     [("adc1", int), ("adc2", int), ("count", int)])  # s12
DoubleADCTuple = NamedTuple("DoubleADCTuple", [("adc1", int), ("adc2", int)])  # s16 mode
SingleADC = NamedTuple("SingleADC", [("adc", int)])  # s32 mode
ADCTypes = Union[DoubleADCTupleWithCount, DoubleADCTuple, SingleADC]