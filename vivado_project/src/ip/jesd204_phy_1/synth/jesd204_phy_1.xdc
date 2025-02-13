#----------------------------------------------------------------------
# Title      : Constraints for JESD204 PHY
# Project    : jesd204_phy_v3_1_1
#----------------------------------------------------------------------
# File       : jesd204_phy_1_block.xdc
# Author     : Xilinx
#----------------------------------------------------------------------
# Description: Xilinx Constraint file for JESD204 PHY core
#---------------------------------------------------------------------
# (c) Copyright 2004-2014 Xilinx, Inc. All rights reserved.
#
# This file contains confidential and proprietary information
# of Xilinx, Inc. and is protected under U.S. and
# international copyright and other intellectual property
# laws.
#
# DISCLAIMER
# This disclaimer is not a license and does not grant any
# rights to the materials distributed herewith. Except as
# otherwise provided in a valid license issued to you by
# Xilinx, and to the maximum extent permitted by applicable
# law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
# WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
# AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
# BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
# INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
# (2) Xilinx shall not be liable (whether in contract or tort,
# including negligence, or under any other theory of
# liability) for any loss or damage of any kind or nature
# related to, arising under or in connection with these
# materials, including for any direct, or any indirect,
# special, incidental, or consequential loss or damage
# (including loss of data, profits, goodwill, or any type of
# loss or damage suffered as a result of any action brought
# by a third party) even if such damage or loss was
# reasonably foreseeable or Xilinx had been advised of the
# possibility of the same.
#
# CRITICAL APPLICATIONS
# Xilinx products are not designed or intended to be fail-
# safe, or for use in any application requiring fail-safe
# performance, such as life-support or safety devices or
# systems, Class III medical devices, nuclear facilities,
# applications related to the deployment of airbags, or any
# other applications that could lead to death, personal
# injury, or severe property or environmental damage
# (individually and collectively, "Critical
# Applications"). Customer assumes the sole risk and
# liability of any use of Xilinx products in Critical
# Applications, subject only to applicable laws and
# regulations governing limitations on product liability.
#
# THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
# PART OF THIS FILE AT ALL TIMES.
#

##############################################################################################################################################################
# False paths to the DRP clock syncronisers that resync the incoming RX/TX resets. This also covers the path from the AXI domain if used.
##############################################################################################################################################################
#set_false_path -to [get_cells -hier -regexp -filter {name =~ {.*jesd204_phy_1.*sync_[rt]x_reset_(?:data|all)\/data_sync_reg.*} && IS_SEQUENTIAL}]

set_false_path -to [get_cells -hier -filter {name =~ {*/sync_tx_reset_data/data_sync_reg*} && IS_SEQUENTIAL}]
set_false_path -to [get_cells -hier -filter {name =~ {*/sync_tx_reset_all/data_sync_reg*}  && IS_SEQUENTIAL}]
set_false_path -to [get_cells -hier -filter {name =~ {*/sync_rx_reset_data/data_sync_reg*} && IS_SEQUENTIAL}]
set_false_path -to [get_cells -hier -filter {name =~ {*/sync_rx_reset_all/data_sync_reg*}  && IS_SEQUENTIAL}]

# To see constaint endpoints use
# foreach {tempVar} [ get_pins -hier -regexp -filter {name =~ {.*jesd204_phy_1.*sync_[rt]x_reset_(?:data|all)\/data_sync_reg0/D} }] { puts $tempVar }
# To see timing 
# report_timing -to  [ get_pins -hier -regexp -filter {name =~ {.*jesd204_phy_1.*sync_[rt]x_reset_(?:data|all)\/data_sync_reg0/D} }] -path_type summary -unique_pins -setup -max_paths 1000

##############################################################################################################################################################
# TIMING CONSTRAINTS
##############################################################################################################################################################
set_false_path -from [get_cells -hier -filter {name =~ *jesd204_phy_block_i/*x_chan_rst_done_r_reg* && IS_SEQUENTIAL}] -to [get_cells -hier -filter {name =~ *jesd204_phy_block_i/sync_*x_chan_rst_done/data_sync_reg* && IS_SEQUENTIAL}]


