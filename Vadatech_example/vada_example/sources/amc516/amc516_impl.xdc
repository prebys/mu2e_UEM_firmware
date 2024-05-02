# ====== Timing Constraints ===========
create_clock -period 4    -name refclk0 		[get_ports FMC_GBTCLK0_P	]
create_clock -period 6.4  -name axiclk 			[get_ports CLK156_25MHZ3_P	]
create_clock -period 10   -name amc_pcie_refclk 	[get_ports FCLKA_P		]
create_clock -period 10   -name p2040_pcie_refclk 	[get_ports CLK100MHZ0_P		]
create_clock -period 10   -name microblaze_clk 		[get_ports CLK100MHZ1_P		]

# false path
set_false_path -to 	[get_cells -hierarchical -filter {NAME =~ *vt_single_sync*/dff* && IS_SEQUENTIAL}]
set_false_path -from 	[get_cells -hierarchical -filter {NAME =~ *vt_single_sync*/dff* && IS_SEQUENTIAL}]

set_false_path -to 	[get_cells -hierarchical -filter {NAME =~ *axi_gpio_32_inst/reg_gpio_in_*} ]
set_false_path -from 	[get_cells -hierarchical -filter {NAME =~ *axi_gpio_32_inst/reg_gpio_out*} ]
