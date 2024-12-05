#!/usr/bin python3
import struct
import sys
import os
import re

from collections import OrderedDict

import numpy as np
import tkinter
import matplotlib
from matplotlib import pyplot as plt
matplotlib.use("Agg")

from datetime import datetime

# sample of beginning of file:
# ffffffff 00ffffff f4f3f2f1 00ccccfc
# 00000000 2804ac00 fdfdfdfd f4f3f2f1
# 2804ac00 fafa03fa ffff9c10 00000000 ...

# set "desired_file" to None to use the most recent data file in the directory
# desired_file = "test20241112_145129.dat"
desired_file = None

# if True, will print all event types regardless of the "show" attribute of the event_to_hex dictionary
show_all = False
show_nothing = True

# set to "-1" to use the newest file in the directory
# "-2" for example will use the second-newest file
to_use_file_index = -1

# if this contains entries, then the code will ignore the "show" attribute of the event_to_hex dictionary
# and only show the events in this list
only_show = ["channel_header"]  # ["begin_event", "event_number", "channel_header", "begin_sub_event", "sub_event_number"]
# set to empty list [] to use the "show" attribute of the event_to_hex dictionary

event_to_hex = {
    "begin_event": {"re": r"ffffffff", "next": ["begin_event", "begin_sub_event"], "show": True, "data_chars": [0, 0]},
    # ↓　(sub event)
    "begin_sub_event": {"re": r"00ffffff", "next": ["byte_order"], "show": True, "data_chars": [0, 0]},
    "byte_order": {"re": r"f4f3f2f1", "next": ["fmc228_number"], "show": True, "data_chars": [0, 0]},
    "fmc228_number": {"re": r"00ccccfc", "next": ["sub_event_number"], "show": False, "data_chars": [0, 2]},
    "sub_event_number": {"re": r"......\d\d", "next": ["event_number"], "show": True, "data_chars": [0, 8]},
    "event_number": {"re": r"........", "next": ["begin_raw_data"], "show": True, "data_chars": [0, 8]},
    # ↓ ↓　(raw waveform data)
    "begin_raw_data": {"re": r"fdfdfdfd", "next": ["byte_order2"], "show": False, "data_chars": [0, 0]},
    "byte_order2": {"re": r"f4f3f2f1", "next": ["event_number2"], "show": False, "data_chars": [0, 0]},
    "event_number2": {"re": r"........", "next": ["channel_header"], "show": False, "data_chars": [0, 8]},
    # ↓ ↓ ↓　(data of one channel)
    "channel_header": {"re": r"fafa..fa", "next": ["waveform"], "show": True, "data_chars": [4, 6]},
    "waveform": {"re": r"ffff....", "next": ["fragment_trig_mask"], "show": True, "data_chars": [4, 8]},
    "fragment_trig_mask": {"re": r"0000....", "next": ["stat"], "show": True, "data_chars": [4, 8]},
    "stat": {"re": r"........", "next": ["status_word"], "show": True, "data_chars": [0, 8]},
    "status_word": {"re": r"........", "next": ["bco_low"], "show": True, "data_chars": [0, 8]},
    "bco_low": {"re": r"........", "next": ["bco_high"], "show": True, "data_chars": [0, 8]},
    "bco_high": {"re": r"........", "next": ["end_of_channel", "raw_data"], "show": True, "data_chars": [0, 8]},
    "raw_data": {"re": r"........", "next": ["end_of_channel", "raw_data"], "show": True, "data_chars": [0, 8]},
    "end_of_channel": {"re": r"fbfbfbfb", "next": ["end_raw_data", "channel_header"], "show": True,
                       "data_chars": [0, 0]},
    # ↑ ↑ ↑　end of (data of one channel)
    "end_raw_data": {"re": r"fefefefe", "next": ["begin_peak_stream_data"], "show": False, "data_chars": [0, 0]},
    # ↑ ↑ end of (raw waveform data)
    # ↓ ↓　(peak stream data)
    "begin_peak_stream_data": {"re": r"efefefef", "next": ["channel_number"], "show": False, "data_chars": [0, 0]},
    # ↓ ↓ ↓　(data of one channel)
    "channel_number": {"re": r"eeee....", "next": ["peak_finding_header"], "show": True, "data_chars": [4, 8]},
    "peak_finding_header": {"re": r"aaaaaaaa", "next": ["peak_height_header"], "show": False, "data_chars": [0, 0]},
    "peak_height_header": {"re": r"cccccccc", "next": ["peak_height_end", "peak_height_data"],
                           "show": False, "data_chars": [0, 0]},
    "peak_height_data": {"re": r"........", "next": ["peak_height_end", "peak_height_data"],
                         "show": False, "data_chars": [0, 8]},
    "peak_height_end": {"re": r"cececece", "next": ["peak_area_header"], "show": False, "data_chars": [0, 0]},
    "peak_area_header": {"re": r"dddddddd", "next": ["peak_area_end", "peak_area_data"],
                         "show": False, "data_chars": [0, 0]},
    "peak_area_data": {"re": r"........", "next": ["peak_area_end", "peak_area_data"],
                       "show": False, "data_chars": [0, 8]},
    "peak_area_end": {"re": r"dededede", "next": ["end_peak_data"], "show": False, "data_chars": [0, 0]},
    "end_peak_data": {"re": r"bbbbbbbb", "next": ["end_peak_channel"], "show": False, "data_chars": [0, 0]},
    "end_peak_channel": {"re": r"ecececec", "next": ["end_peak_stream_data", "channel_number"], "show": False,
                         "data_chars": [0, 0]},
    # ↑ ↑ ↑ end of (data of one channel)
    "end_peak_stream_data": {"re": r"edededed", "next": ["end_sub_event"], "show": False, "data_chars": [0, 0]},
    # ↑ ↑ end of (peak stream data)
    "end_sub_event": {"re": r"00fcfcfc", "next": ["end_event", "begin_sub_event", "begin_event"], "show": True,
                      "data_chars": [0, 0]},
    # ↑ end of (sub event)
    "end_event": {"re": r"fcfcfcfc", "next": ["begin_event"], "show": True, "data_chars": [0, 0]}
}

# next will be a reverse dictionary of the above dictionary containing just the unique event hexes
# for example, "ffffffff" : "begin_event"
hex_to_event = {
    r"ffffffff": "begin_event",
    r"00ffffff": "begin_sub_event",
    r"f4f3f2f1": "byte_order",
    r"00ccccfc": "fmc228_number",
    r"fdfdfdfd": "begin_raw_data",
    r"fafa....": "channel_header",
    r"ffff....": "waveform",
    r"0000....": "fragment_trig_mask",
    r"fbfbfbfb": "end_of_channel",
    r"fefefefe": "end_raw_data",
    r"efefefef": "begin_peak_stream_data",
    r"eeee....": "channel_number",
    r"aaaaaaaa": "peak_finding_header",
    r"cccccccc": "peak_height_header",
    r"cdcdcdcd": "peak_height_end",
    r"dddddddd": "peak_area_header",
    r"dededede": "peak_area_end",
    r"bbbbbbbb": "end_peak_data",
    r"ecececec": "end_peak_channel",
    r"edededed": "end_peak_stream_data",
    r"00fcfcfc": "end_of_sub_event",
    r"fcfcfcfc": "end_event"
}

event_counts = {}
raw_data_log = OrderedDict()

def main(plot=True):
    hex_data, input_file = open_data_file(desired_file)
    
    # count_events(hex_data)

    previous_event_type = ""
    number_of_printed_logs = 0
    event_number = 0
    channel_number = 0
    print("\n\nStart printing of data")
    for i in range(0, len(hex_data), 8):
        # detect current event type
        current_event_hex = hex_data[i:i + 8]
        matched, current_event_type = detect_current_event_type(previous_event_type, current_event_hex)
        previous_event_type = current_event_type
        
        
        if current_event_type == "event_number":
            event_number = int(current_event_hex[2:4] + current_event_hex[0:2], 16)
        if current_event_type == "channel_header":
            channel_number = int(current_event_hex[4:6]) + 1
        
        if matched:
            # if bco_high went straight to end_of_channel, note that there was no raw_data
            # if previous_event_type == "bco_high" and current_event_type == "end_of_channel":
            #     print("** no raw_data **")
            
            # note if the previous event was peak_height_data or peak_area_data since those are being omitted
            # if previous_event_type in ["peak_height_header", "peak_area_header"] and \
            #         current_event_type in ["peak_height_data", "peak_area_data"]:
            #     # omit only if "show" == False in the dictionary
            #     if not event_to_hex[current_event_type]["show"]:
            #         print(f"** {current_event_type} omitted **")
            
            data_start_index = event_to_hex[current_event_type]["data_chars"][0]
            data_end_index = event_to_hex[current_event_type]["data_chars"][1]
            hex_value = current_event_hex[data_start_index:data_end_index]
            
            # some events only have data in certain characters of the hex
            if data_start_index != data_end_index:
                # for event_number, hex will be like "cdab0000", and the first four should be taken and reordered "abcd"
                if event_to_hex[current_event_type]["data_chars"] == [0, 8]:
                    try:
                        int_value = (str(int(hex_value[2:4] + hex_value[0:2], 16)) + " + " +
                                     str(int(hex_value[6:8] + hex_value[4:6], 16)))
                    except ValueError:
                        print(f"Error: {current_event_type}, {hex_value}, {data_start_index}, {data_end_index}, ")
                        return
                else:
                    int_value = int(hex_value, 16)
                event_type_text = f"{current_event_type}, {hex_value} --> {int_value}"
            else:
                event_type_text = f"{current_event_type}"
                
            # take raw data
            if current_event_type == "raw_data":
                data_one, data_two = process_hex_raw_data(current_event_hex)
                raw_data_log[event_number] = raw_data_log.setdefault(event_number, {})
                raw_data_log[event_number][channel_number] = (raw_data_log[event_number].get(channel_number, []) +
                                                              [data_one, data_two])
            
            if event_to_hex[current_event_type]["show"]:
                number_of_printed_logs += 1
                print(f"[{i//8}]: {current_event_hex} ({event_type_text})")
                
            # if number_of_printed_logs > 10000:
            #     # end code
            #     # break
            #     pass
            
            event_counts[current_event_type] = event_counts.get(current_event_type, 0) + 1
        
        else:
            if current_event_type:
                print(f"**** ERROR ****"
                      f"\n[{i//8}] previous_event_type: {previous_event_type}, current_event_type: {current_event_type}, "
                      f"{current_event_hex} (unknown event)")
                return
            else:  # the first event was not "begin_event" and it's searching for that
                # print(f"First event ({current_event_hex}) not 'begin_event', searching for begin_event")
                pass

    for event_type in event_to_hex:
        count = event_counts.get(event_type, 0)
        print(f"{event_type}: {count}")
        
    print(f"Used input file {input_file}")
    
    if plot:
        date = datetime.now().strftime('%Y.%m.%d_%H.%M.%S')
        folder_name = f"{date}_{input_file}"
        plot_data(raw_data_log, folder_name, 15)
    
    return event_counts
    
    
def open_data_file(file_path):
    # get directory of the script
    dir_name = os.path.dirname(os.path.realpath(__file__))
    
    if file_path:
        args = [sys.argv[0], file_path]
    else:
        args = sys.argv
    
    # get input file either from command line or from the current directory
    if len(args) == 2:
        input_file = args[1]
        if input_file.startswith("./"):
            input_file = input_file[2:]
    elif len(args) == 1:
        # find the file ending in .dat in the current directory
        files = os.listdir(dir_name)
        dat_files = sorted([file for file in files if file.endswith(".dat")], key=lambda x: os.path.getctime(x))
        if len(dat_files) == 0:
            print("No .dat files found in the current directory")
            return
        elif len(dat_files) > 1:
            print(f"Warning: Multiple .dat files found in the current directory. "
                  f"Picking the last one ({dat_files[-1]})")
            input_file = dat_files[to_use_file_index]
        else:
            input_file = dat_files[-1]
    else:
        print("Invalid number of arguments. Usage: `python3 hex_check.py path_to_data_file.dat`")
        return
    
    # set "show" values in main dictionary if things are in "only_show"
    if only_show:
        for event in event_to_hex:
            if event in only_show:
                event_to_hex[event]["show"] = True
            else:
                event_to_hex[event]["show"] = False
    
    # show everything if show_all is True
    if show_all and show_nothing:
        raise ValueError("Both show_all and show_nothing are True. Please set one to False.")
    if show_all:
        print("Showing all events regardless of the 'show' attribute in the dictionary")
        for event in event_to_hex:
            event_to_hex[event]["show"] = True
    if show_nothing:
        print("Showing nothing")
        for event in event_to_hex:
            event_to_hex[event]["show"] = False
    
    # open binary file
    with open(os.path.join(dir_name, input_file), "rb") as file:
        binary_data = file.read()  # a "bytes" object
    
    # convert to hex, should be a string starting with "ffffffffffffff00" etc
    hex_data = binary_data.hex()
    
    return hex_data, input_file
    
    
def count_events(hex_data):
    to_count = ["begin_event", "begin_sub_event", "begin_raw_data", "begin_peak_stream_data", "end_event",
                "raw_data", "peak_area_data", "peak_height_data"]
    print("__Event counts__")
    for event in to_count:
        print(f"{event}: {hex_data.count(event_to_hex[event]['re'])}")
        
        
def detect_current_event_type(previous_event_type, current_event_hex):
    # if the current event is one of the data streams, check the rest of the checks and check directly
    # for another data event (avoid regex)
    matched = False
    current_event_type = None
    
    if previous_event_type == "raw_data":
        if current_event_hex == event_to_hex["end_of_channel"]["re"]:
            matched = True
            # previous_event_type = "raw_data"
            current_event_type = "end_of_channel"
        else:
            matched = True
            current_event_type = "raw_data"
            # both previous_event_type and current_event_type are "raw_data"
            pass
    
    elif previous_event_type == "peak_height_data":
        if current_event_hex == event_to_hex["peak_height_end"]["re"]:
            matched = True
            # previous_event_type = "peak_height_data"
            current_event_type = "peak_height_end"
        else:
            matched = True
            current_event_type = "peak_height_data"
            # both previous_event_type and current_event_type are "peak_height_data"
            pass
    
    elif previous_event_type == "peak_area_data":
        if current_event_hex == event_to_hex["peak_area_end"]["re"]:
            matched = True
            # previous_event_type = "peak_area_data"
            current_event_type = "peak_area_end"
        else:
            matched = True
            current_event_type = "peak_area_data"
            # both previous_event_type and current_event_type are "peak_area_data"
            pass
    
    else:
        if not previous_event_type:
            next_event_candidates = ['begin_event']
        else:
            next_event_candidates = event_to_hex[previous_event_type]["next"]
        for potential_event_type in next_event_candidates:
            if re.match(event_to_hex[potential_event_type]["re"], current_event_hex):
                matched = True
                current_event_type = potential_event_type
                break
                
    return matched, current_event_type


def s12(value: int):
    """Converts a 12-bit unsigned value to a signed value."""
    if len(hex(value)) > 5:
        raise ValueError(f"Value must be at most 12-bit (3 bits). Your value had {len(hex(value)) - 2} bits.")
    return -(value & 0x800) | (value & 0x7ff)


def s16(value: int):
    """Converts a 16-bit unsigned value to a signed value."""
    if len(hex(value)) > 6:
        raise ValueError(f"Value must be at most 16-bit (4 bits). Your value had {len(hex(value)) - 2} bits.")
    return -(value & 0x8000) | (value & 0x7fff)


def s32(value: int):
    """Converts a 32-bit unsigned value to a signed value."""
    if len(hex(value)) > 10:
        raise ValueError(f"Value must be at most 32-bit (8 bits). Your value had {len(hex(value)) - 2} bits.")
    return -(value & 0x80000000) | (value & 0x7fffffff)


def plot_data(data_log, folder_name, nevents=5):
    """Plot nevents number of events from the data_log dictionary.
    Save them in ./img/ folder."""
    if not os.path.exists("img"):
        os.mkdir("img")
    if not os.path.exists(f"img/{folder_name}"):
        os.mkdir(f"img/{folder_name}")
    
    for event_number in data_log:
        if nevents == 0:
            break
        nevents -= 1
        for channel_number in data_log[event_number]:
            try:
                data = data_log[event_number][channel_number]
            except IndexError:
                print(f"Error: Event {event_number} -- Channel {channel_number} has no data.")
                print(data_log[event_number])
                print(data_log[event_number][channel_number])
                raise
            plt.plot(data, label=f"Channel {channel_number}")
            plt.title(f"Event {event_number} -- Channel {channel_number}")
            plt.xlabel("Time (ns)")
            plt.ylabel("ADC value (V)")
           
            def convert_voltage(v):
                return v * 2 / 1722 

            plt.gca().yaxis.set_major_formatter(plt.FuncFormatter(lambda v, t: f"{convert_voltage(v):.4f}"))

            
            # on the same plot, put a sine wave with period of 100ns and same amplitude as previous plot
            x = np.linspace(0, len(data), 1000)
            y = max(data) * np.sin(2 * np.pi * x / 100)
            # print(f"Max voltage ({event_number}): {max(data)} ({convert_voltage(max(data)):.2f})")
            # print(f"Min voltage ({event_number}): {min(data)} ({convert_voltage(min(data)):.2f})")
            plt.plot(x, y, '--', label="Artificial sine wave")
            plt.legend()
    
            plt.savefig(f"img/{folder_name}/c{channel_number}.event_{event_number}.png")
            if nevents == 1:
                # plt.show()
                pass
            plt.close()
            
            
def count_raw_data_events():
    """Mimic the above flow of code but make it minimal to emphasize speed while only counting raw data events."""
    # get list of .dat files in current directory
    files = os.listdir()
    dat_files = [file for file in files if file.endswith(".dat")]
    
    for file in dat_files:
        raw_data_count = 0
        mismatched_count = 0
        with open(file, "rb") as f:
            binary_data = f.read()
        hex_data = binary_data.hex()
        
        current_event_type = ""
        for i in range(0, len(hex_data), 8):
            current_hex = hex_data[i:i + 8]
            matched, current_event_type = detect_current_event_type(current_event_type, current_hex)
            if matched and current_event_type == "raw_data":
                raw_data_count += 1
            elif not matched:
                mismatched_count += 1
        
        print(f"{file}: {raw_data_count} raw data events ({mismatched_count} mismatched events)")
        
def process_hex_raw_data(hex_value: str = "ABCDEF12", debug: bool = False):
    # Input: Hexadecimal string
    
    # Step 1: Convert the hex string to bytes
    # Each pair of characters in the hex string represents a byte.
    # Use `bytes.fromhex` to parse the string.
    byte_data = bytes.fromhex(hex_value)
    
    # Step 2: Reconstruct the 32-bit word in little-endian order
    # Use the unpack function from the struct module to interpret the bytes in little-endian format.
    try:
        word: int = struct.unpack('<i', byte_data)[0]  # '<' = little-endian, 'I' = unsigned 32-bit integer
    except struct.error:
        print(f"Error: {hex_value} could not be converted to a 32-bit word.")
        raise
    
    # Step 3: Extract the first ADC value (lower 16 bits of `word`)
    adcvalue1: int = ((word & 0xFFF0) >> 4)  # Mask lower 16 bits, shift right by 4
    adcvalue1 = s12(adcvalue1)
    
    # Step 4: Extract the second ADC value (upper 16 bits of `word`)
    adcvalue2: int = (((word >> 16) & 0xFFF0) >> 4)  # Shift right 16 bits, mask, then shift right 4 again
    adcvalue2 = s12(adcvalue2)
    
    # Print results
    if debug:
        print(f"Input hex string: 0x{hex_value}")
        print(f"Reconstructed 32-bit word (little-endian): 0x{word:08X}")
        print(f"First ADC value: 0x{adcvalue1:04X}")
        print(f"Second ADC value: 0x{adcvalue2:04X}")
        
    return [adcvalue1, adcvalue2]

def old_process_hex_raw_data(current_event_hex: str):
    # each packet is actually two data points, so split in half 0:4 and 4:8
    # data comes in like f4f3f2f1, with the data first being split, so
    # f4f3 is the first data point and f2f1 is the second
    # then the data is reversed to f3f4 and f1f2
    merge = False
    # merge should most likely be "False", because when I tri
    if merge:
        reversed_hex = current_event_hex[6:8] + current_event_hex[4:6] + current_event_hex[2:4] + current_event_hex[0:2]
        # print(event_number, reversed_hex, int(reversed_hex, 16), s32(int(reversed_hex, 16)))
        
        return reversed_hex
        
        # make a dictionary like raw_data_log = {event_number: {channel_number: [data1, data2, ...]}}
        # it will look like {0: {0: [data1, data2, ...], 1: [data1, data2, ...]}, 1: {0: [data1, data2, ...]}}
        # raw_data_log[event_number] = raw_data_log.setdefault(event_number, {})
        # raw_data_log[event_number][channel_number] = raw_data_log[event_number].get(channel_number, []) + \
        #                                              [s32(int(reversed_hex, 16))]
    else:
        swap = True
        if swap:
            data_hex_one = current_event_hex[2:4] + current_event_hex[0:2]
            data_one = s16(int(data_hex_one, 16))
            data_hex_two = current_event_hex[6:8] + current_event_hex[4:6]
            data_two = s16(int(data_hex_two, 16))
        else:
            # this is proven wrong by trying to plot it, fluctuations in the small bits in this version
            # are way overemphasized, and the sign bit was flipping like crazy
            data_one = s16(int(current_event_hex[0:4], 16))
            data_two = s16(int(current_event_hex[4:8], 16))
        # print(current_event_hex)
        
    return data_one, data_two



if __name__ == "__main__":
    # process_hex_raw_data()
    main(plot=True)
    # count_raw_data_events()
