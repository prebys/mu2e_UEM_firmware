import sys
print(sys.version)

import serial
import time

# #######################
#
# CONFIGURE SETTINGS BELOW HERE
#
# #######################

# 1. Trigger mode (7F = ext. trig., FE = one FD, FD = two FD, 00 = anything) (input in hex string)
# Ext. trigger expects, for example, 1.3V positive pulse, 400ns
# Something like 18ns is actually too *short* maybe so be careful
# If you split the trigger output from signal generator in two, it decreases voltage
#     so do something like 1.9V for that (when splitting)
trigger_setting = "7F"

# 2. Trigger settings
# each clock is 4ns, trigger_delay is in units of clock cycles
# so for example, settings trigger_delay = 3000 will correspond to 
# 12,000 ns of peak finding, if it doesn't hit the peak limit set below first

# 0x5DC = 1500ns(?)
# 0x2710 = 10000ns = 10us (?)
# 0x4E20 = 20000
# 0x3B9ACA00 = 1s
# 0x1DCD6500 = 500 ms
# 0x11E1A300 = 300 ms (0.3 * 50 = 15s max event time?)
# 0x07fcad80 = 134 ms
# 0x05f5E100 = 100 ms 
trigger_delay = 0x11E1A300
# trigger_delay = "0"

# number of subevents per event, setting "3" for example will record subevents 1.0, 1.1, 1.2 (total of 3)
# n_subevn = 20  # counts from 0 to 19 for every event
n_subevn = 100
waveform_length = 0  # number of packets per subevent (two data points per packet)
# two data points per packet: a setting of "100" gives 200ns of data

# 5. Test mode (0000=off, 0001=midscale short, 1111=ramp) (input in binary)
# There's the AD9234 test mode (0x550) and JESD204B test mode (0x573)
# AD9234 test mode comes first in the datachain, and for example the ramp will be a full
# 16-bit ramp.
# The JESD204B test mode is the one that is used to test the datachain,
# and it will be a 12-bit ramp.
adc0_test_mode = 0b0000
adc1_test_mode = 0b0000
jesd0_test_mode = 0b0000
jesd1_test_mode = 0b0000

# FPGA test mode: 0000: normal, 0001: checkerboard, 0010: 0xFFFF0000, 1001: data_adc_length value (ramp)
# 1010: triangle wave
fpga_test_mode = 0b0000

# 6. ADC Threshold (max 8192) and Dwell Time Settings (max 65,535)
# at 300/400, lowest negative peak detected was -0.075V
# with testing, threshold 1000 = 149.3mV
# About threshold:
# ADC values go from -2048 to +2047
# The threshold is set from 0 to 8195
# Therefore, to convert a threshold value to an ADC value, DIVIDE BY 4
# For example, setting upper threshold to 200 will allow any signal with an ADC value greater than 200 / 4 = 50
# If you want to only allow ADC signals greater than 400, you should set the upper threshold to 400 * 4 = 1600
lower_threshold = 200
upper_threshold = 500
dwell_time = 4  # in clock cycles (1 ns per cycle)

# 7. Peakfinding threshold
# Input four character hex, for example, B000 = -20480
peakfinding_thr = -100
n_peaks = 50
# Peakhigh count (number of events for peak height packets)
# Two peak high packets per event, so total number of peaks is count/2
# (Default: 84)
peakhigh_count = n_peaks * 2  # 84/2 = 42 peaks allowed
# Peakarea count (number of events for peak area packets)
# Six peak area packets per ecent, so total number of peaks is count/6
# (Default: 252)
peakarea_count = n_peaks * 6


# LOG CURRENT SETTINGS
to_log_data = {
    "Peakfinding Length": trigger_delay,
    "Number of subevents": n_subevn,
    "Raw Data Length": waveform_length,
    "Peakfinding Threshold": peakfinding_thr,
    "Peak height event count": peakhigh_count,
    "Peak area event count": peakarea_count,
    "FPGA Test Mode": fpga_test_mode,
}

# #######################
#
# CONFIGURE SETTINGS ABOVE HERE
# (don't modify anything below this line)
#
# #######################

# Serial Port Configuration
SERIAL_PORT = "/dev/ttyUSB_FMC228"  # Adjust as needed
BAUD_RATE = 115200  # Adjust to match your device's baud rate

# Open the serial connection
ser = serial.Serial(SERIAL_PORT, BAUD_RATE, timeout=1)

# Check if the serial connection is open
if not ser.is_open:
    print("Serial port is not open. Exiting...")
    exit()

# Function to send command to serial console
def send_command(command):
    print(f"Sending: {command}")  # Print for debugging
    ser.write((command + "\r").encode())  # Send over serial
    time.sleep(0.2)  # 200ms delay (equivalent to `usleep 200000`)
    
def dec_to_hex(dec_in: int, bytes: int = 2) -> str:
    """Convert decimal to signed hex string (2's complement)."""
    return dec_in.to_bytes(bytes, byteorder='big', signed=True).hex()

assert dec_to_hex(-20480) == "b000"
assert dec_to_hex(20999) == "5207"
assert dec_to_hex(-20480, 4) == "ffffb000"
assert dec_to_hex(0x7fcad80, 4) == "07fcad80"

# Send commands

# 1. Trigger mode
send_command(f"poke cf00003c {trigger_setting}   -- trigger mode")

# 2. Trigger settings
send_command(f"poke cf000044 {dec_to_hex(trigger_delay, 4)}   -- Peakfinding length")
assert n_subevn > 0
# need subevn - 1 because, for example, setting n_subevn = 3 records events 1.0, 1.1, 1.2, 1.3 (four events)
send_command(f"poke cf00004c {dec_to_hex(n_subevn - 1)}   -- number of subevents")
send_command(f"poke cf000048 {dec_to_hex(waveform_length + 1)}   -- Raw data length")

# 5. Test mode
send_command(f"wspi adc0 550 {hex(adc0_test_mode)[2:]}   -- ADC0 test mode")
send_command(f"wspi adc1 550 {hex(adc1_test_mode)[2:]}   -- ADC1 test mode")
send_command(f"wspi adc0 573 {hex(jesd0_test_mode)[2:]}   -- JESD204B(0) test mode")
send_command(f"wspi adc1 573 {hex(jesd1_test_mode)[2:]}   -- JESD204B(1) test mode")

# FPGA test mode
fpga_test_hex = hex(fpga_test_mode)[2:]
adc_csr_hex = f"0{fpga_test_hex}000001"
send_command(f"poke cf000038 {adc_csr_hex}   -- FPGA test mode")

# 6. ADC Threshold and Dwell Time
# Compute register values
lower_threshold_lower = hex(lower_threshold & 0xFF)[2:]
lower_threshold_upper = hex((lower_threshold >> 8) & 0x1F)[2:]

upper_threshold_lower = hex(upper_threshold & 0xFF)[2:]
upper_threshold_upper = hex((upper_threshold >> 8) & 0x1F)[2:]

dwell_time_lower = hex(dwell_time & 0xFF)[2:]
dwell_time_upper = hex((dwell_time >> 8) & 0xFF)[2:]

# Send commands
send_command(f"wspi adc0 249 {lower_threshold_lower}   -- lower threshold lower bits")
send_command(f"wspi adc0 24a {lower_threshold_upper}   -- lower threshold upper bits")
send_command(f"wspi adc1 249 {lower_threshold_lower}   -- lower threshold lower bits")
send_command(f"wspi adc1 24a {lower_threshold_upper}   -- lower threshold upper bits")

send_command(f"wspi adc0 247 {upper_threshold_lower}   -- upper threshold lower bits")
send_command(f"wspi adc0 248 {upper_threshold_upper}   -- upper threshold upper bits")
send_command(f"wspi adc1 247 {upper_threshold_lower}   -- upper threshold lower bits")
send_command(f"wspi adc1 248 {upper_threshold_upper}   -- upper threshold upper bits")

send_command(f"wspi adc0 24B {dwell_time_lower}   -- dwell time lower bits")
send_command(f"wspi adc0 24C {dwell_time_upper}   -- dwell time upper bits")
send_command(f"wspi adc1 24B {dwell_time_lower}   -- dwell time lower bits")
send_command(f"wspi adc1 24C {dwell_time_upper}   -- dwell time upper bits")

# 7. Peakfinding threshold
send_command(f"poke cf000050 {dec_to_hex(peakfinding_thr)}   -- peakfinding thr")
send_command(f"poke cf000054 {dec_to_hex(peakhigh_count - 1)}   -- peak high count")
send_command(f"poke cf000058 {dec_to_hex(peakarea_count - 1)}   -- peak area count")


# LOG CURRENT SETTINGS
with open("../socketudp/current_adc_settings.txt", "w") as f:
    for i, j in to_log_data.items():
        f.write(f"{i}: {j}\n")





# OLD ARCHIVED SETTING OPTIONS

enable_old_settings = True

if enable_old_settings:
    
    # 3. Enable FD
    adc0_fd_0 = True
    adc0_fd_1 = True
    adc1_fd_0 = True
    adc1_fd_1 = True
    
    # 4. adc_invert
    adc0_invert = False
    adc1_invert = False
    
    # 3. Enable FD
    def fd_enable(adc, fd0, fd1):
        if not fd0:
            print(f"WARNING: Disabling {adc} FD_0")
        if not fd1:
            print(f"WARNING: Disabling {adc} FD_1")
        fd0_binary = 0b000111 if not fd0 else 0
        fd1_binary = 0b111000 if not fd1 else 0
        fd_value = fd0_binary | fd1_binary
        send_command(f"wspi {adc} 40 {dec_to_hex(fd_value)}")
    
    fd_enable("adc0", adc0_fd_0, adc0_fd_1)
    fd_enable("adc1", adc1_fd_0, adc1_fd_1)
    
    # 4. ADC Invert
    if adc0_invert:
        send_command(f"wspi adc0 561 {dec_to_hex(0b101)}")
    else:
        send_command(f"wspi adc0 561 {dec_to_hex(0b001)}")
    
    if adc1_invert:
        send_command(f"wspi adc1 561 {dec_to_hex(0b101)}")
    else:
        send_command(f"wspi adc1 561 {dec_to_hex(0b001)}")

print("DISABLING ADC1_B (channel 4)")
send_command("wspi adc1 008 2")
send_command("wspi adc1 015 1")  # disable
# send_command("wspi adc1 015 0")  # enable
send_command("wspi adc1 008 3")

# Close the serial connection
ser.close()
