#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/opt/Xilinx/SDK/2016.2/bin:/opt/Xilinx/Vivado/2016.2/ids_lite/ISE/bin/lin64:/opt/Xilinx/Vivado/2016.2/bin
else
  PATH=/opt/Xilinx/SDK/2016.2/bin:/opt/Xilinx/Vivado/2016.2/ids_lite/ISE/bin/lin64:/opt/Xilinx/Vivado/2016.2/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=/opt/Xilinx/Vivado/2016.2/ids_lite/ISE/lib/lin64
else
  LD_LIBRARY_PATH=/opt/Xilinx/Vivado/2016.2/ids_lite/ISE/lib/lin64:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/amc502_fmc228_f0.runs/synth_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep vivado -log amc502_fmc228_fpga_f0.vds -m64 -mode batch -messageDb vivado.pb -notrace -source amc502_fmc228_fpga_f0.tcl