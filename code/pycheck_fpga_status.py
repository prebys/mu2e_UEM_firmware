import serial
import time
import signal
import sys

# Serial port configuration
SERIAL_PORT = "/dev/ttyUSB0"
BAUD_RATE = 115200

# Open serial connection
ser = serial.Serial(SERIAL_PORT, BAUD_RATE, timeout=1)

def cleanup(signal_received=None, frame=None):
    """Cleanup function to handle Ctrl+C"""
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

# Send command
command = "peek cf000038\n"  # Ensure newline for proper command execution
ser.write(command.encode())

# Wait for response
time.sleep(0.2)

# Read response
response_lines = ser.readlines()  # Reads all available lines
filtered_response = ""

for line in response_lines:
    decoded_line = line.decode().strip()
    if " = " in decoded_line:
        filtered_response = decoded_line.split(" = ")[1]  # Extract value after '='

print(f"Received: {filtered_response}")

# Cleanup
cleanup()

