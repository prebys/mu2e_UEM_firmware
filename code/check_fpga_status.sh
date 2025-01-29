#!/bin/bash

# Set serial port configuration
# stty -F /dev/ttyUSB0 1:0:1cb2:0:0:0:0:0:0:5:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0
# stty -F /dev/ttyUSB0 -echo
stty -F /dev/ttyUSB0 115200 cs8 -parenb -cstopb

OUTPUT_FILE="serial_output.log"

# Start capturing serial output in the background
cat /dev/ttyUSB0 > "$OUTPUT_FILE" &
CAT_PID=$!
echo "cat started: $CAT_PID"

# Cleanup function to handle SIGINT
cleanup() {
    echo "Cleaning up..."
    kill $CAT_PID
    wait $CAT_PID 2>/dev/null
    exit 0
}

# Trap SIGINT (Ctrl+C) to execute cleanup
trap cleanup SIGINT

sleep 1

# Send command
echo "peek cf000038" > /dev/ttyUSB0
sleep 1

# Ensure the file is ready before reading
sleep 1  # Wait for output to be captured

# Read response
RESPONSE=$(cat "$OUTPUT_FILE" | tr -d '\r')
RESPONSE=$(grep " = " serial_output.log | awk '{print $3}')
echo "Received: $RESPONSE"

# Call cleanup function properly
cleanup

