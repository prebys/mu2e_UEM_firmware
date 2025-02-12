# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7k420tffg1156-2

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.cache/wt [current_project]
set_property parent.project_path /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.xpr [current_project]
set_property XPM_LIBRARIES XPM_MEMORY [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
read_ip -quiet /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/fei4_pixel_fifo/fei4_pixel_fifo.xci
set_property is_locked true [get_files /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/fei4_pixel_fifo/fei4_pixel_fifo.xci]

foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top fei4_pixel_fifo -part xc7k420tffg1156-2 -mode out_of_context

rename_ref -prefix_all fei4_pixel_fifo_

write_checkpoint -force -noxdef fei4_pixel_fifo.dcp

catch { report_utilization -file fei4_pixel_fifo_utilization_synth.rpt -pb fei4_pixel_fifo_utilization_synth.pb }

if { [catch {
  file copy -force /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.runs/fei4_pixel_fifo_synth_1/fei4_pixel_fifo.dcp /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/fei4_pixel_fifo/fei4_pixel_fifo.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  write_verilog -force -mode synth_stub /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/fei4_pixel_fifo/fei4_pixel_fifo_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode synth_stub /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/fei4_pixel_fifo/fei4_pixel_fifo_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_verilog -force -mode funcsim /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/fei4_pixel_fifo/fei4_pixel_fifo_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode funcsim /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/fei4_pixel_fifo/fei4_pixel_fifo_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if {[file isdir /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.ip_user_files/ip/fei4_pixel_fifo]} {
  catch { 
    file copy -force /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/fei4_pixel_fifo/fei4_pixel_fifo_stub.v /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.ip_user_files/ip/fei4_pixel_fifo
  }
}

if {[file isdir /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.ip_user_files/ip/fei4_pixel_fifo]} {
  catch { 
    file copy -force /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/fei4_pixel_fifo/fei4_pixel_fifo_stub.vhdl /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.ip_user_files/ip/fei4_pixel_fifo
  }
}
