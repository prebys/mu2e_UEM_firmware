# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {Common 17-41} -limit 10000000
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7k420tffg1156-2

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.cache/wt [current_project]
set_property parent.project_path /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.xpr [current_project]
set_property XPM_LIBRARIES XPM_MEMORY [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
add_files /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.sdk/monitor_null/Debug/monitor_null.elf
add_files /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.sdk/monitor_amc502/Debug/monitor_amc502_xaui.elf
add_files /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/decoder_10b8b_rom.coe
add_files /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.sdk/monitor_amc502/Debug/monitor_amc502_xaui_fei4.elf
add_files /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.sdk/monitor_amc502/Debug/monitor_amc502_fmc164.elf
add_files /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.sdk/monitor_amc502/Debug/monitor_amc502_fmc228.elf
set_property SCOPED_TO_REF microblaze_mcs_0 [get_files -all /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.sdk/monitor_amc502/Debug/monitor_amc502_fmc228.elf]
set_property SCOPED_TO_CELLS U0/microblaze_I [get_files -all /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.sdk/monitor_amc502/Debug/monitor_amc502_fmc228.elf]
add_files /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.sdk/monitor_amc502/Debug/monitor_fmc228_pcie.elf
add_files -quiet /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/gig_ethernet_pcs_pma_0/gig_ethernet_pcs_pma_0.dcp
set_property used_in_implementation false [get_files /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/gig_ethernet_pcs_pma_0/gig_ethernet_pcs_pma_0.dcp]
add_files -quiet /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/xaui_0/xaui_0.dcp
set_property used_in_implementation false [get_files /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/xaui_0/xaui_0.dcp]
add_files -quiet /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/decoder_10b8b_rom/decoder_10b8b_rom.dcp
set_property used_in_implementation false [get_files /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/decoder_10b8b_rom/decoder_10b8b_rom.dcp]
add_files -quiet /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/fei4_pixel_fifo/fei4_pixel_fifo.dcp
set_property used_in_implementation false [get_files /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/fei4_pixel_fifo/fei4_pixel_fifo.dcp]
add_files -quiet /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/fei4_spy_fifo/fei4_spy_fifo.dcp
set_property used_in_implementation false [get_files /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/fei4_spy_fifo/fei4_spy_fifo.dcp]
add_files -quiet /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/microblaze_mcs_0/microblaze_mcs_0.dcp
set_property used_in_implementation false [get_files /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/microblaze_mcs_0/microblaze_mcs_0.dcp]
add_files -quiet /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/gtwizard_0/gtwizard_0.dcp
set_property used_in_implementation false [get_files /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/gtwizard_0/gtwizard_0.dcp]
add_files -quiet /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/jesd204_phy_1/jesd204_phy_1.dcp
set_property used_in_implementation false [get_files /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/jesd204_phy_1/jesd204_phy_1.dcp]
add_files -quiet /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/fifo_generator_0/fifo_generator_0.dcp
set_property used_in_implementation false [get_files /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/fifo_generator_0/fifo_generator_0.dcp]
add_files -quiet /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/sumarea_fifo/sumarea_fifo.dcp
set_property used_in_implementation false [get_files /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/sumarea_fifo/sumarea_fifo.dcp]
add_files -quiet /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/peakhigh_fifo/peakhigh_fifo.dcp
set_property used_in_implementation false [get_files /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/peakhigh_fifo/peakhigh_fifo.dcp]
read_vhdl -library hep337dev {
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/add8.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/validation.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/lfsr_n.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/sumarea_module.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/peakhigh_module.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/min_module.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/lfsr.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ilas.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/adc_buffer.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/iobus.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/crc32.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/cksum.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ipbuf.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/trigger_ram.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/peakfinding.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/peakdata_stream.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/lmk_spi.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/jesd204_adc.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/hmc_spi.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/event_module.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/adc_trigger.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/adc_spi.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/adc_buffer_streamer.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/adc_buffer_pool.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/gbe.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/tclkb_driver.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/tclka_receiver.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/tclka_counter.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/i2c.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/clkfreq.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/amc502.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/sendpkt.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/arprep.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/txether.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/icmp.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/streampkt.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/udp.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ipheader.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/icmprep.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/udpbuffer.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/arp.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/gbe_stream_buffer.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/txbuffer.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/arpreq.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ethernet.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/arptab.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/latch_generator.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/event_generator.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/trigger.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/i2c_slave.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/fmc228.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/fmc228card1_interface.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/amc502_interface.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/iobus_interface.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/gbe_interface.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/fmc228_interface.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/fmc164_readout_buffer.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/fmc164.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/fmc164_threshold_trigger.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/fmc164_interface.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/fei4_parse_new.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/fei4_match.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/fei4_lv1count.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/fei4_pixel_fifo.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/fei4rx.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/fei4.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/crc32x64.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/xaui_udpbuffer.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/xaui_udp.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/xaui_txbuffer.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/xaui_sendpkt.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/xaui_icmpreq.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/xaui_icmprep.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/xaui_icmp.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/xaui_ethernet.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/xaui_arpreq.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/xaui_arprep.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/xaui_arp.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/xaui_arbiter.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/xaui.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/fei4_readout.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/fei4_pulser.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/fei4_event_builder.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/fei4_bcocounter.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/fei4tx.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/xaui_interface.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/fei4_interface.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/fmc164_adc_buffer.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/adc_fifo.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/fei4_readout_buffer.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/xaui_stream_buffer.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/xaui_streampkt.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/crc32x64rom.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/crc8x32_const.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/xaui_trigger.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/trigger_in.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/link_interface.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/link.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/trigger_pipeline.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/peakbuffer.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/event_card1_module.vhd
  /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/event_amc.vhd
}
read_vhdl -library xil_defaultlib /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/top_fmc228_pcie.vhd
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/constrs_fmc228_pcie/imports/constrs_1/pins_amc502.xdc
set_property used_in_implementation false [get_files /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/constrs_fmc228_pcie/imports/constrs_1/pins_amc502.xdc]

read_xdc /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/constrs_fmc228_pcie/imports/constrs_1/timing_fmc228_pcie.xdc
set_property used_in_implementation false [get_files /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/constrs_fmc228_pcie/imports/constrs_1/timing_fmc228_pcie.xdc]

read_xdc /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/constrs_fmc228_pcie/imports/constrs_1/pins_fmc228_fmc0.xdc
set_property used_in_implementation false [get_files /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/constrs_fmc228_pcie/imports/constrs_1/pins_fmc228_fmc0.xdc]

read_xdc /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/constrs_fmc228_pcie/imports/constrs_1/pins_fmc228_fmc1.xdc
set_property used_in_implementation false [get_files /disk2/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/constrs_fmc228_pcie/imports/constrs_1/pins_fmc228_fmc1.xdc]


synth_design -top top_fmc228_pcie -part xc7k420tffg1156-2 -fanout_limit 400 -fsm_extraction one_hot -keep_equivalent_registers -resource_sharing off -no_lc -shreg_min_size 5


write_checkpoint -force -noxdef top_fmc228_pcie.dcp

catch { report_utilization -file top_fmc228_pcie_utilization_synth.rpt -pb top_fmc228_pcie_utilization_synth.pb }