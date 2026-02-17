import os
import re
import sys
from datetime import datetime

from python_analysis.hex_check_config import config


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
    dir_name: str = os.path.dirname(os.path.realpath(__file__)).replace("\\",
                                                                        "/")  # Directory of the script
    
    # create qualified name link to data directory at ../socketudp/data
    data_dir = os.path.join(dir_name, "../socketudp/data").replace("\\", "/")
    files = os.listdir(data_dir)
    dat_files = sorted(
        [file for file in files if file.endswith(".dat") and desired_file_path in file],
        key=lambda x: os.path.getctime(f"{data_dir}/{x}"))
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
    data_file_path = os.path.join(dir_name, "..", "socketudp", "data", file_name)
    assert os.path.exists(data_file_path), f"File at {data_file_path} does not exist."

    # check to make sure file has content
    if os.path.getsize(data_file_path) == 0:
        raise ValueError(f"File at {data_file_path} is empty.")

    with open(data_file_path, "rb") as file:
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
            print(
                f"⚠️⚠️ Truncated hex data to last valid event ending at index {last_match.end()}. "
                f"Cut last {cut_len / full_len * 100:.2f}% of data. ⚠️⚠️")
    
    hex_data_list = [hex_data[i:i + 8] for i in range(0, len(hex_data), 8)]
    
    return hex_data_list, file_creation_date, headers