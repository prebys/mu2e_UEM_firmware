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

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/amc502_fmc228_f0.cache/wt [current_project]
  set_property parent.project_path /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/amc502_fmc228_f0.xpr [current_project]
  set_property ip_repo_paths {
  /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/amc502_fmc228_f0.cache/ip
  /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/common/ip_repo/fsl_elbc_axi4lite_bridge
} [current_project]
  set_property ip_output_repo /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/amc502_fmc228_f0.cache/ip [current_project]
  set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
  add_files -quiet /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/amc502_fmc228_f0.runs/synth_1/amc502_fmc228_fpga_f0.dcp
  add_files -quiet /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/axi_crossbar_0/axi_crossbar_0.dcp
  set_property netlist_only true [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/axi_crossbar_0/axi_crossbar_0.dcp]
  add_files -quiet /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/ila_0/ila_0.dcp
  set_property netlist_only true [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/ila_0/ila_0.dcp]
  add_files -quiet /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/fifo_generator_0/fifo_generator_0.dcp
  set_property netlist_only true [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/fifo_generator_0/fifo_generator_0.dcp]
  add_files -quiet /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/jesd204_0_phy/jesd204_0_phy.dcp
  set_property netlist_only true [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/jesd204_0_phy/jesd204_0_phy.dcp]
  add_files -quiet /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/jesd204_0/jesd204_0.dcp
  set_property netlist_only true [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/jesd204_0/jesd204_0.dcp]
  add_files -quiet /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/amc502_fmc228_f0.srcs/sources_1/ip/jesd204_1/jesd204_1.dcp
  set_property netlist_only true [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/amc502_fmc228_f0.srcs/sources_1/ip/jesd204_1/jesd204_1.dcp]
  add_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/design_1.bmm
  set_property SCOPED_TO_REF design_1 [get_files -all /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/design_1.bmm]
  add_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/sdk/fmc228_tool/Debug/fmc228_tool.elf
  set_property SCOPED_TO_REF design_1 [get_files -all /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/sdk/fmc228_tool/Debug/fmc228_tool.elf]
  set_property SCOPED_TO_CELLS microblaze_0 [get_files -all /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/sdk/fmc228_tool/Debug/fmc228_tool.elf]
  read_xdc -ref design_1_axi_pcie_0_0 -cells U0 /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_axi_pcie_0_0/design_1_axi_pcie_0_0/source/axi_pcie_X0Y0.xdc
  set_property processing_order EARLY [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_axi_pcie_0_0/design_1_axi_pcie_0_0/source/axi_pcie_X0Y0.xdc]
  read_xdc -prop_thru_buffers -ref design_1_axi_uartlite_0_0 -cells U0 /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_axi_uartlite_0_0/design_1_axi_uartlite_0_0_board.xdc
  set_property processing_order EARLY [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_axi_uartlite_0_0/design_1_axi_uartlite_0_0_board.xdc]
  read_xdc -ref design_1_axi_uartlite_0_0 -cells U0 /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_axi_uartlite_0_0/design_1_axi_uartlite_0_0.xdc
  set_property processing_order EARLY [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_axi_uartlite_0_0/design_1_axi_uartlite_0_0.xdc]
  read_xdc -ref design_1_mdm_1_0 -cells U0 /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_mdm_1_0/design_1_mdm_1_0.xdc
  set_property processing_order EARLY [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_mdm_1_0/design_1_mdm_1_0.xdc]
  read_xdc -ref design_1_microblaze_0_0 -cells U0 /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_microblaze_0_0/design_1_microblaze_0_0.xdc
  set_property processing_order EARLY [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_microblaze_0_0/design_1_microblaze_0_0.xdc]
  read_xdc -prop_thru_buffers -ref design_1_rst_clk_wiz_1_100M_0 -cells U0 /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_rst_clk_wiz_1_100M_0/design_1_rst_clk_wiz_1_100M_0_board.xdc
  set_property processing_order EARLY [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_rst_clk_wiz_1_100M_0/design_1_rst_clk_wiz_1_100M_0_board.xdc]
  read_xdc -ref design_1_rst_clk_wiz_1_100M_0 -cells U0 /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_rst_clk_wiz_1_100M_0/design_1_rst_clk_wiz_1_100M_0.xdc
  set_property processing_order EARLY [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_rst_clk_wiz_1_100M_0/design_1_rst_clk_wiz_1_100M_0.xdc]
  read_xdc -ref design_1_dlmb_v10_0 -cells U0 /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_dlmb_v10_0/design_1_dlmb_v10_0.xdc
  set_property processing_order EARLY [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_dlmb_v10_0/design_1_dlmb_v10_0.xdc]
  read_xdc -ref design_1_ilmb_v10_0 -cells U0 /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_ilmb_v10_0/design_1_ilmb_v10_0.xdc
  set_property processing_order EARLY [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_ilmb_v10_0/design_1_ilmb_v10_0.xdc]
  read_xdc -mode out_of_context -ref axi_crossbar_0 -cells inst /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/axi_crossbar_0/axi_crossbar_0_ooc.xdc
  set_property processing_order EARLY [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/axi_crossbar_0/axi_crossbar_0_ooc.xdc]
  read_xdc -mode out_of_context -ref ila_0 -cells U0 /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/ila_0/ila_0_ooc.xdc
  set_property processing_order EARLY [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/ila_0/ila_0_ooc.xdc]
  read_xdc -ref ila_0 -cells U0 /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/ila_0/ila_v6_1/constraints/ila.xdc
  set_property processing_order EARLY [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/ila_0/ila_v6_1/constraints/ila.xdc]
  read_xdc -mode out_of_context -ref fifo_generator_0 -cells U0 /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/fifo_generator_0/fifo_generator_0_ooc.xdc
  set_property processing_order EARLY [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/fifo_generator_0/fifo_generator_0_ooc.xdc]
  read_xdc -ref fifo_generator_0 -cells U0 /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/fifo_generator_0/fifo_generator_0/fifo_generator_0.xdc
  set_property processing_order EARLY [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/fifo_generator_0/fifo_generator_0/fifo_generator_0.xdc]
  read_xdc -mode out_of_context -ref jesd204_0_phy -cells inst /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/jesd204_0_phy/synth/jesd204_0_phy_ooc.xdc
  set_property processing_order EARLY [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/jesd204_0_phy/synth/jesd204_0_phy_ooc.xdc]
  read_xdc -ref jesd204_0_phy_gt -cells U0 /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/jesd204_0_phy/ip_0/jesd204_0_phy_gt.xdc
  set_property processing_order EARLY [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/jesd204_0_phy/ip_0/jesd204_0_phy_gt.xdc]
  read_xdc -ref jesd204_0_phy -cells inst /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/jesd204_0_phy/synth/jesd204_0_phy.xdc
  set_property processing_order EARLY [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/jesd204_0_phy/synth/jesd204_0_phy.xdc]
  read_xdc -mode out_of_context -ref jesd204_0 -cells inst /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/jesd204_0/synth/jesd204_0_ooc.xdc
  set_property processing_order EARLY [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/jesd204_0/synth/jesd204_0_ooc.xdc]
  read_xdc -ref jesd204_0 -cells inst /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/jesd204_0/synth/jesd204_0.xdc
  set_property processing_order EARLY [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/jesd204_0/synth/jesd204_0.xdc]
  read_xdc -mode out_of_context -ref jesd204_1 -cells inst /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/amc502_fmc228_f0.srcs/sources_1/ip/jesd204_1/synth/jesd204_1_ooc.xdc
  set_property processing_order EARLY [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/amc502_fmc228_f0.srcs/sources_1/ip/jesd204_1/synth/jesd204_1_ooc.xdc]
  read_xdc -ref jesd204_1 -cells inst /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/amc502_fmc228_f0.srcs/sources_1/ip/jesd204_1/synth/jesd204_1.xdc
  set_property processing_order EARLY [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/amc502_fmc228_f0.srcs/sources_1/ip/jesd204_1/synth/jesd204_1.xdc]
  read_xdc /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/amc502_pins_f0.xdc
  read_xdc /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/amc502_impl_f0.xdc
  read_xdc -ref design_1_auto_cc_0 -cells inst /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_auto_cc_0/design_1_auto_cc_0_clocks.xdc
  set_property processing_order LATE [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_auto_cc_0/design_1_auto_cc_0_clocks.xdc]
  read_xdc -ref design_1_auto_cc_1 -cells inst /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_auto_cc_1/design_1_auto_cc_1_clocks.xdc
  set_property processing_order LATE [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_auto_cc_1/design_1_auto_cc_1_clocks.xdc]
  read_xdc -ref design_1_auto_ds_0 -cells inst /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_auto_ds_0/design_1_auto_ds_0_clocks.xdc
  set_property processing_order LATE [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/bd/design_1/ip/design_1_auto_ds_0/design_1_auto_ds_0_clocks.xdc]
  read_xdc -ref fifo_generator_0 -cells U0 /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/fifo_generator_0/fifo_generator_0/fifo_generator_0_clocks.xdc
  set_property processing_order LATE [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/fifo_generator_0/fifo_generator_0/fifo_generator_0_clocks.xdc]
  read_xdc -ref jesd204_0_phy -cells inst /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/jesd204_0_phy/synth/jesd204_0_phy_clocks.xdc
  set_property processing_order LATE [get_files /disk2/data/tmnguyen/mu2e_monitor_firmware_original/Vadatech_fmc228_example/VivadoReferenceDesignR2/sources/amc502/ip/jesd204_0_phy/synth/jesd204_0_phy_clocks.xdc]
  link_design -top amc502_fmc228_fpga_f0 -part xc7k420tffg1156-2
  write_hwdef -file amc502_fmc228_fpga_f0.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force amc502_fmc228_fpga_f0_opt.dcp
  report_drc -file amc502_fmc228_fpga_f0_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force amc502_fmc228_fpga_f0_placed.dcp
  report_io -file amc502_fmc228_fpga_f0_io_placed.rpt
  report_utilization -file amc502_fmc228_fpga_f0_utilization_placed.rpt -pb amc502_fmc228_fpga_f0_utilization_placed.pb
  report_control_sets -verbose -file amc502_fmc228_fpga_f0_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force amc502_fmc228_fpga_f0_routed.dcp
  report_drc -file amc502_fmc228_fpga_f0_drc_routed.rpt -pb amc502_fmc228_fpga_f0_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file amc502_fmc228_fpga_f0_timing_summary_routed.rpt -rpx amc502_fmc228_fpga_f0_timing_summary_routed.rpx
  report_power -file amc502_fmc228_fpga_f0_power_routed.rpt -pb amc502_fmc228_fpga_f0_power_summary_routed.pb -rpx amc502_fmc228_fpga_f0_power_routed.rpx
  report_route_status -file amc502_fmc228_fpga_f0_route_status.rpt -pb amc502_fmc228_fpga_f0_route_status.pb
  report_clock_utilization -file amc502_fmc228_fpga_f0_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
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

