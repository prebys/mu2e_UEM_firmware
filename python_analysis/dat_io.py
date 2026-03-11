import os
import sys
from datetime import datetime

from python_analysis.hex_check_config import config


def find_data_file(desired_file_path, to_use_index_increment: int = 0) -> str:
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

    dir_name: str = os.path.dirname(os.path.realpath(__file__)).replace("\\", "/")
    data_dir = os.path.join(dir_name, "../socketudp/data").replace("\\", "/")
    files = os.listdir(data_dir)
    dat_files = sorted(
        [file for file in files if file.endswith(".dat") and desired_file_path in file],
        key=lambda x: os.path.getctime(f"{data_dir}/{x}"))
    if len(dat_files) == 0:
        raise ValueError("No .dat files found in the current directory matching search")
    elif len(dat_files) > 1:
        input_file_name = dat_files[-config.to_use_file_index - to_use_index_increment]
        print(f"⚠️⚠️ Info: Multiple .dat files found in the current directory. "
              f"Picking this one ({input_file_name}) ⚠️⚠️")
    else:
        input_file_name = dat_files[0]
    return input_file_name


def read_data_file(dir_name, file_name) -> tuple[bytes, datetime, list[str]]:
    headers = []
    data_file_path = os.path.join(dir_name, "..", "socketudp", "data", file_name)
    assert os.path.exists(data_file_path), f"File at {data_file_path} does not exist."

    if os.path.getsize(data_file_path) == 0:
        raise ValueError(f"File at {data_file_path} is empty.")

    with open(data_file_path, "rb") as file:
        for line in file:
            if line.startswith(b"#"):
                headers.append(line.decode().strip())
            else:
                break
        binary_data = line + file.read()
        file_creation_date = datetime.fromtimestamp(os.path.getctime(file.name))

    if len(binary_data) % 4 != 0:
        pattern = b'\xff\xff\xff\xff\x00\xff\xff\xff\xf4\xf3\xf2\xf1'
        last_match = binary_data.rfind(pattern)
        if last_match != -1:
            cut_len = len(binary_data) - last_match
            full_len = len(binary_data)
            binary_data = binary_data[:last_match]
            print(
                f"⚠️⚠️ Truncated binary data to last valid event start at index {last_match}. "
                f"Cut last {cut_len / full_len * 100:.2f}% of data. ⚠️⚠️")

    return binary_data, file_creation_date, headers