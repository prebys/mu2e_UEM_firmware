proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  open_checkpoint amc502_fmc228_fpga_f0_routed.dcp
  set_property webtalk.parent_dir /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_example/vada_exaple/amc502_fmc228_f0.cache/wt [current_project]
  add_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_example/vada_exaple/sources/sdk/fmc228_tool/Debug/fmc228_tool.elf
  set_property SCOPED_TO_REF design_1 [get_files -all /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_example/vada_exaple/sources/sdk/fmc228_tool/Debug/fmc228_tool.elf]
  set_property SCOPED_TO_CELLS microblaze_0 [get_files -all /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_example/vada_exaple/sources/sdk/fmc228_tool/Debug/fmc228_tool.elf]
  catch { write_mem_info -force amc502_fmc228_fpga_f0.mmi }
  catch { write_bmm -force amc502_fmc228_fpga_f0_bd.bmm }
  write_bitstream -force amc502_fmc228_fpga_f0.bit -bin_file
  catch { write_sysdef -hwdef amc502_fmc228_fpga_f0.hwdef -bitfile amc502_fmc228_fpga_f0.bit -meminfo amc502_fmc228_fpga_f0.mmi -file amc502_fmc228_fpga_f0.sysdef }
  catch {write_debug_probes -quiet -force debug_nets}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

