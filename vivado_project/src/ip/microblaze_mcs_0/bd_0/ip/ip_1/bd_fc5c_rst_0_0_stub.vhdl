-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
-- Date        : Fri Mar 22 16:54:05 2024
-- Host        : mu2euem.dhcp.fnal.gov running 64-bit Scientific Linux release 7.9 (Nitrogen)
-- Command     : write_vhdl -force -mode synth_stub
--               /root/Documents/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/microblaze_mcs_0/bd_0/ip/ip_1/bd_fc5c_rst_0_0_stub.vhdl
-- Design      : bd_fc5c_rst_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k420tffg1156-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bd_fc5c_rst_0_0 is
  Port ( 
    slowest_sync_clk : in STD_LOGIC;
    ext_reset_in : in STD_LOGIC;
    aux_reset_in : in STD_LOGIC;
    mb_debug_sys_rst : in STD_LOGIC;
    dcm_locked : in STD_LOGIC;
    mb_reset : out STD_LOGIC;
    bus_struct_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    interconnect_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 )
  );

end bd_fc5c_rst_0_0;

architecture stub of bd_fc5c_rst_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "slowest_sync_clk,ext_reset_in,aux_reset_in,mb_debug_sys_rst,dcm_locked,mb_reset,bus_struct_reset[0:0],peripheral_reset[0:0],interconnect_aresetn[0:0],peripheral_aresetn[0:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "proc_sys_reset,Vivado 2016.2";
begin
end;
