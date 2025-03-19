import serial
import time
import signal
import sys

def insert_underscores(input_string, interval=4):
    """Insert underscores into a string at a given interval"""
    return '_'.join(input_string[i:i+interval] for i in range(0, len(input_string), interval))

def to_hex(input_string):
    """Convert a binary string to a hex string"""
    return hex(int(input_string, 2))

def get_bits(input_string, high_bit, low_bit = None):
    """Get bits from a string in a VHDL fashion (31 is highest bit)"""
    if low_bit is None:
        return input_string[::-1][high_bit]
    return input_string[::-1][low_bit:high_bit+1]

# cf000000 --> fmc228_csr
# cf000000 <= fmc228_csr(31 downto 24) & adc_fd_r & fmc228_csr(19 downto 18) & trig_in & trig_busy &
#             lmk_sysref_req & fmc228_csr(14 downto 12) & hmc_ldo & fmc228_csr(10 downto 5) &
#             lmk_status_ld & fmc228_csr(2 downto 0);
# fmc228_csr(31) == lmk_reset
# fmc228_csr(30) == jesd204_sys_reset
# fmc228_csr(23 downto 20) == adc_fd_r(3 downto 0)
# fmc228_csr(17) == trig_in
# fmc228_csr(16) == trig_busy
# fmc228_csr(15) == lmk_sysref_req
# fmc228_csr(11) == hmc_ldo
# fmc228_csr(10) == adc_pdwn(1);
# fmc228_csr(9) == adc_pdwn(0);
# fmc228_csr(8) == hmc_chip_en;
# fmc228_csr(7) == lmk_sync;
# fmc228_csr(5) == lmk_clkoe;
# fmc228_csr(4 downto 3) == lmk_status_ld(1 downto 0)

# cf000038 --> adc_buffer_csr
# bs_imp : adc_buffer_streamer port map ( rst => adc_buffer_csr(31), ...
# bs_imp : adc_buffer_streamer port map ( testmode => adc_buffer_csr(27 downto 24), ...
# peakst_imp : peakdata_stream port map ( rst => adc_buffer_csr(31), ...
# ev_imp : event_module port map ( rst => adc_buffer_csr(31), ...
# adc_buffer_csr(31) == adc_buffer_rst
# adc_buffer_csr(27 downto 24) == adc_buffer_testmode

# amc502_csr (c0000000):
# not 31  :  pll_rst_n
# 30      :  sysclk_sel
# 25  : slave pll reset
# 24  : master pll reset
# 17 : bco_count_reset
# 16 : bco_count_enabled
# 11~8 : tclka_counter sel
# 7       :  uled_select
# 2 : uled(2)
# 1 : uled(1)
# 0 : uled(0)

# Serial port configuration
SERIAL_PORT = "/dev/ttyUSB0"
BAUD_RATE = 115200

# Open serial connection
ser = serial.Serial(SERIAL_PORT, BAUD_RATE, timeout=1)

def cleanup(signal_received=None, frame=None, silent=False):
    """Cleanup function to handle Ctrl+C"""
    if not silent:
        print("Cleaning up...")
    ser.close()
    sys.exit(0)

# Register SIGINT (Ctrl+C) signal handler
signal.signal(signal.SIGINT, cleanup)

# Ensure serial port is open
if not ser.is_open:
    ser.open()

# Small delay to ensure readiness
time.sleep(0.2)

def get_data(command: str):
    # Send command
    ser.write(command.encode())
    
    # Wait for response
    time.sleep(0.2)
    
    # Read response
    response_lines = ser.readlines()  # Reads all available lines
    hex_string = ""
    
    for line in response_lines:
        decoded_line = line.decode().strip()
        if " = " in decoded_line:
            hex_string = decoded_line.split(" = ")[1]  # Extract value after '='
    
    if not hex_string:
        raise ValueError(f"Failed to get data for command: {command} ({hex_string}")
    
    # hex_string is a hex string like "abcdef12", convert to binary string
    binary_string = bin(int(hex_string, 16))[2:].zfill(32)
    
    return hex_string, binary_string


def main(memory_address, memory_name, data_dict):
    hex_string, binary_string = get_data(f"peek {memory_address}\n")
    print(f"{memory_name} values: {insert_underscores(hex_string)} "
          f"({insert_underscores(binary_string)})")
    
    for key, (high_bit, low_bit) in data_dict.items():
        b = get_bits(binary_string, high_bit, low_bit)
        if len(b) == 1:
            print(f"[{high_bit}] {key}: {b}")
        else:
            print(f"[{high_bit}:{low_bit}] {key}: {b} ({to_hex(b)})")
            
    print()
    print()
            
fmc_228_data = {
    "lmk_reset": (31, 31),
    "jesd204_sys_reset": (30, 30),
    "adc_fd_r": (23, 20),
    "trig_in": (17, 17),
    "trig_busy": (16, 16),
    "lmk_sysref_req": (15, 15),
    "hmc_ldo": (11, 11),
    "adc_pdwn(1)": (10, 10),
    "adc_pdwn(0)": (9, 9),
    "hmc_chip_en": (8, 8),
    "lmk_sync": (7, 7),
    "lmk_clkoe": (5, 5),
    "lmk_status_ld": (4, 3)
}

adc_buffer_data = {
    "adc_buffer_rst": (31, 31),
    "adc_buffer_testmode": (27, 24)
}

amc_502_data = {
    "pll_rst_n": (31, 31),
    "sysclk_sel": (30, 30),
    "slave_pll_reset": (25, 25),
    "master_pll_reset": (24, 24),
    "bco_count_reset": (17, 17),
    "bco_count_enabled": (16, 16),
    "tclka_counter_sel": (11, 8),
    "uled_select": (7, 7),
    "uled": (2, 0)
}

# gbe_csr c1000000
gbe_data = {
    "gbe_reset": (30, 30),
    "reset_done": (29, 29),
    "mmcm_locked": (28, 28),
    "gbe_int": (16, 16)
}

# arp_csr c1000044
arp_data = {
    "sendpkt_arptab_read_strobe": (27, 27),
    "sendpkt_arpreq_strobe": (26, 26),
    "arptab_missing": (25, 25),
    "arptab_found": (24, 24),
    "arptab_size": (23, 16),
    "arptab_entries": (15, 8)
}

# streampkt_status: c1000080
streampkt_status_data = {
    "streampkt_buffer_free": (31, 16),
    "streampkt_lost_packets": (15, 0)
}

# streampkt_buffer c100007c
streampkt_buffer_data = {
    "streampkt_buffer_cksum": (31, 16),
    "streampkt_buffer_length": (15, 0)
}

fei4_interface_data_one = {}
# c8000000 --> fei4_interface_csr

fei4_interface_data_two = {}
# c8000004 --> fei4_interface_csr

try:
    main("cf000000", "fmc228_csr", fmc_228_data)
    main("cf000038", "adc_buffer_csr", adc_buffer_data)
    main("c0000000", "amc502_csr", amc_502_data)
    main("c8000000", "fei4_interface_csr", fei4_interface_data_one)
    main("c8000004", "fei4_interface_csr", fei4_interface_data_two)
    main("c1000000", "gbe_csr", gbe_data)
    main("c1000044", "arp_csr", arp_data)
    main("c1000080", "streampkt_status", streampkt_status_data)
    main("c100007c", "streampkt_buffer", streampkt_buffer_data)
finally:
    cleanup()

# Cleanup
cleanup(silent=True)


