// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
// Date        : Mon Jan 28 22:07:39 2019
// Host        : mu2etest.fnal.gov running 64-bit Scientific Linux Fermi release 6.10 (Ramsey)
// Command     : write_verilog -force -mode synth_stub
//               /home/mu2e/mu2e_firmware/firmware/mu2e_1.srcs/sources_1/ip/xaui_0/xaui_0_stub.v
// Design      : xaui_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k420tffg1156-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "xaui_v12_2_5,Vivado 2016.2" *)
module xaui_0(dclk, reset, clk156_out, clk156_lock, refclk, xgmii_txd, xgmii_txc, xgmii_rxd, xgmii_rxc, xaui_tx_l0_p, xaui_tx_l0_n, xaui_tx_l1_p, xaui_tx_l1_n, xaui_tx_l2_p, xaui_tx_l2_n, xaui_tx_l3_p, xaui_tx_l3_n, xaui_rx_l0_p, xaui_rx_l0_n, xaui_rx_l1_p, xaui_rx_l1_n, xaui_rx_l2_p, xaui_rx_l2_n, xaui_rx_l3_p, xaui_rx_l3_n, signal_detect, debug, configuration_vector, status_vector)
/* synthesis syn_black_box black_box_pad_pin="dclk,reset,clk156_out,clk156_lock,refclk,xgmii_txd[63:0],xgmii_txc[7:0],xgmii_rxd[63:0],xgmii_rxc[7:0],xaui_tx_l0_p,xaui_tx_l0_n,xaui_tx_l1_p,xaui_tx_l1_n,xaui_tx_l2_p,xaui_tx_l2_n,xaui_tx_l3_p,xaui_tx_l3_n,xaui_rx_l0_p,xaui_rx_l0_n,xaui_rx_l1_p,xaui_rx_l1_n,xaui_rx_l2_p,xaui_rx_l2_n,xaui_rx_l3_p,xaui_rx_l3_n,signal_detect[3:0],debug[5:0],configuration_vector[6:0],status_vector[7:0]" */;
  input dclk;
  input reset;
  output clk156_out;
  output clk156_lock;
  input refclk;
  input [63:0]xgmii_txd;
  input [7:0]xgmii_txc;
  output [63:0]xgmii_rxd;
  output [7:0]xgmii_rxc;
  output xaui_tx_l0_p;
  output xaui_tx_l0_n;
  output xaui_tx_l1_p;
  output xaui_tx_l1_n;
  output xaui_tx_l2_p;
  output xaui_tx_l2_n;
  output xaui_tx_l3_p;
  output xaui_tx_l3_n;
  input xaui_rx_l0_p;
  input xaui_rx_l0_n;
  input xaui_rx_l1_p;
  input xaui_rx_l1_n;
  input xaui_rx_l2_p;
  input xaui_rx_l2_n;
  input xaui_rx_l3_p;
  input xaui_rx_l3_n;
  input [3:0]signal_detect;
  output [5:0]debug;
  input [6:0]configuration_vector;
  output [7:0]status_vector;
endmodule
