import serial
import time

# #######################
#
# CONFIGURE SETTINGS BELOW HERE
#
# #######################

# 1. Trigger mode (7F = ext. trig., FE = one FD, FD = two FD, 00 = anything) (input in hex string)
# Ext. trigger expects, for example, 1.3V positive pulse, 400ns
trigger_setting = "7F"

# 2. Trigger settings
# 0x5DC = 1500ns(?) 
# 0x2710 = 10000ns = 10us (?)
# 0x4E20 = 20000
# 0x7fcad80 = 134 ms (0.134s)
trigger_delay = "0"  # (input in hex string)
# trigger_delay = "0"

# number of subevents per event, setting "3" for example will record subevents 1.0, 1.1, 1.2 (total of 3)
# n_subevn = 20  # counts from 0 to 19 for every event
n_subevn = 2
waveform_length = 100  # number of packets per subevent (two data points per packet)

# 3. Enable FD
adc0_fd_0 = True
adc0_fd_1 = True
adc1_fd_0 = True
adc1_fd_1 = True

# 4. adc_invert
adc0_invert = False
adc1_invert = False

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
fpga_test_mode = 0b0000

# 6. ADC Threshold (max 8192) and Dwell Time Settings (max 65,535)
# at 300/400, lowest negative peak detected was -0.075V
# with testing, threshold 1000 = 149.3mV
lower_threshold = 400
upper_threshold = 500
dwell_time = 5  # in clock cycles (1 ns per cycle)

# #######################
#
# CONFIGURE SETTINGS ABOVE HERE
# (don't modify anything below this line)
#
# #######################

# Serial Port Configuration
SERIAL_PORT = "/dev/ttyUSB0"  # Adjust as needed
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
    ser.write((command + "\n").encode())  # Send over serial
    time.sleep(0.2)  # 200ms delay (equivalent to `usleep 200000`)

# Send commands

# 1. Trigger mode
send_command(f"poke cf00003c {trigger_setting}")

# 2. Trigger settings
send_command(f"poke cf000044 {trigger_delay}")
assert n_subevn > 0
# need subevn + 1 because, for example, setting n_subevn = 3 records events 1.0, 1.1, 1.2, 1.3 (four events)
send_command(f"poke cf00004c {hex(n_subevn - 1)[2:]}")
send_command(f"poke cf000048 {hex(waveform_length)[2:]}")


# 3. Enable FD
def fd_enable(adc, fd0, fd1):
    fd0_binary = 0b000111 if not fd0 else 0
    fd1_binary = 0b111000 if not fd1 else 0
    fd_value = fd0_binary | fd1_binary
    send_command(f"wspi {adc} 40 {hex(fd_value)[2:]}")

fd_enable("adc0", adc0_fd_0, adc0_fd_1)
fd_enable("adc1", adc1_fd_0, adc1_fd_1)

# 4. ADC Invert
if adc0_invert:
    send_command(f"wspi adc0 561 {hex(0b101)[2:]}")
else:
    send_command(f"wspi adc0 561 {hex(0b001)[2:]}")

if adc1_invert:
    send_command(f"wspi adc1 561 {hex(0b101)[2:]}")
else:
    send_command(f"wspi adc1 561 {hex(0b001)[2:]}")

# 5. Test mode
send_command(f"wspi adc0 550 {hex(adc0_test_mode)[2:]}")
send_command(f"wspi adc1 550 {hex(adc1_test_mode)[2:]}")
send_command(f"wspi adc0 573 {hex(jesd0_test_mode)[2:]}")
send_command(f"wspi adc1 573 {hex(jesd1_test_mode)[2:]}")

# FPGA test mode
fpga_test_hex = hex(fpga_test_mode)[2:]
adc_csr_hex = f"0{fpga_test_hex}000001"
send_command(f"poke cf000038 {adc_csr_hex}")

# 6. ADC Threshold and Dwell Time
# Compute register values
lower_threshold_lower = hex(lower_threshold & 0xFF)[2:]
lower_threshold_upper = hex((lower_threshold >> 8) & 0x1F)[2:]

upper_threshold_lower = hex(upper_threshold & 0xFF)[2:]
upper_threshold_upper = hex((upper_threshold >> 8) & 0x1F)[2:]

dwell_time_lower = hex(dwell_time & 0xFF)[2:]
dwell_time_upper = hex((dwell_time >> 8) & 0xFF)[2:]

# Send commands
send_command(f"wspi adc0 249 {lower_threshold_lower}")
send_command(f"wspi adc0 24a {lower_threshold_upper}")
send_command(f"wspi adc1 249 {lower_threshold_lower}")
send_command(f"wspi adc1 24a {lower_threshold_upper}")

send_command(f"wspi adc0 247 {upper_threshold_lower}")
send_command(f"wspi adc0 248 {upper_threshold_upper}")
send_command(f"wspi adc1 247 {upper_threshold_lower}")
send_command(f"wspi adc1 248 {upper_threshold_upper}")

send_command(f"wspi adc0 24B {dwell_time_lower}")
send_command(f"wspi adc0 24C {dwell_time_upper}")
send_command(f"wspi adc1 24B {dwell_time_lower}")
send_command(f"wspi adc1 24C {dwell_time_upper}")


# Close the serial connection
ser.close()
