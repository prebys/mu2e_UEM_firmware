open_project ./mu2e_UEM_firmware.xpr
update_compile_order -fileset sources_1

reset_run synth_1 -verbose
launch_runs synth_1 -verbose
wait_on_run synth_1 -verbose

launch_runs impl_1 -to_step write_bitstream -verbose
wait_on_run impl_1 -verbose
puts "Implementation done!"
