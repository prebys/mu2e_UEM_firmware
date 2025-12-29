#!/bin/bash

# Name of the Tcl script
TCL_SCRIPT="compile_bitfile.tcl"

# Name of the output log file
LOG_FILE="vivado_batch_run.log"

# Check if the TCL script exists
if [ ! -f "$TCL_SCRIPT" ]; then
  echo "Error: Tcl script '$TCL_SCRIPT' not found in the current directory."
  exit 1
fi

# Run Vivado in batch mode with nohup
echo "Starting Vivado batch run..."
nohup vivado -mode batch -source "$TCL_SCRIPT" > "$LOG_FILE" 2>&1 &

# Get the PID of the background job
PID=$!
echo "Vivado started in background with PID $PID."
echo "Log file: $LOG_FILE"
echo "Use 'tail -f $LOG_FILE' to monitor progress. For now, I'll do that."

# tail -f $LOG_FILE
