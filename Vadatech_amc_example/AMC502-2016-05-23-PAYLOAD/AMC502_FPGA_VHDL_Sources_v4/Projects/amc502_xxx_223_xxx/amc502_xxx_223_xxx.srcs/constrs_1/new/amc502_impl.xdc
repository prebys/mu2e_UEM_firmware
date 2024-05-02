# AMC502 Project Implementation Constraints
# Copyright 2015 VadaTech Incorporated.   All rights reserved.

# Set the following two configuration properties according to VADJ/1
# which is used for the configuration banks and depends on the
# FMC being used.  The 2.5V default is provided for example but
# the board has a dynamic CFGBVS strapping and dynamic VADJ/1 so
# these must be adjusted by the customer to be correct for
# the customer's particular FMC application.
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 2.5 [current_design]

set_property BITSTREAM.GENERAL.COMPRESS true [current_design]

# Clock constraints
create_clock -period 10.000 -name clk100mhz1 [get_ports CLK100MHZ1_P]

set_clock_groups -asynchronous -group [get_clocks clk100mhz1] -group [get_clocks clk_125mhz_mux_x0y0]
set_clock_groups -asynchronous -group [get_clocks clk100mhz1] -group [get_clocks clk_250mhz_mux_x0y0]
set_clock_groups -asynchronous -group [get_clocks clk100mhz1] -group [get_clocks -of_objects [get_pins pcie0_inst/U0/inst/gt_top_i/pipe_wrapper_i/pipe_clock_int.pipe_clock_i/mmcm_i/CLKOUT3]]
