#######################################################################
# Clock frequencies and clock management                              #
#######################################################################

# Clock rate below is the 10-Gigabit Ethernet speed; change to
# 159.375 MHz for 10-Gigabit Fibre Channel applications

create_clock -period 6.400 [get_pins -of_objects [get_cells * -hierarchical -filter {REF_NAME=~ GTXE2_CHANNEL && NAME =~ *gt0*}] -filter {NAME =~ *TXOUTCLK}]

## set false path synchronizers
set_false_path -to   [get_cells -hierarchical -filter {NAME =~ *reset_count_done_sync_i/sync1_r_reg[0]}]

set_false_path -to   [get_cells -hierarchical -filter {NAME =~ *plllocked_sync_i/sync1_r_reg[0]}]



set_case_analysis 0 [get_ports configuration_vector]
