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

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

# Clock constraints
create_clock -period 10.000 -name clk100mhz1 [get_ports CLK100MHZ1_P]



set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN DIV-1 [current_design]
set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 2 [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]
set_property CONFIG_MODE SPIx2 [current_design]


set_property BITSTREAM.CONFIG.CONFIGRATE 3 [current_design]


















