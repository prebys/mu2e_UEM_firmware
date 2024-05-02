# ====== Timing Constraints ===========
create_clock -period 4 -name refclk [get_ports FMC0_GBTCLK0_P]
create_clock -period 10 -name axiclk [get_ports CLK100MHZ1_P]
create_clock -period 10 -name pcie_refclk [get_ports FCLKA_P]

# false path
set_false_path -to 	[get_cells -hierarchical -filter {NAME =~ *vt_single_sync*/dff* && IS_SEQUENTIAL}]
set_false_path -from 	[get_cells -hierarchical -filter {NAME =~ *vt_single_sync*/dff* && IS_SEQUENTIAL}]

set_false_path -to 	[get_cells -hierarchical -filter {NAME =~ *axi_gpio_32_inst/reg_gpio_in_*} ]
set_false_path -from 	[get_cells -hierarchical -filter {NAME =~ *axi_gpio_32_inst/reg_gpio_out*} ]
