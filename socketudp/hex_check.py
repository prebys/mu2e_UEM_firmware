#!/usr/bin python3

import sys
import os
import re

# sample of beginning of file:
# ffffffff 00ffffff f4f3f2f1 00ccccfc
# 00000000 2804ac00 fdfdfdfd f4f3f2f1
# 2804ac00 fafa03fa ffff9c10 00000000 ...

# if this contains entries, then the code will ignore the "show" attribute of the event_to_hex dictionary
# and only show the events in this list
only_show = []

event_to_hex = {
    "begin_event": {"re": r"ffffffff", "next": ["begin_sub_event"], "show": True, "data_chars": [0, 0]},
    # ↓　(sub event)
    "begin_sub_event": {"re": r"00ffffff", "next": ["byte_order"], "show": True, "data_chars": [0, 0]},
    "byte_order": {"re": r"f4f3f2f1", "next": ["fmc228_number"], "show": True, "data_chars": [0, 0]},
    "fmc228_number": {"re": r"00ccccfc", "next": ["sub_event_number"], "show": True, "data_chars": [0, 2]},
    "sub_event_number": {"re": r"......\d\d", "next": ["event_number"], "show": True, "data_chars": [0, 8]},
    "event_number": {"re": r"........", "next": ["begin_raw_data"], "show": True, "data_chars": [0, 8]},
    # ↓ ↓　(raw waveform data)
    "begin_raw_data": {"re": r"fdfdfdfd", "next": ["byte_order2"], "show": True, "data_chars": [0, 0]},
    "byte_order2": {"re": r"f4f3f2f1", "next": ["event_number2"], "show": True, "data_chars": [0, 0]},
    "event_number2": {"re": r"........", "next": ["channel_header"], "show": True, "data_chars": [0, 8]},
    # ↓ ↓ ↓　(data of one channel)
    "channel_header": {"re": r"fafa....", "next": ["waveform"], "show": True, "data_chars": [4, 8]},
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
    "end_raw_data": {"re": r"fefefefe", "next": ["begin_peak_stream_data"], "show": True, "data_chars": [0, 0]},
    # ↑ ↑ end of (raw waveform data)
    # ↓ ↓　(peak stream data)
    "begin_peak_stream_data": {"re": r"efefefef", "next": ["channel_number"], "show": True, "data_chars": [0, 0]},
    # ↓ ↓ ↓　(data of one channel)
    "channel_number": {"re": r"eeee....", "next": ["peak_finding_header"], "show": True, "data_chars": [4, 8]},
    "peak_finding_header": {"re": r"aaaaaaaa", "next": ["peak_height_header"], "show": True, "data_chars": [0, 0]},
    "peak_height_header": {"re": r"cccccccc", "next": ["peak_height_data"], "show": True, "data_chars": [0, 0]},
    "peak_height_data": {"re": r"........", "next": ["peak_height_end", "peak_height_data"],
                         "show": False, "data_chars": [0, 8]},
    "peak_height_end": {"re": r"cececece", "next": ["peak_area_header"], "show": True, "data_chars": [0, 0]},
    "peak_area_header": {"re": r"dddddddd", "next": ["peak_area_data"], "show": True, "data_chars": [0, 0]},
    "peak_area_data": {"re": r"........", "next": ["peak_area_end", "peak_area_data"],
                       "show": False, "data_chars": [0, 8]},
    "peak_area_end": {"re": r"dededede", "next": ["end_peak_data"], "show": True, "data_chars": [0, 0]},
    "end_peak_data": {"re": r"bbbbbbbb", "next": ["end_peak_channel"], "show": True, "data_chars": [0, 0]},
    "end_peak_channel": {"re": r"ecececec", "next": ["end_peak_stream_data", "channel_number"], "show": True,
                         "data_chars": [0, 0]},
    # ↑ ↑ ↑ end of (data of one channel)
    "end_peak_stream_data": {"re": r"edededed", "next": ["end_sub_event"], "show": True, "data_chars": [0, 0]},
    # ↑ ↑ end of (peak stream data)
    "end_sub_event": {"re": r"00fcfcfc", "next": ["end_event", "begin_sub_event"], "show": True, "data_chars": [0, 0]},
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
    r"fcfcfcfc": "end_of_event"
}


def main():
    # get directory of the script
    dir = os.path.dirname(os.path.realpath(__file__))

    # get input file either from command line or from the current directory
    if len(sys.argv) == 2:
        input_file = sys.argv[1]
        if input_file.startswith("./"):
            input_file = input_file[2:]
    elif len(sys.argv) == 1:
        # find the file ending in .dat in the current directory
        files = os.listdir(dir)
        dat_files = [file for file in files if file.endswith(".dat")]
        if len(dat_files) == 0:
            print("No .dat files found in the current directory")
            return
        elif len(dat_files) > 1:
            print("Multiple .dat files found in the current directory")
            return
        else:
            input_file = dat_files[0]
    else:
        print("Invalid number of arguments. Usage: `python3 hex_check.py path_to_data_file.dat`")
        return

    # open binary file
    with open(os.path.join(dir, input_file), "rb") as file:
        binary_data = file.read()  # a "bytes" object

    # convert to hex, should be a string starting with "ffffffffffffff00" etc
    hex_data = binary_data.hex()

    to_count = ["begin_event", "begin_sub_event", "begin_raw_data", "begin_peak_stream_data"]
    print("__Event counts__")
    for event in to_count:
        print(f"{event}: {hex_data.count(event_to_hex[event]['re'])}")

    current_event_type = ""
    next_event_candidates = ["begin_event"]
    print("\n\nStart printing of data")
    matched = False
    number_of_printed_logs = 0
    for i in range(0, len(hex_data), 8):
        if number_of_printed_logs > 10000:
            break
        previous_event_type = current_event_type
        current_event_hex = hex_data[i:i + 8]
        if current_event_hex == "ffffffff":
            print(f"[{i//8}] hey, this if ffffffff -----------------------------------")
        if current_event_hex == "fcfcfcfc":
            print(f"[{i//8}] fcfcfcfc!!!! -----------------------------------")

        # if the current event is one of the data streams, check the rest of the checks and check directly
        # for another data event (avoid regex)
        if previous_event_type == "raw_data":
            if current_event_hex == event_to_hex["end_of_channel"]["re"]:
                matched = True
                previous_event_type = "raw_data"
                current_event_type = "end_of_channel"
                next_event_candidates = event_to_hex[current_event_type]["next"]
            else:
                matched = True
                # both previous_event_type and current_event_type are "raw_data"
                pass

        elif previous_event_type == "peak_height_data":
            if current_event_hex == event_to_hex["peak_height_end"]["re"]:
                matched = True
                previous_event_type = "peak_height_data"
                current_event_type = "peak_height_end"
                next_event_candidates = event_to_hex[current_event_type]["next"]
            else:
                matched = True
                # both previous_event_type and current_event_type are "peak_height_data"
                pass

        elif previous_event_type == "peak_area_data":
            if current_event_hex == event_to_hex["peak_area_end"]["re"]:
                matched = True
                previous_event_type = "peak_area_data"
                current_event_type = "peak_area_end"
                next_event_candidates = event_to_hex[current_event_type]["next"]
            else:
                matched = True
                # both previous_event_type and current_event_type are "peak_area_data"
                pass

        else:
            for potential_event_type in next_event_candidates:
                if re.match(event_to_hex[potential_event_type]["re"], current_event_hex):
                    matched = True
                    previous_event_type = current_event_type
                    current_event_type = potential_event_type
                    next_event_candidates = event_to_hex[current_event_type]["next"]
                    break

        if matched:
            # if bco_high went straight to end_of_channel, note that there was no raw_data
            # if previous_event_type == "bco_high" and current_event_type == "end_of_channel":
            #     print("** no raw_data **")

            # note if the previous event was peak_height_data or peak_area_data since those are being omitted
            if previous_event_type in ["peak_height_header", "peak_area_header"] and \
                    current_event_type in ["peak_height_data", "peak_area_data"]:
                print(f"** {current_event_type} omitted **")

            data_start_index = event_to_hex[current_event_type]["data_chars"][0]
            data_end_index = event_to_hex[current_event_type]["data_chars"][1]
            if data_start_index != data_end_index:
                event_type_text = f"{current_event_type}, {current_event_hex[data_start_index:data_end_index]}"
            else:
                event_type_text = f"{current_event_type}"

            if only_show:
                if current_event_type in only_show:
                    number_of_printed_logs += 1
                    print(f"[{i//8}]: {current_event_hex} ({event_type_text})")
            else:
                if event_to_hex[current_event_type]["show"]:
                    number_of_printed_logs += 1
                    print(f"[{i//8}]: {current_event_hex} ({event_type_text})")

        else:
            if current_event_type:
                print(f"**** ERROR ****"
                      f"\n[{i//8}] previous_event_type: {previous_event_type}, current_event_type: {current_event_type}, "
                      f"{current_event_hex} (unknown event)")
                return
            else:  # the first event was not "begin_event" and it's searching for that
                print(f"First event ({current_event_hex}) not 'begin_event', searching for begin_event")


if __name__ == "__main__":
    main()
