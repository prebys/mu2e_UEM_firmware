// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.4 (win64) Build 1412921 Wed Nov 18 09:43:45 MST 2015
// Date        : Fri May 20 11:31:33 2016
// Host        : fpga03 running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               C:/Projects/vts0025/amc502/fpga/trunk/amc502_xxx_211_xxx/amc502_xxx_211_xxx.srcs/sources_1/ip/xaui/xaui_sim_netlist.v
// Design      : xaui
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k420tffg1156-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* core_generation_info = "xaui,xaui_v12_2_3,{x_ipProduct=Vivado 2015.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=xaui,x_ipVersion=12.2,x_ipCoreRevision=3,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED,c_family=kintex7,c_component_name=xaui,c_is_dxaui=false,c_has_mdio=false,c_sub_core_name=xaui_gt,c_gt_dmonitorout_width=8,c_gt_txdiffctrl_width=16,c_gt_daddr_width=9,c_refclkrate=156.25,c_drpclk_freq=50.0,c_gt_loc=X0Y0 X0Y1 X0Y2 X0Y3}" *) (* x_core_info = "xaui_v12_2_3,Vivado 2015.4" *) 
(* NotValidForBitStream *)
module xaui
   (dclk,
    reset,
    clk156_out,
    clk156_lock,
    refclk,
    xgmii_txd,
    xgmii_txc,
    xgmii_rxd,
    xgmii_rxc,
    xaui_tx_l0_p,
    xaui_tx_l0_n,
    xaui_tx_l1_p,
    xaui_tx_l1_n,
    xaui_tx_l2_p,
    xaui_tx_l2_n,
    xaui_tx_l3_p,
    xaui_tx_l3_n,
    xaui_rx_l0_p,
    xaui_rx_l0_n,
    xaui_rx_l1_p,
    xaui_rx_l1_n,
    xaui_rx_l2_p,
    xaui_rx_l2_n,
    xaui_rx_l3_p,
    xaui_rx_l3_n,
    signal_detect,
    debug,
    configuration_vector,
    status_vector);
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

  wire clk156_lock;
  wire clk156_out;
  wire [6:0]configuration_vector;
  wire dclk;
  wire [5:0]debug;
  wire refclk;
  wire reset;
  wire [3:0]signal_detect;
  wire [7:0]status_vector;
  wire xaui_rx_l0_n;
  wire xaui_rx_l0_p;
  wire xaui_rx_l1_n;
  wire xaui_rx_l1_p;
  wire xaui_rx_l2_n;
  wire xaui_rx_l2_p;
  wire xaui_rx_l3_n;
  wire xaui_rx_l3_p;
  wire xaui_tx_l0_n;
  wire xaui_tx_l0_p;
  wire xaui_tx_l1_n;
  wire xaui_tx_l1_p;
  wire xaui_tx_l2_n;
  wire xaui_tx_l2_p;
  wire xaui_tx_l3_n;
  wire xaui_tx_l3_p;
  wire [7:0]xgmii_rxc;
  wire [63:0]xgmii_rxd;
  wire [7:0]xgmii_txc;
  wire [63:0]xgmii_txd;
  wire NLW_U0_gt0_drprdy_UNCONNECTED;
  wire NLW_U0_gt0_eyescandataerror_out_UNCONNECTED;
  wire NLW_U0_gt0_rxcommadet_out_UNCONNECTED;
  wire NLW_U0_gt0_rxprbserr_out_UNCONNECTED;
  wire NLW_U0_gt0_rxresetdone_out_UNCONNECTED;
  wire NLW_U0_gt0_txdlysresetdone_out_UNCONNECTED;
  wire NLW_U0_gt0_txphaligndone_out_UNCONNECTED;
  wire NLW_U0_gt0_txphinitdone_out_UNCONNECTED;
  wire NLW_U0_gt0_txresetdone_out_UNCONNECTED;
  wire NLW_U0_gt1_drprdy_UNCONNECTED;
  wire NLW_U0_gt1_eyescandataerror_out_UNCONNECTED;
  wire NLW_U0_gt1_rxcommadet_out_UNCONNECTED;
  wire NLW_U0_gt1_rxprbserr_out_UNCONNECTED;
  wire NLW_U0_gt1_rxresetdone_out_UNCONNECTED;
  wire NLW_U0_gt1_txdlysresetdone_out_UNCONNECTED;
  wire NLW_U0_gt1_txphaligndone_out_UNCONNECTED;
  wire NLW_U0_gt1_txphinitdone_out_UNCONNECTED;
  wire NLW_U0_gt1_txresetdone_out_UNCONNECTED;
  wire NLW_U0_gt2_drprdy_UNCONNECTED;
  wire NLW_U0_gt2_eyescandataerror_out_UNCONNECTED;
  wire NLW_U0_gt2_rxcommadet_out_UNCONNECTED;
  wire NLW_U0_gt2_rxprbserr_out_UNCONNECTED;
  wire NLW_U0_gt2_rxresetdone_out_UNCONNECTED;
  wire NLW_U0_gt2_txdlysresetdone_out_UNCONNECTED;
  wire NLW_U0_gt2_txphaligndone_out_UNCONNECTED;
  wire NLW_U0_gt2_txphinitdone_out_UNCONNECTED;
  wire NLW_U0_gt2_txresetdone_out_UNCONNECTED;
  wire NLW_U0_gt3_drprdy_UNCONNECTED;
  wire NLW_U0_gt3_eyescandataerror_out_UNCONNECTED;
  wire NLW_U0_gt3_rxcommadet_out_UNCONNECTED;
  wire NLW_U0_gt3_rxprbserr_out_UNCONNECTED;
  wire NLW_U0_gt3_rxresetdone_out_UNCONNECTED;
  wire NLW_U0_gt3_txdlysresetdone_out_UNCONNECTED;
  wire NLW_U0_gt3_txphaligndone_out_UNCONNECTED;
  wire NLW_U0_gt3_txphinitdone_out_UNCONNECTED;
  wire NLW_U0_gt3_txresetdone_out_UNCONNECTED;
  wire NLW_U0_gt_qplllock_out_UNCONNECTED;
  wire [7:0]NLW_U0_gt0_dmonitorout_out_UNCONNECTED;
  wire [15:0]NLW_U0_gt0_drpdo_UNCONNECTED;
  wire [2:0]NLW_U0_gt0_rxbufstatus_out_UNCONNECTED;
  wire [1:0]NLW_U0_gt0_rxdisperr_out_UNCONNECTED;
  wire [6:0]NLW_U0_gt0_rxmonitorout_out_UNCONNECTED;
  wire [1:0]NLW_U0_gt0_rxnotintable_out_UNCONNECTED;
  wire [7:0]NLW_U0_gt1_dmonitorout_out_UNCONNECTED;
  wire [15:0]NLW_U0_gt1_drpdo_UNCONNECTED;
  wire [2:0]NLW_U0_gt1_rxbufstatus_out_UNCONNECTED;
  wire [1:0]NLW_U0_gt1_rxdisperr_out_UNCONNECTED;
  wire [6:0]NLW_U0_gt1_rxmonitorout_out_UNCONNECTED;
  wire [1:0]NLW_U0_gt1_rxnotintable_out_UNCONNECTED;
  wire [7:0]NLW_U0_gt2_dmonitorout_out_UNCONNECTED;
  wire [15:0]NLW_U0_gt2_drpdo_UNCONNECTED;
  wire [2:0]NLW_U0_gt2_rxbufstatus_out_UNCONNECTED;
  wire [1:0]NLW_U0_gt2_rxdisperr_out_UNCONNECTED;
  wire [6:0]NLW_U0_gt2_rxmonitorout_out_UNCONNECTED;
  wire [1:0]NLW_U0_gt2_rxnotintable_out_UNCONNECTED;
  wire [7:0]NLW_U0_gt3_dmonitorout_out_UNCONNECTED;
  wire [15:0]NLW_U0_gt3_drpdo_UNCONNECTED;
  wire [2:0]NLW_U0_gt3_rxbufstatus_out_UNCONNECTED;
  wire [1:0]NLW_U0_gt3_rxdisperr_out_UNCONNECTED;
  wire [6:0]NLW_U0_gt3_rxmonitorout_out_UNCONNECTED;
  wire [1:0]NLW_U0_gt3_rxnotintable_out_UNCONNECTED;

  (* downgradeipidentifiedwarnings = "yes" *) 
  xaui_xaui_block U0
       (.clk156_lock(clk156_lock),
        .clk156_out(clk156_out),
        .configuration_vector(configuration_vector),
        .dclk(dclk),
        .debug(debug),
        .gt0_dmonitorout_out(NLW_U0_gt0_dmonitorout_out_UNCONNECTED[7:0]),
        .gt0_drpaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .gt0_drpdi({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .gt0_drpdo(NLW_U0_gt0_drpdo_UNCONNECTED[15:0]),
        .gt0_drpen(1'b0),
        .gt0_drprdy(NLW_U0_gt0_drprdy_UNCONNECTED),
        .gt0_drpwe(1'b0),
        .gt0_eyescandataerror_out(NLW_U0_gt0_eyescandataerror_out_UNCONNECTED),
        .gt0_eyescanreset_in(1'b0),
        .gt0_eyescantrigger_in(1'b0),
        .gt0_loopback_in({1'b0,1'b0,1'b0}),
        .gt0_rxbufstatus_out(NLW_U0_gt0_rxbufstatus_out_UNCONNECTED[2:0]),
        .gt0_rxcdrhold_in(1'b0),
        .gt0_rxcommadet_out(NLW_U0_gt0_rxcommadet_out_UNCONNECTED),
        .gt0_rxdfelpmreset_in(1'b0),
        .gt0_rxdisperr_out(NLW_U0_gt0_rxdisperr_out_UNCONNECTED[1:0]),
        .gt0_rxlpmen_in(1'b1),
        .gt0_rxmonitorout_out(NLW_U0_gt0_rxmonitorout_out_UNCONNECTED[6:0]),
        .gt0_rxmonitorsel_in({1'b0,1'b0}),
        .gt0_rxnotintable_out(NLW_U0_gt0_rxnotintable_out_UNCONNECTED[1:0]),
        .gt0_rxpcsreset_in(1'b0),
        .gt0_rxpmareset_in(1'b0),
        .gt0_rxpolarity_in(1'b0),
        .gt0_rxprbscntreset_in(1'b0),
        .gt0_rxprbserr_out(NLW_U0_gt0_rxprbserr_out_UNCONNECTED),
        .gt0_rxprbssel_in({1'b0,1'b0,1'b0}),
        .gt0_rxrate_in({1'b0,1'b0,1'b0}),
        .gt0_rxresetdone_out(NLW_U0_gt0_rxresetdone_out_UNCONNECTED),
        .gt0_txdiffctrl_in({1'b1,1'b0,1'b0,1'b0}),
        .gt0_txdlysresetdone_out(NLW_U0_gt0_txdlysresetdone_out_UNCONNECTED),
        .gt0_txinhibit_in(1'b0),
        .gt0_txpcsreset_in(1'b0),
        .gt0_txphaligndone_out(NLW_U0_gt0_txphaligndone_out_UNCONNECTED),
        .gt0_txphinitdone_out(NLW_U0_gt0_txphinitdone_out_UNCONNECTED),
        .gt0_txpmareset_in(1'b0),
        .gt0_txpolarity_in(1'b0),
        .gt0_txpostcursor_in({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .gt0_txprbsforceerr_in(1'b0),
        .gt0_txprbssel_in({1'b0,1'b0,1'b0}),
        .gt0_txprecursor_in({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .gt0_txresetdone_out(NLW_U0_gt0_txresetdone_out_UNCONNECTED),
        .gt1_dmonitorout_out(NLW_U0_gt1_dmonitorout_out_UNCONNECTED[7:0]),
        .gt1_drpaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .gt1_drpdi({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .gt1_drpdo(NLW_U0_gt1_drpdo_UNCONNECTED[15:0]),
        .gt1_drpen(1'b0),
        .gt1_drprdy(NLW_U0_gt1_drprdy_UNCONNECTED),
        .gt1_drpwe(1'b0),
        .gt1_eyescandataerror_out(NLW_U0_gt1_eyescandataerror_out_UNCONNECTED),
        .gt1_eyescanreset_in(1'b0),
        .gt1_eyescantrigger_in(1'b0),
        .gt1_loopback_in({1'b0,1'b0,1'b0}),
        .gt1_rxbufstatus_out(NLW_U0_gt1_rxbufstatus_out_UNCONNECTED[2:0]),
        .gt1_rxcdrhold_in(1'b0),
        .gt1_rxcommadet_out(NLW_U0_gt1_rxcommadet_out_UNCONNECTED),
        .gt1_rxdfelpmreset_in(1'b0),
        .gt1_rxdisperr_out(NLW_U0_gt1_rxdisperr_out_UNCONNECTED[1:0]),
        .gt1_rxlpmen_in(1'b1),
        .gt1_rxmonitorout_out(NLW_U0_gt1_rxmonitorout_out_UNCONNECTED[6:0]),
        .gt1_rxmonitorsel_in({1'b0,1'b0}),
        .gt1_rxnotintable_out(NLW_U0_gt1_rxnotintable_out_UNCONNECTED[1:0]),
        .gt1_rxpcsreset_in(1'b0),
        .gt1_rxpmareset_in(1'b0),
        .gt1_rxpolarity_in(1'b0),
        .gt1_rxprbscntreset_in(1'b0),
        .gt1_rxprbserr_out(NLW_U0_gt1_rxprbserr_out_UNCONNECTED),
        .gt1_rxprbssel_in({1'b0,1'b0,1'b0}),
        .gt1_rxrate_in({1'b0,1'b0,1'b0}),
        .gt1_rxresetdone_out(NLW_U0_gt1_rxresetdone_out_UNCONNECTED),
        .gt1_txdiffctrl_in({1'b1,1'b0,1'b0,1'b0}),
        .gt1_txdlysresetdone_out(NLW_U0_gt1_txdlysresetdone_out_UNCONNECTED),
        .gt1_txinhibit_in(1'b0),
        .gt1_txpcsreset_in(1'b0),
        .gt1_txphaligndone_out(NLW_U0_gt1_txphaligndone_out_UNCONNECTED),
        .gt1_txphinitdone_out(NLW_U0_gt1_txphinitdone_out_UNCONNECTED),
        .gt1_txpmareset_in(1'b0),
        .gt1_txpolarity_in(1'b0),
        .gt1_txpostcursor_in({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .gt1_txprbsforceerr_in(1'b0),
        .gt1_txprbssel_in({1'b0,1'b0,1'b0}),
        .gt1_txprecursor_in({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .gt1_txresetdone_out(NLW_U0_gt1_txresetdone_out_UNCONNECTED),
        .gt2_dmonitorout_out(NLW_U0_gt2_dmonitorout_out_UNCONNECTED[7:0]),
        .gt2_drpaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .gt2_drpdi({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .gt2_drpdo(NLW_U0_gt2_drpdo_UNCONNECTED[15:0]),
        .gt2_drpen(1'b0),
        .gt2_drprdy(NLW_U0_gt2_drprdy_UNCONNECTED),
        .gt2_drpwe(1'b0),
        .gt2_eyescandataerror_out(NLW_U0_gt2_eyescandataerror_out_UNCONNECTED),
        .gt2_eyescanreset_in(1'b0),
        .gt2_eyescantrigger_in(1'b0),
        .gt2_loopback_in({1'b0,1'b0,1'b0}),
        .gt2_rxbufstatus_out(NLW_U0_gt2_rxbufstatus_out_UNCONNECTED[2:0]),
        .gt2_rxcdrhold_in(1'b0),
        .gt2_rxcommadet_out(NLW_U0_gt2_rxcommadet_out_UNCONNECTED),
        .gt2_rxdfelpmreset_in(1'b0),
        .gt2_rxdisperr_out(NLW_U0_gt2_rxdisperr_out_UNCONNECTED[1:0]),
        .gt2_rxlpmen_in(1'b1),
        .gt2_rxmonitorout_out(NLW_U0_gt2_rxmonitorout_out_UNCONNECTED[6:0]),
        .gt2_rxmonitorsel_in({1'b0,1'b0}),
        .gt2_rxnotintable_out(NLW_U0_gt2_rxnotintable_out_UNCONNECTED[1:0]),
        .gt2_rxpcsreset_in(1'b0),
        .gt2_rxpmareset_in(1'b0),
        .gt2_rxpolarity_in(1'b0),
        .gt2_rxprbscntreset_in(1'b0),
        .gt2_rxprbserr_out(NLW_U0_gt2_rxprbserr_out_UNCONNECTED),
        .gt2_rxprbssel_in({1'b0,1'b0,1'b0}),
        .gt2_rxrate_in({1'b0,1'b0,1'b0}),
        .gt2_rxresetdone_out(NLW_U0_gt2_rxresetdone_out_UNCONNECTED),
        .gt2_txdiffctrl_in({1'b1,1'b0,1'b0,1'b0}),
        .gt2_txdlysresetdone_out(NLW_U0_gt2_txdlysresetdone_out_UNCONNECTED),
        .gt2_txinhibit_in(1'b0),
        .gt2_txpcsreset_in(1'b0),
        .gt2_txphaligndone_out(NLW_U0_gt2_txphaligndone_out_UNCONNECTED),
        .gt2_txphinitdone_out(NLW_U0_gt2_txphinitdone_out_UNCONNECTED),
        .gt2_txpmareset_in(1'b0),
        .gt2_txpolarity_in(1'b0),
        .gt2_txpostcursor_in({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .gt2_txprbsforceerr_in(1'b0),
        .gt2_txprbssel_in({1'b0,1'b0,1'b0}),
        .gt2_txprecursor_in({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .gt2_txresetdone_out(NLW_U0_gt2_txresetdone_out_UNCONNECTED),
        .gt3_dmonitorout_out(NLW_U0_gt3_dmonitorout_out_UNCONNECTED[7:0]),
        .gt3_drpaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .gt3_drpdi({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .gt3_drpdo(NLW_U0_gt3_drpdo_UNCONNECTED[15:0]),
        .gt3_drpen(1'b0),
        .gt3_drprdy(NLW_U0_gt3_drprdy_UNCONNECTED),
        .gt3_drpwe(1'b0),
        .gt3_eyescandataerror_out(NLW_U0_gt3_eyescandataerror_out_UNCONNECTED),
        .gt3_eyescanreset_in(1'b0),
        .gt3_eyescantrigger_in(1'b0),
        .gt3_loopback_in({1'b0,1'b0,1'b0}),
        .gt3_rxbufstatus_out(NLW_U0_gt3_rxbufstatus_out_UNCONNECTED[2:0]),
        .gt3_rxcdrhold_in(1'b0),
        .gt3_rxcommadet_out(NLW_U0_gt3_rxcommadet_out_UNCONNECTED),
        .gt3_rxdfelpmreset_in(1'b0),
        .gt3_rxdisperr_out(NLW_U0_gt3_rxdisperr_out_UNCONNECTED[1:0]),
        .gt3_rxlpmen_in(1'b1),
        .gt3_rxmonitorout_out(NLW_U0_gt3_rxmonitorout_out_UNCONNECTED[6:0]),
        .gt3_rxmonitorsel_in({1'b0,1'b0}),
        .gt3_rxnotintable_out(NLW_U0_gt3_rxnotintable_out_UNCONNECTED[1:0]),
        .gt3_rxpcsreset_in(1'b0),
        .gt3_rxpmareset_in(1'b0),
        .gt3_rxpolarity_in(1'b0),
        .gt3_rxprbscntreset_in(1'b0),
        .gt3_rxprbserr_out(NLW_U0_gt3_rxprbserr_out_UNCONNECTED),
        .gt3_rxprbssel_in({1'b0,1'b0,1'b0}),
        .gt3_rxrate_in({1'b0,1'b0,1'b0}),
        .gt3_rxresetdone_out(NLW_U0_gt3_rxresetdone_out_UNCONNECTED),
        .gt3_txdiffctrl_in({1'b1,1'b0,1'b0,1'b0}),
        .gt3_txdlysresetdone_out(NLW_U0_gt3_txdlysresetdone_out_UNCONNECTED),
        .gt3_txinhibit_in(1'b0),
        .gt3_txpcsreset_in(1'b0),
        .gt3_txphaligndone_out(NLW_U0_gt3_txphaligndone_out_UNCONNECTED),
        .gt3_txphinitdone_out(NLW_U0_gt3_txphinitdone_out_UNCONNECTED),
        .gt3_txpmareset_in(1'b0),
        .gt3_txpolarity_in(1'b0),
        .gt3_txpostcursor_in({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .gt3_txprbsforceerr_in(1'b0),
        .gt3_txprbssel_in({1'b0,1'b0,1'b0}),
        .gt3_txprecursor_in({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .gt3_txresetdone_out(NLW_U0_gt3_txresetdone_out_UNCONNECTED),
        .gt_qplllock_out(NLW_U0_gt_qplllock_out_UNCONNECTED),
        .refclk(refclk),
        .reset(reset),
        .signal_detect(signal_detect),
        .status_vector(status_vector),
        .xaui_rx_l0_n(xaui_rx_l0_n),
        .xaui_rx_l0_p(xaui_rx_l0_p),
        .xaui_rx_l1_n(xaui_rx_l1_n),
        .xaui_rx_l1_p(xaui_rx_l1_p),
        .xaui_rx_l2_n(xaui_rx_l2_n),
        .xaui_rx_l2_p(xaui_rx_l2_p),
        .xaui_rx_l3_n(xaui_rx_l3_n),
        .xaui_rx_l3_p(xaui_rx_l3_p),
        .xaui_tx_l0_n(xaui_tx_l0_n),
        .xaui_tx_l0_p(xaui_tx_l0_p),
        .xaui_tx_l1_n(xaui_tx_l1_n),
        .xaui_tx_l1_p(xaui_tx_l1_p),
        .xaui_tx_l2_n(xaui_tx_l2_n),
        .xaui_tx_l2_p(xaui_tx_l2_p),
        .xaui_tx_l3_n(xaui_tx_l3_n),
        .xaui_tx_l3_p(xaui_tx_l3_p),
        .xgmii_rxc(xgmii_rxc),
        .xgmii_rxd(xgmii_rxd),
        .xgmii_txc(xgmii_txc),
        .xgmii_txd(xgmii_txd));
endmodule

(* ORIG_REF_NAME = "align_counter" *) 
module xaui_align_counter
   (\count_reg[4]_0 ,
    Q,
    \state_reg[1][1] ,
    \state_reg[1][1]_0 ,
    \state_reg[1][1]_1 ,
    \state_reg[1][1]_2 ,
    \state_reg[1][0] ,
    \state_reg[1][2] ,
    \state_reg[0][0] ,
    \state_reg[0][0]_0 ,
    q_det,
    \state_reg[1][0]_0 ,
    next_ifg_is_a_reg,
    \state_reg[1][1]_3 ,
    usrclk_reset,
    usrclk,
    D,
    \state_reg[0][1] ,
    \state_reg[0][0]_1 ,
    \state_reg[1][1]_4 ,
    \state_reg[1][0]_1 );
  output [3:0]\count_reg[4]_0 ;
  output [1:0]Q;
  output \state_reg[1][1] ;
  output \state_reg[1][1]_0 ;
  output \state_reg[1][1]_1 ;
  output \state_reg[1][1]_2 ;
  output \state_reg[1][0] ;
  output \state_reg[1][2] ;
  output \state_reg[0][0] ;
  input \state_reg[0][0]_0 ;
  input q_det;
  input \state_reg[1][0]_0 ;
  input next_ifg_is_a_reg;
  input \state_reg[1][1]_3 ;
  input usrclk_reset;
  input usrclk;
  input [1:0]D;
  input \state_reg[0][1] ;
  input [0:0]\state_reg[0][0]_1 ;
  input \state_reg[1][1]_4 ;
  input [0:0]\state_reg[1][0]_1 ;

  wire [1:0]D;
  wire [1:0]Q;
  wire [2:2]count;
  wire \count[2]_i_1_n_0 ;
  wire \count[3]_i_1_n_0 ;
  wire \count[3]_i_2_n_0 ;
  wire \count[4]_i_1_n_0 ;
  wire [3:0]\count_reg[4]_0 ;
  wire extra_a;
  wire extra_a_i_1_n_0;
  wire next_ifg_is_a_reg;
  wire [3:2]p_1_in;
  wire \prbs[1]_i_1_n_0 ;
  wire \prbs_reg_n_0_[5] ;
  wire \prbs_reg_n_0_[6] ;
  wire \prbs_reg_n_0_[7] ;
  wire q_det;
  wire \state_reg[0][0] ;
  wire \state_reg[0][0]_0 ;
  wire [0:0]\state_reg[0][0]_1 ;
  wire \state_reg[0][1] ;
  wire \state_reg[1][0] ;
  wire \state_reg[1][0]_0 ;
  wire [0:0]\state_reg[1][0]_1 ;
  wire \state_reg[1][1] ;
  wire \state_reg[1][1]_0 ;
  wire \state_reg[1][1]_1 ;
  wire \state_reg[1][1]_2 ;
  wire \state_reg[1][1]_3 ;
  wire \state_reg[1][1]_4 ;
  wire \state_reg[1][2] ;
  wire usrclk;
  wire usrclk_reset;

  LUT4 #(
    .INIT(16'hB88B)) 
    \count[2]_i_1 
       (.I0(p_1_in[2]),
        .I1(\state_reg[0][0]_0 ),
        .I2(count),
        .I3(\count_reg[4]_0 [1]),
        .O(\count[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \count[3]_i_1 
       (.I0(count),
        .I1(\count_reg[4]_0 [1]),
        .I2(\state_reg[0][0]_0 ),
        .I3(\count_reg[4]_0 [3]),
        .I4(\count_reg[4]_0 [2]),
        .O(\count[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8B88B)) 
    \count[3]_i_2 
       (.I0(p_1_in[3]),
        .I1(\state_reg[0][0]_0 ),
        .I2(\count_reg[4]_0 [2]),
        .I3(\count_reg[4]_0 [1]),
        .I4(count),
        .O(\count[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT5 #(
    .INIT(32'hFFF0FEF0)) 
    \count[4]_i_1 
       (.I0(count),
        .I1(\count_reg[4]_0 [1]),
        .I2(\state_reg[0][0]_0 ),
        .I3(\count_reg[4]_0 [3]),
        .I4(\count_reg[4]_0 [2]),
        .O(\count[4]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[0] 
       (.C(usrclk),
        .CE(\count[3]_i_1_n_0 ),
        .D(D[0]),
        .Q(\count_reg[4]_0 [0]),
        .R(usrclk_reset));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[1] 
       (.C(usrclk),
        .CE(\count[3]_i_1_n_0 ),
        .D(D[1]),
        .Q(\count_reg[4]_0 [1]),
        .R(usrclk_reset));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[2] 
       (.C(usrclk),
        .CE(\count[3]_i_1_n_0 ),
        .D(\count[2]_i_1_n_0 ),
        .Q(count),
        .R(usrclk_reset));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[3] 
       (.C(usrclk),
        .CE(\count[3]_i_1_n_0 ),
        .D(\count[3]_i_2_n_0 ),
        .Q(\count_reg[4]_0 [2]),
        .R(usrclk_reset));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\count[4]_i_1_n_0 ),
        .Q(\count_reg[4]_0 [3]),
        .R(usrclk_reset));
  LUT6 #(
    .INIT(64'h00000000AEAE00AE)) 
    extra_a_i_1
       (.I0(extra_a),
        .I1(\state_reg[0][1] ),
        .I2(\state_reg[0][0]_1 ),
        .I3(\state_reg[1][1]_4 ),
        .I4(\state_reg[1][0]_1 ),
        .I5(usrclk_reset),
        .O(extra_a_i_1_n_0));
  FDRE extra_a_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(extra_a_i_1_n_0),
        .Q(extra_a),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h6)) 
    \prbs[1]_i_1 
       (.I0(\prbs_reg_n_0_[7] ),
        .I1(\prbs_reg_n_0_[6] ),
        .O(\prbs[1]_i_1_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \prbs_reg[1] 
       (.C(usrclk),
        .CE(\state_reg[0][0]_0 ),
        .D(\prbs[1]_i_1_n_0 ),
        .Q(Q[0]),
        .S(usrclk_reset));
  FDSE #(
    .INIT(1'b1)) 
    \prbs_reg[2] 
       (.C(usrclk),
        .CE(\state_reg[0][0]_0 ),
        .D(Q[0]),
        .Q(Q[1]),
        .S(usrclk_reset));
  FDSE #(
    .INIT(1'b1)) 
    \prbs_reg[3] 
       (.C(usrclk),
        .CE(\state_reg[0][0]_0 ),
        .D(Q[1]),
        .Q(p_1_in[2]),
        .S(usrclk_reset));
  FDSE #(
    .INIT(1'b1)) 
    \prbs_reg[4] 
       (.C(usrclk),
        .CE(\state_reg[0][0]_0 ),
        .D(p_1_in[2]),
        .Q(p_1_in[3]),
        .S(usrclk_reset));
  FDSE #(
    .INIT(1'b1)) 
    \prbs_reg[5] 
       (.C(usrclk),
        .CE(\state_reg[0][0]_0 ),
        .D(p_1_in[3]),
        .Q(\prbs_reg_n_0_[5] ),
        .S(usrclk_reset));
  FDSE #(
    .INIT(1'b1)) 
    \prbs_reg[6] 
       (.C(usrclk),
        .CE(\state_reg[0][0]_0 ),
        .D(\prbs_reg_n_0_[5] ),
        .Q(\prbs_reg_n_0_[6] ),
        .S(usrclk_reset));
  FDSE #(
    .INIT(1'b1)) 
    \prbs_reg[7] 
       (.C(usrclk),
        .CE(\state_reg[0][0]_0 ),
        .D(\prbs_reg_n_0_[6] ),
        .Q(\prbs_reg_n_0_[7] ),
        .S(usrclk_reset));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \state[0][0]_i_3 
       (.I0(\count_reg[4]_0 [2]),
        .I1(\count_reg[4]_0 [3]),
        .I2(\state_reg[0][0]_0 ),
        .I3(\state_reg[1][1]_2 ),
        .O(\state_reg[0][0] ));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT4 #(
    .INIT(16'hAA8A)) 
    \state[1][0]_i_10 
       (.I0(count),
        .I1(\count_reg[4]_0 [0]),
        .I2(extra_a),
        .I3(\count_reg[4]_0 [1]),
        .O(\state_reg[1][1]_0 ));
  LUT6 #(
    .INIT(64'h0000000000000004)) 
    \state[1][0]_i_4 
       (.I0(\state_reg[1][0]_0 ),
        .I1(q_det),
        .I2(\state_reg[1][1]_2 ),
        .I3(\state_reg[0][0]_0 ),
        .I4(\count_reg[4]_0 [3]),
        .I5(\count_reg[4]_0 [2]),
        .O(\state_reg[1][0] ));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT4 #(
    .INIT(16'hBAAA)) 
    \state[1][0]_i_9 
       (.I0(count),
        .I1(extra_a),
        .I2(\count_reg[4]_0 [0]),
        .I3(\count_reg[4]_0 [1]),
        .O(\state_reg[1][1]_2 ));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \state[1][1]_i_10 
       (.I0(\count_reg[4]_0 [2]),
        .I1(\count_reg[4]_0 [3]),
        .O(\state_reg[1][1]_1 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFEFCFEFF)) 
    \state[1][1]_i_6 
       (.I0(\state_reg[1][1]_0 ),
        .I1(\state_reg[1][1]_1 ),
        .I2(\state_reg[0][0]_0 ),
        .I3(\state_reg[1][1]_2 ),
        .I4(q_det),
        .I5(\state_reg[1][0]_0 ),
        .O(\state_reg[1][1] ));
  LUT6 #(
    .INIT(64'hFFFEFFFFFFFFFFFF)) 
    \state[1][2]_i_2 
       (.I0(\count_reg[4]_0 [2]),
        .I1(\count_reg[4]_0 [3]),
        .I2(\state_reg[0][0]_0 ),
        .I3(\state_reg[1][1]_2 ),
        .I4(next_ifg_is_a_reg),
        .I5(\state_reg[1][1]_3 ),
        .O(\state_reg[1][2] ));
endmodule

(* ORIG_REF_NAME = "deskew_state_machine" *) 
module xaui_deskew_state_machine
   (mgt_enchansync,
    \status_vector[6] ,
    \tx_is_idle_pipe_reg[0] ,
    \rxc_out_reg[7] ,
    usrclk,
    usrclk_reset,
    sync_status,
    mgt_codevalid,
    mgt_rxdata,
    mgt_rxcharisk,
    \mgt_rxdata_reg_reg[36] ,
    \mgt_rxdata_reg_reg[20] ,
    \mgt_rxdata_reg_reg[52] );
  output mgt_enchansync;
  output \status_vector[6] ;
  output \tx_is_idle_pipe_reg[0] ;
  output \rxc_out_reg[7] ;
  input usrclk;
  input usrclk_reset;
  input sync_status;
  input [7:0]mgt_codevalid;
  input [48:0]mgt_rxdata;
  input [4:0]mgt_rxcharisk;
  input \mgt_rxdata_reg_reg[36] ;
  input \mgt_rxdata_reg_reg[20] ;
  input \mgt_rxdata_reg_reg[52] ;

  wire align_status_i;
  wire deskew_error;
  wire \deskew_error_reg_n_0_[0] ;
  wire enchansync_i;
  wire got_align;
  wire \got_align[0]_i_2_n_0 ;
  wire \got_align[0]_i_3_n_0 ;
  wire \got_align[0]_i_4_n_0 ;
  wire \got_align[0]_i_5_n_0 ;
  wire \got_align[1]_i_2_n_0 ;
  wire \got_align[1]_i_3_n_0 ;
  wire \got_align[1]_i_4_n_0 ;
  wire \got_align[1]_i_5_n_0 ;
  wire \got_align[1]_i_6_n_0 ;
  wire \got_align[1]_i_7_n_0 ;
  wire \got_align[1]_i_8_n_0 ;
  wire \got_align[1]_i_9_n_0 ;
  wire \got_align_reg_n_0_[0] ;
  wire [7:0]mgt_codevalid;
  wire mgt_enchansync;
  wire [4:0]mgt_rxcharisk;
  wire [48:0]mgt_rxdata;
  wire \mgt_rxdata_reg_reg[20] ;
  wire \mgt_rxdata_reg_reg[36] ;
  wire \mgt_rxdata_reg_reg[52] ;
  wire [1:0]p_1_out;
  wire [1:0]p_7_out;
  wire \rxc_out_reg[7] ;
  wire [0:0]state;
  wire \state[1][0]_i_1_n_0 ;
  wire \state[1][1]_i_1_n_0 ;
  wire \state[1][2]_i_1_n_0 ;
  wire \state[1][2]_i_2__0_n_0 ;
  wire \state[1][2]_i_3_n_0 ;
  wire \state[1][2]_i_5_n_0 ;
  wire \state_reg_n_0_[1][0] ;
  wire \state_reg_n_0_[1][1] ;
  wire \status_vector[6] ;
  wire sync_status;
  wire \tx_is_idle_pipe_reg[0] ;
  wire usrclk;
  wire usrclk_reset;

  FDRE align_status_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(align_status_i),
        .Q(\status_vector[6] ),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hFE7F)) 
    \deskew_error[0]_i_1 
       (.I0(\got_align[0]_i_5_n_0 ),
        .I1(\got_align[0]_i_4_n_0 ),
        .I2(\got_align[0]_i_3_n_0 ),
        .I3(\got_align[0]_i_2_n_0 ),
        .O(p_1_out[0]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hFE7F)) 
    \deskew_error[1]_i_1 
       (.I0(\got_align[1]_i_5_n_0 ),
        .I1(\got_align[1]_i_4_n_0 ),
        .I2(\got_align[1]_i_3_n_0 ),
        .I3(\got_align[1]_i_2_n_0 ),
        .O(p_1_out[1]));
  FDRE #(
    .INIT(1'b0)) 
    \deskew_error_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_1_out[0]),
        .Q(\deskew_error_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \deskew_error_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_1_out[1]),
        .Q(deskew_error),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h0010)) 
    enchansync_i_1
       (.I0(\state_reg_n_0_[1][0] ),
        .I1(align_status_i),
        .I2(sync_status),
        .I3(\state_reg_n_0_[1][1] ),
        .O(enchansync_i));
  FDRE enchansync_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(enchansync_i),
        .Q(mgt_enchansync),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \got_align[0]_i_1 
       (.I0(\got_align[0]_i_2_n_0 ),
        .I1(\got_align[0]_i_3_n_0 ),
        .I2(\got_align[0]_i_4_n_0 ),
        .I3(\got_align[0]_i_5_n_0 ),
        .O(p_7_out[0]));
  LUT5 #(
    .INIT(32'hF7FFFFFF)) 
    \got_align[0]_i_2 
       (.I0(mgt_codevalid[0]),
        .I1(mgt_rxdata[6]),
        .I2(mgt_rxdata[7]),
        .I3(mgt_rxdata[5]),
        .I4(\tx_is_idle_pipe_reg[0] ),
        .O(\got_align[0]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00800000)) 
    \got_align[0]_i_3 
       (.I0(\mgt_rxdata_reg_reg[52] ),
        .I1(mgt_codevalid[6]),
        .I2(mgt_rxdata[39]),
        .I3(mgt_rxdata[40]),
        .I4(mgt_rxdata[38]),
        .O(\got_align[0]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h20000000)) 
    \got_align[0]_i_4 
       (.I0(\mgt_rxdata_reg_reg[36] ),
        .I1(mgt_rxdata[29]),
        .I2(mgt_codevalid[4]),
        .I3(mgt_rxdata[27]),
        .I4(mgt_rxdata[28]),
        .O(\got_align[0]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00800000)) 
    \got_align[0]_i_5 
       (.I0(\mgt_rxdata_reg_reg[20] ),
        .I1(mgt_codevalid[2]),
        .I2(mgt_rxdata[17]),
        .I3(mgt_rxdata[18]),
        .I4(mgt_rxdata[16]),
        .O(\got_align[0]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \got_align[1]_i_1 
       (.I0(\got_align[1]_i_2_n_0 ),
        .I1(\got_align[1]_i_3_n_0 ),
        .I2(\got_align[1]_i_4_n_0 ),
        .I3(\got_align[1]_i_5_n_0 ),
        .O(p_7_out[1]));
  LUT5 #(
    .INIT(32'hFFFFBFFF)) 
    \got_align[1]_i_2 
       (.I0(mgt_rxdata[48]),
        .I1(mgt_codevalid[7]),
        .I2(mgt_rxdata[43]),
        .I3(mgt_rxdata[44]),
        .I4(\got_align[1]_i_6_n_0 ),
        .O(\got_align[1]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00000080)) 
    \got_align[1]_i_3 
       (.I0(mgt_rxcharisk[1]),
        .I1(mgt_rxdata[12]),
        .I2(mgt_codevalid[1]),
        .I3(mgt_rxdata[15]),
        .I4(\got_align[1]_i_7_n_0 ),
        .O(\got_align[1]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00002000)) 
    \got_align[1]_i_4 
       (.I0(mgt_codevalid[5]),
        .I1(mgt_rxdata[37]),
        .I2(mgt_rxdata[32]),
        .I3(mgt_rxdata[33]),
        .I4(\got_align[1]_i_8_n_0 ),
        .O(\got_align[1]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h00004000)) 
    \got_align[1]_i_5 
       (.I0(mgt_rxdata[26]),
        .I1(mgt_codevalid[3]),
        .I2(mgt_rxdata[21]),
        .I3(mgt_rxdata[22]),
        .I4(\got_align[1]_i_9_n_0 ),
        .O(\got_align[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFF7FFFFFFFFFFFF)) 
    \got_align[1]_i_6 
       (.I0(mgt_rxdata[47]),
        .I1(mgt_rxdata[46]),
        .I2(mgt_rxdata[42]),
        .I3(mgt_rxdata[41]),
        .I4(mgt_rxcharisk[4]),
        .I5(mgt_rxdata[45]),
        .O(\got_align[1]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFFF7FFFFFFFFFFFF)) 
    \got_align[1]_i_7 
       (.I0(mgt_rxdata[14]),
        .I1(mgt_rxdata[13]),
        .I2(mgt_rxdata[9]),
        .I3(mgt_rxdata[8]),
        .I4(mgt_rxdata[10]),
        .I5(mgt_rxdata[11]),
        .O(\got_align[1]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFFF7FFFFFFFFFFFF)) 
    \got_align[1]_i_8 
       (.I0(mgt_rxdata[36]),
        .I1(mgt_rxdata[35]),
        .I2(mgt_rxdata[31]),
        .I3(mgt_rxdata[30]),
        .I4(mgt_rxcharisk[3]),
        .I5(mgt_rxdata[34]),
        .O(\got_align[1]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF7FFF)) 
    \got_align[1]_i_9 
       (.I0(mgt_rxdata[25]),
        .I1(mgt_rxdata[24]),
        .I2(mgt_rxcharisk[2]),
        .I3(mgt_rxdata[23]),
        .I4(mgt_rxdata[20]),
        .I5(mgt_rxdata[19]),
        .O(\got_align[1]_i_9_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \got_align_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_7_out[0]),
        .Q(\got_align_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \got_align_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_7_out[1]),
        .Q(got_align),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \rxd_out[63]_i_1 
       (.I0(\status_vector[6] ),
        .O(\rxc_out_reg[7] ));
  LUT6 #(
    .INIT(64'h000000000055DB0A)) 
    \state[1][0]_i_1 
       (.I0(deskew_error),
        .I1(\state[1][2]_i_3_n_0 ),
        .I2(\state[1][2]_i_2__0_n_0 ),
        .I3(got_align),
        .I4(state),
        .I5(\state[1][2]_i_5_n_0 ),
        .O(\state[1][0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000020C0133D)) 
    \state[1][1]_i_1 
       (.I0(got_align),
        .I1(deskew_error),
        .I2(state),
        .I3(\state[1][2]_i_2__0_n_0 ),
        .I4(\state[1][2]_i_3_n_0 ),
        .I5(\state[1][2]_i_5_n_0 ),
        .O(\state[1][1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000044557555)) 
    \state[1][2]_i_1 
       (.I0(\state[1][2]_i_2__0_n_0 ),
        .I1(\state[1][2]_i_3_n_0 ),
        .I2(got_align),
        .I3(state),
        .I4(deskew_error),
        .I5(\state[1][2]_i_5_n_0 ),
        .O(\state[1][2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hC000DFFFFFFFFFFF)) 
    \state[1][2]_i_2__0 
       (.I0(\got_align_reg_n_0_[0] ),
        .I1(\deskew_error_reg_n_0_[0] ),
        .I2(\state_reg_n_0_[1][0] ),
        .I3(\state_reg_n_0_[1][1] ),
        .I4(align_status_i),
        .I5(sync_status),
        .O(\state[1][2]_i_2__0_n_0 ));
  LUT6 #(
    .INIT(64'hBF7F7BF7BF7F7777)) 
    \state[1][2]_i_3 
       (.I0(\state_reg_n_0_[1][1] ),
        .I1(sync_status),
        .I2(align_status_i),
        .I3(\state_reg_n_0_[1][0] ),
        .I4(\deskew_error_reg_n_0_[0] ),
        .I5(\got_align_reg_n_0_[0] ),
        .O(\state[1][2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h3614000026340000)) 
    \state[1][2]_i_4 
       (.I0(\deskew_error_reg_n_0_[0] ),
        .I1(\state_reg_n_0_[1][0] ),
        .I2(\got_align_reg_n_0_[0] ),
        .I3(align_status_i),
        .I4(sync_status),
        .I5(\state_reg_n_0_[1][1] ),
        .O(state));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \state[1][2]_i_5 
       (.I0(usrclk_reset),
        .I1(sync_status),
        .O(\state[1][2]_i_5_n_0 ));
  FDRE \state_reg[1][0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\state[1][0]_i_1_n_0 ),
        .Q(\state_reg_n_0_[1][0] ),
        .R(1'b0));
  FDRE \state_reg[1][1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\state[1][1]_i_1_n_0 ),
        .Q(\state_reg_n_0_[1][1] ),
        .R(1'b0));
  FDRE \state_reg[1][2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\state[1][2]_i_1_n_0 ),
        .Q(align_status_i),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0000000000008000)) 
    \tx_is_idle_pipe[0]_i_2 
       (.I0(mgt_rxdata[4]),
        .I1(mgt_rxcharisk[0]),
        .I2(mgt_rxdata[2]),
        .I3(mgt_rxdata[3]),
        .I4(mgt_rxdata[1]),
        .I5(mgt_rxdata[0]),
        .O(\tx_is_idle_pipe_reg[0] ));
endmodule

(* ORIG_REF_NAME = "k_r_prbs" *) 
module xaui_k_r_prbs
   (Q,
    usrclk_reset,
    usrclk);
  output [1:0]Q;
  input usrclk_reset;
  input usrclk;

  wire [1:0]Q;
  wire p_0_in;
  wire [6:0]p_2_out;
  wire usrclk;
  wire usrclk_reset;

  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \prbs[1]_i_1__0 
       (.I0(p_0_in),
        .I1(p_2_out[6]),
        .O(p_2_out[0]));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \prbs[2]_i_1 
       (.I0(Q[0]),
        .I1(p_0_in),
        .O(p_2_out[1]));
  FDSE \prbs_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_2_out[0]),
        .Q(p_2_out[2]),
        .S(usrclk_reset));
  FDSE \prbs_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_2_out[1]),
        .Q(p_2_out[3]),
        .S(usrclk_reset));
  FDSE \prbs_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_2_out[2]),
        .Q(p_2_out[4]),
        .S(usrclk_reset));
  FDSE \prbs_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_2_out[3]),
        .Q(p_2_out[5]),
        .S(usrclk_reset));
  FDSE \prbs_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_2_out[4]),
        .Q(p_2_out[6]),
        .S(usrclk_reset));
  FDSE \prbs_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_2_out[5]),
        .Q(p_0_in),
        .S(usrclk_reset));
  FDSE \prbs_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_2_out[6]),
        .Q(Q[0]),
        .S(usrclk_reset));
  FDSE \prbs_reg[8] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_0_in),
        .Q(Q[1]),
        .S(usrclk_reset));
endmodule

(* ORIG_REF_NAME = "rx" *) 
module xaui_rx
   (mgt_enchansync,
    align_status_int,
    mgt_enable_align,
    xgmii_rxd,
    xgmii_rxc,
    in0,
    usrclk,
    \signal_detect_int_reg[0] ,
    \signal_detect_int_reg[1] ,
    \signal_detect_int_reg[2] ,
    \signal_detect_int_reg[3] ,
    usrclk_reset,
    mgt_rx_reset,
    mgt_rxlock,
    mgt_rxdata,
    mgt_rxcharisk,
    mgt_codecomma,
    mgt_codevalid);
  output mgt_enchansync;
  output align_status_int;
  output [3:0]mgt_enable_align;
  output [63:0]xgmii_rxd;
  output [7:0]xgmii_rxc;
  output [3:0]in0;
  input usrclk;
  input \signal_detect_int_reg[0] ;
  input \signal_detect_int_reg[1] ;
  input \signal_detect_int_reg[2] ;
  input \signal_detect_int_reg[3] ;
  input usrclk_reset;
  input [3:0]mgt_rx_reset;
  input [3:0]mgt_rxlock;
  input [63:0]mgt_rxdata;
  input [7:0]mgt_rxcharisk;
  input [7:0]mgt_codecomma;
  input [7:0]mgt_codevalid;

  wire \G_PCS_SYNC_STATE[0].pcs_sync_state_n_1 ;
  wire \G_PCS_SYNC_STATE[0].pcs_sync_state_n_2 ;
  wire \G_PCS_SYNC_STATE[0].pcs_sync_state_n_3 ;
  wire \G_PCS_SYNC_STATE[0].pcs_sync_state_n_4 ;
  wire \G_PCS_SYNC_STATE[1].pcs_sync_state_n_1 ;
  wire \G_PCS_SYNC_STATE[1].pcs_sync_state_n_2 ;
  wire \G_PCS_SYNC_STATE[1].pcs_sync_state_n_3 ;
  wire \G_PCS_SYNC_STATE[1].pcs_sync_state_n_4 ;
  wire \G_PCS_SYNC_STATE[2].pcs_sync_state_n_1 ;
  wire \G_PCS_SYNC_STATE[2].pcs_sync_state_n_2 ;
  wire \G_PCS_SYNC_STATE[2].pcs_sync_state_n_3 ;
  wire \G_PCS_SYNC_STATE[2].pcs_sync_state_n_4 ;
  wire \G_PCS_SYNC_STATE[3].pcs_sync_state_n_1 ;
  wire \G_PCS_SYNC_STATE[3].pcs_sync_state_n_2 ;
  wire align_status_int;
  wire deskew_state_n_2;
  wire deskew_state_n_3;
  wire [3:0]in0;
  wire [7:0]mgt_codecomma;
  wire [7:0]mgt_codevalid;
  wire [3:0]mgt_enable_align;
  wire mgt_enchansync;
  wire [3:0]mgt_rx_reset;
  wire [7:0]mgt_rxcharisk;
  wire [63:0]mgt_rxdata;
  wire [3:0]mgt_rxlock;
  wire recoder_n_0;
  wire recoder_n_1;
  wire recoder_n_2;
  wire \signal_detect_int_reg[0] ;
  wire \signal_detect_int_reg[1] ;
  wire \signal_detect_int_reg[2] ;
  wire \signal_detect_int_reg[3] ;
  wire sync_status;
  wire sync_status_i_2_n_0;
  wire sync_status_int;
  wire usrclk;
  wire usrclk_reset;
  wire [7:0]xgmii_rxc;
  wire [63:0]xgmii_rxd;

  xaui_sync_state_machine \G_PCS_SYNC_STATE[0].pcs_sync_state 
       (.mgt_codecomma(mgt_codecomma[1:0]),
        .mgt_codevalid(mgt_codevalid[1:0]),
        .mgt_enable_align(mgt_enable_align[0]),
        .mgt_rx_reset(mgt_rx_reset[0]),
        .mgt_rxlock(mgt_rxlock[0]),
        .out({\G_PCS_SYNC_STATE[0].pcs_sync_state_n_1 ,\G_PCS_SYNC_STATE[0].pcs_sync_state_n_2 ,\G_PCS_SYNC_STATE[0].pcs_sync_state_n_3 }),
        .\signal_detect_int_reg[0] (\signal_detect_int_reg[0] ),
        .\sync_ok_reg[0] (\G_PCS_SYNC_STATE[0].pcs_sync_state_n_4 ),
        .usrclk(usrclk),
        .usrclk_reset(usrclk_reset));
  xaui_sync_state_machine_30 \G_PCS_SYNC_STATE[1].pcs_sync_state 
       (.mgt_codecomma(mgt_codecomma[3:2]),
        .mgt_codevalid(mgt_codevalid[3:2]),
        .mgt_enable_align(mgt_enable_align[1]),
        .mgt_rx_reset(mgt_rx_reset[1]),
        .mgt_rxlock(mgt_rxlock[1]),
        .out({\G_PCS_SYNC_STATE[1].pcs_sync_state_n_1 ,\G_PCS_SYNC_STATE[1].pcs_sync_state_n_2 ,\G_PCS_SYNC_STATE[1].pcs_sync_state_n_3 }),
        .\signal_detect_int_reg[1] (\signal_detect_int_reg[1] ),
        .\sync_ok_reg[1] (\G_PCS_SYNC_STATE[1].pcs_sync_state_n_4 ),
        .usrclk(usrclk),
        .usrclk_reset(usrclk_reset));
  xaui_sync_state_machine_31 \G_PCS_SYNC_STATE[2].pcs_sync_state 
       (.mgt_codecomma(mgt_codecomma[5:4]),
        .mgt_codevalid(mgt_codevalid[5:4]),
        .mgt_enable_align(mgt_enable_align[2]),
        .mgt_rx_reset(mgt_rx_reset[2]),
        .mgt_rxlock(mgt_rxlock[2]),
        .out({\G_PCS_SYNC_STATE[2].pcs_sync_state_n_1 ,\G_PCS_SYNC_STATE[2].pcs_sync_state_n_2 ,\G_PCS_SYNC_STATE[2].pcs_sync_state_n_3 }),
        .\signal_detect_int_reg[2] (\signal_detect_int_reg[2] ),
        .\sync_ok_reg[2] (\G_PCS_SYNC_STATE[2].pcs_sync_state_n_4 ),
        .usrclk(usrclk),
        .usrclk_reset(usrclk_reset));
  xaui_sync_state_machine_32 \G_PCS_SYNC_STATE[3].pcs_sync_state 
       (.mgt_codecomma(mgt_codecomma[7:6]),
        .mgt_codevalid(mgt_codevalid[7:6]),
        .mgt_enable_align(mgt_enable_align[3]),
        .mgt_rx_reset(mgt_rx_reset[3]),
        .mgt_rxlock(mgt_rxlock[3]),
        .out(\G_PCS_SYNC_STATE[3].pcs_sync_state_n_1 ),
        .\signal_detect_int_reg[3] (\signal_detect_int_reg[3] ),
        .\sync_ok_reg[3] (\G_PCS_SYNC_STATE[3].pcs_sync_state_n_2 ),
        .usrclk(usrclk),
        .usrclk_reset(usrclk_reset));
  xaui_deskew_state_machine deskew_state
       (.mgt_codevalid(mgt_codevalid),
        .mgt_enchansync(mgt_enchansync),
        .mgt_rxcharisk({mgt_rxcharisk[7],mgt_rxcharisk[5],mgt_rxcharisk[3],mgt_rxcharisk[1:0]}),
        .mgt_rxdata({mgt_rxdata[63:53],mgt_rxdata[47:37],mgt_rxdata[31:21],mgt_rxdata[15:0]}),
        .\mgt_rxdata_reg_reg[20] (recoder_n_1),
        .\mgt_rxdata_reg_reg[36] (recoder_n_0),
        .\mgt_rxdata_reg_reg[52] (recoder_n_2),
        .\rxc_out_reg[7] (deskew_state_n_3),
        .\status_vector[6] (align_status_int),
        .sync_status(sync_status),
        .\tx_is_idle_pipe_reg[0] (deskew_state_n_2),
        .usrclk(usrclk),
        .usrclk_reset(usrclk_reset));
  xaui_rx_recoder recoder
       (.align_status_reg(align_status_int),
        .align_status_reg_0(deskew_state_n_3),
        .mgt_codevalid(mgt_codevalid),
        .mgt_rxcharisk(mgt_rxcharisk),
        .mgt_rxdata(mgt_rxdata),
        .\mgt_rxdata_reg_reg[4] (deskew_state_n_2),
        .\tx_is_idle_pipe_reg[1]_0 (recoder_n_1),
        .\tx_is_idle_pipe_reg[2]_0 (recoder_n_0),
        .\tx_is_idle_pipe_reg[3]_0 (recoder_n_2),
        .usrclk(usrclk),
        .xgmii_rxc(xgmii_rxc),
        .xgmii_rxd(xgmii_rxd));
  FDSE \sync_ok_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\G_PCS_SYNC_STATE[0].pcs_sync_state_n_4 ),
        .Q(in0[0]),
        .S(\G_PCS_SYNC_STATE[0].pcs_sync_state_n_1 ));
  FDSE \sync_ok_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\G_PCS_SYNC_STATE[1].pcs_sync_state_n_4 ),
        .Q(in0[1]),
        .S(\G_PCS_SYNC_STATE[1].pcs_sync_state_n_1 ));
  FDSE \sync_ok_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\G_PCS_SYNC_STATE[2].pcs_sync_state_n_4 ),
        .Q(in0[2]),
        .S(\G_PCS_SYNC_STATE[2].pcs_sync_state_n_1 ));
  FDSE \sync_ok_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\G_PCS_SYNC_STATE[3].pcs_sync_state_n_2 ),
        .Q(in0[3]),
        .S(\G_PCS_SYNC_STATE[3].pcs_sync_state_n_1 ));
  LUT6 #(
    .INIT(64'h00000000EEEEEEE0)) 
    sync_status_i_1
       (.I0(\G_PCS_SYNC_STATE[3].pcs_sync_state_n_2 ),
        .I1(\G_PCS_SYNC_STATE[3].pcs_sync_state_n_1 ),
        .I2(\G_PCS_SYNC_STATE[2].pcs_sync_state_n_3 ),
        .I3(\G_PCS_SYNC_STATE[2].pcs_sync_state_n_2 ),
        .I4(\G_PCS_SYNC_STATE[2].pcs_sync_state_n_1 ),
        .I5(sync_status_i_2_n_0),
        .O(sync_status_int));
  LUT6 #(
    .INIT(64'h01010101010101FF)) 
    sync_status_i_2
       (.I0(\G_PCS_SYNC_STATE[1].pcs_sync_state_n_1 ),
        .I1(\G_PCS_SYNC_STATE[1].pcs_sync_state_n_2 ),
        .I2(\G_PCS_SYNC_STATE[1].pcs_sync_state_n_3 ),
        .I3(\G_PCS_SYNC_STATE[0].pcs_sync_state_n_1 ),
        .I4(\G_PCS_SYNC_STATE[0].pcs_sync_state_n_2 ),
        .I5(\G_PCS_SYNC_STATE[0].pcs_sync_state_n_3 ),
        .O(sync_status_i_2_n_0));
  FDRE sync_status_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(sync_status_int),
        .Q(sync_status),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "rx_recoder" *) 
module xaui_rx_recoder
   (\tx_is_idle_pipe_reg[2]_0 ,
    \tx_is_idle_pipe_reg[1]_0 ,
    \tx_is_idle_pipe_reg[3]_0 ,
    xgmii_rxd,
    xgmii_rxc,
    align_status_reg,
    mgt_rxdata,
    mgt_rxcharisk,
    mgt_codevalid,
    \mgt_rxdata_reg_reg[4] ,
    usrclk,
    align_status_reg_0);
  output \tx_is_idle_pipe_reg[2]_0 ;
  output \tx_is_idle_pipe_reg[1]_0 ;
  output \tx_is_idle_pipe_reg[3]_0 ;
  output [63:0]xgmii_rxd;
  output [7:0]xgmii_rxc;
  input align_status_reg;
  input [63:0]mgt_rxdata;
  input [7:0]mgt_rxcharisk;
  input [7:0]mgt_codevalid;
  input \mgt_rxdata_reg_reg[4] ;
  input usrclk;
  input align_status_reg_0;

  wire align_status_reg;
  wire align_status_reg_0;
  wire c11_in;
  wire c153_in;
  wire c3_in;
  wire c72_in;
  wire c75_in;
  wire c78_in;
  wire c7_in;
  wire [7:0]code_error;
  wire [7:0]code_error_delay;
  wire \code_error_pipe[0]_i_2_n_0 ;
  wire \code_error_pipe[0]_i_3_n_0 ;
  wire \code_error_pipe[1]_i_2_n_0 ;
  wire \code_error_pipe[1]_i_3_n_0 ;
  wire \code_error_pipe[2]_i_2_n_0 ;
  wire \code_error_pipe[2]_i_3_n_0 ;
  wire \code_error_pipe[3]_i_2_n_0 ;
  wire \code_error_pipe[3]_i_3_n_0 ;
  wire \code_error_pipe[4]_i_2_n_0 ;
  wire \code_error_pipe[4]_i_3_n_0 ;
  wire \code_error_pipe[4]_i_4_n_0 ;
  wire \code_error_pipe[5]_i_2_n_0 ;
  wire \code_error_pipe[5]_i_3_n_0 ;
  wire \code_error_pipe[5]_i_4_n_0 ;
  wire \code_error_pipe[6]_i_2_n_0 ;
  wire \code_error_pipe[6]_i_3_n_0 ;
  wire \code_error_pipe[7]_i_2_n_0 ;
  wire \code_error_pipe[7]_i_3_n_0 ;
  wire \code_error_pipe_reg_n_0_[4] ;
  wire \code_error_pipe_reg_n_0_[5] ;
  wire \code_error_pipe_reg_n_0_[6] ;
  wire \code_error_pipe_reg_n_0_[7] ;
  wire [3:0]lane_term_pipe;
  wire \lane_terminate_temp[0]_i_2_n_0 ;
  wire \lane_terminate_temp[1]_i_2_n_0 ;
  wire \lane_terminate_temp[2]_i_2_n_0 ;
  wire \lane_terminate_temp[3]_i_2_n_0 ;
  wire \lane_terminate_temp[4]_i_2_n_0 ;
  wire \lane_terminate_temp[5]_i_2_n_0 ;
  wire \lane_terminate_temp[6]_i_2_n_0 ;
  wire \lane_terminate_temp[7]_i_2_n_0 ;
  wire \lane_terminate_temp_reg_n_0_[0] ;
  wire \lane_terminate_temp_reg_n_0_[2] ;
  wire \lane_terminate_temp_reg_n_0_[3] ;
  wire \lane_terminate_temp_reg_n_0_[4] ;
  wire \lane_terminate_temp_reg_n_0_[5] ;
  wire \lane_terminate_temp_reg_n_0_[6] ;
  wire \lane_terminate_temp_reg_n_0_[7] ;
  wire [7:0]mgt_codevalid;
  wire [7:0]mgt_rxcharisk;
  wire [63:0]mgt_rxdata;
  wire \mgt_rxdata_reg_reg[4] ;
  wire p_0_in0_in;
  wire p_11_in;
  wire [3:0]p_15_out;
  wire [7:0]p_21_out;
  wire p_2_in;
  wire p_2_in_0;
  wire [7:0]p_3_in;
  wire p_4_in;
  wire [7:0]p_5_in;
  wire [3:0]rxc_half_pipe;
  wire \rxc_out[0]_i_1_n_0 ;
  wire \rxc_out[1]_i_1_n_0 ;
  wire \rxc_out[2]_i_1_n_0 ;
  wire \rxc_out[3]_i_1_n_0 ;
  wire \rxc_out[4]_i_1_n_0 ;
  wire \rxc_out[5]_i_1_n_0 ;
  wire \rxc_out[6]_i_1_n_0 ;
  wire \rxc_out[7]_i_1_n_0 ;
  wire \rxc_pipe_reg_n_0_[0] ;
  wire [31:0]rxd_half_pipe;
  wire \rxd_out[0]_i_1_n_0 ;
  wire \rxd_out[10]_i_1_n_0 ;
  wire \rxd_out[11]_i_1_n_0 ;
  wire \rxd_out[12]_i_1_n_0 ;
  wire \rxd_out[13]_i_1_n_0 ;
  wire \rxd_out[14]_i_1_n_0 ;
  wire \rxd_out[15]_i_1_n_0 ;
  wire \rxd_out[15]_i_2_n_0 ;
  wire \rxd_out[15]_i_3_n_0 ;
  wire \rxd_out[15]_i_4_n_0 ;
  wire \rxd_out[15]_i_5_n_0 ;
  wire \rxd_out[15]_i_6_n_0 ;
  wire \rxd_out[16]_i_1_n_0 ;
  wire \rxd_out[17]_i_1_n_0 ;
  wire \rxd_out[18]_i_1_n_0 ;
  wire \rxd_out[19]_i_1_n_0 ;
  wire \rxd_out[1]_i_1_n_0 ;
  wire \rxd_out[20]_i_1_n_0 ;
  wire \rxd_out[21]_i_1_n_0 ;
  wire \rxd_out[22]_i_1_n_0 ;
  wire \rxd_out[23]_i_1_n_0 ;
  wire \rxd_out[23]_i_2_n_0 ;
  wire \rxd_out[23]_i_3_n_0 ;
  wire \rxd_out[23]_i_4_n_0 ;
  wire \rxd_out[23]_i_5_n_0 ;
  wire \rxd_out[23]_i_6_n_0 ;
  wire \rxd_out[24]_i_1_n_0 ;
  wire \rxd_out[25]_i_1_n_0 ;
  wire \rxd_out[26]_i_1_n_0 ;
  wire \rxd_out[27]_i_1_n_0 ;
  wire \rxd_out[28]_i_1_n_0 ;
  wire \rxd_out[29]_i_1_n_0 ;
  wire \rxd_out[2]_i_1_n_0 ;
  wire \rxd_out[30]_i_1_n_0 ;
  wire \rxd_out[31]_i_1_n_0 ;
  wire \rxd_out[31]_i_2_n_0 ;
  wire \rxd_out[31]_i_3_n_0 ;
  wire \rxd_out[31]_i_4_n_0 ;
  wire \rxd_out[32]_i_1_n_0 ;
  wire \rxd_out[33]_i_1_n_0 ;
  wire \rxd_out[33]_i_2_n_0 ;
  wire \rxd_out[33]_i_3_n_0 ;
  wire \rxd_out[34]_i_1_n_0 ;
  wire \rxd_out[35]_i_1_n_0 ;
  wire \rxd_out[36]_i_1_n_0 ;
  wire \rxd_out[37]_i_1_n_0 ;
  wire \rxd_out[38]_i_1_n_0 ;
  wire \rxd_out[38]_i_2_n_0 ;
  wire \rxd_out[39]_i_1_n_0 ;
  wire \rxd_out[39]_i_2_n_0 ;
  wire \rxd_out[39]_i_3_n_0 ;
  wire \rxd_out[39]_i_4_n_0 ;
  wire \rxd_out[39]_i_5_n_0 ;
  wire \rxd_out[39]_i_6_n_0 ;
  wire \rxd_out[3]_i_1_n_0 ;
  wire \rxd_out[40]_i_1_n_0 ;
  wire \rxd_out[41]_i_1_n_0 ;
  wire \rxd_out[42]_i_1_n_0 ;
  wire \rxd_out[43]_i_1_n_0 ;
  wire \rxd_out[44]_i_1_n_0 ;
  wire \rxd_out[45]_i_1_n_0 ;
  wire \rxd_out[46]_i_1_n_0 ;
  wire \rxd_out[47]_i_1_n_0 ;
  wire \rxd_out[47]_i_2_n_0 ;
  wire \rxd_out[47]_i_3_n_0 ;
  wire \rxd_out[47]_i_4_n_0 ;
  wire \rxd_out[47]_i_5_n_0 ;
  wire \rxd_out[47]_i_6_n_0 ;
  wire \rxd_out[48]_i_1_n_0 ;
  wire \rxd_out[49]_i_1_n_0 ;
  wire \rxd_out[4]_i_1_n_0 ;
  wire \rxd_out[50]_i_1_n_0 ;
  wire \rxd_out[51]_i_1_n_0 ;
  wire \rxd_out[52]_i_1_n_0 ;
  wire \rxd_out[53]_i_1_n_0 ;
  wire \rxd_out[54]_i_1_n_0 ;
  wire \rxd_out[55]_i_1_n_0 ;
  wire \rxd_out[55]_i_2_n_0 ;
  wire \rxd_out[55]_i_3_n_0 ;
  wire \rxd_out[55]_i_4_n_0 ;
  wire \rxd_out[55]_i_5_n_0 ;
  wire \rxd_out[55]_i_6_n_0 ;
  wire \rxd_out[55]_i_7_n_0 ;
  wire \rxd_out[56]_i_1_n_0 ;
  wire \rxd_out[57]_i_1_n_0 ;
  wire \rxd_out[58]_i_1_n_0 ;
  wire \rxd_out[59]_i_1_n_0 ;
  wire \rxd_out[5]_i_1_n_0 ;
  wire \rxd_out[60]_i_1_n_0 ;
  wire \rxd_out[61]_i_1_n_0 ;
  wire \rxd_out[62]_i_1_n_0 ;
  wire \rxd_out[63]_i_2_n_0 ;
  wire \rxd_out[63]_i_3_n_0 ;
  wire \rxd_out[63]_i_4_n_0 ;
  wire \rxd_out[63]_i_5_n_0 ;
  wire \rxd_out[63]_i_6_n_0 ;
  wire \rxd_out[6]_i_1_n_0 ;
  wire \rxd_out[6]_i_2_n_0 ;
  wire \rxd_out[6]_i_3_n_0 ;
  wire \rxd_out[7]_i_1_n_0 ;
  wire \rxd_out[7]_i_2_n_0 ;
  wire \rxd_out[7]_i_3_n_0 ;
  wire \rxd_out[7]_i_4_n_0 ;
  wire \rxd_out[7]_i_5_n_0 ;
  wire \rxd_out[8]_i_1_n_0 ;
  wire \rxd_out[9]_i_1_n_0 ;
  wire \rxd_pipe_reg_n_0_[0] ;
  wire \rxd_pipe_reg_n_0_[1] ;
  wire \rxd_pipe_reg_n_0_[24] ;
  wire \rxd_pipe_reg_n_0_[25] ;
  wire \rxd_pipe_reg_n_0_[26] ;
  wire \rxd_pipe_reg_n_0_[27] ;
  wire \rxd_pipe_reg_n_0_[28] ;
  wire \rxd_pipe_reg_n_0_[29] ;
  wire \rxd_pipe_reg_n_0_[2] ;
  wire \rxd_pipe_reg_n_0_[30] ;
  wire \rxd_pipe_reg_n_0_[31] ;
  wire \rxd_pipe_reg_n_0_[32] ;
  wire \rxd_pipe_reg_n_0_[33] ;
  wire \rxd_pipe_reg_n_0_[34] ;
  wire \rxd_pipe_reg_n_0_[35] ;
  wire \rxd_pipe_reg_n_0_[36] ;
  wire \rxd_pipe_reg_n_0_[37] ;
  wire \rxd_pipe_reg_n_0_[38] ;
  wire \rxd_pipe_reg_n_0_[39] ;
  wire \rxd_pipe_reg_n_0_[3] ;
  wire \rxd_pipe_reg_n_0_[40] ;
  wire \rxd_pipe_reg_n_0_[41] ;
  wire \rxd_pipe_reg_n_0_[42] ;
  wire \rxd_pipe_reg_n_0_[43] ;
  wire \rxd_pipe_reg_n_0_[44] ;
  wire \rxd_pipe_reg_n_0_[45] ;
  wire \rxd_pipe_reg_n_0_[46] ;
  wire \rxd_pipe_reg_n_0_[47] ;
  wire \rxd_pipe_reg_n_0_[48] ;
  wire \rxd_pipe_reg_n_0_[49] ;
  wire \rxd_pipe_reg_n_0_[4] ;
  wire \rxd_pipe_reg_n_0_[50] ;
  wire \rxd_pipe_reg_n_0_[51] ;
  wire \rxd_pipe_reg_n_0_[52] ;
  wire \rxd_pipe_reg_n_0_[53] ;
  wire \rxd_pipe_reg_n_0_[54] ;
  wire \rxd_pipe_reg_n_0_[55] ;
  wire \rxd_pipe_reg_n_0_[56] ;
  wire \rxd_pipe_reg_n_0_[57] ;
  wire \rxd_pipe_reg_n_0_[58] ;
  wire \rxd_pipe_reg_n_0_[59] ;
  wire \rxd_pipe_reg_n_0_[5] ;
  wire \rxd_pipe_reg_n_0_[60] ;
  wire \rxd_pipe_reg_n_0_[61] ;
  wire \rxd_pipe_reg_n_0_[62] ;
  wire \rxd_pipe_reg_n_0_[63] ;
  wire \rxd_pipe_reg_n_0_[6] ;
  wire \rxd_pipe_reg_n_0_[7] ;
  wire \tx_is_idle_half_pipe[0]_i_2_n_0 ;
  wire \tx_is_idle_half_pipe[1]_i_2_n_0 ;
  wire \tx_is_idle_half_pipe[2]_i_2_n_0 ;
  wire \tx_is_idle_half_pipe[3]_i_2_n_0 ;
  wire \tx_is_idle_half_pipe_reg_n_0_[0] ;
  wire \tx_is_idle_half_pipe_reg_n_0_[1] ;
  wire \tx_is_idle_half_pipe_reg_n_0_[3] ;
  wire \tx_is_idle_pipe[0]_i_1_n_0 ;
  wire \tx_is_idle_pipe[1]_i_1_n_0 ;
  wire \tx_is_idle_pipe[2]_i_1_n_0 ;
  wire \tx_is_idle_pipe[3]_i_1_n_0 ;
  wire \tx_is_idle_pipe_reg[1]_0 ;
  wire \tx_is_idle_pipe_reg[2]_0 ;
  wire \tx_is_idle_pipe_reg[3]_0 ;
  wire \tx_is_idle_pipe_reg_n_0_[0] ;
  wire usrclk;
  wire [7:0]xgmii_rxc;
  wire [63:0]xgmii_rxd;

  FDRE #(
    .INIT(1'b0)) 
    \code_error_delay_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\code_error_pipe_reg_n_0_[4] ),
        .Q(code_error_delay[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \code_error_delay_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\code_error_pipe_reg_n_0_[5] ),
        .Q(code_error_delay[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \code_error_delay_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\code_error_pipe_reg_n_0_[6] ),
        .Q(code_error_delay[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \code_error_delay_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\code_error_pipe_reg_n_0_[7] ),
        .Q(code_error_delay[3]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFF540000FFFFFFFF)) 
    \code_error_pipe[0]_i_1 
       (.I0(\code_error_pipe[0]_i_2_n_0 ),
        .I1(mgt_rxdata[1]),
        .I2(mgt_rxdata[0]),
        .I3(\code_error_pipe[0]_i_3_n_0 ),
        .I4(mgt_rxcharisk[0]),
        .I5(mgt_codevalid[0]),
        .O(code_error[0]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'h80)) 
    \code_error_pipe[0]_i_2 
       (.I0(mgt_rxdata[5]),
        .I1(mgt_rxdata[7]),
        .I2(mgt_rxdata[6]),
        .O(\code_error_pipe[0]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h9777FFFF)) 
    \code_error_pipe[0]_i_3 
       (.I0(mgt_rxdata[3]),
        .I1(mgt_rxdata[2]),
        .I2(mgt_rxdata[0]),
        .I3(mgt_rxdata[1]),
        .I4(mgt_rxdata[4]),
        .O(\code_error_pipe[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFF540000FFFFFFFF)) 
    \code_error_pipe[1]_i_1 
       (.I0(\code_error_pipe[1]_i_2_n_0 ),
        .I1(mgt_rxdata[17]),
        .I2(mgt_rxdata[16]),
        .I3(\code_error_pipe[1]_i_3_n_0 ),
        .I4(mgt_rxcharisk[2]),
        .I5(mgt_codevalid[2]),
        .O(code_error[1]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h80)) 
    \code_error_pipe[1]_i_2 
       (.I0(mgt_rxdata[21]),
        .I1(mgt_rxdata[23]),
        .I2(mgt_rxdata[22]),
        .O(\code_error_pipe[1]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hD77F7F7F)) 
    \code_error_pipe[1]_i_3 
       (.I0(mgt_rxdata[20]),
        .I1(mgt_rxdata[19]),
        .I2(mgt_rxdata[18]),
        .I3(mgt_rxdata[16]),
        .I4(mgt_rxdata[17]),
        .O(\code_error_pipe[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFF540000FFFFFFFF)) 
    \code_error_pipe[2]_i_1 
       (.I0(\code_error_pipe[2]_i_2_n_0 ),
        .I1(mgt_rxdata[33]),
        .I2(mgt_rxdata[32]),
        .I3(\code_error_pipe[2]_i_3_n_0 ),
        .I4(mgt_rxcharisk[4]),
        .I5(mgt_codevalid[4]),
        .O(code_error[2]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'h80)) 
    \code_error_pipe[2]_i_2 
       (.I0(mgt_rxdata[39]),
        .I1(mgt_rxdata[38]),
        .I2(mgt_rxdata[37]),
        .O(\code_error_pipe[2]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hD77F7F7F)) 
    \code_error_pipe[2]_i_3 
       (.I0(mgt_rxdata[36]),
        .I1(mgt_rxdata[35]),
        .I2(mgt_rxdata[34]),
        .I3(mgt_rxdata[32]),
        .I4(mgt_rxdata[33]),
        .O(\code_error_pipe[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFF540000FFFFFFFF)) 
    \code_error_pipe[3]_i_1 
       (.I0(\code_error_pipe[3]_i_2_n_0 ),
        .I1(mgt_rxdata[49]),
        .I2(mgt_rxdata[48]),
        .I3(\code_error_pipe[3]_i_3_n_0 ),
        .I4(mgt_rxcharisk[6]),
        .I5(mgt_codevalid[6]),
        .O(code_error[3]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h80)) 
    \code_error_pipe[3]_i_2 
       (.I0(mgt_rxdata[53]),
        .I1(mgt_rxdata[55]),
        .I2(mgt_rxdata[54]),
        .O(\code_error_pipe[3]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h9777FFFF)) 
    \code_error_pipe[3]_i_3 
       (.I0(mgt_rxdata[51]),
        .I1(mgt_rxdata[50]),
        .I2(mgt_rxdata[48]),
        .I3(mgt_rxdata[49]),
        .I4(mgt_rxdata[52]),
        .O(\code_error_pipe[3]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFD00FFFF)) 
    \code_error_pipe[4]_i_1 
       (.I0(\code_error_pipe[4]_i_2_n_0 ),
        .I1(\code_error_pipe[4]_i_3_n_0 ),
        .I2(\code_error_pipe[4]_i_4_n_0 ),
        .I3(mgt_rxcharisk[1]),
        .I4(mgt_codevalid[1]),
        .O(code_error[4]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hA8)) 
    \code_error_pipe[4]_i_2 
       (.I0(mgt_rxdata[12]),
        .I1(mgt_rxdata[11]),
        .I2(mgt_rxdata[10]),
        .O(\code_error_pipe[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'h8777)) 
    \code_error_pipe[4]_i_3 
       (.I0(mgt_rxdata[11]),
        .I1(mgt_rxdata[10]),
        .I2(mgt_rxdata[8]),
        .I3(mgt_rxdata[9]),
        .O(\code_error_pipe[4]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h0EEEEEEE)) 
    \code_error_pipe[4]_i_4 
       (.I0(mgt_rxdata[8]),
        .I1(mgt_rxdata[9]),
        .I2(mgt_rxdata[15]),
        .I3(mgt_rxdata[13]),
        .I4(mgt_rxdata[14]),
        .O(\code_error_pipe[4]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFD00FFFF)) 
    \code_error_pipe[5]_i_1 
       (.I0(\code_error_pipe[5]_i_2_n_0 ),
        .I1(\code_error_pipe[5]_i_3_n_0 ),
        .I2(\code_error_pipe[5]_i_4_n_0 ),
        .I3(mgt_rxcharisk[3]),
        .I4(mgt_codevalid[3]),
        .O(code_error[5]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hA8)) 
    \code_error_pipe[5]_i_2 
       (.I0(mgt_rxdata[28]),
        .I1(mgt_rxdata[27]),
        .I2(mgt_rxdata[26]),
        .O(\code_error_pipe[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'h8777)) 
    \code_error_pipe[5]_i_3 
       (.I0(mgt_rxdata[27]),
        .I1(mgt_rxdata[26]),
        .I2(mgt_rxdata[24]),
        .I3(mgt_rxdata[25]),
        .O(\code_error_pipe[5]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h0EEEEEEE)) 
    \code_error_pipe[5]_i_4 
       (.I0(mgt_rxdata[24]),
        .I1(mgt_rxdata[25]),
        .I2(mgt_rxdata[31]),
        .I3(mgt_rxdata[29]),
        .I4(mgt_rxdata[30]),
        .O(\code_error_pipe[5]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFA80000FFFFFFFF)) 
    \code_error_pipe[6]_i_1 
       (.I0(\code_error_pipe[6]_i_2_n_0 ),
        .I1(mgt_rxdata[41]),
        .I2(mgt_rxdata[40]),
        .I3(\code_error_pipe[6]_i_3_n_0 ),
        .I4(mgt_rxcharisk[5]),
        .I5(mgt_codevalid[5]),
        .O(code_error[6]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    \code_error_pipe[6]_i_2 
       (.I0(mgt_rxdata[46]),
        .I1(mgt_rxdata[45]),
        .I2(mgt_rxdata[47]),
        .O(\code_error_pipe[6]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h9777FFFF)) 
    \code_error_pipe[6]_i_3 
       (.I0(mgt_rxdata[43]),
        .I1(mgt_rxdata[42]),
        .I2(mgt_rxdata[40]),
        .I3(mgt_rxdata[41]),
        .I4(mgt_rxdata[44]),
        .O(\code_error_pipe[6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFA80000FFFFFFFF)) 
    \code_error_pipe[7]_i_1 
       (.I0(\code_error_pipe[7]_i_2_n_0 ),
        .I1(mgt_rxdata[57]),
        .I2(mgt_rxdata[56]),
        .I3(\code_error_pipe[7]_i_3_n_0 ),
        .I4(mgt_rxcharisk[7]),
        .I5(mgt_codevalid[7]),
        .O(code_error[7]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    \code_error_pipe[7]_i_2 
       (.I0(mgt_rxdata[62]),
        .I1(mgt_rxdata[61]),
        .I2(mgt_rxdata[63]),
        .O(\code_error_pipe[7]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hD57F7FFF)) 
    \code_error_pipe[7]_i_3 
       (.I0(mgt_rxdata[60]),
        .I1(mgt_rxdata[57]),
        .I2(mgt_rxdata[56]),
        .I3(mgt_rxdata[58]),
        .I4(mgt_rxdata[59]),
        .O(\code_error_pipe[7]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \code_error_pipe_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(code_error[0]),
        .Q(code_error_delay[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \code_error_pipe_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(code_error[1]),
        .Q(code_error_delay[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \code_error_pipe_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(code_error[2]),
        .Q(code_error_delay[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \code_error_pipe_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(code_error[3]),
        .Q(code_error_delay[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \code_error_pipe_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(code_error[4]),
        .Q(\code_error_pipe_reg_n_0_[4] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \code_error_pipe_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(code_error[5]),
        .Q(\code_error_pipe_reg_n_0_[5] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \code_error_pipe_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(code_error[6]),
        .Q(\code_error_pipe_reg_n_0_[6] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \code_error_pipe_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(code_error[7]),
        .Q(\code_error_pipe_reg_n_0_[7] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \lane_term_pipe_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\lane_terminate_temp_reg_n_0_[4] ),
        .Q(lane_term_pipe[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \lane_term_pipe_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\lane_terminate_temp_reg_n_0_[5] ),
        .Q(lane_term_pipe[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \lane_term_pipe_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\lane_terminate_temp_reg_n_0_[6] ),
        .Q(lane_term_pipe[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \lane_term_pipe_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\lane_terminate_temp_reg_n_0_[7] ),
        .Q(lane_term_pipe[3]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT5 #(
    .INIT(32'h00008000)) 
    \lane_terminate_temp[0]_i_1 
       (.I0(\lane_terminate_temp[0]_i_2_n_0 ),
        .I1(mgt_rxdata[5]),
        .I2(mgt_rxdata[7]),
        .I3(mgt_rxdata[6]),
        .I4(code_error[0]),
        .O(p_21_out[0]));
  LUT6 #(
    .INIT(64'h0080000000000000)) 
    \lane_terminate_temp[0]_i_2 
       (.I0(mgt_rxdata[4]),
        .I1(mgt_rxcharisk[0]),
        .I2(mgt_rxdata[0]),
        .I3(mgt_rxdata[1]),
        .I4(mgt_rxdata[2]),
        .I5(mgt_rxdata[3]),
        .O(\lane_terminate_temp[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h00008000)) 
    \lane_terminate_temp[1]_i_1 
       (.I0(\lane_terminate_temp[1]_i_2_n_0 ),
        .I1(mgt_rxdata[21]),
        .I2(mgt_rxdata[23]),
        .I3(mgt_rxdata[22]),
        .I4(code_error[1]),
        .O(p_21_out[1]));
  LUT6 #(
    .INIT(64'h0080000000000000)) 
    \lane_terminate_temp[1]_i_2 
       (.I0(mgt_rxdata[20]),
        .I1(mgt_rxcharisk[2]),
        .I2(mgt_rxdata[16]),
        .I3(mgt_rxdata[17]),
        .I4(mgt_rxdata[18]),
        .I5(mgt_rxdata[19]),
        .O(\lane_terminate_temp[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'h00008000)) 
    \lane_terminate_temp[2]_i_1 
       (.I0(\lane_terminate_temp[2]_i_2_n_0 ),
        .I1(mgt_rxdata[39]),
        .I2(mgt_rxdata[38]),
        .I3(mgt_rxdata[37]),
        .I4(code_error[2]),
        .O(p_21_out[2]));
  LUT6 #(
    .INIT(64'h0080000000000000)) 
    \lane_terminate_temp[2]_i_2 
       (.I0(mgt_rxdata[36]),
        .I1(mgt_rxcharisk[4]),
        .I2(mgt_rxdata[32]),
        .I3(mgt_rxdata[33]),
        .I4(mgt_rxdata[34]),
        .I5(mgt_rxdata[35]),
        .O(\lane_terminate_temp[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT5 #(
    .INIT(32'h00008000)) 
    \lane_terminate_temp[3]_i_1 
       (.I0(\lane_terminate_temp[3]_i_2_n_0 ),
        .I1(mgt_rxdata[53]),
        .I2(mgt_rxdata[55]),
        .I3(mgt_rxdata[54]),
        .I4(code_error[3]),
        .O(p_21_out[3]));
  LUT6 #(
    .INIT(64'h0080000000000000)) 
    \lane_terminate_temp[3]_i_2 
       (.I0(mgt_rxdata[52]),
        .I1(mgt_rxcharisk[6]),
        .I2(mgt_rxdata[48]),
        .I3(mgt_rxdata[49]),
        .I4(mgt_rxdata[50]),
        .I5(mgt_rxdata[51]),
        .O(\lane_terminate_temp[3]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00004000)) 
    \lane_terminate_temp[4]_i_1 
       (.I0(\lane_terminate_temp[4]_i_2_n_0 ),
        .I1(mgt_rxdata[14]),
        .I2(mgt_rxdata[13]),
        .I3(mgt_rxdata[15]),
        .I4(code_error[4]),
        .O(p_21_out[4]));
  LUT6 #(
    .INIT(64'hF7FFFFFFFFFFFFFF)) 
    \lane_terminate_temp[4]_i_2 
       (.I0(mgt_rxdata[11]),
        .I1(mgt_rxdata[10]),
        .I2(mgt_rxdata[9]),
        .I3(mgt_rxdata[8]),
        .I4(mgt_rxcharisk[1]),
        .I5(mgt_rxdata[12]),
        .O(\lane_terminate_temp[4]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00004000)) 
    \lane_terminate_temp[5]_i_1 
       (.I0(\lane_terminate_temp[5]_i_2_n_0 ),
        .I1(mgt_rxdata[30]),
        .I2(mgt_rxdata[29]),
        .I3(mgt_rxdata[31]),
        .I4(code_error[5]),
        .O(p_21_out[5]));
  LUT6 #(
    .INIT(64'hF7FFFFFFFFFFFFFF)) 
    \lane_terminate_temp[5]_i_2 
       (.I0(mgt_rxdata[28]),
        .I1(mgt_rxcharisk[3]),
        .I2(mgt_rxdata[25]),
        .I3(mgt_rxdata[24]),
        .I4(mgt_rxdata[26]),
        .I5(mgt_rxdata[27]),
        .O(\lane_terminate_temp[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'h00004000)) 
    \lane_terminate_temp[6]_i_1 
       (.I0(\lane_terminate_temp[6]_i_2_n_0 ),
        .I1(mgt_rxdata[46]),
        .I2(mgt_rxdata[45]),
        .I3(mgt_rxdata[47]),
        .I4(code_error[6]),
        .O(p_21_out[6]));
  LUT6 #(
    .INIT(64'hFF7FFFFFFFFFFFFF)) 
    \lane_terminate_temp[6]_i_2 
       (.I0(mgt_rxdata[44]),
        .I1(mgt_rxcharisk[5]),
        .I2(mgt_rxdata[40]),
        .I3(mgt_rxdata[41]),
        .I4(mgt_rxdata[42]),
        .I5(mgt_rxdata[43]),
        .O(\lane_terminate_temp[6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'h00004000)) 
    \lane_terminate_temp[7]_i_1 
       (.I0(\lane_terminate_temp[7]_i_2_n_0 ),
        .I1(mgt_rxdata[62]),
        .I2(mgt_rxdata[61]),
        .I3(mgt_rxdata[63]),
        .I4(code_error[7]),
        .O(p_21_out[7]));
  LUT6 #(
    .INIT(64'hF7FFFFFFFFFFFFFF)) 
    \lane_terminate_temp[7]_i_2 
       (.I0(mgt_rxdata[60]),
        .I1(mgt_rxcharisk[7]),
        .I2(mgt_rxdata[57]),
        .I3(mgt_rxdata[56]),
        .I4(mgt_rxdata[58]),
        .I5(mgt_rxdata[59]),
        .O(\lane_terminate_temp[7]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \lane_terminate_temp_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_21_out[0]),
        .Q(\lane_terminate_temp_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \lane_terminate_temp_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_21_out[1]),
        .Q(p_2_in_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \lane_terminate_temp_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_21_out[2]),
        .Q(\lane_terminate_temp_reg_n_0_[2] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \lane_terminate_temp_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_21_out[3]),
        .Q(\lane_terminate_temp_reg_n_0_[3] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \lane_terminate_temp_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_21_out[4]),
        .Q(\lane_terminate_temp_reg_n_0_[4] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \lane_terminate_temp_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_21_out[5]),
        .Q(\lane_terminate_temp_reg_n_0_[5] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \lane_terminate_temp_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_21_out[6]),
        .Q(\lane_terminate_temp_reg_n_0_[6] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \lane_terminate_temp_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_21_out[7]),
        .Q(\lane_terminate_temp_reg_n_0_[7] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rxc_half_pipe_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(c153_in),
        .Q(rxc_half_pipe[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxc_half_pipe_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(c3_in),
        .Q(rxc_half_pipe[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxc_half_pipe_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(c7_in),
        .Q(rxc_half_pipe[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxc_half_pipe_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(c11_in),
        .Q(rxc_half_pipe[3]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \rxc_out[0]_i_1 
       (.I0(rxc_half_pipe[0]),
        .I1(\rxd_out[7]_i_2_n_0 ),
        .I2(\tx_is_idle_half_pipe_reg_n_0_[0] ),
        .O(\rxc_out[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    \rxc_out[1]_i_1 
       (.I0(rxc_half_pipe[1]),
        .I1(\rxd_out[15]_i_2_n_0 ),
        .I2(\tx_is_idle_half_pipe_reg_n_0_[1] ),
        .O(\rxc_out[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    \rxc_out[2]_i_1 
       (.I0(rxc_half_pipe[2]),
        .I1(\rxd_out[23]_i_2_n_0 ),
        .I2(p_0_in0_in),
        .O(\rxc_out[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    \rxc_out[3]_i_1 
       (.I0(rxc_half_pipe[3]),
        .I1(\rxd_out[31]_i_2_n_0 ),
        .I2(\tx_is_idle_half_pipe_reg_n_0_[3] ),
        .O(\rxc_out[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \rxc_out[4]_i_1 
       (.I0(\rxc_pipe_reg_n_0_[0] ),
        .I1(\rxd_out[39]_i_2_n_0 ),
        .I2(\tx_is_idle_pipe_reg_n_0_[0] ),
        .O(\rxc_out[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    \rxc_out[5]_i_1 
       (.I0(c78_in),
        .I1(\rxd_out[47]_i_2_n_0 ),
        .I2(p_2_in),
        .O(\rxc_out[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    \rxc_out[6]_i_1 
       (.I0(c75_in),
        .I1(\rxd_out[55]_i_2_n_0 ),
        .I2(p_4_in),
        .O(\rxc_out[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    \rxc_out[7]_i_1 
       (.I0(c72_in),
        .I1(\rxd_out[63]_i_3_n_0 ),
        .I2(p_11_in),
        .O(\rxc_out[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b1)) 
    \rxc_out_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxc_out[0]_i_1_n_0 ),
        .Q(xgmii_rxc[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxc_out_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxc_out[1]_i_1_n_0 ),
        .Q(xgmii_rxc[1]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxc_out_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxc_out[2]_i_1_n_0 ),
        .Q(xgmii_rxc[2]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxc_out_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxc_out[3]_i_1_n_0 ),
        .Q(xgmii_rxc[3]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b1)) 
    \rxc_out_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxc_out[4]_i_1_n_0 ),
        .Q(xgmii_rxc[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxc_out_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxc_out[5]_i_1_n_0 ),
        .Q(xgmii_rxc[5]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxc_out_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxc_out[6]_i_1_n_0 ),
        .Q(xgmii_rxc[6]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxc_out_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxc_out[7]_i_1_n_0 ),
        .Q(xgmii_rxc[7]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b1)) 
    \rxc_pipe_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxcharisk[0]),
        .Q(\rxc_pipe_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxc_pipe_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxcharisk[2]),
        .Q(c78_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxc_pipe_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxcharisk[4]),
        .Q(c75_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxc_pipe_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxcharisk[6]),
        .Q(c72_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rxc_pipe_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxcharisk[1]),
        .Q(c153_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxc_pipe_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxcharisk[3]),
        .Q(c3_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxc_pipe_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxcharisk[5]),
        .Q(c7_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxc_pipe_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxcharisk[7]),
        .Q(c11_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[32] ),
        .Q(rxd_half_pipe[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[10] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[42] ),
        .Q(rxd_half_pipe[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[11] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[43] ),
        .Q(rxd_half_pipe[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[12] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[44] ),
        .Q(rxd_half_pipe[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[13] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[45] ),
        .Q(rxd_half_pipe[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[14] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[46] ),
        .Q(rxd_half_pipe[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[15] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[47] ),
        .Q(rxd_half_pipe[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[16] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[48] ),
        .Q(rxd_half_pipe[16]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[17] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[49] ),
        .Q(rxd_half_pipe[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[18] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[50] ),
        .Q(rxd_half_pipe[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[19] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[51] ),
        .Q(rxd_half_pipe[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[33] ),
        .Q(rxd_half_pipe[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[20] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[52] ),
        .Q(rxd_half_pipe[20]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[21] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[53] ),
        .Q(rxd_half_pipe[21]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[22] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[54] ),
        .Q(rxd_half_pipe[22]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[23] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[55] ),
        .Q(rxd_half_pipe[23]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_half_pipe_reg[24] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[56] ),
        .Q(rxd_half_pipe[24]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[25] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[57] ),
        .Q(rxd_half_pipe[25]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[26] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[58] ),
        .Q(rxd_half_pipe[26]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[27] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[59] ),
        .Q(rxd_half_pipe[27]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[28] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[60] ),
        .Q(rxd_half_pipe[28]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[29] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[61] ),
        .Q(rxd_half_pipe[29]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_half_pipe_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[34] ),
        .Q(rxd_half_pipe[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[30] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[62] ),
        .Q(rxd_half_pipe[30]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[31] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[63] ),
        .Q(rxd_half_pipe[31]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_half_pipe_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[35] ),
        .Q(rxd_half_pipe[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_half_pipe_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[36] ),
        .Q(rxd_half_pipe[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[37] ),
        .Q(rxd_half_pipe[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[38] ),
        .Q(rxd_half_pipe[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_half_pipe_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[39] ),
        .Q(rxd_half_pipe[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[8] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[40] ),
        .Q(rxd_half_pipe[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_half_pipe_reg[9] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_pipe_reg_n_0_[41] ),
        .Q(rxd_half_pipe[9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \rxd_out[0]_i_1 
       (.I0(rxd_half_pipe[0]),
        .I1(\tx_is_idle_half_pipe_reg_n_0_[0] ),
        .I2(\rxd_out[7]_i_2_n_0 ),
        .O(\rxd_out[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    \rxd_out[10]_i_1 
       (.I0(rxd_half_pipe[10]),
        .I1(\rxd_out[15]_i_2_n_0 ),
        .I2(\tx_is_idle_half_pipe_reg_n_0_[1] ),
        .O(\rxd_out[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[11]_i_1 
       (.I0(\tx_is_idle_half_pipe_reg_n_0_[1] ),
        .I1(rxd_half_pipe[11]),
        .I2(\rxd_out[15]_i_2_n_0 ),
        .O(\rxd_out[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[12]_i_1 
       (.I0(\tx_is_idle_half_pipe_reg_n_0_[1] ),
        .I1(rxd_half_pipe[12]),
        .I2(\rxd_out[15]_i_2_n_0 ),
        .O(\rxd_out[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[13]_i_1 
       (.I0(\tx_is_idle_half_pipe_reg_n_0_[1] ),
        .I1(rxd_half_pipe[13]),
        .I2(\rxd_out[15]_i_2_n_0 ),
        .O(\rxd_out[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[14]_i_1 
       (.I0(\tx_is_idle_half_pipe_reg_n_0_[1] ),
        .I1(rxd_half_pipe[14]),
        .I2(\rxd_out[15]_i_2_n_0 ),
        .O(\rxd_out[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[15]_i_1 
       (.I0(\tx_is_idle_half_pipe_reg_n_0_[1] ),
        .I1(rxd_half_pipe[15]),
        .I2(\rxd_out[15]_i_2_n_0 ),
        .O(\rxd_out[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h0000555D)) 
    \rxd_out[15]_i_2 
       (.I0(\rxd_out[15]_i_3_n_0 ),
        .I1(\rxd_out[15]_i_4_n_0 ),
        .I2(\rxd_out[15]_i_5_n_0 ),
        .I3(\rxd_out[15]_i_6_n_0 ),
        .I4(code_error_delay[1]),
        .O(\rxd_out[15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'hAAAAAAFE)) 
    \rxd_out[15]_i_3 
       (.I0(\lane_terminate_temp_reg_n_0_[0] ),
        .I1(lane_term_pipe[3]),
        .I2(lane_term_pipe[2]),
        .I3(lane_term_pipe[1]),
        .I4(lane_term_pipe[0]),
        .O(\rxd_out[15]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000700000000000)) 
    \rxd_out[15]_i_4 
       (.I0(p_3_in[6]),
        .I1(p_3_in[7]),
        .I2(p_3_in[3]),
        .I3(p_3_in[4]),
        .I4(p_3_in[0]),
        .I5(c78_in),
        .O(\rxd_out[15]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFFDF)) 
    \rxd_out[15]_i_5 
       (.I0(p_3_in[5]),
        .I1(p_3_in[1]),
        .I2(p_3_in[2]),
        .I3(code_error_delay[5]),
        .O(\rxd_out[15]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h0D)) 
    \rxd_out[15]_i_6 
       (.I0(p_3_in[6]),
        .I1(\lane_terminate_temp_reg_n_0_[0] ),
        .I2(p_3_in[7]),
        .O(\rxd_out[15]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'h8880)) 
    \rxd_out[16]_i_1 
       (.I0(\rxd_out[23]_i_2_n_0 ),
        .I1(align_status_reg),
        .I2(p_0_in0_in),
        .I3(rxd_half_pipe[16]),
        .O(\rxd_out[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    \rxd_out[17]_i_1 
       (.I0(rxd_half_pipe[17]),
        .I1(\rxd_out[23]_i_2_n_0 ),
        .I2(p_0_in0_in),
        .O(\rxd_out[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    \rxd_out[18]_i_1 
       (.I0(rxd_half_pipe[18]),
        .I1(\rxd_out[23]_i_2_n_0 ),
        .I2(p_0_in0_in),
        .O(\rxd_out[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[19]_i_1 
       (.I0(p_0_in0_in),
        .I1(rxd_half_pipe[19]),
        .I2(\rxd_out[23]_i_2_n_0 ),
        .O(\rxd_out[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \rxd_out[1]_i_1 
       (.I0(\rxd_out[6]_i_2_n_0 ),
        .I1(rxd_half_pipe[1]),
        .I2(\tx_is_idle_half_pipe_reg_n_0_[0] ),
        .O(\rxd_out[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[20]_i_1 
       (.I0(p_0_in0_in),
        .I1(rxd_half_pipe[20]),
        .I2(\rxd_out[23]_i_2_n_0 ),
        .O(\rxd_out[20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[21]_i_1 
       (.I0(p_0_in0_in),
        .I1(rxd_half_pipe[21]),
        .I2(\rxd_out[23]_i_2_n_0 ),
        .O(\rxd_out[21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[22]_i_1 
       (.I0(p_0_in0_in),
        .I1(rxd_half_pipe[22]),
        .I2(\rxd_out[23]_i_2_n_0 ),
        .O(\rxd_out[22]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[23]_i_1 
       (.I0(p_0_in0_in),
        .I1(rxd_half_pipe[23]),
        .I2(\rxd_out[23]_i_2_n_0 ),
        .O(\rxd_out[23]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h0000555D)) 
    \rxd_out[23]_i_2 
       (.I0(\rxd_out[23]_i_3_n_0 ),
        .I1(\rxd_out[23]_i_4_n_0 ),
        .I2(\rxd_out[23]_i_5_n_0 ),
        .I3(\rxd_out[23]_i_6_n_0 ),
        .I4(code_error_delay[2]),
        .O(\rxd_out[23]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hEEEEEEEEEEEEEFEE)) 
    \rxd_out[23]_i_3 
       (.I0(p_2_in_0),
        .I1(\lane_terminate_temp_reg_n_0_[0] ),
        .I2(lane_term_pipe[2]),
        .I3(lane_term_pipe[3]),
        .I4(lane_term_pipe[1]),
        .I5(lane_term_pipe[0]),
        .O(\rxd_out[23]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h5557)) 
    \rxd_out[23]_i_4 
       (.I0(p_5_in[6]),
        .I1(\lane_terminate_temp_reg_n_0_[0] ),
        .I2(p_2_in_0),
        .I3(p_5_in[7]),
        .O(\rxd_out[23]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFF1FFFFFFFFFFFF)) 
    \rxd_out[23]_i_5 
       (.I0(p_5_in[6]),
        .I1(p_5_in[7]),
        .I2(code_error_delay[6]),
        .I3(p_5_in[1]),
        .I4(c75_in),
        .I5(p_5_in[4]),
        .O(\rxd_out[23]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hFF7F)) 
    \rxd_out[23]_i_6 
       (.I0(p_5_in[3]),
        .I1(p_5_in[5]),
        .I2(p_5_in[2]),
        .I3(p_5_in[0]),
        .O(\rxd_out[23]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hE0FF)) 
    \rxd_out[24]_i_1 
       (.I0(\tx_is_idle_half_pipe_reg_n_0_[3] ),
        .I1(rxd_half_pipe[24]),
        .I2(\rxd_out[31]_i_2_n_0 ),
        .I3(align_status_reg),
        .O(\rxd_out[24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    \rxd_out[25]_i_1 
       (.I0(rxd_half_pipe[25]),
        .I1(\rxd_out[31]_i_2_n_0 ),
        .I2(\tx_is_idle_half_pipe_reg_n_0_[3] ),
        .O(\rxd_out[25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    \rxd_out[26]_i_1 
       (.I0(rxd_half_pipe[26]),
        .I1(\rxd_out[31]_i_2_n_0 ),
        .I2(\tx_is_idle_half_pipe_reg_n_0_[3] ),
        .O(\rxd_out[26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[27]_i_1 
       (.I0(\tx_is_idle_half_pipe_reg_n_0_[3] ),
        .I1(rxd_half_pipe[27]),
        .I2(\rxd_out[31]_i_2_n_0 ),
        .O(\rxd_out[27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[28]_i_1 
       (.I0(\tx_is_idle_half_pipe_reg_n_0_[3] ),
        .I1(rxd_half_pipe[28]),
        .I2(\rxd_out[31]_i_2_n_0 ),
        .O(\rxd_out[28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[29]_i_1 
       (.I0(\tx_is_idle_half_pipe_reg_n_0_[3] ),
        .I1(rxd_half_pipe[29]),
        .I2(\rxd_out[31]_i_2_n_0 ),
        .O(\rxd_out[29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \rxd_out[2]_i_1 
       (.I0(rxd_half_pipe[2]),
        .I1(\rxd_out[7]_i_2_n_0 ),
        .I2(\tx_is_idle_half_pipe_reg_n_0_[0] ),
        .O(\rxd_out[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[30]_i_1 
       (.I0(\tx_is_idle_half_pipe_reg_n_0_[3] ),
        .I1(rxd_half_pipe[30]),
        .I2(\rxd_out[31]_i_2_n_0 ),
        .O(\rxd_out[30]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[31]_i_1 
       (.I0(\tx_is_idle_half_pipe_reg_n_0_[3] ),
        .I1(rxd_half_pipe[31]),
        .I2(\rxd_out[31]_i_2_n_0 ),
        .O(\rxd_out[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h000000000101FF01)) 
    \rxd_out[31]_i_2 
       (.I0(\lane_terminate_temp_reg_n_0_[2] ),
        .I1(p_2_in_0),
        .I2(\lane_terminate_temp_reg_n_0_[0] ),
        .I3(\rxd_out[31]_i_3_n_0 ),
        .I4(\rxd_out[31]_i_4_n_0 ),
        .I5(code_error_delay[3]),
        .O(\rxd_out[31]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h0080)) 
    \rxd_out[31]_i_3 
       (.I0(\rxd_pipe_reg_n_0_[28] ),
        .I1(c72_in),
        .I2(\rxd_pipe_reg_n_0_[27] ),
        .I3(code_error_delay[7]),
        .O(\rxd_out[31]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFDFFF)) 
    \rxd_out[31]_i_4 
       (.I0(\rxd_pipe_reg_n_0_[31] ),
        .I1(\rxd_pipe_reg_n_0_[30] ),
        .I2(\rxd_pipe_reg_n_0_[29] ),
        .I3(\rxd_pipe_reg_n_0_[26] ),
        .I4(\rxd_pipe_reg_n_0_[25] ),
        .I5(\rxd_pipe_reg_n_0_[24] ),
        .O(\rxd_out[31]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \rxd_out[32]_i_1 
       (.I0(\tx_is_idle_pipe_reg_n_0_[0] ),
        .I1(\rxd_pipe_reg_n_0_[0] ),
        .I2(\rxd_out[39]_i_2_n_0 ),
        .O(\rxd_out[32]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \rxd_out[33]_i_1 
       (.I0(\rxd_out[33]_i_2_n_0 ),
        .I1(code_error_delay[4]),
        .I2(\rxd_pipe_reg_n_0_[1] ),
        .I3(\tx_is_idle_pipe_reg_n_0_[0] ),
        .O(\rxd_out[33]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAA2AA2A)) 
    \rxd_out[33]_i_2 
       (.I0(\rxd_out[39]_i_3_n_0 ),
        .I1(\rxd_out[33]_i_3_n_0 ),
        .I2(\rxd_pipe_reg_n_0_[38] ),
        .I3(\rxd_pipe_reg_n_0_[33] ),
        .I4(\rxd_pipe_reg_n_0_[39] ),
        .I5(\rxd_out[39]_i_5_n_0 ),
        .O(\rxd_out[33]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \rxd_out[33]_i_3 
       (.I0(\rxd_pipe_reg_n_0_[32] ),
        .I1(\rxd_pipe_reg_n_0_[34] ),
        .I2(\rxd_pipe_reg_n_0_[35] ),
        .O(\rxd_out[33]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \rxd_out[34]_i_1 
       (.I0(\rxd_pipe_reg_n_0_[2] ),
        .I1(\rxd_out[39]_i_2_n_0 ),
        .I2(\tx_is_idle_pipe_reg_n_0_[0] ),
        .O(\rxd_out[34]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'hBA)) 
    \rxd_out[35]_i_1 
       (.I0(\rxd_out[39]_i_2_n_0 ),
        .I1(\tx_is_idle_pipe_reg_n_0_[0] ),
        .I2(\rxd_pipe_reg_n_0_[3] ),
        .O(\rxd_out[35]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hBA)) 
    \rxd_out[36]_i_1 
       (.I0(\rxd_out[39]_i_2_n_0 ),
        .I1(\tx_is_idle_pipe_reg_n_0_[0] ),
        .I2(\rxd_pipe_reg_n_0_[4] ),
        .O(\rxd_out[36]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'hBA)) 
    \rxd_out[37]_i_1 
       (.I0(\rxd_out[38]_i_2_n_0 ),
        .I1(\tx_is_idle_pipe_reg_n_0_[0] ),
        .I2(\rxd_pipe_reg_n_0_[5] ),
        .O(\rxd_out[37]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'hBA)) 
    \rxd_out[38]_i_1 
       (.I0(\rxd_out[38]_i_2_n_0 ),
        .I1(\tx_is_idle_pipe_reg_n_0_[0] ),
        .I2(\rxd_pipe_reg_n_0_[6] ),
        .O(\rxd_out[38]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFBAAAA)) 
    \rxd_out[38]_i_2 
       (.I0(code_error_delay[4]),
        .I1(\rxd_out[39]_i_6_n_0 ),
        .I2(\rxd_out[39]_i_5_n_0 ),
        .I3(\rxd_out[39]_i_4_n_0 ),
        .I4(\rxd_out[39]_i_3_n_0 ),
        .O(\rxd_out[38]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hF4)) 
    \rxd_out[39]_i_1 
       (.I0(\tx_is_idle_pipe_reg_n_0_[0] ),
        .I1(\rxd_pipe_reg_n_0_[7] ),
        .I2(\rxd_out[39]_i_2_n_0 ),
        .O(\rxd_out[39]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFA8AAFFFFFFFF)) 
    \rxd_out[39]_i_2 
       (.I0(\rxd_out[39]_i_3_n_0 ),
        .I1(\rxd_out[39]_i_4_n_0 ),
        .I2(\rxd_out[39]_i_5_n_0 ),
        .I3(\rxd_out[39]_i_6_n_0 ),
        .I4(code_error_delay[4]),
        .I5(align_status_reg),
        .O(\rxd_out[39]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h00FE)) 
    \rxd_out[39]_i_3 
       (.I0(\lane_terminate_temp_reg_n_0_[2] ),
        .I1(\lane_terminate_temp_reg_n_0_[3] ),
        .I2(p_2_in_0),
        .I3(\lane_terminate_temp_reg_n_0_[0] ),
        .O(\rxd_out[39]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAAA8AAAAAAAAAAAA)) 
    \rxd_out[39]_i_4 
       (.I0(\rxd_pipe_reg_n_0_[39] ),
        .I1(\rxd_pipe_reg_n_0_[33] ),
        .I2(\rxd_pipe_reg_n_0_[38] ),
        .I3(\rxd_pipe_reg_n_0_[32] ),
        .I4(\rxd_pipe_reg_n_0_[34] ),
        .I5(\rxd_pipe_reg_n_0_[35] ),
        .O(\rxd_out[39]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFF7F)) 
    \rxd_out[39]_i_5 
       (.I0(\rxd_pipe_reg_n_0_[37] ),
        .I1(c153_in),
        .I2(\rxd_pipe_reg_n_0_[36] ),
        .I3(\code_error_pipe_reg_n_0_[4] ),
        .O(\rxd_out[39]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAAAABAAAAAAAAAAA)) 
    \rxd_out[39]_i_6 
       (.I0(\rxd_pipe_reg_n_0_[39] ),
        .I1(\rxd_pipe_reg_n_0_[33] ),
        .I2(\rxd_pipe_reg_n_0_[35] ),
        .I3(\rxd_pipe_reg_n_0_[34] ),
        .I4(\rxd_pipe_reg_n_0_[32] ),
        .I5(\rxd_pipe_reg_n_0_[38] ),
        .O(\rxd_out[39]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'hBA)) 
    \rxd_out[3]_i_1 
       (.I0(\rxd_out[7]_i_2_n_0 ),
        .I1(\tx_is_idle_half_pipe_reg_n_0_[0] ),
        .I2(rxd_half_pipe[3]),
        .O(\rxd_out[3]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h8880)) 
    \rxd_out[40]_i_1 
       (.I0(\rxd_out[47]_i_2_n_0 ),
        .I1(align_status_reg),
        .I2(p_2_in),
        .I3(p_3_in[0]),
        .O(\rxd_out[40]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    \rxd_out[41]_i_1 
       (.I0(p_3_in[1]),
        .I1(\rxd_out[47]_i_2_n_0 ),
        .I2(p_2_in),
        .O(\rxd_out[41]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    \rxd_out[42]_i_1 
       (.I0(p_3_in[2]),
        .I1(\rxd_out[47]_i_2_n_0 ),
        .I2(p_2_in),
        .O(\rxd_out[42]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[43]_i_1 
       (.I0(p_2_in),
        .I1(p_3_in[3]),
        .I2(\rxd_out[47]_i_2_n_0 ),
        .O(\rxd_out[43]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[44]_i_1 
       (.I0(p_2_in),
        .I1(p_3_in[4]),
        .I2(\rxd_out[47]_i_2_n_0 ),
        .O(\rxd_out[44]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[45]_i_1 
       (.I0(p_2_in),
        .I1(p_3_in[5]),
        .I2(\rxd_out[47]_i_2_n_0 ),
        .O(\rxd_out[45]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[46]_i_1 
       (.I0(p_2_in),
        .I1(p_3_in[6]),
        .I2(\rxd_out[47]_i_2_n_0 ),
        .O(\rxd_out[46]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[47]_i_1 
       (.I0(p_2_in),
        .I1(p_3_in[7]),
        .I2(\rxd_out[47]_i_2_n_0 ),
        .O(\rxd_out[47]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000055DD000D)) 
    \rxd_out[47]_i_2 
       (.I0(\lane_terminate_temp_reg_n_0_[4] ),
        .I1(\rxd_out[47]_i_3_n_0 ),
        .I2(\rxd_out[47]_i_4_n_0 ),
        .I3(\rxd_out[47]_i_5_n_0 ),
        .I4(\rxd_out[47]_i_6_n_0 ),
        .I5(code_error_delay[5]),
        .O(\rxd_out[47]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h0800)) 
    \rxd_out[47]_i_3 
       (.I0(\rxd_pipe_reg_n_0_[45] ),
        .I1(c3_in),
        .I2(\rxd_pipe_reg_n_0_[46] ),
        .I3(\rxd_pipe_reg_n_0_[47] ),
        .O(\rxd_out[47]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'hF77F)) 
    \rxd_out[47]_i_4 
       (.I0(\rxd_pipe_reg_n_0_[45] ),
        .I1(c3_in),
        .I2(\rxd_pipe_reg_n_0_[47] ),
        .I3(\rxd_pipe_reg_n_0_[46] ),
        .O(\rxd_out[47]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFBFFFFFF)) 
    \rxd_out[47]_i_5 
       (.I0(\code_error_pipe_reg_n_0_[5] ),
        .I1(\rxd_pipe_reg_n_0_[44] ),
        .I2(\rxd_pipe_reg_n_0_[40] ),
        .I3(\rxd_pipe_reg_n_0_[42] ),
        .I4(\rxd_pipe_reg_n_0_[43] ),
        .I5(\rxd_pipe_reg_n_0_[41] ),
        .O(\rxd_out[47]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'hEEEF)) 
    \rxd_out[47]_i_6 
       (.I0(p_2_in_0),
        .I1(\lane_terminate_temp_reg_n_0_[0] ),
        .I2(\lane_terminate_temp_reg_n_0_[3] ),
        .I3(\lane_terminate_temp_reg_n_0_[2] ),
        .O(\rxd_out[47]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'h8880)) 
    \rxd_out[48]_i_1 
       (.I0(\rxd_out[55]_i_2_n_0 ),
        .I1(align_status_reg),
        .I2(p_4_in),
        .I3(p_5_in[0]),
        .O(\rxd_out[48]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    \rxd_out[49]_i_1 
       (.I0(p_5_in[1]),
        .I1(\rxd_out[55]_i_2_n_0 ),
        .I2(p_4_in),
        .O(\rxd_out[49]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'hBA)) 
    \rxd_out[4]_i_1 
       (.I0(\rxd_out[7]_i_2_n_0 ),
        .I1(\tx_is_idle_half_pipe_reg_n_0_[0] ),
        .I2(rxd_half_pipe[4]),
        .O(\rxd_out[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    \rxd_out[50]_i_1 
       (.I0(p_5_in[2]),
        .I1(\rxd_out[55]_i_2_n_0 ),
        .I2(p_4_in),
        .O(\rxd_out[50]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[51]_i_1 
       (.I0(p_4_in),
        .I1(p_5_in[3]),
        .I2(\rxd_out[55]_i_2_n_0 ),
        .O(\rxd_out[51]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[52]_i_1 
       (.I0(p_4_in),
        .I1(p_5_in[4]),
        .I2(\rxd_out[55]_i_2_n_0 ),
        .O(\rxd_out[52]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[53]_i_1 
       (.I0(p_4_in),
        .I1(p_5_in[5]),
        .I2(\rxd_out[55]_i_2_n_0 ),
        .O(\rxd_out[53]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[54]_i_1 
       (.I0(p_4_in),
        .I1(p_5_in[6]),
        .I2(\rxd_out[55]_i_2_n_0 ),
        .O(\rxd_out[54]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[55]_i_1 
       (.I0(p_4_in),
        .I1(p_5_in[7]),
        .I2(\rxd_out[55]_i_2_n_0 ),
        .O(\rxd_out[55]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000007770505)) 
    \rxd_out[55]_i_2 
       (.I0(\rxd_out[55]_i_3_n_0 ),
        .I1(\rxd_out[55]_i_4_n_0 ),
        .I2(\rxd_out[55]_i_5_n_0 ),
        .I3(\rxd_out[55]_i_6_n_0 ),
        .I4(\rxd_out[55]_i_7_n_0 ),
        .I5(code_error_delay[6]),
        .O(\rxd_out[55]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \rxd_out[55]_i_3 
       (.I0(\lane_terminate_temp_reg_n_0_[4] ),
        .I1(\lane_terminate_temp_reg_n_0_[5] ),
        .O(\rxd_out[55]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hDFFF)) 
    \rxd_out[55]_i_4 
       (.I0(\rxd_pipe_reg_n_0_[55] ),
        .I1(\rxd_pipe_reg_n_0_[54] ),
        .I2(\rxd_pipe_reg_n_0_[53] ),
        .I3(c7_in),
        .O(\rxd_out[55]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'h0002)) 
    \rxd_out[55]_i_5 
       (.I0(\lane_terminate_temp_reg_n_0_[3] ),
        .I1(\lane_terminate_temp_reg_n_0_[0] ),
        .I2(p_2_in_0),
        .I3(\lane_terminate_temp_reg_n_0_[2] ),
        .O(\rxd_out[55]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'hF77F)) 
    \rxd_out[55]_i_6 
       (.I0(\rxd_pipe_reg_n_0_[53] ),
        .I1(c7_in),
        .I2(\rxd_pipe_reg_n_0_[55] ),
        .I3(\rxd_pipe_reg_n_0_[54] ),
        .O(\rxd_out[55]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0000000004000000)) 
    \rxd_out[55]_i_7 
       (.I0(\code_error_pipe_reg_n_0_[6] ),
        .I1(\rxd_pipe_reg_n_0_[52] ),
        .I2(\rxd_pipe_reg_n_0_[48] ),
        .I3(\rxd_pipe_reg_n_0_[50] ),
        .I4(\rxd_pipe_reg_n_0_[51] ),
        .I5(\rxd_pipe_reg_n_0_[49] ),
        .O(\rxd_out[55]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hE0FF)) 
    \rxd_out[56]_i_1 
       (.I0(p_11_in),
        .I1(\rxd_pipe_reg_n_0_[24] ),
        .I2(\rxd_out[63]_i_3_n_0 ),
        .I3(align_status_reg),
        .O(\rxd_out[56]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    \rxd_out[57]_i_1 
       (.I0(\rxd_pipe_reg_n_0_[25] ),
        .I1(\rxd_out[63]_i_3_n_0 ),
        .I2(p_11_in),
        .O(\rxd_out[57]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    \rxd_out[58]_i_1 
       (.I0(\rxd_pipe_reg_n_0_[26] ),
        .I1(\rxd_out[63]_i_3_n_0 ),
        .I2(p_11_in),
        .O(\rxd_out[58]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[59]_i_1 
       (.I0(p_11_in),
        .I1(\rxd_pipe_reg_n_0_[27] ),
        .I2(\rxd_out[63]_i_3_n_0 ),
        .O(\rxd_out[59]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hBA)) 
    \rxd_out[5]_i_1 
       (.I0(\rxd_out[6]_i_2_n_0 ),
        .I1(\tx_is_idle_half_pipe_reg_n_0_[0] ),
        .I2(rxd_half_pipe[5]),
        .O(\rxd_out[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[60]_i_1 
       (.I0(p_11_in),
        .I1(\rxd_pipe_reg_n_0_[28] ),
        .I2(\rxd_out[63]_i_3_n_0 ),
        .O(\rxd_out[60]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[61]_i_1 
       (.I0(p_11_in),
        .I1(\rxd_pipe_reg_n_0_[29] ),
        .I2(\rxd_out[63]_i_3_n_0 ),
        .O(\rxd_out[61]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[62]_i_1 
       (.I0(p_11_in),
        .I1(\rxd_pipe_reg_n_0_[30] ),
        .I2(\rxd_out[63]_i_3_n_0 ),
        .O(\rxd_out[62]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \rxd_out[63]_i_2 
       (.I0(p_11_in),
        .I1(\rxd_pipe_reg_n_0_[31] ),
        .I2(\rxd_out[63]_i_3_n_0 ),
        .O(\rxd_out[63]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000155555555)) 
    \rxd_out[63]_i_3 
       (.I0(code_error_delay[7]),
        .I1(\rxd_out[63]_i_4_n_0 ),
        .I2(\rxd_out[63]_i_5_n_0 ),
        .I3(\rxd_pipe_reg_n_0_[57] ),
        .I4(\code_error_pipe_reg_n_0_[7] ),
        .I5(\rxd_out[63]_i_6_n_0 ),
        .O(\rxd_out[63]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \rxd_out[63]_i_4 
       (.I0(\rxd_pipe_reg_n_0_[58] ),
        .I1(\rxd_pipe_reg_n_0_[59] ),
        .I2(\rxd_pipe_reg_n_0_[61] ),
        .I3(c11_in),
        .O(\rxd_out[63]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFFF7)) 
    \rxd_out[63]_i_5 
       (.I0(\rxd_pipe_reg_n_0_[63] ),
        .I1(\rxd_pipe_reg_n_0_[60] ),
        .I2(\rxd_pipe_reg_n_0_[62] ),
        .I3(\rxd_pipe_reg_n_0_[56] ),
        .O(\rxd_out[63]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \rxd_out[63]_i_6 
       (.I0(\lane_terminate_temp_reg_n_0_[6] ),
        .I1(\lane_terminate_temp_reg_n_0_[5] ),
        .I2(\lane_terminate_temp_reg_n_0_[4] ),
        .O(\rxd_out[63]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'hBA)) 
    \rxd_out[6]_i_1 
       (.I0(\rxd_out[6]_i_2_n_0 ),
        .I1(\tx_is_idle_half_pipe_reg_n_0_[0] ),
        .I2(rxd_half_pipe[6]),
        .O(\rxd_out[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAFBFBFBAA)) 
    \rxd_out[6]_i_2 
       (.I0(code_error_delay[0]),
        .I1(\rxd_out[7]_i_5_n_0 ),
        .I2(\rxd_out[7]_i_4_n_0 ),
        .I3(\rxd_out[6]_i_3_n_0 ),
        .I4(lane_term_pipe[1]),
        .I5(lane_term_pipe[0]),
        .O(\rxd_out[6]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \rxd_out[6]_i_3 
       (.I0(lane_term_pipe[3]),
        .I1(lane_term_pipe[2]),
        .O(\rxd_out[6]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'hF4)) 
    \rxd_out[7]_i_1 
       (.I0(\tx_is_idle_half_pipe_reg_n_0_[0] ),
        .I1(rxd_half_pipe[7]),
        .I2(\rxd_out[7]_i_2_n_0 ),
        .O(\rxd_out[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFF8AFFFF)) 
    \rxd_out[7]_i_2 
       (.I0(\rxd_out[7]_i_3_n_0 ),
        .I1(\rxd_out[7]_i_4_n_0 ),
        .I2(\rxd_out[7]_i_5_n_0 ),
        .I3(code_error_delay[0]),
        .I4(align_status_reg),
        .O(\rxd_out[7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h00FE)) 
    \rxd_out[7]_i_3 
       (.I0(lane_term_pipe[3]),
        .I1(lane_term_pipe[2]),
        .I2(lane_term_pipe[1]),
        .I3(lane_term_pipe[0]),
        .O(\rxd_out[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF9FFF)) 
    \rxd_out[7]_i_4 
       (.I0(\rxd_pipe_reg_n_0_[6] ),
        .I1(\rxd_pipe_reg_n_0_[7] ),
        .I2(\rxc_pipe_reg_n_0_[0] ),
        .I3(\rxd_pipe_reg_n_0_[4] ),
        .I4(code_error_delay[4]),
        .I5(\rxd_pipe_reg_n_0_[1] ),
        .O(\rxd_out[7]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h0080)) 
    \rxd_out[7]_i_5 
       (.I0(\rxd_pipe_reg_n_0_[3] ),
        .I1(\rxd_pipe_reg_n_0_[2] ),
        .I2(\rxd_pipe_reg_n_0_[5] ),
        .I3(\rxd_pipe_reg_n_0_[0] ),
        .O(\rxd_out[7]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'h8880)) 
    \rxd_out[8]_i_1 
       (.I0(\rxd_out[15]_i_2_n_0 ),
        .I1(align_status_reg),
        .I2(\tx_is_idle_half_pipe_reg_n_0_[1] ),
        .I3(rxd_half_pipe[8]),
        .O(\rxd_out[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hFB)) 
    \rxd_out[9]_i_1 
       (.I0(rxd_half_pipe[9]),
        .I1(\rxd_out[15]_i_2_n_0 ),
        .I2(\tx_is_idle_half_pipe_reg_n_0_[1] ),
        .O(\rxd_out[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[0]_i_1_n_0 ),
        .Q(xgmii_rxd[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[10] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[10]_i_1_n_0 ),
        .Q(xgmii_rxd[10]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[11] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[11]_i_1_n_0 ),
        .Q(xgmii_rxd[11]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[12] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[12]_i_1_n_0 ),
        .Q(xgmii_rxd[12]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[13] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[13]_i_1_n_0 ),
        .Q(xgmii_rxd[13]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[14] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[14]_i_1_n_0 ),
        .Q(xgmii_rxd[14]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[15] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[15]_i_1_n_0 ),
        .Q(xgmii_rxd[15]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[16] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[16]_i_1_n_0 ),
        .Q(xgmii_rxd[16]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[17] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[17]_i_1_n_0 ),
        .Q(xgmii_rxd[17]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[18] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[18]_i_1_n_0 ),
        .Q(xgmii_rxd[18]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[19] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[19]_i_1_n_0 ),
        .Q(xgmii_rxd[19]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[1]_i_1_n_0 ),
        .Q(xgmii_rxd[1]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[20] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[20]_i_1_n_0 ),
        .Q(xgmii_rxd[20]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[21] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[21]_i_1_n_0 ),
        .Q(xgmii_rxd[21]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[22] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[22]_i_1_n_0 ),
        .Q(xgmii_rxd[22]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[23] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[23]_i_1_n_0 ),
        .Q(xgmii_rxd[23]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_out_reg[24] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[24]_i_1_n_0 ),
        .Q(xgmii_rxd[24]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[25] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[25]_i_1_n_0 ),
        .Q(xgmii_rxd[25]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[26] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[26]_i_1_n_0 ),
        .Q(xgmii_rxd[26]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[27] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[27]_i_1_n_0 ),
        .Q(xgmii_rxd[27]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[28] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[28]_i_1_n_0 ),
        .Q(xgmii_rxd[28]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[29] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[29]_i_1_n_0 ),
        .Q(xgmii_rxd[29]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_out_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[2]_i_1_n_0 ),
        .Q(xgmii_rxd[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[30] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[30]_i_1_n_0 ),
        .Q(xgmii_rxd[30]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[31] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[31]_i_1_n_0 ),
        .Q(xgmii_rxd[31]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[32] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[32]_i_1_n_0 ),
        .Q(xgmii_rxd[32]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[33] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[33]_i_1_n_0 ),
        .Q(xgmii_rxd[33]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_out_reg[34] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[34]_i_1_n_0 ),
        .Q(xgmii_rxd[34]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_out_reg[35] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[35]_i_1_n_0 ),
        .Q(xgmii_rxd[35]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_out_reg[36] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[36]_i_1_n_0 ),
        .Q(xgmii_rxd[36]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[37] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[37]_i_1_n_0 ),
        .Q(xgmii_rxd[37]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[38] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[38]_i_1_n_0 ),
        .Q(xgmii_rxd[38]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_out_reg[39] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[39]_i_1_n_0 ),
        .Q(xgmii_rxd[39]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_out_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[3]_i_1_n_0 ),
        .Q(xgmii_rxd[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[40] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[40]_i_1_n_0 ),
        .Q(xgmii_rxd[40]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[41] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[41]_i_1_n_0 ),
        .Q(xgmii_rxd[41]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[42] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[42]_i_1_n_0 ),
        .Q(xgmii_rxd[42]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[43] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[43]_i_1_n_0 ),
        .Q(xgmii_rxd[43]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[44] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[44]_i_1_n_0 ),
        .Q(xgmii_rxd[44]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[45] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[45]_i_1_n_0 ),
        .Q(xgmii_rxd[45]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[46] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[46]_i_1_n_0 ),
        .Q(xgmii_rxd[46]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[47] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[47]_i_1_n_0 ),
        .Q(xgmii_rxd[47]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[48] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[48]_i_1_n_0 ),
        .Q(xgmii_rxd[48]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[49] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[49]_i_1_n_0 ),
        .Q(xgmii_rxd[49]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_out_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[4]_i_1_n_0 ),
        .Q(xgmii_rxd[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[50] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[50]_i_1_n_0 ),
        .Q(xgmii_rxd[50]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[51] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[51]_i_1_n_0 ),
        .Q(xgmii_rxd[51]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[52] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[52]_i_1_n_0 ),
        .Q(xgmii_rxd[52]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[53] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[53]_i_1_n_0 ),
        .Q(xgmii_rxd[53]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[54] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[54]_i_1_n_0 ),
        .Q(xgmii_rxd[54]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[55] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[55]_i_1_n_0 ),
        .Q(xgmii_rxd[55]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_out_reg[56] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[56]_i_1_n_0 ),
        .Q(xgmii_rxd[56]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[57] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[57]_i_1_n_0 ),
        .Q(xgmii_rxd[57]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[58] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[58]_i_1_n_0 ),
        .Q(xgmii_rxd[58]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[59] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[59]_i_1_n_0 ),
        .Q(xgmii_rxd[59]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[5]_i_1_n_0 ),
        .Q(xgmii_rxd[5]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[60] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[60]_i_1_n_0 ),
        .Q(xgmii_rxd[60]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[61] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[61]_i_1_n_0 ),
        .Q(xgmii_rxd[61]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[62] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[62]_i_1_n_0 ),
        .Q(xgmii_rxd[62]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[63] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[63]_i_2_n_0 ),
        .Q(xgmii_rxd[63]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[6]_i_1_n_0 ),
        .Q(xgmii_rxd[6]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_out_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[7]_i_1_n_0 ),
        .Q(xgmii_rxd[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[8] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[8]_i_1_n_0 ),
        .Q(xgmii_rxd[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_out_reg[9] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\rxd_out[9]_i_1_n_0 ),
        .Q(xgmii_rxd[9]),
        .R(align_status_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[0]),
        .Q(\rxd_pipe_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[10] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[18]),
        .Q(p_3_in[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[11] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[19]),
        .Q(p_3_in[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[12] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[20]),
        .Q(p_3_in[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[13] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[21]),
        .Q(p_3_in[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[14] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[22]),
        .Q(p_3_in[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[15] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[23]),
        .Q(p_3_in[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[16] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[32]),
        .Q(p_5_in[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[17] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[33]),
        .Q(p_5_in[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[18] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[34]),
        .Q(p_5_in[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[19] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[35]),
        .Q(p_5_in[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[1]),
        .Q(\rxd_pipe_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[20] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[36]),
        .Q(p_5_in[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[21] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[37]),
        .Q(p_5_in[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[22] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[38]),
        .Q(p_5_in[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[23] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[39]),
        .Q(p_5_in[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_pipe_reg[24] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[48]),
        .Q(\rxd_pipe_reg_n_0_[24] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[25] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[49]),
        .Q(\rxd_pipe_reg_n_0_[25] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[26] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[50]),
        .Q(\rxd_pipe_reg_n_0_[26] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[27] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[51]),
        .Q(\rxd_pipe_reg_n_0_[27] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[28] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[52]),
        .Q(\rxd_pipe_reg_n_0_[28] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[29] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[53]),
        .Q(\rxd_pipe_reg_n_0_[29] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_pipe_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[2]),
        .Q(\rxd_pipe_reg_n_0_[2] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[30] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[54]),
        .Q(\rxd_pipe_reg_n_0_[30] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[31] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[55]),
        .Q(\rxd_pipe_reg_n_0_[31] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[32] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[8]),
        .Q(\rxd_pipe_reg_n_0_[32] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[33] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[9]),
        .Q(\rxd_pipe_reg_n_0_[33] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_pipe_reg[34] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[10]),
        .Q(\rxd_pipe_reg_n_0_[34] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_pipe_reg[35] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[11]),
        .Q(\rxd_pipe_reg_n_0_[35] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_pipe_reg[36] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[12]),
        .Q(\rxd_pipe_reg_n_0_[36] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[37] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[13]),
        .Q(\rxd_pipe_reg_n_0_[37] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[38] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[14]),
        .Q(\rxd_pipe_reg_n_0_[38] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_pipe_reg[39] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[15]),
        .Q(\rxd_pipe_reg_n_0_[39] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_pipe_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[3]),
        .Q(\rxd_pipe_reg_n_0_[3] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[40] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[24]),
        .Q(\rxd_pipe_reg_n_0_[40] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[41] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[25]),
        .Q(\rxd_pipe_reg_n_0_[41] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[42] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[26]),
        .Q(\rxd_pipe_reg_n_0_[42] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[43] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[27]),
        .Q(\rxd_pipe_reg_n_0_[43] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[44] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[28]),
        .Q(\rxd_pipe_reg_n_0_[44] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[45] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[29]),
        .Q(\rxd_pipe_reg_n_0_[45] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[46] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[30]),
        .Q(\rxd_pipe_reg_n_0_[46] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[47] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[31]),
        .Q(\rxd_pipe_reg_n_0_[47] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[48] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[40]),
        .Q(\rxd_pipe_reg_n_0_[48] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[49] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[41]),
        .Q(\rxd_pipe_reg_n_0_[49] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_pipe_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[4]),
        .Q(\rxd_pipe_reg_n_0_[4] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[50] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[42]),
        .Q(\rxd_pipe_reg_n_0_[50] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[51] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[43]),
        .Q(\rxd_pipe_reg_n_0_[51] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[52] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[44]),
        .Q(\rxd_pipe_reg_n_0_[52] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[53] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[45]),
        .Q(\rxd_pipe_reg_n_0_[53] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[54] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[46]),
        .Q(\rxd_pipe_reg_n_0_[54] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[55] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[47]),
        .Q(\rxd_pipe_reg_n_0_[55] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_pipe_reg[56] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[56]),
        .Q(\rxd_pipe_reg_n_0_[56] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[57] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[57]),
        .Q(\rxd_pipe_reg_n_0_[57] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[58] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[58]),
        .Q(\rxd_pipe_reg_n_0_[58] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[59] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[59]),
        .Q(\rxd_pipe_reg_n_0_[59] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[5]),
        .Q(\rxd_pipe_reg_n_0_[5] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[60] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[60]),
        .Q(\rxd_pipe_reg_n_0_[60] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[61] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[61]),
        .Q(\rxd_pipe_reg_n_0_[61] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[62] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[62]),
        .Q(\rxd_pipe_reg_n_0_[62] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[63] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[63]),
        .Q(\rxd_pipe_reg_n_0_[63] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[6]),
        .Q(\rxd_pipe_reg_n_0_[6] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \rxd_pipe_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[7]),
        .Q(\rxd_pipe_reg_n_0_[7] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[8] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[16]),
        .Q(p_3_in[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \rxd_pipe_reg[9] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_rxdata[17]),
        .Q(p_3_in[1]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0000000008840000)) 
    \tx_is_idle_half_pipe[0]_i_1 
       (.I0(\rxd_pipe_reg_n_0_[37] ),
        .I1(c153_in),
        .I2(\rxd_pipe_reg_n_0_[39] ),
        .I3(\rxd_pipe_reg_n_0_[38] ),
        .I4(\rxd_pipe_reg_n_0_[36] ),
        .I5(\tx_is_idle_half_pipe[0]_i_2_n_0 ),
        .O(p_15_out[0]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'hFFBF)) 
    \tx_is_idle_half_pipe[0]_i_2 
       (.I0(\rxd_pipe_reg_n_0_[33] ),
        .I1(\rxd_pipe_reg_n_0_[35] ),
        .I2(\rxd_pipe_reg_n_0_[34] ),
        .I3(\rxd_pipe_reg_n_0_[32] ),
        .O(\tx_is_idle_half_pipe[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'h00000884)) 
    \tx_is_idle_half_pipe[1]_i_1 
       (.I0(\rxd_pipe_reg_n_0_[45] ),
        .I1(c3_in),
        .I2(\rxd_pipe_reg_n_0_[47] ),
        .I3(\rxd_pipe_reg_n_0_[46] ),
        .I4(\tx_is_idle_half_pipe[1]_i_2_n_0 ),
        .O(p_15_out[1]));
  LUT5 #(
    .INIT(32'hFFBFFFFF)) 
    \tx_is_idle_half_pipe[1]_i_2 
       (.I0(\rxd_pipe_reg_n_0_[41] ),
        .I1(\rxd_pipe_reg_n_0_[43] ),
        .I2(\rxd_pipe_reg_n_0_[42] ),
        .I3(\rxd_pipe_reg_n_0_[40] ),
        .I4(\rxd_pipe_reg_n_0_[44] ),
        .O(\tx_is_idle_half_pipe[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'h14000100)) 
    \tx_is_idle_half_pipe[2]_i_1 
       (.I0(\tx_is_idle_half_pipe[2]_i_2_n_0 ),
        .I1(\rxd_pipe_reg_n_0_[55] ),
        .I2(\rxd_pipe_reg_n_0_[54] ),
        .I3(c7_in),
        .I4(\rxd_pipe_reg_n_0_[53] ),
        .O(p_15_out[2]));
  LUT5 #(
    .INIT(32'hFFBFFFFF)) 
    \tx_is_idle_half_pipe[2]_i_2 
       (.I0(\rxd_pipe_reg_n_0_[49] ),
        .I1(\rxd_pipe_reg_n_0_[51] ),
        .I2(\rxd_pipe_reg_n_0_[50] ),
        .I3(\rxd_pipe_reg_n_0_[48] ),
        .I4(\rxd_pipe_reg_n_0_[52] ),
        .O(\tx_is_idle_half_pipe[2]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h28000200)) 
    \tx_is_idle_half_pipe[3]_i_1 
       (.I0(\tx_is_idle_half_pipe[3]_i_2_n_0 ),
        .I1(\rxd_pipe_reg_n_0_[62] ),
        .I2(\rxd_pipe_reg_n_0_[63] ),
        .I3(c11_in),
        .I4(\rxd_pipe_reg_n_0_[61] ),
        .O(p_15_out[3]));
  LUT5 #(
    .INIT(32'h10000000)) 
    \tx_is_idle_half_pipe[3]_i_2 
       (.I0(\rxd_pipe_reg_n_0_[57] ),
        .I1(\rxd_pipe_reg_n_0_[56] ),
        .I2(\rxd_pipe_reg_n_0_[60] ),
        .I3(\rxd_pipe_reg_n_0_[59] ),
        .I4(\rxd_pipe_reg_n_0_[58] ),
        .O(\tx_is_idle_half_pipe[3]_i_2_n_0 ));
  FDRE \tx_is_idle_half_pipe_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_15_out[0]),
        .Q(\tx_is_idle_half_pipe_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \tx_is_idle_half_pipe_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_15_out[1]),
        .Q(\tx_is_idle_half_pipe_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \tx_is_idle_half_pipe_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_15_out[2]),
        .Q(p_0_in0_in),
        .R(1'b0));
  FDRE \tx_is_idle_half_pipe_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(p_15_out[3]),
        .Q(\tx_is_idle_half_pipe_reg_n_0_[3] ),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h2802)) 
    \tx_is_idle_pipe[0]_i_1 
       (.I0(\mgt_rxdata_reg_reg[4] ),
        .I1(mgt_rxdata[6]),
        .I2(mgt_rxdata[7]),
        .I3(mgt_rxdata[5]),
        .O(\tx_is_idle_pipe[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2802)) 
    \tx_is_idle_pipe[1]_i_1 
       (.I0(\tx_is_idle_pipe_reg[1]_0 ),
        .I1(mgt_rxdata[22]),
        .I2(mgt_rxdata[23]),
        .I3(mgt_rxdata[21]),
        .O(\tx_is_idle_pipe[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000008000)) 
    \tx_is_idle_pipe[1]_i_2 
       (.I0(mgt_rxdata[20]),
        .I1(mgt_rxcharisk[2]),
        .I2(mgt_rxdata[18]),
        .I3(mgt_rxdata[19]),
        .I4(mgt_rxdata[17]),
        .I5(mgt_rxdata[16]),
        .O(\tx_is_idle_pipe_reg[1]_0 ));
  LUT4 #(
    .INIT(16'h2802)) 
    \tx_is_idle_pipe[2]_i_1 
       (.I0(\tx_is_idle_pipe_reg[2]_0 ),
        .I1(mgt_rxdata[39]),
        .I2(mgt_rxdata[38]),
        .I3(mgt_rxdata[37]),
        .O(\tx_is_idle_pipe[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0008000000000000)) 
    \tx_is_idle_pipe[2]_i_2 
       (.I0(mgt_rxdata[36]),
        .I1(mgt_rxcharisk[4]),
        .I2(mgt_rxdata[33]),
        .I3(mgt_rxdata[32]),
        .I4(mgt_rxdata[34]),
        .I5(mgt_rxdata[35]),
        .O(\tx_is_idle_pipe_reg[2]_0 ));
  LUT4 #(
    .INIT(16'h2802)) 
    \tx_is_idle_pipe[3]_i_1 
       (.I0(\tx_is_idle_pipe_reg[3]_0 ),
        .I1(mgt_rxdata[54]),
        .I2(mgt_rxdata[55]),
        .I3(mgt_rxdata[53]),
        .O(\tx_is_idle_pipe[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0008000000000000)) 
    \tx_is_idle_pipe[3]_i_2 
       (.I0(mgt_rxdata[52]),
        .I1(mgt_rxcharisk[6]),
        .I2(mgt_rxdata[49]),
        .I3(mgt_rxdata[48]),
        .I4(mgt_rxdata[50]),
        .I5(mgt_rxdata[51]),
        .O(\tx_is_idle_pipe_reg[3]_0 ));
  FDRE \tx_is_idle_pipe_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\tx_is_idle_pipe[0]_i_1_n_0 ),
        .Q(\tx_is_idle_pipe_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \tx_is_idle_pipe_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\tx_is_idle_pipe[1]_i_1_n_0 ),
        .Q(p_2_in),
        .R(1'b0));
  FDRE \tx_is_idle_pipe_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\tx_is_idle_pipe[2]_i_1_n_0 ),
        .Q(p_4_in),
        .R(1'b0));
  FDRE \tx_is_idle_pipe_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\tx_is_idle_pipe[3]_i_1_n_0 ),
        .Q(p_11_in),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "sync_state_machine" *) 
module xaui_sync_state_machine
   (mgt_enable_align,
    out,
    \sync_ok_reg[0] ,
    \signal_detect_int_reg[0] ,
    usrclk,
    mgt_rx_reset,
    mgt_rxlock,
    usrclk_reset,
    mgt_codecomma,
    mgt_codevalid);
  output [0:0]mgt_enable_align;
  output [2:0]out;
  output \sync_ok_reg[0] ;
  input \signal_detect_int_reg[0] ;
  input usrclk;
  input [0:0]mgt_rx_reset;
  input [0:0]mgt_rxlock;
  input usrclk_reset;
  input [1:0]mgt_codecomma;
  input [1:0]mgt_codevalid;

  wire \FSM_sequential_state[1][0]_i_10_n_0 ;
  wire \FSM_sequential_state[1][0]_i_11_n_0 ;
  wire \FSM_sequential_state[1][0]_i_12_n_0 ;
  wire \FSM_sequential_state[1][0]_i_13_n_0 ;
  wire \FSM_sequential_state[1][0]_i_2_n_0 ;
  wire \FSM_sequential_state[1][0]_i_3_n_0 ;
  wire \FSM_sequential_state[1][0]_i_4_n_0 ;
  wire \FSM_sequential_state[1][0]_i_6_n_0 ;
  wire \FSM_sequential_state[1][0]_i_9_n_0 ;
  wire \FSM_sequential_state[1][1]_i_1_n_0 ;
  wire \FSM_sequential_state[1][1]_i_2_n_0 ;
  wire \FSM_sequential_state[1][1]_i_3_n_0 ;
  wire \FSM_sequential_state[1][1]_i_4_n_0 ;
  wire \FSM_sequential_state[1][1]_i_5_n_0 ;
  wire \FSM_sequential_state[1][2]_i_1_n_0 ;
  wire \FSM_sequential_state[1][2]_i_2_n_0 ;
  wire \FSM_sequential_state[1][2]_i_3_n_0 ;
  wire \FSM_sequential_state[1][2]_i_4_n_0 ;
  wire \FSM_sequential_state[1][2]_i_5_n_0 ;
  wire \FSM_sequential_state[1][3]_i_1_n_0 ;
  wire \FSM_sequential_state[1][3]_i_2_n_0 ;
  wire \FSM_sequential_state[1][4]_i_1_n_0 ;
  wire \FSM_sequential_state[1][4]_i_2_n_0 ;
  wire \FSM_sequential_state[1][4]_i_3_n_0 ;
  wire \FSM_sequential_state_reg[1][0]_i_1_n_0 ;
  wire \FSM_sequential_state_reg[1][0]_i_5_n_0 ;
  wire \FSM_sequential_state_reg[1][0]_i_7_n_0 ;
  wire \code_comma_pipe_reg_n_0_[0] ;
  wire \code_comma_pipe_reg_n_0_[1] ;
  wire \code_valid_pipe_reg_n_0_[0] ;
  wire \code_valid_pipe_reg_n_0_[1] ;
  wire enable_align_i;
  wire get_next_state;
  wire [1:0]mgt_codecomma;
  wire [1:0]mgt_codevalid;
  wire [0:0]mgt_enable_align;
  wire [0:0]mgt_rx_reset;
  wire [0:0]mgt_rxlock;
  (* RTL_KEEP = "yes" *) wire [2:0]out;
  wire \signal_detect_int_reg[0] ;
  wire signal_detect_last;
  (* RTL_KEEP = "yes" *) wire [1:0]state;
  wire \sync_ok_reg[0] ;
  wire usrclk;
  wire usrclk_reset;

  LUT6 #(
    .INIT(64'h4040E04AFFFF0CC0)) 
    \FSM_sequential_state[1][0]_i_10 
       (.I0(\code_valid_pipe_reg_n_0_[0] ),
        .I1(\signal_detect_int_reg[0] ),
        .I2(\code_comma_pipe_reg_n_0_[1] ),
        .I3(\code_comma_pipe_reg_n_0_[0] ),
        .I4(out[1]),
        .I5(state[0]),
        .O(\FSM_sequential_state[1][0]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h3F373C483C043C48)) 
    \FSM_sequential_state[1][0]_i_11 
       (.I0(\code_comma_pipe_reg_n_0_[0] ),
        .I1(\code_valid_pipe_reg_n_0_[0] ),
        .I2(state[0]),
        .I3(out[1]),
        .I4(\code_comma_pipe_reg_n_0_[1] ),
        .I5(\signal_detect_int_reg[0] ),
        .O(\FSM_sequential_state[1][0]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h6467202020202020)) 
    \FSM_sequential_state[1][0]_i_12 
       (.I0(\code_valid_pipe_reg_n_0_[0] ),
        .I1(state[0]),
        .I2(out[1]),
        .I3(\code_comma_pipe_reg_n_0_[0] ),
        .I4(\code_comma_pipe_reg_n_0_[1] ),
        .I5(\signal_detect_int_reg[0] ),
        .O(\FSM_sequential_state[1][0]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'hCFB3CC80CC80CC80)) 
    \FSM_sequential_state[1][0]_i_13 
       (.I0(\code_comma_pipe_reg_n_0_[0] ),
        .I1(\code_valid_pipe_reg_n_0_[0] ),
        .I2(state[0]),
        .I3(out[1]),
        .I4(\code_comma_pipe_reg_n_0_[1] ),
        .I5(\signal_detect_int_reg[0] ),
        .O(\FSM_sequential_state[1][0]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \FSM_sequential_state[1][0]_i_2 
       (.I0(\FSM_sequential_state[1][0]_i_4_n_0 ),
        .I1(\FSM_sequential_state_reg[1][0]_i_5_n_0 ),
        .I2(\code_valid_pipe_reg_n_0_[1] ),
        .I3(\FSM_sequential_state[1][0]_i_6_n_0 ),
        .I4(out[0]),
        .I5(\FSM_sequential_state_reg[1][0]_i_7_n_0 ),
        .O(\FSM_sequential_state[1][0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000022003000)) 
    \FSM_sequential_state[1][0]_i_3 
       (.I0(\code_valid_pipe_reg_n_0_[1] ),
        .I1(state[1]),
        .I2(get_next_state),
        .I3(\FSM_sequential_state[1][0]_i_9_n_0 ),
        .I4(\code_valid_pipe_reg_n_0_[0] ),
        .I5(out[0]),
        .O(\FSM_sequential_state[1][0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h000F00008FFFFFFF)) 
    \FSM_sequential_state[1][0]_i_4 
       (.I0(\signal_detect_int_reg[0] ),
        .I1(\code_comma_pipe_reg_n_0_[1] ),
        .I2(state[1]),
        .I3(state[0]),
        .I4(out[1]),
        .I5(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0FFFFFFF8F0FF0FF)) 
    \FSM_sequential_state[1][0]_i_6 
       (.I0(\signal_detect_int_reg[0] ),
        .I1(\code_comma_pipe_reg_n_0_[1] ),
        .I2(state[1]),
        .I3(out[1]),
        .I4(state[0]),
        .I5(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][0]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \FSM_sequential_state[1][0]_i_8 
       (.I0(\signal_detect_int_reg[0] ),
        .I1(\code_comma_pipe_reg_n_0_[1] ),
        .O(get_next_state));
  LUT2 #(
    .INIT(4'h1)) 
    \FSM_sequential_state[1][0]_i_9 
       (.I0(out[1]),
        .I1(state[0]),
        .O(\FSM_sequential_state[1][0]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \FSM_sequential_state[1][1]_i_1 
       (.I0(\FSM_sequential_state[1][2]_i_2_n_0 ),
        .I1(out[2]),
        .I2(\FSM_sequential_state[1][1]_i_2_n_0 ),
        .I3(\code_valid_pipe_reg_n_0_[1] ),
        .I4(\FSM_sequential_state[1][1]_i_3_n_0 ),
        .O(\FSM_sequential_state[1][1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h1F10CFCF1F10C0C0)) 
    \FSM_sequential_state[1][1]_i_2 
       (.I0(\code_valid_pipe_reg_n_0_[0] ),
        .I1(state[0]),
        .I2(out[0]),
        .I3(\FSM_sequential_state[1][1]_i_4_n_0 ),
        .I4(state[1]),
        .I5(\FSM_sequential_state[1][1]_i_5_n_0 ),
        .O(\FSM_sequential_state[1][1]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h67A8282A)) 
    \FSM_sequential_state[1][1]_i_3 
       (.I0(out[0]),
        .I1(state[1]),
        .I2(state[0]),
        .I3(out[1]),
        .I4(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][1]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h45570000)) 
    \FSM_sequential_state[1][1]_i_4 
       (.I0(state[0]),
        .I1(out[1]),
        .I2(\code_comma_pipe_reg_n_0_[0] ),
        .I3(\code_comma_pipe_reg_n_0_[1] ),
        .I4(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h8888B88888888800)) 
    \FSM_sequential_state[1][1]_i_5 
       (.I0(\code_valid_pipe_reg_n_0_[0] ),
        .I1(state[0]),
        .I2(\signal_detect_int_reg[0] ),
        .I3(\code_comma_pipe_reg_n_0_[0] ),
        .I4(out[1]),
        .I5(\code_comma_pipe_reg_n_0_[1] ),
        .O(\FSM_sequential_state[1][1]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \FSM_sequential_state[1][2]_i_1 
       (.I0(\FSM_sequential_state[1][2]_i_2_n_0 ),
        .I1(out[2]),
        .I2(\FSM_sequential_state[1][2]_i_3_n_0 ),
        .I3(\code_valid_pipe_reg_n_0_[1] ),
        .I4(\FSM_sequential_state[1][2]_i_4_n_0 ),
        .O(\FSM_sequential_state[1][2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000400000000)) 
    \FSM_sequential_state[1][2]_i_2 
       (.I0(out[0]),
        .I1(\code_valid_pipe_reg_n_0_[0] ),
        .I2(out[1]),
        .I3(state[0]),
        .I4(state[1]),
        .I5(\code_valid_pipe_reg_n_0_[1] ),
        .O(\FSM_sequential_state[1][2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7701FFFF77010000)) 
    \FSM_sequential_state[1][2]_i_3 
       (.I0(state[1]),
        .I1(state[0]),
        .I2(out[1]),
        .I3(\code_valid_pipe_reg_n_0_[0] ),
        .I4(out[0]),
        .I5(\FSM_sequential_state[1][2]_i_5_n_0 ),
        .O(\FSM_sequential_state[1][2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h5AFFEAAA0AA00AAA)) 
    \FSM_sequential_state[1][2]_i_4 
       (.I0(out[0]),
        .I1(\code_comma_pipe_reg_n_0_[0] ),
        .I2(state[1]),
        .I3(state[0]),
        .I4(out[1]),
        .I5(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][2]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hF00FE08000000000)) 
    \FSM_sequential_state[1][2]_i_5 
       (.I0(\code_comma_pipe_reg_n_0_[0] ),
        .I1(\code_comma_pipe_reg_n_0_[1] ),
        .I2(state[1]),
        .I3(state[0]),
        .I4(out[1]),
        .I5(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][2]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_sequential_state[1][3]_i_1 
       (.I0(\FSM_sequential_state[1][3]_i_2_n_0 ),
        .I1(out[2]),
        .O(\FSM_sequential_state[1][3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h3A39C0002CCA8CC8)) 
    \FSM_sequential_state[1][3]_i_2 
       (.I0(\code_valid_pipe_reg_n_0_[1] ),
        .I1(out[0]),
        .I2(state[1]),
        .I3(state[0]),
        .I4(out[1]),
        .I5(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][3]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF6FF)) 
    \FSM_sequential_state[1][4]_i_1 
       (.I0(signal_detect_last),
        .I1(\signal_detect_int_reg[0] ),
        .I2(mgt_rx_reset),
        .I3(mgt_rxlock),
        .I4(usrclk_reset),
        .O(\FSM_sequential_state[1][4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000080000000)) 
    \FSM_sequential_state[1][4]_i_2 
       (.I0(\code_valid_pipe_reg_n_0_[1] ),
        .I1(state[1]),
        .I2(\FSM_sequential_state[1][4]_i_3_n_0 ),
        .I3(\code_valid_pipe_reg_n_0_[0] ),
        .I4(out[0]),
        .I5(out[2]),
        .O(\FSM_sequential_state[1][4]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \FSM_sequential_state[1][4]_i_3 
       (.I0(out[1]),
        .I1(state[0]),
        .O(\FSM_sequential_state[1][4]_i_3_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[1][0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\FSM_sequential_state_reg[1][0]_i_1_n_0 ),
        .Q(state[0]),
        .R(\FSM_sequential_state[1][4]_i_1_n_0 ));
  MUXF7 \FSM_sequential_state_reg[1][0]_i_1 
       (.I0(\FSM_sequential_state[1][0]_i_2_n_0 ),
        .I1(\FSM_sequential_state[1][0]_i_3_n_0 ),
        .O(\FSM_sequential_state_reg[1][0]_i_1_n_0 ),
        .S(out[2]));
  MUXF7 \FSM_sequential_state_reg[1][0]_i_5 
       (.I0(\FSM_sequential_state[1][0]_i_10_n_0 ),
        .I1(\FSM_sequential_state[1][0]_i_11_n_0 ),
        .O(\FSM_sequential_state_reg[1][0]_i_5_n_0 ),
        .S(state[1]));
  MUXF7 \FSM_sequential_state_reg[1][0]_i_7 
       (.I0(\FSM_sequential_state[1][0]_i_12_n_0 ),
        .I1(\FSM_sequential_state[1][0]_i_13_n_0 ),
        .O(\FSM_sequential_state_reg[1][0]_i_7_n_0 ),
        .S(state[1]));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[1][1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\FSM_sequential_state[1][1]_i_1_n_0 ),
        .Q(state[1]),
        .R(\FSM_sequential_state[1][4]_i_1_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[1][2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\FSM_sequential_state[1][2]_i_1_n_0 ),
        .Q(out[0]),
        .R(\FSM_sequential_state[1][4]_i_1_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[1][3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\FSM_sequential_state[1][3]_i_1_n_0 ),
        .Q(out[1]),
        .R(\FSM_sequential_state[1][4]_i_1_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[1][4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\FSM_sequential_state[1][4]_i_2_n_0 ),
        .Q(out[2]),
        .R(\FSM_sequential_state[1][4]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \code_comma_pipe_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_codecomma[0]),
        .Q(\code_comma_pipe_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \code_comma_pipe_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_codecomma[1]),
        .Q(\code_comma_pipe_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \code_valid_pipe_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_codevalid[0]),
        .Q(\code_valid_pipe_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \code_valid_pipe_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_codevalid[1]),
        .Q(\code_valid_pipe_reg_n_0_[1] ),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h00000001)) 
    enable_align_i_1
       (.I0(out[0]),
        .I1(state[0]),
        .I2(out[1]),
        .I3(state[1]),
        .I4(out[2]),
        .O(enable_align_i));
  FDRE enable_align_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(enable_align_i),
        .Q(mgt_enable_align),
        .R(1'b0));
  FDRE signal_detect_last_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(\signal_detect_int_reg[0] ),
        .Q(signal_detect_last),
        .R(1'b0));
  LUT2 #(
    .INIT(4'hE)) 
    \sync_ok[0]_i_1 
       (.I0(out[1]),
        .I1(out[0]),
        .O(\sync_ok_reg[0] ));
endmodule

(* ORIG_REF_NAME = "sync_state_machine" *) 
module xaui_sync_state_machine_30
   (mgt_enable_align,
    out,
    \sync_ok_reg[1] ,
    \signal_detect_int_reg[1] ,
    usrclk,
    mgt_rx_reset,
    mgt_rxlock,
    usrclk_reset,
    mgt_codecomma,
    mgt_codevalid);
  output [0:0]mgt_enable_align;
  output [2:0]out;
  output \sync_ok_reg[1] ;
  input \signal_detect_int_reg[1] ;
  input usrclk;
  input [0:0]mgt_rx_reset;
  input [0:0]mgt_rxlock;
  input usrclk_reset;
  input [1:0]mgt_codecomma;
  input [1:0]mgt_codevalid;

  wire \FSM_sequential_state[1][0]_i_10__0_n_0 ;
  wire \FSM_sequential_state[1][0]_i_11__0_n_0 ;
  wire \FSM_sequential_state[1][0]_i_12__0_n_0 ;
  wire \FSM_sequential_state[1][0]_i_13__0_n_0 ;
  wire \FSM_sequential_state[1][0]_i_2__0_n_0 ;
  wire \FSM_sequential_state[1][0]_i_3__0_n_0 ;
  wire \FSM_sequential_state[1][0]_i_4__0_n_0 ;
  wire \FSM_sequential_state[1][0]_i_6__0_n_0 ;
  wire \FSM_sequential_state[1][0]_i_9__0_n_0 ;
  wire \FSM_sequential_state[1][1]_i_1__0_n_0 ;
  wire \FSM_sequential_state[1][1]_i_2__0_n_0 ;
  wire \FSM_sequential_state[1][1]_i_3__0_n_0 ;
  wire \FSM_sequential_state[1][1]_i_4__0_n_0 ;
  wire \FSM_sequential_state[1][1]_i_5__0_n_0 ;
  wire \FSM_sequential_state[1][2]_i_1__0_n_0 ;
  wire \FSM_sequential_state[1][2]_i_2__0_n_0 ;
  wire \FSM_sequential_state[1][2]_i_3__0_n_0 ;
  wire \FSM_sequential_state[1][2]_i_4__0_n_0 ;
  wire \FSM_sequential_state[1][2]_i_5__0_n_0 ;
  wire \FSM_sequential_state[1][3]_i_1__0_n_0 ;
  wire \FSM_sequential_state[1][3]_i_2__0_n_0 ;
  wire \FSM_sequential_state[1][4]_i_1__0_n_0 ;
  wire \FSM_sequential_state[1][4]_i_2__0_n_0 ;
  wire \FSM_sequential_state[1][4]_i_3__0_n_0 ;
  wire \FSM_sequential_state_reg[1][0]_i_1__0_n_0 ;
  wire \FSM_sequential_state_reg[1][0]_i_5__0_n_0 ;
  wire \FSM_sequential_state_reg[1][0]_i_7__0_n_0 ;
  wire \code_comma_pipe_reg_n_0_[0] ;
  wire \code_comma_pipe_reg_n_0_[1] ;
  wire \code_valid_pipe_reg_n_0_[0] ;
  wire \code_valid_pipe_reg_n_0_[1] ;
  wire enable_align_i;
  wire get_next_state;
  wire [1:0]mgt_codecomma;
  wire [1:0]mgt_codevalid;
  wire [0:0]mgt_enable_align;
  wire [0:0]mgt_rx_reset;
  wire [0:0]mgt_rxlock;
  (* RTL_KEEP = "yes" *) wire [2:0]out;
  wire \signal_detect_int_reg[1] ;
  wire signal_detect_last;
  (* RTL_KEEP = "yes" *) wire [1:0]state;
  wire \sync_ok_reg[1] ;
  wire usrclk;
  wire usrclk_reset;

  LUT6 #(
    .INIT(64'h4040E04AFFFF0CC0)) 
    \FSM_sequential_state[1][0]_i_10__0 
       (.I0(\code_valid_pipe_reg_n_0_[0] ),
        .I1(\signal_detect_int_reg[1] ),
        .I2(\code_comma_pipe_reg_n_0_[1] ),
        .I3(\code_comma_pipe_reg_n_0_[0] ),
        .I4(out[1]),
        .I5(state[0]),
        .O(\FSM_sequential_state[1][0]_i_10__0_n_0 ));
  LUT6 #(
    .INIT(64'h3F373C483C043C48)) 
    \FSM_sequential_state[1][0]_i_11__0 
       (.I0(\code_comma_pipe_reg_n_0_[0] ),
        .I1(\code_valid_pipe_reg_n_0_[0] ),
        .I2(state[0]),
        .I3(out[1]),
        .I4(\code_comma_pipe_reg_n_0_[1] ),
        .I5(\signal_detect_int_reg[1] ),
        .O(\FSM_sequential_state[1][0]_i_11__0_n_0 ));
  LUT6 #(
    .INIT(64'h6467202020202020)) 
    \FSM_sequential_state[1][0]_i_12__0 
       (.I0(\code_valid_pipe_reg_n_0_[0] ),
        .I1(state[0]),
        .I2(out[1]),
        .I3(\code_comma_pipe_reg_n_0_[0] ),
        .I4(\code_comma_pipe_reg_n_0_[1] ),
        .I5(\signal_detect_int_reg[1] ),
        .O(\FSM_sequential_state[1][0]_i_12__0_n_0 ));
  LUT6 #(
    .INIT(64'hCFB3CC80CC80CC80)) 
    \FSM_sequential_state[1][0]_i_13__0 
       (.I0(\code_comma_pipe_reg_n_0_[0] ),
        .I1(\code_valid_pipe_reg_n_0_[0] ),
        .I2(state[0]),
        .I3(out[1]),
        .I4(\code_comma_pipe_reg_n_0_[1] ),
        .I5(\signal_detect_int_reg[1] ),
        .O(\FSM_sequential_state[1][0]_i_13__0_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \FSM_sequential_state[1][0]_i_2__0 
       (.I0(\FSM_sequential_state[1][0]_i_4__0_n_0 ),
        .I1(\FSM_sequential_state_reg[1][0]_i_5__0_n_0 ),
        .I2(\code_valid_pipe_reg_n_0_[1] ),
        .I3(\FSM_sequential_state[1][0]_i_6__0_n_0 ),
        .I4(out[0]),
        .I5(\FSM_sequential_state_reg[1][0]_i_7__0_n_0 ),
        .O(\FSM_sequential_state[1][0]_i_2__0_n_0 ));
  LUT6 #(
    .INIT(64'h0000000022003000)) 
    \FSM_sequential_state[1][0]_i_3__0 
       (.I0(\code_valid_pipe_reg_n_0_[1] ),
        .I1(state[1]),
        .I2(get_next_state),
        .I3(\FSM_sequential_state[1][0]_i_9__0_n_0 ),
        .I4(\code_valid_pipe_reg_n_0_[0] ),
        .I5(out[0]),
        .O(\FSM_sequential_state[1][0]_i_3__0_n_0 ));
  LUT6 #(
    .INIT(64'h000F00008FFFFFFF)) 
    \FSM_sequential_state[1][0]_i_4__0 
       (.I0(\signal_detect_int_reg[1] ),
        .I1(\code_comma_pipe_reg_n_0_[1] ),
        .I2(state[1]),
        .I3(state[0]),
        .I4(out[1]),
        .I5(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][0]_i_4__0_n_0 ));
  LUT6 #(
    .INIT(64'h0FFFFFFF8F0FF0FF)) 
    \FSM_sequential_state[1][0]_i_6__0 
       (.I0(\signal_detect_int_reg[1] ),
        .I1(\code_comma_pipe_reg_n_0_[1] ),
        .I2(state[1]),
        .I3(out[1]),
        .I4(state[0]),
        .I5(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][0]_i_6__0_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \FSM_sequential_state[1][0]_i_8__0 
       (.I0(\signal_detect_int_reg[1] ),
        .I1(\code_comma_pipe_reg_n_0_[1] ),
        .O(get_next_state));
  LUT2 #(
    .INIT(4'h1)) 
    \FSM_sequential_state[1][0]_i_9__0 
       (.I0(out[1]),
        .I1(state[0]),
        .O(\FSM_sequential_state[1][0]_i_9__0_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \FSM_sequential_state[1][1]_i_1__0 
       (.I0(\FSM_sequential_state[1][2]_i_2__0_n_0 ),
        .I1(out[2]),
        .I2(\FSM_sequential_state[1][1]_i_2__0_n_0 ),
        .I3(\code_valid_pipe_reg_n_0_[1] ),
        .I4(\FSM_sequential_state[1][1]_i_3__0_n_0 ),
        .O(\FSM_sequential_state[1][1]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h1F10CFCF1F10C0C0)) 
    \FSM_sequential_state[1][1]_i_2__0 
       (.I0(\code_valid_pipe_reg_n_0_[0] ),
        .I1(state[0]),
        .I2(out[0]),
        .I3(\FSM_sequential_state[1][1]_i_4__0_n_0 ),
        .I4(state[1]),
        .I5(\FSM_sequential_state[1][1]_i_5__0_n_0 ),
        .O(\FSM_sequential_state[1][1]_i_2__0_n_0 ));
  LUT5 #(
    .INIT(32'h67A8282A)) 
    \FSM_sequential_state[1][1]_i_3__0 
       (.I0(out[0]),
        .I1(state[1]),
        .I2(state[0]),
        .I3(out[1]),
        .I4(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][1]_i_3__0_n_0 ));
  LUT5 #(
    .INIT(32'h45570000)) 
    \FSM_sequential_state[1][1]_i_4__0 
       (.I0(state[0]),
        .I1(out[1]),
        .I2(\code_comma_pipe_reg_n_0_[0] ),
        .I3(\code_comma_pipe_reg_n_0_[1] ),
        .I4(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][1]_i_4__0_n_0 ));
  LUT6 #(
    .INIT(64'h8888B88888888800)) 
    \FSM_sequential_state[1][1]_i_5__0 
       (.I0(\code_valid_pipe_reg_n_0_[0] ),
        .I1(state[0]),
        .I2(\signal_detect_int_reg[1] ),
        .I3(\code_comma_pipe_reg_n_0_[0] ),
        .I4(out[1]),
        .I5(\code_comma_pipe_reg_n_0_[1] ),
        .O(\FSM_sequential_state[1][1]_i_5__0_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \FSM_sequential_state[1][2]_i_1__0 
       (.I0(\FSM_sequential_state[1][2]_i_2__0_n_0 ),
        .I1(out[2]),
        .I2(\FSM_sequential_state[1][2]_i_3__0_n_0 ),
        .I3(\code_valid_pipe_reg_n_0_[1] ),
        .I4(\FSM_sequential_state[1][2]_i_4__0_n_0 ),
        .O(\FSM_sequential_state[1][2]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h0000000400000000)) 
    \FSM_sequential_state[1][2]_i_2__0 
       (.I0(out[0]),
        .I1(\code_valid_pipe_reg_n_0_[0] ),
        .I2(out[1]),
        .I3(state[0]),
        .I4(state[1]),
        .I5(\code_valid_pipe_reg_n_0_[1] ),
        .O(\FSM_sequential_state[1][2]_i_2__0_n_0 ));
  LUT6 #(
    .INIT(64'h7701FFFF77010000)) 
    \FSM_sequential_state[1][2]_i_3__0 
       (.I0(state[1]),
        .I1(state[0]),
        .I2(out[1]),
        .I3(\code_valid_pipe_reg_n_0_[0] ),
        .I4(out[0]),
        .I5(\FSM_sequential_state[1][2]_i_5__0_n_0 ),
        .O(\FSM_sequential_state[1][2]_i_3__0_n_0 ));
  LUT6 #(
    .INIT(64'h5AFFEAAA0AA00AAA)) 
    \FSM_sequential_state[1][2]_i_4__0 
       (.I0(out[0]),
        .I1(\code_comma_pipe_reg_n_0_[0] ),
        .I2(state[1]),
        .I3(state[0]),
        .I4(out[1]),
        .I5(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][2]_i_4__0_n_0 ));
  LUT6 #(
    .INIT(64'hF00FE08000000000)) 
    \FSM_sequential_state[1][2]_i_5__0 
       (.I0(\code_comma_pipe_reg_n_0_[0] ),
        .I1(\code_comma_pipe_reg_n_0_[1] ),
        .I2(state[1]),
        .I3(state[0]),
        .I4(out[1]),
        .I5(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][2]_i_5__0_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_sequential_state[1][3]_i_1__0 
       (.I0(\FSM_sequential_state[1][3]_i_2__0_n_0 ),
        .I1(out[2]),
        .O(\FSM_sequential_state[1][3]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h3A39C0002CCA8CC8)) 
    \FSM_sequential_state[1][3]_i_2__0 
       (.I0(\code_valid_pipe_reg_n_0_[1] ),
        .I1(out[0]),
        .I2(state[1]),
        .I3(state[0]),
        .I4(out[1]),
        .I5(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][3]_i_2__0_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF6FF)) 
    \FSM_sequential_state[1][4]_i_1__0 
       (.I0(signal_detect_last),
        .I1(\signal_detect_int_reg[1] ),
        .I2(mgt_rx_reset),
        .I3(mgt_rxlock),
        .I4(usrclk_reset),
        .O(\FSM_sequential_state[1][4]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h0000000080000000)) 
    \FSM_sequential_state[1][4]_i_2__0 
       (.I0(\code_valid_pipe_reg_n_0_[1] ),
        .I1(state[1]),
        .I2(\FSM_sequential_state[1][4]_i_3__0_n_0 ),
        .I3(\code_valid_pipe_reg_n_0_[0] ),
        .I4(out[0]),
        .I5(out[2]),
        .O(\FSM_sequential_state[1][4]_i_2__0_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \FSM_sequential_state[1][4]_i_3__0 
       (.I0(out[1]),
        .I1(state[0]),
        .O(\FSM_sequential_state[1][4]_i_3__0_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[1][0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\FSM_sequential_state_reg[1][0]_i_1__0_n_0 ),
        .Q(state[0]),
        .R(\FSM_sequential_state[1][4]_i_1__0_n_0 ));
  MUXF7 \FSM_sequential_state_reg[1][0]_i_1__0 
       (.I0(\FSM_sequential_state[1][0]_i_2__0_n_0 ),
        .I1(\FSM_sequential_state[1][0]_i_3__0_n_0 ),
        .O(\FSM_sequential_state_reg[1][0]_i_1__0_n_0 ),
        .S(out[2]));
  MUXF7 \FSM_sequential_state_reg[1][0]_i_5__0 
       (.I0(\FSM_sequential_state[1][0]_i_10__0_n_0 ),
        .I1(\FSM_sequential_state[1][0]_i_11__0_n_0 ),
        .O(\FSM_sequential_state_reg[1][0]_i_5__0_n_0 ),
        .S(state[1]));
  MUXF7 \FSM_sequential_state_reg[1][0]_i_7__0 
       (.I0(\FSM_sequential_state[1][0]_i_12__0_n_0 ),
        .I1(\FSM_sequential_state[1][0]_i_13__0_n_0 ),
        .O(\FSM_sequential_state_reg[1][0]_i_7__0_n_0 ),
        .S(state[1]));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[1][1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\FSM_sequential_state[1][1]_i_1__0_n_0 ),
        .Q(state[1]),
        .R(\FSM_sequential_state[1][4]_i_1__0_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[1][2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\FSM_sequential_state[1][2]_i_1__0_n_0 ),
        .Q(out[0]),
        .R(\FSM_sequential_state[1][4]_i_1__0_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[1][3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\FSM_sequential_state[1][3]_i_1__0_n_0 ),
        .Q(out[1]),
        .R(\FSM_sequential_state[1][4]_i_1__0_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[1][4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\FSM_sequential_state[1][4]_i_2__0_n_0 ),
        .Q(out[2]),
        .R(\FSM_sequential_state[1][4]_i_1__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \code_comma_pipe_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_codecomma[0]),
        .Q(\code_comma_pipe_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \code_comma_pipe_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_codecomma[1]),
        .Q(\code_comma_pipe_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \code_valid_pipe_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_codevalid[0]),
        .Q(\code_valid_pipe_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \code_valid_pipe_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_codevalid[1]),
        .Q(\code_valid_pipe_reg_n_0_[1] ),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h00000001)) 
    enable_align_i_1__0
       (.I0(out[0]),
        .I1(state[0]),
        .I2(out[1]),
        .I3(state[1]),
        .I4(out[2]),
        .O(enable_align_i));
  FDRE enable_align_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(enable_align_i),
        .Q(mgt_enable_align),
        .R(1'b0));
  FDRE signal_detect_last_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(\signal_detect_int_reg[1] ),
        .Q(signal_detect_last),
        .R(1'b0));
  LUT2 #(
    .INIT(4'hE)) 
    \sync_ok[1]_i_1 
       (.I0(out[1]),
        .I1(out[0]),
        .O(\sync_ok_reg[1] ));
endmodule

(* ORIG_REF_NAME = "sync_state_machine" *) 
module xaui_sync_state_machine_31
   (mgt_enable_align,
    out,
    \sync_ok_reg[2] ,
    \signal_detect_int_reg[2] ,
    usrclk,
    mgt_rx_reset,
    mgt_rxlock,
    usrclk_reset,
    mgt_codecomma,
    mgt_codevalid);
  output [0:0]mgt_enable_align;
  output [2:0]out;
  output \sync_ok_reg[2] ;
  input \signal_detect_int_reg[2] ;
  input usrclk;
  input [0:0]mgt_rx_reset;
  input [0:0]mgt_rxlock;
  input usrclk_reset;
  input [1:0]mgt_codecomma;
  input [1:0]mgt_codevalid;

  wire \FSM_sequential_state[1][0]_i_10__1_n_0 ;
  wire \FSM_sequential_state[1][0]_i_11__1_n_0 ;
  wire \FSM_sequential_state[1][0]_i_12__1_n_0 ;
  wire \FSM_sequential_state[1][0]_i_13__1_n_0 ;
  wire \FSM_sequential_state[1][0]_i_2__1_n_0 ;
  wire \FSM_sequential_state[1][0]_i_3__1_n_0 ;
  wire \FSM_sequential_state[1][0]_i_4__1_n_0 ;
  wire \FSM_sequential_state[1][0]_i_6__1_n_0 ;
  wire \FSM_sequential_state[1][0]_i_9__1_n_0 ;
  wire \FSM_sequential_state[1][1]_i_1__1_n_0 ;
  wire \FSM_sequential_state[1][1]_i_2__1_n_0 ;
  wire \FSM_sequential_state[1][1]_i_3__1_n_0 ;
  wire \FSM_sequential_state[1][1]_i_4__1_n_0 ;
  wire \FSM_sequential_state[1][1]_i_5__1_n_0 ;
  wire \FSM_sequential_state[1][2]_i_1__1_n_0 ;
  wire \FSM_sequential_state[1][2]_i_2__1_n_0 ;
  wire \FSM_sequential_state[1][2]_i_3__1_n_0 ;
  wire \FSM_sequential_state[1][2]_i_4__1_n_0 ;
  wire \FSM_sequential_state[1][2]_i_5__1_n_0 ;
  wire \FSM_sequential_state[1][3]_i_1__1_n_0 ;
  wire \FSM_sequential_state[1][3]_i_2__1_n_0 ;
  wire \FSM_sequential_state[1][4]_i_1__1_n_0 ;
  wire \FSM_sequential_state[1][4]_i_2__1_n_0 ;
  wire \FSM_sequential_state[1][4]_i_3__1_n_0 ;
  wire \FSM_sequential_state_reg[1][0]_i_1__1_n_0 ;
  wire \FSM_sequential_state_reg[1][0]_i_5__1_n_0 ;
  wire \FSM_sequential_state_reg[1][0]_i_7__1_n_0 ;
  wire \code_comma_pipe_reg_n_0_[0] ;
  wire \code_comma_pipe_reg_n_0_[1] ;
  wire \code_valid_pipe_reg_n_0_[0] ;
  wire \code_valid_pipe_reg_n_0_[1] ;
  wire enable_align_i;
  wire get_next_state;
  wire [1:0]mgt_codecomma;
  wire [1:0]mgt_codevalid;
  wire [0:0]mgt_enable_align;
  wire [0:0]mgt_rx_reset;
  wire [0:0]mgt_rxlock;
  (* RTL_KEEP = "yes" *) wire [2:0]out;
  wire \signal_detect_int_reg[2] ;
  wire signal_detect_last;
  (* RTL_KEEP = "yes" *) wire [1:0]state;
  wire \sync_ok_reg[2] ;
  wire usrclk;
  wire usrclk_reset;

  LUT6 #(
    .INIT(64'h4040E04AFFFF0CC0)) 
    \FSM_sequential_state[1][0]_i_10__1 
       (.I0(\code_valid_pipe_reg_n_0_[0] ),
        .I1(\signal_detect_int_reg[2] ),
        .I2(\code_comma_pipe_reg_n_0_[1] ),
        .I3(\code_comma_pipe_reg_n_0_[0] ),
        .I4(out[1]),
        .I5(state[0]),
        .O(\FSM_sequential_state[1][0]_i_10__1_n_0 ));
  LUT6 #(
    .INIT(64'h3F373C483C043C48)) 
    \FSM_sequential_state[1][0]_i_11__1 
       (.I0(\code_comma_pipe_reg_n_0_[0] ),
        .I1(\code_valid_pipe_reg_n_0_[0] ),
        .I2(state[0]),
        .I3(out[1]),
        .I4(\code_comma_pipe_reg_n_0_[1] ),
        .I5(\signal_detect_int_reg[2] ),
        .O(\FSM_sequential_state[1][0]_i_11__1_n_0 ));
  LUT6 #(
    .INIT(64'h6467202020202020)) 
    \FSM_sequential_state[1][0]_i_12__1 
       (.I0(\code_valid_pipe_reg_n_0_[0] ),
        .I1(state[0]),
        .I2(out[1]),
        .I3(\code_comma_pipe_reg_n_0_[0] ),
        .I4(\code_comma_pipe_reg_n_0_[1] ),
        .I5(\signal_detect_int_reg[2] ),
        .O(\FSM_sequential_state[1][0]_i_12__1_n_0 ));
  LUT6 #(
    .INIT(64'hCFB3CC80CC80CC80)) 
    \FSM_sequential_state[1][0]_i_13__1 
       (.I0(\code_comma_pipe_reg_n_0_[0] ),
        .I1(\code_valid_pipe_reg_n_0_[0] ),
        .I2(state[0]),
        .I3(out[1]),
        .I4(\code_comma_pipe_reg_n_0_[1] ),
        .I5(\signal_detect_int_reg[2] ),
        .O(\FSM_sequential_state[1][0]_i_13__1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \FSM_sequential_state[1][0]_i_2__1 
       (.I0(\FSM_sequential_state[1][0]_i_4__1_n_0 ),
        .I1(\FSM_sequential_state_reg[1][0]_i_5__1_n_0 ),
        .I2(\code_valid_pipe_reg_n_0_[1] ),
        .I3(\FSM_sequential_state[1][0]_i_6__1_n_0 ),
        .I4(out[0]),
        .I5(\FSM_sequential_state_reg[1][0]_i_7__1_n_0 ),
        .O(\FSM_sequential_state[1][0]_i_2__1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000022003000)) 
    \FSM_sequential_state[1][0]_i_3__1 
       (.I0(\code_valid_pipe_reg_n_0_[1] ),
        .I1(state[1]),
        .I2(get_next_state),
        .I3(\FSM_sequential_state[1][0]_i_9__1_n_0 ),
        .I4(\code_valid_pipe_reg_n_0_[0] ),
        .I5(out[0]),
        .O(\FSM_sequential_state[1][0]_i_3__1_n_0 ));
  LUT6 #(
    .INIT(64'h000F00008FFFFFFF)) 
    \FSM_sequential_state[1][0]_i_4__1 
       (.I0(\signal_detect_int_reg[2] ),
        .I1(\code_comma_pipe_reg_n_0_[1] ),
        .I2(state[1]),
        .I3(state[0]),
        .I4(out[1]),
        .I5(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][0]_i_4__1_n_0 ));
  LUT6 #(
    .INIT(64'h0FFFFFFF8F0FF0FF)) 
    \FSM_sequential_state[1][0]_i_6__1 
       (.I0(\signal_detect_int_reg[2] ),
        .I1(\code_comma_pipe_reg_n_0_[1] ),
        .I2(state[1]),
        .I3(out[1]),
        .I4(state[0]),
        .I5(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][0]_i_6__1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \FSM_sequential_state[1][0]_i_8__1 
       (.I0(\signal_detect_int_reg[2] ),
        .I1(\code_comma_pipe_reg_n_0_[1] ),
        .O(get_next_state));
  LUT2 #(
    .INIT(4'h1)) 
    \FSM_sequential_state[1][0]_i_9__1 
       (.I0(out[1]),
        .I1(state[0]),
        .O(\FSM_sequential_state[1][0]_i_9__1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \FSM_sequential_state[1][1]_i_1__1 
       (.I0(\FSM_sequential_state[1][2]_i_2__1_n_0 ),
        .I1(out[2]),
        .I2(\FSM_sequential_state[1][1]_i_2__1_n_0 ),
        .I3(\code_valid_pipe_reg_n_0_[1] ),
        .I4(\FSM_sequential_state[1][1]_i_3__1_n_0 ),
        .O(\FSM_sequential_state[1][1]_i_1__1_n_0 ));
  LUT6 #(
    .INIT(64'h1F10CFCF1F10C0C0)) 
    \FSM_sequential_state[1][1]_i_2__1 
       (.I0(\code_valid_pipe_reg_n_0_[0] ),
        .I1(state[0]),
        .I2(out[0]),
        .I3(\FSM_sequential_state[1][1]_i_4__1_n_0 ),
        .I4(state[1]),
        .I5(\FSM_sequential_state[1][1]_i_5__1_n_0 ),
        .O(\FSM_sequential_state[1][1]_i_2__1_n_0 ));
  LUT5 #(
    .INIT(32'h67A8282A)) 
    \FSM_sequential_state[1][1]_i_3__1 
       (.I0(out[0]),
        .I1(state[1]),
        .I2(state[0]),
        .I3(out[1]),
        .I4(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][1]_i_3__1_n_0 ));
  LUT5 #(
    .INIT(32'h45570000)) 
    \FSM_sequential_state[1][1]_i_4__1 
       (.I0(state[0]),
        .I1(out[1]),
        .I2(\code_comma_pipe_reg_n_0_[0] ),
        .I3(\code_comma_pipe_reg_n_0_[1] ),
        .I4(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][1]_i_4__1_n_0 ));
  LUT6 #(
    .INIT(64'h8888B88888888800)) 
    \FSM_sequential_state[1][1]_i_5__1 
       (.I0(\code_valid_pipe_reg_n_0_[0] ),
        .I1(state[0]),
        .I2(\signal_detect_int_reg[2] ),
        .I3(\code_comma_pipe_reg_n_0_[0] ),
        .I4(out[1]),
        .I5(\code_comma_pipe_reg_n_0_[1] ),
        .O(\FSM_sequential_state[1][1]_i_5__1_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \FSM_sequential_state[1][2]_i_1__1 
       (.I0(\FSM_sequential_state[1][2]_i_2__1_n_0 ),
        .I1(out[2]),
        .I2(\FSM_sequential_state[1][2]_i_3__1_n_0 ),
        .I3(\code_valid_pipe_reg_n_0_[1] ),
        .I4(\FSM_sequential_state[1][2]_i_4__1_n_0 ),
        .O(\FSM_sequential_state[1][2]_i_1__1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000400000000)) 
    \FSM_sequential_state[1][2]_i_2__1 
       (.I0(out[0]),
        .I1(\code_valid_pipe_reg_n_0_[0] ),
        .I2(out[1]),
        .I3(state[0]),
        .I4(state[1]),
        .I5(\code_valid_pipe_reg_n_0_[1] ),
        .O(\FSM_sequential_state[1][2]_i_2__1_n_0 ));
  LUT6 #(
    .INIT(64'h7701FFFF77010000)) 
    \FSM_sequential_state[1][2]_i_3__1 
       (.I0(state[1]),
        .I1(state[0]),
        .I2(out[1]),
        .I3(\code_valid_pipe_reg_n_0_[0] ),
        .I4(out[0]),
        .I5(\FSM_sequential_state[1][2]_i_5__1_n_0 ),
        .O(\FSM_sequential_state[1][2]_i_3__1_n_0 ));
  LUT6 #(
    .INIT(64'h5AFFEAAA0AA00AAA)) 
    \FSM_sequential_state[1][2]_i_4__1 
       (.I0(out[0]),
        .I1(\code_comma_pipe_reg_n_0_[0] ),
        .I2(state[1]),
        .I3(state[0]),
        .I4(out[1]),
        .I5(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][2]_i_4__1_n_0 ));
  LUT6 #(
    .INIT(64'hF00FE08000000000)) 
    \FSM_sequential_state[1][2]_i_5__1 
       (.I0(\code_comma_pipe_reg_n_0_[0] ),
        .I1(\code_comma_pipe_reg_n_0_[1] ),
        .I2(state[1]),
        .I3(state[0]),
        .I4(out[1]),
        .I5(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][2]_i_5__1_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_sequential_state[1][3]_i_1__1 
       (.I0(\FSM_sequential_state[1][3]_i_2__1_n_0 ),
        .I1(out[2]),
        .O(\FSM_sequential_state[1][3]_i_1__1_n_0 ));
  LUT6 #(
    .INIT(64'h3A39C0002CCA8CC8)) 
    \FSM_sequential_state[1][3]_i_2__1 
       (.I0(\code_valid_pipe_reg_n_0_[1] ),
        .I1(out[0]),
        .I2(state[1]),
        .I3(state[0]),
        .I4(out[1]),
        .I5(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][3]_i_2__1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF6FF)) 
    \FSM_sequential_state[1][4]_i_1__1 
       (.I0(signal_detect_last),
        .I1(\signal_detect_int_reg[2] ),
        .I2(mgt_rx_reset),
        .I3(mgt_rxlock),
        .I4(usrclk_reset),
        .O(\FSM_sequential_state[1][4]_i_1__1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000080000000)) 
    \FSM_sequential_state[1][4]_i_2__1 
       (.I0(\code_valid_pipe_reg_n_0_[1] ),
        .I1(state[1]),
        .I2(\FSM_sequential_state[1][4]_i_3__1_n_0 ),
        .I3(\code_valid_pipe_reg_n_0_[0] ),
        .I4(out[0]),
        .I5(out[2]),
        .O(\FSM_sequential_state[1][4]_i_2__1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \FSM_sequential_state[1][4]_i_3__1 
       (.I0(out[1]),
        .I1(state[0]),
        .O(\FSM_sequential_state[1][4]_i_3__1_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[1][0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\FSM_sequential_state_reg[1][0]_i_1__1_n_0 ),
        .Q(state[0]),
        .R(\FSM_sequential_state[1][4]_i_1__1_n_0 ));
  MUXF7 \FSM_sequential_state_reg[1][0]_i_1__1 
       (.I0(\FSM_sequential_state[1][0]_i_2__1_n_0 ),
        .I1(\FSM_sequential_state[1][0]_i_3__1_n_0 ),
        .O(\FSM_sequential_state_reg[1][0]_i_1__1_n_0 ),
        .S(out[2]));
  MUXF7 \FSM_sequential_state_reg[1][0]_i_5__1 
       (.I0(\FSM_sequential_state[1][0]_i_10__1_n_0 ),
        .I1(\FSM_sequential_state[1][0]_i_11__1_n_0 ),
        .O(\FSM_sequential_state_reg[1][0]_i_5__1_n_0 ),
        .S(state[1]));
  MUXF7 \FSM_sequential_state_reg[1][0]_i_7__1 
       (.I0(\FSM_sequential_state[1][0]_i_12__1_n_0 ),
        .I1(\FSM_sequential_state[1][0]_i_13__1_n_0 ),
        .O(\FSM_sequential_state_reg[1][0]_i_7__1_n_0 ),
        .S(state[1]));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[1][1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\FSM_sequential_state[1][1]_i_1__1_n_0 ),
        .Q(state[1]),
        .R(\FSM_sequential_state[1][4]_i_1__1_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[1][2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\FSM_sequential_state[1][2]_i_1__1_n_0 ),
        .Q(out[0]),
        .R(\FSM_sequential_state[1][4]_i_1__1_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[1][3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\FSM_sequential_state[1][3]_i_1__1_n_0 ),
        .Q(out[1]),
        .R(\FSM_sequential_state[1][4]_i_1__1_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[1][4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\FSM_sequential_state[1][4]_i_2__1_n_0 ),
        .Q(out[2]),
        .R(\FSM_sequential_state[1][4]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \code_comma_pipe_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_codecomma[0]),
        .Q(\code_comma_pipe_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \code_comma_pipe_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_codecomma[1]),
        .Q(\code_comma_pipe_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \code_valid_pipe_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_codevalid[0]),
        .Q(\code_valid_pipe_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \code_valid_pipe_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_codevalid[1]),
        .Q(\code_valid_pipe_reg_n_0_[1] ),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h00000001)) 
    enable_align_i_1__1
       (.I0(out[0]),
        .I1(state[0]),
        .I2(out[1]),
        .I3(state[1]),
        .I4(out[2]),
        .O(enable_align_i));
  FDRE enable_align_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(enable_align_i),
        .Q(mgt_enable_align),
        .R(1'b0));
  FDRE signal_detect_last_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(\signal_detect_int_reg[2] ),
        .Q(signal_detect_last),
        .R(1'b0));
  LUT2 #(
    .INIT(4'hE)) 
    \sync_ok[2]_i_1 
       (.I0(out[1]),
        .I1(out[0]),
        .O(\sync_ok_reg[2] ));
endmodule

(* ORIG_REF_NAME = "sync_state_machine" *) 
module xaui_sync_state_machine_32
   (mgt_enable_align,
    out,
    \sync_ok_reg[3] ,
    \signal_detect_int_reg[3] ,
    usrclk,
    mgt_rx_reset,
    mgt_rxlock,
    usrclk_reset,
    mgt_codecomma,
    mgt_codevalid);
  output [0:0]mgt_enable_align;
  output [0:0]out;
  output \sync_ok_reg[3] ;
  input \signal_detect_int_reg[3] ;
  input usrclk;
  input [0:0]mgt_rx_reset;
  input [0:0]mgt_rxlock;
  input usrclk_reset;
  input [1:0]mgt_codecomma;
  input [1:0]mgt_codevalid;

  wire \FSM_sequential_state[1][0]_i_10__2_n_0 ;
  wire \FSM_sequential_state[1][0]_i_11__2_n_0 ;
  wire \FSM_sequential_state[1][0]_i_12__2_n_0 ;
  wire \FSM_sequential_state[1][0]_i_13__2_n_0 ;
  wire \FSM_sequential_state[1][0]_i_2__2_n_0 ;
  wire \FSM_sequential_state[1][0]_i_3__2_n_0 ;
  wire \FSM_sequential_state[1][0]_i_4__2_n_0 ;
  wire \FSM_sequential_state[1][0]_i_6__2_n_0 ;
  wire \FSM_sequential_state[1][0]_i_9__2_n_0 ;
  wire \FSM_sequential_state[1][1]_i_1__2_n_0 ;
  wire \FSM_sequential_state[1][1]_i_2__2_n_0 ;
  wire \FSM_sequential_state[1][1]_i_3__2_n_0 ;
  wire \FSM_sequential_state[1][1]_i_4__2_n_0 ;
  wire \FSM_sequential_state[1][1]_i_5__2_n_0 ;
  wire \FSM_sequential_state[1][2]_i_1__2_n_0 ;
  wire \FSM_sequential_state[1][2]_i_2__2_n_0 ;
  wire \FSM_sequential_state[1][2]_i_3__2_n_0 ;
  wire \FSM_sequential_state[1][2]_i_4__2_n_0 ;
  wire \FSM_sequential_state[1][2]_i_5__2_n_0 ;
  wire \FSM_sequential_state[1][3]_i_1__2_n_0 ;
  wire \FSM_sequential_state[1][3]_i_2__2_n_0 ;
  wire \FSM_sequential_state[1][4]_i_1__2_n_0 ;
  wire \FSM_sequential_state[1][4]_i_2__2_n_0 ;
  wire \FSM_sequential_state[1][4]_i_3__2_n_0 ;
  wire \FSM_sequential_state_reg[1][0]_i_1__2_n_0 ;
  wire \FSM_sequential_state_reg[1][0]_i_5__2_n_0 ;
  wire \FSM_sequential_state_reg[1][0]_i_7__2_n_0 ;
  wire \code_comma_pipe_reg_n_0_[0] ;
  wire \code_comma_pipe_reg_n_0_[1] ;
  wire \code_valid_pipe_reg_n_0_[0] ;
  wire \code_valid_pipe_reg_n_0_[1] ;
  wire enable_align_i;
  wire get_next_state;
  wire [1:0]mgt_codecomma;
  wire [1:0]mgt_codevalid;
  wire [0:0]mgt_enable_align;
  wire [0:0]mgt_rx_reset;
  wire [0:0]mgt_rxlock;
  (* RTL_KEEP = "yes" *) wire [0:0]out;
  wire \signal_detect_int_reg[3] ;
  wire signal_detect_last;
  (* RTL_KEEP = "yes" *) wire [3:0]state;
  wire \sync_ok_reg[3] ;
  wire usrclk;
  wire usrclk_reset;

  LUT6 #(
    .INIT(64'h4040E04AFFFF0CC0)) 
    \FSM_sequential_state[1][0]_i_10__2 
       (.I0(\code_valid_pipe_reg_n_0_[0] ),
        .I1(\signal_detect_int_reg[3] ),
        .I2(\code_comma_pipe_reg_n_0_[1] ),
        .I3(\code_comma_pipe_reg_n_0_[0] ),
        .I4(state[3]),
        .I5(state[0]),
        .O(\FSM_sequential_state[1][0]_i_10__2_n_0 ));
  LUT6 #(
    .INIT(64'h3F373C483C043C48)) 
    \FSM_sequential_state[1][0]_i_11__2 
       (.I0(\code_comma_pipe_reg_n_0_[0] ),
        .I1(\code_valid_pipe_reg_n_0_[0] ),
        .I2(state[0]),
        .I3(state[3]),
        .I4(\code_comma_pipe_reg_n_0_[1] ),
        .I5(\signal_detect_int_reg[3] ),
        .O(\FSM_sequential_state[1][0]_i_11__2_n_0 ));
  LUT6 #(
    .INIT(64'h6467202020202020)) 
    \FSM_sequential_state[1][0]_i_12__2 
       (.I0(\code_valid_pipe_reg_n_0_[0] ),
        .I1(state[0]),
        .I2(state[3]),
        .I3(\code_comma_pipe_reg_n_0_[0] ),
        .I4(\code_comma_pipe_reg_n_0_[1] ),
        .I5(\signal_detect_int_reg[3] ),
        .O(\FSM_sequential_state[1][0]_i_12__2_n_0 ));
  LUT6 #(
    .INIT(64'hCFB3CC80CC80CC80)) 
    \FSM_sequential_state[1][0]_i_13__2 
       (.I0(\code_comma_pipe_reg_n_0_[0] ),
        .I1(\code_valid_pipe_reg_n_0_[0] ),
        .I2(state[0]),
        .I3(state[3]),
        .I4(\code_comma_pipe_reg_n_0_[1] ),
        .I5(\signal_detect_int_reg[3] ),
        .O(\FSM_sequential_state[1][0]_i_13__2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \FSM_sequential_state[1][0]_i_2__2 
       (.I0(\FSM_sequential_state[1][0]_i_4__2_n_0 ),
        .I1(\FSM_sequential_state_reg[1][0]_i_5__2_n_0 ),
        .I2(\code_valid_pipe_reg_n_0_[1] ),
        .I3(\FSM_sequential_state[1][0]_i_6__2_n_0 ),
        .I4(state[2]),
        .I5(\FSM_sequential_state_reg[1][0]_i_7__2_n_0 ),
        .O(\FSM_sequential_state[1][0]_i_2__2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000022003000)) 
    \FSM_sequential_state[1][0]_i_3__2 
       (.I0(\code_valid_pipe_reg_n_0_[1] ),
        .I1(state[1]),
        .I2(get_next_state),
        .I3(\FSM_sequential_state[1][0]_i_9__2_n_0 ),
        .I4(\code_valid_pipe_reg_n_0_[0] ),
        .I5(state[2]),
        .O(\FSM_sequential_state[1][0]_i_3__2_n_0 ));
  LUT6 #(
    .INIT(64'h000F00008FFFFFFF)) 
    \FSM_sequential_state[1][0]_i_4__2 
       (.I0(\signal_detect_int_reg[3] ),
        .I1(\code_comma_pipe_reg_n_0_[1] ),
        .I2(state[1]),
        .I3(state[0]),
        .I4(state[3]),
        .I5(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][0]_i_4__2_n_0 ));
  LUT6 #(
    .INIT(64'h0FFFFFFF8F0FF0FF)) 
    \FSM_sequential_state[1][0]_i_6__2 
       (.I0(\signal_detect_int_reg[3] ),
        .I1(\code_comma_pipe_reg_n_0_[1] ),
        .I2(state[1]),
        .I3(state[3]),
        .I4(state[0]),
        .I5(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][0]_i_6__2_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \FSM_sequential_state[1][0]_i_8__2 
       (.I0(\signal_detect_int_reg[3] ),
        .I1(\code_comma_pipe_reg_n_0_[1] ),
        .O(get_next_state));
  LUT2 #(
    .INIT(4'h1)) 
    \FSM_sequential_state[1][0]_i_9__2 
       (.I0(state[3]),
        .I1(state[0]),
        .O(\FSM_sequential_state[1][0]_i_9__2_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \FSM_sequential_state[1][1]_i_1__2 
       (.I0(\FSM_sequential_state[1][2]_i_2__2_n_0 ),
        .I1(out),
        .I2(\FSM_sequential_state[1][1]_i_2__2_n_0 ),
        .I3(\code_valid_pipe_reg_n_0_[1] ),
        .I4(\FSM_sequential_state[1][1]_i_3__2_n_0 ),
        .O(\FSM_sequential_state[1][1]_i_1__2_n_0 ));
  LUT6 #(
    .INIT(64'h1F10CFCF1F10C0C0)) 
    \FSM_sequential_state[1][1]_i_2__2 
       (.I0(\code_valid_pipe_reg_n_0_[0] ),
        .I1(state[0]),
        .I2(state[2]),
        .I3(\FSM_sequential_state[1][1]_i_4__2_n_0 ),
        .I4(state[1]),
        .I5(\FSM_sequential_state[1][1]_i_5__2_n_0 ),
        .O(\FSM_sequential_state[1][1]_i_2__2_n_0 ));
  LUT5 #(
    .INIT(32'h67A8282A)) 
    \FSM_sequential_state[1][1]_i_3__2 
       (.I0(state[2]),
        .I1(state[1]),
        .I2(state[0]),
        .I3(state[3]),
        .I4(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][1]_i_3__2_n_0 ));
  LUT5 #(
    .INIT(32'h45570000)) 
    \FSM_sequential_state[1][1]_i_4__2 
       (.I0(state[0]),
        .I1(state[3]),
        .I2(\code_comma_pipe_reg_n_0_[0] ),
        .I3(\code_comma_pipe_reg_n_0_[1] ),
        .I4(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][1]_i_4__2_n_0 ));
  LUT6 #(
    .INIT(64'h8888B88888888800)) 
    \FSM_sequential_state[1][1]_i_5__2 
       (.I0(\code_valid_pipe_reg_n_0_[0] ),
        .I1(state[0]),
        .I2(\signal_detect_int_reg[3] ),
        .I3(\code_comma_pipe_reg_n_0_[0] ),
        .I4(state[3]),
        .I5(\code_comma_pipe_reg_n_0_[1] ),
        .O(\FSM_sequential_state[1][1]_i_5__2_n_0 ));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \FSM_sequential_state[1][2]_i_1__2 
       (.I0(\FSM_sequential_state[1][2]_i_2__2_n_0 ),
        .I1(out),
        .I2(\FSM_sequential_state[1][2]_i_3__2_n_0 ),
        .I3(\code_valid_pipe_reg_n_0_[1] ),
        .I4(\FSM_sequential_state[1][2]_i_4__2_n_0 ),
        .O(\FSM_sequential_state[1][2]_i_1__2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000400000000)) 
    \FSM_sequential_state[1][2]_i_2__2 
       (.I0(state[2]),
        .I1(\code_valid_pipe_reg_n_0_[0] ),
        .I2(state[3]),
        .I3(state[0]),
        .I4(state[1]),
        .I5(\code_valid_pipe_reg_n_0_[1] ),
        .O(\FSM_sequential_state[1][2]_i_2__2_n_0 ));
  LUT6 #(
    .INIT(64'h7701FFFF77010000)) 
    \FSM_sequential_state[1][2]_i_3__2 
       (.I0(state[1]),
        .I1(state[0]),
        .I2(state[3]),
        .I3(\code_valid_pipe_reg_n_0_[0] ),
        .I4(state[2]),
        .I5(\FSM_sequential_state[1][2]_i_5__2_n_0 ),
        .O(\FSM_sequential_state[1][2]_i_3__2_n_0 ));
  LUT6 #(
    .INIT(64'h5AFFEAAA0AA00AAA)) 
    \FSM_sequential_state[1][2]_i_4__2 
       (.I0(state[2]),
        .I1(\code_comma_pipe_reg_n_0_[0] ),
        .I2(state[1]),
        .I3(state[0]),
        .I4(state[3]),
        .I5(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][2]_i_4__2_n_0 ));
  LUT6 #(
    .INIT(64'hF00FE08000000000)) 
    \FSM_sequential_state[1][2]_i_5__2 
       (.I0(\code_comma_pipe_reg_n_0_[0] ),
        .I1(\code_comma_pipe_reg_n_0_[1] ),
        .I2(state[1]),
        .I3(state[0]),
        .I4(state[3]),
        .I5(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][2]_i_5__2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_sequential_state[1][3]_i_1__2 
       (.I0(\FSM_sequential_state[1][3]_i_2__2_n_0 ),
        .I1(out),
        .O(\FSM_sequential_state[1][3]_i_1__2_n_0 ));
  LUT6 #(
    .INIT(64'h3A39C0002CCA8CC8)) 
    \FSM_sequential_state[1][3]_i_2__2 
       (.I0(\code_valid_pipe_reg_n_0_[1] ),
        .I1(state[2]),
        .I2(state[1]),
        .I3(state[0]),
        .I4(state[3]),
        .I5(\code_valid_pipe_reg_n_0_[0] ),
        .O(\FSM_sequential_state[1][3]_i_2__2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFF6FF)) 
    \FSM_sequential_state[1][4]_i_1__2 
       (.I0(signal_detect_last),
        .I1(\signal_detect_int_reg[3] ),
        .I2(mgt_rx_reset),
        .I3(mgt_rxlock),
        .I4(usrclk_reset),
        .O(\FSM_sequential_state[1][4]_i_1__2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000080000000)) 
    \FSM_sequential_state[1][4]_i_2__2 
       (.I0(\code_valid_pipe_reg_n_0_[1] ),
        .I1(state[1]),
        .I2(\FSM_sequential_state[1][4]_i_3__2_n_0 ),
        .I3(\code_valid_pipe_reg_n_0_[0] ),
        .I4(state[2]),
        .I5(out),
        .O(\FSM_sequential_state[1][4]_i_2__2_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \FSM_sequential_state[1][4]_i_3__2 
       (.I0(state[3]),
        .I1(state[0]),
        .O(\FSM_sequential_state[1][4]_i_3__2_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[1][0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\FSM_sequential_state_reg[1][0]_i_1__2_n_0 ),
        .Q(state[0]),
        .R(\FSM_sequential_state[1][4]_i_1__2_n_0 ));
  MUXF7 \FSM_sequential_state_reg[1][0]_i_1__2 
       (.I0(\FSM_sequential_state[1][0]_i_2__2_n_0 ),
        .I1(\FSM_sequential_state[1][0]_i_3__2_n_0 ),
        .O(\FSM_sequential_state_reg[1][0]_i_1__2_n_0 ),
        .S(out));
  MUXF7 \FSM_sequential_state_reg[1][0]_i_5__2 
       (.I0(\FSM_sequential_state[1][0]_i_10__2_n_0 ),
        .I1(\FSM_sequential_state[1][0]_i_11__2_n_0 ),
        .O(\FSM_sequential_state_reg[1][0]_i_5__2_n_0 ),
        .S(state[1]));
  MUXF7 \FSM_sequential_state_reg[1][0]_i_7__2 
       (.I0(\FSM_sequential_state[1][0]_i_12__2_n_0 ),
        .I1(\FSM_sequential_state[1][0]_i_13__2_n_0 ),
        .O(\FSM_sequential_state_reg[1][0]_i_7__2_n_0 ),
        .S(state[1]));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[1][1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\FSM_sequential_state[1][1]_i_1__2_n_0 ),
        .Q(state[1]),
        .R(\FSM_sequential_state[1][4]_i_1__2_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[1][2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\FSM_sequential_state[1][2]_i_1__2_n_0 ),
        .Q(state[2]),
        .R(\FSM_sequential_state[1][4]_i_1__2_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[1][3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\FSM_sequential_state[1][3]_i_1__2_n_0 ),
        .Q(state[3]),
        .R(\FSM_sequential_state[1][4]_i_1__2_n_0 ));
  (* KEEP = "yes" *) 
  FDRE \FSM_sequential_state_reg[1][4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\FSM_sequential_state[1][4]_i_2__2_n_0 ),
        .Q(out),
        .R(\FSM_sequential_state[1][4]_i_1__2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \code_comma_pipe_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_codecomma[0]),
        .Q(\code_comma_pipe_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \code_comma_pipe_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_codecomma[1]),
        .Q(\code_comma_pipe_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \code_valid_pipe_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_codevalid[0]),
        .Q(\code_valid_pipe_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \code_valid_pipe_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(mgt_codevalid[1]),
        .Q(\code_valid_pipe_reg_n_0_[1] ),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h00000001)) 
    enable_align_i_1__2
       (.I0(state[2]),
        .I1(state[0]),
        .I2(state[3]),
        .I3(state[1]),
        .I4(out),
        .O(enable_align_i));
  FDRE enable_align_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(enable_align_i),
        .Q(mgt_enable_align),
        .R(1'b0));
  FDRE signal_detect_last_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(\signal_detect_int_reg[3] ),
        .Q(signal_detect_last),
        .R(1'b0));
  LUT2 #(
    .INIT(4'hE)) 
    \sync_ok[3]_i_1 
       (.I0(state[3]),
        .I1(state[2]),
        .O(\sync_ok_reg[3] ));
endmodule

(* ORIG_REF_NAME = "tqmsg_capture" *) 
module xaui_tqmsg_capture
   (\state_reg[0][2] ,
    q_det,
    last_qmsg,
    Q,
    \state_reg[1][1] ,
    \state_reg[0][0] ,
    \state_reg[0][1] ,
    \txd_out_reg[2] ,
    txc_out_reg,
    usrclk,
    \txd_out_reg[6] ,
    D,
    txd_filtered,
    txc_out_reg_0);
  output \state_reg[0][2] ;
  output q_det;
  output [31:0]last_qmsg;
  input [0:0]Q;
  input \state_reg[1][1] ;
  input [0:0]\state_reg[0][0] ;
  input \state_reg[0][1] ;
  input \txd_out_reg[2] ;
  input txc_out_reg;
  input usrclk;
  input \txd_out_reg[6] ;
  input [23:0]D;
  input [7:0]txd_filtered;
  input txc_out_reg_0;

  wire [23:0]D;
  wire [0:0]Q;
  wire [31:0]last_qmsg;
  wire \last_qmsg[6]_i_1_n_0 ;
  wire \last_qmsg[7]_i_1_n_0 ;
  wire q_det;
  wire q_det_i_1_n_0;
  wire [0:0]\state_reg[0][0] ;
  wire \state_reg[0][1] ;
  wire \state_reg[0][2] ;
  wire \state_reg[1][1] ;
  wire txc_out_reg;
  wire txc_out_reg_0;
  wire [7:0]txd_filtered;
  wire \txd_out_reg[2] ;
  wire \txd_out_reg[6] ;
  wire usrclk;

  LUT2 #(
    .INIT(4'h8)) 
    \last_qmsg[6]_i_1 
       (.I0(txc_out_reg_0),
        .I1(\txd_out_reg[6] ),
        .O(\last_qmsg[6]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \last_qmsg[7]_i_1 
       (.I0(txc_out_reg_0),
        .I1(\txd_out_reg[6] ),
        .O(\last_qmsg[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[0] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(txd_filtered[0]),
        .Q(last_qmsg[0]),
        .R(\last_qmsg[6]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[10] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[2]),
        .Q(last_qmsg[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[11] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[3]),
        .Q(last_qmsg[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[12] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[4]),
        .Q(last_qmsg[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[13] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[5]),
        .Q(last_qmsg[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[14] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[6]),
        .Q(last_qmsg[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[15] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[7]),
        .Q(last_qmsg[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[16] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[8]),
        .Q(last_qmsg[16]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[17] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[9]),
        .Q(last_qmsg[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[18] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[10]),
        .Q(last_qmsg[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[19] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[11]),
        .Q(last_qmsg[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[1] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(txd_filtered[1]),
        .Q(last_qmsg[1]),
        .R(\last_qmsg[6]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[20] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[12]),
        .Q(last_qmsg[20]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[21] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[13]),
        .Q(last_qmsg[21]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[22] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[14]),
        .Q(last_qmsg[22]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[23] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[15]),
        .Q(last_qmsg[23]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[24] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[16]),
        .Q(last_qmsg[24]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[25] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[17]),
        .Q(last_qmsg[25]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[26] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[18]),
        .Q(last_qmsg[26]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[27] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[19]),
        .Q(last_qmsg[27]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[28] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[20]),
        .Q(last_qmsg[28]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[29] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[21]),
        .Q(last_qmsg[29]),
        .R(1'b0));
  FDSE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[2] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(txd_filtered[2]),
        .Q(last_qmsg[2]),
        .S(\last_qmsg[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[30] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[22]),
        .Q(last_qmsg[30]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[31] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[23]),
        .Q(last_qmsg[31]),
        .R(1'b0));
  FDSE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[3] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(txd_filtered[3]),
        .Q(last_qmsg[3]),
        .S(\last_qmsg[7]_i_1_n_0 ));
  FDSE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[4] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(txd_filtered[4]),
        .Q(last_qmsg[4]),
        .S(\last_qmsg[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[5] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(txd_filtered[5]),
        .Q(last_qmsg[5]),
        .R(\last_qmsg[6]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[6] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(txd_filtered[6]),
        .Q(last_qmsg[6]),
        .R(\last_qmsg[6]_i_1_n_0 ));
  FDSE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[7] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(txd_filtered[7]),
        .Q(last_qmsg[7]),
        .S(\last_qmsg[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[8] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[0]),
        .Q(last_qmsg[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \last_qmsg_reg[9] 
       (.C(usrclk),
        .CE(\txd_out_reg[6] ),
        .D(D[1]),
        .Q(last_qmsg[9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF1500)) 
    q_det_i_1
       (.I0(\state_reg[1][1] ),
        .I1(\state_reg[0][0] ),
        .I2(\state_reg[0][1] ),
        .I3(q_det),
        .I4(\txd_out_reg[2] ),
        .I5(txc_out_reg),
        .O(q_det_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    q_det_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(q_det_i_1_n_0),
        .Q(q_det),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h1)) 
    \state[0][2]_i_2 
       (.I0(Q),
        .I1(q_det),
        .O(\state_reg[0][2] ));
endmodule

(* ORIG_REF_NAME = "tx" *) 
module xaui_tx
   (mgt_txdata,
    mgt_txcharisk,
    usrclk,
    usrclk_reset,
    configuration_vector,
    xgmii_txd,
    xgmii_txc);
  output [63:0]mgt_txdata;
  output [7:0]mgt_txcharisk;
  input usrclk;
  input usrclk_reset;
  input [2:0]configuration_vector;
  input [63:0]xgmii_txd;
  input [7:0]xgmii_txc;

  wire \G_FILTER_HIGH[4].filter_n_1 ;
  wire \G_FILTER_HIGH[4].filter_n_10 ;
  wire \G_FILTER_HIGH[4].filter_n_11 ;
  wire \G_FILTER_HIGH[4].filter_n_2 ;
  wire \G_FILTER_HIGH[5].filter_n_1 ;
  wire \G_FILTER_HIGH[5].filter_n_10 ;
  wire \G_FILTER_HIGH[5].filter_n_11 ;
  wire \G_FILTER_HIGH[5].filter_n_12 ;
  wire \G_FILTER_HIGH[5].filter_n_13 ;
  wire \G_FILTER_HIGH[5].filter_n_14 ;
  wire \G_FILTER_HIGH[5].filter_n_15 ;
  wire \G_FILTER_HIGH[5].filter_n_16 ;
  wire \G_FILTER_HIGH[5].filter_n_2 ;
  wire \G_FILTER_HIGH[5].filter_n_3 ;
  wire \G_FILTER_HIGH[5].filter_n_4 ;
  wire \G_FILTER_HIGH[5].filter_n_5 ;
  wire \G_FILTER_HIGH[5].filter_n_6 ;
  wire \G_FILTER_HIGH[5].filter_n_7 ;
  wire \G_FILTER_HIGH[5].filter_n_8 ;
  wire \G_FILTER_HIGH[5].filter_n_9 ;
  wire \G_FILTER_HIGH[6].filter_n_1 ;
  wire \G_FILTER_HIGH[6].filter_n_10 ;
  wire \G_FILTER_HIGH[6].filter_n_11 ;
  wire \G_FILTER_HIGH[6].filter_n_12 ;
  wire \G_FILTER_HIGH[6].filter_n_13 ;
  wire \G_FILTER_HIGH[6].filter_n_14 ;
  wire \G_FILTER_HIGH[6].filter_n_15 ;
  wire \G_FILTER_HIGH[6].filter_n_16 ;
  wire \G_FILTER_HIGH[6].filter_n_2 ;
  wire \G_FILTER_HIGH[6].filter_n_3 ;
  wire \G_FILTER_HIGH[6].filter_n_4 ;
  wire \G_FILTER_HIGH[6].filter_n_5 ;
  wire \G_FILTER_HIGH[6].filter_n_6 ;
  wire \G_FILTER_HIGH[6].filter_n_7 ;
  wire \G_FILTER_HIGH[6].filter_n_8 ;
  wire \G_FILTER_HIGH[6].filter_n_9 ;
  wire \G_FILTER_HIGH[7].filter_n_1 ;
  wire \G_FILTER_HIGH[7].filter_n_10 ;
  wire \G_FILTER_HIGH[7].filter_n_11 ;
  wire \G_FILTER_HIGH[7].filter_n_12 ;
  wire \G_FILTER_HIGH[7].filter_n_13 ;
  wire \G_FILTER_HIGH[7].filter_n_14 ;
  wire \G_FILTER_HIGH[7].filter_n_15 ;
  wire \G_FILTER_HIGH[7].filter_n_16 ;
  wire \G_FILTER_HIGH[7].filter_n_2 ;
  wire \G_FILTER_HIGH[7].filter_n_3 ;
  wire \G_FILTER_HIGH[7].filter_n_4 ;
  wire \G_FILTER_HIGH[7].filter_n_5 ;
  wire \G_FILTER_HIGH[7].filter_n_6 ;
  wire \G_FILTER_HIGH[7].filter_n_7 ;
  wire \G_FILTER_HIGH[7].filter_n_8 ;
  wire \G_FILTER_HIGH[7].filter_n_9 ;
  wire \G_FILTER_LOW[0].filter_n_1 ;
  wire \G_FILTER_LOW[0].filter_n_10 ;
  wire \G_FILTER_LOW[0].filter_n_11 ;
  wire \G_FILTER_LOW[0].filter_n_12 ;
  wire align_n_10;
  wire align_n_11;
  wire align_n_12;
  wire align_n_6;
  wire align_n_7;
  wire align_n_8;
  wire align_n_9;
  wire [3:0]c;
  wire c12_in;
  wire c15_in;
  wire c9_in;
  wire [1:0]code_sel;
  wire [2:0]configuration_vector;
  wire [4:0]count;
  wire [7:0]d;
  wire [31:8]data1;
  wire [1:0]is_idle;
  wire [7:0]is_invalid_k;
  wire [1:0]is_q;
  wire is_terminate;
  wire \is_terminate[0]_i_1_n_0 ;
  wire \is_terminate[0]_i_2_n_0 ;
  wire \is_terminate[0]_i_3_n_0 ;
  wire \is_terminate[0]_i_4_n_0 ;
  wire \is_terminate[0]_i_5_n_0 ;
  wire \is_terminate[0]_i_6_n_0 ;
  wire \is_terminate[0]_i_7_n_0 ;
  wire \is_terminate[1]_i_1_n_0 ;
  wire \is_terminate[1]_i_2_n_0 ;
  wire \is_terminate[1]_i_3_n_0 ;
  wire \is_terminate[1]_i_4_n_0 ;
  wire \is_terminate[1]_i_5_n_0 ;
  wire \is_terminate[1]_i_6_n_0 ;
  wire \is_terminate[1]_i_7_n_0 ;
  wire \is_terminate[1]_i_8_n_0 ;
  wire \is_terminate_reg_n_0_[0] ;
  wire is_txd_IDLE;
  wire [31:0]last_qmsg;
  wire [7:0]mgt_txcharisk;
  wire [63:0]mgt_txdata;
  wire [1:0]p_1_in;
  wire q_det;
  wire recoder_n_0;
  wire recoder_n_2;
  wire recoder_n_3;
  wire state_machine_n_0;
  wire state_machine_n_1;
  wire state_machine_n_10;
  wire state_machine_n_11;
  wire state_machine_n_12;
  wire state_machine_n_13;
  wire state_machine_n_14;
  wire state_machine_n_15;
  wire state_machine_n_16;
  wire state_machine_n_17;
  wire state_machine_n_18;
  wire state_machine_n_19;
  wire state_machine_n_2;
  wire state_machine_n_20;
  wire state_machine_n_21;
  wire state_machine_n_22;
  wire state_machine_n_23;
  wire state_machine_n_24;
  wire state_machine_n_25;
  wire state_machine_n_26;
  wire state_machine_n_27;
  wire state_machine_n_28;
  wire state_machine_n_29;
  wire state_machine_n_3;
  wire state_machine_n_30;
  wire state_machine_n_31;
  wire state_machine_n_32;
  wire state_machine_n_33;
  wire state_machine_n_34;
  wire state_machine_n_35;
  wire state_machine_n_36;
  wire state_machine_n_37;
  wire state_machine_n_38;
  wire state_machine_n_39;
  wire state_machine_n_4;
  wire state_machine_n_40;
  wire state_machine_n_41;
  wire state_machine_n_42;
  wire state_machine_n_43;
  wire state_machine_n_44;
  wire state_machine_n_45;
  wire state_machine_n_46;
  wire state_machine_n_47;
  wire state_machine_n_48;
  wire state_machine_n_49;
  wire state_machine_n_5;
  wire state_machine_n_50;
  wire state_machine_n_51;
  wire state_machine_n_52;
  wire state_machine_n_53;
  wire state_machine_n_54;
  wire state_machine_n_55;
  wire state_machine_n_56;
  wire state_machine_n_57;
  wire state_machine_n_58;
  wire state_machine_n_59;
  wire state_machine_n_6;
  wire state_machine_n_60;
  wire state_machine_n_61;
  wire state_machine_n_62;
  wire state_machine_n_63;
  wire state_machine_n_64;
  wire state_machine_n_65;
  wire state_machine_n_66;
  wire state_machine_n_67;
  wire state_machine_n_68;
  wire state_machine_n_69;
  wire state_machine_n_7;
  wire state_machine_n_70;
  wire state_machine_n_71;
  wire state_machine_n_72;
  wire state_machine_n_73;
  wire state_machine_n_74;
  wire state_machine_n_75;
  wire state_machine_n_76;
  wire state_machine_n_77;
  wire state_machine_n_78;
  wire state_machine_n_79;
  wire state_machine_n_8;
  wire state_machine_n_80;
  wire state_machine_n_81;
  wire state_machine_n_82;
  wire state_machine_n_83;
  wire state_machine_n_84;
  wire state_machine_n_85;
  wire state_machine_n_9;
  wire tqmsg_capture_1_n_0;
  wire \tx_is_idle[0]_i_2_n_0 ;
  wire \tx_is_idle[1]_i_2_n_0 ;
  wire [1:0]tx_is_idle_comb;
  wire \tx_is_invalid_k_reg[0]_i_1_n_0 ;
  wire \tx_is_invalid_k_reg[0]_i_2_n_0 ;
  wire \tx_is_invalid_k_reg[0]_i_3_n_0 ;
  wire \tx_is_invalid_k_reg[1]_i_1_n_0 ;
  wire \tx_is_invalid_k_reg[1]_i_2_n_0 ;
  wire \tx_is_invalid_k_reg[1]_i_3_n_0 ;
  wire \tx_is_invalid_k_reg[2]_i_1_n_0 ;
  wire \tx_is_invalid_k_reg[2]_i_2_n_0 ;
  wire \tx_is_invalid_k_reg[2]_i_3_n_0 ;
  wire \tx_is_invalid_k_reg[3]_i_1_n_0 ;
  wire \tx_is_invalid_k_reg[3]_i_2_n_0 ;
  wire \tx_is_invalid_k_reg[3]_i_3_n_0 ;
  wire \tx_is_invalid_k_reg[4]_i_1_n_0 ;
  wire \tx_is_invalid_k_reg[4]_i_2_n_0 ;
  wire \tx_is_invalid_k_reg[4]_i_3_n_0 ;
  wire \tx_is_invalid_k_reg[5]_i_1_n_0 ;
  wire \tx_is_invalid_k_reg[5]_i_2_n_0 ;
  wire \tx_is_invalid_k_reg[5]_i_3_n_0 ;
  wire \tx_is_invalid_k_reg[6]_i_1_n_0 ;
  wire \tx_is_invalid_k_reg[6]_i_2_n_0 ;
  wire \tx_is_invalid_k_reg[6]_i_3_n_0 ;
  wire \tx_is_invalid_k_reg[7]_i_1_n_0 ;
  wire \tx_is_invalid_k_reg[7]_i_2_n_0 ;
  wire \tx_is_invalid_k_reg[7]_i_3_n_0 ;
  wire \tx_is_q[0]_i_2_n_0 ;
  wire \tx_is_q[0]_i_3_n_0 ;
  wire \tx_is_q[1]_i_2_n_0 ;
  wire \tx_is_q[1]_i_3_n_0 ;
  wire [1:0]tx_is_q_comb;
  wire [7:0]txc_filtered;
  wire txc_in;
  wire \txc_pipe_2_reg_n_0_[0] ;
  wire \txc_pipe_2_reg_n_0_[2] ;
  wire \txc_pipe_2_reg_n_0_[3] ;
  wire \txc_pipe_2_reg_n_0_[4] ;
  wire \txc_pipe_2_reg_n_0_[5] ;
  wire \txc_pipe_2_reg_n_0_[6] ;
  wire \txc_pipe_2_reg_n_0_[7] ;
  wire \txc_pipe_reg_n_0_[0] ;
  wire [39:0]txd_filtered;
  wire [7:0]txd_in;
  wire txd_is_IDLE;
  wire \txd_is_IDLE_reg[0]_i_1_n_0 ;
  wire \txd_is_IDLE_reg[0]_i_2_n_0 ;
  wire \txd_is_IDLE_reg[1]_i_1_n_0 ;
  wire \txd_is_IDLE_reg[1]_i_2_n_0 ;
  wire \txd_is_IDLE_reg[2]_i_1_n_0 ;
  wire \txd_is_IDLE_reg[2]_i_2_n_0 ;
  wire \txd_is_IDLE_reg[3]_i_1_n_0 ;
  wire \txd_is_IDLE_reg[3]_i_2_n_0 ;
  wire \txd_is_IDLE_reg[4]_i_1_n_0 ;
  wire \txd_is_IDLE_reg[4]_i_2_n_0 ;
  wire \txd_is_IDLE_reg[5]_i_1_n_0 ;
  wire \txd_is_IDLE_reg[5]_i_2_n_0 ;
  wire \txd_is_IDLE_reg[6]_i_1_n_0 ;
  wire \txd_is_IDLE_reg[6]_i_2_n_0 ;
  wire \txd_is_IDLE_reg[7]_i_2_n_0 ;
  wire \txd_is_IDLE_reg_reg_n_0_[0] ;
  wire \txd_is_IDLE_reg_reg_n_0_[2] ;
  wire \txd_is_IDLE_reg_reg_n_0_[3] ;
  wire \txd_is_IDLE_reg_reg_n_0_[4] ;
  wire \txd_is_IDLE_reg_reg_n_0_[5] ;
  wire \txd_is_IDLE_reg_reg_n_0_[6] ;
  wire \txd_is_IDLE_reg_reg_n_0_[7] ;
  wire txd_out13_out;
  wire \txd_pipe_2_reg_n_0_[0] ;
  wire \txd_pipe_2_reg_n_0_[16] ;
  wire \txd_pipe_2_reg_n_0_[17] ;
  wire \txd_pipe_2_reg_n_0_[18] ;
  wire \txd_pipe_2_reg_n_0_[19] ;
  wire \txd_pipe_2_reg_n_0_[1] ;
  wire \txd_pipe_2_reg_n_0_[20] ;
  wire \txd_pipe_2_reg_n_0_[21] ;
  wire \txd_pipe_2_reg_n_0_[22] ;
  wire \txd_pipe_2_reg_n_0_[23] ;
  wire \txd_pipe_2_reg_n_0_[24] ;
  wire \txd_pipe_2_reg_n_0_[25] ;
  wire \txd_pipe_2_reg_n_0_[26] ;
  wire \txd_pipe_2_reg_n_0_[27] ;
  wire \txd_pipe_2_reg_n_0_[28] ;
  wire \txd_pipe_2_reg_n_0_[29] ;
  wire \txd_pipe_2_reg_n_0_[2] ;
  wire \txd_pipe_2_reg_n_0_[30] ;
  wire \txd_pipe_2_reg_n_0_[31] ;
  wire \txd_pipe_2_reg_n_0_[32] ;
  wire \txd_pipe_2_reg_n_0_[33] ;
  wire \txd_pipe_2_reg_n_0_[34] ;
  wire \txd_pipe_2_reg_n_0_[35] ;
  wire \txd_pipe_2_reg_n_0_[36] ;
  wire \txd_pipe_2_reg_n_0_[37] ;
  wire \txd_pipe_2_reg_n_0_[38] ;
  wire \txd_pipe_2_reg_n_0_[39] ;
  wire \txd_pipe_2_reg_n_0_[3] ;
  wire \txd_pipe_2_reg_n_0_[40] ;
  wire \txd_pipe_2_reg_n_0_[41] ;
  wire \txd_pipe_2_reg_n_0_[42] ;
  wire \txd_pipe_2_reg_n_0_[43] ;
  wire \txd_pipe_2_reg_n_0_[44] ;
  wire \txd_pipe_2_reg_n_0_[45] ;
  wire \txd_pipe_2_reg_n_0_[46] ;
  wire \txd_pipe_2_reg_n_0_[47] ;
  wire \txd_pipe_2_reg_n_0_[48] ;
  wire \txd_pipe_2_reg_n_0_[49] ;
  wire \txd_pipe_2_reg_n_0_[4] ;
  wire \txd_pipe_2_reg_n_0_[50] ;
  wire \txd_pipe_2_reg_n_0_[51] ;
  wire \txd_pipe_2_reg_n_0_[52] ;
  wire \txd_pipe_2_reg_n_0_[53] ;
  wire \txd_pipe_2_reg_n_0_[54] ;
  wire \txd_pipe_2_reg_n_0_[55] ;
  wire \txd_pipe_2_reg_n_0_[56] ;
  wire \txd_pipe_2_reg_n_0_[57] ;
  wire \txd_pipe_2_reg_n_0_[58] ;
  wire \txd_pipe_2_reg_n_0_[59] ;
  wire \txd_pipe_2_reg_n_0_[5] ;
  wire \txd_pipe_2_reg_n_0_[60] ;
  wire \txd_pipe_2_reg_n_0_[61] ;
  wire \txd_pipe_2_reg_n_0_[62] ;
  wire \txd_pipe_2_reg_n_0_[63] ;
  wire \txd_pipe_2_reg_n_0_[6] ;
  wire \txd_pipe_2_reg_n_0_[7] ;
  wire \txd_pipe_reg_n_0_[0] ;
  wire \txd_pipe_reg_n_0_[16] ;
  wire \txd_pipe_reg_n_0_[17] ;
  wire \txd_pipe_reg_n_0_[18] ;
  wire \txd_pipe_reg_n_0_[19] ;
  wire \txd_pipe_reg_n_0_[1] ;
  wire \txd_pipe_reg_n_0_[20] ;
  wire \txd_pipe_reg_n_0_[21] ;
  wire \txd_pipe_reg_n_0_[22] ;
  wire \txd_pipe_reg_n_0_[23] ;
  wire \txd_pipe_reg_n_0_[24] ;
  wire \txd_pipe_reg_n_0_[25] ;
  wire \txd_pipe_reg_n_0_[26] ;
  wire \txd_pipe_reg_n_0_[27] ;
  wire \txd_pipe_reg_n_0_[28] ;
  wire \txd_pipe_reg_n_0_[29] ;
  wire \txd_pipe_reg_n_0_[2] ;
  wire \txd_pipe_reg_n_0_[30] ;
  wire \txd_pipe_reg_n_0_[31] ;
  wire \txd_pipe_reg_n_0_[32] ;
  wire \txd_pipe_reg_n_0_[33] ;
  wire \txd_pipe_reg_n_0_[34] ;
  wire \txd_pipe_reg_n_0_[35] ;
  wire \txd_pipe_reg_n_0_[36] ;
  wire \txd_pipe_reg_n_0_[37] ;
  wire \txd_pipe_reg_n_0_[38] ;
  wire \txd_pipe_reg_n_0_[39] ;
  wire \txd_pipe_reg_n_0_[3] ;
  wire \txd_pipe_reg_n_0_[40] ;
  wire \txd_pipe_reg_n_0_[41] ;
  wire \txd_pipe_reg_n_0_[42] ;
  wire \txd_pipe_reg_n_0_[43] ;
  wire \txd_pipe_reg_n_0_[44] ;
  wire \txd_pipe_reg_n_0_[45] ;
  wire \txd_pipe_reg_n_0_[46] ;
  wire \txd_pipe_reg_n_0_[47] ;
  wire \txd_pipe_reg_n_0_[48] ;
  wire \txd_pipe_reg_n_0_[49] ;
  wire \txd_pipe_reg_n_0_[4] ;
  wire \txd_pipe_reg_n_0_[50] ;
  wire \txd_pipe_reg_n_0_[51] ;
  wire \txd_pipe_reg_n_0_[52] ;
  wire \txd_pipe_reg_n_0_[53] ;
  wire \txd_pipe_reg_n_0_[54] ;
  wire \txd_pipe_reg_n_0_[55] ;
  wire \txd_pipe_reg_n_0_[56] ;
  wire \txd_pipe_reg_n_0_[57] ;
  wire \txd_pipe_reg_n_0_[58] ;
  wire \txd_pipe_reg_n_0_[59] ;
  wire \txd_pipe_reg_n_0_[5] ;
  wire \txd_pipe_reg_n_0_[60] ;
  wire \txd_pipe_reg_n_0_[61] ;
  wire \txd_pipe_reg_n_0_[62] ;
  wire \txd_pipe_reg_n_0_[63] ;
  wire \txd_pipe_reg_n_0_[6] ;
  wire \txd_pipe_reg_n_0_[7] ;
  wire usrclk;
  wire usrclk_reset;
  wire [7:0]xgmii_txc;
  wire [63:0]xgmii_txd;

  xaui_tx_filter \G_FILTER_HIGH[4].filter 
       (.Q(\txc_pipe_2_reg_n_0_[4] ),
        .configuration_vector(configuration_vector),
        .is_invalid_k(is_invalid_k[4]),
        .is_terminate(is_terminate),
        .last_qmsg(last_qmsg[3]),
        .\last_qmsg_reg[0] (\G_FILTER_HIGH[4].filter_n_10 ),
        .\last_qmsg_reg[31] (\G_FILTER_HIGH[4].filter_n_1 ),
        .q_det_reg(\G_FILTER_HIGH[4].filter_n_2 ),
        .\state_reg[1][1] (state_machine_n_12),
        .txc_filtered(txc_filtered[4]),
        .txc_out_reg_0(\G_FILTER_LOW[0].filter_n_12 ),
        .txc_out_reg_1(txc_filtered[7:5]),
        .\txd_is_IDLE_reg_reg[4] (\txd_is_IDLE_reg_reg_n_0_[4] ),
        .\txd_out_reg[35] (\G_FILTER_HIGH[4].filter_n_11 ),
        .\txd_out_reg[39] ({txd_filtered[39:36],txd_filtered[34:32]}),
        .\txd_out_reg[4]_0 (\G_FILTER_LOW[0].filter_n_11 ),
        .\txd_out_reg[7]_0 (\G_FILTER_LOW[0].filter_n_10 ),
        .\txd_pipe_2_reg[39] ({\txd_pipe_2_reg_n_0_[39] ,\txd_pipe_2_reg_n_0_[38] ,\txd_pipe_2_reg_n_0_[37] ,\txd_pipe_2_reg_n_0_[36] ,\txd_pipe_2_reg_n_0_[35] ,\txd_pipe_2_reg_n_0_[34] ,\txd_pipe_2_reg_n_0_[33] ,\txd_pipe_2_reg_n_0_[32] }),
        .usrclk(usrclk));
  xaui_tx_filter_23 \G_FILTER_HIGH[5].filter 
       (.D({\G_FILTER_HIGH[5].filter_n_1 ,\G_FILTER_HIGH[5].filter_n_2 ,\G_FILTER_HIGH[5].filter_n_3 ,\G_FILTER_HIGH[5].filter_n_4 ,\G_FILTER_HIGH[5].filter_n_5 ,\G_FILTER_HIGH[5].filter_n_6 ,\G_FILTER_HIGH[5].filter_n_7 ,\G_FILTER_HIGH[5].filter_n_8 }),
        .Q(\txc_pipe_2_reg_n_0_[5] ),
        .configuration_vector(configuration_vector),
        .data1(data1[15:8]),
        .is_invalid_k(is_invalid_k[5]),
        .is_terminate(is_terminate),
        .\last_qmsg_reg[10] (\G_FILTER_HIGH[5].filter_n_12 ),
        .\last_qmsg_reg[11] (last_qmsg[11]),
        .\last_qmsg_reg[12] (\G_FILTER_HIGH[5].filter_n_13 ),
        .\last_qmsg_reg[13] (\G_FILTER_HIGH[5].filter_n_14 ),
        .\last_qmsg_reg[14] ({\G_FILTER_HIGH[5].filter_n_9 ,\G_FILTER_HIGH[5].filter_n_10 ,\G_FILTER_HIGH[5].filter_n_11 }),
        .\last_qmsg_reg[15] (\G_FILTER_HIGH[5].filter_n_15 ),
        .\state_reg[1][1] (state_machine_n_12),
        .\txc_out_reg[5] (txc_filtered[5]),
        .txc_out_reg_0(\G_FILTER_HIGH[4].filter_n_2 ),
        .\txd_is_IDLE_reg_reg[5] (\txd_is_IDLE_reg_reg_n_0_[5] ),
        .\txd_out_reg[43] (\G_FILTER_HIGH[5].filter_n_16 ),
        .\txd_pipe_2_reg[47] ({\txd_pipe_2_reg_n_0_[47] ,\txd_pipe_2_reg_n_0_[46] ,\txd_pipe_2_reg_n_0_[45] ,\txd_pipe_2_reg_n_0_[44] ,\txd_pipe_2_reg_n_0_[43] ,\txd_pipe_2_reg_n_0_[42] ,\txd_pipe_2_reg_n_0_[41] ,\txd_pipe_2_reg_n_0_[40] }),
        .usrclk(usrclk));
  xaui_tx_filter_24 \G_FILTER_HIGH[6].filter 
       (.D({\G_FILTER_HIGH[6].filter_n_1 ,\G_FILTER_HIGH[6].filter_n_2 ,\G_FILTER_HIGH[6].filter_n_3 ,\G_FILTER_HIGH[6].filter_n_4 ,\G_FILTER_HIGH[6].filter_n_5 ,\G_FILTER_HIGH[6].filter_n_6 ,\G_FILTER_HIGH[6].filter_n_7 ,\G_FILTER_HIGH[6].filter_n_8 }),
        .Q(\txc_pipe_2_reg_n_0_[6] ),
        .configuration_vector(configuration_vector),
        .data1(data1[23:16]),
        .is_invalid_k(is_invalid_k[6]),
        .is_terminate(is_terminate),
        .\last_qmsg_reg[18] (\G_FILTER_HIGH[6].filter_n_12 ),
        .\last_qmsg_reg[19] (last_qmsg[19]),
        .\last_qmsg_reg[20] (\G_FILTER_HIGH[6].filter_n_13 ),
        .\last_qmsg_reg[21] (\G_FILTER_HIGH[6].filter_n_14 ),
        .\last_qmsg_reg[22] ({\G_FILTER_HIGH[6].filter_n_9 ,\G_FILTER_HIGH[6].filter_n_10 ,\G_FILTER_HIGH[6].filter_n_11 }),
        .\last_qmsg_reg[23] (\G_FILTER_HIGH[6].filter_n_15 ),
        .\state_reg[1][1] (state_machine_n_12),
        .\txc_out_reg[6] (txc_filtered[6]),
        .txc_out_reg_0(\G_FILTER_HIGH[4].filter_n_2 ),
        .\txd_is_IDLE_reg_reg[6] (\txd_is_IDLE_reg_reg_n_0_[6] ),
        .\txd_out_reg[51] (\G_FILTER_HIGH[6].filter_n_16 ),
        .\txd_pipe_2_reg[55] ({\txd_pipe_2_reg_n_0_[55] ,\txd_pipe_2_reg_n_0_[54] ,\txd_pipe_2_reg_n_0_[53] ,\txd_pipe_2_reg_n_0_[52] ,\txd_pipe_2_reg_n_0_[51] ,\txd_pipe_2_reg_n_0_[50] ,\txd_pipe_2_reg_n_0_[49] ,\txd_pipe_2_reg_n_0_[48] }),
        .usrclk(usrclk));
  xaui_tx_filter_25 \G_FILTER_HIGH[7].filter 
       (.D({\G_FILTER_HIGH[7].filter_n_1 ,\G_FILTER_HIGH[7].filter_n_2 ,\G_FILTER_HIGH[7].filter_n_3 ,\G_FILTER_HIGH[7].filter_n_4 ,\G_FILTER_HIGH[7].filter_n_5 ,\G_FILTER_HIGH[7].filter_n_6 ,\G_FILTER_HIGH[7].filter_n_7 ,\G_FILTER_HIGH[7].filter_n_8 }),
        .Q(\txc_pipe_2_reg_n_0_[7] ),
        .configuration_vector(configuration_vector),
        .data1(data1[31:24]),
        .is_invalid_k(is_invalid_k[7]),
        .is_terminate(is_terminate),
        .\last_qmsg_reg[26] (\G_FILTER_HIGH[7].filter_n_12 ),
        .\last_qmsg_reg[27] (last_qmsg[27]),
        .\last_qmsg_reg[28] (\G_FILTER_HIGH[7].filter_n_13 ),
        .\last_qmsg_reg[29] (\G_FILTER_HIGH[7].filter_n_14 ),
        .\last_qmsg_reg[30] ({\G_FILTER_HIGH[7].filter_n_9 ,\G_FILTER_HIGH[7].filter_n_10 ,\G_FILTER_HIGH[7].filter_n_11 }),
        .\last_qmsg_reg[31] (\G_FILTER_HIGH[7].filter_n_15 ),
        .\state_reg[1][1] (state_machine_n_12),
        .\txc_out_reg[7] (txc_filtered[7]),
        .txc_out_reg_0(\G_FILTER_HIGH[4].filter_n_2 ),
        .\txd_is_IDLE_reg_reg[7] (\txd_is_IDLE_reg_reg_n_0_[7] ),
        .\txd_out_reg[59] (\G_FILTER_HIGH[7].filter_n_16 ),
        .\txd_pipe_2_reg[63] ({\txd_pipe_2_reg_n_0_[63] ,\txd_pipe_2_reg_n_0_[62] ,\txd_pipe_2_reg_n_0_[61] ,\txd_pipe_2_reg_n_0_[60] ,\txd_pipe_2_reg_n_0_[59] ,\txd_pipe_2_reg_n_0_[58] ,\txd_pipe_2_reg_n_0_[57] ,\txd_pipe_2_reg_n_0_[56] }),
        .usrclk(usrclk));
  xaui_tx_filter_26 \G_FILTER_LOW[0].filter 
       (.Q(\txc_pipe_2_reg_n_0_[0] ),
        .is_invalid_k(is_invalid_k[0]),
        .\is_terminate_reg[0] (\is_terminate_reg_n_0_[0] ),
        .\last_qmsg_reg[31] (\G_FILTER_LOW[0].filter_n_10 ),
        .\last_qmsg_reg[31]_0 (\G_FILTER_LOW[0].filter_n_11 ),
        .\last_qmsg_reg[31]_1 (\G_FILTER_LOW[0].filter_n_12 ),
        .q_det_reg(\G_FILTER_LOW[0].filter_n_1 ),
        .txc_filtered(txc_filtered[0]),
        .txc_out_reg_0(txc_filtered[3:1]),
        .txd_filtered(txd_filtered[7:0]),
        .\txd_is_IDLE_reg_reg[0] (\txd_is_IDLE_reg_reg_n_0_[0] ),
        .\txd_pipe_2_reg[7] ({\txd_pipe_2_reg_n_0_[7] ,\txd_pipe_2_reg_n_0_[6] ,\txd_pipe_2_reg_n_0_[5] ,\txd_pipe_2_reg_n_0_[4] ,\txd_pipe_2_reg_n_0_[3] ,\txd_pipe_2_reg_n_0_[2] ,\txd_pipe_2_reg_n_0_[1] ,\txd_pipe_2_reg_n_0_[0] }),
        .usrclk(usrclk));
  xaui_tx_filter_27 \G_FILTER_LOW[1].filter 
       (.Q(txc_in),
        .data1(data1[15:8]),
        .is_invalid_k(is_invalid_k[1]),
        .\is_terminate_reg[0] (\is_terminate_reg_n_0_[0] ),
        .\txc_out_reg[1] (txc_filtered[1]),
        .\txd_is_IDLE_reg_reg[1] (is_txd_IDLE),
        .\txd_pipe_2_reg[15] (txd_in),
        .usrclk(usrclk));
  xaui_tx_filter_28 \G_FILTER_LOW[2].filter 
       (.Q(\txc_pipe_2_reg_n_0_[2] ),
        .data1(data1[23:16]),
        .is_invalid_k(is_invalid_k[2]),
        .\is_terminate_reg[0] (\is_terminate_reg_n_0_[0] ),
        .\txc_out_reg[2] (txc_filtered[2]),
        .\txd_is_IDLE_reg_reg[2] (\txd_is_IDLE_reg_reg_n_0_[2] ),
        .\txd_pipe_2_reg[23] ({\txd_pipe_2_reg_n_0_[23] ,\txd_pipe_2_reg_n_0_[22] ,\txd_pipe_2_reg_n_0_[21] ,\txd_pipe_2_reg_n_0_[20] ,\txd_pipe_2_reg_n_0_[19] ,\txd_pipe_2_reg_n_0_[18] ,\txd_pipe_2_reg_n_0_[17] ,\txd_pipe_2_reg_n_0_[16] }),
        .usrclk(usrclk));
  xaui_tx_filter_29 \G_FILTER_LOW[3].filter 
       (.Q(\txc_pipe_2_reg_n_0_[3] ),
        .data1(data1[31:24]),
        .is_invalid_k(is_invalid_k[3]),
        .\is_terminate_reg[0] (\is_terminate_reg_n_0_[0] ),
        .\txc_out_reg[3] (txc_filtered[3]),
        .\txd_is_IDLE_reg_reg[3] (\txd_is_IDLE_reg_reg_n_0_[3] ),
        .\txd_pipe_2_reg[31] ({\txd_pipe_2_reg_n_0_[31] ,\txd_pipe_2_reg_n_0_[30] ,\txd_pipe_2_reg_n_0_[29] ,\txd_pipe_2_reg_n_0_[28] ,\txd_pipe_2_reg_n_0_[27] ,\txd_pipe_2_reg_n_0_[26] ,\txd_pipe_2_reg_n_0_[25] ,\txd_pipe_2_reg_n_0_[24] }),
        .usrclk(usrclk));
  xaui_align_counter align
       (.D({state_machine_n_45,state_machine_n_46}),
        .Q(p_1_in),
        .\count_reg[4]_0 ({count[4:3],count[1:0]}),
        .next_ifg_is_a_reg(state_machine_n_0),
        .q_det(q_det),
        .\state_reg[0][0] (align_n_12),
        .\state_reg[0][0]_0 (state_machine_n_15),
        .\state_reg[0][0]_1 (state_machine_n_13),
        .\state_reg[0][1] (state_machine_n_14),
        .\state_reg[1][0] (align_n_10),
        .\state_reg[1][0]_0 (state_machine_n_10),
        .\state_reg[1][0]_1 (state_machine_n_11),
        .\state_reg[1][1] (align_n_6),
        .\state_reg[1][1]_0 (align_n_7),
        .\state_reg[1][1]_1 (align_n_8),
        .\state_reg[1][1]_2 (align_n_9),
        .\state_reg[1][1]_3 (state_machine_n_12),
        .\state_reg[1][1]_4 (state_machine_n_1),
        .\state_reg[1][2] (align_n_11),
        .usrclk(usrclk),
        .usrclk_reset(usrclk_reset));
  LUT6 #(
    .INIT(64'hEAAAAAAAFFFFFFFF)) 
    \is_terminate[0]_i_1 
       (.I0(\is_terminate[0]_i_2_n_0 ),
        .I1(\is_terminate[0]_i_3_n_0 ),
        .I2(\txd_pipe_reg_n_0_[31] ),
        .I3(\txd_pipe_reg_n_0_[29] ),
        .I4(\txd_pipe_reg_n_0_[30] ),
        .I5(\is_terminate[0]_i_4_n_0 ),
        .O(\is_terminate[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair78" *) 
  LUT5 #(
    .INIT(32'h20000000)) 
    \is_terminate[0]_i_2 
       (.I0(\tx_is_q[0]_i_2_n_0 ),
        .I1(\txd_pipe_reg_n_0_[1] ),
        .I2(\txd_pipe_reg_n_0_[0] ),
        .I3(\txd_pipe_reg_n_0_[5] ),
        .I4(\txd_pipe_reg_n_0_[6] ),
        .O(\is_terminate[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000800000000000)) 
    \is_terminate[0]_i_3 
       (.I0(\txd_pipe_reg_n_0_[27] ),
        .I1(\txd_pipe_reg_n_0_[26] ),
        .I2(c9_in),
        .I3(\txd_pipe_reg_n_0_[28] ),
        .I4(\txd_pipe_reg_n_0_[25] ),
        .I5(\txd_pipe_reg_n_0_[24] ),
        .O(\is_terminate[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hBFFF0000BFFFBFFF)) 
    \is_terminate[0]_i_4 
       (.I0(\is_terminate[0]_i_5_n_0 ),
        .I1(d[7]),
        .I2(d[6]),
        .I3(d[5]),
        .I4(\is_terminate[0]_i_6_n_0 ),
        .I5(\is_terminate[0]_i_7_n_0 ),
        .O(\is_terminate[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF7FFFFFFFFFFF)) 
    \is_terminate[0]_i_5 
       (.I0(d[3]),
        .I1(d[2]),
        .I2(c15_in),
        .I3(d[4]),
        .I4(d[1]),
        .I5(d[0]),
        .O(\is_terminate[0]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair84" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    \is_terminate[0]_i_6 
       (.I0(\txd_pipe_reg_n_0_[22] ),
        .I1(\txd_pipe_reg_n_0_[21] ),
        .I2(\txd_pipe_reg_n_0_[23] ),
        .O(\is_terminate[0]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0000800000000000)) 
    \is_terminate[0]_i_7 
       (.I0(\txd_pipe_reg_n_0_[19] ),
        .I1(\txd_pipe_reg_n_0_[18] ),
        .I2(c12_in),
        .I3(\txd_pipe_reg_n_0_[20] ),
        .I4(\txd_pipe_reg_n_0_[17] ),
        .I5(\txd_pipe_reg_n_0_[16] ),
        .O(\is_terminate[0]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \is_terminate[1]_i_1 
       (.I0(\is_terminate[1]_i_2_n_0 ),
        .I1(\is_terminate[1]_i_3_n_0 ),
        .O(\is_terminate[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h8000FFFF80008000)) 
    \is_terminate[1]_i_2 
       (.I0(\txd_pipe_reg_n_0_[62] ),
        .I1(\txd_pipe_reg_n_0_[61] ),
        .I2(\txd_pipe_reg_n_0_[63] ),
        .I3(\is_terminate[1]_i_4_n_0 ),
        .I4(\is_terminate[1]_i_5_n_0 ),
        .I5(\tx_is_q[1]_i_2_n_0 ),
        .O(\is_terminate[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hBFFF0000BFFFBFFF)) 
    \is_terminate[1]_i_3 
       (.I0(\is_terminate[1]_i_6_n_0 ),
        .I1(\txd_pipe_reg_n_0_[55] ),
        .I2(\txd_pipe_reg_n_0_[54] ),
        .I3(\txd_pipe_reg_n_0_[53] ),
        .I4(\is_terminate[1]_i_7_n_0 ),
        .I5(\is_terminate[1]_i_8_n_0 ),
        .O(\is_terminate[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000800000000000)) 
    \is_terminate[1]_i_4 
       (.I0(\txd_pipe_reg_n_0_[59] ),
        .I1(\txd_pipe_reg_n_0_[58] ),
        .I2(c[3]),
        .I3(\txd_pipe_reg_n_0_[60] ),
        .I4(\txd_pipe_reg_n_0_[57] ),
        .I5(\txd_pipe_reg_n_0_[56] ),
        .O(\is_terminate[1]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair80" *) 
  LUT5 #(
    .INIT(32'hFF7FFFFF)) 
    \is_terminate[1]_i_5 
       (.I0(\txd_pipe_reg_n_0_[38] ),
        .I1(\txd_pipe_reg_n_0_[37] ),
        .I2(c[0]),
        .I3(\txd_pipe_reg_n_0_[33] ),
        .I4(\txd_pipe_reg_n_0_[32] ),
        .O(\is_terminate[1]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF7FFFFFFFFFFF)) 
    \is_terminate[1]_i_6 
       (.I0(\txd_pipe_reg_n_0_[51] ),
        .I1(\txd_pipe_reg_n_0_[50] ),
        .I2(c[2]),
        .I3(\txd_pipe_reg_n_0_[52] ),
        .I4(\txd_pipe_reg_n_0_[49] ),
        .I5(\txd_pipe_reg_n_0_[48] ),
        .O(\is_terminate[1]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair83" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    \is_terminate[1]_i_7 
       (.I0(\txd_pipe_reg_n_0_[46] ),
        .I1(\txd_pipe_reg_n_0_[45] ),
        .I2(\txd_pipe_reg_n_0_[47] ),
        .O(\is_terminate[1]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h0800000000000000)) 
    \is_terminate[1]_i_8 
       (.I0(\txd_pipe_reg_n_0_[43] ),
        .I1(\txd_pipe_reg_n_0_[42] ),
        .I2(\txd_pipe_reg_n_0_[41] ),
        .I3(c[1]),
        .I4(\txd_pipe_reg_n_0_[40] ),
        .I5(\txd_pipe_reg_n_0_[44] ),
        .O(\is_terminate[1]_i_8_n_0 ));
  FDRE \is_terminate_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\is_terminate[0]_i_1_n_0 ),
        .Q(\is_terminate_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \is_terminate_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\is_terminate[1]_i_1_n_0 ),
        .Q(is_terminate),
        .R(1'b0));
  xaui_k_r_prbs k_r_prbs_i
       (.Q({code_sel[0],code_sel[1]}),
        .usrclk(usrclk),
        .usrclk_reset(usrclk_reset));
  xaui_tx_recoder recoder
       (.D({state_machine_n_16,state_machine_n_17,state_machine_n_18,state_machine_n_19,state_machine_n_20,state_machine_n_21,state_machine_n_22,state_machine_n_23,state_machine_n_24,state_machine_n_25,state_machine_n_26,state_machine_n_27,state_machine_n_28,state_machine_n_29,state_machine_n_30,state_machine_n_31,state_machine_n_32,state_machine_n_33,state_machine_n_34,state_machine_n_35,state_machine_n_36,state_machine_n_37,state_machine_n_38,state_machine_n_39,state_machine_n_40,state_machine_n_41,state_machine_n_42,state_machine_n_43}),
        .configuration_vector(configuration_vector),
        .\last_qmsg_reg[13] (state_machine_n_68),
        .\last_qmsg_reg[13]_0 (state_machine_n_56),
        .\last_qmsg_reg[15] (state_machine_n_69),
        .\last_qmsg_reg[21] (state_machine_n_70),
        .\last_qmsg_reg[23] (state_machine_n_71),
        .\last_qmsg_reg[29] (state_machine_n_72),
        .\last_qmsg_reg[5] (state_machine_n_66),
        .\last_qmsg_reg[7] (state_machine_n_67),
        .mgt_txcharisk(mgt_txcharisk),
        .mgt_txdata(mgt_txdata),
        .\state_reg[0][0] (state_machine_n_49),
        .\state_reg[0][1] (state_machine_n_47),
        .\state_reg[0][1]_0 (state_machine_n_77),
        .\state_reg[0][2] (state_machine_n_65),
        .\state_reg[0][2]_0 (state_machine_n_61),
        .\state_reg[0][2]_1 (state_machine_n_57),
        .\state_reg[0][2]_2 (state_machine_n_53),
        .\state_reg[0][2]_3 (state_machine_n_64),
        .\state_reg[0][2]_4 (state_machine_n_60),
        .\state_reg[0][2]_5 (state_machine_n_52),
        .\state_reg[1][0] (state_machine_n_75),
        .\state_reg[1][0]_0 (state_machine_n_76),
        .\state_reg[1][1] (state_machine_n_48),
        .\state_reg[1][2] (state_machine_n_73),
        .\state_reg[1][2]_0 (state_machine_n_74),
        .txc_out_reg({state_machine_n_2,state_machine_n_3,state_machine_n_4,state_machine_n_5,state_machine_n_6,state_machine_n_7,state_machine_n_8,state_machine_n_9}),
        .txd_out13_out(txd_out13_out),
        .\txd_out_reg[24]_0 (recoder_n_0),
        .\txd_out_reg[24]_1 (recoder_n_3),
        .\txd_out_reg[2]_0 (state_machine_n_84),
        .\txd_out_reg[2]_1 (state_machine_n_82),
        .\txd_out_reg[2]_2 (state_machine_n_80),
        .\txd_out_reg[2]_3 (state_machine_n_78),
        .\txd_out_reg[2]_4 (state_machine_n_62),
        .\txd_out_reg[2]_5 (state_machine_n_58),
        .\txd_out_reg[2]_6 (state_machine_n_54),
        .\txd_out_reg[2]_7 (state_machine_n_50),
        .\txd_out_reg[38]_0 (recoder_n_2),
        .\txd_out_reg[3]_0 (\G_FILTER_HIGH[7].filter_n_16 ),
        .\txd_out_reg[3]_1 (\G_FILTER_HIGH[6].filter_n_16 ),
        .\txd_out_reg[3]_2 (\G_FILTER_HIGH[5].filter_n_16 ),
        .\txd_out_reg[3]_3 (\G_FILTER_HIGH[4].filter_n_11 ),
        .\txd_out_reg[4]_0 (state_machine_n_85),
        .\txd_out_reg[4]_1 (state_machine_n_83),
        .\txd_out_reg[4]_2 (state_machine_n_81),
        .\txd_out_reg[4]_3 (state_machine_n_79),
        .\txd_out_reg[4]_4 (state_machine_n_63),
        .\txd_out_reg[4]_5 (state_machine_n_59),
        .\txd_out_reg[4]_6 (state_machine_n_55),
        .\txd_out_reg[4]_7 (state_machine_n_51),
        .usrclk(usrclk));
  xaui_tx_state_machine state_machine
       (.D({state_machine_n_16,state_machine_n_17,state_machine_n_18,state_machine_n_19,state_machine_n_20,state_machine_n_21,state_machine_n_22,state_machine_n_23,state_machine_n_24,state_machine_n_25,state_machine_n_26,state_machine_n_27,state_machine_n_28,state_machine_n_29,state_machine_n_30,state_machine_n_31,state_machine_n_32,state_machine_n_33,state_machine_n_34,state_machine_n_35,state_machine_n_36,state_machine_n_37,state_machine_n_38,state_machine_n_39,state_machine_n_40,state_machine_n_41,state_machine_n_42,state_machine_n_43}),
        .Q(is_q),
        .configuration_vector(configuration_vector),
        .\configuration_vector[5] (recoder_n_2),
        .\configuration_vector[6] (recoder_n_0),
        .\configuration_vector[6]_0 (recoder_n_3),
        .\count_reg[1] (state_machine_n_13),
        .\count_reg[1]_0 (state_machine_n_14),
        .\count_reg[1]_1 ({state_machine_n_45,state_machine_n_46}),
        .\count_reg[2] (align_n_9),
        .\count_reg[2]_0 (align_n_7),
        .\count_reg[3] (align_n_8),
        .\count_reg[3]_0 (align_n_11),
        .\count_reg[3]_1 (align_n_12),
        .\count_reg[4] ({count[4:3],count[1:0]}),
        .data1(data1),
        .last_qmsg(last_qmsg),
        .next_ifg_is_a_reg_0(state_machine_n_0),
        .\prbs_reg[2] (p_1_in),
        .\prbs_reg[7] (state_machine_n_15),
        .\prbs_reg[8] ({code_sel[0],code_sel[1]}),
        .q_det(q_det),
        .q_det_reg(align_n_10),
        .q_det_reg_0(align_n_6),
        .\state_reg[0][0]_0 (state_machine_n_1),
        .\state_reg[0][2]_0 (state_machine_n_11),
        .\state_reg[1][0]_0 (state_machine_n_10),
        .\tx_is_idle_reg[1] (is_idle),
        .\tx_is_q_reg[0] (tqmsg_capture_1_n_0),
        .txc_filtered(txc_filtered),
        .\txc_out_reg[7] ({state_machine_n_2,state_machine_n_3,state_machine_n_4,state_machine_n_5,state_machine_n_6,state_machine_n_7,state_machine_n_8,state_machine_n_9}),
        .txd_filtered({txd_filtered[39:36],txd_filtered[34:32],txd_filtered[7:0]}),
        .txd_out13_out(txd_out13_out),
        .\txd_out_reg[10] (state_machine_n_54),
        .\txd_out_reg[12] (state_machine_n_55),
        .\txd_out_reg[13] (state_machine_n_56),
        .\txd_out_reg[15] (state_machine_n_57),
        .\txd_out_reg[18] (state_machine_n_58),
        .\txd_out_reg[20] (state_machine_n_59),
        .\txd_out_reg[21] (state_machine_n_60),
        .\txd_out_reg[23] (state_machine_n_61),
        .\txd_out_reg[26] (state_machine_n_62),
        .\txd_out_reg[28] (state_machine_n_63),
        .\txd_out_reg[28]_0 (state_machine_n_77),
        .\txd_out_reg[29] (state_machine_n_47),
        .\txd_out_reg[29]_0 (state_machine_n_64),
        .\txd_out_reg[2] (state_machine_n_50),
        .\txd_out_reg[2]_0 (\G_FILTER_HIGH[5].filter_n_12 ),
        .\txd_out_reg[2]_1 (\G_FILTER_HIGH[6].filter_n_12 ),
        .\txd_out_reg[2]_2 (\G_FILTER_HIGH[7].filter_n_12 ),
        .\txd_out_reg[31] (state_machine_n_49),
        .\txd_out_reg[31]_0 (state_machine_n_65),
        .\txd_out_reg[34] (state_machine_n_78),
        .\txd_out_reg[36] (state_machine_n_79),
        .\txd_out_reg[37] (state_machine_n_66),
        .\txd_out_reg[38] (state_machine_n_12),
        .\txd_out_reg[38]_0 (state_machine_n_44),
        .\txd_out_reg[39] (state_machine_n_67),
        .\txd_out_reg[42] (state_machine_n_80),
        .\txd_out_reg[44] (state_machine_n_81),
        .\txd_out_reg[45] (state_machine_n_68),
        .\txd_out_reg[47] (state_machine_n_69),
        .\txd_out_reg[4] (state_machine_n_51),
        .\txd_out_reg[4]_0 (\G_FILTER_HIGH[5].filter_n_13 ),
        .\txd_out_reg[4]_1 (\G_FILTER_HIGH[6].filter_n_13 ),
        .\txd_out_reg[4]_2 (\G_FILTER_HIGH[7].filter_n_13 ),
        .\txd_out_reg[50] (state_machine_n_82),
        .\txd_out_reg[52] (state_machine_n_83),
        .\txd_out_reg[53] (state_machine_n_70),
        .\txd_out_reg[55] (state_machine_n_71),
        .\txd_out_reg[58] (state_machine_n_84),
        .\txd_out_reg[59] (state_machine_n_76),
        .\txd_out_reg[5] (state_machine_n_52),
        .\txd_out_reg[5]_0 (\G_FILTER_HIGH[5].filter_n_14 ),
        .\txd_out_reg[5]_1 (\G_FILTER_HIGH[6].filter_n_14 ),
        .\txd_out_reg[5]_2 (\G_FILTER_HIGH[7].filter_n_14 ),
        .\txd_out_reg[60] (state_machine_n_75),
        .\txd_out_reg[60]_0 (state_machine_n_85),
        .\txd_out_reg[61] (state_machine_n_72),
        .\txd_out_reg[61]_0 (state_machine_n_74),
        .\txd_out_reg[63] (state_machine_n_48),
        .\txd_out_reg[63]_0 (state_machine_n_73),
        .\txd_out_reg[6] ({\G_FILTER_HIGH[5].filter_n_9 ,\G_FILTER_HIGH[5].filter_n_10 ,\G_FILTER_HIGH[5].filter_n_11 }),
        .\txd_out_reg[6]_0 ({\G_FILTER_HIGH[6].filter_n_9 ,\G_FILTER_HIGH[6].filter_n_10 ,\G_FILTER_HIGH[6].filter_n_11 }),
        .\txd_out_reg[6]_1 ({\G_FILTER_HIGH[7].filter_n_9 ,\G_FILTER_HIGH[7].filter_n_10 ,\G_FILTER_HIGH[7].filter_n_11 }),
        .\txd_out_reg[7] (state_machine_n_53),
        .\txd_out_reg[7]_0 (\G_FILTER_HIGH[5].filter_n_15 ),
        .\txd_out_reg[7]_1 (\G_FILTER_HIGH[6].filter_n_15 ),
        .\txd_out_reg[7]_2 (\G_FILTER_HIGH[7].filter_n_15 ),
        .usrclk(usrclk),
        .usrclk_reset(usrclk_reset));
  xaui_tqmsg_capture tqmsg_capture_1
       (.D({\G_FILTER_HIGH[7].filter_n_1 ,\G_FILTER_HIGH[7].filter_n_2 ,\G_FILTER_HIGH[7].filter_n_3 ,\G_FILTER_HIGH[7].filter_n_4 ,\G_FILTER_HIGH[7].filter_n_5 ,\G_FILTER_HIGH[7].filter_n_6 ,\G_FILTER_HIGH[7].filter_n_7 ,\G_FILTER_HIGH[7].filter_n_8 ,\G_FILTER_HIGH[6].filter_n_1 ,\G_FILTER_HIGH[6].filter_n_2 ,\G_FILTER_HIGH[6].filter_n_3 ,\G_FILTER_HIGH[6].filter_n_4 ,\G_FILTER_HIGH[6].filter_n_5 ,\G_FILTER_HIGH[6].filter_n_6 ,\G_FILTER_HIGH[6].filter_n_7 ,\G_FILTER_HIGH[6].filter_n_8 ,\G_FILTER_HIGH[5].filter_n_1 ,\G_FILTER_HIGH[5].filter_n_2 ,\G_FILTER_HIGH[5].filter_n_3 ,\G_FILTER_HIGH[5].filter_n_4 ,\G_FILTER_HIGH[5].filter_n_5 ,\G_FILTER_HIGH[5].filter_n_6 ,\G_FILTER_HIGH[5].filter_n_7 ,\G_FILTER_HIGH[5].filter_n_8 }),
        .Q(is_q[0]),
        .last_qmsg(last_qmsg),
        .q_det(q_det),
        .\state_reg[0][0] (state_machine_n_13),
        .\state_reg[0][1] (state_machine_n_14),
        .\state_reg[0][2] (tqmsg_capture_1_n_0),
        .\state_reg[1][1] (state_machine_n_44),
        .txc_out_reg(\G_FILTER_HIGH[4].filter_n_2 ),
        .txc_out_reg_0(\G_FILTER_HIGH[4].filter_n_10 ),
        .txd_filtered(txd_filtered[7:0]),
        .\txd_out_reg[2] (\G_FILTER_LOW[0].filter_n_1 ),
        .\txd_out_reg[6] (\G_FILTER_HIGH[4].filter_n_1 ),
        .usrclk(usrclk));
  LUT5 #(
    .INIT(32'h40000000)) 
    \tx_is_idle[0]_i_1 
       (.I0(\tx_is_idle[0]_i_2_n_0 ),
        .I1(\txd_is_IDLE_reg[0]_i_1_n_0 ),
        .I2(\txd_is_IDLE_reg[3]_i_1_n_0 ),
        .I3(\txd_is_IDLE_reg[2]_i_1_n_0 ),
        .I4(\txd_is_IDLE_reg[1]_i_1_n_0 ),
        .O(tx_is_idle_comb[0]));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \tx_is_idle[0]_i_2 
       (.I0(c15_in),
        .I1(\txc_pipe_reg_n_0_[0] ),
        .I2(c9_in),
        .I3(c12_in),
        .O(\tx_is_idle[0]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h40000000)) 
    \tx_is_idle[1]_i_1 
       (.I0(\tx_is_idle[1]_i_2_n_0 ),
        .I1(\txd_is_IDLE_reg[4]_i_1_n_0 ),
        .I2(txd_is_IDLE),
        .I3(\txd_is_IDLE_reg[6]_i_1_n_0 ),
        .I4(\txd_is_IDLE_reg[5]_i_1_n_0 ),
        .O(tx_is_idle_comb[1]));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \tx_is_idle[1]_i_2 
       (.I0(c[1]),
        .I1(c[0]),
        .I2(c[3]),
        .I3(c[2]),
        .O(\tx_is_idle[1]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b1)) 
    \tx_is_idle_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(tx_is_idle_comb[0]),
        .Q(is_idle[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \tx_is_idle_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(tx_is_idle_comb[1]),
        .Q(is_idle[1]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hAAAAAAAA2AAAA22A)) 
    \tx_is_invalid_k_reg[0]_i_1 
       (.I0(\txc_pipe_reg_n_0_[0] ),
        .I1(\txd_pipe_reg_n_0_[4] ),
        .I2(\txd_pipe_reg_n_0_[3] ),
        .I3(\txd_pipe_reg_n_0_[2] ),
        .I4(\tx_is_invalid_k_reg[0]_i_2_n_0 ),
        .I5(\tx_is_invalid_k_reg[0]_i_3_n_0 ),
        .O(\tx_is_invalid_k_reg[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair78" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \tx_is_invalid_k_reg[0]_i_2 
       (.I0(\txd_pipe_reg_n_0_[0] ),
        .I1(\txd_pipe_reg_n_0_[1] ),
        .O(\tx_is_invalid_k_reg[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair81" *) 
  LUT5 #(
    .INIT(32'h0EEEEEEE)) 
    \tx_is_invalid_k_reg[0]_i_3 
       (.I0(\txd_pipe_reg_n_0_[1] ),
        .I1(\txd_pipe_reg_n_0_[0] ),
        .I2(\txd_pipe_reg_n_0_[5] ),
        .I3(\txd_pipe_reg_n_0_[6] ),
        .I4(\txd_pipe_reg_n_0_[7] ),
        .O(\tx_is_invalid_k_reg[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAA2AAAA22A)) 
    \tx_is_invalid_k_reg[1]_i_1 
       (.I0(c15_in),
        .I1(d[4]),
        .I2(d[3]),
        .I3(d[2]),
        .I4(\tx_is_invalid_k_reg[1]_i_2_n_0 ),
        .I5(\tx_is_invalid_k_reg[1]_i_3_n_0 ),
        .O(\tx_is_invalid_k_reg[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair87" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \tx_is_invalid_k_reg[1]_i_2 
       (.I0(d[0]),
        .I1(d[1]),
        .O(\tx_is_invalid_k_reg[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair87" *) 
  LUT5 #(
    .INIT(32'h7F7F7F00)) 
    \tx_is_invalid_k_reg[1]_i_3 
       (.I0(d[5]),
        .I1(d[6]),
        .I2(d[7]),
        .I3(d[1]),
        .I4(d[0]),
        .O(\tx_is_invalid_k_reg[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAA2AAAA22A)) 
    \tx_is_invalid_k_reg[2]_i_1 
       (.I0(c12_in),
        .I1(\txd_pipe_reg_n_0_[20] ),
        .I2(\txd_pipe_reg_n_0_[19] ),
        .I3(\txd_pipe_reg_n_0_[18] ),
        .I4(\tx_is_invalid_k_reg[2]_i_2_n_0 ),
        .I5(\tx_is_invalid_k_reg[2]_i_3_n_0 ),
        .O(\tx_is_invalid_k_reg[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair89" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \tx_is_invalid_k_reg[2]_i_2 
       (.I0(\txd_pipe_reg_n_0_[16] ),
        .I1(\txd_pipe_reg_n_0_[17] ),
        .O(\tx_is_invalid_k_reg[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair84" *) 
  LUT5 #(
    .INIT(32'h7F7F7F00)) 
    \tx_is_invalid_k_reg[2]_i_3 
       (.I0(\txd_pipe_reg_n_0_[23] ),
        .I1(\txd_pipe_reg_n_0_[21] ),
        .I2(\txd_pipe_reg_n_0_[22] ),
        .I3(\txd_pipe_reg_n_0_[17] ),
        .I4(\txd_pipe_reg_n_0_[16] ),
        .O(\tx_is_invalid_k_reg[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAA2AAAA22A)) 
    \tx_is_invalid_k_reg[3]_i_1 
       (.I0(c9_in),
        .I1(\txd_pipe_reg_n_0_[28] ),
        .I2(\txd_pipe_reg_n_0_[27] ),
        .I3(\txd_pipe_reg_n_0_[26] ),
        .I4(\tx_is_invalid_k_reg[3]_i_2_n_0 ),
        .I5(\tx_is_invalid_k_reg[3]_i_3_n_0 ),
        .O(\tx_is_invalid_k_reg[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair86" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \tx_is_invalid_k_reg[3]_i_2 
       (.I0(\txd_pipe_reg_n_0_[24] ),
        .I1(\txd_pipe_reg_n_0_[25] ),
        .O(\tx_is_invalid_k_reg[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair86" *) 
  LUT5 #(
    .INIT(32'h7F7F7F00)) 
    \tx_is_invalid_k_reg[3]_i_3 
       (.I0(\txd_pipe_reg_n_0_[31] ),
        .I1(\txd_pipe_reg_n_0_[29] ),
        .I2(\txd_pipe_reg_n_0_[30] ),
        .I3(\txd_pipe_reg_n_0_[25] ),
        .I4(\txd_pipe_reg_n_0_[24] ),
        .O(\tx_is_invalid_k_reg[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAA2AAAA22A)) 
    \tx_is_invalid_k_reg[4]_i_1 
       (.I0(c[0]),
        .I1(\txd_pipe_reg_n_0_[36] ),
        .I2(\txd_pipe_reg_n_0_[35] ),
        .I3(\txd_pipe_reg_n_0_[34] ),
        .I4(\tx_is_invalid_k_reg[4]_i_2_n_0 ),
        .I5(\tx_is_invalid_k_reg[4]_i_3_n_0 ),
        .O(\tx_is_invalid_k_reg[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair82" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \tx_is_invalid_k_reg[4]_i_2 
       (.I0(\txd_pipe_reg_n_0_[32] ),
        .I1(\txd_pipe_reg_n_0_[33] ),
        .O(\tx_is_invalid_k_reg[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair82" *) 
  LUT5 #(
    .INIT(32'h0EEEEEEE)) 
    \tx_is_invalid_k_reg[4]_i_3 
       (.I0(\txd_pipe_reg_n_0_[33] ),
        .I1(\txd_pipe_reg_n_0_[32] ),
        .I2(\txd_pipe_reg_n_0_[37] ),
        .I3(\txd_pipe_reg_n_0_[38] ),
        .I4(\txd_pipe_reg_n_0_[39] ),
        .O(\tx_is_invalid_k_reg[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAA2AAAA22A)) 
    \tx_is_invalid_k_reg[5]_i_1 
       (.I0(c[1]),
        .I1(\txd_pipe_reg_n_0_[44] ),
        .I2(\txd_pipe_reg_n_0_[43] ),
        .I3(\txd_pipe_reg_n_0_[42] ),
        .I4(\tx_is_invalid_k_reg[5]_i_2_n_0 ),
        .I5(\tx_is_invalid_k_reg[5]_i_3_n_0 ),
        .O(\tx_is_invalid_k_reg[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair88" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \tx_is_invalid_k_reg[5]_i_2 
       (.I0(\txd_pipe_reg_n_0_[40] ),
        .I1(\txd_pipe_reg_n_0_[41] ),
        .O(\tx_is_invalid_k_reg[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair83" *) 
  LUT5 #(
    .INIT(32'h7F7F7F00)) 
    \tx_is_invalid_k_reg[5]_i_3 
       (.I0(\txd_pipe_reg_n_0_[47] ),
        .I1(\txd_pipe_reg_n_0_[45] ),
        .I2(\txd_pipe_reg_n_0_[46] ),
        .I3(\txd_pipe_reg_n_0_[41] ),
        .I4(\txd_pipe_reg_n_0_[40] ),
        .O(\tx_is_invalid_k_reg[5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAA2AAAA22A)) 
    \tx_is_invalid_k_reg[6]_i_1 
       (.I0(c[2]),
        .I1(\txd_pipe_reg_n_0_[52] ),
        .I2(\txd_pipe_reg_n_0_[51] ),
        .I3(\txd_pipe_reg_n_0_[50] ),
        .I4(\tx_is_invalid_k_reg[6]_i_2_n_0 ),
        .I5(\tx_is_invalid_k_reg[6]_i_3_n_0 ),
        .O(\tx_is_invalid_k_reg[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair79" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \tx_is_invalid_k_reg[6]_i_2 
       (.I0(\txd_pipe_reg_n_0_[48] ),
        .I1(\txd_pipe_reg_n_0_[49] ),
        .O(\tx_is_invalid_k_reg[6]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair79" *) 
  LUT5 #(
    .INIT(32'h7F7F7F00)) 
    \tx_is_invalid_k_reg[6]_i_3 
       (.I0(\txd_pipe_reg_n_0_[53] ),
        .I1(\txd_pipe_reg_n_0_[54] ),
        .I2(\txd_pipe_reg_n_0_[55] ),
        .I3(\txd_pipe_reg_n_0_[49] ),
        .I4(\txd_pipe_reg_n_0_[48] ),
        .O(\tx_is_invalid_k_reg[6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAA2AAAA22A)) 
    \tx_is_invalid_k_reg[7]_i_1 
       (.I0(c[3]),
        .I1(\txd_pipe_reg_n_0_[60] ),
        .I2(\txd_pipe_reg_n_0_[59] ),
        .I3(\txd_pipe_reg_n_0_[58] ),
        .I4(\tx_is_invalid_k_reg[7]_i_2_n_0 ),
        .I5(\tx_is_invalid_k_reg[7]_i_3_n_0 ),
        .O(\tx_is_invalid_k_reg[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair85" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \tx_is_invalid_k_reg[7]_i_2 
       (.I0(\txd_pipe_reg_n_0_[56] ),
        .I1(\txd_pipe_reg_n_0_[57] ),
        .O(\tx_is_invalid_k_reg[7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair85" *) 
  LUT5 #(
    .INIT(32'h7F7F7F00)) 
    \tx_is_invalid_k_reg[7]_i_3 
       (.I0(\txd_pipe_reg_n_0_[63] ),
        .I1(\txd_pipe_reg_n_0_[61] ),
        .I2(\txd_pipe_reg_n_0_[62] ),
        .I3(\txd_pipe_reg_n_0_[57] ),
        .I4(\txd_pipe_reg_n_0_[56] ),
        .O(\tx_is_invalid_k_reg[7]_i_3_n_0 ));
  FDRE \tx_is_invalid_k_reg_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\tx_is_invalid_k_reg[0]_i_1_n_0 ),
        .Q(is_invalid_k[0]),
        .R(1'b0));
  FDRE \tx_is_invalid_k_reg_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\tx_is_invalid_k_reg[1]_i_1_n_0 ),
        .Q(is_invalid_k[1]),
        .R(1'b0));
  FDRE \tx_is_invalid_k_reg_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\tx_is_invalid_k_reg[2]_i_1_n_0 ),
        .Q(is_invalid_k[2]),
        .R(1'b0));
  FDRE \tx_is_invalid_k_reg_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\tx_is_invalid_k_reg[3]_i_1_n_0 ),
        .Q(is_invalid_k[3]),
        .R(1'b0));
  FDRE \tx_is_invalid_k_reg_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\tx_is_invalid_k_reg[4]_i_1_n_0 ),
        .Q(is_invalid_k[4]),
        .R(1'b0));
  FDRE \tx_is_invalid_k_reg_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\tx_is_invalid_k_reg[5]_i_1_n_0 ),
        .Q(is_invalid_k[5]),
        .R(1'b0));
  FDRE \tx_is_invalid_k_reg_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\tx_is_invalid_k_reg[6]_i_1_n_0 ),
        .Q(is_invalid_k[6]),
        .R(1'b0));
  FDRE \tx_is_invalid_k_reg_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\tx_is_invalid_k_reg[7]_i_1_n_0 ),
        .Q(is_invalid_k[7]),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h00000002)) 
    \tx_is_q[0]_i_1 
       (.I0(\tx_is_q[0]_i_2_n_0 ),
        .I1(\tx_is_q[0]_i_3_n_0 ),
        .I2(\txd_pipe_reg_n_0_[1] ),
        .I3(c9_in),
        .I4(c12_in),
        .O(tx_is_q_comb[0]));
  LUT5 #(
    .INIT(32'h80000000)) 
    \tx_is_q[0]_i_2 
       (.I0(\txd_pipe_reg_n_0_[3] ),
        .I1(\txd_pipe_reg_n_0_[2] ),
        .I2(\txc_pipe_reg_n_0_[0] ),
        .I3(\txd_pipe_reg_n_0_[4] ),
        .I4(\txd_pipe_reg_n_0_[7] ),
        .O(\tx_is_q[0]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \tx_is_q[0]_i_3 
       (.I0(\txd_pipe_reg_n_0_[6] ),
        .I1(\txd_pipe_reg_n_0_[5] ),
        .I2(c15_in),
        .I3(\txd_pipe_reg_n_0_[0] ),
        .O(\tx_is_q[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000020000)) 
    \tx_is_q[1]_i_1 
       (.I0(\tx_is_q[1]_i_2_n_0 ),
        .I1(\tx_is_q[1]_i_3_n_0 ),
        .I2(c[3]),
        .I3(c[2]),
        .I4(c[0]),
        .I5(c[1]),
        .O(tx_is_q_comb[1]));
  LUT4 #(
    .INIT(16'h8000)) 
    \tx_is_q[1]_i_2 
       (.I0(\txd_pipe_reg_n_0_[35] ),
        .I1(\txd_pipe_reg_n_0_[34] ),
        .I2(\txd_pipe_reg_n_0_[39] ),
        .I3(\txd_pipe_reg_n_0_[36] ),
        .O(\tx_is_q[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair80" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \tx_is_q[1]_i_3 
       (.I0(\txd_pipe_reg_n_0_[38] ),
        .I1(\txd_pipe_reg_n_0_[37] ),
        .I2(\txd_pipe_reg_n_0_[33] ),
        .I3(\txd_pipe_reg_n_0_[32] ),
        .O(\tx_is_q[1]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \tx_is_q_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(tx_is_q_comb[0]),
        .Q(is_q[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \tx_is_q_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(tx_is_q_comb[1]),
        .Q(is_q[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txc_pipe_2_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txc_pipe_reg_n_0_[0] ),
        .Q(\txc_pipe_2_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txc_pipe_2_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(c15_in),
        .Q(txc_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txc_pipe_2_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(c12_in),
        .Q(\txc_pipe_2_reg_n_0_[2] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txc_pipe_2_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(c9_in),
        .Q(\txc_pipe_2_reg_n_0_[3] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txc_pipe_2_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(c[0]),
        .Q(\txc_pipe_2_reg_n_0_[4] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txc_pipe_2_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(c[1]),
        .Q(\txc_pipe_2_reg_n_0_[5] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txc_pipe_2_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(c[2]),
        .Q(\txc_pipe_2_reg_n_0_[6] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txc_pipe_2_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(c[3]),
        .Q(\txc_pipe_2_reg_n_0_[7] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txc_pipe_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txc[0]),
        .Q(\txc_pipe_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txc_pipe_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txc[1]),
        .Q(c15_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txc_pipe_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txc[2]),
        .Q(c12_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txc_pipe_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txc[3]),
        .Q(c9_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txc_pipe_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txc[4]),
        .Q(c[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txc_pipe_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txc[5]),
        .Q(c[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txc_pipe_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txc[6]),
        .Q(c[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txc_pipe_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txc[7]),
        .Q(c[3]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0000000000000010)) 
    \txd_is_IDLE_reg[0]_i_1 
       (.I0(\txd_pipe_reg_n_0_[3] ),
        .I1(\txd_pipe_reg_n_0_[4] ),
        .I2(\txd_pipe_reg_n_0_[2] ),
        .I3(\txd_pipe_reg_n_0_[7] ),
        .I4(\tx_is_invalid_k_reg[0]_i_2_n_0 ),
        .I5(\txd_is_IDLE_reg[0]_i_2_n_0 ),
        .O(\txd_is_IDLE_reg[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair81" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \txd_is_IDLE_reg[0]_i_2 
       (.I0(\txd_pipe_reg_n_0_[5] ),
        .I1(\txd_pipe_reg_n_0_[6] ),
        .O(\txd_is_IDLE_reg[0]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00000001)) 
    \txd_is_IDLE_reg[1]_i_1 
       (.I0(d[6]),
        .I1(d[7]),
        .I2(d[3]),
        .I3(d[4]),
        .I4(\txd_is_IDLE_reg[1]_i_2_n_0 ),
        .O(\txd_is_IDLE_reg[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFF7F)) 
    \txd_is_IDLE_reg[1]_i_2 
       (.I0(d[1]),
        .I1(d[0]),
        .I2(d[2]),
        .I3(d[5]),
        .O(\txd_is_IDLE_reg[1]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00000004)) 
    \txd_is_IDLE_reg[2]_i_1 
       (.I0(\txd_pipe_reg_n_0_[22] ),
        .I1(\txd_pipe_reg_n_0_[18] ),
        .I2(\txd_pipe_reg_n_0_[20] ),
        .I3(\txd_pipe_reg_n_0_[21] ),
        .I4(\txd_is_IDLE_reg[2]_i_2_n_0 ),
        .O(\txd_is_IDLE_reg[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair89" *) 
  LUT4 #(
    .INIT(16'hEFFF)) 
    \txd_is_IDLE_reg[2]_i_2 
       (.I0(\txd_pipe_reg_n_0_[23] ),
        .I1(\txd_pipe_reg_n_0_[19] ),
        .I2(\txd_pipe_reg_n_0_[17] ),
        .I3(\txd_pipe_reg_n_0_[16] ),
        .O(\txd_is_IDLE_reg[2]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00000001)) 
    \txd_is_IDLE_reg[3]_i_1 
       (.I0(\txd_pipe_reg_n_0_[27] ),
        .I1(\txd_pipe_reg_n_0_[31] ),
        .I2(\txd_pipe_reg_n_0_[28] ),
        .I3(\txd_pipe_reg_n_0_[29] ),
        .I4(\txd_is_IDLE_reg[3]_i_2_n_0 ),
        .O(\txd_is_IDLE_reg[3]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFF7F)) 
    \txd_is_IDLE_reg[3]_i_2 
       (.I0(\txd_pipe_reg_n_0_[25] ),
        .I1(\txd_pipe_reg_n_0_[24] ),
        .I2(\txd_pipe_reg_n_0_[26] ),
        .I3(\txd_pipe_reg_n_0_[30] ),
        .O(\txd_is_IDLE_reg[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000004)) 
    \txd_is_IDLE_reg[4]_i_1 
       (.I0(\txd_pipe_reg_n_0_[39] ),
        .I1(\txd_pipe_reg_n_0_[34] ),
        .I2(\txd_pipe_reg_n_0_[35] ),
        .I3(\txd_pipe_reg_n_0_[36] ),
        .I4(\txd_is_IDLE_reg[4]_i_2_n_0 ),
        .I5(\tx_is_invalid_k_reg[4]_i_2_n_0 ),
        .O(\txd_is_IDLE_reg[4]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \txd_is_IDLE_reg[4]_i_2 
       (.I0(\txd_pipe_reg_n_0_[37] ),
        .I1(\txd_pipe_reg_n_0_[38] ),
        .O(\txd_is_IDLE_reg[4]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00000001)) 
    \txd_is_IDLE_reg[5]_i_1 
       (.I0(\txd_pipe_reg_n_0_[43] ),
        .I1(\txd_pipe_reg_n_0_[44] ),
        .I2(\txd_pipe_reg_n_0_[46] ),
        .I3(\txd_pipe_reg_n_0_[47] ),
        .I4(\txd_is_IDLE_reg[5]_i_2_n_0 ),
        .O(\txd_is_IDLE_reg[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair88" *) 
  LUT4 #(
    .INIT(16'hFF7F)) 
    \txd_is_IDLE_reg[5]_i_2 
       (.I0(\txd_pipe_reg_n_0_[41] ),
        .I1(\txd_pipe_reg_n_0_[40] ),
        .I2(\txd_pipe_reg_n_0_[42] ),
        .I3(\txd_pipe_reg_n_0_[45] ),
        .O(\txd_is_IDLE_reg[5]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00000004)) 
    \txd_is_IDLE_reg[6]_i_1 
       (.I0(\txd_pipe_reg_n_0_[54] ),
        .I1(\txd_pipe_reg_n_0_[50] ),
        .I2(\txd_pipe_reg_n_0_[52] ),
        .I3(\txd_pipe_reg_n_0_[53] ),
        .I4(\txd_is_IDLE_reg[6]_i_2_n_0 ),
        .O(\txd_is_IDLE_reg[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hEFFF)) 
    \txd_is_IDLE_reg[6]_i_2 
       (.I0(\txd_pipe_reg_n_0_[55] ),
        .I1(\txd_pipe_reg_n_0_[51] ),
        .I2(\txd_pipe_reg_n_0_[49] ),
        .I3(\txd_pipe_reg_n_0_[48] ),
        .O(\txd_is_IDLE_reg[6]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00000001)) 
    \txd_is_IDLE_reg[7]_i_1 
       (.I0(\txd_pipe_reg_n_0_[59] ),
        .I1(\txd_pipe_reg_n_0_[63] ),
        .I2(\txd_pipe_reg_n_0_[60] ),
        .I3(\txd_pipe_reg_n_0_[61] ),
        .I4(\txd_is_IDLE_reg[7]_i_2_n_0 ),
        .O(txd_is_IDLE));
  LUT4 #(
    .INIT(16'hDFFF)) 
    \txd_is_IDLE_reg[7]_i_2 
       (.I0(\txd_pipe_reg_n_0_[58] ),
        .I1(\txd_pipe_reg_n_0_[62] ),
        .I2(\txd_pipe_reg_n_0_[57] ),
        .I3(\txd_pipe_reg_n_0_[56] ),
        .O(\txd_is_IDLE_reg[7]_i_2_n_0 ));
  FDRE \txd_is_IDLE_reg_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_is_IDLE_reg[0]_i_1_n_0 ),
        .Q(\txd_is_IDLE_reg_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \txd_is_IDLE_reg_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_is_IDLE_reg[1]_i_1_n_0 ),
        .Q(is_txd_IDLE),
        .R(1'b0));
  FDRE \txd_is_IDLE_reg_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_is_IDLE_reg[2]_i_1_n_0 ),
        .Q(\txd_is_IDLE_reg_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \txd_is_IDLE_reg_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_is_IDLE_reg[3]_i_1_n_0 ),
        .Q(\txd_is_IDLE_reg_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \txd_is_IDLE_reg_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_is_IDLE_reg[4]_i_1_n_0 ),
        .Q(\txd_is_IDLE_reg_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \txd_is_IDLE_reg_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_is_IDLE_reg[5]_i_1_n_0 ),
        .Q(\txd_is_IDLE_reg_reg_n_0_[5] ),
        .R(1'b0));
  FDRE \txd_is_IDLE_reg_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_is_IDLE_reg[6]_i_1_n_0 ),
        .Q(\txd_is_IDLE_reg_reg_n_0_[6] ),
        .R(1'b0));
  FDRE \txd_is_IDLE_reg_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(txd_is_IDLE),
        .Q(\txd_is_IDLE_reg_reg_n_0_[7] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[0] ),
        .Q(\txd_pipe_2_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[10] 
       (.C(usrclk),
        .CE(1'b1),
        .D(d[2]),
        .Q(txd_in[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[11] 
       (.C(usrclk),
        .CE(1'b1),
        .D(d[3]),
        .Q(txd_in[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[12] 
       (.C(usrclk),
        .CE(1'b1),
        .D(d[4]),
        .Q(txd_in[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[13] 
       (.C(usrclk),
        .CE(1'b1),
        .D(d[5]),
        .Q(txd_in[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[14] 
       (.C(usrclk),
        .CE(1'b1),
        .D(d[6]),
        .Q(txd_in[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[15] 
       (.C(usrclk),
        .CE(1'b1),
        .D(d[7]),
        .Q(txd_in[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[16] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[16] ),
        .Q(\txd_pipe_2_reg_n_0_[16] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[17] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[17] ),
        .Q(\txd_pipe_2_reg_n_0_[17] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[18] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[18] ),
        .Q(\txd_pipe_2_reg_n_0_[18] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[19] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[19] ),
        .Q(\txd_pipe_2_reg_n_0_[19] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[1] ),
        .Q(\txd_pipe_2_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[20] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[20] ),
        .Q(\txd_pipe_2_reg_n_0_[20] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[21] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[21] ),
        .Q(\txd_pipe_2_reg_n_0_[21] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[22] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[22] ),
        .Q(\txd_pipe_2_reg_n_0_[22] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[23] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[23] ),
        .Q(\txd_pipe_2_reg_n_0_[23] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[24] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[24] ),
        .Q(\txd_pipe_2_reg_n_0_[24] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[25] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[25] ),
        .Q(\txd_pipe_2_reg_n_0_[25] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[26] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[26] ),
        .Q(\txd_pipe_2_reg_n_0_[26] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[27] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[27] ),
        .Q(\txd_pipe_2_reg_n_0_[27] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[28] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[28] ),
        .Q(\txd_pipe_2_reg_n_0_[28] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[29] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[29] ),
        .Q(\txd_pipe_2_reg_n_0_[29] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[2] ),
        .Q(\txd_pipe_2_reg_n_0_[2] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[30] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[30] ),
        .Q(\txd_pipe_2_reg_n_0_[30] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[31] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[31] ),
        .Q(\txd_pipe_2_reg_n_0_[31] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[32] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[32] ),
        .Q(\txd_pipe_2_reg_n_0_[32] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[33] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[33] ),
        .Q(\txd_pipe_2_reg_n_0_[33] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[34] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[34] ),
        .Q(\txd_pipe_2_reg_n_0_[34] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[35] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[35] ),
        .Q(\txd_pipe_2_reg_n_0_[35] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[36] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[36] ),
        .Q(\txd_pipe_2_reg_n_0_[36] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[37] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[37] ),
        .Q(\txd_pipe_2_reg_n_0_[37] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[38] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[38] ),
        .Q(\txd_pipe_2_reg_n_0_[38] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[39] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[39] ),
        .Q(\txd_pipe_2_reg_n_0_[39] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[3] ),
        .Q(\txd_pipe_2_reg_n_0_[3] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[40] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[40] ),
        .Q(\txd_pipe_2_reg_n_0_[40] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[41] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[41] ),
        .Q(\txd_pipe_2_reg_n_0_[41] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[42] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[42] ),
        .Q(\txd_pipe_2_reg_n_0_[42] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[43] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[43] ),
        .Q(\txd_pipe_2_reg_n_0_[43] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[44] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[44] ),
        .Q(\txd_pipe_2_reg_n_0_[44] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[45] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[45] ),
        .Q(\txd_pipe_2_reg_n_0_[45] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[46] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[46] ),
        .Q(\txd_pipe_2_reg_n_0_[46] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[47] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[47] ),
        .Q(\txd_pipe_2_reg_n_0_[47] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[48] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[48] ),
        .Q(\txd_pipe_2_reg_n_0_[48] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[49] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[49] ),
        .Q(\txd_pipe_2_reg_n_0_[49] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[4] ),
        .Q(\txd_pipe_2_reg_n_0_[4] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[50] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[50] ),
        .Q(\txd_pipe_2_reg_n_0_[50] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[51] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[51] ),
        .Q(\txd_pipe_2_reg_n_0_[51] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[52] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[52] ),
        .Q(\txd_pipe_2_reg_n_0_[52] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[53] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[53] ),
        .Q(\txd_pipe_2_reg_n_0_[53] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[54] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[54] ),
        .Q(\txd_pipe_2_reg_n_0_[54] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[55] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[55] ),
        .Q(\txd_pipe_2_reg_n_0_[55] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[56] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[56] ),
        .Q(\txd_pipe_2_reg_n_0_[56] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[57] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[57] ),
        .Q(\txd_pipe_2_reg_n_0_[57] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[58] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[58] ),
        .Q(\txd_pipe_2_reg_n_0_[58] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[59] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[59] ),
        .Q(\txd_pipe_2_reg_n_0_[59] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[5] ),
        .Q(\txd_pipe_2_reg_n_0_[5] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[60] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[60] ),
        .Q(\txd_pipe_2_reg_n_0_[60] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[61] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[61] ),
        .Q(\txd_pipe_2_reg_n_0_[61] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[62] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[62] ),
        .Q(\txd_pipe_2_reg_n_0_[62] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[63] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[63] ),
        .Q(\txd_pipe_2_reg_n_0_[63] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[6] ),
        .Q(\txd_pipe_2_reg_n_0_[6] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_2_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_reg_n_0_[7] ),
        .Q(\txd_pipe_2_reg_n_0_[7] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[8] 
       (.C(usrclk),
        .CE(1'b1),
        .D(d[0]),
        .Q(txd_in[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_2_reg[9] 
       (.C(usrclk),
        .CE(1'b1),
        .D(d[1]),
        .Q(txd_in[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[0]),
        .Q(\txd_pipe_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[10] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[10]),
        .Q(d[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[11] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[11]),
        .Q(d[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[12] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[12]),
        .Q(d[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[13] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[13]),
        .Q(d[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[14] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[14]),
        .Q(d[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[15] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[15]),
        .Q(d[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[16] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[16]),
        .Q(\txd_pipe_reg_n_0_[16] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[17] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[17]),
        .Q(\txd_pipe_reg_n_0_[17] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[18] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[18]),
        .Q(\txd_pipe_reg_n_0_[18] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[19] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[19]),
        .Q(\txd_pipe_reg_n_0_[19] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[1]),
        .Q(\txd_pipe_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[20] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[20]),
        .Q(\txd_pipe_reg_n_0_[20] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[21] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[21]),
        .Q(\txd_pipe_reg_n_0_[21] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[22] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[22]),
        .Q(\txd_pipe_reg_n_0_[22] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[23] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[23]),
        .Q(\txd_pipe_reg_n_0_[23] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[24] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[24]),
        .Q(\txd_pipe_reg_n_0_[24] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[25] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[25]),
        .Q(\txd_pipe_reg_n_0_[25] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[26] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[26]),
        .Q(\txd_pipe_reg_n_0_[26] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[27] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[27]),
        .Q(\txd_pipe_reg_n_0_[27] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[28] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[28]),
        .Q(\txd_pipe_reg_n_0_[28] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[29] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[29]),
        .Q(\txd_pipe_reg_n_0_[29] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[2]),
        .Q(\txd_pipe_reg_n_0_[2] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[30] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[30]),
        .Q(\txd_pipe_reg_n_0_[30] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[31] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[31]),
        .Q(\txd_pipe_reg_n_0_[31] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[32] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[32]),
        .Q(\txd_pipe_reg_n_0_[32] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[33] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[33]),
        .Q(\txd_pipe_reg_n_0_[33] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[34] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[34]),
        .Q(\txd_pipe_reg_n_0_[34] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[35] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[35]),
        .Q(\txd_pipe_reg_n_0_[35] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[36] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[36]),
        .Q(\txd_pipe_reg_n_0_[36] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[37] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[37]),
        .Q(\txd_pipe_reg_n_0_[37] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[38] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[38]),
        .Q(\txd_pipe_reg_n_0_[38] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[39] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[39]),
        .Q(\txd_pipe_reg_n_0_[39] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[3]),
        .Q(\txd_pipe_reg_n_0_[3] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[40] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[40]),
        .Q(\txd_pipe_reg_n_0_[40] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[41] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[41]),
        .Q(\txd_pipe_reg_n_0_[41] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[42] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[42]),
        .Q(\txd_pipe_reg_n_0_[42] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[43] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[43]),
        .Q(\txd_pipe_reg_n_0_[43] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[44] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[44]),
        .Q(\txd_pipe_reg_n_0_[44] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[45] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[45]),
        .Q(\txd_pipe_reg_n_0_[45] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[46] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[46]),
        .Q(\txd_pipe_reg_n_0_[46] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[47] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[47]),
        .Q(\txd_pipe_reg_n_0_[47] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[48] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[48]),
        .Q(\txd_pipe_reg_n_0_[48] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[49] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[49]),
        .Q(\txd_pipe_reg_n_0_[49] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[4]),
        .Q(\txd_pipe_reg_n_0_[4] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[50] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[50]),
        .Q(\txd_pipe_reg_n_0_[50] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[51] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[51]),
        .Q(\txd_pipe_reg_n_0_[51] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[52] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[52]),
        .Q(\txd_pipe_reg_n_0_[52] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[53] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[53]),
        .Q(\txd_pipe_reg_n_0_[53] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[54] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[54]),
        .Q(\txd_pipe_reg_n_0_[54] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[55] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[55]),
        .Q(\txd_pipe_reg_n_0_[55] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[56] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[56]),
        .Q(\txd_pipe_reg_n_0_[56] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[57] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[57]),
        .Q(\txd_pipe_reg_n_0_[57] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[58] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[58]),
        .Q(\txd_pipe_reg_n_0_[58] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[59] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[59]),
        .Q(\txd_pipe_reg_n_0_[59] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[5]),
        .Q(\txd_pipe_reg_n_0_[5] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[60] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[60]),
        .Q(\txd_pipe_reg_n_0_[60] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[61] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[61]),
        .Q(\txd_pipe_reg_n_0_[61] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[62] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[62]),
        .Q(\txd_pipe_reg_n_0_[62] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[63] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[63]),
        .Q(\txd_pipe_reg_n_0_[63] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[6]),
        .Q(\txd_pipe_reg_n_0_[6] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_pipe_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[7]),
        .Q(\txd_pipe_reg_n_0_[7] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[8] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[8]),
        .Q(d[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \txd_pipe_reg[9] 
       (.C(usrclk),
        .CE(1'b1),
        .D(xgmii_txd[9]),
        .Q(d[1]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "tx_filter" *) 
module xaui_tx_filter
   (txc_filtered,
    \last_qmsg_reg[31] ,
    q_det_reg,
    \txd_out_reg[39] ,
    \last_qmsg_reg[0] ,
    \txd_out_reg[35] ,
    Q,
    usrclk,
    is_terminate,
    \txd_is_IDLE_reg_reg[4] ,
    is_invalid_k,
    \txd_out_reg[4]_0 ,
    \txd_out_reg[7]_0 ,
    txc_out_reg_0,
    txc_out_reg_1,
    \state_reg[1][1] ,
    configuration_vector,
    last_qmsg,
    \txd_pipe_2_reg[39] );
  output [0:0]txc_filtered;
  output \last_qmsg_reg[31] ;
  output q_det_reg;
  output [6:0]\txd_out_reg[39] ;
  output \last_qmsg_reg[0] ;
  output \txd_out_reg[35] ;
  input [0:0]Q;
  input usrclk;
  input is_terminate;
  input [0:0]\txd_is_IDLE_reg_reg[4] ;
  input [0:0]is_invalid_k;
  input \txd_out_reg[4]_0 ;
  input \txd_out_reg[7]_0 ;
  input txc_out_reg_0;
  input [2:0]txc_out_reg_1;
  input \state_reg[1][1] ;
  input [2:0]configuration_vector;
  input [0:0]last_qmsg;
  input [7:0]\txd_pipe_2_reg[39] ;

  wire [0:0]Q;
  wire [2:0]configuration_vector;
  wire [0:0]is_invalid_k;
  wire is_terminate;
  wire [0:0]last_qmsg;
  wire \last_qmsg[31]_i_3_n_0 ;
  wire \last_qmsg[31]_i_4_n_0 ;
  wire \last_qmsg[31]_i_5_n_0 ;
  wire \last_qmsg[6]_i_3_n_0 ;
  wire \last_qmsg[6]_i_4_n_0 ;
  wire \last_qmsg_reg[0] ;
  wire \last_qmsg_reg[31] ;
  wire q_det_reg;
  wire \state_reg[1][1] ;
  wire [0:0]txc_filtered;
  wire txc_out_reg_0;
  wire [2:0]txc_out_reg_1;
  wire [35:35]txd_filtered;
  wire [0:0]\txd_is_IDLE_reg_reg[4] ;
  wire \txd_out[0]_i_1_n_0 ;
  wire \txd_out[1]_i_1_n_0 ;
  wire \txd_out[6]_i_1_n_0 ;
  wire \txd_out[7]_i_1__4_n_0 ;
  wire \txd_out_reg[35] ;
  wire [6:0]\txd_out_reg[39] ;
  wire \txd_out_reg[4]_0 ;
  wire \txd_out_reg[7]_0 ;
  wire [7:0]\txd_pipe_2_reg[39] ;
  wire usrclk;

  LUT6 #(
    .INIT(64'h101010FF10101010)) 
    \last_qmsg[31]_i_1 
       (.I0(\last_qmsg[31]_i_3_n_0 ),
        .I1(\last_qmsg[31]_i_4_n_0 ),
        .I2(\last_qmsg[31]_i_5_n_0 ),
        .I3(\txd_out_reg[4]_0 ),
        .I4(\txd_out_reg[7]_0 ),
        .I5(txc_out_reg_0),
        .O(\last_qmsg_reg[31] ));
  LUT4 #(
    .INIT(16'hEFFF)) 
    \last_qmsg[31]_i_3 
       (.I0(\txd_out_reg[39] [5]),
        .I1(\txd_out_reg[39] [0]),
        .I2(\txd_out_reg[39] [6]),
        .I3(txd_filtered),
        .O(\last_qmsg[31]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFFFD)) 
    \last_qmsg[31]_i_4 
       (.I0(\txd_out_reg[39] [3]),
        .I1(\txd_out_reg[39] [1]),
        .I2(\txd_out_reg[39] [4]),
        .I3(txc_out_reg_1[2]),
        .O(\last_qmsg[31]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h1000)) 
    \last_qmsg[31]_i_5 
       (.I0(txc_out_reg_1[0]),
        .I1(txc_out_reg_1[1]),
        .I2(\txd_out_reg[39] [2]),
        .I3(txc_filtered),
        .O(\last_qmsg[31]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000004)) 
    \last_qmsg[6]_i_2 
       (.I0(txc_out_reg_1[2]),
        .I1(txc_filtered),
        .I2(txc_out_reg_1[1]),
        .I3(txc_out_reg_1[0]),
        .I4(\last_qmsg[6]_i_3_n_0 ),
        .I5(\last_qmsg[6]_i_4_n_0 ),
        .O(\last_qmsg_reg[0] ));
  LUT4 #(
    .INIT(16'hFFDF)) 
    \last_qmsg[6]_i_3 
       (.I0(\txd_out_reg[39] [3]),
        .I1(\txd_out_reg[39] [4]),
        .I2(\txd_out_reg[39] [6]),
        .I3(\txd_out_reg[39] [5]),
        .O(\last_qmsg[6]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFFDF)) 
    \last_qmsg[6]_i_4 
       (.I0(\txd_out_reg[39] [2]),
        .I1(\txd_out_reg[39] [1]),
        .I2(txd_filtered),
        .I3(\txd_out_reg[39] [0]),
        .O(\last_qmsg[6]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000008)) 
    q_det_i_3
       (.I0(txc_filtered),
        .I1(\txd_out_reg[39] [2]),
        .I2(txc_out_reg_1[1]),
        .I3(txc_out_reg_1[0]),
        .I4(\last_qmsg[31]_i_4_n_0 ),
        .I5(\last_qmsg[31]_i_3_n_0 ),
        .O(q_det_reg));
  FDRE #(
    .INIT(1'b1)) 
    txc_out_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(Q),
        .Q(txc_filtered),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h0222AAAA)) 
    \txd_out[0]_i_1 
       (.I0(\txd_pipe_2_reg[39] [0]),
        .I1(is_invalid_k),
        .I2(\txd_is_IDLE_reg_reg[4] ),
        .I3(is_terminate),
        .I4(Q),
        .O(\txd_out[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h50F8F8F8)) 
    \txd_out[1]_i_1 
       (.I0(Q),
        .I1(is_invalid_k),
        .I2(\txd_pipe_2_reg[39] [1]),
        .I3(is_terminate),
        .I4(\txd_is_IDLE_reg_reg[4] ),
        .O(\txd_out[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hBBB0BBBB88808888)) 
    \txd_out[35]_i_1 
       (.I0(txd_filtered),
        .I1(\state_reg[1][1] ),
        .I2(configuration_vector[2]),
        .I3(configuration_vector[1]),
        .I4(configuration_vector[0]),
        .I5(last_qmsg),
        .O(\txd_out_reg[35] ));
  LUT5 #(
    .INIT(32'h50F8F8F8)) 
    \txd_out[6]_i_1 
       (.I0(Q),
        .I1(is_invalid_k),
        .I2(\txd_pipe_2_reg[39] [6]),
        .I3(is_terminate),
        .I4(\txd_is_IDLE_reg_reg[4] ),
        .O(\txd_out[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hAA80)) 
    \txd_out[7]_i_1__4 
       (.I0(Q),
        .I1(is_terminate),
        .I2(\txd_is_IDLE_reg_reg[4] ),
        .I3(is_invalid_k),
        .O(\txd_out[7]_i_1__4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[0]_i_1_n_0 ),
        .Q(\txd_out_reg[39] [0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[1]_i_1_n_0 ),
        .Q(\txd_out_reg[39] [1]),
        .R(1'b0));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[39] [2]),
        .Q(\txd_out_reg[39] [2]),
        .S(\txd_out[7]_i_1__4_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[39] [3]),
        .Q(txd_filtered),
        .S(\txd_out[7]_i_1__4_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[39] [4]),
        .Q(\txd_out_reg[39] [3]),
        .S(\txd_out[7]_i_1__4_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[39] [5]),
        .Q(\txd_out_reg[39] [4]),
        .S(\txd_out[7]_i_1__4_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[6]_i_1_n_0 ),
        .Q(\txd_out_reg[39] [5]),
        .R(1'b0));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[39] [7]),
        .Q(\txd_out_reg[39] [6]),
        .S(\txd_out[7]_i_1__4_n_0 ));
endmodule

(* ORIG_REF_NAME = "tx_filter" *) 
module xaui_tx_filter_23
   (\txc_out_reg[5] ,
    D,
    \last_qmsg_reg[14] ,
    \last_qmsg_reg[10] ,
    \last_qmsg_reg[12] ,
    \last_qmsg_reg[13] ,
    \last_qmsg_reg[15] ,
    \txd_out_reg[43] ,
    Q,
    usrclk,
    is_terminate,
    \txd_is_IDLE_reg_reg[5] ,
    is_invalid_k,
    txc_out_reg_0,
    data1,
    \state_reg[1][1] ,
    configuration_vector,
    \last_qmsg_reg[11] ,
    \txd_pipe_2_reg[47] );
  output [0:0]\txc_out_reg[5] ;
  output [7:0]D;
  output [2:0]\last_qmsg_reg[14] ;
  output \last_qmsg_reg[10] ;
  output \last_qmsg_reg[12] ;
  output \last_qmsg_reg[13] ;
  output \last_qmsg_reg[15] ;
  output \txd_out_reg[43] ;
  input [0:0]Q;
  input usrclk;
  input is_terminate;
  input [0:0]\txd_is_IDLE_reg_reg[5] ;
  input [0:0]is_invalid_k;
  input txc_out_reg_0;
  input [7:0]data1;
  input \state_reg[1][1] ;
  input [2:0]configuration_vector;
  input [0:0]\last_qmsg_reg[11] ;
  input [7:0]\txd_pipe_2_reg[47] ;

  wire [7:0]D;
  wire [0:0]Q;
  wire [2:0]configuration_vector;
  wire [7:0]data1;
  wire [0:0]is_invalid_k;
  wire is_terminate;
  wire \last_qmsg_reg[10] ;
  wire [0:0]\last_qmsg_reg[11] ;
  wire \last_qmsg_reg[12] ;
  wire \last_qmsg_reg[13] ;
  wire [2:0]\last_qmsg_reg[14] ;
  wire \last_qmsg_reg[15] ;
  wire \state_reg[1][1] ;
  wire [0:0]\txc_out_reg[5] ;
  wire txc_out_reg_0;
  wire [0:0]\txd_is_IDLE_reg_reg[5] ;
  wire \txd_out[0]_i_1_n_0 ;
  wire \txd_out[1]_i_1_n_0 ;
  wire \txd_out[6]_i_1_n_0 ;
  wire \txd_out[7]_i_1__5_n_0 ;
  wire \txd_out_reg[43] ;
  wire \txd_out_reg_n_0_[3] ;
  wire [7:0]\txd_pipe_2_reg[47] ;
  wire usrclk;

  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[10]_i_1 
       (.I0(\last_qmsg_reg[10] ),
        .I1(txc_out_reg_0),
        .I2(data1[2]),
        .O(D[2]));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[11]_i_1 
       (.I0(\txd_out_reg_n_0_[3] ),
        .I1(txc_out_reg_0),
        .I2(data1[3]),
        .O(D[3]));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[12]_i_1 
       (.I0(\last_qmsg_reg[12] ),
        .I1(txc_out_reg_0),
        .I2(data1[4]),
        .O(D[4]));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[13]_i_1 
       (.I0(\last_qmsg_reg[13] ),
        .I1(txc_out_reg_0),
        .I2(data1[5]),
        .O(D[5]));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[14]_i_1 
       (.I0(\last_qmsg_reg[14] [2]),
        .I1(txc_out_reg_0),
        .I2(data1[6]),
        .O(D[6]));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[15]_i_1 
       (.I0(\last_qmsg_reg[15] ),
        .I1(txc_out_reg_0),
        .I2(data1[7]),
        .O(D[7]));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[8]_i_1 
       (.I0(\last_qmsg_reg[14] [0]),
        .I1(txc_out_reg_0),
        .I2(data1[0]),
        .O(D[0]));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[9]_i_1 
       (.I0(\last_qmsg_reg[14] [1]),
        .I1(txc_out_reg_0),
        .I2(data1[1]),
        .O(D[1]));
  FDRE #(
    .INIT(1'b1)) 
    txc_out_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(Q),
        .Q(\txc_out_reg[5] ),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h0222AAAA)) 
    \txd_out[0]_i_1 
       (.I0(\txd_pipe_2_reg[47] [0]),
        .I1(is_invalid_k),
        .I2(\txd_is_IDLE_reg_reg[5] ),
        .I3(is_terminate),
        .I4(Q),
        .O(\txd_out[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h50F8F8F8)) 
    \txd_out[1]_i_1 
       (.I0(Q),
        .I1(is_invalid_k),
        .I2(\txd_pipe_2_reg[47] [1]),
        .I3(is_terminate),
        .I4(\txd_is_IDLE_reg_reg[5] ),
        .O(\txd_out[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hBBB0BBBB88808888)) 
    \txd_out[43]_i_1 
       (.I0(\txd_out_reg_n_0_[3] ),
        .I1(\state_reg[1][1] ),
        .I2(configuration_vector[2]),
        .I3(configuration_vector[1]),
        .I4(configuration_vector[0]),
        .I5(\last_qmsg_reg[11] ),
        .O(\txd_out_reg[43] ));
  LUT5 #(
    .INIT(32'h50F8F8F8)) 
    \txd_out[6]_i_1 
       (.I0(Q),
        .I1(is_invalid_k),
        .I2(\txd_pipe_2_reg[47] [6]),
        .I3(is_terminate),
        .I4(\txd_is_IDLE_reg_reg[5] ),
        .O(\txd_out[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hAA80)) 
    \txd_out[7]_i_1__5 
       (.I0(Q),
        .I1(is_terminate),
        .I2(\txd_is_IDLE_reg_reg[5] ),
        .I3(is_invalid_k),
        .O(\txd_out[7]_i_1__5_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[0]_i_1_n_0 ),
        .Q(\last_qmsg_reg[14] [0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[1]_i_1_n_0 ),
        .Q(\last_qmsg_reg[14] [1]),
        .R(1'b0));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[47] [2]),
        .Q(\last_qmsg_reg[10] ),
        .S(\txd_out[7]_i_1__5_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[47] [3]),
        .Q(\txd_out_reg_n_0_[3] ),
        .S(\txd_out[7]_i_1__5_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[47] [4]),
        .Q(\last_qmsg_reg[12] ),
        .S(\txd_out[7]_i_1__5_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[47] [5]),
        .Q(\last_qmsg_reg[13] ),
        .S(\txd_out[7]_i_1__5_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[6]_i_1_n_0 ),
        .Q(\last_qmsg_reg[14] [2]),
        .R(1'b0));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[47] [7]),
        .Q(\last_qmsg_reg[15] ),
        .S(\txd_out[7]_i_1__5_n_0 ));
endmodule

(* ORIG_REF_NAME = "tx_filter" *) 
module xaui_tx_filter_24
   (\txc_out_reg[6] ,
    D,
    \last_qmsg_reg[22] ,
    \last_qmsg_reg[18] ,
    \last_qmsg_reg[20] ,
    \last_qmsg_reg[21] ,
    \last_qmsg_reg[23] ,
    \txd_out_reg[51] ,
    Q,
    usrclk,
    is_terminate,
    \txd_is_IDLE_reg_reg[6] ,
    is_invalid_k,
    txc_out_reg_0,
    data1,
    \state_reg[1][1] ,
    configuration_vector,
    \last_qmsg_reg[19] ,
    \txd_pipe_2_reg[55] );
  output [0:0]\txc_out_reg[6] ;
  output [7:0]D;
  output [2:0]\last_qmsg_reg[22] ;
  output \last_qmsg_reg[18] ;
  output \last_qmsg_reg[20] ;
  output \last_qmsg_reg[21] ;
  output \last_qmsg_reg[23] ;
  output \txd_out_reg[51] ;
  input [0:0]Q;
  input usrclk;
  input is_terminate;
  input [0:0]\txd_is_IDLE_reg_reg[6] ;
  input [0:0]is_invalid_k;
  input txc_out_reg_0;
  input [7:0]data1;
  input \state_reg[1][1] ;
  input [2:0]configuration_vector;
  input [0:0]\last_qmsg_reg[19] ;
  input [7:0]\txd_pipe_2_reg[55] ;

  wire [7:0]D;
  wire [0:0]Q;
  wire [2:0]configuration_vector;
  wire [7:0]data1;
  wire [0:0]is_invalid_k;
  wire is_terminate;
  wire \last_qmsg_reg[18] ;
  wire [0:0]\last_qmsg_reg[19] ;
  wire \last_qmsg_reg[20] ;
  wire \last_qmsg_reg[21] ;
  wire [2:0]\last_qmsg_reg[22] ;
  wire \last_qmsg_reg[23] ;
  wire \state_reg[1][1] ;
  wire [0:0]\txc_out_reg[6] ;
  wire txc_out_reg_0;
  wire [0:0]\txd_is_IDLE_reg_reg[6] ;
  wire \txd_out[0]_i_1_n_0 ;
  wire \txd_out[1]_i_1_n_0 ;
  wire \txd_out[6]_i_1_n_0 ;
  wire \txd_out[7]_i_1__6_n_0 ;
  wire \txd_out_reg[51] ;
  wire \txd_out_reg_n_0_[3] ;
  wire [7:0]\txd_pipe_2_reg[55] ;
  wire usrclk;

  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[16]_i_1 
       (.I0(\last_qmsg_reg[22] [0]),
        .I1(txc_out_reg_0),
        .I2(data1[0]),
        .O(D[0]));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[17]_i_1 
       (.I0(\last_qmsg_reg[22] [1]),
        .I1(txc_out_reg_0),
        .I2(data1[1]),
        .O(D[1]));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[18]_i_1 
       (.I0(\last_qmsg_reg[18] ),
        .I1(txc_out_reg_0),
        .I2(data1[2]),
        .O(D[2]));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[19]_i_1 
       (.I0(\txd_out_reg_n_0_[3] ),
        .I1(txc_out_reg_0),
        .I2(data1[3]),
        .O(D[3]));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[20]_i_1 
       (.I0(\last_qmsg_reg[20] ),
        .I1(txc_out_reg_0),
        .I2(data1[4]),
        .O(D[4]));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[21]_i_1 
       (.I0(\last_qmsg_reg[21] ),
        .I1(txc_out_reg_0),
        .I2(data1[5]),
        .O(D[5]));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[22]_i_1 
       (.I0(\last_qmsg_reg[22] [2]),
        .I1(txc_out_reg_0),
        .I2(data1[6]),
        .O(D[6]));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[23]_i_1 
       (.I0(\last_qmsg_reg[23] ),
        .I1(txc_out_reg_0),
        .I2(data1[7]),
        .O(D[7]));
  FDRE #(
    .INIT(1'b1)) 
    txc_out_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(Q),
        .Q(\txc_out_reg[6] ),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h0222AAAA)) 
    \txd_out[0]_i_1 
       (.I0(\txd_pipe_2_reg[55] [0]),
        .I1(is_invalid_k),
        .I2(\txd_is_IDLE_reg_reg[6] ),
        .I3(is_terminate),
        .I4(Q),
        .O(\txd_out[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h50F8F8F8)) 
    \txd_out[1]_i_1 
       (.I0(Q),
        .I1(is_invalid_k),
        .I2(\txd_pipe_2_reg[55] [1]),
        .I3(is_terminate),
        .I4(\txd_is_IDLE_reg_reg[6] ),
        .O(\txd_out[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hBBB0BBBB88808888)) 
    \txd_out[51]_i_1 
       (.I0(\txd_out_reg_n_0_[3] ),
        .I1(\state_reg[1][1] ),
        .I2(configuration_vector[2]),
        .I3(configuration_vector[1]),
        .I4(configuration_vector[0]),
        .I5(\last_qmsg_reg[19] ),
        .O(\txd_out_reg[51] ));
  LUT5 #(
    .INIT(32'h50F8F8F8)) 
    \txd_out[6]_i_1 
       (.I0(Q),
        .I1(is_invalid_k),
        .I2(\txd_pipe_2_reg[55] [6]),
        .I3(is_terminate),
        .I4(\txd_is_IDLE_reg_reg[6] ),
        .O(\txd_out[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hAA80)) 
    \txd_out[7]_i_1__6 
       (.I0(Q),
        .I1(is_terminate),
        .I2(\txd_is_IDLE_reg_reg[6] ),
        .I3(is_invalid_k),
        .O(\txd_out[7]_i_1__6_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[0]_i_1_n_0 ),
        .Q(\last_qmsg_reg[22] [0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[1]_i_1_n_0 ),
        .Q(\last_qmsg_reg[22] [1]),
        .R(1'b0));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[55] [2]),
        .Q(\last_qmsg_reg[18] ),
        .S(\txd_out[7]_i_1__6_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[55] [3]),
        .Q(\txd_out_reg_n_0_[3] ),
        .S(\txd_out[7]_i_1__6_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[55] [4]),
        .Q(\last_qmsg_reg[20] ),
        .S(\txd_out[7]_i_1__6_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[55] [5]),
        .Q(\last_qmsg_reg[21] ),
        .S(\txd_out[7]_i_1__6_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[6]_i_1_n_0 ),
        .Q(\last_qmsg_reg[22] [2]),
        .R(1'b0));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[55] [7]),
        .Q(\last_qmsg_reg[23] ),
        .S(\txd_out[7]_i_1__6_n_0 ));
endmodule

(* ORIG_REF_NAME = "tx_filter" *) 
module xaui_tx_filter_25
   (\txc_out_reg[7] ,
    D,
    \last_qmsg_reg[30] ,
    \last_qmsg_reg[26] ,
    \last_qmsg_reg[28] ,
    \last_qmsg_reg[29] ,
    \last_qmsg_reg[31] ,
    \txd_out_reg[59] ,
    Q,
    usrclk,
    is_terminate,
    \txd_is_IDLE_reg_reg[7] ,
    is_invalid_k,
    txc_out_reg_0,
    data1,
    \state_reg[1][1] ,
    configuration_vector,
    \last_qmsg_reg[27] ,
    \txd_pipe_2_reg[63] );
  output [0:0]\txc_out_reg[7] ;
  output [7:0]D;
  output [2:0]\last_qmsg_reg[30] ;
  output \last_qmsg_reg[26] ;
  output \last_qmsg_reg[28] ;
  output \last_qmsg_reg[29] ;
  output \last_qmsg_reg[31] ;
  output \txd_out_reg[59] ;
  input [0:0]Q;
  input usrclk;
  input is_terminate;
  input [0:0]\txd_is_IDLE_reg_reg[7] ;
  input [0:0]is_invalid_k;
  input txc_out_reg_0;
  input [7:0]data1;
  input \state_reg[1][1] ;
  input [2:0]configuration_vector;
  input [0:0]\last_qmsg_reg[27] ;
  input [7:0]\txd_pipe_2_reg[63] ;

  wire [7:0]D;
  wire [0:0]Q;
  wire [2:0]configuration_vector;
  wire [7:0]data1;
  wire [0:0]is_invalid_k;
  wire is_terminate;
  wire \last_qmsg_reg[26] ;
  wire [0:0]\last_qmsg_reg[27] ;
  wire \last_qmsg_reg[28] ;
  wire \last_qmsg_reg[29] ;
  wire [2:0]\last_qmsg_reg[30] ;
  wire \last_qmsg_reg[31] ;
  wire \state_reg[1][1] ;
  wire [0:0]\txc_out_reg[7] ;
  wire txc_out_reg_0;
  wire [0:0]\txd_is_IDLE_reg_reg[7] ;
  wire \txd_out[0]_i_1_n_0 ;
  wire \txd_out[1]_i_1_n_0 ;
  wire \txd_out[6]_i_1_n_0 ;
  wire \txd_out[7]_i_1__7_n_0 ;
  wire \txd_out_reg[59] ;
  wire \txd_out_reg_n_0_[3] ;
  wire [7:0]\txd_pipe_2_reg[63] ;
  wire usrclk;

  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[24]_i_1 
       (.I0(\last_qmsg_reg[30] [0]),
        .I1(txc_out_reg_0),
        .I2(data1[0]),
        .O(D[0]));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[25]_i_1 
       (.I0(\last_qmsg_reg[30] [1]),
        .I1(txc_out_reg_0),
        .I2(data1[1]),
        .O(D[1]));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[26]_i_1 
       (.I0(\last_qmsg_reg[26] ),
        .I1(txc_out_reg_0),
        .I2(data1[2]),
        .O(D[2]));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[27]_i_1 
       (.I0(\txd_out_reg_n_0_[3] ),
        .I1(txc_out_reg_0),
        .I2(data1[3]),
        .O(D[3]));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[28]_i_1 
       (.I0(\last_qmsg_reg[28] ),
        .I1(txc_out_reg_0),
        .I2(data1[4]),
        .O(D[4]));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[29]_i_1 
       (.I0(\last_qmsg_reg[29] ),
        .I1(txc_out_reg_0),
        .I2(data1[5]),
        .O(D[5]));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[30]_i_1 
       (.I0(\last_qmsg_reg[30] [2]),
        .I1(txc_out_reg_0),
        .I2(data1[6]),
        .O(D[6]));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \last_qmsg[31]_i_2 
       (.I0(\last_qmsg_reg[31] ),
        .I1(txc_out_reg_0),
        .I2(data1[7]),
        .O(D[7]));
  FDRE #(
    .INIT(1'b1)) 
    txc_out_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(Q),
        .Q(\txc_out_reg[7] ),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h0222AAAA)) 
    \txd_out[0]_i_1 
       (.I0(\txd_pipe_2_reg[63] [0]),
        .I1(is_invalid_k),
        .I2(\txd_is_IDLE_reg_reg[7] ),
        .I3(is_terminate),
        .I4(Q),
        .O(\txd_out[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h50F8F8F8)) 
    \txd_out[1]_i_1 
       (.I0(Q),
        .I1(is_invalid_k),
        .I2(\txd_pipe_2_reg[63] [1]),
        .I3(is_terminate),
        .I4(\txd_is_IDLE_reg_reg[7] ),
        .O(\txd_out[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hBBB0BBBB88808888)) 
    \txd_out[59]_i_2 
       (.I0(\txd_out_reg_n_0_[3] ),
        .I1(\state_reg[1][1] ),
        .I2(configuration_vector[2]),
        .I3(configuration_vector[1]),
        .I4(configuration_vector[0]),
        .I5(\last_qmsg_reg[27] ),
        .O(\txd_out_reg[59] ));
  LUT5 #(
    .INIT(32'h50F8F8F8)) 
    \txd_out[6]_i_1 
       (.I0(Q),
        .I1(is_invalid_k),
        .I2(\txd_pipe_2_reg[63] [6]),
        .I3(is_terminate),
        .I4(\txd_is_IDLE_reg_reg[7] ),
        .O(\txd_out[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hAA80)) 
    \txd_out[7]_i_1__7 
       (.I0(Q),
        .I1(is_terminate),
        .I2(\txd_is_IDLE_reg_reg[7] ),
        .I3(is_invalid_k),
        .O(\txd_out[7]_i_1__7_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[0]_i_1_n_0 ),
        .Q(\last_qmsg_reg[30] [0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[1]_i_1_n_0 ),
        .Q(\last_qmsg_reg[30] [1]),
        .R(1'b0));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[63] [2]),
        .Q(\last_qmsg_reg[26] ),
        .S(\txd_out[7]_i_1__7_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[63] [3]),
        .Q(\txd_out_reg_n_0_[3] ),
        .S(\txd_out[7]_i_1__7_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[63] [4]),
        .Q(\last_qmsg_reg[28] ),
        .S(\txd_out[7]_i_1__7_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[63] [5]),
        .Q(\last_qmsg_reg[29] ),
        .S(\txd_out[7]_i_1__7_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[6]_i_1_n_0 ),
        .Q(\last_qmsg_reg[30] [2]),
        .R(1'b0));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[63] [7]),
        .Q(\last_qmsg_reg[31] ),
        .S(\txd_out[7]_i_1__7_n_0 ));
endmodule

(* ORIG_REF_NAME = "tx_filter" *) 
module xaui_tx_filter_26
   (txc_filtered,
    q_det_reg,
    txd_filtered,
    \last_qmsg_reg[31] ,
    \last_qmsg_reg[31]_0 ,
    \last_qmsg_reg[31]_1 ,
    Q,
    usrclk,
    \is_terminate_reg[0] ,
    \txd_is_IDLE_reg_reg[0] ,
    is_invalid_k,
    txc_out_reg_0,
    \txd_pipe_2_reg[7] );
  output [0:0]txc_filtered;
  output q_det_reg;
  output [7:0]txd_filtered;
  output \last_qmsg_reg[31] ;
  output \last_qmsg_reg[31]_0 ;
  output \last_qmsg_reg[31]_1 ;
  input [0:0]Q;
  input usrclk;
  input \is_terminate_reg[0] ;
  input [0:0]\txd_is_IDLE_reg_reg[0] ;
  input [0:0]is_invalid_k;
  input [2:0]txc_out_reg_0;
  input [7:0]\txd_pipe_2_reg[7] ;

  wire [0:0]Q;
  wire [0:0]is_invalid_k;
  wire \is_terminate_reg[0] ;
  wire \last_qmsg_reg[31] ;
  wire \last_qmsg_reg[31]_0 ;
  wire \last_qmsg_reg[31]_1 ;
  wire q_det_reg;
  wire [0:0]txc_filtered;
  wire [2:0]txc_out_reg_0;
  wire [7:0]txd_filtered;
  wire [0:0]\txd_is_IDLE_reg_reg[0] ;
  wire \txd_out[0]_i_1_n_0 ;
  wire \txd_out[1]_i_1_n_0 ;
  wire \txd_out[6]_i_1_n_0 ;
  wire \txd_out[7]_i_1__0_n_0 ;
  wire [7:0]\txd_pipe_2_reg[7] ;
  wire usrclk;

  LUT4 #(
    .INIT(16'hFFFD)) 
    \last_qmsg[31]_i_6 
       (.I0(txd_filtered[4]),
        .I1(txc_out_reg_0[2]),
        .I2(txd_filtered[6]),
        .I3(txd_filtered[5]),
        .O(\last_qmsg_reg[31]_0 ));
  LUT4 #(
    .INIT(16'hFFDF)) 
    \last_qmsg[31]_i_7 
       (.I0(txd_filtered[7]),
        .I1(txd_filtered[1]),
        .I2(txd_filtered[3]),
        .I3(txc_out_reg_0[0]),
        .O(\last_qmsg_reg[31] ));
  LUT4 #(
    .INIT(16'h1000)) 
    \last_qmsg[31]_i_8 
       (.I0(txc_out_reg_0[1]),
        .I1(txd_filtered[0]),
        .I2(txc_filtered),
        .I3(txd_filtered[2]),
        .O(\last_qmsg_reg[31]_1 ));
  LUT6 #(
    .INIT(64'h0000000000000008)) 
    q_det_i_2
       (.I0(txd_filtered[2]),
        .I1(txc_filtered),
        .I2(txd_filtered[0]),
        .I3(txc_out_reg_0[1]),
        .I4(\last_qmsg_reg[31] ),
        .I5(\last_qmsg_reg[31]_0 ),
        .O(q_det_reg));
  FDRE #(
    .INIT(1'b1)) 
    txc_out_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(Q),
        .Q(txc_filtered),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h0222AAAA)) 
    \txd_out[0]_i_1 
       (.I0(\txd_pipe_2_reg[7] [0]),
        .I1(is_invalid_k),
        .I2(\txd_is_IDLE_reg_reg[0] ),
        .I3(\is_terminate_reg[0] ),
        .I4(Q),
        .O(\txd_out[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h50F8F8F8)) 
    \txd_out[1]_i_1 
       (.I0(Q),
        .I1(is_invalid_k),
        .I2(\txd_pipe_2_reg[7] [1]),
        .I3(\is_terminate_reg[0] ),
        .I4(\txd_is_IDLE_reg_reg[0] ),
        .O(\txd_out[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h50F8F8F8)) 
    \txd_out[6]_i_1 
       (.I0(Q),
        .I1(is_invalid_k),
        .I2(\txd_pipe_2_reg[7] [6]),
        .I3(\is_terminate_reg[0] ),
        .I4(\txd_is_IDLE_reg_reg[0] ),
        .O(\txd_out[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hAA80)) 
    \txd_out[7]_i_1__0 
       (.I0(Q),
        .I1(\is_terminate_reg[0] ),
        .I2(\txd_is_IDLE_reg_reg[0] ),
        .I3(is_invalid_k),
        .O(\txd_out[7]_i_1__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[0]_i_1_n_0 ),
        .Q(txd_filtered[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[1]_i_1_n_0 ),
        .Q(txd_filtered[1]),
        .R(1'b0));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[7] [2]),
        .Q(txd_filtered[2]),
        .S(\txd_out[7]_i_1__0_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[7] [3]),
        .Q(txd_filtered[3]),
        .S(\txd_out[7]_i_1__0_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[7] [4]),
        .Q(txd_filtered[4]),
        .S(\txd_out[7]_i_1__0_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[7] [5]),
        .Q(txd_filtered[5]),
        .S(\txd_out[7]_i_1__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[6]_i_1_n_0 ),
        .Q(txd_filtered[6]),
        .R(1'b0));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[7] [7]),
        .Q(txd_filtered[7]),
        .S(\txd_out[7]_i_1__0_n_0 ));
endmodule

(* ORIG_REF_NAME = "tx_filter" *) 
module xaui_tx_filter_27
   (\txc_out_reg[1] ,
    data1,
    Q,
    usrclk,
    \is_terminate_reg[0] ,
    \txd_is_IDLE_reg_reg[1] ,
    is_invalid_k,
    \txd_pipe_2_reg[15] );
  output [0:0]\txc_out_reg[1] ;
  output [7:0]data1;
  input [0:0]Q;
  input usrclk;
  input \is_terminate_reg[0] ;
  input [0:0]\txd_is_IDLE_reg_reg[1] ;
  input [0:0]is_invalid_k;
  input [7:0]\txd_pipe_2_reg[15] ;

  wire [0:0]Q;
  wire [7:0]data1;
  wire [0:0]is_invalid_k;
  wire \is_terminate_reg[0] ;
  wire [0:0]\txc_out_reg[1] ;
  wire [0:0]\txd_is_IDLE_reg_reg[1] ;
  wire \txd_out[0]_i_1_n_0 ;
  wire \txd_out[1]_i_1_n_0 ;
  wire \txd_out[6]_i_1_n_0 ;
  wire \txd_out[7]_i_1__1_n_0 ;
  wire [7:0]\txd_pipe_2_reg[15] ;
  wire usrclk;

  FDRE #(
    .INIT(1'b1)) 
    txc_out_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(Q),
        .Q(\txc_out_reg[1] ),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h0222AAAA)) 
    \txd_out[0]_i_1 
       (.I0(\txd_pipe_2_reg[15] [0]),
        .I1(is_invalid_k),
        .I2(\txd_is_IDLE_reg_reg[1] ),
        .I3(\is_terminate_reg[0] ),
        .I4(Q),
        .O(\txd_out[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h50F8F8F8)) 
    \txd_out[1]_i_1 
       (.I0(Q),
        .I1(is_invalid_k),
        .I2(\txd_pipe_2_reg[15] [1]),
        .I3(\is_terminate_reg[0] ),
        .I4(\txd_is_IDLE_reg_reg[1] ),
        .O(\txd_out[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h50F8F8F8)) 
    \txd_out[6]_i_1 
       (.I0(Q),
        .I1(is_invalid_k),
        .I2(\txd_pipe_2_reg[15] [6]),
        .I3(\is_terminate_reg[0] ),
        .I4(\txd_is_IDLE_reg_reg[1] ),
        .O(\txd_out[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hAA80)) 
    \txd_out[7]_i_1__1 
       (.I0(Q),
        .I1(\is_terminate_reg[0] ),
        .I2(\txd_is_IDLE_reg_reg[1] ),
        .I3(is_invalid_k),
        .O(\txd_out[7]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[0]_i_1_n_0 ),
        .Q(data1[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[1]_i_1_n_0 ),
        .Q(data1[1]),
        .R(1'b0));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[15] [2]),
        .Q(data1[2]),
        .S(\txd_out[7]_i_1__1_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[15] [3]),
        .Q(data1[3]),
        .S(\txd_out[7]_i_1__1_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[15] [4]),
        .Q(data1[4]),
        .S(\txd_out[7]_i_1__1_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[15] [5]),
        .Q(data1[5]),
        .S(\txd_out[7]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[6]_i_1_n_0 ),
        .Q(data1[6]),
        .R(1'b0));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[15] [7]),
        .Q(data1[7]),
        .S(\txd_out[7]_i_1__1_n_0 ));
endmodule

(* ORIG_REF_NAME = "tx_filter" *) 
module xaui_tx_filter_28
   (\txc_out_reg[2] ,
    data1,
    Q,
    usrclk,
    \is_terminate_reg[0] ,
    \txd_is_IDLE_reg_reg[2] ,
    is_invalid_k,
    \txd_pipe_2_reg[23] );
  output [0:0]\txc_out_reg[2] ;
  output [7:0]data1;
  input [0:0]Q;
  input usrclk;
  input \is_terminate_reg[0] ;
  input [0:0]\txd_is_IDLE_reg_reg[2] ;
  input [0:0]is_invalid_k;
  input [7:0]\txd_pipe_2_reg[23] ;

  wire [0:0]Q;
  wire [7:0]data1;
  wire [0:0]is_invalid_k;
  wire \is_terminate_reg[0] ;
  wire [0:0]\txc_out_reg[2] ;
  wire [0:0]\txd_is_IDLE_reg_reg[2] ;
  wire \txd_out[0]_i_1_n_0 ;
  wire \txd_out[1]_i_1_n_0 ;
  wire \txd_out[6]_i_1_n_0 ;
  wire \txd_out[7]_i_1__2_n_0 ;
  wire [7:0]\txd_pipe_2_reg[23] ;
  wire usrclk;

  FDRE #(
    .INIT(1'b1)) 
    txc_out_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(Q),
        .Q(\txc_out_reg[2] ),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h0222AAAA)) 
    \txd_out[0]_i_1 
       (.I0(\txd_pipe_2_reg[23] [0]),
        .I1(is_invalid_k),
        .I2(\txd_is_IDLE_reg_reg[2] ),
        .I3(\is_terminate_reg[0] ),
        .I4(Q),
        .O(\txd_out[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h50F8F8F8)) 
    \txd_out[1]_i_1 
       (.I0(Q),
        .I1(is_invalid_k),
        .I2(\txd_pipe_2_reg[23] [1]),
        .I3(\is_terminate_reg[0] ),
        .I4(\txd_is_IDLE_reg_reg[2] ),
        .O(\txd_out[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h50F8F8F8)) 
    \txd_out[6]_i_1 
       (.I0(Q),
        .I1(is_invalid_k),
        .I2(\txd_pipe_2_reg[23] [6]),
        .I3(\is_terminate_reg[0] ),
        .I4(\txd_is_IDLE_reg_reg[2] ),
        .O(\txd_out[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hAA80)) 
    \txd_out[7]_i_1__2 
       (.I0(Q),
        .I1(\is_terminate_reg[0] ),
        .I2(\txd_is_IDLE_reg_reg[2] ),
        .I3(is_invalid_k),
        .O(\txd_out[7]_i_1__2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[0]_i_1_n_0 ),
        .Q(data1[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[1]_i_1_n_0 ),
        .Q(data1[1]),
        .R(1'b0));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[23] [2]),
        .Q(data1[2]),
        .S(\txd_out[7]_i_1__2_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[23] [3]),
        .Q(data1[3]),
        .S(\txd_out[7]_i_1__2_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[23] [4]),
        .Q(data1[4]),
        .S(\txd_out[7]_i_1__2_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[23] [5]),
        .Q(data1[5]),
        .S(\txd_out[7]_i_1__2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[6]_i_1_n_0 ),
        .Q(data1[6]),
        .R(1'b0));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[23] [7]),
        .Q(data1[7]),
        .S(\txd_out[7]_i_1__2_n_0 ));
endmodule

(* ORIG_REF_NAME = "tx_filter" *) 
module xaui_tx_filter_29
   (\txc_out_reg[3] ,
    data1,
    Q,
    usrclk,
    \is_terminate_reg[0] ,
    \txd_is_IDLE_reg_reg[3] ,
    is_invalid_k,
    \txd_pipe_2_reg[31] );
  output [0:0]\txc_out_reg[3] ;
  output [7:0]data1;
  input [0:0]Q;
  input usrclk;
  input \is_terminate_reg[0] ;
  input [0:0]\txd_is_IDLE_reg_reg[3] ;
  input [0:0]is_invalid_k;
  input [7:0]\txd_pipe_2_reg[31] ;

  wire [0:0]Q;
  wire [7:0]data1;
  wire [0:0]is_invalid_k;
  wire \is_terminate_reg[0] ;
  wire [0:0]\txc_out_reg[3] ;
  wire [0:0]\txd_is_IDLE_reg_reg[3] ;
  wire \txd_out[0]_i_1_n_0 ;
  wire \txd_out[1]_i_1_n_0 ;
  wire \txd_out[6]_i_1_n_0 ;
  wire \txd_out[7]_i_1__3_n_0 ;
  wire [7:0]\txd_pipe_2_reg[31] ;
  wire usrclk;

  FDRE #(
    .INIT(1'b1)) 
    txc_out_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(Q),
        .Q(\txc_out_reg[3] ),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h0222AAAA)) 
    \txd_out[0]_i_1 
       (.I0(\txd_pipe_2_reg[31] [0]),
        .I1(is_invalid_k),
        .I2(\txd_is_IDLE_reg_reg[3] ),
        .I3(\is_terminate_reg[0] ),
        .I4(Q),
        .O(\txd_out[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h50F8F8F8)) 
    \txd_out[1]_i_1 
       (.I0(Q),
        .I1(is_invalid_k),
        .I2(\txd_pipe_2_reg[31] [1]),
        .I3(\is_terminate_reg[0] ),
        .I4(\txd_is_IDLE_reg_reg[3] ),
        .O(\txd_out[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h50F8F8F8)) 
    \txd_out[6]_i_1 
       (.I0(Q),
        .I1(is_invalid_k),
        .I2(\txd_pipe_2_reg[31] [6]),
        .I3(\is_terminate_reg[0] ),
        .I4(\txd_is_IDLE_reg_reg[3] ),
        .O(\txd_out[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hAA80)) 
    \txd_out[7]_i_1__3 
       (.I0(Q),
        .I1(\is_terminate_reg[0] ),
        .I2(\txd_is_IDLE_reg_reg[3] ),
        .I3(is_invalid_k),
        .O(\txd_out[7]_i_1__3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[0]_i_1_n_0 ),
        .Q(data1[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[1]_i_1_n_0 ),
        .Q(data1[1]),
        .R(1'b0));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[31] [2]),
        .Q(data1[2]),
        .S(\txd_out[7]_i_1__3_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[31] [3]),
        .Q(data1[3]),
        .S(\txd_out[7]_i_1__3_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[31] [4]),
        .Q(data1[4]),
        .S(\txd_out[7]_i_1__3_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[31] [5]),
        .Q(data1[5]),
        .S(\txd_out[7]_i_1__3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \txd_out_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out[6]_i_1_n_0 ),
        .Q(data1[6]),
        .R(1'b0));
  FDSE #(
    .INIT(1'b1)) 
    \txd_out_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_pipe_2_reg[31] [7]),
        .Q(data1[7]),
        .S(\txd_out[7]_i_1__3_n_0 ));
endmodule

(* ORIG_REF_NAME = "tx_recoder" *) 
module xaui_tx_recoder
   (\txd_out_reg[24]_0 ,
    txd_out13_out,
    \txd_out_reg[38]_0 ,
    \txd_out_reg[24]_1 ,
    mgt_txdata,
    mgt_txcharisk,
    configuration_vector,
    D,
    usrclk,
    \state_reg[1][1] ,
    \state_reg[1][2] ,
    \last_qmsg_reg[23] ,
    \last_qmsg_reg[15] ,
    \last_qmsg_reg[7] ,
    \state_reg[1][2]_0 ,
    \last_qmsg_reg[29] ,
    \last_qmsg_reg[21] ,
    \last_qmsg_reg[13] ,
    \last_qmsg_reg[5] ,
    \state_reg[1][0] ,
    \txd_out_reg[4]_0 ,
    \txd_out_reg[2]_0 ,
    \txd_out_reg[4]_1 ,
    \txd_out_reg[2]_1 ,
    \txd_out_reg[4]_2 ,
    \txd_out_reg[2]_2 ,
    \txd_out_reg[4]_3 ,
    \txd_out_reg[2]_3 ,
    \state_reg[1][0]_0 ,
    \txd_out_reg[3]_0 ,
    \txd_out_reg[3]_1 ,
    \txd_out_reg[3]_2 ,
    \txd_out_reg[3]_3 ,
    \state_reg[0][0] ,
    \state_reg[0][2] ,
    \state_reg[0][2]_0 ,
    \state_reg[0][2]_1 ,
    \state_reg[0][2]_2 ,
    \state_reg[0][1] ,
    \state_reg[0][2]_3 ,
    \state_reg[0][2]_4 ,
    \last_qmsg_reg[13]_0 ,
    \state_reg[0][2]_5 ,
    \state_reg[0][1]_0 ,
    \txd_out_reg[4]_4 ,
    \txd_out_reg[2]_4 ,
    \txd_out_reg[4]_5 ,
    \txd_out_reg[2]_5 ,
    \txd_out_reg[4]_6 ,
    \txd_out_reg[2]_6 ,
    \txd_out_reg[4]_7 ,
    \txd_out_reg[2]_7 ,
    txc_out_reg);
  output \txd_out_reg[24]_0 ;
  output txd_out13_out;
  output \txd_out_reg[38]_0 ;
  output \txd_out_reg[24]_1 ;
  output [63:0]mgt_txdata;
  output [7:0]mgt_txcharisk;
  input [2:0]configuration_vector;
  input [27:0]D;
  input usrclk;
  input \state_reg[1][1] ;
  input \state_reg[1][2] ;
  input \last_qmsg_reg[23] ;
  input \last_qmsg_reg[15] ;
  input \last_qmsg_reg[7] ;
  input \state_reg[1][2]_0 ;
  input \last_qmsg_reg[29] ;
  input \last_qmsg_reg[21] ;
  input \last_qmsg_reg[13] ;
  input \last_qmsg_reg[5] ;
  input \state_reg[1][0] ;
  input \txd_out_reg[4]_0 ;
  input \txd_out_reg[2]_0 ;
  input \txd_out_reg[4]_1 ;
  input \txd_out_reg[2]_1 ;
  input \txd_out_reg[4]_2 ;
  input \txd_out_reg[2]_2 ;
  input \txd_out_reg[4]_3 ;
  input \txd_out_reg[2]_3 ;
  input \state_reg[1][0]_0 ;
  input \txd_out_reg[3]_0 ;
  input \txd_out_reg[3]_1 ;
  input \txd_out_reg[3]_2 ;
  input \txd_out_reg[3]_3 ;
  input \state_reg[0][0] ;
  input \state_reg[0][2] ;
  input \state_reg[0][2]_0 ;
  input \state_reg[0][2]_1 ;
  input \state_reg[0][2]_2 ;
  input \state_reg[0][1] ;
  input \state_reg[0][2]_3 ;
  input \state_reg[0][2]_4 ;
  input \last_qmsg_reg[13]_0 ;
  input \state_reg[0][2]_5 ;
  input \state_reg[0][1]_0 ;
  input \txd_out_reg[4]_4 ;
  input \txd_out_reg[2]_4 ;
  input \txd_out_reg[4]_5 ;
  input \txd_out_reg[2]_5 ;
  input \txd_out_reg[4]_6 ;
  input \txd_out_reg[2]_6 ;
  input \txd_out_reg[4]_7 ;
  input \txd_out_reg[2]_7 ;
  input [7:0]txc_out_reg;

  wire [27:0]D;
  wire [2:0]configuration_vector;
  wire \last_qmsg_reg[13] ;
  wire \last_qmsg_reg[13]_0 ;
  wire \last_qmsg_reg[15] ;
  wire \last_qmsg_reg[21] ;
  wire \last_qmsg_reg[23] ;
  wire \last_qmsg_reg[29] ;
  wire \last_qmsg_reg[5] ;
  wire \last_qmsg_reg[7] ;
  wire [7:0]mgt_txcharisk;
  wire [63:0]mgt_txdata;
  wire \state_reg[0][0] ;
  wire \state_reg[0][1] ;
  wire \state_reg[0][1]_0 ;
  wire \state_reg[0][2] ;
  wire \state_reg[0][2]_0 ;
  wire \state_reg[0][2]_1 ;
  wire \state_reg[0][2]_2 ;
  wire \state_reg[0][2]_3 ;
  wire \state_reg[0][2]_4 ;
  wire \state_reg[0][2]_5 ;
  wire \state_reg[1][0] ;
  wire \state_reg[1][0]_0 ;
  wire \state_reg[1][1] ;
  wire \state_reg[1][2] ;
  wire \state_reg[1][2]_0 ;
  wire [7:0]txc_out_reg;
  wire txd_out13_out;
  wire \txd_out_reg[24]_0 ;
  wire \txd_out_reg[24]_1 ;
  wire \txd_out_reg[2]_0 ;
  wire \txd_out_reg[2]_1 ;
  wire \txd_out_reg[2]_2 ;
  wire \txd_out_reg[2]_3 ;
  wire \txd_out_reg[2]_4 ;
  wire \txd_out_reg[2]_5 ;
  wire \txd_out_reg[2]_6 ;
  wire \txd_out_reg[2]_7 ;
  wire \txd_out_reg[38]_0 ;
  wire \txd_out_reg[3]_0 ;
  wire \txd_out_reg[3]_1 ;
  wire \txd_out_reg[3]_2 ;
  wire \txd_out_reg[3]_3 ;
  wire \txd_out_reg[4]_0 ;
  wire \txd_out_reg[4]_1 ;
  wire \txd_out_reg[4]_2 ;
  wire \txd_out_reg[4]_3 ;
  wire \txd_out_reg[4]_4 ;
  wire \txd_out_reg[4]_5 ;
  wire \txd_out_reg[4]_6 ;
  wire \txd_out_reg[4]_7 ;
  wire usrclk;

  LUT3 #(
    .INIT(8'h08)) 
    \txc_out[7]_i_1 
       (.I0(configuration_vector[0]),
        .I1(configuration_vector[1]),
        .I2(configuration_vector[2]),
        .O(txd_out13_out));
  FDSE \txc_out_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(txc_out_reg[0]),
        .Q(mgt_txcharisk[0]),
        .S(txd_out13_out));
  FDSE \txc_out_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(txc_out_reg[1]),
        .Q(mgt_txcharisk[2]),
        .S(txd_out13_out));
  FDSE \txc_out_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(txc_out_reg[2]),
        .Q(mgt_txcharisk[4]),
        .S(txd_out13_out));
  FDSE \txc_out_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(txc_out_reg[3]),
        .Q(mgt_txcharisk[6]),
        .S(txd_out13_out));
  FDSE \txc_out_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(txc_out_reg[4]),
        .Q(mgt_txcharisk[1]),
        .S(txd_out13_out));
  FDSE \txc_out_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(txc_out_reg[5]),
        .Q(mgt_txcharisk[3]),
        .S(txd_out13_out));
  FDSE \txc_out_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(txc_out_reg[6]),
        .Q(mgt_txcharisk[5]),
        .S(txd_out13_out));
  FDSE \txc_out_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(txc_out_reg[7]),
        .Q(mgt_txcharisk[7]),
        .S(txd_out13_out));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT3 #(
    .INIT(8'h28)) 
    \txd_out[56]_i_2 
       (.I0(configuration_vector[0]),
        .I1(configuration_vector[1]),
        .I2(configuration_vector[2]),
        .O(\txd_out_reg[24]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT3 #(
    .INIT(8'h02)) 
    \txd_out[56]_i_3 
       (.I0(configuration_vector[0]),
        .I1(configuration_vector[1]),
        .I2(configuration_vector[2]),
        .O(\txd_out_reg[24]_1 ));
  LUT2 #(
    .INIT(4'h2)) 
    \txd_out[62]_i_5 
       (.I0(configuration_vector[0]),
        .I1(configuration_vector[1]),
        .O(\txd_out_reg[38]_0 ));
  FDRE \txd_out_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[0]),
        .Q(mgt_txdata[0]),
        .R(1'b0));
  FDSE \txd_out_reg[10] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out_reg[2]_6 ),
        .Q(mgt_txdata[18]),
        .S(\state_reg[0][1]_0 ));
  FDRE \txd_out_reg[11] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[6]),
        .Q(mgt_txdata[19]),
        .R(1'b0));
  FDSE \txd_out_reg[12] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out_reg[4]_6 ),
        .Q(mgt_txdata[20]),
        .S(\state_reg[0][1]_0 ));
  FDSE \txd_out_reg[13] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\last_qmsg_reg[13]_0 ),
        .Q(mgt_txdata[21]),
        .S(\state_reg[0][1] ));
  FDRE \txd_out_reg[14] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[7]),
        .Q(mgt_txdata[22]),
        .R(1'b0));
  FDSE \txd_out_reg[15] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\state_reg[0][2]_1 ),
        .Q(mgt_txdata[23]),
        .S(\state_reg[0][0] ));
  FDRE \txd_out_reg[16] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[8]),
        .Q(mgt_txdata[32]),
        .R(1'b0));
  FDRE \txd_out_reg[17] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[9]),
        .Q(mgt_txdata[33]),
        .R(1'b0));
  FDSE \txd_out_reg[18] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out_reg[2]_5 ),
        .Q(mgt_txdata[34]),
        .S(\state_reg[0][1]_0 ));
  FDRE \txd_out_reg[19] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[10]),
        .Q(mgt_txdata[35]),
        .R(1'b0));
  FDRE \txd_out_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[1]),
        .Q(mgt_txdata[1]),
        .R(1'b0));
  FDSE \txd_out_reg[20] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out_reg[4]_5 ),
        .Q(mgt_txdata[36]),
        .S(\state_reg[0][1]_0 ));
  FDSE \txd_out_reg[21] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\state_reg[0][2]_4 ),
        .Q(mgt_txdata[37]),
        .S(\state_reg[0][1] ));
  FDRE \txd_out_reg[22] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[11]),
        .Q(mgt_txdata[38]),
        .R(1'b0));
  FDSE \txd_out_reg[23] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\state_reg[0][2]_0 ),
        .Q(mgt_txdata[39]),
        .S(\state_reg[0][0] ));
  FDRE \txd_out_reg[24] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[12]),
        .Q(mgt_txdata[48]),
        .R(1'b0));
  FDRE \txd_out_reg[25] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[13]),
        .Q(mgt_txdata[49]),
        .R(1'b0));
  FDSE \txd_out_reg[26] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out_reg[2]_4 ),
        .Q(mgt_txdata[50]),
        .S(\state_reg[0][1]_0 ));
  FDRE \txd_out_reg[27] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[14]),
        .Q(mgt_txdata[51]),
        .R(1'b0));
  FDSE \txd_out_reg[28] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out_reg[4]_4 ),
        .Q(mgt_txdata[52]),
        .S(\state_reg[0][1]_0 ));
  FDSE \txd_out_reg[29] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\state_reg[0][2]_3 ),
        .Q(mgt_txdata[53]),
        .S(\state_reg[0][1] ));
  FDSE \txd_out_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out_reg[2]_7 ),
        .Q(mgt_txdata[2]),
        .S(\state_reg[0][1]_0 ));
  FDRE \txd_out_reg[30] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[15]),
        .Q(mgt_txdata[54]),
        .R(1'b0));
  FDSE \txd_out_reg[31] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\state_reg[0][2] ),
        .Q(mgt_txdata[55]),
        .S(\state_reg[0][0] ));
  FDRE \txd_out_reg[32] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[16]),
        .Q(mgt_txdata[8]),
        .R(1'b0));
  FDRE \txd_out_reg[33] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[17]),
        .Q(mgt_txdata[9]),
        .R(1'b0));
  FDSE \txd_out_reg[34] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out_reg[2]_3 ),
        .Q(mgt_txdata[10]),
        .S(\state_reg[1][0] ));
  FDSE \txd_out_reg[35] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out_reg[3]_3 ),
        .Q(mgt_txdata[11]),
        .S(\state_reg[1][0]_0 ));
  FDSE \txd_out_reg[36] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out_reg[4]_3 ),
        .Q(mgt_txdata[12]),
        .S(\state_reg[1][0] ));
  FDSE \txd_out_reg[37] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\last_qmsg_reg[5] ),
        .Q(mgt_txdata[13]),
        .S(\state_reg[1][2]_0 ));
  FDRE \txd_out_reg[38] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[18]),
        .Q(mgt_txdata[14]),
        .R(1'b0));
  FDSE \txd_out_reg[39] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\last_qmsg_reg[7] ),
        .Q(mgt_txdata[15]),
        .S(\state_reg[1][1] ));
  FDRE \txd_out_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[2]),
        .Q(mgt_txdata[3]),
        .R(1'b0));
  FDRE \txd_out_reg[40] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[19]),
        .Q(mgt_txdata[24]),
        .R(1'b0));
  FDRE \txd_out_reg[41] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[20]),
        .Q(mgt_txdata[25]),
        .R(1'b0));
  FDSE \txd_out_reg[42] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out_reg[2]_2 ),
        .Q(mgt_txdata[26]),
        .S(\state_reg[1][0] ));
  FDSE \txd_out_reg[43] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out_reg[3]_2 ),
        .Q(mgt_txdata[27]),
        .S(\state_reg[1][0]_0 ));
  FDSE \txd_out_reg[44] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out_reg[4]_2 ),
        .Q(mgt_txdata[28]),
        .S(\state_reg[1][0] ));
  FDSE \txd_out_reg[45] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\last_qmsg_reg[13] ),
        .Q(mgt_txdata[29]),
        .S(\state_reg[1][2]_0 ));
  FDRE \txd_out_reg[46] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[21]),
        .Q(mgt_txdata[30]),
        .R(1'b0));
  FDSE \txd_out_reg[47] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\last_qmsg_reg[15] ),
        .Q(mgt_txdata[31]),
        .S(\state_reg[1][1] ));
  FDRE \txd_out_reg[48] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[22]),
        .Q(mgt_txdata[40]),
        .R(1'b0));
  FDRE \txd_out_reg[49] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[23]),
        .Q(mgt_txdata[41]),
        .R(1'b0));
  FDSE \txd_out_reg[4] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out_reg[4]_7 ),
        .Q(mgt_txdata[4]),
        .S(\state_reg[0][1]_0 ));
  FDSE \txd_out_reg[50] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out_reg[2]_1 ),
        .Q(mgt_txdata[42]),
        .S(\state_reg[1][0] ));
  FDSE \txd_out_reg[51] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out_reg[3]_1 ),
        .Q(mgt_txdata[43]),
        .S(\state_reg[1][0]_0 ));
  FDSE \txd_out_reg[52] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out_reg[4]_1 ),
        .Q(mgt_txdata[44]),
        .S(\state_reg[1][0] ));
  FDSE \txd_out_reg[53] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\last_qmsg_reg[21] ),
        .Q(mgt_txdata[45]),
        .S(\state_reg[1][2]_0 ));
  FDRE \txd_out_reg[54] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[24]),
        .Q(mgt_txdata[46]),
        .R(1'b0));
  FDSE \txd_out_reg[55] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\last_qmsg_reg[23] ),
        .Q(mgt_txdata[47]),
        .S(\state_reg[1][1] ));
  FDRE \txd_out_reg[56] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[25]),
        .Q(mgt_txdata[56]),
        .R(1'b0));
  FDRE \txd_out_reg[57] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[26]),
        .Q(mgt_txdata[57]),
        .R(1'b0));
  FDSE \txd_out_reg[58] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out_reg[2]_0 ),
        .Q(mgt_txdata[58]),
        .S(\state_reg[1][0] ));
  FDSE \txd_out_reg[59] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out_reg[3]_0 ),
        .Q(mgt_txdata[59]),
        .S(\state_reg[1][0]_0 ));
  FDSE \txd_out_reg[5] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\state_reg[0][2]_5 ),
        .Q(mgt_txdata[5]),
        .S(\state_reg[0][1] ));
  FDSE \txd_out_reg[60] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\txd_out_reg[4]_0 ),
        .Q(mgt_txdata[60]),
        .S(\state_reg[1][0] ));
  FDSE \txd_out_reg[61] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\last_qmsg_reg[29] ),
        .Q(mgt_txdata[61]),
        .S(\state_reg[1][2]_0 ));
  FDRE \txd_out_reg[62] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[27]),
        .Q(mgt_txdata[62]),
        .R(1'b0));
  FDSE \txd_out_reg[63] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\state_reg[1][2] ),
        .Q(mgt_txdata[63]),
        .S(\state_reg[1][1] ));
  FDRE \txd_out_reg[6] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[3]),
        .Q(mgt_txdata[6]),
        .R(1'b0));
  FDSE \txd_out_reg[7] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\state_reg[0][2]_2 ),
        .Q(mgt_txdata[7]),
        .S(\state_reg[0][0] ));
  FDRE \txd_out_reg[8] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[4]),
        .Q(mgt_txdata[16]),
        .R(1'b0));
  FDRE \txd_out_reg[9] 
       (.C(usrclk),
        .CE(1'b1),
        .D(D[5]),
        .Q(mgt_txdata[17]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "tx_state_machine" *) 
module xaui_tx_state_machine
   (next_ifg_is_a_reg_0,
    \state_reg[0][0]_0 ,
    \txc_out_reg[7] ,
    \state_reg[1][0]_0 ,
    \state_reg[0][2]_0 ,
    \txd_out_reg[38] ,
    \count_reg[1] ,
    \count_reg[1]_0 ,
    \prbs_reg[7] ,
    D,
    \txd_out_reg[38]_0 ,
    \count_reg[1]_1 ,
    \txd_out_reg[29] ,
    \txd_out_reg[63] ,
    \txd_out_reg[31] ,
    \txd_out_reg[2] ,
    \txd_out_reg[4] ,
    \txd_out_reg[5] ,
    \txd_out_reg[7] ,
    \txd_out_reg[10] ,
    \txd_out_reg[12] ,
    \txd_out_reg[13] ,
    \txd_out_reg[15] ,
    \txd_out_reg[18] ,
    \txd_out_reg[20] ,
    \txd_out_reg[21] ,
    \txd_out_reg[23] ,
    \txd_out_reg[26] ,
    \txd_out_reg[28] ,
    \txd_out_reg[29]_0 ,
    \txd_out_reg[31]_0 ,
    \txd_out_reg[37] ,
    \txd_out_reg[39] ,
    \txd_out_reg[45] ,
    \txd_out_reg[47] ,
    \txd_out_reg[53] ,
    \txd_out_reg[55] ,
    \txd_out_reg[61] ,
    \txd_out_reg[63]_0 ,
    \txd_out_reg[61]_0 ,
    \txd_out_reg[60] ,
    \txd_out_reg[59] ,
    \txd_out_reg[28]_0 ,
    \txd_out_reg[34] ,
    \txd_out_reg[36] ,
    \txd_out_reg[42] ,
    \txd_out_reg[44] ,
    \txd_out_reg[50] ,
    \txd_out_reg[52] ,
    \txd_out_reg[58] ,
    \txd_out_reg[60]_0 ,
    usrclk_reset,
    usrclk,
    Q,
    \tx_is_idle_reg[1] ,
    \prbs_reg[8] ,
    configuration_vector,
    txc_filtered,
    q_det_reg,
    \count_reg[2] ,
    q_det,
    \count_reg[3] ,
    \count_reg[4] ,
    \count_reg[2]_0 ,
    txd_filtered,
    last_qmsg,
    \configuration_vector[5] ,
    \txd_out_reg[6] ,
    \txd_out_reg[6]_0 ,
    \txd_out_reg[6]_1 ,
    \prbs_reg[2] ,
    data1,
    txd_out13_out,
    \configuration_vector[6] ,
    \configuration_vector[6]_0 ,
    \txd_out_reg[5]_0 ,
    \txd_out_reg[7]_0 ,
    \txd_out_reg[5]_1 ,
    \txd_out_reg[7]_1 ,
    \txd_out_reg[5]_2 ,
    \txd_out_reg[7]_2 ,
    \txd_out_reg[2]_0 ,
    \txd_out_reg[4]_0 ,
    \txd_out_reg[2]_1 ,
    \txd_out_reg[4]_1 ,
    \txd_out_reg[2]_2 ,
    \txd_out_reg[4]_2 ,
    \count_reg[3]_0 ,
    q_det_reg_0,
    \count_reg[3]_1 ,
    \tx_is_q_reg[0] );
  output next_ifg_is_a_reg_0;
  output \state_reg[0][0]_0 ;
  output [7:0]\txc_out_reg[7] ;
  output \state_reg[1][0]_0 ;
  output [0:0]\state_reg[0][2]_0 ;
  output \txd_out_reg[38] ;
  output [0:0]\count_reg[1] ;
  output \count_reg[1]_0 ;
  output \prbs_reg[7] ;
  output [27:0]D;
  output \txd_out_reg[38]_0 ;
  output [1:0]\count_reg[1]_1 ;
  output \txd_out_reg[29] ;
  output \txd_out_reg[63] ;
  output \txd_out_reg[31] ;
  output \txd_out_reg[2] ;
  output \txd_out_reg[4] ;
  output \txd_out_reg[5] ;
  output \txd_out_reg[7] ;
  output \txd_out_reg[10] ;
  output \txd_out_reg[12] ;
  output \txd_out_reg[13] ;
  output \txd_out_reg[15] ;
  output \txd_out_reg[18] ;
  output \txd_out_reg[20] ;
  output \txd_out_reg[21] ;
  output \txd_out_reg[23] ;
  output \txd_out_reg[26] ;
  output \txd_out_reg[28] ;
  output \txd_out_reg[29]_0 ;
  output \txd_out_reg[31]_0 ;
  output \txd_out_reg[37] ;
  output \txd_out_reg[39] ;
  output \txd_out_reg[45] ;
  output \txd_out_reg[47] ;
  output \txd_out_reg[53] ;
  output \txd_out_reg[55] ;
  output \txd_out_reg[61] ;
  output \txd_out_reg[63]_0 ;
  output \txd_out_reg[61]_0 ;
  output \txd_out_reg[60] ;
  output \txd_out_reg[59] ;
  output \txd_out_reg[28]_0 ;
  output \txd_out_reg[34] ;
  output \txd_out_reg[36] ;
  output \txd_out_reg[42] ;
  output \txd_out_reg[44] ;
  output \txd_out_reg[50] ;
  output \txd_out_reg[52] ;
  output \txd_out_reg[58] ;
  output \txd_out_reg[60]_0 ;
  input usrclk_reset;
  input usrclk;
  input [1:0]Q;
  input [1:0]\tx_is_idle_reg[1] ;
  input [1:0]\prbs_reg[8] ;
  input [2:0]configuration_vector;
  input [7:0]txc_filtered;
  input q_det_reg;
  input \count_reg[2] ;
  input q_det;
  input \count_reg[3] ;
  input [3:0]\count_reg[4] ;
  input \count_reg[2]_0 ;
  input [14:0]txd_filtered;
  input [31:0]last_qmsg;
  input \configuration_vector[5] ;
  input [2:0]\txd_out_reg[6] ;
  input [2:0]\txd_out_reg[6]_0 ;
  input [2:0]\txd_out_reg[6]_1 ;
  input [1:0]\prbs_reg[2] ;
  input [23:0]data1;
  input txd_out13_out;
  input \configuration_vector[6] ;
  input \configuration_vector[6]_0 ;
  input \txd_out_reg[5]_0 ;
  input \txd_out_reg[7]_0 ;
  input \txd_out_reg[5]_1 ;
  input \txd_out_reg[7]_1 ;
  input \txd_out_reg[5]_2 ;
  input \txd_out_reg[7]_2 ;
  input \txd_out_reg[2]_0 ;
  input \txd_out_reg[4]_0 ;
  input \txd_out_reg[2]_1 ;
  input \txd_out_reg[4]_1 ;
  input \txd_out_reg[2]_2 ;
  input \txd_out_reg[4]_2 ;
  input \count_reg[3]_0 ;
  input q_det_reg_0;
  input \count_reg[3]_1 ;
  input \tx_is_q_reg[0] ;

  wire [27:0]D;
  wire [1:0]Q;
  wire [2:0]configuration_vector;
  wire \configuration_vector[5] ;
  wire \configuration_vector[6] ;
  wire \configuration_vector[6]_0 ;
  wire [0:0]\count_reg[1] ;
  wire \count_reg[1]_0 ;
  wire [1:0]\count_reg[1]_1 ;
  wire \count_reg[2] ;
  wire \count_reg[2]_0 ;
  wire \count_reg[3] ;
  wire \count_reg[3]_0 ;
  wire \count_reg[3]_1 ;
  wire [3:0]\count_reg[4] ;
  wire [23:0]data1;
  wire [0:0]\get_next_state[1]_0 ;
  wire [31:0]last_qmsg;
  wire next_ifg_is_a_i_1_n_0;
  wire next_ifg_is_a_i_2_n_0;
  wire next_ifg_is_a_i_3_n_0;
  wire next_ifg_is_a_reg_0;
  wire \next_state[1]16_out ;
  wire [1:0]\prbs_reg[2] ;
  wire \prbs_reg[7] ;
  wire [1:0]\prbs_reg[8] ;
  wire q_det;
  wire q_det_reg;
  wire q_det_reg_0;
  wire \state[0][0]_i_1_n_0 ;
  wire \state[0][0]_i_2_n_0 ;
  wire \state[0][1]_i_1_n_0 ;
  wire \state[0][1]_i_2_n_0 ;
  wire \state[0][1]_i_3_n_0 ;
  wire \state[0][1]_i_4_n_0 ;
  wire \state[0][1]_i_5_n_0 ;
  wire \state[0][1]_i_6_n_0 ;
  wire \state[0][1]_i_7_n_0 ;
  wire \state[0][2]_i_1_n_0 ;
  wire \state[1][0]_i_11_n_0 ;
  wire \state[1][0]_i_12_n_0 ;
  wire \state[1][0]_i_14_n_0 ;
  wire \state[1][0]_i_15_n_0 ;
  wire \state[1][0]_i_2_n_0 ;
  wire \state[1][0]_i_3_n_0 ;
  wire \state[1][0]_i_5_n_0 ;
  wire \state[1][0]_i_7_n_0 ;
  wire \state[1][0]_i_8_n_0 ;
  wire \state[1][1]_i_11_n_0 ;
  wire \state[1][1]_i_1_n_0 ;
  wire \state[1][1]_i_2_n_0 ;
  wire \state[1][1]_i_3_n_0 ;
  wire \state[1][1]_i_4_n_0 ;
  wire \state[1][1]_i_5_n_0 ;
  wire \state[1][1]_i_7_n_0 ;
  wire \state[1][1]_i_8_n_0 ;
  wire \state[1][1]_i_9_n_0 ;
  wire \state[1][2]_i_1_n_0 ;
  wire \state_reg[0][0]_0 ;
  wire [0:0]\state_reg[0][2]_0 ;
  wire \state_reg[1][0]_0 ;
  wire \state_reg_n_0_[0][2] ;
  wire \state_reg_n_0_[1][2] ;
  wire [1:0]\tx_is_idle_reg[1] ;
  wire \tx_is_q_reg[0] ;
  wire [7:0]txc_filtered;
  wire \txc_out[3]_i_2_n_0 ;
  wire \txc_out[7]_i_3_n_0 ;
  wire [7:0]\txc_out_reg[7] ;
  wire [14:0]txd_filtered;
  wire txd_out13_out;
  wire \txd_out[27]_i_2_n_0 ;
  wire \txd_out[30]_i_2_n_0 ;
  wire \txd_out[30]_i_3_n_0 ;
  wire \txd_out[30]_i_4_n_0 ;
  wire \txd_out[62]_i_3_n_0 ;
  wire \txd_out_reg[10] ;
  wire \txd_out_reg[12] ;
  wire \txd_out_reg[13] ;
  wire \txd_out_reg[15] ;
  wire \txd_out_reg[18] ;
  wire \txd_out_reg[20] ;
  wire \txd_out_reg[21] ;
  wire \txd_out_reg[23] ;
  wire \txd_out_reg[26] ;
  wire \txd_out_reg[28] ;
  wire \txd_out_reg[28]_0 ;
  wire \txd_out_reg[29] ;
  wire \txd_out_reg[29]_0 ;
  wire \txd_out_reg[2] ;
  wire \txd_out_reg[2]_0 ;
  wire \txd_out_reg[2]_1 ;
  wire \txd_out_reg[2]_2 ;
  wire \txd_out_reg[31] ;
  wire \txd_out_reg[31]_0 ;
  wire \txd_out_reg[34] ;
  wire \txd_out_reg[36] ;
  wire \txd_out_reg[37] ;
  wire \txd_out_reg[38] ;
  wire \txd_out_reg[38]_0 ;
  wire \txd_out_reg[39] ;
  wire \txd_out_reg[42] ;
  wire \txd_out_reg[44] ;
  wire \txd_out_reg[45] ;
  wire \txd_out_reg[47] ;
  wire \txd_out_reg[4] ;
  wire \txd_out_reg[4]_0 ;
  wire \txd_out_reg[4]_1 ;
  wire \txd_out_reg[4]_2 ;
  wire \txd_out_reg[50] ;
  wire \txd_out_reg[52] ;
  wire \txd_out_reg[53] ;
  wire \txd_out_reg[55] ;
  wire \txd_out_reg[58] ;
  wire \txd_out_reg[59] ;
  wire \txd_out_reg[5] ;
  wire \txd_out_reg[5]_0 ;
  wire \txd_out_reg[5]_1 ;
  wire \txd_out_reg[5]_2 ;
  wire \txd_out_reg[60] ;
  wire \txd_out_reg[60]_0 ;
  wire \txd_out_reg[61] ;
  wire \txd_out_reg[61]_0 ;
  wire \txd_out_reg[63] ;
  wire \txd_out_reg[63]_0 ;
  wire [2:0]\txd_out_reg[6] ;
  wire [2:0]\txd_out_reg[6]_0 ;
  wire [2:0]\txd_out_reg[6]_1 ;
  wire \txd_out_reg[7] ;
  wire \txd_out_reg[7]_0 ;
  wire \txd_out_reg[7]_1 ;
  wire \txd_out_reg[7]_2 ;
  wire usrclk;
  wire usrclk_reset;

  LUT6 #(
    .INIT(64'hEFAAEFEF20AA2020)) 
    \count[0]_i_1 
       (.I0(\prbs_reg[2] [0]),
        .I1(\count_reg[1] ),
        .I2(\count_reg[1]_0 ),
        .I3(\state_reg[0][2]_0 ),
        .I4(\state_reg[0][0]_0 ),
        .I5(\count_reg[4] [0]),
        .O(\count_reg[1]_1 [0]));
  LUT6 #(
    .INIT(64'h20AA2020EFAAEFEF)) 
    \count[1]_i_1 
       (.I0(\prbs_reg[2] [1]),
        .I1(\count_reg[1] ),
        .I2(\count_reg[1]_0 ),
        .I3(\state_reg[0][2]_0 ),
        .I4(\state_reg[0][0]_0 ),
        .I5(\count_reg[4] [1]),
        .O(\count_reg[1]_1 [1]));
  LUT3 #(
    .INIT(8'h32)) 
    next_ifg_is_a_i_1
       (.I0(next_ifg_is_a_i_2_n_0),
        .I1(next_ifg_is_a_i_3_n_0),
        .I2(next_ifg_is_a_reg_0),
        .O(next_ifg_is_a_i_1_n_0));
  LUT6 #(
    .INIT(64'h01010101010101FF)) 
    next_ifg_is_a_i_2
       (.I0(\state_reg_n_0_[0][2] ),
        .I1(\count_reg[1]_0 ),
        .I2(\count_reg[1] ),
        .I3(\state_reg[0][2]_0 ),
        .I4(\state_reg_n_0_[1][2] ),
        .I5(\state_reg[0][0]_0 ),
        .O(next_ifg_is_a_i_2_n_0));
  LUT6 #(
    .INIT(64'h0404040404FF0404)) 
    next_ifg_is_a_i_3
       (.I0(\state_reg_n_0_[0][2] ),
        .I1(\count_reg[1]_0 ),
        .I2(\count_reg[1] ),
        .I3(\state_reg_n_0_[1][2] ),
        .I4(\state_reg[0][0]_0 ),
        .I5(\state_reg[0][2]_0 ),
        .O(next_ifg_is_a_i_3_n_0));
  FDSE next_ifg_is_a_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(next_ifg_is_a_i_1_n_0),
        .Q(next_ifg_is_a_reg_0),
        .S(usrclk_reset));
  LUT4 #(
    .INIT(16'h4F44)) 
    \prbs[7]_i_1 
       (.I0(\count_reg[1] ),
        .I1(\count_reg[1]_0 ),
        .I2(\state_reg[0][2]_0 ),
        .I3(\state_reg[0][0]_0 ),
        .O(\prbs_reg[7] ));
  LUT6 #(
    .INIT(64'hFFFFFFFFAAAAFEAA)) 
    \state[0][0]_i_1 
       (.I0(\state[0][0]_i_2_n_0 ),
        .I1(\count_reg[3]_1 ),
        .I2(\state_reg[0][0]_0 ),
        .I3(\state_reg_n_0_[1][2] ),
        .I4(\prbs_reg[8] [1]),
        .I5(\next_state[1]16_out ),
        .O(\state[0][0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT5 #(
    .INIT(32'h0C040C00)) 
    \state[0][0]_i_2 
       (.I0(\state_reg_n_0_[1][2] ),
        .I1(\state_reg[0][0]_0 ),
        .I2(\state_reg[0][2]_0 ),
        .I3(q_det),
        .I4(Q[0]),
        .O(\state[0][0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FEFEFFFE)) 
    \state[0][1]_i_1 
       (.I0(\state[0][1]_i_2_n_0 ),
        .I1(\state[0][1]_i_3_n_0 ),
        .I2(\state[0][1]_i_4_n_0 ),
        .I3(\state[0][1]_i_5_n_0 ),
        .I4(\count_reg[3]_1 ),
        .I5(\state[0][1]_i_6_n_0 ),
        .O(\state[0][1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0002000000000000)) 
    \state[0][1]_i_2 
       (.I0(next_ifg_is_a_reg_0),
        .I1(\count_reg[2] ),
        .I2(\prbs_reg[7] ),
        .I3(\count_reg[3] ),
        .I4(\state_reg[0][2]_0 ),
        .I5(\state[0][1]_i_7_n_0 ),
        .O(\state[0][1]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h4000)) 
    \state[0][1]_i_3 
       (.I0(\state_reg[0][2]_0 ),
        .I1(q_det),
        .I2(\state_reg[0][0]_0 ),
        .I3(\state_reg_n_0_[1][2] ),
        .O(\state[0][1]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair75" *) 
  LUT5 #(
    .INIT(32'h00000E00)) 
    \state[0][1]_i_4 
       (.I0(Q[0]),
        .I1(q_det),
        .I2(\state_reg[0][2]_0 ),
        .I3(\state_reg[0][0]_0 ),
        .I4(\state_reg_n_0_[1][2] ),
        .O(\state[0][1]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair74" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \state[0][1]_i_5 
       (.I0(\state_reg_n_0_[1][2] ),
        .I1(\state_reg[0][0]_0 ),
        .O(\state[0][1]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'hAB)) 
    \state[0][1]_i_6 
       (.I0(usrclk_reset),
        .I1(\tx_is_idle_reg[1] [0]),
        .I2(Q[0]),
        .O(\state[0][1]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \state[0][1]_i_7 
       (.I0(\state_reg_n_0_[1][2] ),
        .I1(\state_reg[0][0]_0 ),
        .O(\state[0][1]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h000000000000FCEF)) 
    \state[0][2]_i_1 
       (.I0(\tx_is_q_reg[0] ),
        .I1(\state_reg_n_0_[1][2] ),
        .I2(\state_reg[0][0]_0 ),
        .I3(\state_reg[0][2]_0 ),
        .I4(\next_state[1]16_out ),
        .I5(usrclk_reset),
        .O(\state[0][2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF000000FD)) 
    \state[1][0]_i_1 
       (.I0(\state[1][0]_i_2_n_0 ),
        .I1(\state[1][0]_i_3_n_0 ),
        .I2(q_det_reg),
        .I3(\state[1][0]_i_5_n_0 ),
        .I4(\next_state[1]16_out ),
        .I5(\state[1][0]_i_7_n_0 ),
        .O(\get_next_state[1]_0 ));
  LUT6 #(
    .INIT(64'h000000000000DD0D)) 
    \state[1][0]_i_11 
       (.I0(\state_reg[0][0]_0 ),
        .I1(\state_reg[0][2]_0 ),
        .I2(\count_reg[1]_0 ),
        .I3(\count_reg[1] ),
        .I4(\count_reg[4] [3]),
        .I5(\count_reg[4] [2]),
        .O(\state[1][0]_i_11_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair75" *) 
  LUT4 #(
    .INIT(16'h0FE0)) 
    \state[1][0]_i_12 
       (.I0(Q[0]),
        .I1(q_det),
        .I2(\state_reg[0][0]_0 ),
        .I3(\state_reg[0][2]_0 ),
        .O(\state[1][0]_i_12_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair68" *) 
  LUT3 #(
    .INIT(8'h8F)) 
    \state[1][0]_i_13 
       (.I0(\state_reg[0][2]_0 ),
        .I1(\state_reg[0][0]_0 ),
        .I2(\state_reg_n_0_[1][2] ),
        .O(\state_reg[1][0]_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \state[1][0]_i_14 
       (.I0(Q[1]),
        .I1(\tx_is_idle_reg[1] [1]),
        .O(\state[1][0]_i_14_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair77" *) 
  LUT5 #(
    .INIT(32'hF1FFFFFF)) 
    \state[1][0]_i_15 
       (.I0(Q[0]),
        .I1(\tx_is_idle_reg[1] [0]),
        .I2(\prbs_reg[8] [0]),
        .I3(\state_reg[0][0]_0 ),
        .I4(\state_reg_n_0_[1][2] ),
        .O(\state[1][0]_i_15_n_0 ));
  LUT6 #(
    .INIT(64'hFCFFFFFFFDFFFFFF)) 
    \state[1][0]_i_2 
       (.I0(Q[1]),
        .I1(\state[1][0]_i_8_n_0 ),
        .I2(\count_reg[2] ),
        .I3(next_ifg_is_a_reg_0),
        .I4(\txd_out_reg[38] ),
        .I5(q_det),
        .O(\state[1][0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000505551555155)) 
    \state[1][0]_i_3 
       (.I0(\prbs_reg[8] [0]),
        .I1(\count_reg[2] ),
        .I2(\count_reg[2]_0 ),
        .I3(\state[1][0]_i_11_n_0 ),
        .I4(\state[1][0]_i_12_n_0 ),
        .I5(\state_reg[1][0]_0 ),
        .O(\state[1][0]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair73" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \state[1][0]_i_5 
       (.I0(\state_reg_n_0_[1][2] ),
        .I1(\state_reg[0][0]_0 ),
        .O(\state[1][0]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair77" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \state[1][0]_i_6 
       (.I0(Q[0]),
        .I1(\tx_is_idle_reg[1] [0]),
        .O(\next_state[1]16_out ));
  LUT6 #(
    .INIT(64'hBBBBABAABBBBBBBB)) 
    \state[1][0]_i_7 
       (.I0(\state[1][0]_i_14_n_0 ),
        .I1(\state[1][0]_i_15_n_0 ),
        .I2(\state_reg[1][0]_0 ),
        .I3(q_det),
        .I4(\count_reg[2]_0 ),
        .I5(\state[1][0]_i_11_n_0 ),
        .O(\state[1][0]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF22F2)) 
    \state[1][0]_i_8 
       (.I0(\state_reg[0][0]_0 ),
        .I1(\state_reg[0][2]_0 ),
        .I2(\count_reg[1]_0 ),
        .I3(\count_reg[1] ),
        .I4(\count_reg[4] [3]),
        .I5(\count_reg[4] [2]),
        .O(\state[1][0]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h00000000F777F7F7)) 
    \state[1][1]_i_1 
       (.I0(\state[1][1]_i_2_n_0 ),
        .I1(\state[1][1]_i_3_n_0 ),
        .I2(\state[1][1]_i_4_n_0 ),
        .I3(\state[1][1]_i_5_n_0 ),
        .I4(q_det_reg_0),
        .I5(\state[1][1]_i_7_n_0 ),
        .O(\state[1][1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \state[1][1]_i_11 
       (.I0(\state_reg[0][2]_0 ),
        .I1(\state_reg[0][0]_0 ),
        .O(\state[1][1]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'hFFFBFFFFFFFFFFFF)) 
    \state[1][1]_i_2 
       (.I0(\next_state[1]16_out ),
        .I1(Q[1]),
        .I2(\state[1][0]_i_8_n_0 ),
        .I3(\count_reg[2] ),
        .I4(next_ifg_is_a_reg_0),
        .I5(\txd_out_reg[38] ),
        .O(\state[1][1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF7770FFFF)) 
    \state[1][1]_i_3 
       (.I0(next_ifg_is_a_reg_0),
        .I1(\next_state[1]16_out ),
        .I2(\state[1][1]_i_8_n_0 ),
        .I3(\state[1][1]_i_9_n_0 ),
        .I4(\state[1][0]_i_11_n_0 ),
        .I5(\count_reg[2]_0 ),
        .O(\state[1][1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h7770777077700000)) 
    \state[1][1]_i_4 
       (.I0(\state_reg[0][0]_0 ),
        .I1(\state_reg_n_0_[1][2] ),
        .I2(Q[1]),
        .I3(\tx_is_idle_reg[1] [1]),
        .I4(Q[0]),
        .I5(\tx_is_idle_reg[1] [0]),
        .O(\state[1][1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0100000000000000)) 
    \state[1][1]_i_5 
       (.I0(\count_reg[3] ),
        .I1(\prbs_reg[7] ),
        .I2(\count_reg[2] ),
        .I3(next_ifg_is_a_reg_0),
        .I4(\state[1][1]_i_11_n_0 ),
        .I5(q_det),
        .O(\state[1][1]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair76" *) 
  LUT5 #(
    .INIT(32'hAAAAAAAB)) 
    \state[1][1]_i_7 
       (.I0(usrclk_reset),
        .I1(Q[1]),
        .I2(\tx_is_idle_reg[1] [1]),
        .I3(Q[0]),
        .I4(\tx_is_idle_reg[1] [0]),
        .O(\state[1][1]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair76" *) 
  LUT4 #(
    .INIT(16'h111F)) 
    \state[1][1]_i_8 
       (.I0(\tx_is_idle_reg[1] [0]),
        .I1(Q[0]),
        .I2(\tx_is_idle_reg[1] [1]),
        .I3(Q[1]),
        .O(\state[1][1]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT5 #(
    .INIT(32'h00FFFEF0)) 
    \state[1][1]_i_9 
       (.I0(q_det),
        .I1(Q[0]),
        .I2(\state_reg_n_0_[1][2] ),
        .I3(\state_reg[0][0]_0 ),
        .I4(\state_reg[0][2]_0 ),
        .O(\state[1][1]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h000000000000E0E2)) 
    \state[1][2]_i_1 
       (.I0(\tx_is_idle_reg[1] [1]),
        .I1(Q[1]),
        .I2(\count_reg[3]_0 ),
        .I3(q_det),
        .I4(\next_state[1]16_out ),
        .I5(usrclk_reset),
        .O(\state[1][2]_i_1_n_0 ));
  (* FSM_ENCODING = "one-hot" *) 
  FDRE \state_reg[0][0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\state[0][0]_i_1_n_0 ),
        .Q(\count_reg[1] ),
        .R(usrclk_reset));
  (* FSM_ENCODING = "one-hot" *) 
  FDRE \state_reg[0][1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\state[0][1]_i_1_n_0 ),
        .Q(\count_reg[1]_0 ),
        .R(1'b0));
  (* FSM_ENCODING = "one-hot" *) 
  FDRE \state_reg[0][2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\state[0][2]_i_1_n_0 ),
        .Q(\state_reg_n_0_[0][2] ),
        .R(1'b0));
  (* FSM_ENCODING = "one-hot" *) 
  FDRE \state_reg[1][0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\get_next_state[1]_0 ),
        .Q(\state_reg[0][2]_0 ),
        .R(usrclk_reset));
  (* FSM_ENCODING = "one-hot" *) 
  FDRE \state_reg[1][1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\state[1][1]_i_1_n_0 ),
        .Q(\state_reg[0][0]_0 ),
        .R(1'b0));
  (* FSM_ENCODING = "one-hot" *) 
  FDRE \state_reg[1][2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(\state[1][2]_i_1_n_0 ),
        .Q(\state_reg_n_0_[1][2] ),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hEFEF20EF)) 
    \txc_out[0]_i_1 
       (.I0(configuration_vector[2]),
        .I1(configuration_vector[1]),
        .I2(configuration_vector[0]),
        .I3(\txd_out[30]_i_2_n_0 ),
        .I4(txc_filtered[0]),
        .O(\txc_out_reg[7] [0]));
  LUT6 #(
    .INIT(64'hFEFFAAAAAAAAAAAA)) 
    \txc_out[1]_i_1 
       (.I0(\txc_out[3]_i_2_n_0 ),
        .I1(configuration_vector[2]),
        .I2(configuration_vector[1]),
        .I3(configuration_vector[0]),
        .I4(\txd_out[30]_i_2_n_0 ),
        .I5(txc_filtered[1]),
        .O(\txc_out_reg[7] [1]));
  LUT6 #(
    .INIT(64'hFEFFAAAAAAAAAAAA)) 
    \txc_out[2]_i_1 
       (.I0(\txc_out[3]_i_2_n_0 ),
        .I1(configuration_vector[2]),
        .I2(configuration_vector[1]),
        .I3(configuration_vector[0]),
        .I4(\txd_out[30]_i_2_n_0 ),
        .I5(txc_filtered[2]),
        .O(\txc_out_reg[7] [2]));
  LUT6 #(
    .INIT(64'hFEFFAAAAAAAAAAAA)) 
    \txc_out[3]_i_1 
       (.I0(\txc_out[3]_i_2_n_0 ),
        .I1(configuration_vector[2]),
        .I2(configuration_vector[1]),
        .I3(configuration_vector[0]),
        .I4(\txd_out[30]_i_2_n_0 ),
        .I5(txc_filtered[3]),
        .O(\txc_out_reg[7] [3]));
  LUT6 #(
    .INIT(64'h5D5DFF005D5D5D5D)) 
    \txc_out[3]_i_2 
       (.I0(\count_reg[1] ),
        .I1(\state_reg_n_0_[0][2] ),
        .I2(\count_reg[1]_0 ),
        .I3(configuration_vector[2]),
        .I4(configuration_vector[1]),
        .I5(configuration_vector[0]),
        .O(\txc_out[3]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hEFEF20EF)) 
    \txc_out[4]_i_1 
       (.I0(configuration_vector[2]),
        .I1(configuration_vector[1]),
        .I2(configuration_vector[0]),
        .I3(\txd_out_reg[38] ),
        .I4(txc_filtered[4]),
        .O(\txc_out_reg[7] [4]));
  LUT6 #(
    .INIT(64'hFEFFAAAAAAAAAAAA)) 
    \txc_out[5]_i_1 
       (.I0(\txc_out[7]_i_3_n_0 ),
        .I1(configuration_vector[2]),
        .I2(configuration_vector[1]),
        .I3(configuration_vector[0]),
        .I4(\txd_out_reg[38] ),
        .I5(txc_filtered[5]),
        .O(\txc_out_reg[7] [5]));
  LUT6 #(
    .INIT(64'hFEFFAAAAAAAAAAAA)) 
    \txc_out[6]_i_1 
       (.I0(\txc_out[7]_i_3_n_0 ),
        .I1(configuration_vector[2]),
        .I2(configuration_vector[1]),
        .I3(configuration_vector[0]),
        .I4(\txd_out_reg[38] ),
        .I5(txc_filtered[6]),
        .O(\txc_out_reg[7] [6]));
  LUT6 #(
    .INIT(64'hFEFFAAAAAAAAAAAA)) 
    \txc_out[7]_i_2 
       (.I0(\txc_out[7]_i_3_n_0 ),
        .I1(configuration_vector[2]),
        .I2(configuration_vector[1]),
        .I3(configuration_vector[0]),
        .I4(\txd_out_reg[38] ),
        .I5(txc_filtered[7]),
        .O(\txc_out_reg[7] [7]));
  LUT6 #(
    .INIT(64'h4F4FFF004F4F4F4F)) 
    \txc_out[7]_i_3 
       (.I0(\state_reg[0][0]_0 ),
        .I1(\state_reg_n_0_[1][2] ),
        .I2(\state_reg[0][2]_0 ),
        .I3(configuration_vector[2]),
        .I4(configuration_vector[1]),
        .I5(configuration_vector[0]),
        .O(\txc_out[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0000F444)) 
    \txd_out[0]_i_1 
       (.I0(\txd_out[30]_i_4_n_0 ),
        .I1(last_qmsg[0]),
        .I2(txd_filtered[0]),
        .I3(\txd_out[30]_i_2_n_0 ),
        .I4(\configuration_vector[6] ),
        .I5(\configuration_vector[6]_0 ),
        .O(D[0]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \txd_out[10]_i_1 
       (.I0(data1[2]),
        .I1(\count_reg[1] ),
        .I2(\count_reg[1]_0 ),
        .I3(\state_reg_n_0_[0][2] ),
        .I4(last_qmsg[10]),
        .O(\txd_out_reg[10] ));
  LUT5 #(
    .INIT(32'hFFFF00AC)) 
    \txd_out[11]_i_1 
       (.I0(data1[3]),
        .I1(last_qmsg[11]),
        .I2(\txd_out[30]_i_2_n_0 ),
        .I3(\configuration_vector[6]_0 ),
        .I4(\txd_out[27]_i_2_n_0 ),
        .O(D[6]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \txd_out[12]_i_1 
       (.I0(data1[4]),
        .I1(\count_reg[1] ),
        .I2(\count_reg[1]_0 ),
        .I3(\state_reg_n_0_[0][2] ),
        .I4(last_qmsg[12]),
        .O(\txd_out_reg[12] ));
  LUT5 #(
    .INIT(32'h808C8080)) 
    \txd_out[13]_i_1 
       (.I0(last_qmsg[13]),
        .I1(\count_reg[1] ),
        .I2(\count_reg[1]_0 ),
        .I3(\state_reg_n_0_[0][2] ),
        .I4(data1[5]),
        .O(\txd_out_reg[13] ));
  LUT6 #(
    .INIT(64'hFFFFFFFF008800F8)) 
    \txd_out[14]_i_1 
       (.I0(\txd_out[30]_i_2_n_0 ),
        .I1(data1[6]),
        .I2(last_qmsg[14]),
        .I3(\configuration_vector[5] ),
        .I4(\txd_out[30]_i_4_n_0 ),
        .I5(\txd_out[30]_i_3_n_0 ),
        .O(D[7]));
  LUT5 #(
    .INIT(32'hF4000400)) 
    \txd_out[15]_i_1 
       (.I0(\state_reg_n_0_[0][2] ),
        .I1(data1[7]),
        .I2(\count_reg[1]_0 ),
        .I3(\count_reg[1] ),
        .I4(last_qmsg[15]),
        .O(\txd_out_reg[15] ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0000F444)) 
    \txd_out[16]_i_1 
       (.I0(\txd_out[30]_i_4_n_0 ),
        .I1(last_qmsg[16]),
        .I2(data1[8]),
        .I3(\txd_out[30]_i_2_n_0 ),
        .I4(\configuration_vector[6] ),
        .I5(\configuration_vector[6]_0 ),
        .O(D[8]));
  LUT6 #(
    .INIT(64'h000F000400040004)) 
    \txd_out[17]_i_1 
       (.I0(\txd_out[30]_i_4_n_0 ),
        .I1(last_qmsg[17]),
        .I2(\configuration_vector[5] ),
        .I3(txd_out13_out),
        .I4(\txd_out[30]_i_2_n_0 ),
        .I5(data1[9]),
        .O(D[9]));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \txd_out[18]_i_1 
       (.I0(data1[10]),
        .I1(\count_reg[1] ),
        .I2(\count_reg[1]_0 ),
        .I3(\state_reg_n_0_[0][2] ),
        .I4(last_qmsg[18]),
        .O(\txd_out_reg[18] ));
  LUT5 #(
    .INIT(32'hFFFF00CA)) 
    \txd_out[19]_i_1 
       (.I0(last_qmsg[19]),
        .I1(data1[11]),
        .I2(\txd_out[30]_i_2_n_0 ),
        .I3(\configuration_vector[6]_0 ),
        .I4(\txd_out[27]_i_2_n_0 ),
        .O(D[10]));
  LUT6 #(
    .INIT(64'h000F000400040004)) 
    \txd_out[1]_i_1 
       (.I0(\txd_out[30]_i_4_n_0 ),
        .I1(last_qmsg[1]),
        .I2(\configuration_vector[5] ),
        .I3(txd_out13_out),
        .I4(\txd_out[30]_i_2_n_0 ),
        .I5(txd_filtered[1]),
        .O(D[1]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \txd_out[20]_i_1 
       (.I0(data1[12]),
        .I1(\count_reg[1] ),
        .I2(\count_reg[1]_0 ),
        .I3(\state_reg_n_0_[0][2] ),
        .I4(last_qmsg[20]),
        .O(\txd_out_reg[20] ));
  LUT5 #(
    .INIT(32'hF4000400)) 
    \txd_out[21]_i_1 
       (.I0(\state_reg_n_0_[0][2] ),
        .I1(data1[13]),
        .I2(\count_reg[1]_0 ),
        .I3(\count_reg[1] ),
        .I4(last_qmsg[21]),
        .O(\txd_out_reg[21] ));
  LUT6 #(
    .INIT(64'hFFFFFFFF008800F8)) 
    \txd_out[22]_i_1 
       (.I0(\txd_out[30]_i_2_n_0 ),
        .I1(data1[14]),
        .I2(last_qmsg[22]),
        .I3(\configuration_vector[5] ),
        .I4(\txd_out[30]_i_4_n_0 ),
        .I5(\txd_out[30]_i_3_n_0 ),
        .O(D[11]));
  LUT5 #(
    .INIT(32'hF4000400)) 
    \txd_out[23]_i_1 
       (.I0(\state_reg_n_0_[0][2] ),
        .I1(data1[15]),
        .I2(\count_reg[1]_0 ),
        .I3(\count_reg[1] ),
        .I4(last_qmsg[23]),
        .O(\txd_out_reg[23] ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0000F444)) 
    \txd_out[24]_i_1 
       (.I0(\txd_out[30]_i_4_n_0 ),
        .I1(last_qmsg[24]),
        .I2(data1[16]),
        .I3(\txd_out[30]_i_2_n_0 ),
        .I4(\configuration_vector[6] ),
        .I5(\configuration_vector[6]_0 ),
        .O(D[12]));
  LUT6 #(
    .INIT(64'h000F000400040004)) 
    \txd_out[25]_i_1 
       (.I0(\txd_out[30]_i_4_n_0 ),
        .I1(last_qmsg[25]),
        .I2(\configuration_vector[5] ),
        .I3(txd_out13_out),
        .I4(\txd_out[30]_i_2_n_0 ),
        .I5(data1[17]),
        .O(D[13]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \txd_out[26]_i_1 
       (.I0(data1[18]),
        .I1(\count_reg[1] ),
        .I2(\count_reg[1]_0 ),
        .I3(\state_reg_n_0_[0][2] ),
        .I4(last_qmsg[26]),
        .O(\txd_out_reg[26] ));
  LUT5 #(
    .INIT(32'hCCCCFCEE)) 
    \txd_out[27]_i_1 
       (.I0(last_qmsg[27]),
        .I1(\txd_out[27]_i_2_n_0 ),
        .I2(data1[19]),
        .I3(\txd_out[30]_i_2_n_0 ),
        .I4(\configuration_vector[6]_0 ),
        .O(D[14]));
  LUT6 #(
    .INIT(64'h28FD2828FDFDFDFD)) 
    \txd_out[27]_i_2 
       (.I0(configuration_vector[0]),
        .I1(configuration_vector[1]),
        .I2(configuration_vector[2]),
        .I3(\count_reg[1]_0 ),
        .I4(\state_reg_n_0_[0][2] ),
        .I5(\count_reg[1] ),
        .O(\txd_out[27]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h2AFF2A2AFFFFFFFF)) 
    \txd_out[28]_i_1 
       (.I0(configuration_vector[0]),
        .I1(configuration_vector[1]),
        .I2(configuration_vector[2]),
        .I3(\count_reg[1]_0 ),
        .I4(\state_reg_n_0_[0][2] ),
        .I5(\count_reg[1] ),
        .O(\txd_out_reg[28]_0 ));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \txd_out[28]_i_2 
       (.I0(data1[20]),
        .I1(\count_reg[1] ),
        .I2(\count_reg[1]_0 ),
        .I3(\state_reg_n_0_[0][2] ),
        .I4(last_qmsg[28]),
        .O(\txd_out_reg[28] ));
  LUT6 #(
    .INIT(64'h2AFF2A2AFF2AFFFF)) 
    \txd_out[29]_i_1 
       (.I0(configuration_vector[0]),
        .I1(configuration_vector[1]),
        .I2(configuration_vector[2]),
        .I3(\count_reg[1]_0 ),
        .I4(\state_reg_n_0_[0][2] ),
        .I5(\count_reg[1] ),
        .O(\txd_out_reg[29] ));
  LUT5 #(
    .INIT(32'hF4000400)) 
    \txd_out[29]_i_2 
       (.I0(\state_reg_n_0_[0][2] ),
        .I1(data1[21]),
        .I2(\count_reg[1]_0 ),
        .I3(\count_reg[1] ),
        .I4(last_qmsg[29]),
        .O(\txd_out_reg[29]_0 ));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \txd_out[2]_i_1 
       (.I0(txd_filtered[2]),
        .I1(\count_reg[1] ),
        .I2(\count_reg[1]_0 ),
        .I3(\state_reg_n_0_[0][2] ),
        .I4(last_qmsg[2]),
        .O(\txd_out_reg[2] ));
  LUT6 #(
    .INIT(64'hF0F0F8F8F0F0FFF8)) 
    \txd_out[30]_i_1 
       (.I0(\txd_out[30]_i_2_n_0 ),
        .I1(data1[22]),
        .I2(\txd_out[30]_i_3_n_0 ),
        .I3(last_qmsg[30]),
        .I4(\configuration_vector[5] ),
        .I5(\txd_out[30]_i_4_n_0 ),
        .O(D[15]));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT3 #(
    .INIT(8'h02)) 
    \txd_out[30]_i_2 
       (.I0(\count_reg[1] ),
        .I1(\count_reg[1]_0 ),
        .I2(\state_reg_n_0_[0][2] ),
        .O(\txd_out[30]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT5 #(
    .INIT(32'h4040F340)) 
    \txd_out[30]_i_3 
       (.I0(configuration_vector[2]),
        .I1(configuration_vector[0]),
        .I2(configuration_vector[1]),
        .I3(\count_reg[1]_0 ),
        .I4(\count_reg[1] ),
        .O(\txd_out[30]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \txd_out[30]_i_4 
       (.I0(\count_reg[1]_0 ),
        .I1(\count_reg[1] ),
        .O(\txd_out[30]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h2A2A2A2AFF2A2AFF)) 
    \txd_out[31]_i_1 
       (.I0(configuration_vector[0]),
        .I1(configuration_vector[1]),
        .I2(configuration_vector[2]),
        .I3(\count_reg[1] ),
        .I4(\state_reg_n_0_[0][2] ),
        .I5(\count_reg[1]_0 ),
        .O(\txd_out_reg[31] ));
  LUT5 #(
    .INIT(32'hF4000400)) 
    \txd_out[31]_i_2 
       (.I0(\state_reg_n_0_[0][2] ),
        .I1(data1[23]),
        .I2(\count_reg[1]_0 ),
        .I3(\count_reg[1] ),
        .I4(last_qmsg[31]),
        .O(\txd_out_reg[31]_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0000F888)) 
    \txd_out[32]_i_1 
       (.I0(\txd_out_reg[38]_0 ),
        .I1(last_qmsg[0]),
        .I2(txd_filtered[8]),
        .I3(\txd_out_reg[38] ),
        .I4(\configuration_vector[6] ),
        .I5(\configuration_vector[6]_0 ),
        .O(D[16]));
  LUT6 #(
    .INIT(64'h000F000800080008)) 
    \txd_out[33]_i_1 
       (.I0(\txd_out_reg[38]_0 ),
        .I1(last_qmsg[1]),
        .I2(\configuration_vector[5] ),
        .I3(txd_out13_out),
        .I4(\txd_out_reg[38] ),
        .I5(txd_filtered[9]),
        .O(D[17]));
  LUT5 #(
    .INIT(32'hFFEF0020)) 
    \txd_out[34]_i_1 
       (.I0(txd_filtered[10]),
        .I1(\state_reg[0][0]_0 ),
        .I2(\state_reg[0][2]_0 ),
        .I3(\state_reg_n_0_[1][2] ),
        .I4(last_qmsg[2]),
        .O(\txd_out_reg[34] ));
  LUT5 #(
    .INIT(32'hFFEF0020)) 
    \txd_out[36]_i_1 
       (.I0(txd_filtered[11]),
        .I1(\state_reg[0][0]_0 ),
        .I2(\state_reg[0][2]_0 ),
        .I3(\state_reg_n_0_[1][2] ),
        .I4(last_qmsg[4]),
        .O(\txd_out_reg[36] ));
  (* SOFT_HLUTNM = "soft_lutpair68" *) 
  LUT5 #(
    .INIT(32'h80B08080)) 
    \txd_out[37]_i_1 
       (.I0(last_qmsg[5]),
        .I1(\state_reg[0][0]_0 ),
        .I2(\state_reg[0][2]_0 ),
        .I3(\state_reg_n_0_[1][2] ),
        .I4(txd_filtered[12]),
        .O(\txd_out_reg[37] ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0000F888)) 
    \txd_out[38]_i_1 
       (.I0(\txd_out_reg[38] ),
        .I1(txd_filtered[13]),
        .I2(last_qmsg[6]),
        .I3(\txd_out_reg[38]_0 ),
        .I4(\configuration_vector[5] ),
        .I5(\txd_out[62]_i_3_n_0 ),
        .O(D[18]));
  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT5 #(
    .INIT(32'h80B08080)) 
    \txd_out[39]_i_1 
       (.I0(last_qmsg[7]),
        .I1(\state_reg[0][0]_0 ),
        .I2(\state_reg[0][2]_0 ),
        .I3(\state_reg_n_0_[1][2] ),
        .I4(txd_filtered[14]),
        .O(\txd_out_reg[39] ));
  LUT5 #(
    .INIT(32'hFFFF00AC)) 
    \txd_out[3]_i_1 
       (.I0(txd_filtered[3]),
        .I1(last_qmsg[3]),
        .I2(\txd_out[30]_i_2_n_0 ),
        .I3(\configuration_vector[6]_0 ),
        .I4(\txd_out[27]_i_2_n_0 ),
        .O(D[2]));
  LUT6 #(
    .INIT(64'hFFFFFFFF0000F888)) 
    \txd_out[40]_i_1 
       (.I0(\txd_out_reg[38]_0 ),
        .I1(last_qmsg[8]),
        .I2(\txd_out_reg[6] [0]),
        .I3(\txd_out_reg[38] ),
        .I4(\configuration_vector[6] ),
        .I5(\configuration_vector[6]_0 ),
        .O(D[19]));
  LUT6 #(
    .INIT(64'h000F000800080008)) 
    \txd_out[41]_i_1 
       (.I0(\txd_out_reg[38]_0 ),
        .I1(last_qmsg[9]),
        .I2(\configuration_vector[5] ),
        .I3(txd_out13_out),
        .I4(\txd_out_reg[38] ),
        .I5(\txd_out_reg[6] [1]),
        .O(D[20]));
  LUT5 #(
    .INIT(32'hFFEF0020)) 
    \txd_out[42]_i_1 
       (.I0(\txd_out_reg[2]_0 ),
        .I1(\state_reg[0][0]_0 ),
        .I2(\state_reg[0][2]_0 ),
        .I3(\state_reg_n_0_[1][2] ),
        .I4(last_qmsg[10]),
        .O(\txd_out_reg[42] ));
  LUT5 #(
    .INIT(32'hFFEF0020)) 
    \txd_out[44]_i_1 
       (.I0(\txd_out_reg[4]_0 ),
        .I1(\state_reg[0][0]_0 ),
        .I2(\state_reg[0][2]_0 ),
        .I3(\state_reg_n_0_[1][2] ),
        .I4(last_qmsg[12]),
        .O(\txd_out_reg[44] ));
  (* SOFT_HLUTNM = "soft_lutpair70" *) 
  LUT5 #(
    .INIT(32'h80B08080)) 
    \txd_out[45]_i_1 
       (.I0(last_qmsg[13]),
        .I1(\state_reg[0][0]_0 ),
        .I2(\state_reg[0][2]_0 ),
        .I3(\state_reg_n_0_[1][2] ),
        .I4(\txd_out_reg[5]_0 ),
        .O(\txd_out_reg[45] ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0000F888)) 
    \txd_out[46]_i_1 
       (.I0(\txd_out_reg[38] ),
        .I1(\txd_out_reg[6] [2]),
        .I2(last_qmsg[14]),
        .I3(\txd_out_reg[38]_0 ),
        .I4(\configuration_vector[5] ),
        .I5(\txd_out[62]_i_3_n_0 ),
        .O(D[21]));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT5 #(
    .INIT(32'h80B08080)) 
    \txd_out[47]_i_1 
       (.I0(last_qmsg[15]),
        .I1(\state_reg[0][0]_0 ),
        .I2(\state_reg[0][2]_0 ),
        .I3(\state_reg_n_0_[1][2] ),
        .I4(\txd_out_reg[7]_0 ),
        .O(\txd_out_reg[47] ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0000F888)) 
    \txd_out[48]_i_1 
       (.I0(\txd_out_reg[38]_0 ),
        .I1(last_qmsg[16]),
        .I2(\txd_out_reg[6]_0 [0]),
        .I3(\txd_out_reg[38] ),
        .I4(\configuration_vector[6] ),
        .I5(\configuration_vector[6]_0 ),
        .O(D[22]));
  LUT6 #(
    .INIT(64'h000F000800080008)) 
    \txd_out[49]_i_1 
       (.I0(\txd_out_reg[38]_0 ),
        .I1(last_qmsg[17]),
        .I2(\configuration_vector[5] ),
        .I3(txd_out13_out),
        .I4(\txd_out_reg[38] ),
        .I5(\txd_out_reg[6]_0 [1]),
        .O(D[23]));
  LUT5 #(
    .INIT(32'hFFFB0008)) 
    \txd_out[4]_i_1 
       (.I0(txd_filtered[4]),
        .I1(\count_reg[1] ),
        .I2(\count_reg[1]_0 ),
        .I3(\state_reg_n_0_[0][2] ),
        .I4(last_qmsg[4]),
        .O(\txd_out_reg[4] ));
  LUT5 #(
    .INIT(32'hFFEF0020)) 
    \txd_out[50]_i_1 
       (.I0(\txd_out_reg[2]_1 ),
        .I1(\state_reg[0][0]_0 ),
        .I2(\state_reg[0][2]_0 ),
        .I3(\state_reg_n_0_[1][2] ),
        .I4(last_qmsg[18]),
        .O(\txd_out_reg[50] ));
  LUT5 #(
    .INIT(32'hFFEF0020)) 
    \txd_out[52]_i_1 
       (.I0(\txd_out_reg[4]_1 ),
        .I1(\state_reg[0][0]_0 ),
        .I2(\state_reg[0][2]_0 ),
        .I3(\state_reg_n_0_[1][2] ),
        .I4(last_qmsg[20]),
        .O(\txd_out_reg[52] ));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT5 #(
    .INIT(32'h80B08080)) 
    \txd_out[53]_i_1 
       (.I0(last_qmsg[21]),
        .I1(\state_reg[0][0]_0 ),
        .I2(\state_reg[0][2]_0 ),
        .I3(\state_reg_n_0_[1][2] ),
        .I4(\txd_out_reg[5]_1 ),
        .O(\txd_out_reg[53] ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0000F888)) 
    \txd_out[54]_i_1 
       (.I0(\txd_out_reg[38] ),
        .I1(\txd_out_reg[6]_0 [2]),
        .I2(last_qmsg[22]),
        .I3(\txd_out_reg[38]_0 ),
        .I4(\configuration_vector[5] ),
        .I5(\txd_out[62]_i_3_n_0 ),
        .O(D[24]));
  (* SOFT_HLUTNM = "soft_lutpair73" *) 
  LUT5 #(
    .INIT(32'h80B08080)) 
    \txd_out[55]_i_1 
       (.I0(last_qmsg[23]),
        .I1(\state_reg[0][0]_0 ),
        .I2(\state_reg[0][2]_0 ),
        .I3(\state_reg_n_0_[1][2] ),
        .I4(\txd_out_reg[7]_1 ),
        .O(\txd_out_reg[55] ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0000F888)) 
    \txd_out[56]_i_1 
       (.I0(\txd_out_reg[38]_0 ),
        .I1(last_qmsg[24]),
        .I2(\txd_out_reg[6]_1 [0]),
        .I3(\txd_out_reg[38] ),
        .I4(\configuration_vector[6] ),
        .I5(\configuration_vector[6]_0 ),
        .O(D[25]));
  LUT6 #(
    .INIT(64'h000F000800080008)) 
    \txd_out[57]_i_1 
       (.I0(\txd_out_reg[38]_0 ),
        .I1(last_qmsg[25]),
        .I2(\configuration_vector[5] ),
        .I3(txd_out13_out),
        .I4(\txd_out_reg[38] ),
        .I5(\txd_out_reg[6]_1 [1]),
        .O(D[26]));
  LUT5 #(
    .INIT(32'hFFEF0020)) 
    \txd_out[58]_i_1 
       (.I0(\txd_out_reg[2]_2 ),
        .I1(\state_reg[0][0]_0 ),
        .I2(\state_reg[0][2]_0 ),
        .I3(\state_reg_n_0_[1][2] ),
        .I4(last_qmsg[26]),
        .O(\txd_out_reg[58] ));
  LUT6 #(
    .INIT(64'h28FD28FDFDFD28FD)) 
    \txd_out[59]_i_1 
       (.I0(configuration_vector[0]),
        .I1(configuration_vector[1]),
        .I2(configuration_vector[2]),
        .I3(\state_reg[0][2]_0 ),
        .I4(\state_reg_n_0_[1][2] ),
        .I5(\state_reg[0][0]_0 ),
        .O(\txd_out_reg[59] ));
  LUT5 #(
    .INIT(32'hF4000400)) 
    \txd_out[5]_i_1 
       (.I0(\state_reg_n_0_[0][2] ),
        .I1(txd_filtered[5]),
        .I2(\count_reg[1]_0 ),
        .I3(\count_reg[1] ),
        .I4(last_qmsg[5]),
        .O(\txd_out_reg[5] ));
  LUT6 #(
    .INIT(64'h2AFF2AFFFFFF2AFF)) 
    \txd_out[60]_i_1 
       (.I0(configuration_vector[0]),
        .I1(configuration_vector[1]),
        .I2(configuration_vector[2]),
        .I3(\state_reg[0][2]_0 ),
        .I4(\state_reg_n_0_[1][2] ),
        .I5(\state_reg[0][0]_0 ),
        .O(\txd_out_reg[60] ));
  LUT5 #(
    .INIT(32'hFFEF0020)) 
    \txd_out[60]_i_2 
       (.I0(\txd_out_reg[4]_2 ),
        .I1(\state_reg[0][0]_0 ),
        .I2(\state_reg[0][2]_0 ),
        .I3(\state_reg_n_0_[1][2] ),
        .I4(last_qmsg[28]),
        .O(\txd_out_reg[60]_0 ));
  LUT6 #(
    .INIT(64'h2A2AFF2AFFFF2AFF)) 
    \txd_out[61]_i_1 
       (.I0(configuration_vector[0]),
        .I1(configuration_vector[1]),
        .I2(configuration_vector[2]),
        .I3(\state_reg_n_0_[1][2] ),
        .I4(\state_reg[0][0]_0 ),
        .I5(\state_reg[0][2]_0 ),
        .O(\txd_out_reg[61]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair74" *) 
  LUT5 #(
    .INIT(32'h80B08080)) 
    \txd_out[61]_i_2 
       (.I0(last_qmsg[29]),
        .I1(\state_reg[0][0]_0 ),
        .I2(\state_reg[0][2]_0 ),
        .I3(\state_reg_n_0_[1][2] ),
        .I4(\txd_out_reg[5]_2 ),
        .O(\txd_out_reg[61] ));
  LUT6 #(
    .INIT(64'hF0F0F0F0FFF8F8F8)) 
    \txd_out[62]_i_1 
       (.I0(\txd_out_reg[38] ),
        .I1(\txd_out_reg[6]_1 [2]),
        .I2(\txd_out[62]_i_3_n_0 ),
        .I3(last_qmsg[30]),
        .I4(\txd_out_reg[38]_0 ),
        .I5(\configuration_vector[5] ),
        .O(D[27]));
  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT3 #(
    .INIT(8'h04)) 
    \txd_out[62]_i_2 
       (.I0(\state_reg[0][0]_0 ),
        .I1(\state_reg[0][2]_0 ),
        .I2(\state_reg_n_0_[1][2] ),
        .O(\txd_out_reg[38] ));
  LUT5 #(
    .INIT(32'h4040F340)) 
    \txd_out[62]_i_3 
       (.I0(configuration_vector[2]),
        .I1(configuration_vector[0]),
        .I2(configuration_vector[1]),
        .I3(\state_reg[0][0]_0 ),
        .I4(\state_reg[0][2]_0 ),
        .O(\txd_out[62]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair70" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \txd_out[62]_i_4 
       (.I0(\state_reg[0][0]_0 ),
        .I1(\state_reg[0][2]_0 ),
        .O(\txd_out_reg[38]_0 ));
  LUT6 #(
    .INIT(64'h2AFF2A2A2A2A2AFF)) 
    \txd_out[63]_i_1 
       (.I0(configuration_vector[0]),
        .I1(configuration_vector[1]),
        .I2(configuration_vector[2]),
        .I3(\state_reg[0][0]_0 ),
        .I4(\state_reg_n_0_[1][2] ),
        .I5(\state_reg[0][2]_0 ),
        .O(\txd_out_reg[63] ));
  LUT5 #(
    .INIT(32'hF4000400)) 
    \txd_out[63]_i_2 
       (.I0(\state_reg_n_0_[1][2] ),
        .I1(\txd_out_reg[7]_2 ),
        .I2(\state_reg[0][0]_0 ),
        .I3(\state_reg[0][2]_0 ),
        .I4(last_qmsg[31]),
        .O(\txd_out_reg[63]_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF008800F8)) 
    \txd_out[6]_i_1 
       (.I0(\txd_out[30]_i_2_n_0 ),
        .I1(txd_filtered[6]),
        .I2(last_qmsg[6]),
        .I3(\configuration_vector[5] ),
        .I4(\txd_out[30]_i_4_n_0 ),
        .I5(\txd_out[30]_i_3_n_0 ),
        .O(D[3]));
  LUT5 #(
    .INIT(32'hF4000400)) 
    \txd_out[7]_i_1 
       (.I0(\state_reg_n_0_[0][2] ),
        .I1(txd_filtered[7]),
        .I2(\count_reg[1]_0 ),
        .I3(\count_reg[1] ),
        .I4(last_qmsg[7]),
        .O(\txd_out_reg[7] ));
  LUT6 #(
    .INIT(64'hFFFFFFFF0000F444)) 
    \txd_out[8]_i_1 
       (.I0(\txd_out[30]_i_4_n_0 ),
        .I1(last_qmsg[8]),
        .I2(data1[0]),
        .I3(\txd_out[30]_i_2_n_0 ),
        .I4(\configuration_vector[6] ),
        .I5(\configuration_vector[6]_0 ),
        .O(D[4]));
  LUT6 #(
    .INIT(64'h000F000400040004)) 
    \txd_out[9]_i_1 
       (.I0(\txd_out[30]_i_4_n_0 ),
        .I1(last_qmsg[9]),
        .I2(\configuration_vector[5] ),
        .I3(txd_out13_out),
        .I4(\txd_out[30]_i_2_n_0 ),
        .I5(data1[1]),
        .O(D[5]));
endmodule

(* ORIG_REF_NAME = "xaui_block" *) (* downgradeipidentifiedwarnings = "yes" *) 
module xaui_xaui_block
   (dclk,
    reset,
    clk156_out,
    clk156_lock,
    refclk,
    xgmii_txd,
    xgmii_txc,
    xgmii_rxd,
    xgmii_rxc,
    xaui_tx_l0_p,
    xaui_tx_l0_n,
    xaui_tx_l1_p,
    xaui_tx_l1_n,
    xaui_tx_l2_p,
    xaui_tx_l2_n,
    xaui_tx_l3_p,
    xaui_tx_l3_n,
    xaui_rx_l0_p,
    xaui_rx_l0_n,
    xaui_rx_l1_p,
    xaui_rx_l1_n,
    xaui_rx_l2_p,
    xaui_rx_l2_n,
    xaui_rx_l3_p,
    xaui_rx_l3_n,
    signal_detect,
    debug,
    gt0_drpaddr,
    gt0_drpen,
    gt0_drpdi,
    gt0_drpdo,
    gt0_drprdy,
    gt0_drpwe,
    gt0_txpmareset_in,
    gt0_txpcsreset_in,
    gt0_txresetdone_out,
    gt0_rxpmareset_in,
    gt0_rxpcsreset_in,
    gt0_rxresetdone_out,
    gt0_rxbufstatus_out,
    gt0_txphaligndone_out,
    gt0_txphinitdone_out,
    gt0_txdlysresetdone_out,
    gt_qplllock_out,
    gt0_eyescantrigger_in,
    gt0_eyescanreset_in,
    gt0_eyescandataerror_out,
    gt0_rxrate_in,
    gt0_loopback_in,
    gt0_rxpolarity_in,
    gt0_txpolarity_in,
    gt0_rxlpmen_in,
    gt0_rxdfelpmreset_in,
    gt0_rxmonitorsel_in,
    gt0_rxmonitorout_out,
    gt0_txpostcursor_in,
    gt0_txprecursor_in,
    gt0_txdiffctrl_in,
    gt0_txinhibit_in,
    gt0_rxprbscntreset_in,
    gt0_rxprbserr_out,
    gt0_rxprbssel_in,
    gt0_txprbssel_in,
    gt0_txprbsforceerr_in,
    gt0_rxcdrhold_in,
    gt0_dmonitorout_out,
    gt0_rxdisperr_out,
    gt0_rxnotintable_out,
    gt0_rxcommadet_out,
    gt1_drpaddr,
    gt1_drpen,
    gt1_drpdi,
    gt1_drpdo,
    gt1_drprdy,
    gt1_drpwe,
    gt1_txpmareset_in,
    gt1_txpcsreset_in,
    gt1_txresetdone_out,
    gt1_rxpmareset_in,
    gt1_rxpcsreset_in,
    gt1_rxresetdone_out,
    gt1_rxbufstatus_out,
    gt1_txphaligndone_out,
    gt1_txphinitdone_out,
    gt1_txdlysresetdone_out,
    gt1_eyescantrigger_in,
    gt1_eyescanreset_in,
    gt1_eyescandataerror_out,
    gt1_rxrate_in,
    gt1_loopback_in,
    gt1_rxpolarity_in,
    gt1_txpolarity_in,
    gt1_rxlpmen_in,
    gt1_rxdfelpmreset_in,
    gt1_rxmonitorsel_in,
    gt1_rxmonitorout_out,
    gt1_txpostcursor_in,
    gt1_txprecursor_in,
    gt1_txdiffctrl_in,
    gt1_txinhibit_in,
    gt1_rxprbscntreset_in,
    gt1_rxprbserr_out,
    gt1_rxprbssel_in,
    gt1_txprbssel_in,
    gt1_txprbsforceerr_in,
    gt1_rxcdrhold_in,
    gt1_dmonitorout_out,
    gt1_rxdisperr_out,
    gt1_rxnotintable_out,
    gt1_rxcommadet_out,
    gt2_drpaddr,
    gt2_drpen,
    gt2_drpdi,
    gt2_drpdo,
    gt2_drprdy,
    gt2_drpwe,
    gt2_txpmareset_in,
    gt2_txpcsreset_in,
    gt2_txresetdone_out,
    gt2_rxpmareset_in,
    gt2_rxpcsreset_in,
    gt2_rxresetdone_out,
    gt2_rxbufstatus_out,
    gt2_txphaligndone_out,
    gt2_txphinitdone_out,
    gt2_txdlysresetdone_out,
    gt2_eyescantrigger_in,
    gt2_eyescanreset_in,
    gt2_eyescandataerror_out,
    gt2_rxrate_in,
    gt2_loopback_in,
    gt2_rxpolarity_in,
    gt2_txpolarity_in,
    gt2_rxlpmen_in,
    gt2_rxdfelpmreset_in,
    gt2_rxmonitorsel_in,
    gt2_rxmonitorout_out,
    gt2_txpostcursor_in,
    gt2_txprecursor_in,
    gt2_txdiffctrl_in,
    gt2_txinhibit_in,
    gt2_rxprbscntreset_in,
    gt2_rxprbserr_out,
    gt2_rxprbssel_in,
    gt2_txprbssel_in,
    gt2_txprbsforceerr_in,
    gt2_rxcdrhold_in,
    gt2_dmonitorout_out,
    gt2_rxdisperr_out,
    gt2_rxnotintable_out,
    gt2_rxcommadet_out,
    gt3_drpaddr,
    gt3_drpen,
    gt3_drpdi,
    gt3_drpdo,
    gt3_drprdy,
    gt3_drpwe,
    gt3_txpmareset_in,
    gt3_txpcsreset_in,
    gt3_txresetdone_out,
    gt3_rxpmareset_in,
    gt3_rxpcsreset_in,
    gt3_rxresetdone_out,
    gt3_rxbufstatus_out,
    gt3_txphaligndone_out,
    gt3_txphinitdone_out,
    gt3_txdlysresetdone_out,
    gt3_eyescantrigger_in,
    gt3_eyescanreset_in,
    gt3_eyescandataerror_out,
    gt3_rxrate_in,
    gt3_loopback_in,
    gt3_rxpolarity_in,
    gt3_txpolarity_in,
    gt3_rxlpmen_in,
    gt3_rxdfelpmreset_in,
    gt3_rxmonitorsel_in,
    gt3_rxmonitorout_out,
    gt3_txpostcursor_in,
    gt3_txprecursor_in,
    gt3_txdiffctrl_in,
    gt3_txinhibit_in,
    gt3_rxprbscntreset_in,
    gt3_rxprbserr_out,
    gt3_rxprbssel_in,
    gt3_txprbssel_in,
    gt3_txprbsforceerr_in,
    gt3_rxcdrhold_in,
    gt3_dmonitorout_out,
    gt3_rxdisperr_out,
    gt3_rxnotintable_out,
    gt3_rxcommadet_out,
    configuration_vector,
    status_vector);
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
  input [8:0]gt0_drpaddr;
  input gt0_drpen;
  input [15:0]gt0_drpdi;
  output [15:0]gt0_drpdo;
  output gt0_drprdy;
  input gt0_drpwe;
  input gt0_txpmareset_in;
  input gt0_txpcsreset_in;
  output gt0_txresetdone_out;
  input gt0_rxpmareset_in;
  input gt0_rxpcsreset_in;
  output gt0_rxresetdone_out;
  output [2:0]gt0_rxbufstatus_out;
  output gt0_txphaligndone_out;
  output gt0_txphinitdone_out;
  output gt0_txdlysresetdone_out;
  output gt_qplllock_out;
  input gt0_eyescantrigger_in;
  input gt0_eyescanreset_in;
  output gt0_eyescandataerror_out;
  input [2:0]gt0_rxrate_in;
  input [2:0]gt0_loopback_in;
  input gt0_rxpolarity_in;
  input gt0_txpolarity_in;
  input gt0_rxlpmen_in;
  input gt0_rxdfelpmreset_in;
  input [1:0]gt0_rxmonitorsel_in;
  output [6:0]gt0_rxmonitorout_out;
  input [4:0]gt0_txpostcursor_in;
  input [4:0]gt0_txprecursor_in;
  input [3:0]gt0_txdiffctrl_in;
  input gt0_txinhibit_in;
  input gt0_rxprbscntreset_in;
  output gt0_rxprbserr_out;
  input [2:0]gt0_rxprbssel_in;
  input [2:0]gt0_txprbssel_in;
  input gt0_txprbsforceerr_in;
  input gt0_rxcdrhold_in;
  output [7:0]gt0_dmonitorout_out;
  output [1:0]gt0_rxdisperr_out;
  output [1:0]gt0_rxnotintable_out;
  output gt0_rxcommadet_out;
  input [8:0]gt1_drpaddr;
  input gt1_drpen;
  input [15:0]gt1_drpdi;
  output [15:0]gt1_drpdo;
  output gt1_drprdy;
  input gt1_drpwe;
  input gt1_txpmareset_in;
  input gt1_txpcsreset_in;
  output gt1_txresetdone_out;
  input gt1_rxpmareset_in;
  input gt1_rxpcsreset_in;
  output gt1_rxresetdone_out;
  output [2:0]gt1_rxbufstatus_out;
  output gt1_txphaligndone_out;
  output gt1_txphinitdone_out;
  output gt1_txdlysresetdone_out;
  input gt1_eyescantrigger_in;
  input gt1_eyescanreset_in;
  output gt1_eyescandataerror_out;
  input [2:0]gt1_rxrate_in;
  input [2:0]gt1_loopback_in;
  input gt1_rxpolarity_in;
  input gt1_txpolarity_in;
  input gt1_rxlpmen_in;
  input gt1_rxdfelpmreset_in;
  input [1:0]gt1_rxmonitorsel_in;
  output [6:0]gt1_rxmonitorout_out;
  input [4:0]gt1_txpostcursor_in;
  input [4:0]gt1_txprecursor_in;
  input [3:0]gt1_txdiffctrl_in;
  input gt1_txinhibit_in;
  input gt1_rxprbscntreset_in;
  output gt1_rxprbserr_out;
  input [2:0]gt1_rxprbssel_in;
  input [2:0]gt1_txprbssel_in;
  input gt1_txprbsforceerr_in;
  input gt1_rxcdrhold_in;
  output [7:0]gt1_dmonitorout_out;
  output [1:0]gt1_rxdisperr_out;
  output [1:0]gt1_rxnotintable_out;
  output gt1_rxcommadet_out;
  input [8:0]gt2_drpaddr;
  input gt2_drpen;
  input [15:0]gt2_drpdi;
  output [15:0]gt2_drpdo;
  output gt2_drprdy;
  input gt2_drpwe;
  input gt2_txpmareset_in;
  input gt2_txpcsreset_in;
  output gt2_txresetdone_out;
  input gt2_rxpmareset_in;
  input gt2_rxpcsreset_in;
  output gt2_rxresetdone_out;
  output [2:0]gt2_rxbufstatus_out;
  output gt2_txphaligndone_out;
  output gt2_txphinitdone_out;
  output gt2_txdlysresetdone_out;
  input gt2_eyescantrigger_in;
  input gt2_eyescanreset_in;
  output gt2_eyescandataerror_out;
  input [2:0]gt2_rxrate_in;
  input [2:0]gt2_loopback_in;
  input gt2_rxpolarity_in;
  input gt2_txpolarity_in;
  input gt2_rxlpmen_in;
  input gt2_rxdfelpmreset_in;
  input [1:0]gt2_rxmonitorsel_in;
  output [6:0]gt2_rxmonitorout_out;
  input [4:0]gt2_txpostcursor_in;
  input [4:0]gt2_txprecursor_in;
  input [3:0]gt2_txdiffctrl_in;
  input gt2_txinhibit_in;
  input gt2_rxprbscntreset_in;
  output gt2_rxprbserr_out;
  input [2:0]gt2_rxprbssel_in;
  input [2:0]gt2_txprbssel_in;
  input gt2_txprbsforceerr_in;
  input gt2_rxcdrhold_in;
  output [7:0]gt2_dmonitorout_out;
  output [1:0]gt2_rxdisperr_out;
  output [1:0]gt2_rxnotintable_out;
  output gt2_rxcommadet_out;
  input [8:0]gt3_drpaddr;
  input gt3_drpen;
  input [15:0]gt3_drpdi;
  output [15:0]gt3_drpdo;
  output gt3_drprdy;
  input gt3_drpwe;
  input gt3_txpmareset_in;
  input gt3_txpcsreset_in;
  output gt3_txresetdone_out;
  input gt3_rxpmareset_in;
  input gt3_rxpcsreset_in;
  output gt3_rxresetdone_out;
  output [2:0]gt3_rxbufstatus_out;
  output gt3_txphaligndone_out;
  output gt3_txphinitdone_out;
  output gt3_txdlysresetdone_out;
  input gt3_eyescantrigger_in;
  input gt3_eyescanreset_in;
  output gt3_eyescandataerror_out;
  input [2:0]gt3_rxrate_in;
  input [2:0]gt3_loopback_in;
  input gt3_rxpolarity_in;
  input gt3_txpolarity_in;
  input gt3_rxlpmen_in;
  input gt3_rxdfelpmreset_in;
  input [1:0]gt3_rxmonitorsel_in;
  output [6:0]gt3_rxmonitorout_out;
  input [4:0]gt3_txpostcursor_in;
  input [4:0]gt3_txprecursor_in;
  input [3:0]gt3_txdiffctrl_in;
  input gt3_txinhibit_in;
  input gt3_rxprbscntreset_in;
  output gt3_rxprbserr_out;
  input [2:0]gt3_rxprbssel_in;
  input [2:0]gt3_txprbssel_in;
  input gt3_txprbsforceerr_in;
  input gt3_rxcdrhold_in;
  output [7:0]gt3_dmonitorout_out;
  output [1:0]gt3_rxdisperr_out;
  output [1:0]gt3_rxnotintable_out;
  output gt3_rxcommadet_out;
  input [6:0]configuration_vector;
  output [7:0]status_vector;

  wire [2:0]bufStatus;
  wire clk156_lock;
  wire clk156_out;
  wire [6:0]configuration_vector;
  wire data_out;
  wire dclk;
  wire [5:0]debug;
  wire done;
  wire [7:0]gt0_dmonitorout_out;
  wire [8:0]gt0_drpaddr;
  wire [15:0]gt0_drpdi;
  wire [15:0]gt0_drpdo;
  wire gt0_drpen;
  wire gt0_drprdy;
  wire gt0_drpwe;
  wire gt0_eyescandataerror_out;
  wire gt0_eyescanreset_in;
  wire gt0_eyescantrigger_in;
  wire [2:0]gt0_loopback_in;
  wire gt0_qpllreset_in;
  wire [2:0]gt0_rxbufstatus_out;
  wire gt0_rxcdrhold_in;
  wire [1:0]gt0_rxchariscomma_out;
  wire [1:0]gt0_rxcharisk_out;
  wire gt0_rxcommadet_out;
  wire [15:0]gt0_rxdata_out;
  wire gt0_rxdfelpmreset_in;
  wire [1:0]gt0_rxdisperr_out;
  wire gt0_rxlpmen_in;
  wire [6:0]gt0_rxmonitorout_out;
  wire [1:0]gt0_rxmonitorsel_in;
  wire [1:0]gt0_rxnotintable_out;
  wire gt0_rxpcsreset_in;
  wire gt0_rxpmareset;
  wire gt0_rxpmareset_in;
  wire gt0_rxpolarity_in;
  wire gt0_rxprbscntreset_in;
  wire gt0_rxprbserr_out;
  wire [2:0]gt0_rxprbssel_in;
  wire [2:0]gt0_rxrate_in;
  wire gt0_rxresetdone_out;
  wire [3:0]gt0_txdiffctrl_in;
  wire gt0_txdlysresetdone_out;
  wire gt0_txinhibit_in;
  wire gt0_txoutclk_i;
  wire gt0_txpcsreset_in;
  wire gt0_txphaligndone_out;
  wire gt0_txphinitdone_out;
  wire gt0_txpmareset_in;
  wire gt0_txpolarity_in;
  wire [4:0]gt0_txpostcursor_in;
  wire gt0_txprbsforceerr_in;
  wire [2:0]gt0_txprbssel_in;
  wire [4:0]gt0_txprecursor_in;
  wire gt0_txresetdone_out;
  wire [7:0]gt1_dmonitorout_out;
  wire [8:0]gt1_drpaddr;
  wire [15:0]gt1_drpdi;
  wire [15:0]gt1_drpdo;
  wire gt1_drpen;
  wire gt1_drprdy;
  wire gt1_drpwe;
  wire gt1_eyescandataerror_out;
  wire gt1_eyescanreset_in;
  wire gt1_eyescantrigger_in;
  wire [2:0]gt1_loopback_in;
  wire gt1_rxbufreset_in;
  wire [2:0]gt1_rxbufstatus_out;
  wire gt1_rxcdrhold_in;
  wire [1:0]gt1_rxchariscomma_out;
  wire [1:0]gt1_rxcharisk_out;
  wire gt1_rxcommadet_out;
  wire [15:0]gt1_rxdata_out;
  wire gt1_rxdfelpmreset_in;
  wire [1:0]gt1_rxdisperr_out;
  wire gt1_rxlpmen_in;
  wire gt1_rxmcommaalignen_in;
  wire [6:0]gt1_rxmonitorout_out;
  wire [1:0]gt1_rxmonitorsel_in;
  wire [1:0]gt1_rxnotintable_out;
  wire gt1_rxpcsreset_in;
  wire gt1_rxpmareset;
  wire gt1_rxpmareset_in;
  wire gt1_rxpolarity_in;
  wire gt1_rxprbscntreset_in;
  wire gt1_rxprbserr_out;
  wire [2:0]gt1_rxprbssel_in;
  wire [2:0]gt1_rxrate_in;
  wire gt1_rxresetdone_out;
  wire [1:0]gt1_txcharisk_in;
  wire [15:0]gt1_txdata_in;
  wire [3:0]gt1_txdiffctrl_in;
  wire gt1_txdlysreset_in;
  wire gt1_txdlysresetdone_out;
  wire gt1_txinhibit_in;
  wire gt1_txpcsreset_in;
  wire gt1_txphalign_in;
  wire gt1_txphaligndone_out;
  wire gt1_txphinit_in;
  wire gt1_txphinitdone_out;
  wire gt1_txpmareset_in;
  wire gt1_txpolarity_in;
  wire [4:0]gt1_txpostcursor_in;
  wire gt1_txprbsforceerr_in;
  wire [2:0]gt1_txprbssel_in;
  wire [4:0]gt1_txprecursor_in;
  wire gt1_txresetdone_out;
  wire [7:0]gt2_dmonitorout_out;
  wire [8:0]gt2_drpaddr;
  wire [15:0]gt2_drpdi;
  wire [15:0]gt2_drpdo;
  wire gt2_drpen;
  wire gt2_drprdy;
  wire gt2_drpwe;
  wire gt2_eyescandataerror_out;
  wire gt2_eyescanreset_in;
  wire gt2_eyescantrigger_in;
  wire [2:0]gt2_loopback_in;
  wire gt2_rxbufreset_in;
  wire [2:0]gt2_rxbufstatus_out;
  wire gt2_rxcdrhold_in;
  wire [1:0]gt2_rxchariscomma_out;
  wire [1:0]gt2_rxcharisk_out;
  wire gt2_rxcommadet_out;
  wire [15:0]gt2_rxdata_out;
  wire gt2_rxdfelpmreset_in;
  wire [1:0]gt2_rxdisperr_out;
  wire gt2_rxlpmen_in;
  wire gt2_rxmcommaalignen_in;
  wire [6:0]gt2_rxmonitorout_out;
  wire [1:0]gt2_rxmonitorsel_in;
  wire [1:0]gt2_rxnotintable_out;
  wire gt2_rxpcsreset_in;
  wire gt2_rxpmareset;
  wire gt2_rxpmareset_in;
  wire gt2_rxpolarity_in;
  wire gt2_rxprbscntreset_in;
  wire gt2_rxprbserr_out;
  wire [2:0]gt2_rxprbssel_in;
  wire [2:0]gt2_rxrate_in;
  wire gt2_rxresetdone_out;
  wire [1:0]gt2_txcharisk_in;
  wire [15:0]gt2_txdata_in;
  wire [3:0]gt2_txdiffctrl_in;
  wire gt2_txdlysreset_in;
  wire gt2_txdlysresetdone_out;
  wire gt2_txinhibit_in;
  wire gt2_txpcsreset_in;
  wire gt2_txphalign_in;
  wire gt2_txphaligndone_out;
  wire gt2_txphinit_in;
  wire gt2_txphinitdone_out;
  wire gt2_txpmareset_in;
  wire gt2_txpolarity_in;
  wire [4:0]gt2_txpostcursor_in;
  wire gt2_txprbsforceerr_in;
  wire [2:0]gt2_txprbssel_in;
  wire [4:0]gt2_txprecursor_in;
  wire gt2_txresetdone_out;
  wire [7:0]gt3_dmonitorout_out;
  wire [8:0]gt3_drpaddr;
  wire [15:0]gt3_drpdi;
  wire [15:0]gt3_drpdo;
  wire gt3_drpen;
  wire gt3_drprdy;
  wire gt3_drpwe;
  wire gt3_eyescandataerror_out;
  wire gt3_eyescanreset_in;
  wire gt3_eyescantrigger_in;
  wire [2:0]gt3_loopback_in;
  wire gt3_rxbufreset_in;
  wire [2:0]gt3_rxbufstatus_out;
  wire gt3_rxcdrhold_in;
  wire [1:0]gt3_rxchariscomma_out;
  wire [1:0]gt3_rxcharisk_out;
  wire gt3_rxcommadet_out;
  wire [15:0]gt3_rxdata_out;
  wire gt3_rxdfelpmreset_in;
  wire [1:0]gt3_rxdisperr_out;
  wire gt3_rxlpmen_in;
  wire gt3_rxmcommaalignen_in;
  wire [6:0]gt3_rxmonitorout_out;
  wire [1:0]gt3_rxmonitorsel_in;
  wire [1:0]gt3_rxnotintable_out;
  wire gt3_rxpcsreset_in;
  wire gt3_rxpmareset;
  wire gt3_rxpmareset_in;
  wire gt3_rxpolarity_in;
  wire gt3_rxprbscntreset_in;
  wire gt3_rxprbserr_out;
  wire [2:0]gt3_rxprbssel_in;
  wire [2:0]gt3_rxrate_in;
  wire gt3_rxresetdone_out;
  wire [1:0]gt3_txcharisk_in;
  wire [15:0]gt3_txdata_in;
  wire [3:0]gt3_txdiffctrl_in;
  wire gt3_txdlysreset_in;
  wire gt3_txdlysresetdone_out;
  wire gt3_txinhibit_in;
  wire gt3_txpcsreset_in;
  wire gt3_txphalign_in;
  wire gt3_txphaligndone_out;
  wire gt3_txphinit_in;
  wire gt3_txphinitdone_out;
  wire gt3_txpmareset_in;
  wire gt3_txpolarity_in;
  wire [4:0]gt3_txpostcursor_in;
  wire gt3_txprbsforceerr_in;
  wire [2:0]gt3_txprbssel_in;
  wire [4:0]gt3_txprecursor_in;
  wire gt3_txresetdone_out;
  wire gt_qplllock_out;
  wire [7:0]mgt_codecomma;
  wire [7:0]mgt_codevalid;
  wire [3:0]mgt_rx_reset;
  wire \mgt_rxcharisk_reg_reg_n_0_[0] ;
  wire \mgt_rxcharisk_reg_reg_n_0_[1] ;
  wire \mgt_rxcharisk_reg_reg_n_0_[2] ;
  wire \mgt_rxcharisk_reg_reg_n_0_[3] ;
  wire \mgt_rxcharisk_reg_reg_n_0_[4] ;
  wire \mgt_rxcharisk_reg_reg_n_0_[5] ;
  wire \mgt_rxcharisk_reg_reg_n_0_[6] ;
  wire \mgt_rxcharisk_reg_reg_n_0_[7] ;
  wire \mgt_rxdata_reg_reg_n_0_[0] ;
  wire \mgt_rxdata_reg_reg_n_0_[10] ;
  wire \mgt_rxdata_reg_reg_n_0_[11] ;
  wire \mgt_rxdata_reg_reg_n_0_[12] ;
  wire \mgt_rxdata_reg_reg_n_0_[13] ;
  wire \mgt_rxdata_reg_reg_n_0_[14] ;
  wire \mgt_rxdata_reg_reg_n_0_[15] ;
  wire \mgt_rxdata_reg_reg_n_0_[16] ;
  wire \mgt_rxdata_reg_reg_n_0_[17] ;
  wire \mgt_rxdata_reg_reg_n_0_[18] ;
  wire \mgt_rxdata_reg_reg_n_0_[19] ;
  wire \mgt_rxdata_reg_reg_n_0_[1] ;
  wire \mgt_rxdata_reg_reg_n_0_[20] ;
  wire \mgt_rxdata_reg_reg_n_0_[21] ;
  wire \mgt_rxdata_reg_reg_n_0_[22] ;
  wire \mgt_rxdata_reg_reg_n_0_[23] ;
  wire \mgt_rxdata_reg_reg_n_0_[24] ;
  wire \mgt_rxdata_reg_reg_n_0_[25] ;
  wire \mgt_rxdata_reg_reg_n_0_[26] ;
  wire \mgt_rxdata_reg_reg_n_0_[27] ;
  wire \mgt_rxdata_reg_reg_n_0_[28] ;
  wire \mgt_rxdata_reg_reg_n_0_[29] ;
  wire \mgt_rxdata_reg_reg_n_0_[2] ;
  wire \mgt_rxdata_reg_reg_n_0_[30] ;
  wire \mgt_rxdata_reg_reg_n_0_[31] ;
  wire \mgt_rxdata_reg_reg_n_0_[32] ;
  wire \mgt_rxdata_reg_reg_n_0_[33] ;
  wire \mgt_rxdata_reg_reg_n_0_[34] ;
  wire \mgt_rxdata_reg_reg_n_0_[35] ;
  wire \mgt_rxdata_reg_reg_n_0_[36] ;
  wire \mgt_rxdata_reg_reg_n_0_[37] ;
  wire \mgt_rxdata_reg_reg_n_0_[38] ;
  wire \mgt_rxdata_reg_reg_n_0_[39] ;
  wire \mgt_rxdata_reg_reg_n_0_[3] ;
  wire \mgt_rxdata_reg_reg_n_0_[40] ;
  wire \mgt_rxdata_reg_reg_n_0_[41] ;
  wire \mgt_rxdata_reg_reg_n_0_[42] ;
  wire \mgt_rxdata_reg_reg_n_0_[43] ;
  wire \mgt_rxdata_reg_reg_n_0_[44] ;
  wire \mgt_rxdata_reg_reg_n_0_[45] ;
  wire \mgt_rxdata_reg_reg_n_0_[46] ;
  wire \mgt_rxdata_reg_reg_n_0_[47] ;
  wire \mgt_rxdata_reg_reg_n_0_[48] ;
  wire \mgt_rxdata_reg_reg_n_0_[49] ;
  wire \mgt_rxdata_reg_reg_n_0_[4] ;
  wire \mgt_rxdata_reg_reg_n_0_[50] ;
  wire \mgt_rxdata_reg_reg_n_0_[51] ;
  wire \mgt_rxdata_reg_reg_n_0_[52] ;
  wire \mgt_rxdata_reg_reg_n_0_[53] ;
  wire \mgt_rxdata_reg_reg_n_0_[54] ;
  wire \mgt_rxdata_reg_reg_n_0_[55] ;
  wire \mgt_rxdata_reg_reg_n_0_[56] ;
  wire \mgt_rxdata_reg_reg_n_0_[57] ;
  wire \mgt_rxdata_reg_reg_n_0_[58] ;
  wire \mgt_rxdata_reg_reg_n_0_[59] ;
  wire \mgt_rxdata_reg_reg_n_0_[5] ;
  wire \mgt_rxdata_reg_reg_n_0_[60] ;
  wire \mgt_rxdata_reg_reg_n_0_[61] ;
  wire \mgt_rxdata_reg_reg_n_0_[62] ;
  wire \mgt_rxdata_reg_reg_n_0_[63] ;
  wire \mgt_rxdata_reg_reg_n_0_[6] ;
  wire \mgt_rxdata_reg_reg_n_0_[7] ;
  wire \mgt_rxdata_reg_reg_n_0_[8] ;
  wire \mgt_rxdata_reg_reg_n_0_[9] ;
  wire [7:0]mgt_rxdisperr_reg;
  wire [7:0]mgt_rxnotintable_reg;
  wire p_0_in;
  wire [3:0]p_0_out;
  wire refclk;
  wire reset;
  wire reset156;
  wire reset_count_done_sync_i_n_0;
  wire rxprbs_in_use;
  wire rxprbs_in_use0;
  wire rxprbs_in_use_i_2_n_0;
  wire rxprbs_in_use_i_3_n_0;
  wire [3:0]signal_detect;
  wire [7:0]status_vector;
  wire txsync_i_n_1;
  wire txsync_i_n_10;
  wire txsync_i_n_14;
  wire txsync_i_n_5;
  wire txsync_i_n_6;
  wire uclk_cbm_rx_reset;
  wire uclk_chbond_counter;
  wire \uclk_chbond_counter[0]_i_3_n_0 ;
  wire \uclk_chbond_counter[0]_i_4_n_0 ;
  wire \uclk_chbond_counter[0]_i_5_n_0 ;
  wire \uclk_chbond_counter[0]_i_6_n_0 ;
  wire \uclk_chbond_counter[0]_i_7_n_0 ;
  wire \uclk_chbond_counter[12]_i_2_n_0 ;
  wire \uclk_chbond_counter[12]_i_3_n_0 ;
  wire \uclk_chbond_counter[12]_i_4_n_0 ;
  wire \uclk_chbond_counter[12]_i_5_n_0 ;
  wire \uclk_chbond_counter[4]_i_2_n_0 ;
  wire \uclk_chbond_counter[4]_i_3_n_0 ;
  wire \uclk_chbond_counter[4]_i_4_n_0 ;
  wire \uclk_chbond_counter[4]_i_5_n_0 ;
  wire \uclk_chbond_counter[8]_i_2_n_0 ;
  wire \uclk_chbond_counter[8]_i_3_n_0 ;
  wire \uclk_chbond_counter[8]_i_4_n_0 ;
  wire \uclk_chbond_counter[8]_i_5_n_0 ;
  wire \uclk_chbond_counter_reg[0]_i_2_n_0 ;
  wire \uclk_chbond_counter_reg[0]_i_2_n_1 ;
  wire \uclk_chbond_counter_reg[0]_i_2_n_2 ;
  wire \uclk_chbond_counter_reg[0]_i_2_n_3 ;
  wire \uclk_chbond_counter_reg[0]_i_2_n_4 ;
  wire \uclk_chbond_counter_reg[0]_i_2_n_5 ;
  wire \uclk_chbond_counter_reg[0]_i_2_n_6 ;
  wire \uclk_chbond_counter_reg[0]_i_2_n_7 ;
  wire \uclk_chbond_counter_reg[12]_i_1_n_1 ;
  wire \uclk_chbond_counter_reg[12]_i_1_n_2 ;
  wire \uclk_chbond_counter_reg[12]_i_1_n_3 ;
  wire \uclk_chbond_counter_reg[12]_i_1_n_4 ;
  wire \uclk_chbond_counter_reg[12]_i_1_n_5 ;
  wire \uclk_chbond_counter_reg[12]_i_1_n_6 ;
  wire \uclk_chbond_counter_reg[12]_i_1_n_7 ;
  wire \uclk_chbond_counter_reg[4]_i_1_n_0 ;
  wire \uclk_chbond_counter_reg[4]_i_1_n_1 ;
  wire \uclk_chbond_counter_reg[4]_i_1_n_2 ;
  wire \uclk_chbond_counter_reg[4]_i_1_n_3 ;
  wire \uclk_chbond_counter_reg[4]_i_1_n_4 ;
  wire \uclk_chbond_counter_reg[4]_i_1_n_5 ;
  wire \uclk_chbond_counter_reg[4]_i_1_n_6 ;
  wire \uclk_chbond_counter_reg[4]_i_1_n_7 ;
  wire \uclk_chbond_counter_reg[8]_i_1_n_0 ;
  wire \uclk_chbond_counter_reg[8]_i_1_n_1 ;
  wire \uclk_chbond_counter_reg[8]_i_1_n_2 ;
  wire \uclk_chbond_counter_reg[8]_i_1_n_3 ;
  wire \uclk_chbond_counter_reg[8]_i_1_n_4 ;
  wire \uclk_chbond_counter_reg[8]_i_1_n_5 ;
  wire \uclk_chbond_counter_reg[8]_i_1_n_6 ;
  wire \uclk_chbond_counter_reg[8]_i_1_n_7 ;
  wire \uclk_chbond_counter_reg_n_0_[0] ;
  wire \uclk_chbond_counter_reg_n_0_[10] ;
  wire \uclk_chbond_counter_reg_n_0_[11] ;
  wire \uclk_chbond_counter_reg_n_0_[12] ;
  wire \uclk_chbond_counter_reg_n_0_[13] ;
  wire \uclk_chbond_counter_reg_n_0_[14] ;
  wire \uclk_chbond_counter_reg_n_0_[1] ;
  wire \uclk_chbond_counter_reg_n_0_[2] ;
  wire \uclk_chbond_counter_reg_n_0_[3] ;
  wire \uclk_chbond_counter_reg_n_0_[4] ;
  wire \uclk_chbond_counter_reg_n_0_[5] ;
  wire \uclk_chbond_counter_reg_n_0_[6] ;
  wire \uclk_chbond_counter_reg_n_0_[7] ;
  wire \uclk_chbond_counter_reg_n_0_[8] ;
  wire \uclk_chbond_counter_reg_n_0_[9] ;
  wire [1:1]uclk_loopback_int;
  wire uclk_loopback_reset;
  wire uclk_loopback_reset_i_1_n_0;
  wire uclk_mgt_enchansync;
  wire uclk_mgt_enchansync_reg;
  wire uclk_mgt_loopback;
  wire uclk_mgt_powerdown;
  wire uclk_mgt_powerdown_falling;
  wire uclk_mgt_powerdown_falling0;
  wire uclk_mgt_powerdown_r;
  wire uclk_mgt_rx_reset;
  wire uclk_mgt_rx_reset0;
  wire uclk_mgt_rx_reset5;
  wire uclk_mgt_rxbuf_reset0;
  wire \uclk_mgt_rxbuf_reset[3]_i_2_n_0 ;
  wire \uclk_mgt_rxbuf_reset[3]_i_3_n_0 ;
  wire \uclk_mgt_rxbuf_reset_reg_n_0_[0] ;
  wire \uclk_mgt_rxbufstatus_reg_reg_n_0_[0] ;
  wire \uclk_mgt_rxbufstatus_reg_reg_n_0_[10] ;
  wire \uclk_mgt_rxbufstatus_reg_reg_n_0_[11] ;
  wire \uclk_mgt_rxbufstatus_reg_reg_n_0_[1] ;
  wire \uclk_mgt_rxbufstatus_reg_reg_n_0_[2] ;
  wire \uclk_mgt_rxbufstatus_reg_reg_n_0_[6] ;
  wire \uclk_mgt_rxbufstatus_reg_reg_n_0_[7] ;
  wire \uclk_mgt_rxbufstatus_reg_reg_n_0_[8] ;
  wire \uclk_mgt_rxbufstatus_reg_reg_n_0_[9] ;
  wire uclk_mgt_tx_reset;
  wire uclk_mgt_tx_reset0;
  wire [3:0]uclk_mgt_txresetdone_reg;
  wire [3:0]uclk_signal_detect;
  wire \uclk_sync_counter[0]_i_1_n_0 ;
  wire \uclk_sync_counter[0]_i_3_n_0 ;
  wire \uclk_sync_counter[0]_i_4_n_0 ;
  wire \uclk_sync_counter[0]_i_5_n_0 ;
  wire \uclk_sync_counter[0]_i_6_n_0 ;
  wire \uclk_sync_counter[12]_i_2_n_0 ;
  wire \uclk_sync_counter[12]_i_3_n_0 ;
  wire \uclk_sync_counter[12]_i_4_n_0 ;
  wire \uclk_sync_counter[12]_i_5_n_0 ;
  wire \uclk_sync_counter[4]_i_2_n_0 ;
  wire \uclk_sync_counter[4]_i_3_n_0 ;
  wire \uclk_sync_counter[4]_i_4_n_0 ;
  wire \uclk_sync_counter[4]_i_5_n_0 ;
  wire \uclk_sync_counter[8]_i_2_n_0 ;
  wire \uclk_sync_counter[8]_i_3_n_0 ;
  wire \uclk_sync_counter[8]_i_4_n_0 ;
  wire \uclk_sync_counter[8]_i_5_n_0 ;
  wire \uclk_sync_counter_reg[0]_i_2_n_0 ;
  wire \uclk_sync_counter_reg[0]_i_2_n_1 ;
  wire \uclk_sync_counter_reg[0]_i_2_n_2 ;
  wire \uclk_sync_counter_reg[0]_i_2_n_3 ;
  wire \uclk_sync_counter_reg[0]_i_2_n_4 ;
  wire \uclk_sync_counter_reg[0]_i_2_n_5 ;
  wire \uclk_sync_counter_reg[0]_i_2_n_6 ;
  wire \uclk_sync_counter_reg[0]_i_2_n_7 ;
  wire \uclk_sync_counter_reg[12]_i_1_n_1 ;
  wire \uclk_sync_counter_reg[12]_i_1_n_2 ;
  wire \uclk_sync_counter_reg[12]_i_1_n_3 ;
  wire \uclk_sync_counter_reg[12]_i_1_n_4 ;
  wire \uclk_sync_counter_reg[12]_i_1_n_5 ;
  wire \uclk_sync_counter_reg[12]_i_1_n_6 ;
  wire \uclk_sync_counter_reg[12]_i_1_n_7 ;
  wire \uclk_sync_counter_reg[4]_i_1_n_0 ;
  wire \uclk_sync_counter_reg[4]_i_1_n_1 ;
  wire \uclk_sync_counter_reg[4]_i_1_n_2 ;
  wire \uclk_sync_counter_reg[4]_i_1_n_3 ;
  wire \uclk_sync_counter_reg[4]_i_1_n_4 ;
  wire \uclk_sync_counter_reg[4]_i_1_n_5 ;
  wire \uclk_sync_counter_reg[4]_i_1_n_6 ;
  wire \uclk_sync_counter_reg[4]_i_1_n_7 ;
  wire \uclk_sync_counter_reg[8]_i_1_n_0 ;
  wire \uclk_sync_counter_reg[8]_i_1_n_1 ;
  wire \uclk_sync_counter_reg[8]_i_1_n_2 ;
  wire \uclk_sync_counter_reg[8]_i_1_n_3 ;
  wire \uclk_sync_counter_reg[8]_i_1_n_4 ;
  wire \uclk_sync_counter_reg[8]_i_1_n_5 ;
  wire \uclk_sync_counter_reg[8]_i_1_n_6 ;
  wire \uclk_sync_counter_reg[8]_i_1_n_7 ;
  wire \uclk_sync_counter_reg_n_0_[0] ;
  wire \uclk_sync_counter_reg_n_0_[10] ;
  wire \uclk_sync_counter_reg_n_0_[11] ;
  wire \uclk_sync_counter_reg_n_0_[12] ;
  wire \uclk_sync_counter_reg_n_0_[13] ;
  wire \uclk_sync_counter_reg_n_0_[14] ;
  wire \uclk_sync_counter_reg_n_0_[1] ;
  wire \uclk_sync_counter_reg_n_0_[2] ;
  wire \uclk_sync_counter_reg_n_0_[3] ;
  wire \uclk_sync_counter_reg_n_0_[4] ;
  wire \uclk_sync_counter_reg_n_0_[5] ;
  wire \uclk_sync_counter_reg_n_0_[6] ;
  wire \uclk_sync_counter_reg_n_0_[7] ;
  wire \uclk_sync_counter_reg_n_0_[8] ;
  wire \uclk_sync_counter_reg_n_0_[9] ;
  wire uclk_txsync_start_phase_align_reg_n_0;
  wire xaui_core_n_120;
  wire xaui_core_n_121;
  wire xaui_core_n_122;
  wire xaui_core_n_123;
  wire xaui_core_n_124;
  wire xaui_core_n_125;
  wire xaui_core_n_126;
  wire xaui_core_n_127;
  wire xaui_core_n_128;
  wire xaui_core_n_129;
  wire xaui_core_n_130;
  wire xaui_core_n_131;
  wire xaui_core_n_132;
  wire xaui_core_n_133;
  wire xaui_core_n_134;
  wire xaui_core_n_135;
  wire xaui_core_n_142;
  wire xaui_core_n_143;
  wire xaui_core_n_147;
  wire xaui_rx_l0_n;
  wire xaui_rx_l0_p;
  wire xaui_rx_l1_n;
  wire xaui_rx_l1_p;
  wire xaui_rx_l2_n;
  wire xaui_rx_l2_p;
  wire xaui_rx_l3_n;
  wire xaui_rx_l3_p;
  wire xaui_tx_l0_n;
  wire xaui_tx_l0_p;
  wire xaui_tx_l1_n;
  wire xaui_tx_l1_p;
  wire xaui_tx_l2_n;
  wire xaui_tx_l2_p;
  wire xaui_tx_l3_n;
  wire xaui_tx_l3_p;
  wire [7:0]xgmii_rxc;
  wire [63:0]xgmii_rxd;
  wire [7:0]xgmii_txc;
  wire [63:0]xgmii_txd;
  wire [3:3]\NLW_uclk_chbond_counter_reg[12]_i_1_CO_UNCONNECTED ;
  wire [3:3]\NLW_uclk_sync_counter_reg[12]_i_1_CO_UNCONNECTED ;
  wire NLW_xaui_core_mdio_out_UNCONNECTED;
  wire NLW_xaui_core_mdio_tri_UNCONNECTED;
  wire NLW_xaui_core_soft_reset_UNCONNECTED;

  FDRE \core_mgt_rx_reset_reg[0] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(p_0_out[0]),
        .Q(mgt_rx_reset[0]),
        .R(1'b0));
  FDRE \core_mgt_rx_reset_reg[1] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(p_0_out[1]),
        .Q(mgt_rx_reset[1]),
        .R(1'b0));
  FDRE \core_mgt_rx_reset_reg[2] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(p_0_out[2]),
        .Q(mgt_rx_reset[2]),
        .R(1'b0));
  FDRE \core_mgt_rx_reset_reg[3] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(p_0_out[3]),
        .Q(mgt_rx_reset[3]),
        .R(1'b0));
  xaui_xaui_gt_wrapper gt_wrapper_i
       (.CLK(clk156_out),
        .D({gt0_txresetdone_out,gt1_txresetdone_out,gt2_txresetdone_out,gt3_txresetdone_out}),
        .Q({gt3_rxbufreset_in,gt2_rxbufreset_in,gt1_rxbufreset_in,\uclk_mgt_rxbuf_reset_reg_n_0_[0] }),
        .\core_mgt_rx_reset_reg[3] (p_0_out),
        .dclk(dclk),
        .gt0_dmonitorout_out(gt0_dmonitorout_out),
        .gt0_drpaddr(gt0_drpaddr),
        .gt0_drpdi(gt0_drpdi),
        .gt0_drpdo(gt0_drpdo),
        .gt0_drpen(gt0_drpen),
        .gt0_drprdy(gt0_drprdy),
        .gt0_drpwe(gt0_drpwe),
        .gt0_eyescandataerror_out(gt0_eyescandataerror_out),
        .gt0_eyescanreset_in(gt0_eyescanreset_in),
        .gt0_eyescantrigger_in(gt0_eyescantrigger_in),
        .gt0_loopback_in(gt0_loopback_in),
        .gt0_qpllreset_in(gt0_qpllreset_in),
        .gt0_rxcdrhold_in(gt0_rxcdrhold_in),
        .gt0_rxcommadet_out(gt0_rxcommadet_out),
        .gt0_rxdfelpmreset_in(gt0_rxdfelpmreset_in),
        .gt0_rxlpmen_in(gt0_rxlpmen_in),
        .gt0_rxmonitorout_out(gt0_rxmonitorout_out),
        .gt0_rxmonitorsel_in(gt0_rxmonitorsel_in),
        .gt0_rxpcsreset_in(gt0_rxpcsreset_in),
        .gt0_rxpmareset_in(gt0_rxpmareset),
        .gt0_rxpolarity_in(gt0_rxpolarity_in),
        .gt0_rxprbscntreset_in(gt0_rxprbscntreset_in),
        .gt0_rxprbserr_out(gt0_rxprbserr_out),
        .gt0_rxprbssel_in(gt0_rxprbssel_in),
        .gt0_rxrate_in(gt0_rxrate_in),
        .gt0_rxresetdone_out(gt0_rxresetdone_out),
        .gt0_txdiffctrl_in(gt0_txdiffctrl_in),
        .gt0_txdlyen_in(txsync_i_n_14),
        .gt0_txdlysreset_in(txsync_i_n_5),
        .gt0_txdlysresetdone_out(gt0_txdlysresetdone_out),
        .gt0_txinhibit_in(gt0_txinhibit_in),
        .gt0_txoutclk_out(gt0_txoutclk_i),
        .gt0_txpcsreset_in(gt0_txpcsreset_in),
        .gt0_txphalign_in(txsync_i_n_10),
        .gt0_txphaligndone_out(gt0_txphaligndone_out),
        .gt0_txphinit_in(txsync_i_n_6),
        .gt0_txphinitdone_out(gt0_txphinitdone_out),
        .gt0_txpmareset_in(gt0_txpmareset_in),
        .gt0_txpolarity_in(gt0_txpolarity_in),
        .gt0_txpostcursor_in(gt0_txpostcursor_in),
        .gt0_txprbsforceerr_in(gt0_txprbsforceerr_in),
        .gt0_txprbssel_in(gt0_txprbssel_in),
        .gt0_txprecursor_in(gt0_txprecursor_in),
        .gt1_dmonitorout_out(gt1_dmonitorout_out),
        .gt1_drpaddr(gt1_drpaddr),
        .gt1_drpdi(gt1_drpdi),
        .gt1_drpdo(gt1_drpdo),
        .gt1_drpen(gt1_drpen),
        .gt1_drprdy(gt1_drprdy),
        .gt1_drpwe(gt1_drpwe),
        .gt1_eyescandataerror_out(gt1_eyescandataerror_out),
        .gt1_eyescanreset_in(gt1_eyescanreset_in),
        .gt1_eyescantrigger_in(gt1_eyescantrigger_in),
        .gt1_loopback_in(gt1_loopback_in),
        .gt1_rxcdrhold_in(gt1_rxcdrhold_in),
        .gt1_rxcommadet_out(gt1_rxcommadet_out),
        .gt1_rxdfelpmreset_in(gt1_rxdfelpmreset_in),
        .gt1_rxlpmen_in(gt1_rxlpmen_in),
        .gt1_rxmonitorout_out(gt1_rxmonitorout_out),
        .gt1_rxmonitorsel_in(gt1_rxmonitorsel_in),
        .gt1_rxpcsreset_in(gt1_rxpcsreset_in),
        .gt1_rxpmareset_in(gt1_rxpmareset),
        .gt1_rxpolarity_in(gt1_rxpolarity_in),
        .gt1_rxprbscntreset_in(gt1_rxprbscntreset_in),
        .gt1_rxprbserr_out(gt1_rxprbserr_out),
        .gt1_rxprbssel_in(gt1_rxprbssel_in),
        .gt1_rxrate_in(gt1_rxrate_in),
        .gt1_rxresetdone_out(gt1_rxresetdone_out),
        .gt1_txdiffctrl_in(gt1_txdiffctrl_in),
        .gt1_txdlysreset_in(gt1_txdlysreset_in),
        .gt1_txdlysresetdone_out(gt1_txdlysresetdone_out),
        .gt1_txinhibit_in(gt1_txinhibit_in),
        .gt1_txpcsreset_in(gt1_txpcsreset_in),
        .gt1_txphalign_in(gt1_txphalign_in),
        .gt1_txphaligndone_out(gt1_txphaligndone_out),
        .gt1_txphinit_in(gt1_txphinit_in),
        .gt1_txphinitdone_out(gt1_txphinitdone_out),
        .gt1_txpmareset_in(gt1_txpmareset_in),
        .gt1_txpolarity_in(gt1_txpolarity_in),
        .gt1_txpostcursor_in(gt1_txpostcursor_in),
        .gt1_txprbsforceerr_in(gt1_txprbsforceerr_in),
        .gt1_txprbssel_in(gt1_txprbssel_in),
        .gt1_txprecursor_in(gt1_txprecursor_in),
        .gt2_dmonitorout_out(gt2_dmonitorout_out),
        .gt2_drpaddr(gt2_drpaddr),
        .gt2_drpdi(gt2_drpdi),
        .gt2_drpdo(gt2_drpdo),
        .gt2_drpen(gt2_drpen),
        .gt2_drprdy(gt2_drprdy),
        .gt2_drpwe(gt2_drpwe),
        .gt2_eyescandataerror_out(gt2_eyescandataerror_out),
        .gt2_eyescanreset_in(gt2_eyescanreset_in),
        .gt2_eyescantrigger_in(gt2_eyescantrigger_in),
        .gt2_loopback_in(gt2_loopback_in),
        .gt2_rxcdrhold_in(gt2_rxcdrhold_in),
        .gt2_rxcommadet_out(gt2_rxcommadet_out),
        .gt2_rxdfelpmreset_in(gt2_rxdfelpmreset_in),
        .gt2_rxlpmen_in(gt2_rxlpmen_in),
        .gt2_rxmonitorout_out(gt2_rxmonitorout_out),
        .gt2_rxmonitorsel_in(gt2_rxmonitorsel_in),
        .gt2_rxpcsreset_in(gt2_rxpcsreset_in),
        .gt2_rxpmareset_in(gt2_rxpmareset),
        .gt2_rxpolarity_in(gt2_rxpolarity_in),
        .gt2_rxprbscntreset_in(gt2_rxprbscntreset_in),
        .gt2_rxprbserr_out(gt2_rxprbserr_out),
        .gt2_rxprbssel_in(gt2_rxprbssel_in),
        .gt2_rxrate_in(gt2_rxrate_in),
        .gt2_rxresetdone_out(gt2_rxresetdone_out),
        .gt2_txdiffctrl_in(gt2_txdiffctrl_in),
        .gt2_txdlysreset_in(gt2_txdlysreset_in),
        .gt2_txdlysresetdone_out(gt2_txdlysresetdone_out),
        .gt2_txinhibit_in(gt2_txinhibit_in),
        .gt2_txpcsreset_in(gt2_txpcsreset_in),
        .gt2_txphalign_in(gt2_txphalign_in),
        .gt2_txphaligndone_out(gt2_txphaligndone_out),
        .gt2_txphinit_in(gt2_txphinit_in),
        .gt2_txphinitdone_out(gt2_txphinitdone_out),
        .gt2_txpmareset_in(gt2_txpmareset_in),
        .gt2_txpolarity_in(gt2_txpolarity_in),
        .gt2_txpostcursor_in(gt2_txpostcursor_in),
        .gt2_txprbsforceerr_in(gt2_txprbsforceerr_in),
        .gt2_txprbssel_in(gt2_txprbssel_in),
        .gt2_txprecursor_in(gt2_txprecursor_in),
        .gt3_dmonitorout_out(gt3_dmonitorout_out),
        .gt3_drpaddr(gt3_drpaddr),
        .gt3_drpdi(gt3_drpdi),
        .gt3_drpdo(gt3_drpdo),
        .gt3_drpen(gt3_drpen),
        .gt3_drprdy(gt3_drprdy),
        .gt3_drpwe(gt3_drpwe),
        .gt3_eyescandataerror_out(gt3_eyescandataerror_out),
        .gt3_eyescanreset_in(gt3_eyescanreset_in),
        .gt3_eyescantrigger_in(gt3_eyescantrigger_in),
        .gt3_gtrxreset_in(uclk_mgt_rx_reset),
        .gt3_loopback_in(gt3_loopback_in),
        .gt3_rxcdrhold_in(gt3_rxcdrhold_in),
        .gt3_rxchbonden_in(uclk_mgt_enchansync_reg),
        .gt3_rxcommadet_out(gt3_rxcommadet_out),
        .gt3_rxdfelpmreset_in(gt3_rxdfelpmreset_in),
        .gt3_rxlpmen_in(gt3_rxlpmen_in),
        .gt3_rxmonitorout_out(gt3_rxmonitorout_out),
        .gt3_rxmonitorsel_in(gt3_rxmonitorsel_in),
        .gt3_rxpcsreset_in(gt3_rxpcsreset_in),
        .gt3_rxpmareset_in(gt3_rxpmareset),
        .gt3_rxpolarity_in(gt3_rxpolarity_in),
        .gt3_rxprbscntreset_in(gt3_rxprbscntreset_in),
        .gt3_rxprbserr_out(gt3_rxprbserr_out),
        .gt3_rxprbssel_in(gt3_rxprbssel_in),
        .gt3_rxrate_in(gt3_rxrate_in),
        .gt3_rxresetdone_out(gt3_rxresetdone_out),
        .gt3_txdiffctrl_in(gt3_txdiffctrl_in),
        .gt3_txdlysreset_in(gt3_txdlysreset_in),
        .gt3_txdlysresetdone_out(gt3_txdlysresetdone_out),
        .gt3_txelecidle_in(uclk_mgt_powerdown_r),
        .gt3_txinhibit_in(gt3_txinhibit_in),
        .gt3_txpcsreset_in(gt3_txpcsreset_in),
        .gt3_txphalign_in(gt3_txphalign_in),
        .gt3_txphaligndone_out(gt3_txphaligndone_out),
        .gt3_txphinit_in(gt3_txphinit_in),
        .gt3_txphinitdone_out(gt3_txphinitdone_out),
        .gt3_txpmareset_in(gt3_txpmareset_in),
        .gt3_txpolarity_in(gt3_txpolarity_in),
        .gt3_txpostcursor_in(gt3_txpostcursor_in),
        .gt3_txprbsforceerr_in(gt3_txprbsforceerr_in),
        .gt3_txprbssel_in(gt3_txprbssel_in),
        .gt3_txprecursor_in(gt3_txprecursor_in),
        .gt3_txuserrdy_in(clk156_lock),
        .gt_qplllock_out(gt_qplllock_out),
        .\mgt_codecomma_reg_reg[7] ({gt3_rxchariscomma_out,gt2_rxchariscomma_out,gt1_rxchariscomma_out,gt0_rxchariscomma_out}),
        .mgt_enable_align({gt3_rxmcommaalignen_in,gt2_rxmcommaalignen_in,gt1_rxmcommaalignen_in,xaui_core_n_147}),
        .\mgt_rxcharisk_reg_reg[7] ({gt3_rxcharisk_out,gt2_rxcharisk_out,gt1_rxcharisk_out,gt0_rxcharisk_out}),
        .\mgt_rxdata_reg_reg[63] ({gt3_rxdata_out,gt2_rxdata_out,gt1_rxdata_out,gt0_rxdata_out}),
        .\mgt_rxdisperr_reg_reg[7] ({gt3_rxdisperr_out,gt2_rxdisperr_out,gt1_rxdisperr_out,gt0_rxdisperr_out}),
        .\mgt_rxnotintable_reg_reg[7] ({gt3_rxnotintable_out,gt2_rxnotintable_out,gt1_rxnotintable_out,gt0_rxnotintable_out}),
        .mgt_txcharisk({gt3_txcharisk_in,gt2_txcharisk_in,gt1_txcharisk_in,xaui_core_n_142,xaui_core_n_143}),
        .mgt_txdata({gt3_txdata_in,gt2_txdata_in,gt1_txdata_in,xaui_core_n_120,xaui_core_n_121,xaui_core_n_122,xaui_core_n_123,xaui_core_n_124,xaui_core_n_125,xaui_core_n_126,xaui_core_n_127,xaui_core_n_128,xaui_core_n_129,xaui_core_n_130,xaui_core_n_131,xaui_core_n_132,xaui_core_n_133,xaui_core_n_134,xaui_core_n_135}),
        .refclk(refclk),
        .uclk_loopback_int(uclk_loopback_int),
        .\uclk_mgt_rxbufstatus_reg_reg[11] ({gt3_rxbufstatus_out,gt2_rxbufstatus_out,gt1_rxbufstatus_out,gt0_rxbufstatus_out}),
        .uclk_mgt_tx_reset(uclk_mgt_tx_reset),
        .xaui_rx_l0_n(xaui_rx_l0_n),
        .xaui_rx_l0_p(xaui_rx_l0_p),
        .xaui_rx_l1_n(xaui_rx_l1_n),
        .xaui_rx_l1_p(xaui_rx_l1_p),
        .xaui_rx_l2_n(xaui_rx_l2_n),
        .xaui_rx_l2_p(xaui_rx_l2_p),
        .xaui_rx_l3_n(xaui_rx_l3_n),
        .xaui_rx_l3_p(xaui_rx_l3_p),
        .xaui_tx_l0_n(xaui_tx_l0_n),
        .xaui_tx_l0_p(xaui_tx_l0_p),
        .xaui_tx_l1_n(xaui_tx_l1_n),
        .xaui_tx_l1_p(xaui_tx_l1_p),
        .xaui_tx_l2_n(xaui_tx_l2_n),
        .xaui_tx_l2_p(xaui_tx_l2_p),
        .xaui_tx_l3_n(xaui_tx_l3_n),
        .xaui_tx_l3_p(xaui_tx_l3_p));
  FDRE \mgt_codecomma_reg_reg[0] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxchariscomma_out[0]),
        .Q(mgt_codecomma[0]),
        .R(1'b0));
  FDRE \mgt_codecomma_reg_reg[1] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxchariscomma_out[1]),
        .Q(mgt_codecomma[1]),
        .R(1'b0));
  FDRE \mgt_codecomma_reg_reg[2] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxchariscomma_out[0]),
        .Q(mgt_codecomma[2]),
        .R(1'b0));
  FDRE \mgt_codecomma_reg_reg[3] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxchariscomma_out[1]),
        .Q(mgt_codecomma[3]),
        .R(1'b0));
  FDRE \mgt_codecomma_reg_reg[4] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxchariscomma_out[0]),
        .Q(mgt_codecomma[4]),
        .R(1'b0));
  FDRE \mgt_codecomma_reg_reg[5] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxchariscomma_out[1]),
        .Q(mgt_codecomma[5]),
        .R(1'b0));
  FDRE \mgt_codecomma_reg_reg[6] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxchariscomma_out[0]),
        .Q(mgt_codecomma[6]),
        .R(1'b0));
  FDRE \mgt_codecomma_reg_reg[7] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxchariscomma_out[1]),
        .Q(mgt_codecomma[7]),
        .R(1'b0));
  FDRE \mgt_rxcharisk_reg_reg[0] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxcharisk_out[0]),
        .Q(\mgt_rxcharisk_reg_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \mgt_rxcharisk_reg_reg[1] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxcharisk_out[1]),
        .Q(\mgt_rxcharisk_reg_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \mgt_rxcharisk_reg_reg[2] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxcharisk_out[0]),
        .Q(\mgt_rxcharisk_reg_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \mgt_rxcharisk_reg_reg[3] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxcharisk_out[1]),
        .Q(\mgt_rxcharisk_reg_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \mgt_rxcharisk_reg_reg[4] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxcharisk_out[0]),
        .Q(\mgt_rxcharisk_reg_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \mgt_rxcharisk_reg_reg[5] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxcharisk_out[1]),
        .Q(\mgt_rxcharisk_reg_reg_n_0_[5] ),
        .R(1'b0));
  FDRE \mgt_rxcharisk_reg_reg[6] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxcharisk_out[0]),
        .Q(\mgt_rxcharisk_reg_reg_n_0_[6] ),
        .R(1'b0));
  FDRE \mgt_rxcharisk_reg_reg[7] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxcharisk_out[1]),
        .Q(\mgt_rxcharisk_reg_reg_n_0_[7] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[0] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxdata_out[0]),
        .Q(\mgt_rxdata_reg_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[10] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxdata_out[10]),
        .Q(\mgt_rxdata_reg_reg_n_0_[10] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[11] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxdata_out[11]),
        .Q(\mgt_rxdata_reg_reg_n_0_[11] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[12] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxdata_out[12]),
        .Q(\mgt_rxdata_reg_reg_n_0_[12] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[13] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxdata_out[13]),
        .Q(\mgt_rxdata_reg_reg_n_0_[13] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[14] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxdata_out[14]),
        .Q(\mgt_rxdata_reg_reg_n_0_[14] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[15] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxdata_out[15]),
        .Q(\mgt_rxdata_reg_reg_n_0_[15] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[16] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxdata_out[0]),
        .Q(\mgt_rxdata_reg_reg_n_0_[16] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[17] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxdata_out[1]),
        .Q(\mgt_rxdata_reg_reg_n_0_[17] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[18] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxdata_out[2]),
        .Q(\mgt_rxdata_reg_reg_n_0_[18] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[19] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxdata_out[3]),
        .Q(\mgt_rxdata_reg_reg_n_0_[19] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[1] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxdata_out[1]),
        .Q(\mgt_rxdata_reg_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[20] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxdata_out[4]),
        .Q(\mgt_rxdata_reg_reg_n_0_[20] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[21] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxdata_out[5]),
        .Q(\mgt_rxdata_reg_reg_n_0_[21] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[22] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxdata_out[6]),
        .Q(\mgt_rxdata_reg_reg_n_0_[22] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[23] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxdata_out[7]),
        .Q(\mgt_rxdata_reg_reg_n_0_[23] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[24] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxdata_out[8]),
        .Q(\mgt_rxdata_reg_reg_n_0_[24] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[25] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxdata_out[9]),
        .Q(\mgt_rxdata_reg_reg_n_0_[25] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[26] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxdata_out[10]),
        .Q(\mgt_rxdata_reg_reg_n_0_[26] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[27] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxdata_out[11]),
        .Q(\mgt_rxdata_reg_reg_n_0_[27] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[28] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxdata_out[12]),
        .Q(\mgt_rxdata_reg_reg_n_0_[28] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[29] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxdata_out[13]),
        .Q(\mgt_rxdata_reg_reg_n_0_[29] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[2] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxdata_out[2]),
        .Q(\mgt_rxdata_reg_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[30] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxdata_out[14]),
        .Q(\mgt_rxdata_reg_reg_n_0_[30] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[31] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxdata_out[15]),
        .Q(\mgt_rxdata_reg_reg_n_0_[31] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[32] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxdata_out[0]),
        .Q(\mgt_rxdata_reg_reg_n_0_[32] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[33] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxdata_out[1]),
        .Q(\mgt_rxdata_reg_reg_n_0_[33] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[34] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxdata_out[2]),
        .Q(\mgt_rxdata_reg_reg_n_0_[34] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[35] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxdata_out[3]),
        .Q(\mgt_rxdata_reg_reg_n_0_[35] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[36] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxdata_out[4]),
        .Q(\mgt_rxdata_reg_reg_n_0_[36] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[37] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxdata_out[5]),
        .Q(\mgt_rxdata_reg_reg_n_0_[37] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[38] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxdata_out[6]),
        .Q(\mgt_rxdata_reg_reg_n_0_[38] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[39] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxdata_out[7]),
        .Q(\mgt_rxdata_reg_reg_n_0_[39] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[3] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxdata_out[3]),
        .Q(\mgt_rxdata_reg_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[40] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxdata_out[8]),
        .Q(\mgt_rxdata_reg_reg_n_0_[40] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[41] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxdata_out[9]),
        .Q(\mgt_rxdata_reg_reg_n_0_[41] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[42] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxdata_out[10]),
        .Q(\mgt_rxdata_reg_reg_n_0_[42] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[43] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxdata_out[11]),
        .Q(\mgt_rxdata_reg_reg_n_0_[43] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[44] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxdata_out[12]),
        .Q(\mgt_rxdata_reg_reg_n_0_[44] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[45] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxdata_out[13]),
        .Q(\mgt_rxdata_reg_reg_n_0_[45] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[46] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxdata_out[14]),
        .Q(\mgt_rxdata_reg_reg_n_0_[46] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[47] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxdata_out[15]),
        .Q(\mgt_rxdata_reg_reg_n_0_[47] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[48] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxdata_out[0]),
        .Q(\mgt_rxdata_reg_reg_n_0_[48] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[49] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxdata_out[1]),
        .Q(\mgt_rxdata_reg_reg_n_0_[49] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[4] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxdata_out[4]),
        .Q(\mgt_rxdata_reg_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[50] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxdata_out[2]),
        .Q(\mgt_rxdata_reg_reg_n_0_[50] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[51] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxdata_out[3]),
        .Q(\mgt_rxdata_reg_reg_n_0_[51] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[52] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxdata_out[4]),
        .Q(\mgt_rxdata_reg_reg_n_0_[52] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[53] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxdata_out[5]),
        .Q(\mgt_rxdata_reg_reg_n_0_[53] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[54] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxdata_out[6]),
        .Q(\mgt_rxdata_reg_reg_n_0_[54] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[55] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxdata_out[7]),
        .Q(\mgt_rxdata_reg_reg_n_0_[55] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[56] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxdata_out[8]),
        .Q(\mgt_rxdata_reg_reg_n_0_[56] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[57] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxdata_out[9]),
        .Q(\mgt_rxdata_reg_reg_n_0_[57] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[58] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxdata_out[10]),
        .Q(\mgt_rxdata_reg_reg_n_0_[58] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[59] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxdata_out[11]),
        .Q(\mgt_rxdata_reg_reg_n_0_[59] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[5] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxdata_out[5]),
        .Q(\mgt_rxdata_reg_reg_n_0_[5] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[60] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxdata_out[12]),
        .Q(\mgt_rxdata_reg_reg_n_0_[60] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[61] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxdata_out[13]),
        .Q(\mgt_rxdata_reg_reg_n_0_[61] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[62] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxdata_out[14]),
        .Q(\mgt_rxdata_reg_reg_n_0_[62] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[63] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxdata_out[15]),
        .Q(\mgt_rxdata_reg_reg_n_0_[63] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[6] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxdata_out[6]),
        .Q(\mgt_rxdata_reg_reg_n_0_[6] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[7] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxdata_out[7]),
        .Q(\mgt_rxdata_reg_reg_n_0_[7] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[8] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxdata_out[8]),
        .Q(\mgt_rxdata_reg_reg_n_0_[8] ),
        .R(1'b0));
  FDRE \mgt_rxdata_reg_reg[9] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxdata_out[9]),
        .Q(\mgt_rxdata_reg_reg_n_0_[9] ),
        .R(1'b0));
  FDRE \mgt_rxdisperr_reg_reg[0] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxdisperr_out[0]),
        .Q(mgt_rxdisperr_reg[0]),
        .R(1'b0));
  FDRE \mgt_rxdisperr_reg_reg[1] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxdisperr_out[1]),
        .Q(mgt_rxdisperr_reg[1]),
        .R(1'b0));
  FDRE \mgt_rxdisperr_reg_reg[2] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxdisperr_out[0]),
        .Q(mgt_rxdisperr_reg[2]),
        .R(1'b0));
  FDRE \mgt_rxdisperr_reg_reg[3] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxdisperr_out[1]),
        .Q(mgt_rxdisperr_reg[3]),
        .R(1'b0));
  FDRE \mgt_rxdisperr_reg_reg[4] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxdisperr_out[0]),
        .Q(mgt_rxdisperr_reg[4]),
        .R(1'b0));
  FDRE \mgt_rxdisperr_reg_reg[5] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxdisperr_out[1]),
        .Q(mgt_rxdisperr_reg[5]),
        .R(1'b0));
  FDRE \mgt_rxdisperr_reg_reg[6] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxdisperr_out[0]),
        .Q(mgt_rxdisperr_reg[6]),
        .R(1'b0));
  FDRE \mgt_rxdisperr_reg_reg[7] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxdisperr_out[1]),
        .Q(mgt_rxdisperr_reg[7]),
        .R(1'b0));
  FDRE \mgt_rxnotintable_reg_reg[0] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxnotintable_out[0]),
        .Q(mgt_rxnotintable_reg[0]),
        .R(1'b0));
  FDRE \mgt_rxnotintable_reg_reg[1] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxnotintable_out[1]),
        .Q(mgt_rxnotintable_reg[1]),
        .R(1'b0));
  FDRE \mgt_rxnotintable_reg_reg[2] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxnotintable_out[0]),
        .Q(mgt_rxnotintable_reg[2]),
        .R(1'b0));
  FDRE \mgt_rxnotintable_reg_reg[3] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxnotintable_out[1]),
        .Q(mgt_rxnotintable_reg[3]),
        .R(1'b0));
  FDRE \mgt_rxnotintable_reg_reg[4] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxnotintable_out[0]),
        .Q(mgt_rxnotintable_reg[4]),
        .R(1'b0));
  FDRE \mgt_rxnotintable_reg_reg[5] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxnotintable_out[1]),
        .Q(mgt_rxnotintable_reg[5]),
        .R(1'b0));
  FDRE \mgt_rxnotintable_reg_reg[6] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxnotintable_out[0]),
        .Q(mgt_rxnotintable_reg[6]),
        .R(1'b0));
  FDRE \mgt_rxnotintable_reg_reg[7] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxnotintable_out[1]),
        .Q(mgt_rxnotintable_reg[7]),
        .R(1'b0));
  xaui_xaui_ff_synchronizer plllocked_sync_i
       (.CLK(clk156_out),
        .gt_qplllock_out(gt_qplllock_out),
        .out(clk156_lock),
        .uclk_mgt_rx_reset5(uclk_mgt_rx_reset5));
  xaui_xaui_ff_synchronizer_0 reset_count_done_sync_i
       (.CLK(clk156_out),
        .Q(uclk_mgt_txresetdone_reg),
        .\count_reg[7] (done),
        .out(p_0_in),
        .reset156(reset156),
        .\sync1_r_reg[2]_0 (clk156_lock),
        .\uclk_chbond_counter_reg[15] (uclk_cbm_rx_reset),
        .uclk_loopback_reset(uclk_loopback_reset),
        .uclk_mgt_powerdown_falling(uclk_mgt_powerdown_falling),
        .uclk_mgt_rx_reset0(uclk_mgt_rx_reset0),
        .uclk_mgt_tx_reset0(uclk_mgt_tx_reset0),
        .uclk_txsync_start_phase_align_reg(reset_count_done_sync_i_n_0),
        .uclk_txsync_start_phase_align_reg_0(uclk_txsync_start_phase_align_reg_n_0));
  xaui_xaui_reset_counter reset_counter_i
       (.D(done),
        .dclk(dclk),
        .gt0_qpllreset_in(gt0_qpllreset_in),
        .out(data_out));
  xaui_xaui_ff_synchronizer_1 reset_sync_i
       (.dclk(dclk),
        .out(data_out),
        .reset(reset));
  xaui_xaui_ff_synchronizer_2 rxpmareset_sync0_i
       (.dclk(dclk),
        .gt0_rxpmareset_in(gt0_rxpmareset_in),
        .out(gt0_rxpmareset));
  xaui_xaui_ff_synchronizer_3 rxpmareset_sync1_i
       (.dclk(dclk),
        .gt1_rxpmareset_in(gt1_rxpmareset_in),
        .out(gt1_rxpmareset));
  xaui_xaui_ff_synchronizer_4 rxpmareset_sync2_i
       (.dclk(dclk),
        .gt2_rxpmareset_in(gt2_rxpmareset_in),
        .out(gt2_rxpmareset));
  xaui_xaui_ff_synchronizer_5 rxpmareset_sync3_i
       (.dclk(dclk),
        .gt3_rxpmareset_in(gt3_rxpmareset_in),
        .out(gt3_rxpmareset));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    rxprbs_in_use_i_1
       (.I0(gt1_rxprbssel_in[0]),
        .I1(gt2_rxprbssel_in[2]),
        .I2(gt1_rxprbssel_in[1]),
        .I3(gt1_rxprbssel_in[2]),
        .I4(rxprbs_in_use_i_2_n_0),
        .I5(rxprbs_in_use_i_3_n_0),
        .O(rxprbs_in_use0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    rxprbs_in_use_i_2
       (.I0(gt0_rxprbssel_in[2]),
        .I1(gt3_rxprbssel_in[0]),
        .I2(gt0_rxprbssel_in[0]),
        .I3(gt0_rxprbssel_in[1]),
        .O(rxprbs_in_use_i_2_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    rxprbs_in_use_i_3
       (.I0(gt2_rxprbssel_in[0]),
        .I1(gt2_rxprbssel_in[1]),
        .I2(gt3_rxprbssel_in[1]),
        .I3(gt3_rxprbssel_in[2]),
        .O(rxprbs_in_use_i_3_n_0));
  FDRE #(
    .INIT(1'b0)) 
    rxprbs_in_use_reg
       (.C(clk156_out),
        .CE(1'b1),
        .D(rxprbs_in_use0),
        .Q(rxprbs_in_use),
        .R(1'b0));
  xaui_xaui_ff_synchronizer_6 signal_detect_0_sync_i
       (.out(uclk_signal_detect[0]),
        .signal_detect(signal_detect[0]),
        .uclk_mgt_rx_reset_reg(clk156_out));
  xaui_xaui_ff_synchronizer_7 signal_detect_1_sync_i
       (.out(uclk_signal_detect[1]),
        .signal_detect(signal_detect[1]),
        .uclk_mgt_rx_reset_reg(clk156_out));
  xaui_xaui_ff_synchronizer_8 signal_detect_2_sync_i
       (.out(uclk_signal_detect[2]),
        .signal_detect(signal_detect[2]),
        .uclk_mgt_rx_reset_reg(clk156_out));
  xaui_xaui_ff_synchronizer_9 signal_detect_3_sync_i
       (.out(uclk_signal_detect[3]),
        .signal_detect(signal_detect[3]),
        .uclk_mgt_rx_reset_reg(clk156_out));
  xaui_xaui_gt_wrapper_tx_sync_manual txsync_i
       (.\TXDLYEN_reg[0]_0 (txsync_i_n_14),
        .\TXDLYSRESET_reg[0]_0 (txsync_i_n_5),
        .\TXPHALIGN_reg[0]_0 (txsync_i_n_10),
        .\TXPHINIT_reg[0]_0 (txsync_i_n_6),
        .debug(debug[0]),
        .gt0_txdlysresetdone_out(gt0_txdlysresetdone_out),
        .gt0_txphaligndone_out(gt0_txphaligndone_out),
        .gt0_txphinitdone_out(gt0_txphinitdone_out),
        .gt1_txdlysreset_in(gt1_txdlysreset_in),
        .gt1_txdlysresetdone_out(gt1_txdlysresetdone_out),
        .gt1_txphalign_in(gt1_txphalign_in),
        .gt1_txphaligndone_out(gt1_txphaligndone_out),
        .gt1_txphinit_in(gt1_txphinit_in),
        .gt1_txphinitdone_out(gt1_txphinitdone_out),
        .gt2_txdlysreset_in(gt2_txdlysreset_in),
        .gt2_txdlysresetdone_out(gt2_txdlysresetdone_out),
        .gt2_txphalign_in(gt2_txphalign_in),
        .gt2_txphaligndone_out(gt2_txphaligndone_out),
        .gt2_txphinit_in(gt2_txphinit_in),
        .gt2_txphinitdone_out(gt2_txphinitdone_out),
        .gt3_txdlysreset_in(gt3_txdlysreset_in),
        .gt3_txdlysresetdone_out(gt3_txdlysresetdone_out),
        .gt3_txphalign_in(gt3_txphalign_in),
        .gt3_txphaligndone_out(gt3_txphaligndone_out),
        .gt3_txphinit_in(gt3_txphinit_in),
        .gt3_txphinitdone_out(gt3_txphinitdone_out),
        .mgt_tx_reset(txsync_i_n_1),
        .uclk_mgt_rx_reset_reg(clk156_out),
        .uclk_mgt_tx_reset(uclk_mgt_tx_reset),
        .uclk_txsync_start_phase_align_reg(uclk_txsync_start_phase_align_reg_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \uclk_chbond_counter[0]_i_1 
       (.I0(\uclk_chbond_counter[0]_i_3_n_0 ),
        .I1(uclk_cbm_rx_reset),
        .I2(debug[5]),
        .I3(rxprbs_in_use),
        .O(uclk_chbond_counter));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \uclk_chbond_counter[0]_i_3 
       (.I0(debug[1]),
        .I1(debug[3]),
        .I2(debug[4]),
        .I3(debug[2]),
        .O(\uclk_chbond_counter[0]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_chbond_counter[0]_i_4 
       (.I0(\uclk_chbond_counter_reg_n_0_[3] ),
        .O(\uclk_chbond_counter[0]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_chbond_counter[0]_i_5 
       (.I0(\uclk_chbond_counter_reg_n_0_[2] ),
        .O(\uclk_chbond_counter[0]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_chbond_counter[0]_i_6 
       (.I0(\uclk_chbond_counter_reg_n_0_[1] ),
        .O(\uclk_chbond_counter[0]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \uclk_chbond_counter[0]_i_7 
       (.I0(\uclk_chbond_counter_reg_n_0_[0] ),
        .O(\uclk_chbond_counter[0]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_chbond_counter[12]_i_2 
       (.I0(uclk_cbm_rx_reset),
        .O(\uclk_chbond_counter[12]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_chbond_counter[12]_i_3 
       (.I0(\uclk_chbond_counter_reg_n_0_[14] ),
        .O(\uclk_chbond_counter[12]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_chbond_counter[12]_i_4 
       (.I0(\uclk_chbond_counter_reg_n_0_[13] ),
        .O(\uclk_chbond_counter[12]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_chbond_counter[12]_i_5 
       (.I0(\uclk_chbond_counter_reg_n_0_[12] ),
        .O(\uclk_chbond_counter[12]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_chbond_counter[4]_i_2 
       (.I0(\uclk_chbond_counter_reg_n_0_[7] ),
        .O(\uclk_chbond_counter[4]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_chbond_counter[4]_i_3 
       (.I0(\uclk_chbond_counter_reg_n_0_[6] ),
        .O(\uclk_chbond_counter[4]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_chbond_counter[4]_i_4 
       (.I0(\uclk_chbond_counter_reg_n_0_[5] ),
        .O(\uclk_chbond_counter[4]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_chbond_counter[4]_i_5 
       (.I0(\uclk_chbond_counter_reg_n_0_[4] ),
        .O(\uclk_chbond_counter[4]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_chbond_counter[8]_i_2 
       (.I0(\uclk_chbond_counter_reg_n_0_[11] ),
        .O(\uclk_chbond_counter[8]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_chbond_counter[8]_i_3 
       (.I0(\uclk_chbond_counter_reg_n_0_[10] ),
        .O(\uclk_chbond_counter[8]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_chbond_counter[8]_i_4 
       (.I0(\uclk_chbond_counter_reg_n_0_[9] ),
        .O(\uclk_chbond_counter[8]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_chbond_counter[8]_i_5 
       (.I0(\uclk_chbond_counter_reg_n_0_[8] ),
        .O(\uclk_chbond_counter[8]_i_5_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_chbond_counter_reg[0] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_chbond_counter_reg[0]_i_2_n_7 ),
        .Q(\uclk_chbond_counter_reg_n_0_[0] ),
        .R(uclk_chbond_counter));
  CARRY4 \uclk_chbond_counter_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\uclk_chbond_counter_reg[0]_i_2_n_0 ,\uclk_chbond_counter_reg[0]_i_2_n_1 ,\uclk_chbond_counter_reg[0]_i_2_n_2 ,\uclk_chbond_counter_reg[0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\uclk_chbond_counter_reg[0]_i_2_n_4 ,\uclk_chbond_counter_reg[0]_i_2_n_5 ,\uclk_chbond_counter_reg[0]_i_2_n_6 ,\uclk_chbond_counter_reg[0]_i_2_n_7 }),
        .S({\uclk_chbond_counter[0]_i_4_n_0 ,\uclk_chbond_counter[0]_i_5_n_0 ,\uclk_chbond_counter[0]_i_6_n_0 ,\uclk_chbond_counter[0]_i_7_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_chbond_counter_reg[10] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_chbond_counter_reg[8]_i_1_n_5 ),
        .Q(\uclk_chbond_counter_reg_n_0_[10] ),
        .R(uclk_chbond_counter));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_chbond_counter_reg[11] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_chbond_counter_reg[8]_i_1_n_4 ),
        .Q(\uclk_chbond_counter_reg_n_0_[11] ),
        .R(uclk_chbond_counter));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_chbond_counter_reg[12] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_chbond_counter_reg[12]_i_1_n_7 ),
        .Q(\uclk_chbond_counter_reg_n_0_[12] ),
        .R(uclk_chbond_counter));
  CARRY4 \uclk_chbond_counter_reg[12]_i_1 
       (.CI(\uclk_chbond_counter_reg[8]_i_1_n_0 ),
        .CO({\NLW_uclk_chbond_counter_reg[12]_i_1_CO_UNCONNECTED [3],\uclk_chbond_counter_reg[12]_i_1_n_1 ,\uclk_chbond_counter_reg[12]_i_1_n_2 ,\uclk_chbond_counter_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\uclk_chbond_counter_reg[12]_i_1_n_4 ,\uclk_chbond_counter_reg[12]_i_1_n_5 ,\uclk_chbond_counter_reg[12]_i_1_n_6 ,\uclk_chbond_counter_reg[12]_i_1_n_7 }),
        .S({\uclk_chbond_counter[12]_i_2_n_0 ,\uclk_chbond_counter[12]_i_3_n_0 ,\uclk_chbond_counter[12]_i_4_n_0 ,\uclk_chbond_counter[12]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_chbond_counter_reg[13] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_chbond_counter_reg[12]_i_1_n_6 ),
        .Q(\uclk_chbond_counter_reg_n_0_[13] ),
        .R(uclk_chbond_counter));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_chbond_counter_reg[14] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_chbond_counter_reg[12]_i_1_n_5 ),
        .Q(\uclk_chbond_counter_reg_n_0_[14] ),
        .R(uclk_chbond_counter));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_chbond_counter_reg[15] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_chbond_counter_reg[12]_i_1_n_4 ),
        .Q(uclk_cbm_rx_reset),
        .R(uclk_chbond_counter));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_chbond_counter_reg[1] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_chbond_counter_reg[0]_i_2_n_6 ),
        .Q(\uclk_chbond_counter_reg_n_0_[1] ),
        .R(uclk_chbond_counter));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_chbond_counter_reg[2] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_chbond_counter_reg[0]_i_2_n_5 ),
        .Q(\uclk_chbond_counter_reg_n_0_[2] ),
        .R(uclk_chbond_counter));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_chbond_counter_reg[3] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_chbond_counter_reg[0]_i_2_n_4 ),
        .Q(\uclk_chbond_counter_reg_n_0_[3] ),
        .R(uclk_chbond_counter));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_chbond_counter_reg[4] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_chbond_counter_reg[4]_i_1_n_7 ),
        .Q(\uclk_chbond_counter_reg_n_0_[4] ),
        .R(uclk_chbond_counter));
  CARRY4 \uclk_chbond_counter_reg[4]_i_1 
       (.CI(\uclk_chbond_counter_reg[0]_i_2_n_0 ),
        .CO({\uclk_chbond_counter_reg[4]_i_1_n_0 ,\uclk_chbond_counter_reg[4]_i_1_n_1 ,\uclk_chbond_counter_reg[4]_i_1_n_2 ,\uclk_chbond_counter_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\uclk_chbond_counter_reg[4]_i_1_n_4 ,\uclk_chbond_counter_reg[4]_i_1_n_5 ,\uclk_chbond_counter_reg[4]_i_1_n_6 ,\uclk_chbond_counter_reg[4]_i_1_n_7 }),
        .S({\uclk_chbond_counter[4]_i_2_n_0 ,\uclk_chbond_counter[4]_i_3_n_0 ,\uclk_chbond_counter[4]_i_4_n_0 ,\uclk_chbond_counter[4]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_chbond_counter_reg[5] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_chbond_counter_reg[4]_i_1_n_6 ),
        .Q(\uclk_chbond_counter_reg_n_0_[5] ),
        .R(uclk_chbond_counter));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_chbond_counter_reg[6] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_chbond_counter_reg[4]_i_1_n_5 ),
        .Q(\uclk_chbond_counter_reg_n_0_[6] ),
        .R(uclk_chbond_counter));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_chbond_counter_reg[7] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_chbond_counter_reg[4]_i_1_n_4 ),
        .Q(\uclk_chbond_counter_reg_n_0_[7] ),
        .R(uclk_chbond_counter));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_chbond_counter_reg[8] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_chbond_counter_reg[8]_i_1_n_7 ),
        .Q(\uclk_chbond_counter_reg_n_0_[8] ),
        .R(uclk_chbond_counter));
  CARRY4 \uclk_chbond_counter_reg[8]_i_1 
       (.CI(\uclk_chbond_counter_reg[4]_i_1_n_0 ),
        .CO({\uclk_chbond_counter_reg[8]_i_1_n_0 ,\uclk_chbond_counter_reg[8]_i_1_n_1 ,\uclk_chbond_counter_reg[8]_i_1_n_2 ,\uclk_chbond_counter_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\uclk_chbond_counter_reg[8]_i_1_n_4 ,\uclk_chbond_counter_reg[8]_i_1_n_5 ,\uclk_chbond_counter_reg[8]_i_1_n_6 ,\uclk_chbond_counter_reg[8]_i_1_n_7 }),
        .S({\uclk_chbond_counter[8]_i_2_n_0 ,\uclk_chbond_counter[8]_i_3_n_0 ,\uclk_chbond_counter[8]_i_4_n_0 ,\uclk_chbond_counter[8]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_chbond_counter_reg[9] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_chbond_counter_reg[8]_i_1_n_6 ),
        .Q(\uclk_chbond_counter_reg_n_0_[9] ),
        .R(uclk_chbond_counter));
  LUT2 #(
    .INIT(4'h2)) 
    uclk_loopback_reset_i_1
       (.I0(uclk_loopback_int),
        .I1(uclk_mgt_loopback),
        .O(uclk_loopback_reset_i_1_n_0));
  FDRE uclk_loopback_reset_reg
       (.C(clk156_out),
        .CE(1'b1),
        .D(uclk_loopback_reset_i_1_n_0),
        .Q(uclk_loopback_reset),
        .R(1'b0));
  FDRE uclk_mgt_enchansync_reg_reg
       (.C(clk156_out),
        .CE(1'b1),
        .D(uclk_mgt_enchansync),
        .Q(uclk_mgt_enchansync_reg),
        .R(1'b0));
  FDRE uclk_mgt_loopback_reg_reg
       (.C(clk156_out),
        .CE(1'b1),
        .D(uclk_mgt_loopback),
        .Q(uclk_loopback_int),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h2)) 
    uclk_mgt_powerdown_falling_i_1
       (.I0(uclk_mgt_powerdown_r),
        .I1(uclk_mgt_powerdown),
        .O(uclk_mgt_powerdown_falling0));
  FDCE uclk_mgt_powerdown_falling_reg
       (.C(clk156_out),
        .CE(1'b1),
        .CLR(reset156),
        .D(uclk_mgt_powerdown_falling0),
        .Q(uclk_mgt_powerdown_falling));
  FDRE uclk_mgt_powerdown_r_reg
       (.C(clk156_out),
        .CE(1'b1),
        .D(uclk_mgt_powerdown),
        .Q(uclk_mgt_powerdown_r),
        .R(1'b0));
  FDRE uclk_mgt_rx_reset_reg
       (.C(clk156_out),
        .CE(1'b1),
        .D(uclk_mgt_rx_reset0),
        .Q(uclk_mgt_rx_reset),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hEEFEFEEE)) 
    \uclk_mgt_rxbuf_reset[3]_i_1 
       (.I0(\uclk_mgt_rxbuf_reset[3]_i_2_n_0 ),
        .I1(\uclk_mgt_rxbuf_reset[3]_i_3_n_0 ),
        .I2(\uclk_mgt_rxbufstatus_reg_reg_n_0_[8] ),
        .I3(\uclk_mgt_rxbufstatus_reg_reg_n_0_[6] ),
        .I4(\uclk_mgt_rxbufstatus_reg_reg_n_0_[7] ),
        .O(uclk_mgt_rxbuf_reset0));
  LUT4 #(
    .INIT(16'hBEAA)) 
    \uclk_mgt_rxbuf_reset[3]_i_2 
       (.I0(uclk_cbm_rx_reset),
        .I1(\uclk_mgt_rxbufstatus_reg_reg_n_0_[1] ),
        .I2(\uclk_mgt_rxbufstatus_reg_reg_n_0_[0] ),
        .I3(\uclk_mgt_rxbufstatus_reg_reg_n_0_[2] ),
        .O(\uclk_mgt_rxbuf_reset[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h60FFFF6060606060)) 
    \uclk_mgt_rxbuf_reset[3]_i_3 
       (.I0(bufStatus[1]),
        .I1(bufStatus[0]),
        .I2(bufStatus[2]),
        .I3(\uclk_mgt_rxbufstatus_reg_reg_n_0_[10] ),
        .I4(\uclk_mgt_rxbufstatus_reg_reg_n_0_[9] ),
        .I5(\uclk_mgt_rxbufstatus_reg_reg_n_0_[11] ),
        .O(\uclk_mgt_rxbuf_reset[3]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_mgt_rxbuf_reset_reg[0] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(uclk_mgt_rxbuf_reset0),
        .Q(\uclk_mgt_rxbuf_reset_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_mgt_rxbuf_reset_reg[1] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(uclk_mgt_rxbuf_reset0),
        .Q(gt1_rxbufreset_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_mgt_rxbuf_reset_reg[2] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(uclk_mgt_rxbuf_reset0),
        .Q(gt2_rxbufreset_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_mgt_rxbuf_reset_reg[3] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(uclk_mgt_rxbuf_reset0),
        .Q(gt3_rxbufreset_in),
        .R(1'b0));
  FDRE \uclk_mgt_rxbufstatus_reg_reg[0] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxbufstatus_out[0]),
        .Q(\uclk_mgt_rxbufstatus_reg_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \uclk_mgt_rxbufstatus_reg_reg[10] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxbufstatus_out[1]),
        .Q(\uclk_mgt_rxbufstatus_reg_reg_n_0_[10] ),
        .R(1'b0));
  FDRE \uclk_mgt_rxbufstatus_reg_reg[11] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxbufstatus_out[2]),
        .Q(\uclk_mgt_rxbufstatus_reg_reg_n_0_[11] ),
        .R(1'b0));
  FDRE \uclk_mgt_rxbufstatus_reg_reg[1] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxbufstatus_out[1]),
        .Q(\uclk_mgt_rxbufstatus_reg_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \uclk_mgt_rxbufstatus_reg_reg[2] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_rxbufstatus_out[2]),
        .Q(\uclk_mgt_rxbufstatus_reg_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \uclk_mgt_rxbufstatus_reg_reg[3] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxbufstatus_out[0]),
        .Q(bufStatus[0]),
        .R(1'b0));
  FDRE \uclk_mgt_rxbufstatus_reg_reg[4] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxbufstatus_out[1]),
        .Q(bufStatus[1]),
        .R(1'b0));
  FDRE \uclk_mgt_rxbufstatus_reg_reg[5] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_rxbufstatus_out[2]),
        .Q(bufStatus[2]),
        .R(1'b0));
  FDRE \uclk_mgt_rxbufstatus_reg_reg[6] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxbufstatus_out[0]),
        .Q(\uclk_mgt_rxbufstatus_reg_reg_n_0_[6] ),
        .R(1'b0));
  FDRE \uclk_mgt_rxbufstatus_reg_reg[7] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxbufstatus_out[1]),
        .Q(\uclk_mgt_rxbufstatus_reg_reg_n_0_[7] ),
        .R(1'b0));
  FDRE \uclk_mgt_rxbufstatus_reg_reg[8] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_rxbufstatus_out[2]),
        .Q(\uclk_mgt_rxbufstatus_reg_reg_n_0_[8] ),
        .R(1'b0));
  FDRE \uclk_mgt_rxbufstatus_reg_reg[9] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_rxbufstatus_out[0]),
        .Q(\uclk_mgt_rxbufstatus_reg_reg_n_0_[9] ),
        .R(1'b0));
  FDRE uclk_mgt_tx_reset_reg
       (.C(clk156_out),
        .CE(1'b1),
        .D(uclk_mgt_tx_reset0),
        .Q(uclk_mgt_tx_reset),
        .R(1'b0));
  FDRE \uclk_mgt_txresetdone_reg_reg[0] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt3_txresetdone_out),
        .Q(uclk_mgt_txresetdone_reg[0]),
        .R(1'b0));
  FDRE \uclk_mgt_txresetdone_reg_reg[1] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt2_txresetdone_out),
        .Q(uclk_mgt_txresetdone_reg[1]),
        .R(1'b0));
  FDRE \uclk_mgt_txresetdone_reg_reg[2] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt1_txresetdone_out),
        .Q(uclk_mgt_txresetdone_reg[2]),
        .R(1'b0));
  FDRE \uclk_mgt_txresetdone_reg_reg[3] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(gt0_txresetdone_out),
        .Q(uclk_mgt_txresetdone_reg[3]),
        .R(1'b0));
  LUT4 #(
    .INIT(16'hFFFD)) 
    \uclk_sync_counter[0]_i_1 
       (.I0(\uclk_chbond_counter[0]_i_3_n_0 ),
        .I1(rxprbs_in_use),
        .I2(uclk_mgt_powerdown),
        .I3(p_0_in),
        .O(\uclk_sync_counter[0]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_sync_counter[0]_i_3 
       (.I0(\uclk_sync_counter_reg_n_0_[3] ),
        .O(\uclk_sync_counter[0]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_sync_counter[0]_i_4 
       (.I0(\uclk_sync_counter_reg_n_0_[2] ),
        .O(\uclk_sync_counter[0]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_sync_counter[0]_i_5 
       (.I0(\uclk_sync_counter_reg_n_0_[1] ),
        .O(\uclk_sync_counter[0]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \uclk_sync_counter[0]_i_6 
       (.I0(\uclk_sync_counter_reg_n_0_[0] ),
        .O(\uclk_sync_counter[0]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_sync_counter[12]_i_2 
       (.I0(p_0_in),
        .O(\uclk_sync_counter[12]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_sync_counter[12]_i_3 
       (.I0(\uclk_sync_counter_reg_n_0_[14] ),
        .O(\uclk_sync_counter[12]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_sync_counter[12]_i_4 
       (.I0(\uclk_sync_counter_reg_n_0_[13] ),
        .O(\uclk_sync_counter[12]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_sync_counter[12]_i_5 
       (.I0(\uclk_sync_counter_reg_n_0_[12] ),
        .O(\uclk_sync_counter[12]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_sync_counter[4]_i_2 
       (.I0(\uclk_sync_counter_reg_n_0_[7] ),
        .O(\uclk_sync_counter[4]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_sync_counter[4]_i_3 
       (.I0(\uclk_sync_counter_reg_n_0_[6] ),
        .O(\uclk_sync_counter[4]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_sync_counter[4]_i_4 
       (.I0(\uclk_sync_counter_reg_n_0_[5] ),
        .O(\uclk_sync_counter[4]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_sync_counter[4]_i_5 
       (.I0(\uclk_sync_counter_reg_n_0_[4] ),
        .O(\uclk_sync_counter[4]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_sync_counter[8]_i_2 
       (.I0(\uclk_sync_counter_reg_n_0_[11] ),
        .O(\uclk_sync_counter[8]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_sync_counter[8]_i_3 
       (.I0(\uclk_sync_counter_reg_n_0_[10] ),
        .O(\uclk_sync_counter[8]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_sync_counter[8]_i_4 
       (.I0(\uclk_sync_counter_reg_n_0_[9] ),
        .O(\uclk_sync_counter[8]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \uclk_sync_counter[8]_i_5 
       (.I0(\uclk_sync_counter_reg_n_0_[8] ),
        .O(\uclk_sync_counter[8]_i_5_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_sync_counter_reg[0] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_sync_counter_reg[0]_i_2_n_7 ),
        .Q(\uclk_sync_counter_reg_n_0_[0] ),
        .R(\uclk_sync_counter[0]_i_1_n_0 ));
  CARRY4 \uclk_sync_counter_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\uclk_sync_counter_reg[0]_i_2_n_0 ,\uclk_sync_counter_reg[0]_i_2_n_1 ,\uclk_sync_counter_reg[0]_i_2_n_2 ,\uclk_sync_counter_reg[0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\uclk_sync_counter_reg[0]_i_2_n_4 ,\uclk_sync_counter_reg[0]_i_2_n_5 ,\uclk_sync_counter_reg[0]_i_2_n_6 ,\uclk_sync_counter_reg[0]_i_2_n_7 }),
        .S({\uclk_sync_counter[0]_i_3_n_0 ,\uclk_sync_counter[0]_i_4_n_0 ,\uclk_sync_counter[0]_i_5_n_0 ,\uclk_sync_counter[0]_i_6_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_sync_counter_reg[10] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_sync_counter_reg[8]_i_1_n_5 ),
        .Q(\uclk_sync_counter_reg_n_0_[10] ),
        .R(\uclk_sync_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_sync_counter_reg[11] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_sync_counter_reg[8]_i_1_n_4 ),
        .Q(\uclk_sync_counter_reg_n_0_[11] ),
        .R(\uclk_sync_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_sync_counter_reg[12] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_sync_counter_reg[12]_i_1_n_7 ),
        .Q(\uclk_sync_counter_reg_n_0_[12] ),
        .R(\uclk_sync_counter[0]_i_1_n_0 ));
  CARRY4 \uclk_sync_counter_reg[12]_i_1 
       (.CI(\uclk_sync_counter_reg[8]_i_1_n_0 ),
        .CO({\NLW_uclk_sync_counter_reg[12]_i_1_CO_UNCONNECTED [3],\uclk_sync_counter_reg[12]_i_1_n_1 ,\uclk_sync_counter_reg[12]_i_1_n_2 ,\uclk_sync_counter_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\uclk_sync_counter_reg[12]_i_1_n_4 ,\uclk_sync_counter_reg[12]_i_1_n_5 ,\uclk_sync_counter_reg[12]_i_1_n_6 ,\uclk_sync_counter_reg[12]_i_1_n_7 }),
        .S({\uclk_sync_counter[12]_i_2_n_0 ,\uclk_sync_counter[12]_i_3_n_0 ,\uclk_sync_counter[12]_i_4_n_0 ,\uclk_sync_counter[12]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_sync_counter_reg[13] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_sync_counter_reg[12]_i_1_n_6 ),
        .Q(\uclk_sync_counter_reg_n_0_[13] ),
        .R(\uclk_sync_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_sync_counter_reg[14] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_sync_counter_reg[12]_i_1_n_5 ),
        .Q(\uclk_sync_counter_reg_n_0_[14] ),
        .R(\uclk_sync_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_sync_counter_reg[15] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_sync_counter_reg[12]_i_1_n_4 ),
        .Q(p_0_in),
        .R(\uclk_sync_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_sync_counter_reg[1] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_sync_counter_reg[0]_i_2_n_6 ),
        .Q(\uclk_sync_counter_reg_n_0_[1] ),
        .R(\uclk_sync_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_sync_counter_reg[2] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_sync_counter_reg[0]_i_2_n_5 ),
        .Q(\uclk_sync_counter_reg_n_0_[2] ),
        .R(\uclk_sync_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_sync_counter_reg[3] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_sync_counter_reg[0]_i_2_n_4 ),
        .Q(\uclk_sync_counter_reg_n_0_[3] ),
        .R(\uclk_sync_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_sync_counter_reg[4] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_sync_counter_reg[4]_i_1_n_7 ),
        .Q(\uclk_sync_counter_reg_n_0_[4] ),
        .R(\uclk_sync_counter[0]_i_1_n_0 ));
  CARRY4 \uclk_sync_counter_reg[4]_i_1 
       (.CI(\uclk_sync_counter_reg[0]_i_2_n_0 ),
        .CO({\uclk_sync_counter_reg[4]_i_1_n_0 ,\uclk_sync_counter_reg[4]_i_1_n_1 ,\uclk_sync_counter_reg[4]_i_1_n_2 ,\uclk_sync_counter_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\uclk_sync_counter_reg[4]_i_1_n_4 ,\uclk_sync_counter_reg[4]_i_1_n_5 ,\uclk_sync_counter_reg[4]_i_1_n_6 ,\uclk_sync_counter_reg[4]_i_1_n_7 }),
        .S({\uclk_sync_counter[4]_i_2_n_0 ,\uclk_sync_counter[4]_i_3_n_0 ,\uclk_sync_counter[4]_i_4_n_0 ,\uclk_sync_counter[4]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_sync_counter_reg[5] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_sync_counter_reg[4]_i_1_n_6 ),
        .Q(\uclk_sync_counter_reg_n_0_[5] ),
        .R(\uclk_sync_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_sync_counter_reg[6] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_sync_counter_reg[4]_i_1_n_5 ),
        .Q(\uclk_sync_counter_reg_n_0_[6] ),
        .R(\uclk_sync_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_sync_counter_reg[7] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_sync_counter_reg[4]_i_1_n_4 ),
        .Q(\uclk_sync_counter_reg_n_0_[7] ),
        .R(\uclk_sync_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_sync_counter_reg[8] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_sync_counter_reg[8]_i_1_n_7 ),
        .Q(\uclk_sync_counter_reg_n_0_[8] ),
        .R(\uclk_sync_counter[0]_i_1_n_0 ));
  CARRY4 \uclk_sync_counter_reg[8]_i_1 
       (.CI(\uclk_sync_counter_reg[4]_i_1_n_0 ),
        .CO({\uclk_sync_counter_reg[8]_i_1_n_0 ,\uclk_sync_counter_reg[8]_i_1_n_1 ,\uclk_sync_counter_reg[8]_i_1_n_2 ,\uclk_sync_counter_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\uclk_sync_counter_reg[8]_i_1_n_4 ,\uclk_sync_counter_reg[8]_i_1_n_5 ,\uclk_sync_counter_reg[8]_i_1_n_6 ,\uclk_sync_counter_reg[8]_i_1_n_7 }),
        .S({\uclk_sync_counter[8]_i_2_n_0 ,\uclk_sync_counter[8]_i_3_n_0 ,\uclk_sync_counter[8]_i_4_n_0 ,\uclk_sync_counter[8]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \uclk_sync_counter_reg[9] 
       (.C(clk156_out),
        .CE(1'b1),
        .D(\uclk_sync_counter_reg[8]_i_1_n_6 ),
        .Q(\uclk_sync_counter_reg_n_0_[9] ),
        .R(\uclk_sync_counter[0]_i_1_n_0 ));
  FDRE uclk_txsync_start_phase_align_reg
       (.C(clk156_out),
        .CE(1'b1),
        .D(reset_count_done_sync_i_n_0),
        .Q(uclk_txsync_start_phase_align_reg_n_0),
        .R(1'b0));
  xaui_xaui_cl_clocking xaui_cl_clocking_i
       (.clk156_out(clk156_out),
        .gt0_txoutclk_i(gt0_txoutclk_i));
  xaui_xaui_cl_resets xaui_cl_resets_i
       (.reset(reset),
        .reset156(reset156),
        .uclk_mgt_rx_reset5(uclk_mgt_rx_reset5),
        .uclk_mgt_rx_reset_reg(clk156_out));
  (* C_FAMILY = "kintex7" *) 
  (* C_HAS_MDIO = "FALSE" *) 
  (* DONT_TOUCH *) 
  (* c_is_dxaui = "FALSE" *) 
  xaui_xaui_v12_2_3_top xaui_core
       (.align_status(debug[5]),
        .configuration_vector(configuration_vector),
        .mdc(1'b0),
        .mdio_in(1'b0),
        .mdio_out(NLW_xaui_core_mdio_out_UNCONNECTED),
        .mdio_tri(NLW_xaui_core_mdio_tri_UNCONNECTED),
        .mgt_codecomma(mgt_codecomma),
        .mgt_codevalid(mgt_codevalid),
        .mgt_enable_align({gt3_rxmcommaalignen_in,gt2_rxmcommaalignen_in,gt1_rxmcommaalignen_in,xaui_core_n_147}),
        .mgt_enchansync(uclk_mgt_enchansync),
        .mgt_loopback(uclk_mgt_loopback),
        .mgt_powerdown(uclk_mgt_powerdown),
        .mgt_rx_reset(mgt_rx_reset),
        .mgt_rxcharisk({\mgt_rxcharisk_reg_reg_n_0_[7] ,\mgt_rxcharisk_reg_reg_n_0_[6] ,\mgt_rxcharisk_reg_reg_n_0_[5] ,\mgt_rxcharisk_reg_reg_n_0_[4] ,\mgt_rxcharisk_reg_reg_n_0_[3] ,\mgt_rxcharisk_reg_reg_n_0_[2] ,\mgt_rxcharisk_reg_reg_n_0_[1] ,\mgt_rxcharisk_reg_reg_n_0_[0] }),
        .mgt_rxdata({\mgt_rxdata_reg_reg_n_0_[63] ,\mgt_rxdata_reg_reg_n_0_[62] ,\mgt_rxdata_reg_reg_n_0_[61] ,\mgt_rxdata_reg_reg_n_0_[60] ,\mgt_rxdata_reg_reg_n_0_[59] ,\mgt_rxdata_reg_reg_n_0_[58] ,\mgt_rxdata_reg_reg_n_0_[57] ,\mgt_rxdata_reg_reg_n_0_[56] ,\mgt_rxdata_reg_reg_n_0_[55] ,\mgt_rxdata_reg_reg_n_0_[54] ,\mgt_rxdata_reg_reg_n_0_[53] ,\mgt_rxdata_reg_reg_n_0_[52] ,\mgt_rxdata_reg_reg_n_0_[51] ,\mgt_rxdata_reg_reg_n_0_[50] ,\mgt_rxdata_reg_reg_n_0_[49] ,\mgt_rxdata_reg_reg_n_0_[48] ,\mgt_rxdata_reg_reg_n_0_[47] ,\mgt_rxdata_reg_reg_n_0_[46] ,\mgt_rxdata_reg_reg_n_0_[45] ,\mgt_rxdata_reg_reg_n_0_[44] ,\mgt_rxdata_reg_reg_n_0_[43] ,\mgt_rxdata_reg_reg_n_0_[42] ,\mgt_rxdata_reg_reg_n_0_[41] ,\mgt_rxdata_reg_reg_n_0_[40] ,\mgt_rxdata_reg_reg_n_0_[39] ,\mgt_rxdata_reg_reg_n_0_[38] ,\mgt_rxdata_reg_reg_n_0_[37] ,\mgt_rxdata_reg_reg_n_0_[36] ,\mgt_rxdata_reg_reg_n_0_[35] ,\mgt_rxdata_reg_reg_n_0_[34] ,\mgt_rxdata_reg_reg_n_0_[33] ,\mgt_rxdata_reg_reg_n_0_[32] ,\mgt_rxdata_reg_reg_n_0_[31] ,\mgt_rxdata_reg_reg_n_0_[30] ,\mgt_rxdata_reg_reg_n_0_[29] ,\mgt_rxdata_reg_reg_n_0_[28] ,\mgt_rxdata_reg_reg_n_0_[27] ,\mgt_rxdata_reg_reg_n_0_[26] ,\mgt_rxdata_reg_reg_n_0_[25] ,\mgt_rxdata_reg_reg_n_0_[24] ,\mgt_rxdata_reg_reg_n_0_[23] ,\mgt_rxdata_reg_reg_n_0_[22] ,\mgt_rxdata_reg_reg_n_0_[21] ,\mgt_rxdata_reg_reg_n_0_[20] ,\mgt_rxdata_reg_reg_n_0_[19] ,\mgt_rxdata_reg_reg_n_0_[18] ,\mgt_rxdata_reg_reg_n_0_[17] ,\mgt_rxdata_reg_reg_n_0_[16] ,\mgt_rxdata_reg_reg_n_0_[15] ,\mgt_rxdata_reg_reg_n_0_[14] ,\mgt_rxdata_reg_reg_n_0_[13] ,\mgt_rxdata_reg_reg_n_0_[12] ,\mgt_rxdata_reg_reg_n_0_[11] ,\mgt_rxdata_reg_reg_n_0_[10] ,\mgt_rxdata_reg_reg_n_0_[9] ,\mgt_rxdata_reg_reg_n_0_[8] ,\mgt_rxdata_reg_reg_n_0_[7] ,\mgt_rxdata_reg_reg_n_0_[6] ,\mgt_rxdata_reg_reg_n_0_[5] ,\mgt_rxdata_reg_reg_n_0_[4] ,\mgt_rxdata_reg_reg_n_0_[3] ,\mgt_rxdata_reg_reg_n_0_[2] ,\mgt_rxdata_reg_reg_n_0_[1] ,\mgt_rxdata_reg_reg_n_0_[0] }),
        .mgt_rxlock({clk156_lock,clk156_lock,clk156_lock,clk156_lock}),
        .mgt_tx_reset({txsync_i_n_1,txsync_i_n_1,txsync_i_n_1,txsync_i_n_1}),
        .mgt_txcharisk({gt3_txcharisk_in,gt2_txcharisk_in,gt1_txcharisk_in,xaui_core_n_142,xaui_core_n_143}),
        .mgt_txdata({gt3_txdata_in,gt2_txdata_in,gt1_txdata_in,xaui_core_n_120,xaui_core_n_121,xaui_core_n_122,xaui_core_n_123,xaui_core_n_124,xaui_core_n_125,xaui_core_n_126,xaui_core_n_127,xaui_core_n_128,xaui_core_n_129,xaui_core_n_130,xaui_core_n_131,xaui_core_n_132,xaui_core_n_133,xaui_core_n_134,xaui_core_n_135}),
        .prtad({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .reset(reset156),
        .signal_detect(uclk_signal_detect),
        .soft_reset(NLW_xaui_core_soft_reset_UNCONNECTED),
        .status_vector(status_vector),
        .sync_status(debug[4:1]),
        .type_sel({1'b0,1'b0}),
        .usrclk(clk156_out),
        .xgmii_rxc(xgmii_rxc),
        .xgmii_rxd(xgmii_rxd),
        .xgmii_txc(xgmii_txc),
        .xgmii_txd(xgmii_txd));
  LUT2 #(
    .INIT(4'h1)) 
    xaui_core_i_1
       (.I0(mgt_rxnotintable_reg[7]),
        .I1(mgt_rxdisperr_reg[7]),
        .O(mgt_codevalid[7]));
  LUT2 #(
    .INIT(4'h1)) 
    xaui_core_i_2
       (.I0(mgt_rxnotintable_reg[6]),
        .I1(mgt_rxdisperr_reg[6]),
        .O(mgt_codevalid[6]));
  LUT2 #(
    .INIT(4'h1)) 
    xaui_core_i_3
       (.I0(mgt_rxnotintable_reg[5]),
        .I1(mgt_rxdisperr_reg[5]),
        .O(mgt_codevalid[5]));
  LUT2 #(
    .INIT(4'h1)) 
    xaui_core_i_4
       (.I0(mgt_rxnotintable_reg[4]),
        .I1(mgt_rxdisperr_reg[4]),
        .O(mgt_codevalid[4]));
  LUT2 #(
    .INIT(4'h1)) 
    xaui_core_i_5
       (.I0(mgt_rxnotintable_reg[3]),
        .I1(mgt_rxdisperr_reg[3]),
        .O(mgt_codevalid[3]));
  LUT2 #(
    .INIT(4'h1)) 
    xaui_core_i_6
       (.I0(mgt_rxnotintable_reg[2]),
        .I1(mgt_rxdisperr_reg[2]),
        .O(mgt_codevalid[2]));
  LUT2 #(
    .INIT(4'h1)) 
    xaui_core_i_7
       (.I0(mgt_rxnotintable_reg[1]),
        .I1(mgt_rxdisperr_reg[1]),
        .O(mgt_codevalid[1]));
  LUT2 #(
    .INIT(4'h1)) 
    xaui_core_i_8
       (.I0(mgt_rxnotintable_reg[0]),
        .I1(mgt_rxdisperr_reg[0]),
        .O(mgt_codevalid[0]));
endmodule

(* ORIG_REF_NAME = "xaui_cl_clocking" *) 
module xaui_xaui_cl_clocking
   (clk156_out,
    gt0_txoutclk_i);
  output clk156_out;
  input gt0_txoutclk_i;

  wire clk156_out;
  wire gt0_txoutclk_i;

  (* box_type = "PRIMITIVE" *) 
  BUFG clk156_bufg_i
       (.I(gt0_txoutclk_i),
        .O(clk156_out));
endmodule

(* ORIG_REF_NAME = "xaui_cl_resets" *) 
module xaui_xaui_cl_resets
   (reset156,
    uclk_mgt_rx_reset5,
    uclk_mgt_rx_reset_reg,
    reset);
  output reset156;
  input uclk_mgt_rx_reset5;
  input uclk_mgt_rx_reset_reg;
  input reset;

  wire reset;
  (* async_reg = "true" *) wire reset156_r1;
  (* async_reg = "true" *) wire reset156_r2;
  (* async_reg = "true" *) wire reset156_r3;
  wire uclk_mgt_rx_reset5;
  wire uclk_mgt_rx_reset_reg;

  assign reset156 = reset156_r3;
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDPE reset156_r1_reg
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(uclk_mgt_rx_reset5),
        .PRE(reset),
        .Q(reset156_r1));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDPE reset156_r2_reg
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(reset156_r1),
        .PRE(reset),
        .Q(reset156_r2));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDPE reset156_r3_reg
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(reset156_r2),
        .PRE(reset),
        .Q(reset156_r3));
endmodule

(* ORIG_REF_NAME = "xaui_ff_synchronizer" *) 
module xaui_xaui_ff_synchronizer
   (out,
    uclk_mgt_rx_reset5,
    CLK,
    gt_qplllock_out);
  output [0:0]out;
  output uclk_mgt_rx_reset5;
  input CLK;
  input gt_qplllock_out;

  wire CLK;
  wire gt_qplllock_out;
  (* async_reg = "true" *) (* shreg_extract = "no" *) wire [2:0]sync1_r;
  wire uclk_mgt_rx_reset5;

  assign out[0] = sync1_r[2];
  LUT1 #(
    .INIT(2'h1)) 
    reset156_r1_i_1
       (.I0(sync1_r[2]),
        .O(uclk_mgt_rx_reset5));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(gt_qplllock_out),
        .Q(sync1_r[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(sync1_r[0]),
        .Q(sync1_r[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(sync1_r[1]),
        .Q(sync1_r[2]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_ff_synchronizer" *) 
module xaui_xaui_ff_synchronizer_0
   (uclk_txsync_start_phase_align_reg,
    uclk_mgt_rx_reset0,
    uclk_mgt_tx_reset0,
    uclk_txsync_start_phase_align_reg_0,
    Q,
    out,
    uclk_loopback_reset,
    \uclk_chbond_counter_reg[15] ,
    uclk_mgt_powerdown_falling,
    \sync1_r_reg[2]_0 ,
    reset156,
    CLK,
    \count_reg[7] );
  output uclk_txsync_start_phase_align_reg;
  output uclk_mgt_rx_reset0;
  output uclk_mgt_tx_reset0;
  input uclk_txsync_start_phase_align_reg_0;
  input [3:0]Q;
  input [0:0]out;
  input uclk_loopback_reset;
  input [0:0]\uclk_chbond_counter_reg[15] ;
  input uclk_mgt_powerdown_falling;
  input [0:0]\sync1_r_reg[2]_0 ;
  input reset156;
  input CLK;
  input [0:0]\count_reg[7] ;

  wire CLK;
  wire [3:0]Q;
  wire [0:0]\count_reg[7] ;
  wire [0:0]out;
  wire reset156;
  (* async_reg = "true" *) (* shreg_extract = "no" *) wire [2:0]sync1_r;
  wire [0:0]\sync1_r_reg[2]_0 ;
  wire [0:0]\uclk_chbond_counter_reg[15] ;
  wire uclk_loopback_reset;
  wire uclk_mgt_powerdown_falling;
  wire uclk_mgt_rx_reset0;
  wire uclk_mgt_tx_reset0;
  wire uclk_txsync_start_phase_align_reg;
  wire uclk_txsync_start_phase_align_reg_0;

  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(\count_reg[7] ),
        .Q(sync1_r[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(sync1_r[0]),
        .Q(sync1_r[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(sync1_r[1]),
        .Q(sync1_r[2]),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hFFFEAAAA)) 
    uclk_mgt_rx_reset_i_1
       (.I0(uclk_mgt_tx_reset0),
        .I1(out),
        .I2(uclk_loopback_reset),
        .I3(\uclk_chbond_counter_reg[15] ),
        .I4(sync1_r[2]),
        .O(uclk_mgt_rx_reset0));
  LUT4 #(
    .INIT(16'hAA8A)) 
    uclk_mgt_tx_reset_i_1
       (.I0(sync1_r[2]),
        .I1(uclk_mgt_powerdown_falling),
        .I2(\sync1_r_reg[2]_0 ),
        .I3(reset156),
        .O(uclk_mgt_tx_reset0));
  LUT6 #(
    .INIT(64'hC000AAAA0000AAAA)) 
    uclk_txsync_start_phase_align_i_1
       (.I0(uclk_txsync_start_phase_align_reg_0),
        .I1(Q[1]),
        .I2(Q[2]),
        .I3(Q[3]),
        .I4(sync1_r[2]),
        .I5(Q[0]),
        .O(uclk_txsync_start_phase_align_reg));
endmodule

(* ORIG_REF_NAME = "xaui_ff_synchronizer" *) 
module xaui_xaui_ff_synchronizer_1
   (out,
    dclk,
    reset);
  output [0:0]out;
  input dclk;
  input reset;

  wire dclk;
  wire reset;
  (* async_reg = "true" *) (* shreg_extract = "no" *) wire [2:0]sync1_r;

  assign out[0] = sync1_r[2];
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[0] 
       (.C(dclk),
        .CE(1'b1),
        .D(reset),
        .Q(sync1_r[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[1] 
       (.C(dclk),
        .CE(1'b1),
        .D(sync1_r[0]),
        .Q(sync1_r[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[2] 
       (.C(dclk),
        .CE(1'b1),
        .D(sync1_r[1]),
        .Q(sync1_r[2]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_ff_synchronizer" *) 
module xaui_xaui_ff_synchronizer_2
   (out,
    dclk,
    gt0_rxpmareset_in);
  output [0:0]out;
  input dclk;
  input gt0_rxpmareset_in;

  wire dclk;
  wire gt0_rxpmareset_in;
  (* async_reg = "true" *) (* shreg_extract = "no" *) wire [2:0]sync1_r;

  assign out[0] = sync1_r[2];
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[0] 
       (.C(dclk),
        .CE(1'b1),
        .D(gt0_rxpmareset_in),
        .Q(sync1_r[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[1] 
       (.C(dclk),
        .CE(1'b1),
        .D(sync1_r[0]),
        .Q(sync1_r[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[2] 
       (.C(dclk),
        .CE(1'b1),
        .D(sync1_r[1]),
        .Q(sync1_r[2]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_ff_synchronizer" *) 
module xaui_xaui_ff_synchronizer_3
   (out,
    dclk,
    gt1_rxpmareset_in);
  output [0:0]out;
  input dclk;
  input gt1_rxpmareset_in;

  wire dclk;
  wire gt1_rxpmareset_in;
  (* async_reg = "true" *) (* shreg_extract = "no" *) wire [2:0]sync1_r;

  assign out[0] = sync1_r[2];
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[0] 
       (.C(dclk),
        .CE(1'b1),
        .D(gt1_rxpmareset_in),
        .Q(sync1_r[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[1] 
       (.C(dclk),
        .CE(1'b1),
        .D(sync1_r[0]),
        .Q(sync1_r[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[2] 
       (.C(dclk),
        .CE(1'b1),
        .D(sync1_r[1]),
        .Q(sync1_r[2]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_ff_synchronizer" *) 
module xaui_xaui_ff_synchronizer_4
   (out,
    dclk,
    gt2_rxpmareset_in);
  output [0:0]out;
  input dclk;
  input gt2_rxpmareset_in;

  wire dclk;
  wire gt2_rxpmareset_in;
  (* async_reg = "true" *) (* shreg_extract = "no" *) wire [2:0]sync1_r;

  assign out[0] = sync1_r[2];
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[0] 
       (.C(dclk),
        .CE(1'b1),
        .D(gt2_rxpmareset_in),
        .Q(sync1_r[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[1] 
       (.C(dclk),
        .CE(1'b1),
        .D(sync1_r[0]),
        .Q(sync1_r[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[2] 
       (.C(dclk),
        .CE(1'b1),
        .D(sync1_r[1]),
        .Q(sync1_r[2]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_ff_synchronizer" *) 
module xaui_xaui_ff_synchronizer_5
   (out,
    dclk,
    gt3_rxpmareset_in);
  output [0:0]out;
  input dclk;
  input gt3_rxpmareset_in;

  wire dclk;
  wire gt3_rxpmareset_in;
  (* async_reg = "true" *) (* shreg_extract = "no" *) wire [2:0]sync1_r;

  assign out[0] = sync1_r[2];
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[0] 
       (.C(dclk),
        .CE(1'b1),
        .D(gt3_rxpmareset_in),
        .Q(sync1_r[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[1] 
       (.C(dclk),
        .CE(1'b1),
        .D(sync1_r[0]),
        .Q(sync1_r[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[2] 
       (.C(dclk),
        .CE(1'b1),
        .D(sync1_r[1]),
        .Q(sync1_r[2]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_ff_synchronizer" *) 
module xaui_xaui_ff_synchronizer_6
   (out,
    uclk_mgt_rx_reset_reg,
    signal_detect);
  output [0:0]out;
  input uclk_mgt_rx_reset_reg;
  input [0:0]signal_detect;

  wire [0:0]signal_detect;
  (* async_reg = "true" *) (* shreg_extract = "no" *) wire [2:0]sync1_r;
  wire uclk_mgt_rx_reset_reg;

  assign out[0] = sync1_r[2];
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(signal_detect),
        .Q(sync1_r[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync1_r[0]),
        .Q(sync1_r[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync1_r[1]),
        .Q(sync1_r[2]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_ff_synchronizer" *) 
module xaui_xaui_ff_synchronizer_7
   (out,
    uclk_mgt_rx_reset_reg,
    signal_detect);
  output [0:0]out;
  input uclk_mgt_rx_reset_reg;
  input [0:0]signal_detect;

  wire [0:0]signal_detect;
  (* async_reg = "true" *) (* shreg_extract = "no" *) wire [2:0]sync1_r;
  wire uclk_mgt_rx_reset_reg;

  assign out[0] = sync1_r[2];
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(signal_detect),
        .Q(sync1_r[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync1_r[0]),
        .Q(sync1_r[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync1_r[1]),
        .Q(sync1_r[2]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_ff_synchronizer" *) 
module xaui_xaui_ff_synchronizer_8
   (out,
    uclk_mgt_rx_reset_reg,
    signal_detect);
  output [0:0]out;
  input uclk_mgt_rx_reset_reg;
  input [0:0]signal_detect;

  wire [0:0]signal_detect;
  (* async_reg = "true" *) (* shreg_extract = "no" *) wire [2:0]sync1_r;
  wire uclk_mgt_rx_reset_reg;

  assign out[0] = sync1_r[2];
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(signal_detect),
        .Q(sync1_r[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync1_r[0]),
        .Q(sync1_r[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync1_r[1]),
        .Q(sync1_r[2]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_ff_synchronizer" *) 
module xaui_xaui_ff_synchronizer_9
   (out,
    uclk_mgt_rx_reset_reg,
    signal_detect);
  output [0:0]out;
  input uclk_mgt_rx_reset_reg;
  input [0:0]signal_detect;

  wire [0:0]signal_detect;
  (* async_reg = "true" *) (* shreg_extract = "no" *) wire [2:0]sync1_r;
  wire uclk_mgt_rx_reset_reg;

  assign out[0] = sync1_r[2];
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(signal_detect),
        .Q(sync1_r[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync1_r[0]),
        .Q(sync1_r[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync1_r[1]),
        .Q(sync1_r[2]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_gen" *) 
module xaui_xaui_gen
   (in0,
    mgt_txdata,
    mgt_txcharisk,
    mgt_enchansync,
    xgmii_rxd,
    xgmii_rxc,
    mgt_enable_align,
    configuration_vector,
    usrclk,
    xgmii_txd,
    xgmii_txc,
    reset,
    mgt_rxdata,
    mgt_rxcharisk,
    signal_detect,
    mgt_codecomma,
    mgt_codevalid,
    mgt_rx_reset,
    mgt_rxlock,
    mgt_tx_reset);
  output [7:0]in0;
  output [63:0]mgt_txdata;
  output [7:0]mgt_txcharisk;
  output mgt_enchansync;
  output [63:0]xgmii_rxd;
  output [7:0]xgmii_rxc;
  output [3:0]mgt_enable_align;
  input [4:0]configuration_vector;
  input usrclk;
  input [63:0]xgmii_txd;
  input [7:0]xgmii_txc;
  input reset;
  input [63:0]mgt_rxdata;
  input [7:0]mgt_rxcharisk;
  input [3:0]signal_detect;
  input [7:0]mgt_codecomma;
  input [7:0]mgt_codevalid;
  input [3:0]mgt_rx_reset;
  input [3:0]mgt_rxlock;
  input [3:0]mgt_tx_reset;

  (* RTL_KEEP = "true" *) wire align_status_int;
  wire aligned_sticky_i_1_n_0;
  wire clear_aligned;
  wire clear_aligned_edge;
  wire clear_aligned_edge_i_1_n_0;
  wire clear_local_fault;
  wire clear_local_fault_edge;
  wire clear_local_fault_edge_i_1_n_0;
  wire [4:0]configuration_vector;
  wire [7:0]\^in0 ;
  wire last_value;
  wire last_value_reg__0_n_0;
  wire [7:0]mgt_codecomma;
  wire [7:0]mgt_codevalid;
  wire [3:0]mgt_enable_align;
  wire mgt_enchansync;
  wire [3:0]mgt_rx_reset;
  wire [7:0]mgt_rxcharisk;
  wire [63:0]mgt_rxdata;
  wire [3:0]mgt_rxlock;
  wire [3:0]mgt_tx_reset;
  wire [7:0]mgt_txcharisk;
  wire [63:0]mgt_txdata;
  wire reset;
  wire rx_local_fault_i_1_n_0;
  wire rx_local_fault_i_2_n_0;
  wire [3:0]signal_detect;
  wire \signal_detect_int_reg_n_0_[0] ;
  wire \signal_detect_int_reg_n_0_[1] ;
  wire \signal_detect_int_reg_n_0_[2] ;
  wire \signal_detect_int_reg_n_0_[3] ;
  (* RTL_KEEP = "true" *) wire [3:0]sync;
  wire tx_local_fault_i_1_n_0;
  wire usrclk;
  wire usrclk_reset;
  wire usrclk_reset_i_1_n_0;
  wire usrclk_reset_pipe;
  wire [7:0]xgmii_rxc;
  wire [63:0]xgmii_rxd;
  wire [7:0]xgmii_txc;
  wire [63:0]xgmii_txd;

  assign in0[7] = \^in0 [7];
  assign in0[6] = align_status_int;
  assign in0[5:2] = sync;
  assign in0[1:0] = \^in0 [1:0];
  FDRE \G_NO_MDIO.clear_aligned_reg 
       (.C(usrclk),
        .CE(1'b1),
        .D(configuration_vector[1]),
        .Q(clear_aligned),
        .R(1'b0));
  FDRE \G_NO_MDIO.clear_local_fault_reg 
       (.C(usrclk),
        .CE(1'b1),
        .D(configuration_vector[0]),
        .Q(clear_local_fault),
        .R(1'b0));
  LUT4 #(
    .INIT(16'h00E0)) 
    aligned_sticky_i_1
       (.I0(\^in0 [7]),
        .I1(clear_aligned_edge),
        .I2(align_status_int),
        .I3(usrclk_reset),
        .O(aligned_sticky_i_1_n_0));
  FDRE aligned_sticky_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(aligned_sticky_i_1_n_0),
        .Q(\^in0 [7]),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h2)) 
    clear_aligned_edge_i_1
       (.I0(clear_aligned),
        .I1(last_value_reg__0_n_0),
        .O(clear_aligned_edge_i_1_n_0));
  FDRE clear_aligned_edge_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(clear_aligned_edge_i_1_n_0),
        .Q(clear_aligned_edge),
        .R(usrclk_reset));
  LUT2 #(
    .INIT(4'h2)) 
    clear_local_fault_edge_i_1
       (.I0(clear_local_fault),
        .I1(last_value),
        .O(clear_local_fault_edge_i_1_n_0));
  FDRE clear_local_fault_edge_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(clear_local_fault_edge_i_1_n_0),
        .Q(clear_local_fault_edge),
        .R(usrclk_reset));
  FDRE last_value_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(clear_local_fault),
        .Q(last_value),
        .R(usrclk_reset));
  FDRE last_value_reg__0
       (.C(usrclk),
        .CE(1'b1),
        .D(clear_aligned),
        .Q(last_value_reg__0_n_0),
        .R(usrclk_reset));
  xaui_rx receiver
       (.align_status_int(align_status_int),
        .in0(sync),
        .mgt_codecomma(mgt_codecomma),
        .mgt_codevalid(mgt_codevalid),
        .mgt_enable_align(mgt_enable_align),
        .mgt_enchansync(mgt_enchansync),
        .mgt_rx_reset(mgt_rx_reset),
        .mgt_rxcharisk(mgt_rxcharisk),
        .mgt_rxdata(mgt_rxdata),
        .mgt_rxlock(mgt_rxlock),
        .\signal_detect_int_reg[0] (\signal_detect_int_reg_n_0_[0] ),
        .\signal_detect_int_reg[1] (\signal_detect_int_reg_n_0_[1] ),
        .\signal_detect_int_reg[2] (\signal_detect_int_reg_n_0_[2] ),
        .\signal_detect_int_reg[3] (\signal_detect_int_reg_n_0_[3] ),
        .usrclk(usrclk),
        .usrclk_reset(usrclk_reset),
        .xgmii_rxc(xgmii_rxc),
        .xgmii_rxd(xgmii_rxd));
  LUT3 #(
    .INIT(8'hDC)) 
    rx_local_fault_i_1
       (.I0(clear_local_fault_edge),
        .I1(rx_local_fault_i_2_n_0),
        .I2(\^in0 [1]),
        .O(rx_local_fault_i_1_n_0));
  LUT5 #(
    .INIT(32'hFFFFFFEF)) 
    rx_local_fault_i_2
       (.I0(mgt_rx_reset[1]),
        .I1(mgt_rx_reset[0]),
        .I2(align_status_int),
        .I3(mgt_rx_reset[2]),
        .I4(mgt_rx_reset[3]),
        .O(rx_local_fault_i_2_n_0));
  FDRE rx_local_fault_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(rx_local_fault_i_1_n_0),
        .Q(\^in0 [1]),
        .R(usrclk_reset));
  FDRE \signal_detect_int_reg[0] 
       (.C(usrclk),
        .CE(1'b1),
        .D(signal_detect[0]),
        .Q(\signal_detect_int_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \signal_detect_int_reg[1] 
       (.C(usrclk),
        .CE(1'b1),
        .D(signal_detect[1]),
        .Q(\signal_detect_int_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \signal_detect_int_reg[2] 
       (.C(usrclk),
        .CE(1'b1),
        .D(signal_detect[2]),
        .Q(\signal_detect_int_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \signal_detect_int_reg[3] 
       (.C(usrclk),
        .CE(1'b1),
        .D(signal_detect[3]),
        .Q(\signal_detect_int_reg_n_0_[3] ),
        .R(1'b0));
  xaui_tx transmitter
       (.configuration_vector(configuration_vector[4:2]),
        .mgt_txcharisk(mgt_txcharisk),
        .mgt_txdata(mgt_txdata),
        .usrclk(usrclk),
        .usrclk_reset(usrclk_reset),
        .xgmii_txc(xgmii_txc),
        .xgmii_txd(xgmii_txd));
  LUT6 #(
    .INIT(64'hFFFFFFFDFFFFFFFC)) 
    tx_local_fault_i_1
       (.I0(clear_local_fault_edge),
        .I1(mgt_tx_reset[1]),
        .I2(mgt_tx_reset[0]),
        .I3(mgt_tx_reset[2]),
        .I4(mgt_tx_reset[3]),
        .I5(\^in0 [0]),
        .O(tx_local_fault_i_1_n_0));
  FDRE tx_local_fault_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(tx_local_fault_i_1_n_0),
        .Q(\^in0 [0]),
        .R(usrclk_reset));
  LUT2 #(
    .INIT(4'hE)) 
    usrclk_reset_i_1
       (.I0(usrclk_reset_pipe),
        .I1(reset),
        .O(usrclk_reset_i_1_n_0));
  FDRE #(
    .INIT(1'b1)) 
    usrclk_reset_pipe_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(reset),
        .Q(usrclk_reset_pipe),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    usrclk_reset_reg
       (.C(usrclk),
        .CE(1'b1),
        .D(usrclk_reset_i_1_n_0),
        .Q(usrclk_reset),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_gt_wrapper" *) 
module xaui_xaui_gt_wrapper
   (gt0_drprdy,
    gt0_eyescandataerror_out,
    xaui_tx_l0_n,
    xaui_tx_l0_p,
    gt0_rxcommadet_out,
    gt0_rxprbserr_out,
    gt0_rxresetdone_out,
    gt0_txdlysresetdone_out,
    gt0_txoutclk_out,
    gt0_txphaligndone_out,
    gt0_txphinitdone_out,
    D,
    gt0_drpdo,
    \uclk_mgt_rxbufstatus_reg_reg[11] ,
    \mgt_rxdata_reg_reg[63] ,
    gt0_rxmonitorout_out,
    gt0_dmonitorout_out,
    \mgt_codecomma_reg_reg[7] ,
    \mgt_rxcharisk_reg_reg[7] ,
    \mgt_rxdisperr_reg_reg[7] ,
    \mgt_rxnotintable_reg_reg[7] ,
    gt1_drprdy,
    gt1_eyescandataerror_out,
    xaui_tx_l1_n,
    xaui_tx_l1_p,
    gt1_rxcommadet_out,
    gt1_rxprbserr_out,
    gt1_rxresetdone_out,
    gt1_txdlysresetdone_out,
    gt1_txphaligndone_out,
    gt1_txphinitdone_out,
    gt1_drpdo,
    gt1_rxmonitorout_out,
    gt1_dmonitorout_out,
    gt2_drprdy,
    gt2_eyescandataerror_out,
    xaui_tx_l2_n,
    xaui_tx_l2_p,
    gt2_rxcommadet_out,
    gt2_rxprbserr_out,
    gt2_rxresetdone_out,
    gt2_txdlysresetdone_out,
    gt2_txphaligndone_out,
    gt2_txphinitdone_out,
    gt2_drpdo,
    gt2_rxmonitorout_out,
    gt2_dmonitorout_out,
    gt3_drprdy,
    gt3_eyescandataerror_out,
    xaui_tx_l3_n,
    xaui_tx_l3_p,
    gt3_rxcommadet_out,
    gt3_rxprbserr_out,
    gt3_rxresetdone_out,
    gt3_txdlysresetdone_out,
    gt3_txphaligndone_out,
    gt3_txphinitdone_out,
    gt3_drpdo,
    gt3_rxmonitorout_out,
    gt3_dmonitorout_out,
    gt_qplllock_out,
    \core_mgt_rx_reset_reg[3] ,
    dclk,
    gt0_drpen,
    gt0_drpwe,
    gt0_eyescanreset_in,
    gt0_eyescantrigger_in,
    gt3_gtrxreset_in,
    uclk_mgt_tx_reset,
    xaui_rx_l0_n,
    xaui_rx_l0_p,
    Q,
    gt0_rxcdrhold_in,
    gt3_rxchbonden_in,
    gt0_rxdfelpmreset_in,
    gt0_rxlpmen_in,
    mgt_enable_align,
    gt0_rxpcsreset_in,
    gt0_rxpmareset_in,
    gt0_rxpolarity_in,
    gt0_rxprbscntreset_in,
    gt3_txuserrdy_in,
    CLK,
    gt0_txdlyen_in,
    gt0_txdlysreset_in,
    gt3_txelecidle_in,
    gt0_txinhibit_in,
    gt0_txpcsreset_in,
    gt0_txphalign_in,
    gt0_txphinit_in,
    gt0_txpmareset_in,
    gt0_txpolarity_in,
    gt0_txprbsforceerr_in,
    gt0_drpdi,
    gt0_rxmonitorsel_in,
    gt0_loopback_in,
    gt0_rxprbssel_in,
    gt0_rxrate_in,
    gt0_txprbssel_in,
    gt0_txdiffctrl_in,
    gt0_txpostcursor_in,
    gt0_txprecursor_in,
    mgt_txdata,
    mgt_txcharisk,
    gt0_drpaddr,
    gt1_drpen,
    gt1_drpwe,
    gt1_eyescanreset_in,
    gt1_eyescantrigger_in,
    xaui_rx_l1_n,
    xaui_rx_l1_p,
    gt1_rxcdrhold_in,
    gt1_rxdfelpmreset_in,
    gt1_rxlpmen_in,
    gt1_rxpcsreset_in,
    gt1_rxpmareset_in,
    gt1_rxpolarity_in,
    gt1_rxprbscntreset_in,
    gt1_txdlysreset_in,
    gt1_txinhibit_in,
    gt1_txpcsreset_in,
    gt1_txphalign_in,
    gt1_txphinit_in,
    gt1_txpmareset_in,
    gt1_txpolarity_in,
    gt1_txprbsforceerr_in,
    gt1_drpdi,
    gt1_rxmonitorsel_in,
    gt1_loopback_in,
    gt1_rxprbssel_in,
    gt1_rxrate_in,
    gt1_txprbssel_in,
    gt1_txdiffctrl_in,
    gt1_txpostcursor_in,
    gt1_txprecursor_in,
    gt1_drpaddr,
    gt2_drpen,
    gt2_drpwe,
    gt2_eyescanreset_in,
    gt2_eyescantrigger_in,
    xaui_rx_l2_n,
    xaui_rx_l2_p,
    gt2_rxcdrhold_in,
    gt2_rxdfelpmreset_in,
    gt2_rxlpmen_in,
    gt2_rxpcsreset_in,
    gt2_rxpmareset_in,
    gt2_rxpolarity_in,
    gt2_rxprbscntreset_in,
    gt2_txdlysreset_in,
    gt2_txinhibit_in,
    gt2_txpcsreset_in,
    gt2_txphalign_in,
    gt2_txphinit_in,
    gt2_txpmareset_in,
    gt2_txpolarity_in,
    gt2_txprbsforceerr_in,
    gt2_drpdi,
    gt2_rxmonitorsel_in,
    gt2_loopback_in,
    gt2_rxprbssel_in,
    gt2_rxrate_in,
    gt2_txprbssel_in,
    gt2_txdiffctrl_in,
    gt2_txpostcursor_in,
    gt2_txprecursor_in,
    gt2_drpaddr,
    gt3_drpen,
    gt3_drpwe,
    gt3_eyescanreset_in,
    gt3_eyescantrigger_in,
    xaui_rx_l3_n,
    xaui_rx_l3_p,
    gt3_rxcdrhold_in,
    gt3_rxdfelpmreset_in,
    gt3_rxlpmen_in,
    gt3_rxpcsreset_in,
    gt3_rxpmareset_in,
    gt3_rxpolarity_in,
    gt3_rxprbscntreset_in,
    gt3_txdlysreset_in,
    gt3_txinhibit_in,
    gt3_txpcsreset_in,
    gt3_txphalign_in,
    gt3_txphinit_in,
    gt3_txpmareset_in,
    gt3_txpolarity_in,
    gt3_txprbsforceerr_in,
    gt3_drpdi,
    gt3_rxmonitorsel_in,
    gt3_loopback_in,
    gt3_rxprbssel_in,
    gt3_rxrate_in,
    gt3_txprbssel_in,
    gt3_txdiffctrl_in,
    gt3_txpostcursor_in,
    gt3_txprecursor_in,
    gt3_drpaddr,
    refclk,
    gt0_qpllreset_in,
    uclk_loopback_int);
  output gt0_drprdy;
  output gt0_eyescandataerror_out;
  output xaui_tx_l0_n;
  output xaui_tx_l0_p;
  output gt0_rxcommadet_out;
  output gt0_rxprbserr_out;
  output gt0_rxresetdone_out;
  output gt0_txdlysresetdone_out;
  output gt0_txoutclk_out;
  output gt0_txphaligndone_out;
  output gt0_txphinitdone_out;
  output [3:0]D;
  output [15:0]gt0_drpdo;
  output [11:0]\uclk_mgt_rxbufstatus_reg_reg[11] ;
  output [63:0]\mgt_rxdata_reg_reg[63] ;
  output [6:0]gt0_rxmonitorout_out;
  output [7:0]gt0_dmonitorout_out;
  output [7:0]\mgt_codecomma_reg_reg[7] ;
  output [7:0]\mgt_rxcharisk_reg_reg[7] ;
  output [7:0]\mgt_rxdisperr_reg_reg[7] ;
  output [7:0]\mgt_rxnotintable_reg_reg[7] ;
  output gt1_drprdy;
  output gt1_eyescandataerror_out;
  output xaui_tx_l1_n;
  output xaui_tx_l1_p;
  output gt1_rxcommadet_out;
  output gt1_rxprbserr_out;
  output gt1_rxresetdone_out;
  output gt1_txdlysresetdone_out;
  output gt1_txphaligndone_out;
  output gt1_txphinitdone_out;
  output [15:0]gt1_drpdo;
  output [6:0]gt1_rxmonitorout_out;
  output [7:0]gt1_dmonitorout_out;
  output gt2_drprdy;
  output gt2_eyescandataerror_out;
  output xaui_tx_l2_n;
  output xaui_tx_l2_p;
  output gt2_rxcommadet_out;
  output gt2_rxprbserr_out;
  output gt2_rxresetdone_out;
  output gt2_txdlysresetdone_out;
  output gt2_txphaligndone_out;
  output gt2_txphinitdone_out;
  output [15:0]gt2_drpdo;
  output [6:0]gt2_rxmonitorout_out;
  output [7:0]gt2_dmonitorout_out;
  output gt3_drprdy;
  output gt3_eyescandataerror_out;
  output xaui_tx_l3_n;
  output xaui_tx_l3_p;
  output gt3_rxcommadet_out;
  output gt3_rxprbserr_out;
  output gt3_rxresetdone_out;
  output gt3_txdlysresetdone_out;
  output gt3_txphaligndone_out;
  output gt3_txphinitdone_out;
  output [15:0]gt3_drpdo;
  output [6:0]gt3_rxmonitorout_out;
  output [7:0]gt3_dmonitorout_out;
  output gt_qplllock_out;
  output [3:0]\core_mgt_rx_reset_reg[3] ;
  input dclk;
  input gt0_drpen;
  input gt0_drpwe;
  input gt0_eyescanreset_in;
  input gt0_eyescantrigger_in;
  input gt3_gtrxreset_in;
  input uclk_mgt_tx_reset;
  input xaui_rx_l0_n;
  input xaui_rx_l0_p;
  input [3:0]Q;
  input gt0_rxcdrhold_in;
  input gt3_rxchbonden_in;
  input gt0_rxdfelpmreset_in;
  input gt0_rxlpmen_in;
  input [3:0]mgt_enable_align;
  input gt0_rxpcsreset_in;
  input gt0_rxpmareset_in;
  input gt0_rxpolarity_in;
  input gt0_rxprbscntreset_in;
  input gt3_txuserrdy_in;
  input CLK;
  input gt0_txdlyen_in;
  input gt0_txdlysreset_in;
  input gt3_txelecidle_in;
  input gt0_txinhibit_in;
  input gt0_txpcsreset_in;
  input gt0_txphalign_in;
  input gt0_txphinit_in;
  input gt0_txpmareset_in;
  input gt0_txpolarity_in;
  input gt0_txprbsforceerr_in;
  input [15:0]gt0_drpdi;
  input [1:0]gt0_rxmonitorsel_in;
  input [2:0]gt0_loopback_in;
  input [2:0]gt0_rxprbssel_in;
  input [2:0]gt0_rxrate_in;
  input [2:0]gt0_txprbssel_in;
  input [3:0]gt0_txdiffctrl_in;
  input [4:0]gt0_txpostcursor_in;
  input [4:0]gt0_txprecursor_in;
  input [63:0]mgt_txdata;
  input [7:0]mgt_txcharisk;
  input [8:0]gt0_drpaddr;
  input gt1_drpen;
  input gt1_drpwe;
  input gt1_eyescanreset_in;
  input gt1_eyescantrigger_in;
  input xaui_rx_l1_n;
  input xaui_rx_l1_p;
  input gt1_rxcdrhold_in;
  input gt1_rxdfelpmreset_in;
  input gt1_rxlpmen_in;
  input gt1_rxpcsreset_in;
  input gt1_rxpmareset_in;
  input gt1_rxpolarity_in;
  input gt1_rxprbscntreset_in;
  input gt1_txdlysreset_in;
  input gt1_txinhibit_in;
  input gt1_txpcsreset_in;
  input gt1_txphalign_in;
  input gt1_txphinit_in;
  input gt1_txpmareset_in;
  input gt1_txpolarity_in;
  input gt1_txprbsforceerr_in;
  input [15:0]gt1_drpdi;
  input [1:0]gt1_rxmonitorsel_in;
  input [2:0]gt1_loopback_in;
  input [2:0]gt1_rxprbssel_in;
  input [2:0]gt1_rxrate_in;
  input [2:0]gt1_txprbssel_in;
  input [3:0]gt1_txdiffctrl_in;
  input [4:0]gt1_txpostcursor_in;
  input [4:0]gt1_txprecursor_in;
  input [8:0]gt1_drpaddr;
  input gt2_drpen;
  input gt2_drpwe;
  input gt2_eyescanreset_in;
  input gt2_eyescantrigger_in;
  input xaui_rx_l2_n;
  input xaui_rx_l2_p;
  input gt2_rxcdrhold_in;
  input gt2_rxdfelpmreset_in;
  input gt2_rxlpmen_in;
  input gt2_rxpcsreset_in;
  input gt2_rxpmareset_in;
  input gt2_rxpolarity_in;
  input gt2_rxprbscntreset_in;
  input gt2_txdlysreset_in;
  input gt2_txinhibit_in;
  input gt2_txpcsreset_in;
  input gt2_txphalign_in;
  input gt2_txphinit_in;
  input gt2_txpmareset_in;
  input gt2_txpolarity_in;
  input gt2_txprbsforceerr_in;
  input [15:0]gt2_drpdi;
  input [1:0]gt2_rxmonitorsel_in;
  input [2:0]gt2_loopback_in;
  input [2:0]gt2_rxprbssel_in;
  input [2:0]gt2_rxrate_in;
  input [2:0]gt2_txprbssel_in;
  input [3:0]gt2_txdiffctrl_in;
  input [4:0]gt2_txpostcursor_in;
  input [4:0]gt2_txprecursor_in;
  input [8:0]gt2_drpaddr;
  input gt3_drpen;
  input gt3_drpwe;
  input gt3_eyescanreset_in;
  input gt3_eyescantrigger_in;
  input xaui_rx_l3_n;
  input xaui_rx_l3_p;
  input gt3_rxcdrhold_in;
  input gt3_rxdfelpmreset_in;
  input gt3_rxlpmen_in;
  input gt3_rxpcsreset_in;
  input gt3_rxpmareset_in;
  input gt3_rxpolarity_in;
  input gt3_rxprbscntreset_in;
  input gt3_txdlysreset_in;
  input gt3_txinhibit_in;
  input gt3_txpcsreset_in;
  input gt3_txphalign_in;
  input gt3_txphinit_in;
  input gt3_txpmareset_in;
  input gt3_txpolarity_in;
  input gt3_txprbsforceerr_in;
  input [15:0]gt3_drpdi;
  input [1:0]gt3_rxmonitorsel_in;
  input [2:0]gt3_loopback_in;
  input [2:0]gt3_rxprbssel_in;
  input [2:0]gt3_rxrate_in;
  input [2:0]gt3_txprbssel_in;
  input [3:0]gt3_txdiffctrl_in;
  input [4:0]gt3_txpostcursor_in;
  input [4:0]gt3_txprecursor_in;
  input [8:0]gt3_drpaddr;
  input refclk;
  input gt0_qpllreset_in;
  input [0:0]uclk_loopback_int;

  wire CLK;
  wire [3:0]D;
  wire [3:0]Q;
  wire [3:0]\core_mgt_rx_reset_reg[3] ;
  wire dclk;
  wire [7:0]gt0_dmonitorout_out;
  wire [8:0]gt0_drpaddr;
  wire [15:0]gt0_drpdi;
  wire [15:0]gt0_drpdo;
  wire gt0_drpen;
  wire gt0_drprdy;
  wire gt0_drpwe;
  wire gt0_eyescandataerror_out;
  wire gt0_eyescanreset_in;
  wire gt0_eyescantrigger_in;
  wire [2:0]gt0_loopback_in;
  wire gt0_qpllclk_i;
  wire gt0_qpllrefclk_i;
  wire gt0_qpllreset_in;
  wire gt0_rxcdrhold_in;
  wire gt0_rxcommadet_out;
  wire gt0_rxdfelpmreset_in;
  wire gt0_rxlpmen_in;
  wire [6:0]gt0_rxmonitorout_out;
  wire [1:0]gt0_rxmonitorsel_in;
  wire gt0_rxpcsreset_in;
  wire gt0_rxpmareset_in;
  wire gt0_rxpolarity_in;
  wire gt0_rxprbscntreset_in;
  wire gt0_rxprbserr_out;
  wire [2:0]gt0_rxprbssel_in;
  wire [2:0]gt0_rxrate_in;
  wire gt0_rxresetdone_out;
  wire [3:0]gt0_txdiffctrl_in;
  wire gt0_txdlyen_in;
  wire gt0_txdlysreset_in;
  wire gt0_txdlysresetdone_out;
  wire gt0_txinhibit_in;
  wire gt0_txoutclk_out;
  wire gt0_txpcsreset_in;
  wire gt0_txphalign_in;
  wire gt0_txphaligndone_out;
  wire gt0_txphinit_in;
  wire gt0_txphinitdone_out;
  wire gt0_txpmareset_in;
  wire gt0_txpolarity_in;
  wire [4:0]gt0_txpostcursor_in;
  wire gt0_txprbsforceerr_in;
  wire [2:0]gt0_txprbssel_in;
  wire [4:0]gt0_txprecursor_in;
  wire [7:0]gt1_dmonitorout_out;
  wire [8:0]gt1_drpaddr;
  wire [15:0]gt1_drpdi;
  wire [15:0]gt1_drpdo;
  wire gt1_drpen;
  wire gt1_drprdy;
  wire gt1_drpwe;
  wire gt1_eyescandataerror_out;
  wire gt1_eyescanreset_in;
  wire gt1_eyescantrigger_in;
  wire [2:0]gt1_loopback_in;
  wire gt1_rxcdrhold_in;
  wire [4:0]gt1_rxchbondo_i;
  wire gt1_rxcommadet_out;
  wire gt1_rxdfelpmreset_in;
  wire gt1_rxlpmen_in;
  wire [6:0]gt1_rxmonitorout_out;
  wire [1:0]gt1_rxmonitorsel_in;
  wire gt1_rxpcsreset_in;
  wire gt1_rxpmareset_in;
  wire gt1_rxpolarity_in;
  wire gt1_rxprbscntreset_in;
  wire gt1_rxprbserr_out;
  wire [2:0]gt1_rxprbssel_in;
  wire [2:0]gt1_rxrate_in;
  wire gt1_rxresetdone_out;
  wire [3:0]gt1_txdiffctrl_in;
  wire gt1_txdlysreset_in;
  wire gt1_txdlysresetdone_out;
  wire gt1_txinhibit_in;
  wire gt1_txpcsreset_in;
  wire gt1_txphalign_in;
  wire gt1_txphaligndone_out;
  wire gt1_txphinit_in;
  wire gt1_txphinitdone_out;
  wire gt1_txpmareset_in;
  wire gt1_txpolarity_in;
  wire [4:0]gt1_txpostcursor_in;
  wire gt1_txprbsforceerr_in;
  wire [2:0]gt1_txprbssel_in;
  wire [4:0]gt1_txprecursor_in;
  wire [7:0]gt2_dmonitorout_out;
  wire [8:0]gt2_drpaddr;
  wire [15:0]gt2_drpdi;
  wire [15:0]gt2_drpdo;
  wire gt2_drpen;
  wire gt2_drprdy;
  wire gt2_drpwe;
  wire gt2_eyescandataerror_out;
  wire gt2_eyescanreset_in;
  wire gt2_eyescantrigger_in;
  wire [2:0]gt2_loopback_in;
  wire gt2_rxcdrhold_in;
  wire [4:0]gt2_rxchbondo_i;
  wire gt2_rxcommadet_out;
  wire gt2_rxdfelpmreset_in;
  wire gt2_rxlpmen_in;
  wire [6:0]gt2_rxmonitorout_out;
  wire [1:0]gt2_rxmonitorsel_in;
  wire gt2_rxpcsreset_in;
  wire gt2_rxpmareset_in;
  wire gt2_rxpolarity_in;
  wire gt2_rxprbscntreset_in;
  wire gt2_rxprbserr_out;
  wire [2:0]gt2_rxprbssel_in;
  wire [2:0]gt2_rxrate_in;
  wire gt2_rxresetdone_out;
  wire [3:0]gt2_txdiffctrl_in;
  wire gt2_txdlysreset_in;
  wire gt2_txdlysresetdone_out;
  wire gt2_txinhibit_in;
  wire gt2_txpcsreset_in;
  wire gt2_txphalign_in;
  wire gt2_txphaligndone_out;
  wire gt2_txphinit_in;
  wire gt2_txphinitdone_out;
  wire gt2_txpmareset_in;
  wire gt2_txpolarity_in;
  wire [4:0]gt2_txpostcursor_in;
  wire gt2_txprbsforceerr_in;
  wire [2:0]gt2_txprbssel_in;
  wire [4:0]gt2_txprecursor_in;
  wire [7:0]gt3_dmonitorout_out;
  wire [8:0]gt3_drpaddr;
  wire [15:0]gt3_drpdi;
  wire [15:0]gt3_drpdo;
  wire gt3_drpen;
  wire gt3_drprdy;
  wire gt3_drpwe;
  wire gt3_eyescandataerror_out;
  wire gt3_eyescanreset_in;
  wire gt3_eyescantrigger_in;
  wire gt3_gtrxreset_in;
  wire [2:0]gt3_loopback_in;
  wire gt3_rxcdrhold_in;
  wire gt3_rxchbonden_in;
  wire gt3_rxcommadet_out;
  wire gt3_rxdfelpmreset_in;
  wire gt3_rxlpmen_in;
  wire [6:0]gt3_rxmonitorout_out;
  wire [1:0]gt3_rxmonitorsel_in;
  wire gt3_rxpcsreset_in;
  wire gt3_rxpmareset_in;
  wire gt3_rxpolarity_in;
  wire gt3_rxprbscntreset_in;
  wire gt3_rxprbserr_out;
  wire [2:0]gt3_rxprbssel_in;
  wire [2:0]gt3_rxrate_in;
  wire gt3_rxresetdone_out;
  wire [3:0]gt3_txdiffctrl_in;
  wire gt3_txdlysreset_in;
  wire gt3_txdlysresetdone_out;
  wire gt3_txelecidle_in;
  wire gt3_txinhibit_in;
  wire gt3_txpcsreset_in;
  wire gt3_txphalign_in;
  wire gt3_txphaligndone_out;
  wire gt3_txphinit_in;
  wire gt3_txphinitdone_out;
  wire gt3_txpmareset_in;
  wire gt3_txpolarity_in;
  wire [4:0]gt3_txpostcursor_in;
  wire gt3_txprbsforceerr_in;
  wire [2:0]gt3_txprbssel_in;
  wire [4:0]gt3_txprecursor_in;
  wire gt3_txuserrdy_in;
  wire gt_qplllock_out;
  wire gtxe2_common_0_i_n_5;
  wire [7:0]\mgt_codecomma_reg_reg[7] ;
  wire [3:0]mgt_enable_align;
  wire [7:0]\mgt_rxcharisk_reg_reg[7] ;
  wire [63:0]\mgt_rxdata_reg_reg[63] ;
  wire [7:0]\mgt_rxdisperr_reg_reg[7] ;
  wire [7:0]\mgt_rxnotintable_reg_reg[7] ;
  wire [7:0]mgt_txcharisk;
  wire [63:0]mgt_txdata;
  wire refclk;
  wire [0:0]uclk_loopback_int;
  wire [11:0]\uclk_mgt_rxbufstatus_reg_reg[11] ;
  wire uclk_mgt_tx_reset;
  wire xaui_rx_l0_n;
  wire xaui_rx_l0_p;
  wire xaui_rx_l1_n;
  wire xaui_rx_l1_p;
  wire xaui_rx_l2_n;
  wire xaui_rx_l2_p;
  wire xaui_rx_l3_n;
  wire xaui_rx_l3_p;
  wire xaui_tx_l0_n;
  wire xaui_tx_l0_p;
  wire xaui_tx_l1_n;
  wire xaui_tx_l1_p;
  wire xaui_tx_l2_n;
  wire xaui_tx_l2_p;
  wire xaui_tx_l3_n;
  wire xaui_tx_l3_p;
  wire NLW_gtxe2_common_0_i_DRPRDY_UNCONNECTED;
  wire NLW_gtxe2_common_0_i_QPLLFBCLKLOST_UNCONNECTED;
  wire NLW_gtxe2_common_0_i_REFCLKOUTMONITOR_UNCONNECTED;
  wire [15:0]NLW_gtxe2_common_0_i_DRPDO_UNCONNECTED;
  wire [7:0]NLW_gtxe2_common_0_i_QPLLDMONITOR_UNCONNECTED;

  xaui_xaui_gt_wrapper_GT gt0_xaui_gt_wrapper_i
       (.CLK(CLK),
        .D(D[3]),
        .Q(Q[0]),
        .RXCHBONDO(gt1_rxchbondo_i),
        .\core_mgt_rx_reset_reg[0] (\core_mgt_rx_reset_reg[3] [0]),
        .dclk(dclk),
        .gt0_dmonitorout_out(gt0_dmonitorout_out),
        .gt0_drpaddr(gt0_drpaddr),
        .gt0_drpdi(gt0_drpdi),
        .gt0_drpdo(gt0_drpdo),
        .gt0_drpen(gt0_drpen),
        .gt0_drprdy(gt0_drprdy),
        .gt0_drpwe(gt0_drpwe),
        .gt0_eyescandataerror_out(gt0_eyescandataerror_out),
        .gt0_eyescanreset_in(gt0_eyescanreset_in),
        .gt0_eyescantrigger_in(gt0_eyescantrigger_in),
        .gt0_loopback_in(gt0_loopback_in),
        .gt0_qpllclk_i(gt0_qpllclk_i),
        .gt0_qpllrefclk_i(gt0_qpllrefclk_i),
        .gt0_rxcdrhold_in(gt0_rxcdrhold_in),
        .gt0_rxcommadet_out(gt0_rxcommadet_out),
        .gt0_rxdfelpmreset_in(gt0_rxdfelpmreset_in),
        .gt0_rxlpmen_in(gt0_rxlpmen_in),
        .gt0_rxmonitorout_out(gt0_rxmonitorout_out),
        .gt0_rxmonitorsel_in(gt0_rxmonitorsel_in),
        .gt0_rxpcsreset_in(gt0_rxpcsreset_in),
        .gt0_rxpmareset_in(gt0_rxpmareset_in),
        .gt0_rxpolarity_in(gt0_rxpolarity_in),
        .gt0_rxprbscntreset_in(gt0_rxprbscntreset_in),
        .gt0_rxprbserr_out(gt0_rxprbserr_out),
        .gt0_rxprbssel_in(gt0_rxprbssel_in),
        .gt0_rxrate_in(gt0_rxrate_in),
        .gt0_rxresetdone_out(gt0_rxresetdone_out),
        .gt0_txdiffctrl_in(gt0_txdiffctrl_in),
        .gt0_txdlyen_in(gt0_txdlyen_in),
        .gt0_txdlysreset_in(gt0_txdlysreset_in),
        .gt0_txdlysresetdone_out(gt0_txdlysresetdone_out),
        .gt0_txinhibit_in(gt0_txinhibit_in),
        .gt0_txoutclk_out(gt0_txoutclk_out),
        .gt0_txpcsreset_in(gt0_txpcsreset_in),
        .gt0_txphalign_in(gt0_txphalign_in),
        .gt0_txphaligndone_out(gt0_txphaligndone_out),
        .gt0_txphinit_in(gt0_txphinit_in),
        .gt0_txphinitdone_out(gt0_txphinitdone_out),
        .gt0_txpmareset_in(gt0_txpmareset_in),
        .gt0_txpolarity_in(gt0_txpolarity_in),
        .gt0_txpostcursor_in(gt0_txpostcursor_in),
        .gt0_txprbsforceerr_in(gt0_txprbsforceerr_in),
        .gt0_txprbssel_in(gt0_txprbssel_in),
        .gt0_txprecursor_in(gt0_txprecursor_in),
        .gt3_gtrxreset_in(gt3_gtrxreset_in),
        .gt3_rxchbonden_in(gt3_rxchbonden_in),
        .gt3_txelecidle_in(gt3_txelecidle_in),
        .gt3_txuserrdy_in(gt3_txuserrdy_in),
        .\mgt_codecomma_reg_reg[1] (\mgt_codecomma_reg_reg[7] [1:0]),
        .mgt_enable_align(mgt_enable_align[0]),
        .\mgt_rxcharisk_reg_reg[1] (\mgt_rxcharisk_reg_reg[7] [1:0]),
        .\mgt_rxdata_reg_reg[15] (\mgt_rxdata_reg_reg[63] [15:0]),
        .\mgt_rxdisperr_reg_reg[1] (\mgt_rxdisperr_reg_reg[7] [1:0]),
        .\mgt_rxnotintable_reg_reg[1] (\mgt_rxnotintable_reg_reg[7] [1:0]),
        .mgt_txcharisk(mgt_txcharisk[1:0]),
        .mgt_txdata(mgt_txdata[15:0]),
        .uclk_loopback_int(uclk_loopback_int),
        .\uclk_mgt_rxbufstatus_reg_reg[2] (\uclk_mgt_rxbufstatus_reg_reg[11] [2:0]),
        .uclk_mgt_tx_reset(uclk_mgt_tx_reset),
        .xaui_rx_l0_n(xaui_rx_l0_n),
        .xaui_rx_l0_p(xaui_rx_l0_p),
        .xaui_tx_l0_n(xaui_tx_l0_n),
        .xaui_tx_l0_p(xaui_tx_l0_p));
  xaui_xaui_gt_wrapper_GT_20 gt1_xaui_gt_wrapper_i
       (.CLK(CLK),
        .D(D[2]),
        .Q(Q[1]),
        .RXCHBONDO(gt1_rxchbondo_i),
        .\core_mgt_rx_reset_reg[1] (\core_mgt_rx_reset_reg[3] [1]),
        .dclk(dclk),
        .gt0_qpllclk_i(gt0_qpllclk_i),
        .gt0_qpllrefclk_i(gt0_qpllrefclk_i),
        .gt1_dmonitorout_out(gt1_dmonitorout_out),
        .gt1_drpaddr(gt1_drpaddr),
        .gt1_drpdi(gt1_drpdi),
        .gt1_drpdo(gt1_drpdo),
        .gt1_drpen(gt1_drpen),
        .gt1_drprdy(gt1_drprdy),
        .gt1_drpwe(gt1_drpwe),
        .gt1_eyescandataerror_out(gt1_eyescandataerror_out),
        .gt1_eyescanreset_in(gt1_eyescanreset_in),
        .gt1_eyescantrigger_in(gt1_eyescantrigger_in),
        .gt1_loopback_in(gt1_loopback_in),
        .gt1_rxcdrhold_in(gt1_rxcdrhold_in),
        .gt1_rxcommadet_out(gt1_rxcommadet_out),
        .gt1_rxdfelpmreset_in(gt1_rxdfelpmreset_in),
        .gt1_rxlpmen_in(gt1_rxlpmen_in),
        .gt1_rxmonitorout_out(gt1_rxmonitorout_out),
        .gt1_rxmonitorsel_in(gt1_rxmonitorsel_in),
        .gt1_rxpcsreset_in(gt1_rxpcsreset_in),
        .gt1_rxpmareset_in(gt1_rxpmareset_in),
        .gt1_rxpolarity_in(gt1_rxpolarity_in),
        .gt1_rxprbscntreset_in(gt1_rxprbscntreset_in),
        .gt1_rxprbserr_out(gt1_rxprbserr_out),
        .gt1_rxprbssel_in(gt1_rxprbssel_in),
        .gt1_rxrate_in(gt1_rxrate_in),
        .gt1_rxresetdone_out(gt1_rxresetdone_out),
        .gt1_txdiffctrl_in(gt1_txdiffctrl_in),
        .gt1_txdlysreset_in(gt1_txdlysreset_in),
        .gt1_txdlysresetdone_out(gt1_txdlysresetdone_out),
        .gt1_txinhibit_in(gt1_txinhibit_in),
        .gt1_txpcsreset_in(gt1_txpcsreset_in),
        .gt1_txphalign_in(gt1_txphalign_in),
        .gt1_txphaligndone_out(gt1_txphaligndone_out),
        .gt1_txphinit_in(gt1_txphinit_in),
        .gt1_txphinitdone_out(gt1_txphinitdone_out),
        .gt1_txpmareset_in(gt1_txpmareset_in),
        .gt1_txpolarity_in(gt1_txpolarity_in),
        .gt1_txpostcursor_in(gt1_txpostcursor_in),
        .gt1_txprbsforceerr_in(gt1_txprbsforceerr_in),
        .gt1_txprbssel_in(gt1_txprbssel_in),
        .gt1_txprecursor_in(gt1_txprecursor_in),
        .gt3_gtrxreset_in(gt3_gtrxreset_in),
        .gt3_rxchbonden_in(gt3_rxchbonden_in),
        .gt3_txelecidle_in(gt3_txelecidle_in),
        .gt3_txuserrdy_in(gt3_txuserrdy_in),
        .\mgt_codecomma_reg_reg[3] (\mgt_codecomma_reg_reg[7] [3:2]),
        .mgt_enable_align(mgt_enable_align[1]),
        .\mgt_rxcharisk_reg_reg[3] (\mgt_rxcharisk_reg_reg[7] [3:2]),
        .\mgt_rxdata_reg_reg[31] (\mgt_rxdata_reg_reg[63] [31:16]),
        .\mgt_rxdisperr_reg_reg[3] (\mgt_rxdisperr_reg_reg[7] [3:2]),
        .\mgt_rxnotintable_reg_reg[3] (\mgt_rxnotintable_reg_reg[7] [3:2]),
        .mgt_txcharisk(mgt_txcharisk[3:2]),
        .mgt_txdata(mgt_txdata[31:16]),
        .uclk_loopback_int(uclk_loopback_int),
        .uclk_mgt_rx_reset_reg(gt2_rxchbondo_i),
        .\uclk_mgt_rxbufstatus_reg_reg[5] (\uclk_mgt_rxbufstatus_reg_reg[11] [5:3]),
        .uclk_mgt_tx_reset(uclk_mgt_tx_reset),
        .xaui_rx_l1_n(xaui_rx_l1_n),
        .xaui_rx_l1_p(xaui_rx_l1_p),
        .xaui_tx_l1_n(xaui_tx_l1_n),
        .xaui_tx_l1_p(xaui_tx_l1_p));
  xaui_xaui_gt_wrapper_GT_21 gt2_xaui_gt_wrapper_i
       (.CLK(CLK),
        .D(D[1]),
        .Q(Q[2]),
        .\core_mgt_rx_reset_reg[2] (\core_mgt_rx_reset_reg[3] [2]),
        .data_sync_reg1(gt2_rxchbondo_i),
        .dclk(dclk),
        .gt0_qpllclk_i(gt0_qpllclk_i),
        .gt0_qpllrefclk_i(gt0_qpllrefclk_i),
        .gt2_dmonitorout_out(gt2_dmonitorout_out),
        .gt2_drpaddr(gt2_drpaddr),
        .gt2_drpdi(gt2_drpdi),
        .gt2_drpdo(gt2_drpdo),
        .gt2_drpen(gt2_drpen),
        .gt2_drprdy(gt2_drprdy),
        .gt2_drpwe(gt2_drpwe),
        .gt2_eyescandataerror_out(gt2_eyescandataerror_out),
        .gt2_eyescanreset_in(gt2_eyescanreset_in),
        .gt2_eyescantrigger_in(gt2_eyescantrigger_in),
        .gt2_loopback_in(gt2_loopback_in),
        .gt2_rxcdrhold_in(gt2_rxcdrhold_in),
        .gt2_rxcommadet_out(gt2_rxcommadet_out),
        .gt2_rxdfelpmreset_in(gt2_rxdfelpmreset_in),
        .gt2_rxlpmen_in(gt2_rxlpmen_in),
        .gt2_rxmonitorout_out(gt2_rxmonitorout_out),
        .gt2_rxmonitorsel_in(gt2_rxmonitorsel_in),
        .gt2_rxpcsreset_in(gt2_rxpcsreset_in),
        .gt2_rxpmareset_in(gt2_rxpmareset_in),
        .gt2_rxpolarity_in(gt2_rxpolarity_in),
        .gt2_rxprbscntreset_in(gt2_rxprbscntreset_in),
        .gt2_rxprbserr_out(gt2_rxprbserr_out),
        .gt2_rxprbssel_in(gt2_rxprbssel_in),
        .gt2_rxrate_in(gt2_rxrate_in),
        .gt2_rxresetdone_out(gt2_rxresetdone_out),
        .gt2_txdiffctrl_in(gt2_txdiffctrl_in),
        .gt2_txdlysreset_in(gt2_txdlysreset_in),
        .gt2_txdlysresetdone_out(gt2_txdlysresetdone_out),
        .gt2_txinhibit_in(gt2_txinhibit_in),
        .gt2_txpcsreset_in(gt2_txpcsreset_in),
        .gt2_txphalign_in(gt2_txphalign_in),
        .gt2_txphaligndone_out(gt2_txphaligndone_out),
        .gt2_txphinit_in(gt2_txphinit_in),
        .gt2_txphinitdone_out(gt2_txphinitdone_out),
        .gt2_txpmareset_in(gt2_txpmareset_in),
        .gt2_txpolarity_in(gt2_txpolarity_in),
        .gt2_txpostcursor_in(gt2_txpostcursor_in),
        .gt2_txprbsforceerr_in(gt2_txprbsforceerr_in),
        .gt2_txprbssel_in(gt2_txprbssel_in),
        .gt2_txprecursor_in(gt2_txprecursor_in),
        .gt3_gtrxreset_in(gt3_gtrxreset_in),
        .gt3_rxchbonden_in(gt3_rxchbonden_in),
        .gt3_txelecidle_in(gt3_txelecidle_in),
        .gt3_txuserrdy_in(gt3_txuserrdy_in),
        .\mgt_codecomma_reg_reg[5] (\mgt_codecomma_reg_reg[7] [5:4]),
        .mgt_enable_align(mgt_enable_align[2]),
        .\mgt_rxcharisk_reg_reg[5] (\mgt_rxcharisk_reg_reg[7] [5:4]),
        .\mgt_rxdata_reg_reg[47] (\mgt_rxdata_reg_reg[63] [47:32]),
        .\mgt_rxdisperr_reg_reg[5] (\mgt_rxdisperr_reg_reg[7] [5:4]),
        .\mgt_rxnotintable_reg_reg[5] (\mgt_rxnotintable_reg_reg[7] [5:4]),
        .mgt_txcharisk(mgt_txcharisk[5:4]),
        .mgt_txdata(mgt_txdata[47:32]),
        .uclk_loopback_int(uclk_loopback_int),
        .\uclk_mgt_rxbufstatus_reg_reg[8] (\uclk_mgt_rxbufstatus_reg_reg[11] [8:6]),
        .uclk_mgt_tx_reset(uclk_mgt_tx_reset),
        .xaui_rx_l2_n(xaui_rx_l2_n),
        .xaui_rx_l2_p(xaui_rx_l2_p),
        .xaui_tx_l2_n(xaui_tx_l2_n),
        .xaui_tx_l2_p(xaui_tx_l2_p));
  xaui_xaui_gt_wrapper_GT_22 gt3_xaui_gt_wrapper_i
       (.CLK(CLK),
        .D(D[0]),
        .Q(Q[3]),
        .\core_mgt_rx_reset_reg[3] (\core_mgt_rx_reset_reg[3] [3]),
        .dclk(dclk),
        .gt0_qpllclk_i(gt0_qpllclk_i),
        .gt0_qpllrefclk_i(gt0_qpllrefclk_i),
        .gt3_dmonitorout_out(gt3_dmonitorout_out),
        .gt3_drpaddr(gt3_drpaddr),
        .gt3_drpdi(gt3_drpdi),
        .gt3_drpdo(gt3_drpdo),
        .gt3_drpen(gt3_drpen),
        .gt3_drprdy(gt3_drprdy),
        .gt3_drpwe(gt3_drpwe),
        .gt3_eyescandataerror_out(gt3_eyescandataerror_out),
        .gt3_eyescanreset_in(gt3_eyescanreset_in),
        .gt3_eyescantrigger_in(gt3_eyescantrigger_in),
        .gt3_gtrxreset_in(gt3_gtrxreset_in),
        .gt3_loopback_in(gt3_loopback_in),
        .gt3_rxcdrhold_in(gt3_rxcdrhold_in),
        .gt3_rxchbonden_in(gt3_rxchbonden_in),
        .gt3_rxcommadet_out(gt3_rxcommadet_out),
        .gt3_rxdfelpmreset_in(gt3_rxdfelpmreset_in),
        .gt3_rxlpmen_in(gt3_rxlpmen_in),
        .gt3_rxmonitorout_out(gt3_rxmonitorout_out),
        .gt3_rxmonitorsel_in(gt3_rxmonitorsel_in),
        .gt3_rxpcsreset_in(gt3_rxpcsreset_in),
        .gt3_rxpmareset_in(gt3_rxpmareset_in),
        .gt3_rxpolarity_in(gt3_rxpolarity_in),
        .gt3_rxprbscntreset_in(gt3_rxprbscntreset_in),
        .gt3_rxprbserr_out(gt3_rxprbserr_out),
        .gt3_rxprbssel_in(gt3_rxprbssel_in),
        .gt3_rxrate_in(gt3_rxrate_in),
        .gt3_rxresetdone_out(gt3_rxresetdone_out),
        .gt3_txdiffctrl_in(gt3_txdiffctrl_in),
        .gt3_txdlysreset_in(gt3_txdlysreset_in),
        .gt3_txdlysresetdone_out(gt3_txdlysresetdone_out),
        .gt3_txelecidle_in(gt3_txelecidle_in),
        .gt3_txinhibit_in(gt3_txinhibit_in),
        .gt3_txpcsreset_in(gt3_txpcsreset_in),
        .gt3_txphalign_in(gt3_txphalign_in),
        .gt3_txphaligndone_out(gt3_txphaligndone_out),
        .gt3_txphinit_in(gt3_txphinit_in),
        .gt3_txphinitdone_out(gt3_txphinitdone_out),
        .gt3_txpmareset_in(gt3_txpmareset_in),
        .gt3_txpolarity_in(gt3_txpolarity_in),
        .gt3_txpostcursor_in(gt3_txpostcursor_in),
        .gt3_txprbsforceerr_in(gt3_txprbsforceerr_in),
        .gt3_txprbssel_in(gt3_txprbssel_in),
        .gt3_txprecursor_in(gt3_txprecursor_in),
        .gt3_txuserrdy_in(gt3_txuserrdy_in),
        .\mgt_codecomma_reg_reg[7] (\mgt_codecomma_reg_reg[7] [7:6]),
        .mgt_enable_align(mgt_enable_align[3]),
        .\mgt_rxcharisk_reg_reg[7] (\mgt_rxcharisk_reg_reg[7] [7:6]),
        .\mgt_rxdata_reg_reg[63] (\mgt_rxdata_reg_reg[63] [63:48]),
        .\mgt_rxdisperr_reg_reg[7] (\mgt_rxdisperr_reg_reg[7] [7:6]),
        .\mgt_rxnotintable_reg_reg[7] (\mgt_rxnotintable_reg_reg[7] [7:6]),
        .mgt_txcharisk(mgt_txcharisk[7:6]),
        .mgt_txdata(mgt_txdata[63:48]),
        .uclk_loopback_int(uclk_loopback_int),
        .uclk_mgt_rx_reset_reg(gt2_rxchbondo_i),
        .\uclk_mgt_rxbufstatus_reg_reg[11] (\uclk_mgt_rxbufstatus_reg_reg[11] [11:9]),
        .uclk_mgt_tx_reset(uclk_mgt_tx_reset),
        .xaui_rx_l3_n(xaui_rx_l3_n),
        .xaui_rx_l3_p(xaui_rx_l3_p),
        .xaui_tx_l3_n(xaui_tx_l3_n),
        .xaui_tx_l3_p(xaui_tx_l3_p));
  (* box_type = "PRIMITIVE" *) 
  GTXE2_COMMON #(
    .BIAS_CFG(64'h0000040000001000),
    .COMMON_CFG(32'h00000000),
    .IS_DRPCLK_INVERTED(1'b0),
    .IS_GTGREFCLK_INVERTED(1'b0),
    .IS_QPLLLOCKDETCLK_INVERTED(1'b0),
    .QPLL_CFG(27'h06801C1),
    .QPLL_CLKOUT_CFG(4'b0000),
    .QPLL_COARSE_FREQ_OVRD(6'b010000),
    .QPLL_COARSE_FREQ_OVRD_EN(1'b0),
    .QPLL_CP(10'b0000011111),
    .QPLL_CP_MONITOR_EN(1'b0),
    .QPLL_DMONITOR_SEL(1'b0),
    .QPLL_FBDIV(10'b0010000000),
    .QPLL_FBDIV_MONITOR_EN(1'b0),
    .QPLL_FBDIV_RATIO(1'b1),
    .QPLL_INIT_CFG(24'h000006),
    .QPLL_LOCK_CFG(16'h21E8),
    .QPLL_LPF(4'b1111),
    .QPLL_REFCLK_DIV(1),
    .SIM_QPLLREFCLK_SEL(3'b001),
    .SIM_RESET_SPEEDUP("TRUE"),
    .SIM_VERSION("4.0")) 
    gtxe2_common_0_i
       (.BGBYPASSB(1'b1),
        .BGMONITORENB(1'b1),
        .BGPDB(1'b1),
        .BGRCALOVRD({1'b1,1'b1,1'b1,1'b1,1'b1}),
        .DRPADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DRPCLK(1'b0),
        .DRPDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DRPDO(NLW_gtxe2_common_0_i_DRPDO_UNCONNECTED[15:0]),
        .DRPEN(1'b0),
        .DRPRDY(NLW_gtxe2_common_0_i_DRPRDY_UNCONNECTED),
        .DRPWE(1'b0),
        .GTGREFCLK(1'b0),
        .GTNORTHREFCLK0(1'b0),
        .GTNORTHREFCLK1(1'b0),
        .GTREFCLK0(refclk),
        .GTREFCLK1(1'b0),
        .GTSOUTHREFCLK0(1'b0),
        .GTSOUTHREFCLK1(1'b0),
        .PMARSVD({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .QPLLDMONITOR(NLW_gtxe2_common_0_i_QPLLDMONITOR_UNCONNECTED[7:0]),
        .QPLLFBCLKLOST(NLW_gtxe2_common_0_i_QPLLFBCLKLOST_UNCONNECTED),
        .QPLLLOCK(gt_qplllock_out),
        .QPLLLOCKDETCLK(dclk),
        .QPLLLOCKEN(1'b1),
        .QPLLOUTCLK(gt0_qpllclk_i),
        .QPLLOUTREFCLK(gt0_qpllrefclk_i),
        .QPLLOUTRESET(1'b0),
        .QPLLPD(1'b0),
        .QPLLREFCLKLOST(gtxe2_common_0_i_n_5),
        .QPLLREFCLKSEL({1'b0,1'b0,1'b1}),
        .QPLLRESET(gt0_qpllreset_in),
        .QPLLRSVD1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .QPLLRSVD2({1'b1,1'b1,1'b1,1'b1,1'b1}),
        .RCALENB(1'b1),
        .REFCLKOUTMONITOR(NLW_gtxe2_common_0_i_REFCLKOUTMONITOR_UNCONNECTED));
endmodule

(* ORIG_REF_NAME = "xaui_gt_wrapper_GT" *) 
module xaui_xaui_gt_wrapper_GT
   (gt0_drprdy,
    gt0_eyescandataerror_out,
    xaui_tx_l0_n,
    xaui_tx_l0_p,
    gt0_rxcommadet_out,
    gt0_rxprbserr_out,
    gt0_rxresetdone_out,
    gt0_txdlysresetdone_out,
    gt0_txoutclk_out,
    gt0_txphaligndone_out,
    gt0_txphinitdone_out,
    D,
    gt0_drpdo,
    \uclk_mgt_rxbufstatus_reg_reg[2] ,
    \mgt_rxdata_reg_reg[15] ,
    gt0_rxmonitorout_out,
    gt0_dmonitorout_out,
    \mgt_codecomma_reg_reg[1] ,
    \mgt_rxcharisk_reg_reg[1] ,
    \mgt_rxdisperr_reg_reg[1] ,
    \mgt_rxnotintable_reg_reg[1] ,
    \core_mgt_rx_reset_reg[0] ,
    dclk,
    gt0_drpen,
    gt0_drpwe,
    gt0_eyescanreset_in,
    gt0_eyescantrigger_in,
    gt3_gtrxreset_in,
    uclk_mgt_tx_reset,
    xaui_rx_l0_n,
    xaui_rx_l0_p,
    gt0_qpllclk_i,
    gt0_qpllrefclk_i,
    Q,
    gt0_rxcdrhold_in,
    gt3_rxchbonden_in,
    gt0_rxdfelpmreset_in,
    gt0_rxlpmen_in,
    mgt_enable_align,
    gt0_rxpcsreset_in,
    gt0_rxpmareset_in,
    gt0_rxpolarity_in,
    gt0_rxprbscntreset_in,
    gt3_txuserrdy_in,
    CLK,
    gt0_txdlyen_in,
    gt0_txdlysreset_in,
    gt3_txelecidle_in,
    gt0_txinhibit_in,
    gt0_txpcsreset_in,
    gt0_txphalign_in,
    gt0_txphinit_in,
    gt0_txpmareset_in,
    gt0_txpolarity_in,
    gt0_txprbsforceerr_in,
    gt0_drpdi,
    gt0_rxmonitorsel_in,
    gt0_loopback_in,
    gt0_rxprbssel_in,
    gt0_rxrate_in,
    gt0_txprbssel_in,
    gt0_txdiffctrl_in,
    RXCHBONDO,
    gt0_txpostcursor_in,
    gt0_txprecursor_in,
    mgt_txdata,
    mgt_txcharisk,
    gt0_drpaddr,
    uclk_loopback_int);
  output gt0_drprdy;
  output gt0_eyescandataerror_out;
  output xaui_tx_l0_n;
  output xaui_tx_l0_p;
  output gt0_rxcommadet_out;
  output gt0_rxprbserr_out;
  output gt0_rxresetdone_out;
  output gt0_txdlysresetdone_out;
  output gt0_txoutclk_out;
  output gt0_txphaligndone_out;
  output gt0_txphinitdone_out;
  output [0:0]D;
  output [15:0]gt0_drpdo;
  output [2:0]\uclk_mgt_rxbufstatus_reg_reg[2] ;
  output [15:0]\mgt_rxdata_reg_reg[15] ;
  output [6:0]gt0_rxmonitorout_out;
  output [7:0]gt0_dmonitorout_out;
  output [1:0]\mgt_codecomma_reg_reg[1] ;
  output [1:0]\mgt_rxcharisk_reg_reg[1] ;
  output [1:0]\mgt_rxdisperr_reg_reg[1] ;
  output [1:0]\mgt_rxnotintable_reg_reg[1] ;
  output [0:0]\core_mgt_rx_reset_reg[0] ;
  input dclk;
  input gt0_drpen;
  input gt0_drpwe;
  input gt0_eyescanreset_in;
  input gt0_eyescantrigger_in;
  input gt3_gtrxreset_in;
  input uclk_mgt_tx_reset;
  input xaui_rx_l0_n;
  input xaui_rx_l0_p;
  input gt0_qpllclk_i;
  input gt0_qpllrefclk_i;
  input [0:0]Q;
  input gt0_rxcdrhold_in;
  input gt3_rxchbonden_in;
  input gt0_rxdfelpmreset_in;
  input gt0_rxlpmen_in;
  input [0:0]mgt_enable_align;
  input gt0_rxpcsreset_in;
  input gt0_rxpmareset_in;
  input gt0_rxpolarity_in;
  input gt0_rxprbscntreset_in;
  input gt3_txuserrdy_in;
  input CLK;
  input gt0_txdlyen_in;
  input gt0_txdlysreset_in;
  input gt3_txelecidle_in;
  input gt0_txinhibit_in;
  input gt0_txpcsreset_in;
  input gt0_txphalign_in;
  input gt0_txphinit_in;
  input gt0_txpmareset_in;
  input gt0_txpolarity_in;
  input gt0_txprbsforceerr_in;
  input [15:0]gt0_drpdi;
  input [1:0]gt0_rxmonitorsel_in;
  input [2:0]gt0_loopback_in;
  input [2:0]gt0_rxprbssel_in;
  input [2:0]gt0_rxrate_in;
  input [2:0]gt0_txprbssel_in;
  input [3:0]gt0_txdiffctrl_in;
  input [4:0]RXCHBONDO;
  input [4:0]gt0_txpostcursor_in;
  input [4:0]gt0_txprecursor_in;
  input [15:0]mgt_txdata;
  input [1:0]mgt_txcharisk;
  input [8:0]gt0_drpaddr;
  input [0:0]uclk_loopback_int;

  wire CLK;
  wire [0:0]D;
  wire [0:0]Q;
  wire [4:0]RXCHBONDO;
  wire [0:0]\core_mgt_rx_reset_reg[0] ;
  wire dclk;
  wire [7:0]gt0_dmonitorout_out;
  wire [8:0]gt0_drpaddr;
  wire [15:0]gt0_drpdi;
  wire [15:0]gt0_drpdo;
  wire gt0_drpen;
  wire gt0_drprdy;
  wire gt0_drpwe;
  wire gt0_eyescandataerror_out;
  wire gt0_eyescanreset_in;
  wire gt0_eyescantrigger_in;
  wire [2:0]gt0_loopback_in;
  wire [1:1]gt0_loopback_in3_out;
  wire gt0_qpllclk_i;
  wire gt0_qpllrefclk_i;
  wire gt0_rxcdrhold_in;
  wire gt0_rxcommadet_out;
  wire gt0_rxdfelpmreset_in;
  wire gt0_rxlpmen_in;
  wire [6:0]gt0_rxmonitorout_out;
  wire [1:0]gt0_rxmonitorsel_in;
  wire gt0_rxpcsreset_in;
  wire gt0_rxpmareset_in;
  wire gt0_rxpolarity_in;
  wire gt0_rxprbscntreset_in;
  wire gt0_rxprbserr_out;
  wire [2:0]gt0_rxprbssel_in;
  wire [2:0]gt0_rxrate_in;
  wire gt0_rxresetdone_out;
  wire [3:0]gt0_txdiffctrl_in;
  wire gt0_txdlyen_in;
  wire gt0_txdlysreset_in;
  wire gt0_txdlysresetdone_out;
  wire gt0_txinhibit_in;
  wire gt0_txoutclk_out;
  wire gt0_txpcsreset_in;
  wire gt0_txphalign_in;
  wire gt0_txphaligndone_out;
  wire gt0_txphinit_in;
  wire gt0_txphinitdone_out;
  wire gt0_txpmareset_in;
  wire gt0_txpolarity_in;
  wire [4:0]gt0_txpostcursor_in;
  wire gt0_txprbsforceerr_in;
  wire [2:0]gt0_txprbssel_in;
  wire [4:0]gt0_txprecursor_in;
  wire gt3_gtrxreset_in;
  wire gt3_rxchbonden_in;
  wire gt3_txelecidle_in;
  wire gt3_txuserrdy_in;
  wire gtxe2_i_n_10;
  wire gtxe2_i_n_12;
  wire gtxe2_i_n_13;
  wire gtxe2_i_n_14;
  wire gtxe2_i_n_23;
  wire gtxe2_i_n_30;
  wire gtxe2_i_n_38;
  wire gtxe2_i_n_39;
  wire gtxe2_i_n_78;
  wire gtxe2_i_n_79;
  wire gtxe2_i_n_9;
  wire gtxe2_i_n_91;
  wire gtxe2_i_n_92;
  wire gtxe2_i_n_93;
  wire gtxe2_i_n_94;
  wire gtxe2_i_n_95;
  wire [1:0]\mgt_codecomma_reg_reg[1] ;
  wire [0:0]mgt_enable_align;
  wire [1:0]\mgt_rxcharisk_reg_reg[1] ;
  wire [15:0]\mgt_rxdata_reg_reg[15] ;
  wire [1:0]\mgt_rxdisperr_reg_reg[1] ;
  wire [1:0]\mgt_rxnotintable_reg_reg[1] ;
  wire [1:0]mgt_txcharisk;
  wire [15:0]mgt_txdata;
  wire [0:0]uclk_loopback_int;
  wire [2:0]\uclk_mgt_rxbufstatus_reg_reg[2] ;
  wire uclk_mgt_tx_reset;
  wire xaui_rx_l0_n;
  wire xaui_rx_l0_p;
  wire xaui_tx_l0_n;
  wire xaui_tx_l0_p;
  wire NLW_gtxe2_i_CPLLFBCLKLOST_UNCONNECTED;
  wire NLW_gtxe2_i_CPLLLOCK_UNCONNECTED;
  wire NLW_gtxe2_i_CPLLREFCLKLOST_UNCONNECTED;
  wire NLW_gtxe2_i_GTREFCLKMONITOR_UNCONNECTED;
  wire NLW_gtxe2_i_PHYSTATUS_UNCONNECTED;
  wire NLW_gtxe2_i_RXCDRLOCK_UNCONNECTED;
  wire NLW_gtxe2_i_RXCOMINITDET_UNCONNECTED;
  wire NLW_gtxe2_i_RXCOMSASDET_UNCONNECTED;
  wire NLW_gtxe2_i_RXCOMWAKEDET_UNCONNECTED;
  wire NLW_gtxe2_i_RXDATAVALID_UNCONNECTED;
  wire NLW_gtxe2_i_RXDLYSRESETDONE_UNCONNECTED;
  wire NLW_gtxe2_i_RXELECIDLE_UNCONNECTED;
  wire NLW_gtxe2_i_RXHEADERVALID_UNCONNECTED;
  wire NLW_gtxe2_i_RXOUTCLKFABRIC_UNCONNECTED;
  wire NLW_gtxe2_i_RXOUTCLKPCS_UNCONNECTED;
  wire NLW_gtxe2_i_RXPHALIGNDONE_UNCONNECTED;
  wire NLW_gtxe2_i_RXQPISENN_UNCONNECTED;
  wire NLW_gtxe2_i_RXQPISENP_UNCONNECTED;
  wire NLW_gtxe2_i_RXSTARTOFSEQ_UNCONNECTED;
  wire NLW_gtxe2_i_RXVALID_UNCONNECTED;
  wire NLW_gtxe2_i_TXCOMFINISH_UNCONNECTED;
  wire NLW_gtxe2_i_TXGEARBOXREADY_UNCONNECTED;
  wire NLW_gtxe2_i_TXQPISENN_UNCONNECTED;
  wire NLW_gtxe2_i_TXQPISENP_UNCONNECTED;
  wire NLW_gtxe2_i_TXRATEDONE_UNCONNECTED;
  wire [15:0]NLW_gtxe2_i_PCSRSVDOUT_UNCONNECTED;
  wire [7:2]NLW_gtxe2_i_RXCHARISCOMMA_UNCONNECTED;
  wire [7:2]NLW_gtxe2_i_RXCHARISK_UNCONNECTED;
  wire [63:16]NLW_gtxe2_i_RXDATA_UNCONNECTED;
  wire [7:2]NLW_gtxe2_i_RXDISPERR_UNCONNECTED;
  wire [2:0]NLW_gtxe2_i_RXHEADER_UNCONNECTED;
  wire [7:2]NLW_gtxe2_i_RXNOTINTABLE_UNCONNECTED;
  wire [4:0]NLW_gtxe2_i_RXPHMONITOR_UNCONNECTED;
  wire [4:0]NLW_gtxe2_i_RXPHSLIPMONITOR_UNCONNECTED;
  wire [2:0]NLW_gtxe2_i_RXSTATUS_UNCONNECTED;
  wire [9:0]NLW_gtxe2_i_TSTOUT_UNCONNECTED;
  wire [1:0]NLW_gtxe2_i_TXBUFSTATUS_UNCONNECTED;

  LUT1 #(
    .INIT(2'h1)) 
    \core_mgt_rx_reset[0]_i_1 
       (.I0(gt0_rxresetdone_out),
        .O(\core_mgt_rx_reset_reg[0] ));
  (* box_type = "PRIMITIVE" *) 
  GTXE2_CHANNEL #(
    .ALIGN_COMMA_DOUBLE("FALSE"),
    .ALIGN_COMMA_ENABLE(10'b0001111111),
    .ALIGN_COMMA_WORD(1),
    .ALIGN_MCOMMA_DET("TRUE"),
    .ALIGN_MCOMMA_VALUE(10'b1010000011),
    .ALIGN_PCOMMA_DET("TRUE"),
    .ALIGN_PCOMMA_VALUE(10'b0101111100),
    .CBCC_DATA_SOURCE_SEL("DECODED"),
    .CHAN_BOND_KEEP_ALIGN("FALSE"),
    .CHAN_BOND_MAX_SKEW(7),
    .CHAN_BOND_SEQ_1_1(10'b0101111100),
    .CHAN_BOND_SEQ_1_2(10'b0000000000),
    .CHAN_BOND_SEQ_1_3(10'b0000000000),
    .CHAN_BOND_SEQ_1_4(10'b0000000000),
    .CHAN_BOND_SEQ_1_ENABLE(4'b1111),
    .CHAN_BOND_SEQ_2_1(10'b0100000000),
    .CHAN_BOND_SEQ_2_2(10'b0100000000),
    .CHAN_BOND_SEQ_2_3(10'b0100000000),
    .CHAN_BOND_SEQ_2_4(10'b0100000000),
    .CHAN_BOND_SEQ_2_ENABLE(4'b1111),
    .CHAN_BOND_SEQ_2_USE("FALSE"),
    .CHAN_BOND_SEQ_LEN(1),
    .CLK_CORRECT_USE("TRUE"),
    .CLK_COR_KEEP_IDLE("FALSE"),
    .CLK_COR_MAX_LAT(19),
    .CLK_COR_MIN_LAT(17),
    .CLK_COR_PRECEDENCE("TRUE"),
    .CLK_COR_REPEAT_WAIT(0),
    .CLK_COR_SEQ_1_1(10'b0100011100),
    .CLK_COR_SEQ_1_2(10'b0100000000),
    .CLK_COR_SEQ_1_3(10'b0100000000),
    .CLK_COR_SEQ_1_4(10'b0100000000),
    .CLK_COR_SEQ_1_ENABLE(4'b1111),
    .CLK_COR_SEQ_2_1(10'b0100000000),
    .CLK_COR_SEQ_2_2(10'b0100000000),
    .CLK_COR_SEQ_2_3(10'b0100000000),
    .CLK_COR_SEQ_2_4(10'b0100000000),
    .CLK_COR_SEQ_2_ENABLE(4'b1111),
    .CLK_COR_SEQ_2_USE("FALSE"),
    .CLK_COR_SEQ_LEN(1),
    .CPLL_CFG(24'hBC07DC),
    .CPLL_FBDIV(4),
    .CPLL_FBDIV_45(5),
    .CPLL_INIT_CFG(24'h00001E),
    .CPLL_LOCK_CFG(16'h01E8),
    .CPLL_REFCLK_DIV(1),
    .DEC_MCOMMA_DETECT("TRUE"),
    .DEC_PCOMMA_DETECT("TRUE"),
    .DEC_VALID_COMMA_ONLY("TRUE"),
    .DMONITOR_CFG(24'h000A00),
    .ES_CONTROL(6'b000000),
    .ES_ERRDET_EN("FALSE"),
    .ES_EYE_SCAN_EN("TRUE"),
    .ES_HORZ_OFFSET(12'h000),
    .ES_PMA_CFG(10'b0000000000),
    .ES_PRESCALE(5'b00000),
    .ES_QUALIFIER(80'h00000000000000000000),
    .ES_QUAL_MASK(80'h00000000000000000000),
    .ES_SDATA_MASK(80'h00000000000000000000),
    .ES_VERT_OFFSET(9'b000000000),
    .FTS_DESKEW_SEQ_ENABLE(4'b1111),
    .FTS_LANE_DESKEW_CFG(4'b1111),
    .FTS_LANE_DESKEW_EN("FALSE"),
    .GEARBOX_MODE(3'b000),
    .IS_CPLLLOCKDETCLK_INVERTED(1'b0),
    .IS_DRPCLK_INVERTED(1'b0),
    .IS_GTGREFCLK_INVERTED(1'b0),
    .IS_RXUSRCLK2_INVERTED(1'b0),
    .IS_RXUSRCLK_INVERTED(1'b0),
    .IS_TXPHDLYTSTCLK_INVERTED(1'b0),
    .IS_TXUSRCLK2_INVERTED(1'b0),
    .IS_TXUSRCLK_INVERTED(1'b0),
    .OUTREFCLK_SEL_INV(2'b11),
    .PCS_PCIE_EN("FALSE"),
    .PCS_RSVD_ATTR(48'h000000000002),
    .PD_TRANS_TIME_FROM_P2(12'h03C),
    .PD_TRANS_TIME_NONE_P2(8'h19),
    .PD_TRANS_TIME_TO_P2(8'h64),
    .PMA_RSV(32'h00018480),
    .PMA_RSV2(16'h2050),
    .PMA_RSV3(2'b00),
    .PMA_RSV4(32'h00000000),
    .RXBUFRESET_TIME(5'b00001),
    .RXBUF_ADDR_MODE("FULL"),
    .RXBUF_EIDLE_HI_CNT(4'b1000),
    .RXBUF_EIDLE_LO_CNT(4'b0000),
    .RXBUF_EN("TRUE"),
    .RXBUF_RESET_ON_CB_CHANGE("TRUE"),
    .RXBUF_RESET_ON_COMMAALIGN("FALSE"),
    .RXBUF_RESET_ON_EIDLE("FALSE"),
    .RXBUF_RESET_ON_RATE_CHANGE("TRUE"),
    .RXBUF_THRESH_OVFLW(61),
    .RXBUF_THRESH_OVRD("FALSE"),
    .RXBUF_THRESH_UNDFLW(4),
    .RXCDRFREQRESET_TIME(5'b00001),
    .RXCDRPHRESET_TIME(5'b00001),
    .RXCDR_CFG(72'h03000023FF10200020),
    .RXCDR_FR_RESET_ON_EIDLE(1'b0),
    .RXCDR_HOLD_DURING_EIDLE(1'b0),
    .RXCDR_LOCK_CFG(6'b010101),
    .RXCDR_PH_RESET_ON_EIDLE(1'b0),
    .RXDFELPMRESET_TIME(7'b0001111),
    .RXDLY_CFG(16'h001F),
    .RXDLY_LCFG(9'h030),
    .RXDLY_TAP_CFG(16'h0000),
    .RXGEARBOX_EN("FALSE"),
    .RXISCANRESET_TIME(5'b00001),
    .RXLPM_HF_CFG(14'b00000011110000),
    .RXLPM_LF_CFG(14'b00000011110000),
    .RXOOB_CFG(7'b0000110),
    .RXOUT_DIV(2),
    .RXPCSRESET_TIME(5'b00001),
    .RXPHDLY_CFG(24'h084020),
    .RXPH_CFG(24'h000000),
    .RXPH_MONITOR_SEL(5'b00000),
    .RXPMARESET_TIME(5'b00011),
    .RXPRBS_ERR_LOOPBACK(1'b0),
    .RXSLIDE_AUTO_WAIT(7),
    .RXSLIDE_MODE("OFF"),
    .RX_BIAS_CFG(12'b000000000100),
    .RX_BUFFER_CFG(6'b000000),
    .RX_CLK25_DIV(7),
    .RX_CLKMUX_PD(1'b1),
    .RX_CM_SEL(2'b11),
    .RX_CM_TRIM(3'b010),
    .RX_DATA_WIDTH(20),
    .RX_DDI_SEL(6'b000000),
    .RX_DEBUG_CFG(12'b000000000000),
    .RX_DEFER_RESET_BUF_EN("TRUE"),
    .RX_DFE_GAIN_CFG(23'h020FEA),
    .RX_DFE_H2_CFG(12'b000000000000),
    .RX_DFE_H3_CFG(12'b000001000000),
    .RX_DFE_H4_CFG(11'b00011110000),
    .RX_DFE_H5_CFG(11'b00011100000),
    .RX_DFE_KL_CFG(13'b0000011111110),
    .RX_DFE_KL_CFG2(32'h301148AC),
    .RX_DFE_LPM_CFG(16'h0904),
    .RX_DFE_LPM_HOLD_DURING_EIDLE(1'b0),
    .RX_DFE_UT_CFG(17'b10001111000000000),
    .RX_DFE_VP_CFG(17'b00011111100000011),
    .RX_DFE_XYD_CFG(13'b0000000000000),
    .RX_DISPERR_SEQ_MATCH("TRUE"),
    .RX_INT_DATAWIDTH(0),
    .RX_OS_CFG(13'b0000010000000),
    .RX_SIG_VALID_DLY(10),
    .RX_XCLK_SEL("RXREC"),
    .SAS_MAX_COM(64),
    .SAS_MIN_COM(36),
    .SATA_BURST_SEQ_LEN(4'b0101),
    .SATA_BURST_VAL(3'b100),
    .SATA_CPLL_CFG("VCO_3000MHZ"),
    .SATA_EIDLE_VAL(3'b100),
    .SATA_MAX_BURST(8),
    .SATA_MAX_INIT(21),
    .SATA_MAX_WAKE(7),
    .SATA_MIN_BURST(4),
    .SATA_MIN_INIT(12),
    .SATA_MIN_WAKE(4),
    .SHOW_REALIGN_COMMA("TRUE"),
    .SIM_CPLLREFCLK_SEL(3'b001),
    .SIM_RECEIVER_DETECT_PASS("TRUE"),
    .SIM_RESET_SPEEDUP("TRUE"),
    .SIM_TX_EIDLE_DRIVE_LEVEL("X"),
    .SIM_VERSION("4.0"),
    .TERM_RCAL_CFG(5'b10000),
    .TERM_RCAL_OVRD(1'b0),
    .TRANS_TIME_RATE(8'h0E),
    .TST_RSV(32'h00000000),
    .TXBUF_EN("FALSE"),
    .TXBUF_RESET_ON_RATE_CHANGE("TRUE"),
    .TXDLY_CFG(16'h001F),
    .TXDLY_LCFG(9'h030),
    .TXDLY_TAP_CFG(16'h0000),
    .TXGEARBOX_EN("FALSE"),
    .TXOUT_DIV(2),
    .TXPCSRESET_TIME(5'b00001),
    .TXPHDLY_CFG(24'h084020),
    .TXPH_CFG(16'h0780),
    .TXPH_MONITOR_SEL(5'b00000),
    .TXPMARESET_TIME(5'b00001),
    .TX_CLK25_DIV(7),
    .TX_CLKMUX_PD(1'b1),
    .TX_DATA_WIDTH(20),
    .TX_DEEMPH0(5'b00000),
    .TX_DEEMPH1(5'b00000),
    .TX_DRIVE_MODE("DIRECT"),
    .TX_EIDLE_ASSERT_DELAY(3'b110),
    .TX_EIDLE_DEASSERT_DELAY(3'b100),
    .TX_INT_DATAWIDTH(0),
    .TX_LOOPBACK_DRIVE_HIZ("FALSE"),
    .TX_MAINCURSOR_SEL(1'b0),
    .TX_MARGIN_FULL_0(7'b1001110),
    .TX_MARGIN_FULL_1(7'b1001001),
    .TX_MARGIN_FULL_2(7'b1000101),
    .TX_MARGIN_FULL_3(7'b1000010),
    .TX_MARGIN_FULL_4(7'b1000000),
    .TX_MARGIN_LOW_0(7'b1000110),
    .TX_MARGIN_LOW_1(7'b1000100),
    .TX_MARGIN_LOW_2(7'b1000010),
    .TX_MARGIN_LOW_3(7'b1000000),
    .TX_MARGIN_LOW_4(7'b1000000),
    .TX_PREDRIVER_MODE(1'b0),
    .TX_QPI_STATUS_EN(1'b0),
    .TX_RXDETECT_CFG(14'h1832),
    .TX_RXDETECT_REF(3'b100),
    .TX_XCLK_SEL("TXUSR"),
    .UCODEER_CLR(1'b0)) 
    gtxe2_i
       (.CFGRESET(1'b0),
        .CLKRSVD({1'b0,1'b0,1'b0,1'b0}),
        .CPLLFBCLKLOST(NLW_gtxe2_i_CPLLFBCLKLOST_UNCONNECTED),
        .CPLLLOCK(NLW_gtxe2_i_CPLLLOCK_UNCONNECTED),
        .CPLLLOCKDETCLK(1'b0),
        .CPLLLOCKEN(1'b1),
        .CPLLPD(1'b1),
        .CPLLREFCLKLOST(NLW_gtxe2_i_CPLLREFCLKLOST_UNCONNECTED),
        .CPLLREFCLKSEL({1'b0,1'b0,1'b1}),
        .CPLLRESET(1'b0),
        .DMONITOROUT(gt0_dmonitorout_out),
        .DRPADDR(gt0_drpaddr),
        .DRPCLK(dclk),
        .DRPDI(gt0_drpdi),
        .DRPDO(gt0_drpdo),
        .DRPEN(gt0_drpen),
        .DRPRDY(gt0_drprdy),
        .DRPWE(gt0_drpwe),
        .EYESCANDATAERROR(gt0_eyescandataerror_out),
        .EYESCANMODE(1'b0),
        .EYESCANRESET(gt0_eyescanreset_in),
        .EYESCANTRIGGER(gt0_eyescantrigger_in),
        .GTGREFCLK(1'b0),
        .GTNORTHREFCLK0(1'b0),
        .GTNORTHREFCLK1(1'b0),
        .GTREFCLK0(1'b0),
        .GTREFCLK1(1'b0),
        .GTREFCLKMONITOR(NLW_gtxe2_i_GTREFCLKMONITOR_UNCONNECTED),
        .GTRESETSEL(1'b0),
        .GTRSVD({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .GTRXRESET(gt3_gtrxreset_in),
        .GTSOUTHREFCLK0(1'b0),
        .GTSOUTHREFCLK1(1'b0),
        .GTTXRESET(uclk_mgt_tx_reset),
        .GTXRXN(xaui_rx_l0_n),
        .GTXRXP(xaui_rx_l0_p),
        .GTXTXN(xaui_tx_l0_n),
        .GTXTXP(xaui_tx_l0_p),
        .LOOPBACK({gt0_loopback_in[2],gt0_loopback_in3_out,gt0_loopback_in[0]}),
        .PCSRSVDIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCSRSVDIN2({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCSRSVDOUT(NLW_gtxe2_i_PCSRSVDOUT_UNCONNECTED[15:0]),
        .PHYSTATUS(NLW_gtxe2_i_PHYSTATUS_UNCONNECTED),
        .PMARSVDIN({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PMARSVDIN2({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .QPLLCLK(gt0_qpllclk_i),
        .QPLLREFCLK(gt0_qpllrefclk_i),
        .RESETOVRD(1'b0),
        .RX8B10BEN(1'b1),
        .RXBUFRESET(Q),
        .RXBUFSTATUS(\uclk_mgt_rxbufstatus_reg_reg[2] ),
        .RXBYTEISALIGNED(gtxe2_i_n_9),
        .RXBYTEREALIGN(gtxe2_i_n_10),
        .RXCDRFREQRESET(1'b0),
        .RXCDRHOLD(gt0_rxcdrhold_in),
        .RXCDRLOCK(NLW_gtxe2_i_RXCDRLOCK_UNCONNECTED),
        .RXCDROVRDEN(1'b0),
        .RXCDRRESET(1'b0),
        .RXCDRRESETRSV(1'b0),
        .RXCHANBONDSEQ(gtxe2_i_n_12),
        .RXCHANISALIGNED(gtxe2_i_n_13),
        .RXCHANREALIGN(gtxe2_i_n_14),
        .RXCHARISCOMMA({NLW_gtxe2_i_RXCHARISCOMMA_UNCONNECTED[7:2],\mgt_codecomma_reg_reg[1] }),
        .RXCHARISK({NLW_gtxe2_i_RXCHARISK_UNCONNECTED[7:2],\mgt_rxcharisk_reg_reg[1] }),
        .RXCHBONDEN(gt3_rxchbonden_in),
        .RXCHBONDI(RXCHBONDO),
        .RXCHBONDLEVEL({1'b0,1'b0,1'b0}),
        .RXCHBONDMASTER(1'b0),
        .RXCHBONDO({gtxe2_i_n_91,gtxe2_i_n_92,gtxe2_i_n_93,gtxe2_i_n_94,gtxe2_i_n_95}),
        .RXCHBONDSLAVE(1'b1),
        .RXCLKCORCNT({gtxe2_i_n_78,gtxe2_i_n_79}),
        .RXCOMINITDET(NLW_gtxe2_i_RXCOMINITDET_UNCONNECTED),
        .RXCOMMADET(gt0_rxcommadet_out),
        .RXCOMMADETEN(1'b1),
        .RXCOMSASDET(NLW_gtxe2_i_RXCOMSASDET_UNCONNECTED),
        .RXCOMWAKEDET(NLW_gtxe2_i_RXCOMWAKEDET_UNCONNECTED),
        .RXDATA({NLW_gtxe2_i_RXDATA_UNCONNECTED[63:16],\mgt_rxdata_reg_reg[15] }),
        .RXDATAVALID(NLW_gtxe2_i_RXDATAVALID_UNCONNECTED),
        .RXDDIEN(1'b0),
        .RXDFEAGCHOLD(1'b0),
        .RXDFEAGCOVRDEN(1'b0),
        .RXDFECM1EN(1'b0),
        .RXDFELFHOLD(1'b0),
        .RXDFELFOVRDEN(1'b0),
        .RXDFELPMRESET(gt0_rxdfelpmreset_in),
        .RXDFETAP2HOLD(1'b0),
        .RXDFETAP2OVRDEN(1'b0),
        .RXDFETAP3HOLD(1'b0),
        .RXDFETAP3OVRDEN(1'b0),
        .RXDFETAP4HOLD(1'b0),
        .RXDFETAP4OVRDEN(1'b0),
        .RXDFETAP5HOLD(1'b0),
        .RXDFETAP5OVRDEN(1'b0),
        .RXDFEUTHOLD(1'b0),
        .RXDFEUTOVRDEN(1'b0),
        .RXDFEVPHOLD(1'b0),
        .RXDFEVPOVRDEN(1'b0),
        .RXDFEVSEN(1'b0),
        .RXDFEXYDEN(1'b1),
        .RXDFEXYDHOLD(1'b0),
        .RXDFEXYDOVRDEN(1'b0),
        .RXDISPERR({NLW_gtxe2_i_RXDISPERR_UNCONNECTED[7:2],\mgt_rxdisperr_reg_reg[1] }),
        .RXDLYBYPASS(1'b1),
        .RXDLYEN(1'b0),
        .RXDLYOVRDEN(1'b0),
        .RXDLYSRESET(1'b0),
        .RXDLYSRESETDONE(NLW_gtxe2_i_RXDLYSRESETDONE_UNCONNECTED),
        .RXELECIDLE(NLW_gtxe2_i_RXELECIDLE_UNCONNECTED),
        .RXELECIDLEMODE({1'b1,1'b1}),
        .RXGEARBOXSLIP(1'b0),
        .RXHEADER(NLW_gtxe2_i_RXHEADER_UNCONNECTED[2:0]),
        .RXHEADERVALID(NLW_gtxe2_i_RXHEADERVALID_UNCONNECTED),
        .RXLPMEN(gt0_rxlpmen_in),
        .RXLPMHFHOLD(1'b0),
        .RXLPMHFOVRDEN(1'b0),
        .RXLPMLFHOLD(1'b0),
        .RXLPMLFKLOVRDEN(1'b0),
        .RXMCOMMAALIGNEN(mgt_enable_align),
        .RXMONITOROUT(gt0_rxmonitorout_out),
        .RXMONITORSEL(gt0_rxmonitorsel_in),
        .RXNOTINTABLE({NLW_gtxe2_i_RXNOTINTABLE_UNCONNECTED[7:2],\mgt_rxnotintable_reg_reg[1] }),
        .RXOOBRESET(1'b0),
        .RXOSHOLD(1'b0),
        .RXOSOVRDEN(1'b0),
        .RXOUTCLK(gtxe2_i_n_23),
        .RXOUTCLKFABRIC(NLW_gtxe2_i_RXOUTCLKFABRIC_UNCONNECTED),
        .RXOUTCLKPCS(NLW_gtxe2_i_RXOUTCLKPCS_UNCONNECTED),
        .RXOUTCLKSEL({1'b0,1'b1,1'b0}),
        .RXPCOMMAALIGNEN(mgt_enable_align),
        .RXPCSRESET(gt0_rxpcsreset_in),
        .RXPD({gt3_txelecidle_in,gt3_txelecidle_in}),
        .RXPHALIGN(1'b0),
        .RXPHALIGNDONE(NLW_gtxe2_i_RXPHALIGNDONE_UNCONNECTED),
        .RXPHALIGNEN(1'b0),
        .RXPHDLYPD(1'b0),
        .RXPHDLYRESET(1'b0),
        .RXPHMONITOR(NLW_gtxe2_i_RXPHMONITOR_UNCONNECTED[4:0]),
        .RXPHOVRDEN(1'b0),
        .RXPHSLIPMONITOR(NLW_gtxe2_i_RXPHSLIPMONITOR_UNCONNECTED[4:0]),
        .RXPMARESET(gt0_rxpmareset_in),
        .RXPOLARITY(gt0_rxpolarity_in),
        .RXPRBSCNTRESET(gt0_rxprbscntreset_in),
        .RXPRBSERR(gt0_rxprbserr_out),
        .RXPRBSSEL(gt0_rxprbssel_in),
        .RXQPIEN(1'b0),
        .RXQPISENN(NLW_gtxe2_i_RXQPISENN_UNCONNECTED),
        .RXQPISENP(NLW_gtxe2_i_RXQPISENP_UNCONNECTED),
        .RXRATE(gt0_rxrate_in),
        .RXRATEDONE(gtxe2_i_n_30),
        .RXRESETDONE(gt0_rxresetdone_out),
        .RXSLIDE(1'b0),
        .RXSTARTOFSEQ(NLW_gtxe2_i_RXSTARTOFSEQ_UNCONNECTED),
        .RXSTATUS(NLW_gtxe2_i_RXSTATUS_UNCONNECTED[2:0]),
        .RXSYSCLKSEL({1'b1,1'b1}),
        .RXUSERRDY(gt3_txuserrdy_in),
        .RXUSRCLK(CLK),
        .RXUSRCLK2(CLK),
        .RXVALID(NLW_gtxe2_i_RXVALID_UNCONNECTED),
        .SETERRSTATUS(1'b0),
        .TSTIN({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .TSTOUT(NLW_gtxe2_i_TSTOUT_UNCONNECTED[9:0]),
        .TX8B10BBYPASS({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TX8B10BEN(1'b1),
        .TXBUFDIFFCTRL({1'b1,1'b0,1'b0}),
        .TXBUFSTATUS(NLW_gtxe2_i_TXBUFSTATUS_UNCONNECTED[1:0]),
        .TXCHARDISPMODE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXCHARDISPVAL({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXCHARISK({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,mgt_txcharisk}),
        .TXCOMFINISH(NLW_gtxe2_i_TXCOMFINISH_UNCONNECTED),
        .TXCOMINIT(1'b0),
        .TXCOMSAS(1'b0),
        .TXCOMWAKE(1'b0),
        .TXDATA({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,mgt_txdata}),
        .TXDEEMPH(1'b0),
        .TXDETECTRX(1'b0),
        .TXDIFFCTRL(gt0_txdiffctrl_in),
        .TXDIFFPD(1'b0),
        .TXDLYBYPASS(1'b0),
        .TXDLYEN(gt0_txdlyen_in),
        .TXDLYHOLD(1'b0),
        .TXDLYOVRDEN(1'b0),
        .TXDLYSRESET(gt0_txdlysreset_in),
        .TXDLYSRESETDONE(gt0_txdlysresetdone_out),
        .TXDLYUPDOWN(1'b0),
        .TXELECIDLE(gt3_txelecidle_in),
        .TXGEARBOXREADY(NLW_gtxe2_i_TXGEARBOXREADY_UNCONNECTED),
        .TXHEADER({1'b0,1'b0,1'b0}),
        .TXINHIBIT(gt0_txinhibit_in),
        .TXMAINCURSOR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXMARGIN({1'b0,1'b0,1'b0}),
        .TXOUTCLK(gt0_txoutclk_out),
        .TXOUTCLKFABRIC(gtxe2_i_n_38),
        .TXOUTCLKPCS(gtxe2_i_n_39),
        .TXOUTCLKSEL({1'b0,1'b1,1'b1}),
        .TXPCSRESET(gt0_txpcsreset_in),
        .TXPD({gt3_txelecidle_in,gt3_txelecidle_in}),
        .TXPDELECIDLEMODE(1'b0),
        .TXPHALIGN(gt0_txphalign_in),
        .TXPHALIGNDONE(gt0_txphaligndone_out),
        .TXPHALIGNEN(1'b1),
        .TXPHDLYPD(1'b0),
        .TXPHDLYRESET(1'b0),
        .TXPHDLYTSTCLK(1'b0),
        .TXPHINIT(gt0_txphinit_in),
        .TXPHINITDONE(gt0_txphinitdone_out),
        .TXPHOVRDEN(1'b0),
        .TXPISOPD(1'b0),
        .TXPMARESET(gt0_txpmareset_in),
        .TXPOLARITY(gt0_txpolarity_in),
        .TXPOSTCURSOR(gt0_txpostcursor_in),
        .TXPOSTCURSORINV(1'b0),
        .TXPRBSFORCEERR(gt0_txprbsforceerr_in),
        .TXPRBSSEL(gt0_txprbssel_in),
        .TXPRECURSOR(gt0_txprecursor_in),
        .TXPRECURSORINV(1'b0),
        .TXQPIBIASEN(1'b0),
        .TXQPISENN(NLW_gtxe2_i_TXQPISENN_UNCONNECTED),
        .TXQPISENP(NLW_gtxe2_i_TXQPISENP_UNCONNECTED),
        .TXQPISTRONGPDOWN(1'b0),
        .TXQPIWEAKPUP(1'b0),
        .TXRATE({1'b0,1'b0,1'b0}),
        .TXRATEDONE(NLW_gtxe2_i_TXRATEDONE_UNCONNECTED),
        .TXRESETDONE(D),
        .TXSEQUENCE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXSTARTSEQ(1'b0),
        .TXSWING(1'b0),
        .TXSYSCLKSEL({1'b1,1'b1}),
        .TXUSERRDY(gt3_txuserrdy_in),
        .TXUSRCLK(CLK),
        .TXUSRCLK2(CLK));
  LUT2 #(
    .INIT(4'hE)) 
    gtxe2_i_i_1
       (.I0(uclk_loopback_int),
        .I1(gt0_loopback_in[1]),
        .O(gt0_loopback_in3_out));
endmodule

(* ORIG_REF_NAME = "xaui_gt_wrapper_GT" *) 
module xaui_xaui_gt_wrapper_GT_20
   (gt1_drprdy,
    gt1_eyescandataerror_out,
    xaui_tx_l1_n,
    xaui_tx_l1_p,
    gt1_rxcommadet_out,
    gt1_rxprbserr_out,
    gt1_rxresetdone_out,
    gt1_txdlysresetdone_out,
    gt1_txphaligndone_out,
    gt1_txphinitdone_out,
    D,
    gt1_drpdo,
    \uclk_mgt_rxbufstatus_reg_reg[5] ,
    RXCHBONDO,
    \mgt_rxdata_reg_reg[31] ,
    gt1_rxmonitorout_out,
    gt1_dmonitorout_out,
    \mgt_codecomma_reg_reg[3] ,
    \mgt_rxcharisk_reg_reg[3] ,
    \mgt_rxdisperr_reg_reg[3] ,
    \mgt_rxnotintable_reg_reg[3] ,
    \core_mgt_rx_reset_reg[1] ,
    dclk,
    gt1_drpen,
    gt1_drpwe,
    gt1_eyescanreset_in,
    gt1_eyescantrigger_in,
    gt3_gtrxreset_in,
    uclk_mgt_tx_reset,
    xaui_rx_l1_n,
    xaui_rx_l1_p,
    gt0_qpllclk_i,
    gt0_qpllrefclk_i,
    Q,
    gt1_rxcdrhold_in,
    gt3_rxchbonden_in,
    gt1_rxdfelpmreset_in,
    gt1_rxlpmen_in,
    mgt_enable_align,
    gt1_rxpcsreset_in,
    gt1_rxpmareset_in,
    gt1_rxpolarity_in,
    gt1_rxprbscntreset_in,
    gt3_txuserrdy_in,
    CLK,
    gt1_txdlysreset_in,
    gt3_txelecidle_in,
    gt1_txinhibit_in,
    gt1_txpcsreset_in,
    gt1_txphalign_in,
    gt1_txphinit_in,
    gt1_txpmareset_in,
    gt1_txpolarity_in,
    gt1_txprbsforceerr_in,
    gt1_drpdi,
    gt1_rxmonitorsel_in,
    gt1_loopback_in,
    gt1_rxprbssel_in,
    gt1_rxrate_in,
    gt1_txprbssel_in,
    gt1_txdiffctrl_in,
    uclk_mgt_rx_reset_reg,
    gt1_txpostcursor_in,
    gt1_txprecursor_in,
    mgt_txdata,
    mgt_txcharisk,
    gt1_drpaddr,
    uclk_loopback_int);
  output gt1_drprdy;
  output gt1_eyescandataerror_out;
  output xaui_tx_l1_n;
  output xaui_tx_l1_p;
  output gt1_rxcommadet_out;
  output gt1_rxprbserr_out;
  output gt1_rxresetdone_out;
  output gt1_txdlysresetdone_out;
  output gt1_txphaligndone_out;
  output gt1_txphinitdone_out;
  output [0:0]D;
  output [15:0]gt1_drpdo;
  output [2:0]\uclk_mgt_rxbufstatus_reg_reg[5] ;
  output [4:0]RXCHBONDO;
  output [15:0]\mgt_rxdata_reg_reg[31] ;
  output [6:0]gt1_rxmonitorout_out;
  output [7:0]gt1_dmonitorout_out;
  output [1:0]\mgt_codecomma_reg_reg[3] ;
  output [1:0]\mgt_rxcharisk_reg_reg[3] ;
  output [1:0]\mgt_rxdisperr_reg_reg[3] ;
  output [1:0]\mgt_rxnotintable_reg_reg[3] ;
  output [0:0]\core_mgt_rx_reset_reg[1] ;
  input dclk;
  input gt1_drpen;
  input gt1_drpwe;
  input gt1_eyescanreset_in;
  input gt1_eyescantrigger_in;
  input gt3_gtrxreset_in;
  input uclk_mgt_tx_reset;
  input xaui_rx_l1_n;
  input xaui_rx_l1_p;
  input gt0_qpllclk_i;
  input gt0_qpllrefclk_i;
  input [0:0]Q;
  input gt1_rxcdrhold_in;
  input gt3_rxchbonden_in;
  input gt1_rxdfelpmreset_in;
  input gt1_rxlpmen_in;
  input [0:0]mgt_enable_align;
  input gt1_rxpcsreset_in;
  input gt1_rxpmareset_in;
  input gt1_rxpolarity_in;
  input gt1_rxprbscntreset_in;
  input gt3_txuserrdy_in;
  input CLK;
  input gt1_txdlysreset_in;
  input gt3_txelecidle_in;
  input gt1_txinhibit_in;
  input gt1_txpcsreset_in;
  input gt1_txphalign_in;
  input gt1_txphinit_in;
  input gt1_txpmareset_in;
  input gt1_txpolarity_in;
  input gt1_txprbsforceerr_in;
  input [15:0]gt1_drpdi;
  input [1:0]gt1_rxmonitorsel_in;
  input [2:0]gt1_loopback_in;
  input [2:0]gt1_rxprbssel_in;
  input [2:0]gt1_rxrate_in;
  input [2:0]gt1_txprbssel_in;
  input [3:0]gt1_txdiffctrl_in;
  input [4:0]uclk_mgt_rx_reset_reg;
  input [4:0]gt1_txpostcursor_in;
  input [4:0]gt1_txprecursor_in;
  input [15:0]mgt_txdata;
  input [1:0]mgt_txcharisk;
  input [8:0]gt1_drpaddr;
  input [0:0]uclk_loopback_int;

  wire CLK;
  wire [0:0]D;
  wire [0:0]Q;
  wire [4:0]RXCHBONDO;
  wire [0:0]\core_mgt_rx_reset_reg[1] ;
  wire dclk;
  wire gt0_qpllclk_i;
  wire gt0_qpllrefclk_i;
  wire [7:0]gt1_dmonitorout_out;
  wire [8:0]gt1_drpaddr;
  wire [15:0]gt1_drpdi;
  wire [15:0]gt1_drpdo;
  wire gt1_drpen;
  wire gt1_drprdy;
  wire gt1_drpwe;
  wire gt1_eyescandataerror_out;
  wire gt1_eyescanreset_in;
  wire gt1_eyescantrigger_in;
  wire [2:0]gt1_loopback_in;
  wire [1:1]gt1_loopback_in2_out;
  wire gt1_rxcdrhold_in;
  wire gt1_rxcommadet_out;
  wire gt1_rxdfelpmreset_in;
  wire gt1_rxlpmen_in;
  wire [6:0]gt1_rxmonitorout_out;
  wire [1:0]gt1_rxmonitorsel_in;
  wire gt1_rxpcsreset_in;
  wire gt1_rxpmareset_in;
  wire gt1_rxpolarity_in;
  wire gt1_rxprbscntreset_in;
  wire gt1_rxprbserr_out;
  wire [2:0]gt1_rxprbssel_in;
  wire [2:0]gt1_rxrate_in;
  wire gt1_rxresetdone_out;
  wire [3:0]gt1_txdiffctrl_in;
  wire gt1_txdlysreset_in;
  wire gt1_txdlysresetdone_out;
  wire gt1_txinhibit_in;
  wire gt1_txpcsreset_in;
  wire gt1_txphalign_in;
  wire gt1_txphaligndone_out;
  wire gt1_txphinit_in;
  wire gt1_txphinitdone_out;
  wire gt1_txpmareset_in;
  wire gt1_txpolarity_in;
  wire [4:0]gt1_txpostcursor_in;
  wire gt1_txprbsforceerr_in;
  wire [2:0]gt1_txprbssel_in;
  wire [4:0]gt1_txprecursor_in;
  wire gt3_gtrxreset_in;
  wire gt3_rxchbonden_in;
  wire gt3_txelecidle_in;
  wire gt3_txuserrdy_in;
  wire gtxe2_i_n_10;
  wire gtxe2_i_n_12;
  wire gtxe2_i_n_13;
  wire gtxe2_i_n_14;
  wire gtxe2_i_n_23;
  wire gtxe2_i_n_30;
  wire gtxe2_i_n_37;
  wire gtxe2_i_n_38;
  wire gtxe2_i_n_39;
  wire gtxe2_i_n_78;
  wire gtxe2_i_n_79;
  wire gtxe2_i_n_9;
  wire [1:0]\mgt_codecomma_reg_reg[3] ;
  wire [0:0]mgt_enable_align;
  wire [1:0]\mgt_rxcharisk_reg_reg[3] ;
  wire [15:0]\mgt_rxdata_reg_reg[31] ;
  wire [1:0]\mgt_rxdisperr_reg_reg[3] ;
  wire [1:0]\mgt_rxnotintable_reg_reg[3] ;
  wire [1:0]mgt_txcharisk;
  wire [15:0]mgt_txdata;
  wire [0:0]uclk_loopback_int;
  wire [4:0]uclk_mgt_rx_reset_reg;
  wire [2:0]\uclk_mgt_rxbufstatus_reg_reg[5] ;
  wire uclk_mgt_tx_reset;
  wire xaui_rx_l1_n;
  wire xaui_rx_l1_p;
  wire xaui_tx_l1_n;
  wire xaui_tx_l1_p;
  wire NLW_gtxe2_i_CPLLFBCLKLOST_UNCONNECTED;
  wire NLW_gtxe2_i_CPLLLOCK_UNCONNECTED;
  wire NLW_gtxe2_i_CPLLREFCLKLOST_UNCONNECTED;
  wire NLW_gtxe2_i_GTREFCLKMONITOR_UNCONNECTED;
  wire NLW_gtxe2_i_PHYSTATUS_UNCONNECTED;
  wire NLW_gtxe2_i_RXCDRLOCK_UNCONNECTED;
  wire NLW_gtxe2_i_RXCOMINITDET_UNCONNECTED;
  wire NLW_gtxe2_i_RXCOMSASDET_UNCONNECTED;
  wire NLW_gtxe2_i_RXCOMWAKEDET_UNCONNECTED;
  wire NLW_gtxe2_i_RXDATAVALID_UNCONNECTED;
  wire NLW_gtxe2_i_RXDLYSRESETDONE_UNCONNECTED;
  wire NLW_gtxe2_i_RXELECIDLE_UNCONNECTED;
  wire NLW_gtxe2_i_RXHEADERVALID_UNCONNECTED;
  wire NLW_gtxe2_i_RXOUTCLKFABRIC_UNCONNECTED;
  wire NLW_gtxe2_i_RXOUTCLKPCS_UNCONNECTED;
  wire NLW_gtxe2_i_RXPHALIGNDONE_UNCONNECTED;
  wire NLW_gtxe2_i_RXQPISENN_UNCONNECTED;
  wire NLW_gtxe2_i_RXQPISENP_UNCONNECTED;
  wire NLW_gtxe2_i_RXSTARTOFSEQ_UNCONNECTED;
  wire NLW_gtxe2_i_RXVALID_UNCONNECTED;
  wire NLW_gtxe2_i_TXCOMFINISH_UNCONNECTED;
  wire NLW_gtxe2_i_TXGEARBOXREADY_UNCONNECTED;
  wire NLW_gtxe2_i_TXQPISENN_UNCONNECTED;
  wire NLW_gtxe2_i_TXQPISENP_UNCONNECTED;
  wire NLW_gtxe2_i_TXRATEDONE_UNCONNECTED;
  wire [15:0]NLW_gtxe2_i_PCSRSVDOUT_UNCONNECTED;
  wire [7:2]NLW_gtxe2_i_RXCHARISCOMMA_UNCONNECTED;
  wire [7:2]NLW_gtxe2_i_RXCHARISK_UNCONNECTED;
  wire [63:16]NLW_gtxe2_i_RXDATA_UNCONNECTED;
  wire [7:2]NLW_gtxe2_i_RXDISPERR_UNCONNECTED;
  wire [2:0]NLW_gtxe2_i_RXHEADER_UNCONNECTED;
  wire [7:2]NLW_gtxe2_i_RXNOTINTABLE_UNCONNECTED;
  wire [4:0]NLW_gtxe2_i_RXPHMONITOR_UNCONNECTED;
  wire [4:0]NLW_gtxe2_i_RXPHSLIPMONITOR_UNCONNECTED;
  wire [2:0]NLW_gtxe2_i_RXSTATUS_UNCONNECTED;
  wire [9:0]NLW_gtxe2_i_TSTOUT_UNCONNECTED;
  wire [1:0]NLW_gtxe2_i_TXBUFSTATUS_UNCONNECTED;

  LUT1 #(
    .INIT(2'h1)) 
    \core_mgt_rx_reset[1]_i_1 
       (.I0(gt1_rxresetdone_out),
        .O(\core_mgt_rx_reset_reg[1] ));
  (* box_type = "PRIMITIVE" *) 
  GTXE2_CHANNEL #(
    .ALIGN_COMMA_DOUBLE("FALSE"),
    .ALIGN_COMMA_ENABLE(10'b0001111111),
    .ALIGN_COMMA_WORD(1),
    .ALIGN_MCOMMA_DET("TRUE"),
    .ALIGN_MCOMMA_VALUE(10'b1010000011),
    .ALIGN_PCOMMA_DET("TRUE"),
    .ALIGN_PCOMMA_VALUE(10'b0101111100),
    .CBCC_DATA_SOURCE_SEL("DECODED"),
    .CHAN_BOND_KEEP_ALIGN("FALSE"),
    .CHAN_BOND_MAX_SKEW(7),
    .CHAN_BOND_SEQ_1_1(10'b0101111100),
    .CHAN_BOND_SEQ_1_2(10'b0000000000),
    .CHAN_BOND_SEQ_1_3(10'b0000000000),
    .CHAN_BOND_SEQ_1_4(10'b0000000000),
    .CHAN_BOND_SEQ_1_ENABLE(4'b1111),
    .CHAN_BOND_SEQ_2_1(10'b0100000000),
    .CHAN_BOND_SEQ_2_2(10'b0100000000),
    .CHAN_BOND_SEQ_2_3(10'b0100000000),
    .CHAN_BOND_SEQ_2_4(10'b0100000000),
    .CHAN_BOND_SEQ_2_ENABLE(4'b1111),
    .CHAN_BOND_SEQ_2_USE("FALSE"),
    .CHAN_BOND_SEQ_LEN(1),
    .CLK_CORRECT_USE("TRUE"),
    .CLK_COR_KEEP_IDLE("FALSE"),
    .CLK_COR_MAX_LAT(19),
    .CLK_COR_MIN_LAT(17),
    .CLK_COR_PRECEDENCE("TRUE"),
    .CLK_COR_REPEAT_WAIT(0),
    .CLK_COR_SEQ_1_1(10'b0100011100),
    .CLK_COR_SEQ_1_2(10'b0100000000),
    .CLK_COR_SEQ_1_3(10'b0100000000),
    .CLK_COR_SEQ_1_4(10'b0100000000),
    .CLK_COR_SEQ_1_ENABLE(4'b1111),
    .CLK_COR_SEQ_2_1(10'b0100000000),
    .CLK_COR_SEQ_2_2(10'b0100000000),
    .CLK_COR_SEQ_2_3(10'b0100000000),
    .CLK_COR_SEQ_2_4(10'b0100000000),
    .CLK_COR_SEQ_2_ENABLE(4'b1111),
    .CLK_COR_SEQ_2_USE("FALSE"),
    .CLK_COR_SEQ_LEN(1),
    .CPLL_CFG(24'hBC07DC),
    .CPLL_FBDIV(4),
    .CPLL_FBDIV_45(5),
    .CPLL_INIT_CFG(24'h00001E),
    .CPLL_LOCK_CFG(16'h01E8),
    .CPLL_REFCLK_DIV(1),
    .DEC_MCOMMA_DETECT("TRUE"),
    .DEC_PCOMMA_DETECT("TRUE"),
    .DEC_VALID_COMMA_ONLY("TRUE"),
    .DMONITOR_CFG(24'h000A00),
    .ES_CONTROL(6'b000000),
    .ES_ERRDET_EN("FALSE"),
    .ES_EYE_SCAN_EN("TRUE"),
    .ES_HORZ_OFFSET(12'h000),
    .ES_PMA_CFG(10'b0000000000),
    .ES_PRESCALE(5'b00000),
    .ES_QUALIFIER(80'h00000000000000000000),
    .ES_QUAL_MASK(80'h00000000000000000000),
    .ES_SDATA_MASK(80'h00000000000000000000),
    .ES_VERT_OFFSET(9'b000000000),
    .FTS_DESKEW_SEQ_ENABLE(4'b1111),
    .FTS_LANE_DESKEW_CFG(4'b1111),
    .FTS_LANE_DESKEW_EN("FALSE"),
    .GEARBOX_MODE(3'b000),
    .IS_CPLLLOCKDETCLK_INVERTED(1'b0),
    .IS_DRPCLK_INVERTED(1'b0),
    .IS_GTGREFCLK_INVERTED(1'b0),
    .IS_RXUSRCLK2_INVERTED(1'b0),
    .IS_RXUSRCLK_INVERTED(1'b0),
    .IS_TXPHDLYTSTCLK_INVERTED(1'b0),
    .IS_TXUSRCLK2_INVERTED(1'b0),
    .IS_TXUSRCLK_INVERTED(1'b0),
    .OUTREFCLK_SEL_INV(2'b11),
    .PCS_PCIE_EN("FALSE"),
    .PCS_RSVD_ATTR(48'h000000000002),
    .PD_TRANS_TIME_FROM_P2(12'h03C),
    .PD_TRANS_TIME_NONE_P2(8'h19),
    .PD_TRANS_TIME_TO_P2(8'h64),
    .PMA_RSV(32'h00018480),
    .PMA_RSV2(16'h2050),
    .PMA_RSV3(2'b00),
    .PMA_RSV4(32'h00000000),
    .RXBUFRESET_TIME(5'b00001),
    .RXBUF_ADDR_MODE("FULL"),
    .RXBUF_EIDLE_HI_CNT(4'b1000),
    .RXBUF_EIDLE_LO_CNT(4'b0000),
    .RXBUF_EN("TRUE"),
    .RXBUF_RESET_ON_CB_CHANGE("TRUE"),
    .RXBUF_RESET_ON_COMMAALIGN("FALSE"),
    .RXBUF_RESET_ON_EIDLE("FALSE"),
    .RXBUF_RESET_ON_RATE_CHANGE("TRUE"),
    .RXBUF_THRESH_OVFLW(61),
    .RXBUF_THRESH_OVRD("FALSE"),
    .RXBUF_THRESH_UNDFLW(4),
    .RXCDRFREQRESET_TIME(5'b00001),
    .RXCDRPHRESET_TIME(5'b00001),
    .RXCDR_CFG(72'h03000023FF10200020),
    .RXCDR_FR_RESET_ON_EIDLE(1'b0),
    .RXCDR_HOLD_DURING_EIDLE(1'b0),
    .RXCDR_LOCK_CFG(6'b010101),
    .RXCDR_PH_RESET_ON_EIDLE(1'b0),
    .RXDFELPMRESET_TIME(7'b0001111),
    .RXDLY_CFG(16'h001F),
    .RXDLY_LCFG(9'h030),
    .RXDLY_TAP_CFG(16'h0000),
    .RXGEARBOX_EN("FALSE"),
    .RXISCANRESET_TIME(5'b00001),
    .RXLPM_HF_CFG(14'b00000011110000),
    .RXLPM_LF_CFG(14'b00000011110000),
    .RXOOB_CFG(7'b0000110),
    .RXOUT_DIV(2),
    .RXPCSRESET_TIME(5'b00001),
    .RXPHDLY_CFG(24'h084020),
    .RXPH_CFG(24'h000000),
    .RXPH_MONITOR_SEL(5'b00000),
    .RXPMARESET_TIME(5'b00011),
    .RXPRBS_ERR_LOOPBACK(1'b0),
    .RXSLIDE_AUTO_WAIT(7),
    .RXSLIDE_MODE("OFF"),
    .RX_BIAS_CFG(12'b000000000100),
    .RX_BUFFER_CFG(6'b000000),
    .RX_CLK25_DIV(7),
    .RX_CLKMUX_PD(1'b1),
    .RX_CM_SEL(2'b11),
    .RX_CM_TRIM(3'b010),
    .RX_DATA_WIDTH(20),
    .RX_DDI_SEL(6'b000000),
    .RX_DEBUG_CFG(12'b000000000000),
    .RX_DEFER_RESET_BUF_EN("TRUE"),
    .RX_DFE_GAIN_CFG(23'h020FEA),
    .RX_DFE_H2_CFG(12'b000000000000),
    .RX_DFE_H3_CFG(12'b000001000000),
    .RX_DFE_H4_CFG(11'b00011110000),
    .RX_DFE_H5_CFG(11'b00011100000),
    .RX_DFE_KL_CFG(13'b0000011111110),
    .RX_DFE_KL_CFG2(32'h301148AC),
    .RX_DFE_LPM_CFG(16'h0904),
    .RX_DFE_LPM_HOLD_DURING_EIDLE(1'b0),
    .RX_DFE_UT_CFG(17'b10001111000000000),
    .RX_DFE_VP_CFG(17'b00011111100000011),
    .RX_DFE_XYD_CFG(13'b0000000000000),
    .RX_DISPERR_SEQ_MATCH("TRUE"),
    .RX_INT_DATAWIDTH(0),
    .RX_OS_CFG(13'b0000010000000),
    .RX_SIG_VALID_DLY(10),
    .RX_XCLK_SEL("RXREC"),
    .SAS_MAX_COM(64),
    .SAS_MIN_COM(36),
    .SATA_BURST_SEQ_LEN(4'b0101),
    .SATA_BURST_VAL(3'b100),
    .SATA_CPLL_CFG("VCO_3000MHZ"),
    .SATA_EIDLE_VAL(3'b100),
    .SATA_MAX_BURST(8),
    .SATA_MAX_INIT(21),
    .SATA_MAX_WAKE(7),
    .SATA_MIN_BURST(4),
    .SATA_MIN_INIT(12),
    .SATA_MIN_WAKE(4),
    .SHOW_REALIGN_COMMA("TRUE"),
    .SIM_CPLLREFCLK_SEL(3'b001),
    .SIM_RECEIVER_DETECT_PASS("TRUE"),
    .SIM_RESET_SPEEDUP("TRUE"),
    .SIM_TX_EIDLE_DRIVE_LEVEL("X"),
    .SIM_VERSION("4.0"),
    .TERM_RCAL_CFG(5'b10000),
    .TERM_RCAL_OVRD(1'b0),
    .TRANS_TIME_RATE(8'h0E),
    .TST_RSV(32'h00000000),
    .TXBUF_EN("FALSE"),
    .TXBUF_RESET_ON_RATE_CHANGE("TRUE"),
    .TXDLY_CFG(16'h001F),
    .TXDLY_LCFG(9'h030),
    .TXDLY_TAP_CFG(16'h0000),
    .TXGEARBOX_EN("FALSE"),
    .TXOUT_DIV(2),
    .TXPCSRESET_TIME(5'b00001),
    .TXPHDLY_CFG(24'h084020),
    .TXPH_CFG(16'h0780),
    .TXPH_MONITOR_SEL(5'b00000),
    .TXPMARESET_TIME(5'b00001),
    .TX_CLK25_DIV(7),
    .TX_CLKMUX_PD(1'b1),
    .TX_DATA_WIDTH(20),
    .TX_DEEMPH0(5'b00000),
    .TX_DEEMPH1(5'b00000),
    .TX_DRIVE_MODE("DIRECT"),
    .TX_EIDLE_ASSERT_DELAY(3'b110),
    .TX_EIDLE_DEASSERT_DELAY(3'b100),
    .TX_INT_DATAWIDTH(0),
    .TX_LOOPBACK_DRIVE_HIZ("FALSE"),
    .TX_MAINCURSOR_SEL(1'b0),
    .TX_MARGIN_FULL_0(7'b1001110),
    .TX_MARGIN_FULL_1(7'b1001001),
    .TX_MARGIN_FULL_2(7'b1000101),
    .TX_MARGIN_FULL_3(7'b1000010),
    .TX_MARGIN_FULL_4(7'b1000000),
    .TX_MARGIN_LOW_0(7'b1000110),
    .TX_MARGIN_LOW_1(7'b1000100),
    .TX_MARGIN_LOW_2(7'b1000010),
    .TX_MARGIN_LOW_3(7'b1000000),
    .TX_MARGIN_LOW_4(7'b1000000),
    .TX_PREDRIVER_MODE(1'b0),
    .TX_QPI_STATUS_EN(1'b0),
    .TX_RXDETECT_CFG(14'h1832),
    .TX_RXDETECT_REF(3'b100),
    .TX_XCLK_SEL("TXUSR"),
    .UCODEER_CLR(1'b0)) 
    gtxe2_i
       (.CFGRESET(1'b0),
        .CLKRSVD({1'b0,1'b0,1'b0,1'b0}),
        .CPLLFBCLKLOST(NLW_gtxe2_i_CPLLFBCLKLOST_UNCONNECTED),
        .CPLLLOCK(NLW_gtxe2_i_CPLLLOCK_UNCONNECTED),
        .CPLLLOCKDETCLK(1'b0),
        .CPLLLOCKEN(1'b1),
        .CPLLPD(1'b1),
        .CPLLREFCLKLOST(NLW_gtxe2_i_CPLLREFCLKLOST_UNCONNECTED),
        .CPLLREFCLKSEL({1'b0,1'b0,1'b1}),
        .CPLLRESET(1'b0),
        .DMONITOROUT(gt1_dmonitorout_out),
        .DRPADDR(gt1_drpaddr),
        .DRPCLK(dclk),
        .DRPDI(gt1_drpdi),
        .DRPDO(gt1_drpdo),
        .DRPEN(gt1_drpen),
        .DRPRDY(gt1_drprdy),
        .DRPWE(gt1_drpwe),
        .EYESCANDATAERROR(gt1_eyescandataerror_out),
        .EYESCANMODE(1'b0),
        .EYESCANRESET(gt1_eyescanreset_in),
        .EYESCANTRIGGER(gt1_eyescantrigger_in),
        .GTGREFCLK(1'b0),
        .GTNORTHREFCLK0(1'b0),
        .GTNORTHREFCLK1(1'b0),
        .GTREFCLK0(1'b0),
        .GTREFCLK1(1'b0),
        .GTREFCLKMONITOR(NLW_gtxe2_i_GTREFCLKMONITOR_UNCONNECTED),
        .GTRESETSEL(1'b0),
        .GTRSVD({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .GTRXRESET(gt3_gtrxreset_in),
        .GTSOUTHREFCLK0(1'b0),
        .GTSOUTHREFCLK1(1'b0),
        .GTTXRESET(uclk_mgt_tx_reset),
        .GTXRXN(xaui_rx_l1_n),
        .GTXRXP(xaui_rx_l1_p),
        .GTXTXN(xaui_tx_l1_n),
        .GTXTXP(xaui_tx_l1_p),
        .LOOPBACK({gt1_loopback_in[2],gt1_loopback_in2_out,gt1_loopback_in[0]}),
        .PCSRSVDIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCSRSVDIN2({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCSRSVDOUT(NLW_gtxe2_i_PCSRSVDOUT_UNCONNECTED[15:0]),
        .PHYSTATUS(NLW_gtxe2_i_PHYSTATUS_UNCONNECTED),
        .PMARSVDIN({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PMARSVDIN2({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .QPLLCLK(gt0_qpllclk_i),
        .QPLLREFCLK(gt0_qpllrefclk_i),
        .RESETOVRD(1'b0),
        .RX8B10BEN(1'b1),
        .RXBUFRESET(Q),
        .RXBUFSTATUS(\uclk_mgt_rxbufstatus_reg_reg[5] ),
        .RXBYTEISALIGNED(gtxe2_i_n_9),
        .RXBYTEREALIGN(gtxe2_i_n_10),
        .RXCDRFREQRESET(1'b0),
        .RXCDRHOLD(gt1_rxcdrhold_in),
        .RXCDRLOCK(NLW_gtxe2_i_RXCDRLOCK_UNCONNECTED),
        .RXCDROVRDEN(1'b0),
        .RXCDRRESET(1'b0),
        .RXCDRRESETRSV(1'b0),
        .RXCHANBONDSEQ(gtxe2_i_n_12),
        .RXCHANISALIGNED(gtxe2_i_n_13),
        .RXCHANREALIGN(gtxe2_i_n_14),
        .RXCHARISCOMMA({NLW_gtxe2_i_RXCHARISCOMMA_UNCONNECTED[7:2],\mgt_codecomma_reg_reg[3] }),
        .RXCHARISK({NLW_gtxe2_i_RXCHARISK_UNCONNECTED[7:2],\mgt_rxcharisk_reg_reg[3] }),
        .RXCHBONDEN(gt3_rxchbonden_in),
        .RXCHBONDI(uclk_mgt_rx_reset_reg),
        .RXCHBONDLEVEL({1'b0,1'b0,1'b1}),
        .RXCHBONDMASTER(1'b0),
        .RXCHBONDO(RXCHBONDO),
        .RXCHBONDSLAVE(1'b1),
        .RXCLKCORCNT({gtxe2_i_n_78,gtxe2_i_n_79}),
        .RXCOMINITDET(NLW_gtxe2_i_RXCOMINITDET_UNCONNECTED),
        .RXCOMMADET(gt1_rxcommadet_out),
        .RXCOMMADETEN(1'b1),
        .RXCOMSASDET(NLW_gtxe2_i_RXCOMSASDET_UNCONNECTED),
        .RXCOMWAKEDET(NLW_gtxe2_i_RXCOMWAKEDET_UNCONNECTED),
        .RXDATA({NLW_gtxe2_i_RXDATA_UNCONNECTED[63:16],\mgt_rxdata_reg_reg[31] }),
        .RXDATAVALID(NLW_gtxe2_i_RXDATAVALID_UNCONNECTED),
        .RXDDIEN(1'b0),
        .RXDFEAGCHOLD(1'b0),
        .RXDFEAGCOVRDEN(1'b0),
        .RXDFECM1EN(1'b0),
        .RXDFELFHOLD(1'b0),
        .RXDFELFOVRDEN(1'b0),
        .RXDFELPMRESET(gt1_rxdfelpmreset_in),
        .RXDFETAP2HOLD(1'b0),
        .RXDFETAP2OVRDEN(1'b0),
        .RXDFETAP3HOLD(1'b0),
        .RXDFETAP3OVRDEN(1'b0),
        .RXDFETAP4HOLD(1'b0),
        .RXDFETAP4OVRDEN(1'b0),
        .RXDFETAP5HOLD(1'b0),
        .RXDFETAP5OVRDEN(1'b0),
        .RXDFEUTHOLD(1'b0),
        .RXDFEUTOVRDEN(1'b0),
        .RXDFEVPHOLD(1'b0),
        .RXDFEVPOVRDEN(1'b0),
        .RXDFEVSEN(1'b0),
        .RXDFEXYDEN(1'b1),
        .RXDFEXYDHOLD(1'b0),
        .RXDFEXYDOVRDEN(1'b0),
        .RXDISPERR({NLW_gtxe2_i_RXDISPERR_UNCONNECTED[7:2],\mgt_rxdisperr_reg_reg[3] }),
        .RXDLYBYPASS(1'b1),
        .RXDLYEN(1'b0),
        .RXDLYOVRDEN(1'b0),
        .RXDLYSRESET(1'b0),
        .RXDLYSRESETDONE(NLW_gtxe2_i_RXDLYSRESETDONE_UNCONNECTED),
        .RXELECIDLE(NLW_gtxe2_i_RXELECIDLE_UNCONNECTED),
        .RXELECIDLEMODE({1'b1,1'b1}),
        .RXGEARBOXSLIP(1'b0),
        .RXHEADER(NLW_gtxe2_i_RXHEADER_UNCONNECTED[2:0]),
        .RXHEADERVALID(NLW_gtxe2_i_RXHEADERVALID_UNCONNECTED),
        .RXLPMEN(gt1_rxlpmen_in),
        .RXLPMHFHOLD(1'b0),
        .RXLPMHFOVRDEN(1'b0),
        .RXLPMLFHOLD(1'b0),
        .RXLPMLFKLOVRDEN(1'b0),
        .RXMCOMMAALIGNEN(mgt_enable_align),
        .RXMONITOROUT(gt1_rxmonitorout_out),
        .RXMONITORSEL(gt1_rxmonitorsel_in),
        .RXNOTINTABLE({NLW_gtxe2_i_RXNOTINTABLE_UNCONNECTED[7:2],\mgt_rxnotintable_reg_reg[3] }),
        .RXOOBRESET(1'b0),
        .RXOSHOLD(1'b0),
        .RXOSOVRDEN(1'b0),
        .RXOUTCLK(gtxe2_i_n_23),
        .RXOUTCLKFABRIC(NLW_gtxe2_i_RXOUTCLKFABRIC_UNCONNECTED),
        .RXOUTCLKPCS(NLW_gtxe2_i_RXOUTCLKPCS_UNCONNECTED),
        .RXOUTCLKSEL({1'b0,1'b1,1'b0}),
        .RXPCOMMAALIGNEN(mgt_enable_align),
        .RXPCSRESET(gt1_rxpcsreset_in),
        .RXPD({gt3_txelecidle_in,gt3_txelecidle_in}),
        .RXPHALIGN(1'b0),
        .RXPHALIGNDONE(NLW_gtxe2_i_RXPHALIGNDONE_UNCONNECTED),
        .RXPHALIGNEN(1'b0),
        .RXPHDLYPD(1'b0),
        .RXPHDLYRESET(1'b0),
        .RXPHMONITOR(NLW_gtxe2_i_RXPHMONITOR_UNCONNECTED[4:0]),
        .RXPHOVRDEN(1'b0),
        .RXPHSLIPMONITOR(NLW_gtxe2_i_RXPHSLIPMONITOR_UNCONNECTED[4:0]),
        .RXPMARESET(gt1_rxpmareset_in),
        .RXPOLARITY(gt1_rxpolarity_in),
        .RXPRBSCNTRESET(gt1_rxprbscntreset_in),
        .RXPRBSERR(gt1_rxprbserr_out),
        .RXPRBSSEL(gt1_rxprbssel_in),
        .RXQPIEN(1'b0),
        .RXQPISENN(NLW_gtxe2_i_RXQPISENN_UNCONNECTED),
        .RXQPISENP(NLW_gtxe2_i_RXQPISENP_UNCONNECTED),
        .RXRATE(gt1_rxrate_in),
        .RXRATEDONE(gtxe2_i_n_30),
        .RXRESETDONE(gt1_rxresetdone_out),
        .RXSLIDE(1'b0),
        .RXSTARTOFSEQ(NLW_gtxe2_i_RXSTARTOFSEQ_UNCONNECTED),
        .RXSTATUS(NLW_gtxe2_i_RXSTATUS_UNCONNECTED[2:0]),
        .RXSYSCLKSEL({1'b1,1'b1}),
        .RXUSERRDY(gt3_txuserrdy_in),
        .RXUSRCLK(CLK),
        .RXUSRCLK2(CLK),
        .RXVALID(NLW_gtxe2_i_RXVALID_UNCONNECTED),
        .SETERRSTATUS(1'b0),
        .TSTIN({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .TSTOUT(NLW_gtxe2_i_TSTOUT_UNCONNECTED[9:0]),
        .TX8B10BBYPASS({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TX8B10BEN(1'b1),
        .TXBUFDIFFCTRL({1'b1,1'b0,1'b0}),
        .TXBUFSTATUS(NLW_gtxe2_i_TXBUFSTATUS_UNCONNECTED[1:0]),
        .TXCHARDISPMODE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXCHARDISPVAL({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXCHARISK({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,mgt_txcharisk}),
        .TXCOMFINISH(NLW_gtxe2_i_TXCOMFINISH_UNCONNECTED),
        .TXCOMINIT(1'b0),
        .TXCOMSAS(1'b0),
        .TXCOMWAKE(1'b0),
        .TXDATA({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,mgt_txdata}),
        .TXDEEMPH(1'b0),
        .TXDETECTRX(1'b0),
        .TXDIFFCTRL(gt1_txdiffctrl_in),
        .TXDIFFPD(1'b0),
        .TXDLYBYPASS(1'b0),
        .TXDLYEN(1'b0),
        .TXDLYHOLD(1'b0),
        .TXDLYOVRDEN(1'b0),
        .TXDLYSRESET(gt1_txdlysreset_in),
        .TXDLYSRESETDONE(gt1_txdlysresetdone_out),
        .TXDLYUPDOWN(1'b0),
        .TXELECIDLE(gt3_txelecidle_in),
        .TXGEARBOXREADY(NLW_gtxe2_i_TXGEARBOXREADY_UNCONNECTED),
        .TXHEADER({1'b0,1'b0,1'b0}),
        .TXINHIBIT(gt1_txinhibit_in),
        .TXMAINCURSOR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXMARGIN({1'b0,1'b0,1'b0}),
        .TXOUTCLK(gtxe2_i_n_37),
        .TXOUTCLKFABRIC(gtxe2_i_n_38),
        .TXOUTCLKPCS(gtxe2_i_n_39),
        .TXOUTCLKSEL({1'b0,1'b1,1'b1}),
        .TXPCSRESET(gt1_txpcsreset_in),
        .TXPD({gt3_txelecidle_in,gt3_txelecidle_in}),
        .TXPDELECIDLEMODE(1'b0),
        .TXPHALIGN(gt1_txphalign_in),
        .TXPHALIGNDONE(gt1_txphaligndone_out),
        .TXPHALIGNEN(1'b1),
        .TXPHDLYPD(1'b0),
        .TXPHDLYRESET(1'b0),
        .TXPHDLYTSTCLK(1'b0),
        .TXPHINIT(gt1_txphinit_in),
        .TXPHINITDONE(gt1_txphinitdone_out),
        .TXPHOVRDEN(1'b0),
        .TXPISOPD(1'b0),
        .TXPMARESET(gt1_txpmareset_in),
        .TXPOLARITY(gt1_txpolarity_in),
        .TXPOSTCURSOR(gt1_txpostcursor_in),
        .TXPOSTCURSORINV(1'b0),
        .TXPRBSFORCEERR(gt1_txprbsforceerr_in),
        .TXPRBSSEL(gt1_txprbssel_in),
        .TXPRECURSOR(gt1_txprecursor_in),
        .TXPRECURSORINV(1'b0),
        .TXQPIBIASEN(1'b0),
        .TXQPISENN(NLW_gtxe2_i_TXQPISENN_UNCONNECTED),
        .TXQPISENP(NLW_gtxe2_i_TXQPISENP_UNCONNECTED),
        .TXQPISTRONGPDOWN(1'b0),
        .TXQPIWEAKPUP(1'b0),
        .TXRATE({1'b0,1'b0,1'b0}),
        .TXRATEDONE(NLW_gtxe2_i_TXRATEDONE_UNCONNECTED),
        .TXRESETDONE(D),
        .TXSEQUENCE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXSTARTSEQ(1'b0),
        .TXSWING(1'b0),
        .TXSYSCLKSEL({1'b1,1'b1}),
        .TXUSERRDY(gt3_txuserrdy_in),
        .TXUSRCLK(CLK),
        .TXUSRCLK2(CLK));
  LUT2 #(
    .INIT(4'hE)) 
    gtxe2_i_i_1__0
       (.I0(uclk_loopback_int),
        .I1(gt1_loopback_in[1]),
        .O(gt1_loopback_in2_out));
endmodule

(* ORIG_REF_NAME = "xaui_gt_wrapper_GT" *) 
module xaui_xaui_gt_wrapper_GT_21
   (gt2_drprdy,
    gt2_eyescandataerror_out,
    xaui_tx_l2_n,
    xaui_tx_l2_p,
    gt2_rxcommadet_out,
    gt2_rxprbserr_out,
    gt2_rxresetdone_out,
    gt2_txdlysresetdone_out,
    gt2_txphaligndone_out,
    gt2_txphinitdone_out,
    D,
    gt2_drpdo,
    \uclk_mgt_rxbufstatus_reg_reg[8] ,
    data_sync_reg1,
    \mgt_rxdata_reg_reg[47] ,
    gt2_rxmonitorout_out,
    gt2_dmonitorout_out,
    \mgt_codecomma_reg_reg[5] ,
    \mgt_rxcharisk_reg_reg[5] ,
    \mgt_rxdisperr_reg_reg[5] ,
    \mgt_rxnotintable_reg_reg[5] ,
    \core_mgt_rx_reset_reg[2] ,
    dclk,
    gt2_drpen,
    gt2_drpwe,
    gt2_eyescanreset_in,
    gt2_eyescantrigger_in,
    gt3_gtrxreset_in,
    uclk_mgt_tx_reset,
    xaui_rx_l2_n,
    xaui_rx_l2_p,
    gt0_qpllclk_i,
    gt0_qpllrefclk_i,
    Q,
    gt2_rxcdrhold_in,
    gt3_rxchbonden_in,
    gt2_rxdfelpmreset_in,
    gt2_rxlpmen_in,
    mgt_enable_align,
    gt2_rxpcsreset_in,
    gt2_rxpmareset_in,
    gt2_rxpolarity_in,
    gt2_rxprbscntreset_in,
    gt3_txuserrdy_in,
    CLK,
    gt2_txdlysreset_in,
    gt3_txelecidle_in,
    gt2_txinhibit_in,
    gt2_txpcsreset_in,
    gt2_txphalign_in,
    gt2_txphinit_in,
    gt2_txpmareset_in,
    gt2_txpolarity_in,
    gt2_txprbsforceerr_in,
    gt2_drpdi,
    gt2_rxmonitorsel_in,
    gt2_loopback_in,
    gt2_rxprbssel_in,
    gt2_rxrate_in,
    gt2_txprbssel_in,
    gt2_txdiffctrl_in,
    gt2_txpostcursor_in,
    gt2_txprecursor_in,
    mgt_txdata,
    mgt_txcharisk,
    gt2_drpaddr,
    uclk_loopback_int);
  output gt2_drprdy;
  output gt2_eyescandataerror_out;
  output xaui_tx_l2_n;
  output xaui_tx_l2_p;
  output gt2_rxcommadet_out;
  output gt2_rxprbserr_out;
  output gt2_rxresetdone_out;
  output gt2_txdlysresetdone_out;
  output gt2_txphaligndone_out;
  output gt2_txphinitdone_out;
  output [0:0]D;
  output [15:0]gt2_drpdo;
  output [2:0]\uclk_mgt_rxbufstatus_reg_reg[8] ;
  output [4:0]data_sync_reg1;
  output [15:0]\mgt_rxdata_reg_reg[47] ;
  output [6:0]gt2_rxmonitorout_out;
  output [7:0]gt2_dmonitorout_out;
  output [1:0]\mgt_codecomma_reg_reg[5] ;
  output [1:0]\mgt_rxcharisk_reg_reg[5] ;
  output [1:0]\mgt_rxdisperr_reg_reg[5] ;
  output [1:0]\mgt_rxnotintable_reg_reg[5] ;
  output [0:0]\core_mgt_rx_reset_reg[2] ;
  input dclk;
  input gt2_drpen;
  input gt2_drpwe;
  input gt2_eyescanreset_in;
  input gt2_eyescantrigger_in;
  input gt3_gtrxreset_in;
  input uclk_mgt_tx_reset;
  input xaui_rx_l2_n;
  input xaui_rx_l2_p;
  input gt0_qpllclk_i;
  input gt0_qpllrefclk_i;
  input [0:0]Q;
  input gt2_rxcdrhold_in;
  input gt3_rxchbonden_in;
  input gt2_rxdfelpmreset_in;
  input gt2_rxlpmen_in;
  input [0:0]mgt_enable_align;
  input gt2_rxpcsreset_in;
  input gt2_rxpmareset_in;
  input gt2_rxpolarity_in;
  input gt2_rxprbscntreset_in;
  input gt3_txuserrdy_in;
  input CLK;
  input gt2_txdlysreset_in;
  input gt3_txelecidle_in;
  input gt2_txinhibit_in;
  input gt2_txpcsreset_in;
  input gt2_txphalign_in;
  input gt2_txphinit_in;
  input gt2_txpmareset_in;
  input gt2_txpolarity_in;
  input gt2_txprbsforceerr_in;
  input [15:0]gt2_drpdi;
  input [1:0]gt2_rxmonitorsel_in;
  input [2:0]gt2_loopback_in;
  input [2:0]gt2_rxprbssel_in;
  input [2:0]gt2_rxrate_in;
  input [2:0]gt2_txprbssel_in;
  input [3:0]gt2_txdiffctrl_in;
  input [4:0]gt2_txpostcursor_in;
  input [4:0]gt2_txprecursor_in;
  input [15:0]mgt_txdata;
  input [1:0]mgt_txcharisk;
  input [8:0]gt2_drpaddr;
  input [0:0]uclk_loopback_int;

  wire CLK;
  wire [0:0]D;
  wire [0:0]Q;
  wire [0:0]\core_mgt_rx_reset_reg[2] ;
  wire [4:0]data_sync_reg1;
  wire dclk;
  wire gt0_qpllclk_i;
  wire gt0_qpllrefclk_i;
  wire [7:0]gt2_dmonitorout_out;
  wire [8:0]gt2_drpaddr;
  wire [15:0]gt2_drpdi;
  wire [15:0]gt2_drpdo;
  wire gt2_drpen;
  wire gt2_drprdy;
  wire gt2_drpwe;
  wire gt2_eyescandataerror_out;
  wire gt2_eyescanreset_in;
  wire gt2_eyescantrigger_in;
  wire [2:0]gt2_loopback_in;
  wire [1:1]gt2_loopback_in1_out;
  wire gt2_rxcdrhold_in;
  wire gt2_rxcommadet_out;
  wire gt2_rxdfelpmreset_in;
  wire gt2_rxlpmen_in;
  wire [6:0]gt2_rxmonitorout_out;
  wire [1:0]gt2_rxmonitorsel_in;
  wire gt2_rxpcsreset_in;
  wire gt2_rxpmareset_in;
  wire gt2_rxpolarity_in;
  wire gt2_rxprbscntreset_in;
  wire gt2_rxprbserr_out;
  wire [2:0]gt2_rxprbssel_in;
  wire [2:0]gt2_rxrate_in;
  wire gt2_rxresetdone_out;
  wire [3:0]gt2_txdiffctrl_in;
  wire gt2_txdlysreset_in;
  wire gt2_txdlysresetdone_out;
  wire gt2_txinhibit_in;
  wire gt2_txpcsreset_in;
  wire gt2_txphalign_in;
  wire gt2_txphaligndone_out;
  wire gt2_txphinit_in;
  wire gt2_txphinitdone_out;
  wire gt2_txpmareset_in;
  wire gt2_txpolarity_in;
  wire [4:0]gt2_txpostcursor_in;
  wire gt2_txprbsforceerr_in;
  wire [2:0]gt2_txprbssel_in;
  wire [4:0]gt2_txprecursor_in;
  wire gt3_gtrxreset_in;
  wire gt3_rxchbonden_in;
  wire gt3_txelecidle_in;
  wire gt3_txuserrdy_in;
  wire gtxe2_i_n_10;
  wire gtxe2_i_n_12;
  wire gtxe2_i_n_13;
  wire gtxe2_i_n_14;
  wire gtxe2_i_n_23;
  wire gtxe2_i_n_30;
  wire gtxe2_i_n_37;
  wire gtxe2_i_n_38;
  wire gtxe2_i_n_39;
  wire gtxe2_i_n_78;
  wire gtxe2_i_n_79;
  wire gtxe2_i_n_9;
  wire [1:0]\mgt_codecomma_reg_reg[5] ;
  wire [0:0]mgt_enable_align;
  wire [1:0]\mgt_rxcharisk_reg_reg[5] ;
  wire [15:0]\mgt_rxdata_reg_reg[47] ;
  wire [1:0]\mgt_rxdisperr_reg_reg[5] ;
  wire [1:0]\mgt_rxnotintable_reg_reg[5] ;
  wire [1:0]mgt_txcharisk;
  wire [15:0]mgt_txdata;
  wire [0:0]uclk_loopback_int;
  wire [2:0]\uclk_mgt_rxbufstatus_reg_reg[8] ;
  wire uclk_mgt_tx_reset;
  wire xaui_rx_l2_n;
  wire xaui_rx_l2_p;
  wire xaui_tx_l2_n;
  wire xaui_tx_l2_p;
  wire NLW_gtxe2_i_CPLLFBCLKLOST_UNCONNECTED;
  wire NLW_gtxe2_i_CPLLLOCK_UNCONNECTED;
  wire NLW_gtxe2_i_CPLLREFCLKLOST_UNCONNECTED;
  wire NLW_gtxe2_i_GTREFCLKMONITOR_UNCONNECTED;
  wire NLW_gtxe2_i_PHYSTATUS_UNCONNECTED;
  wire NLW_gtxe2_i_RXCDRLOCK_UNCONNECTED;
  wire NLW_gtxe2_i_RXCOMINITDET_UNCONNECTED;
  wire NLW_gtxe2_i_RXCOMSASDET_UNCONNECTED;
  wire NLW_gtxe2_i_RXCOMWAKEDET_UNCONNECTED;
  wire NLW_gtxe2_i_RXDATAVALID_UNCONNECTED;
  wire NLW_gtxe2_i_RXDLYSRESETDONE_UNCONNECTED;
  wire NLW_gtxe2_i_RXELECIDLE_UNCONNECTED;
  wire NLW_gtxe2_i_RXHEADERVALID_UNCONNECTED;
  wire NLW_gtxe2_i_RXOUTCLKFABRIC_UNCONNECTED;
  wire NLW_gtxe2_i_RXOUTCLKPCS_UNCONNECTED;
  wire NLW_gtxe2_i_RXPHALIGNDONE_UNCONNECTED;
  wire NLW_gtxe2_i_RXQPISENN_UNCONNECTED;
  wire NLW_gtxe2_i_RXQPISENP_UNCONNECTED;
  wire NLW_gtxe2_i_RXSTARTOFSEQ_UNCONNECTED;
  wire NLW_gtxe2_i_RXVALID_UNCONNECTED;
  wire NLW_gtxe2_i_TXCOMFINISH_UNCONNECTED;
  wire NLW_gtxe2_i_TXGEARBOXREADY_UNCONNECTED;
  wire NLW_gtxe2_i_TXQPISENN_UNCONNECTED;
  wire NLW_gtxe2_i_TXQPISENP_UNCONNECTED;
  wire NLW_gtxe2_i_TXRATEDONE_UNCONNECTED;
  wire [15:0]NLW_gtxe2_i_PCSRSVDOUT_UNCONNECTED;
  wire [7:2]NLW_gtxe2_i_RXCHARISCOMMA_UNCONNECTED;
  wire [7:2]NLW_gtxe2_i_RXCHARISK_UNCONNECTED;
  wire [63:16]NLW_gtxe2_i_RXDATA_UNCONNECTED;
  wire [7:2]NLW_gtxe2_i_RXDISPERR_UNCONNECTED;
  wire [2:0]NLW_gtxe2_i_RXHEADER_UNCONNECTED;
  wire [7:2]NLW_gtxe2_i_RXNOTINTABLE_UNCONNECTED;
  wire [4:0]NLW_gtxe2_i_RXPHMONITOR_UNCONNECTED;
  wire [4:0]NLW_gtxe2_i_RXPHSLIPMONITOR_UNCONNECTED;
  wire [2:0]NLW_gtxe2_i_RXSTATUS_UNCONNECTED;
  wire [9:0]NLW_gtxe2_i_TSTOUT_UNCONNECTED;
  wire [1:0]NLW_gtxe2_i_TXBUFSTATUS_UNCONNECTED;

  LUT1 #(
    .INIT(2'h1)) 
    \core_mgt_rx_reset[2]_i_1 
       (.I0(gt2_rxresetdone_out),
        .O(\core_mgt_rx_reset_reg[2] ));
  (* box_type = "PRIMITIVE" *) 
  GTXE2_CHANNEL #(
    .ALIGN_COMMA_DOUBLE("FALSE"),
    .ALIGN_COMMA_ENABLE(10'b0001111111),
    .ALIGN_COMMA_WORD(1),
    .ALIGN_MCOMMA_DET("TRUE"),
    .ALIGN_MCOMMA_VALUE(10'b1010000011),
    .ALIGN_PCOMMA_DET("TRUE"),
    .ALIGN_PCOMMA_VALUE(10'b0101111100),
    .CBCC_DATA_SOURCE_SEL("DECODED"),
    .CHAN_BOND_KEEP_ALIGN("FALSE"),
    .CHAN_BOND_MAX_SKEW(7),
    .CHAN_BOND_SEQ_1_1(10'b0101111100),
    .CHAN_BOND_SEQ_1_2(10'b0000000000),
    .CHAN_BOND_SEQ_1_3(10'b0000000000),
    .CHAN_BOND_SEQ_1_4(10'b0000000000),
    .CHAN_BOND_SEQ_1_ENABLE(4'b1111),
    .CHAN_BOND_SEQ_2_1(10'b0100000000),
    .CHAN_BOND_SEQ_2_2(10'b0100000000),
    .CHAN_BOND_SEQ_2_3(10'b0100000000),
    .CHAN_BOND_SEQ_2_4(10'b0100000000),
    .CHAN_BOND_SEQ_2_ENABLE(4'b1111),
    .CHAN_BOND_SEQ_2_USE("FALSE"),
    .CHAN_BOND_SEQ_LEN(1),
    .CLK_CORRECT_USE("TRUE"),
    .CLK_COR_KEEP_IDLE("FALSE"),
    .CLK_COR_MAX_LAT(19),
    .CLK_COR_MIN_LAT(17),
    .CLK_COR_PRECEDENCE("TRUE"),
    .CLK_COR_REPEAT_WAIT(0),
    .CLK_COR_SEQ_1_1(10'b0100011100),
    .CLK_COR_SEQ_1_2(10'b0100000000),
    .CLK_COR_SEQ_1_3(10'b0100000000),
    .CLK_COR_SEQ_1_4(10'b0100000000),
    .CLK_COR_SEQ_1_ENABLE(4'b1111),
    .CLK_COR_SEQ_2_1(10'b0100000000),
    .CLK_COR_SEQ_2_2(10'b0100000000),
    .CLK_COR_SEQ_2_3(10'b0100000000),
    .CLK_COR_SEQ_2_4(10'b0100000000),
    .CLK_COR_SEQ_2_ENABLE(4'b1111),
    .CLK_COR_SEQ_2_USE("FALSE"),
    .CLK_COR_SEQ_LEN(1),
    .CPLL_CFG(24'hBC07DC),
    .CPLL_FBDIV(4),
    .CPLL_FBDIV_45(5),
    .CPLL_INIT_CFG(24'h00001E),
    .CPLL_LOCK_CFG(16'h01E8),
    .CPLL_REFCLK_DIV(1),
    .DEC_MCOMMA_DETECT("TRUE"),
    .DEC_PCOMMA_DETECT("TRUE"),
    .DEC_VALID_COMMA_ONLY("TRUE"),
    .DMONITOR_CFG(24'h000A00),
    .ES_CONTROL(6'b000000),
    .ES_ERRDET_EN("FALSE"),
    .ES_EYE_SCAN_EN("TRUE"),
    .ES_HORZ_OFFSET(12'h000),
    .ES_PMA_CFG(10'b0000000000),
    .ES_PRESCALE(5'b00000),
    .ES_QUALIFIER(80'h00000000000000000000),
    .ES_QUAL_MASK(80'h00000000000000000000),
    .ES_SDATA_MASK(80'h00000000000000000000),
    .ES_VERT_OFFSET(9'b000000000),
    .FTS_DESKEW_SEQ_ENABLE(4'b1111),
    .FTS_LANE_DESKEW_CFG(4'b1111),
    .FTS_LANE_DESKEW_EN("FALSE"),
    .GEARBOX_MODE(3'b000),
    .IS_CPLLLOCKDETCLK_INVERTED(1'b0),
    .IS_DRPCLK_INVERTED(1'b0),
    .IS_GTGREFCLK_INVERTED(1'b0),
    .IS_RXUSRCLK2_INVERTED(1'b0),
    .IS_RXUSRCLK_INVERTED(1'b0),
    .IS_TXPHDLYTSTCLK_INVERTED(1'b0),
    .IS_TXUSRCLK2_INVERTED(1'b0),
    .IS_TXUSRCLK_INVERTED(1'b0),
    .OUTREFCLK_SEL_INV(2'b11),
    .PCS_PCIE_EN("FALSE"),
    .PCS_RSVD_ATTR(48'h000000000002),
    .PD_TRANS_TIME_FROM_P2(12'h03C),
    .PD_TRANS_TIME_NONE_P2(8'h19),
    .PD_TRANS_TIME_TO_P2(8'h64),
    .PMA_RSV(32'h00018480),
    .PMA_RSV2(16'h2050),
    .PMA_RSV3(2'b00),
    .PMA_RSV4(32'h00000000),
    .RXBUFRESET_TIME(5'b00001),
    .RXBUF_ADDR_MODE("FULL"),
    .RXBUF_EIDLE_HI_CNT(4'b1000),
    .RXBUF_EIDLE_LO_CNT(4'b0000),
    .RXBUF_EN("TRUE"),
    .RXBUF_RESET_ON_CB_CHANGE("TRUE"),
    .RXBUF_RESET_ON_COMMAALIGN("FALSE"),
    .RXBUF_RESET_ON_EIDLE("FALSE"),
    .RXBUF_RESET_ON_RATE_CHANGE("TRUE"),
    .RXBUF_THRESH_OVFLW(61),
    .RXBUF_THRESH_OVRD("FALSE"),
    .RXBUF_THRESH_UNDFLW(4),
    .RXCDRFREQRESET_TIME(5'b00001),
    .RXCDRPHRESET_TIME(5'b00001),
    .RXCDR_CFG(72'h03000023FF10200020),
    .RXCDR_FR_RESET_ON_EIDLE(1'b0),
    .RXCDR_HOLD_DURING_EIDLE(1'b0),
    .RXCDR_LOCK_CFG(6'b010101),
    .RXCDR_PH_RESET_ON_EIDLE(1'b0),
    .RXDFELPMRESET_TIME(7'b0001111),
    .RXDLY_CFG(16'h001F),
    .RXDLY_LCFG(9'h030),
    .RXDLY_TAP_CFG(16'h0000),
    .RXGEARBOX_EN("FALSE"),
    .RXISCANRESET_TIME(5'b00001),
    .RXLPM_HF_CFG(14'b00000011110000),
    .RXLPM_LF_CFG(14'b00000011110000),
    .RXOOB_CFG(7'b0000110),
    .RXOUT_DIV(2),
    .RXPCSRESET_TIME(5'b00001),
    .RXPHDLY_CFG(24'h084020),
    .RXPH_CFG(24'h000000),
    .RXPH_MONITOR_SEL(5'b00000),
    .RXPMARESET_TIME(5'b00011),
    .RXPRBS_ERR_LOOPBACK(1'b0),
    .RXSLIDE_AUTO_WAIT(7),
    .RXSLIDE_MODE("OFF"),
    .RX_BIAS_CFG(12'b000000000100),
    .RX_BUFFER_CFG(6'b000000),
    .RX_CLK25_DIV(7),
    .RX_CLKMUX_PD(1'b1),
    .RX_CM_SEL(2'b11),
    .RX_CM_TRIM(3'b010),
    .RX_DATA_WIDTH(20),
    .RX_DDI_SEL(6'b000000),
    .RX_DEBUG_CFG(12'b000000000000),
    .RX_DEFER_RESET_BUF_EN("TRUE"),
    .RX_DFE_GAIN_CFG(23'h020FEA),
    .RX_DFE_H2_CFG(12'b000000000000),
    .RX_DFE_H3_CFG(12'b000001000000),
    .RX_DFE_H4_CFG(11'b00011110000),
    .RX_DFE_H5_CFG(11'b00011100000),
    .RX_DFE_KL_CFG(13'b0000011111110),
    .RX_DFE_KL_CFG2(32'h301148AC),
    .RX_DFE_LPM_CFG(16'h0904),
    .RX_DFE_LPM_HOLD_DURING_EIDLE(1'b0),
    .RX_DFE_UT_CFG(17'b10001111000000000),
    .RX_DFE_VP_CFG(17'b00011111100000011),
    .RX_DFE_XYD_CFG(13'b0000000000000),
    .RX_DISPERR_SEQ_MATCH("TRUE"),
    .RX_INT_DATAWIDTH(0),
    .RX_OS_CFG(13'b0000010000000),
    .RX_SIG_VALID_DLY(10),
    .RX_XCLK_SEL("RXREC"),
    .SAS_MAX_COM(64),
    .SAS_MIN_COM(36),
    .SATA_BURST_SEQ_LEN(4'b0101),
    .SATA_BURST_VAL(3'b100),
    .SATA_CPLL_CFG("VCO_3000MHZ"),
    .SATA_EIDLE_VAL(3'b100),
    .SATA_MAX_BURST(8),
    .SATA_MAX_INIT(21),
    .SATA_MAX_WAKE(7),
    .SATA_MIN_BURST(4),
    .SATA_MIN_INIT(12),
    .SATA_MIN_WAKE(4),
    .SHOW_REALIGN_COMMA("TRUE"),
    .SIM_CPLLREFCLK_SEL(3'b001),
    .SIM_RECEIVER_DETECT_PASS("TRUE"),
    .SIM_RESET_SPEEDUP("TRUE"),
    .SIM_TX_EIDLE_DRIVE_LEVEL("X"),
    .SIM_VERSION("4.0"),
    .TERM_RCAL_CFG(5'b10000),
    .TERM_RCAL_OVRD(1'b0),
    .TRANS_TIME_RATE(8'h0E),
    .TST_RSV(32'h00000000),
    .TXBUF_EN("FALSE"),
    .TXBUF_RESET_ON_RATE_CHANGE("TRUE"),
    .TXDLY_CFG(16'h001F),
    .TXDLY_LCFG(9'h030),
    .TXDLY_TAP_CFG(16'h0000),
    .TXGEARBOX_EN("FALSE"),
    .TXOUT_DIV(2),
    .TXPCSRESET_TIME(5'b00001),
    .TXPHDLY_CFG(24'h084020),
    .TXPH_CFG(16'h0780),
    .TXPH_MONITOR_SEL(5'b00000),
    .TXPMARESET_TIME(5'b00001),
    .TX_CLK25_DIV(7),
    .TX_CLKMUX_PD(1'b1),
    .TX_DATA_WIDTH(20),
    .TX_DEEMPH0(5'b00000),
    .TX_DEEMPH1(5'b00000),
    .TX_DRIVE_MODE("DIRECT"),
    .TX_EIDLE_ASSERT_DELAY(3'b110),
    .TX_EIDLE_DEASSERT_DELAY(3'b100),
    .TX_INT_DATAWIDTH(0),
    .TX_LOOPBACK_DRIVE_HIZ("FALSE"),
    .TX_MAINCURSOR_SEL(1'b0),
    .TX_MARGIN_FULL_0(7'b1001110),
    .TX_MARGIN_FULL_1(7'b1001001),
    .TX_MARGIN_FULL_2(7'b1000101),
    .TX_MARGIN_FULL_3(7'b1000010),
    .TX_MARGIN_FULL_4(7'b1000000),
    .TX_MARGIN_LOW_0(7'b1000110),
    .TX_MARGIN_LOW_1(7'b1000100),
    .TX_MARGIN_LOW_2(7'b1000010),
    .TX_MARGIN_LOW_3(7'b1000000),
    .TX_MARGIN_LOW_4(7'b1000000),
    .TX_PREDRIVER_MODE(1'b0),
    .TX_QPI_STATUS_EN(1'b0),
    .TX_RXDETECT_CFG(14'h1832),
    .TX_RXDETECT_REF(3'b100),
    .TX_XCLK_SEL("TXUSR"),
    .UCODEER_CLR(1'b0)) 
    gtxe2_i
       (.CFGRESET(1'b0),
        .CLKRSVD({1'b0,1'b0,1'b0,1'b0}),
        .CPLLFBCLKLOST(NLW_gtxe2_i_CPLLFBCLKLOST_UNCONNECTED),
        .CPLLLOCK(NLW_gtxe2_i_CPLLLOCK_UNCONNECTED),
        .CPLLLOCKDETCLK(1'b0),
        .CPLLLOCKEN(1'b1),
        .CPLLPD(1'b1),
        .CPLLREFCLKLOST(NLW_gtxe2_i_CPLLREFCLKLOST_UNCONNECTED),
        .CPLLREFCLKSEL({1'b0,1'b0,1'b1}),
        .CPLLRESET(1'b0),
        .DMONITOROUT(gt2_dmonitorout_out),
        .DRPADDR(gt2_drpaddr),
        .DRPCLK(dclk),
        .DRPDI(gt2_drpdi),
        .DRPDO(gt2_drpdo),
        .DRPEN(gt2_drpen),
        .DRPRDY(gt2_drprdy),
        .DRPWE(gt2_drpwe),
        .EYESCANDATAERROR(gt2_eyescandataerror_out),
        .EYESCANMODE(1'b0),
        .EYESCANRESET(gt2_eyescanreset_in),
        .EYESCANTRIGGER(gt2_eyescantrigger_in),
        .GTGREFCLK(1'b0),
        .GTNORTHREFCLK0(1'b0),
        .GTNORTHREFCLK1(1'b0),
        .GTREFCLK0(1'b0),
        .GTREFCLK1(1'b0),
        .GTREFCLKMONITOR(NLW_gtxe2_i_GTREFCLKMONITOR_UNCONNECTED),
        .GTRESETSEL(1'b0),
        .GTRSVD({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .GTRXRESET(gt3_gtrxreset_in),
        .GTSOUTHREFCLK0(1'b0),
        .GTSOUTHREFCLK1(1'b0),
        .GTTXRESET(uclk_mgt_tx_reset),
        .GTXRXN(xaui_rx_l2_n),
        .GTXRXP(xaui_rx_l2_p),
        .GTXTXN(xaui_tx_l2_n),
        .GTXTXP(xaui_tx_l2_p),
        .LOOPBACK({gt2_loopback_in[2],gt2_loopback_in1_out,gt2_loopback_in[0]}),
        .PCSRSVDIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCSRSVDIN2({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCSRSVDOUT(NLW_gtxe2_i_PCSRSVDOUT_UNCONNECTED[15:0]),
        .PHYSTATUS(NLW_gtxe2_i_PHYSTATUS_UNCONNECTED),
        .PMARSVDIN({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PMARSVDIN2({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .QPLLCLK(gt0_qpllclk_i),
        .QPLLREFCLK(gt0_qpllrefclk_i),
        .RESETOVRD(1'b0),
        .RX8B10BEN(1'b1),
        .RXBUFRESET(Q),
        .RXBUFSTATUS(\uclk_mgt_rxbufstatus_reg_reg[8] ),
        .RXBYTEISALIGNED(gtxe2_i_n_9),
        .RXBYTEREALIGN(gtxe2_i_n_10),
        .RXCDRFREQRESET(1'b0),
        .RXCDRHOLD(gt2_rxcdrhold_in),
        .RXCDRLOCK(NLW_gtxe2_i_RXCDRLOCK_UNCONNECTED),
        .RXCDROVRDEN(1'b0),
        .RXCDRRESET(1'b0),
        .RXCDRRESETRSV(1'b0),
        .RXCHANBONDSEQ(gtxe2_i_n_12),
        .RXCHANISALIGNED(gtxe2_i_n_13),
        .RXCHANREALIGN(gtxe2_i_n_14),
        .RXCHARISCOMMA({NLW_gtxe2_i_RXCHARISCOMMA_UNCONNECTED[7:2],\mgt_codecomma_reg_reg[5] }),
        .RXCHARISK({NLW_gtxe2_i_RXCHARISK_UNCONNECTED[7:2],\mgt_rxcharisk_reg_reg[5] }),
        .RXCHBONDEN(gt3_rxchbonden_in),
        .RXCHBONDI({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .RXCHBONDLEVEL({1'b0,1'b1,1'b0}),
        .RXCHBONDMASTER(1'b1),
        .RXCHBONDO(data_sync_reg1),
        .RXCHBONDSLAVE(1'b0),
        .RXCLKCORCNT({gtxe2_i_n_78,gtxe2_i_n_79}),
        .RXCOMINITDET(NLW_gtxe2_i_RXCOMINITDET_UNCONNECTED),
        .RXCOMMADET(gt2_rxcommadet_out),
        .RXCOMMADETEN(1'b1),
        .RXCOMSASDET(NLW_gtxe2_i_RXCOMSASDET_UNCONNECTED),
        .RXCOMWAKEDET(NLW_gtxe2_i_RXCOMWAKEDET_UNCONNECTED),
        .RXDATA({NLW_gtxe2_i_RXDATA_UNCONNECTED[63:16],\mgt_rxdata_reg_reg[47] }),
        .RXDATAVALID(NLW_gtxe2_i_RXDATAVALID_UNCONNECTED),
        .RXDDIEN(1'b0),
        .RXDFEAGCHOLD(1'b0),
        .RXDFEAGCOVRDEN(1'b0),
        .RXDFECM1EN(1'b0),
        .RXDFELFHOLD(1'b0),
        .RXDFELFOVRDEN(1'b0),
        .RXDFELPMRESET(gt2_rxdfelpmreset_in),
        .RXDFETAP2HOLD(1'b0),
        .RXDFETAP2OVRDEN(1'b0),
        .RXDFETAP3HOLD(1'b0),
        .RXDFETAP3OVRDEN(1'b0),
        .RXDFETAP4HOLD(1'b0),
        .RXDFETAP4OVRDEN(1'b0),
        .RXDFETAP5HOLD(1'b0),
        .RXDFETAP5OVRDEN(1'b0),
        .RXDFEUTHOLD(1'b0),
        .RXDFEUTOVRDEN(1'b0),
        .RXDFEVPHOLD(1'b0),
        .RXDFEVPOVRDEN(1'b0),
        .RXDFEVSEN(1'b0),
        .RXDFEXYDEN(1'b1),
        .RXDFEXYDHOLD(1'b0),
        .RXDFEXYDOVRDEN(1'b0),
        .RXDISPERR({NLW_gtxe2_i_RXDISPERR_UNCONNECTED[7:2],\mgt_rxdisperr_reg_reg[5] }),
        .RXDLYBYPASS(1'b1),
        .RXDLYEN(1'b0),
        .RXDLYOVRDEN(1'b0),
        .RXDLYSRESET(1'b0),
        .RXDLYSRESETDONE(NLW_gtxe2_i_RXDLYSRESETDONE_UNCONNECTED),
        .RXELECIDLE(NLW_gtxe2_i_RXELECIDLE_UNCONNECTED),
        .RXELECIDLEMODE({1'b1,1'b1}),
        .RXGEARBOXSLIP(1'b0),
        .RXHEADER(NLW_gtxe2_i_RXHEADER_UNCONNECTED[2:0]),
        .RXHEADERVALID(NLW_gtxe2_i_RXHEADERVALID_UNCONNECTED),
        .RXLPMEN(gt2_rxlpmen_in),
        .RXLPMHFHOLD(1'b0),
        .RXLPMHFOVRDEN(1'b0),
        .RXLPMLFHOLD(1'b0),
        .RXLPMLFKLOVRDEN(1'b0),
        .RXMCOMMAALIGNEN(mgt_enable_align),
        .RXMONITOROUT(gt2_rxmonitorout_out),
        .RXMONITORSEL(gt2_rxmonitorsel_in),
        .RXNOTINTABLE({NLW_gtxe2_i_RXNOTINTABLE_UNCONNECTED[7:2],\mgt_rxnotintable_reg_reg[5] }),
        .RXOOBRESET(1'b0),
        .RXOSHOLD(1'b0),
        .RXOSOVRDEN(1'b0),
        .RXOUTCLK(gtxe2_i_n_23),
        .RXOUTCLKFABRIC(NLW_gtxe2_i_RXOUTCLKFABRIC_UNCONNECTED),
        .RXOUTCLKPCS(NLW_gtxe2_i_RXOUTCLKPCS_UNCONNECTED),
        .RXOUTCLKSEL({1'b0,1'b1,1'b0}),
        .RXPCOMMAALIGNEN(mgt_enable_align),
        .RXPCSRESET(gt2_rxpcsreset_in),
        .RXPD({gt3_txelecidle_in,gt3_txelecidle_in}),
        .RXPHALIGN(1'b0),
        .RXPHALIGNDONE(NLW_gtxe2_i_RXPHALIGNDONE_UNCONNECTED),
        .RXPHALIGNEN(1'b0),
        .RXPHDLYPD(1'b0),
        .RXPHDLYRESET(1'b0),
        .RXPHMONITOR(NLW_gtxe2_i_RXPHMONITOR_UNCONNECTED[4:0]),
        .RXPHOVRDEN(1'b0),
        .RXPHSLIPMONITOR(NLW_gtxe2_i_RXPHSLIPMONITOR_UNCONNECTED[4:0]),
        .RXPMARESET(gt2_rxpmareset_in),
        .RXPOLARITY(gt2_rxpolarity_in),
        .RXPRBSCNTRESET(gt2_rxprbscntreset_in),
        .RXPRBSERR(gt2_rxprbserr_out),
        .RXPRBSSEL(gt2_rxprbssel_in),
        .RXQPIEN(1'b0),
        .RXQPISENN(NLW_gtxe2_i_RXQPISENN_UNCONNECTED),
        .RXQPISENP(NLW_gtxe2_i_RXQPISENP_UNCONNECTED),
        .RXRATE(gt2_rxrate_in),
        .RXRATEDONE(gtxe2_i_n_30),
        .RXRESETDONE(gt2_rxresetdone_out),
        .RXSLIDE(1'b0),
        .RXSTARTOFSEQ(NLW_gtxe2_i_RXSTARTOFSEQ_UNCONNECTED),
        .RXSTATUS(NLW_gtxe2_i_RXSTATUS_UNCONNECTED[2:0]),
        .RXSYSCLKSEL({1'b1,1'b1}),
        .RXUSERRDY(gt3_txuserrdy_in),
        .RXUSRCLK(CLK),
        .RXUSRCLK2(CLK),
        .RXVALID(NLW_gtxe2_i_RXVALID_UNCONNECTED),
        .SETERRSTATUS(1'b0),
        .TSTIN({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .TSTOUT(NLW_gtxe2_i_TSTOUT_UNCONNECTED[9:0]),
        .TX8B10BBYPASS({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TX8B10BEN(1'b1),
        .TXBUFDIFFCTRL({1'b1,1'b0,1'b0}),
        .TXBUFSTATUS(NLW_gtxe2_i_TXBUFSTATUS_UNCONNECTED[1:0]),
        .TXCHARDISPMODE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXCHARDISPVAL({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXCHARISK({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,mgt_txcharisk}),
        .TXCOMFINISH(NLW_gtxe2_i_TXCOMFINISH_UNCONNECTED),
        .TXCOMINIT(1'b0),
        .TXCOMSAS(1'b0),
        .TXCOMWAKE(1'b0),
        .TXDATA({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,mgt_txdata}),
        .TXDEEMPH(1'b0),
        .TXDETECTRX(1'b0),
        .TXDIFFCTRL(gt2_txdiffctrl_in),
        .TXDIFFPD(1'b0),
        .TXDLYBYPASS(1'b0),
        .TXDLYEN(1'b0),
        .TXDLYHOLD(1'b0),
        .TXDLYOVRDEN(1'b0),
        .TXDLYSRESET(gt2_txdlysreset_in),
        .TXDLYSRESETDONE(gt2_txdlysresetdone_out),
        .TXDLYUPDOWN(1'b0),
        .TXELECIDLE(gt3_txelecidle_in),
        .TXGEARBOXREADY(NLW_gtxe2_i_TXGEARBOXREADY_UNCONNECTED),
        .TXHEADER({1'b0,1'b0,1'b0}),
        .TXINHIBIT(gt2_txinhibit_in),
        .TXMAINCURSOR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXMARGIN({1'b0,1'b0,1'b0}),
        .TXOUTCLK(gtxe2_i_n_37),
        .TXOUTCLKFABRIC(gtxe2_i_n_38),
        .TXOUTCLKPCS(gtxe2_i_n_39),
        .TXOUTCLKSEL({1'b0,1'b1,1'b1}),
        .TXPCSRESET(gt2_txpcsreset_in),
        .TXPD({gt3_txelecidle_in,gt3_txelecidle_in}),
        .TXPDELECIDLEMODE(1'b0),
        .TXPHALIGN(gt2_txphalign_in),
        .TXPHALIGNDONE(gt2_txphaligndone_out),
        .TXPHALIGNEN(1'b1),
        .TXPHDLYPD(1'b0),
        .TXPHDLYRESET(1'b0),
        .TXPHDLYTSTCLK(1'b0),
        .TXPHINIT(gt2_txphinit_in),
        .TXPHINITDONE(gt2_txphinitdone_out),
        .TXPHOVRDEN(1'b0),
        .TXPISOPD(1'b0),
        .TXPMARESET(gt2_txpmareset_in),
        .TXPOLARITY(gt2_txpolarity_in),
        .TXPOSTCURSOR(gt2_txpostcursor_in),
        .TXPOSTCURSORINV(1'b0),
        .TXPRBSFORCEERR(gt2_txprbsforceerr_in),
        .TXPRBSSEL(gt2_txprbssel_in),
        .TXPRECURSOR(gt2_txprecursor_in),
        .TXPRECURSORINV(1'b0),
        .TXQPIBIASEN(1'b0),
        .TXQPISENN(NLW_gtxe2_i_TXQPISENN_UNCONNECTED),
        .TXQPISENP(NLW_gtxe2_i_TXQPISENP_UNCONNECTED),
        .TXQPISTRONGPDOWN(1'b0),
        .TXQPIWEAKPUP(1'b0),
        .TXRATE({1'b0,1'b0,1'b0}),
        .TXRATEDONE(NLW_gtxe2_i_TXRATEDONE_UNCONNECTED),
        .TXRESETDONE(D),
        .TXSEQUENCE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXSTARTSEQ(1'b0),
        .TXSWING(1'b0),
        .TXSYSCLKSEL({1'b1,1'b1}),
        .TXUSERRDY(gt3_txuserrdy_in),
        .TXUSRCLK(CLK),
        .TXUSRCLK2(CLK));
  LUT2 #(
    .INIT(4'hE)) 
    gtxe2_i_i_1__1
       (.I0(uclk_loopback_int),
        .I1(gt2_loopback_in[1]),
        .O(gt2_loopback_in1_out));
endmodule

(* ORIG_REF_NAME = "xaui_gt_wrapper_GT" *) 
module xaui_xaui_gt_wrapper_GT_22
   (gt3_drprdy,
    gt3_eyescandataerror_out,
    xaui_tx_l3_n,
    xaui_tx_l3_p,
    gt3_rxcommadet_out,
    gt3_rxprbserr_out,
    gt3_rxresetdone_out,
    gt3_txdlysresetdone_out,
    gt3_txphaligndone_out,
    gt3_txphinitdone_out,
    D,
    gt3_drpdo,
    \uclk_mgt_rxbufstatus_reg_reg[11] ,
    \mgt_rxdata_reg_reg[63] ,
    gt3_rxmonitorout_out,
    gt3_dmonitorout_out,
    \mgt_codecomma_reg_reg[7] ,
    \mgt_rxcharisk_reg_reg[7] ,
    \mgt_rxdisperr_reg_reg[7] ,
    \mgt_rxnotintable_reg_reg[7] ,
    \core_mgt_rx_reset_reg[3] ,
    dclk,
    gt3_drpen,
    gt3_drpwe,
    gt3_eyescanreset_in,
    gt3_eyescantrigger_in,
    gt3_gtrxreset_in,
    uclk_mgt_tx_reset,
    xaui_rx_l3_n,
    xaui_rx_l3_p,
    gt0_qpllclk_i,
    gt0_qpllrefclk_i,
    Q,
    gt3_rxcdrhold_in,
    gt3_rxchbonden_in,
    gt3_rxdfelpmreset_in,
    gt3_rxlpmen_in,
    mgt_enable_align,
    gt3_rxpcsreset_in,
    gt3_rxpmareset_in,
    gt3_rxpolarity_in,
    gt3_rxprbscntreset_in,
    gt3_txuserrdy_in,
    CLK,
    gt3_txdlysreset_in,
    gt3_txelecidle_in,
    gt3_txinhibit_in,
    gt3_txpcsreset_in,
    gt3_txphalign_in,
    gt3_txphinit_in,
    gt3_txpmareset_in,
    gt3_txpolarity_in,
    gt3_txprbsforceerr_in,
    gt3_drpdi,
    gt3_rxmonitorsel_in,
    gt3_loopback_in,
    gt3_rxprbssel_in,
    gt3_rxrate_in,
    gt3_txprbssel_in,
    gt3_txdiffctrl_in,
    uclk_mgt_rx_reset_reg,
    gt3_txpostcursor_in,
    gt3_txprecursor_in,
    mgt_txdata,
    mgt_txcharisk,
    gt3_drpaddr,
    uclk_loopback_int);
  output gt3_drprdy;
  output gt3_eyescandataerror_out;
  output xaui_tx_l3_n;
  output xaui_tx_l3_p;
  output gt3_rxcommadet_out;
  output gt3_rxprbserr_out;
  output gt3_rxresetdone_out;
  output gt3_txdlysresetdone_out;
  output gt3_txphaligndone_out;
  output gt3_txphinitdone_out;
  output [0:0]D;
  output [15:0]gt3_drpdo;
  output [2:0]\uclk_mgt_rxbufstatus_reg_reg[11] ;
  output [15:0]\mgt_rxdata_reg_reg[63] ;
  output [6:0]gt3_rxmonitorout_out;
  output [7:0]gt3_dmonitorout_out;
  output [1:0]\mgt_codecomma_reg_reg[7] ;
  output [1:0]\mgt_rxcharisk_reg_reg[7] ;
  output [1:0]\mgt_rxdisperr_reg_reg[7] ;
  output [1:0]\mgt_rxnotintable_reg_reg[7] ;
  output [0:0]\core_mgt_rx_reset_reg[3] ;
  input dclk;
  input gt3_drpen;
  input gt3_drpwe;
  input gt3_eyescanreset_in;
  input gt3_eyescantrigger_in;
  input gt3_gtrxreset_in;
  input uclk_mgt_tx_reset;
  input xaui_rx_l3_n;
  input xaui_rx_l3_p;
  input gt0_qpllclk_i;
  input gt0_qpllrefclk_i;
  input [0:0]Q;
  input gt3_rxcdrhold_in;
  input gt3_rxchbonden_in;
  input gt3_rxdfelpmreset_in;
  input gt3_rxlpmen_in;
  input [0:0]mgt_enable_align;
  input gt3_rxpcsreset_in;
  input gt3_rxpmareset_in;
  input gt3_rxpolarity_in;
  input gt3_rxprbscntreset_in;
  input gt3_txuserrdy_in;
  input CLK;
  input gt3_txdlysreset_in;
  input gt3_txelecidle_in;
  input gt3_txinhibit_in;
  input gt3_txpcsreset_in;
  input gt3_txphalign_in;
  input gt3_txphinit_in;
  input gt3_txpmareset_in;
  input gt3_txpolarity_in;
  input gt3_txprbsforceerr_in;
  input [15:0]gt3_drpdi;
  input [1:0]gt3_rxmonitorsel_in;
  input [2:0]gt3_loopback_in;
  input [2:0]gt3_rxprbssel_in;
  input [2:0]gt3_rxrate_in;
  input [2:0]gt3_txprbssel_in;
  input [3:0]gt3_txdiffctrl_in;
  input [4:0]uclk_mgt_rx_reset_reg;
  input [4:0]gt3_txpostcursor_in;
  input [4:0]gt3_txprecursor_in;
  input [15:0]mgt_txdata;
  input [1:0]mgt_txcharisk;
  input [8:0]gt3_drpaddr;
  input [0:0]uclk_loopback_int;

  wire CLK;
  wire [0:0]D;
  wire [0:0]Q;
  wire [0:0]\core_mgt_rx_reset_reg[3] ;
  wire dclk;
  wire gt0_qpllclk_i;
  wire gt0_qpllrefclk_i;
  wire [7:0]gt3_dmonitorout_out;
  wire [8:0]gt3_drpaddr;
  wire [15:0]gt3_drpdi;
  wire [15:0]gt3_drpdo;
  wire gt3_drpen;
  wire gt3_drprdy;
  wire gt3_drpwe;
  wire gt3_eyescandataerror_out;
  wire gt3_eyescanreset_in;
  wire gt3_eyescantrigger_in;
  wire gt3_gtrxreset_in;
  wire [2:0]gt3_loopback_in;
  wire [1:1]gt3_loopback_in0_out;
  wire gt3_rxcdrhold_in;
  wire gt3_rxchbonden_in;
  wire gt3_rxcommadet_out;
  wire gt3_rxdfelpmreset_in;
  wire gt3_rxlpmen_in;
  wire [6:0]gt3_rxmonitorout_out;
  wire [1:0]gt3_rxmonitorsel_in;
  wire gt3_rxpcsreset_in;
  wire gt3_rxpmareset_in;
  wire gt3_rxpolarity_in;
  wire gt3_rxprbscntreset_in;
  wire gt3_rxprbserr_out;
  wire [2:0]gt3_rxprbssel_in;
  wire [2:0]gt3_rxrate_in;
  wire gt3_rxresetdone_out;
  wire [3:0]gt3_txdiffctrl_in;
  wire gt3_txdlysreset_in;
  wire gt3_txdlysresetdone_out;
  wire gt3_txelecidle_in;
  wire gt3_txinhibit_in;
  wire gt3_txpcsreset_in;
  wire gt3_txphalign_in;
  wire gt3_txphaligndone_out;
  wire gt3_txphinit_in;
  wire gt3_txphinitdone_out;
  wire gt3_txpmareset_in;
  wire gt3_txpolarity_in;
  wire [4:0]gt3_txpostcursor_in;
  wire gt3_txprbsforceerr_in;
  wire [2:0]gt3_txprbssel_in;
  wire [4:0]gt3_txprecursor_in;
  wire gt3_txuserrdy_in;
  wire gtxe2_i_n_10;
  wire gtxe2_i_n_12;
  wire gtxe2_i_n_13;
  wire gtxe2_i_n_14;
  wire gtxe2_i_n_23;
  wire gtxe2_i_n_30;
  wire gtxe2_i_n_37;
  wire gtxe2_i_n_38;
  wire gtxe2_i_n_39;
  wire gtxe2_i_n_78;
  wire gtxe2_i_n_79;
  wire gtxe2_i_n_9;
  wire gtxe2_i_n_91;
  wire gtxe2_i_n_92;
  wire gtxe2_i_n_93;
  wire gtxe2_i_n_94;
  wire gtxe2_i_n_95;
  wire [1:0]\mgt_codecomma_reg_reg[7] ;
  wire [0:0]mgt_enable_align;
  wire [1:0]\mgt_rxcharisk_reg_reg[7] ;
  wire [15:0]\mgt_rxdata_reg_reg[63] ;
  wire [1:0]\mgt_rxdisperr_reg_reg[7] ;
  wire [1:0]\mgt_rxnotintable_reg_reg[7] ;
  wire [1:0]mgt_txcharisk;
  wire [15:0]mgt_txdata;
  wire [0:0]uclk_loopback_int;
  wire [4:0]uclk_mgt_rx_reset_reg;
  wire [2:0]\uclk_mgt_rxbufstatus_reg_reg[11] ;
  wire uclk_mgt_tx_reset;
  wire xaui_rx_l3_n;
  wire xaui_rx_l3_p;
  wire xaui_tx_l3_n;
  wire xaui_tx_l3_p;
  wire NLW_gtxe2_i_CPLLFBCLKLOST_UNCONNECTED;
  wire NLW_gtxe2_i_CPLLLOCK_UNCONNECTED;
  wire NLW_gtxe2_i_CPLLREFCLKLOST_UNCONNECTED;
  wire NLW_gtxe2_i_GTREFCLKMONITOR_UNCONNECTED;
  wire NLW_gtxe2_i_PHYSTATUS_UNCONNECTED;
  wire NLW_gtxe2_i_RXCDRLOCK_UNCONNECTED;
  wire NLW_gtxe2_i_RXCOMINITDET_UNCONNECTED;
  wire NLW_gtxe2_i_RXCOMSASDET_UNCONNECTED;
  wire NLW_gtxe2_i_RXCOMWAKEDET_UNCONNECTED;
  wire NLW_gtxe2_i_RXDATAVALID_UNCONNECTED;
  wire NLW_gtxe2_i_RXDLYSRESETDONE_UNCONNECTED;
  wire NLW_gtxe2_i_RXELECIDLE_UNCONNECTED;
  wire NLW_gtxe2_i_RXHEADERVALID_UNCONNECTED;
  wire NLW_gtxe2_i_RXOUTCLKFABRIC_UNCONNECTED;
  wire NLW_gtxe2_i_RXOUTCLKPCS_UNCONNECTED;
  wire NLW_gtxe2_i_RXPHALIGNDONE_UNCONNECTED;
  wire NLW_gtxe2_i_RXQPISENN_UNCONNECTED;
  wire NLW_gtxe2_i_RXQPISENP_UNCONNECTED;
  wire NLW_gtxe2_i_RXSTARTOFSEQ_UNCONNECTED;
  wire NLW_gtxe2_i_RXVALID_UNCONNECTED;
  wire NLW_gtxe2_i_TXCOMFINISH_UNCONNECTED;
  wire NLW_gtxe2_i_TXGEARBOXREADY_UNCONNECTED;
  wire NLW_gtxe2_i_TXQPISENN_UNCONNECTED;
  wire NLW_gtxe2_i_TXQPISENP_UNCONNECTED;
  wire NLW_gtxe2_i_TXRATEDONE_UNCONNECTED;
  wire [15:0]NLW_gtxe2_i_PCSRSVDOUT_UNCONNECTED;
  wire [7:2]NLW_gtxe2_i_RXCHARISCOMMA_UNCONNECTED;
  wire [7:2]NLW_gtxe2_i_RXCHARISK_UNCONNECTED;
  wire [63:16]NLW_gtxe2_i_RXDATA_UNCONNECTED;
  wire [7:2]NLW_gtxe2_i_RXDISPERR_UNCONNECTED;
  wire [2:0]NLW_gtxe2_i_RXHEADER_UNCONNECTED;
  wire [7:2]NLW_gtxe2_i_RXNOTINTABLE_UNCONNECTED;
  wire [4:0]NLW_gtxe2_i_RXPHMONITOR_UNCONNECTED;
  wire [4:0]NLW_gtxe2_i_RXPHSLIPMONITOR_UNCONNECTED;
  wire [2:0]NLW_gtxe2_i_RXSTATUS_UNCONNECTED;
  wire [9:0]NLW_gtxe2_i_TSTOUT_UNCONNECTED;
  wire [1:0]NLW_gtxe2_i_TXBUFSTATUS_UNCONNECTED;

  LUT1 #(
    .INIT(2'h1)) 
    \core_mgt_rx_reset[3]_i_1 
       (.I0(gt3_rxresetdone_out),
        .O(\core_mgt_rx_reset_reg[3] ));
  (* box_type = "PRIMITIVE" *) 
  GTXE2_CHANNEL #(
    .ALIGN_COMMA_DOUBLE("FALSE"),
    .ALIGN_COMMA_ENABLE(10'b0001111111),
    .ALIGN_COMMA_WORD(1),
    .ALIGN_MCOMMA_DET("TRUE"),
    .ALIGN_MCOMMA_VALUE(10'b1010000011),
    .ALIGN_PCOMMA_DET("TRUE"),
    .ALIGN_PCOMMA_VALUE(10'b0101111100),
    .CBCC_DATA_SOURCE_SEL("DECODED"),
    .CHAN_BOND_KEEP_ALIGN("FALSE"),
    .CHAN_BOND_MAX_SKEW(7),
    .CHAN_BOND_SEQ_1_1(10'b0101111100),
    .CHAN_BOND_SEQ_1_2(10'b0000000000),
    .CHAN_BOND_SEQ_1_3(10'b0000000000),
    .CHAN_BOND_SEQ_1_4(10'b0000000000),
    .CHAN_BOND_SEQ_1_ENABLE(4'b1111),
    .CHAN_BOND_SEQ_2_1(10'b0100000000),
    .CHAN_BOND_SEQ_2_2(10'b0100000000),
    .CHAN_BOND_SEQ_2_3(10'b0100000000),
    .CHAN_BOND_SEQ_2_4(10'b0100000000),
    .CHAN_BOND_SEQ_2_ENABLE(4'b1111),
    .CHAN_BOND_SEQ_2_USE("FALSE"),
    .CHAN_BOND_SEQ_LEN(1),
    .CLK_CORRECT_USE("TRUE"),
    .CLK_COR_KEEP_IDLE("FALSE"),
    .CLK_COR_MAX_LAT(19),
    .CLK_COR_MIN_LAT(17),
    .CLK_COR_PRECEDENCE("TRUE"),
    .CLK_COR_REPEAT_WAIT(0),
    .CLK_COR_SEQ_1_1(10'b0100011100),
    .CLK_COR_SEQ_1_2(10'b0100000000),
    .CLK_COR_SEQ_1_3(10'b0100000000),
    .CLK_COR_SEQ_1_4(10'b0100000000),
    .CLK_COR_SEQ_1_ENABLE(4'b1111),
    .CLK_COR_SEQ_2_1(10'b0100000000),
    .CLK_COR_SEQ_2_2(10'b0100000000),
    .CLK_COR_SEQ_2_3(10'b0100000000),
    .CLK_COR_SEQ_2_4(10'b0100000000),
    .CLK_COR_SEQ_2_ENABLE(4'b1111),
    .CLK_COR_SEQ_2_USE("FALSE"),
    .CLK_COR_SEQ_LEN(1),
    .CPLL_CFG(24'hBC07DC),
    .CPLL_FBDIV(4),
    .CPLL_FBDIV_45(5),
    .CPLL_INIT_CFG(24'h00001E),
    .CPLL_LOCK_CFG(16'h01E8),
    .CPLL_REFCLK_DIV(1),
    .DEC_MCOMMA_DETECT("TRUE"),
    .DEC_PCOMMA_DETECT("TRUE"),
    .DEC_VALID_COMMA_ONLY("TRUE"),
    .DMONITOR_CFG(24'h000A00),
    .ES_CONTROL(6'b000000),
    .ES_ERRDET_EN("FALSE"),
    .ES_EYE_SCAN_EN("TRUE"),
    .ES_HORZ_OFFSET(12'h000),
    .ES_PMA_CFG(10'b0000000000),
    .ES_PRESCALE(5'b00000),
    .ES_QUALIFIER(80'h00000000000000000000),
    .ES_QUAL_MASK(80'h00000000000000000000),
    .ES_SDATA_MASK(80'h00000000000000000000),
    .ES_VERT_OFFSET(9'b000000000),
    .FTS_DESKEW_SEQ_ENABLE(4'b1111),
    .FTS_LANE_DESKEW_CFG(4'b1111),
    .FTS_LANE_DESKEW_EN("FALSE"),
    .GEARBOX_MODE(3'b000),
    .IS_CPLLLOCKDETCLK_INVERTED(1'b0),
    .IS_DRPCLK_INVERTED(1'b0),
    .IS_GTGREFCLK_INVERTED(1'b0),
    .IS_RXUSRCLK2_INVERTED(1'b0),
    .IS_RXUSRCLK_INVERTED(1'b0),
    .IS_TXPHDLYTSTCLK_INVERTED(1'b0),
    .IS_TXUSRCLK2_INVERTED(1'b0),
    .IS_TXUSRCLK_INVERTED(1'b0),
    .OUTREFCLK_SEL_INV(2'b11),
    .PCS_PCIE_EN("FALSE"),
    .PCS_RSVD_ATTR(48'h000000000002),
    .PD_TRANS_TIME_FROM_P2(12'h03C),
    .PD_TRANS_TIME_NONE_P2(8'h19),
    .PD_TRANS_TIME_TO_P2(8'h64),
    .PMA_RSV(32'h00018480),
    .PMA_RSV2(16'h2050),
    .PMA_RSV3(2'b00),
    .PMA_RSV4(32'h00000000),
    .RXBUFRESET_TIME(5'b00001),
    .RXBUF_ADDR_MODE("FULL"),
    .RXBUF_EIDLE_HI_CNT(4'b1000),
    .RXBUF_EIDLE_LO_CNT(4'b0000),
    .RXBUF_EN("TRUE"),
    .RXBUF_RESET_ON_CB_CHANGE("TRUE"),
    .RXBUF_RESET_ON_COMMAALIGN("FALSE"),
    .RXBUF_RESET_ON_EIDLE("FALSE"),
    .RXBUF_RESET_ON_RATE_CHANGE("TRUE"),
    .RXBUF_THRESH_OVFLW(61),
    .RXBUF_THRESH_OVRD("FALSE"),
    .RXBUF_THRESH_UNDFLW(4),
    .RXCDRFREQRESET_TIME(5'b00001),
    .RXCDRPHRESET_TIME(5'b00001),
    .RXCDR_CFG(72'h03000023FF10200020),
    .RXCDR_FR_RESET_ON_EIDLE(1'b0),
    .RXCDR_HOLD_DURING_EIDLE(1'b0),
    .RXCDR_LOCK_CFG(6'b010101),
    .RXCDR_PH_RESET_ON_EIDLE(1'b0),
    .RXDFELPMRESET_TIME(7'b0001111),
    .RXDLY_CFG(16'h001F),
    .RXDLY_LCFG(9'h030),
    .RXDLY_TAP_CFG(16'h0000),
    .RXGEARBOX_EN("FALSE"),
    .RXISCANRESET_TIME(5'b00001),
    .RXLPM_HF_CFG(14'b00000011110000),
    .RXLPM_LF_CFG(14'b00000011110000),
    .RXOOB_CFG(7'b0000110),
    .RXOUT_DIV(2),
    .RXPCSRESET_TIME(5'b00001),
    .RXPHDLY_CFG(24'h084020),
    .RXPH_CFG(24'h000000),
    .RXPH_MONITOR_SEL(5'b00000),
    .RXPMARESET_TIME(5'b00011),
    .RXPRBS_ERR_LOOPBACK(1'b0),
    .RXSLIDE_AUTO_WAIT(7),
    .RXSLIDE_MODE("OFF"),
    .RX_BIAS_CFG(12'b000000000100),
    .RX_BUFFER_CFG(6'b000000),
    .RX_CLK25_DIV(7),
    .RX_CLKMUX_PD(1'b1),
    .RX_CM_SEL(2'b11),
    .RX_CM_TRIM(3'b010),
    .RX_DATA_WIDTH(20),
    .RX_DDI_SEL(6'b000000),
    .RX_DEBUG_CFG(12'b000000000000),
    .RX_DEFER_RESET_BUF_EN("TRUE"),
    .RX_DFE_GAIN_CFG(23'h020FEA),
    .RX_DFE_H2_CFG(12'b000000000000),
    .RX_DFE_H3_CFG(12'b000001000000),
    .RX_DFE_H4_CFG(11'b00011110000),
    .RX_DFE_H5_CFG(11'b00011100000),
    .RX_DFE_KL_CFG(13'b0000011111110),
    .RX_DFE_KL_CFG2(32'h301148AC),
    .RX_DFE_LPM_CFG(16'h0904),
    .RX_DFE_LPM_HOLD_DURING_EIDLE(1'b0),
    .RX_DFE_UT_CFG(17'b10001111000000000),
    .RX_DFE_VP_CFG(17'b00011111100000011),
    .RX_DFE_XYD_CFG(13'b0000000000000),
    .RX_DISPERR_SEQ_MATCH("TRUE"),
    .RX_INT_DATAWIDTH(0),
    .RX_OS_CFG(13'b0000010000000),
    .RX_SIG_VALID_DLY(10),
    .RX_XCLK_SEL("RXREC"),
    .SAS_MAX_COM(64),
    .SAS_MIN_COM(36),
    .SATA_BURST_SEQ_LEN(4'b0101),
    .SATA_BURST_VAL(3'b100),
    .SATA_CPLL_CFG("VCO_3000MHZ"),
    .SATA_EIDLE_VAL(3'b100),
    .SATA_MAX_BURST(8),
    .SATA_MAX_INIT(21),
    .SATA_MAX_WAKE(7),
    .SATA_MIN_BURST(4),
    .SATA_MIN_INIT(12),
    .SATA_MIN_WAKE(4),
    .SHOW_REALIGN_COMMA("TRUE"),
    .SIM_CPLLREFCLK_SEL(3'b001),
    .SIM_RECEIVER_DETECT_PASS("TRUE"),
    .SIM_RESET_SPEEDUP("TRUE"),
    .SIM_TX_EIDLE_DRIVE_LEVEL("X"),
    .SIM_VERSION("4.0"),
    .TERM_RCAL_CFG(5'b10000),
    .TERM_RCAL_OVRD(1'b0),
    .TRANS_TIME_RATE(8'h0E),
    .TST_RSV(32'h00000000),
    .TXBUF_EN("FALSE"),
    .TXBUF_RESET_ON_RATE_CHANGE("TRUE"),
    .TXDLY_CFG(16'h001F),
    .TXDLY_LCFG(9'h030),
    .TXDLY_TAP_CFG(16'h0000),
    .TXGEARBOX_EN("FALSE"),
    .TXOUT_DIV(2),
    .TXPCSRESET_TIME(5'b00001),
    .TXPHDLY_CFG(24'h084020),
    .TXPH_CFG(16'h0780),
    .TXPH_MONITOR_SEL(5'b00000),
    .TXPMARESET_TIME(5'b00001),
    .TX_CLK25_DIV(7),
    .TX_CLKMUX_PD(1'b1),
    .TX_DATA_WIDTH(20),
    .TX_DEEMPH0(5'b00000),
    .TX_DEEMPH1(5'b00000),
    .TX_DRIVE_MODE("DIRECT"),
    .TX_EIDLE_ASSERT_DELAY(3'b110),
    .TX_EIDLE_DEASSERT_DELAY(3'b100),
    .TX_INT_DATAWIDTH(0),
    .TX_LOOPBACK_DRIVE_HIZ("FALSE"),
    .TX_MAINCURSOR_SEL(1'b0),
    .TX_MARGIN_FULL_0(7'b1001110),
    .TX_MARGIN_FULL_1(7'b1001001),
    .TX_MARGIN_FULL_2(7'b1000101),
    .TX_MARGIN_FULL_3(7'b1000010),
    .TX_MARGIN_FULL_4(7'b1000000),
    .TX_MARGIN_LOW_0(7'b1000110),
    .TX_MARGIN_LOW_1(7'b1000100),
    .TX_MARGIN_LOW_2(7'b1000010),
    .TX_MARGIN_LOW_3(7'b1000000),
    .TX_MARGIN_LOW_4(7'b1000000),
    .TX_PREDRIVER_MODE(1'b0),
    .TX_QPI_STATUS_EN(1'b0),
    .TX_RXDETECT_CFG(14'h1832),
    .TX_RXDETECT_REF(3'b100),
    .TX_XCLK_SEL("TXUSR"),
    .UCODEER_CLR(1'b0)) 
    gtxe2_i
       (.CFGRESET(1'b0),
        .CLKRSVD({1'b0,1'b0,1'b0,1'b0}),
        .CPLLFBCLKLOST(NLW_gtxe2_i_CPLLFBCLKLOST_UNCONNECTED),
        .CPLLLOCK(NLW_gtxe2_i_CPLLLOCK_UNCONNECTED),
        .CPLLLOCKDETCLK(1'b0),
        .CPLLLOCKEN(1'b1),
        .CPLLPD(1'b1),
        .CPLLREFCLKLOST(NLW_gtxe2_i_CPLLREFCLKLOST_UNCONNECTED),
        .CPLLREFCLKSEL({1'b0,1'b0,1'b1}),
        .CPLLRESET(1'b0),
        .DMONITOROUT(gt3_dmonitorout_out),
        .DRPADDR(gt3_drpaddr),
        .DRPCLK(dclk),
        .DRPDI(gt3_drpdi),
        .DRPDO(gt3_drpdo),
        .DRPEN(gt3_drpen),
        .DRPRDY(gt3_drprdy),
        .DRPWE(gt3_drpwe),
        .EYESCANDATAERROR(gt3_eyescandataerror_out),
        .EYESCANMODE(1'b0),
        .EYESCANRESET(gt3_eyescanreset_in),
        .EYESCANTRIGGER(gt3_eyescantrigger_in),
        .GTGREFCLK(1'b0),
        .GTNORTHREFCLK0(1'b0),
        .GTNORTHREFCLK1(1'b0),
        .GTREFCLK0(1'b0),
        .GTREFCLK1(1'b0),
        .GTREFCLKMONITOR(NLW_gtxe2_i_GTREFCLKMONITOR_UNCONNECTED),
        .GTRESETSEL(1'b0),
        .GTRSVD({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .GTRXRESET(gt3_gtrxreset_in),
        .GTSOUTHREFCLK0(1'b0),
        .GTSOUTHREFCLK1(1'b0),
        .GTTXRESET(uclk_mgt_tx_reset),
        .GTXRXN(xaui_rx_l3_n),
        .GTXRXP(xaui_rx_l3_p),
        .GTXTXN(xaui_tx_l3_n),
        .GTXTXP(xaui_tx_l3_p),
        .LOOPBACK({gt3_loopback_in[2],gt3_loopback_in0_out,gt3_loopback_in[0]}),
        .PCSRSVDIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCSRSVDIN2({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCSRSVDOUT(NLW_gtxe2_i_PCSRSVDOUT_UNCONNECTED[15:0]),
        .PHYSTATUS(NLW_gtxe2_i_PHYSTATUS_UNCONNECTED),
        .PMARSVDIN({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PMARSVDIN2({1'b0,1'b0,1'b0,1'b0,1'b0}),
        .QPLLCLK(gt0_qpllclk_i),
        .QPLLREFCLK(gt0_qpllrefclk_i),
        .RESETOVRD(1'b0),
        .RX8B10BEN(1'b1),
        .RXBUFRESET(Q),
        .RXBUFSTATUS(\uclk_mgt_rxbufstatus_reg_reg[11] ),
        .RXBYTEISALIGNED(gtxe2_i_n_9),
        .RXBYTEREALIGN(gtxe2_i_n_10),
        .RXCDRFREQRESET(1'b0),
        .RXCDRHOLD(gt3_rxcdrhold_in),
        .RXCDRLOCK(NLW_gtxe2_i_RXCDRLOCK_UNCONNECTED),
        .RXCDROVRDEN(1'b0),
        .RXCDRRESET(1'b0),
        .RXCDRRESETRSV(1'b0),
        .RXCHANBONDSEQ(gtxe2_i_n_12),
        .RXCHANISALIGNED(gtxe2_i_n_13),
        .RXCHANREALIGN(gtxe2_i_n_14),
        .RXCHARISCOMMA({NLW_gtxe2_i_RXCHARISCOMMA_UNCONNECTED[7:2],\mgt_codecomma_reg_reg[7] }),
        .RXCHARISK({NLW_gtxe2_i_RXCHARISK_UNCONNECTED[7:2],\mgt_rxcharisk_reg_reg[7] }),
        .RXCHBONDEN(gt3_rxchbonden_in),
        .RXCHBONDI(uclk_mgt_rx_reset_reg),
        .RXCHBONDLEVEL({1'b0,1'b0,1'b1}),
        .RXCHBONDMASTER(1'b0),
        .RXCHBONDO({gtxe2_i_n_91,gtxe2_i_n_92,gtxe2_i_n_93,gtxe2_i_n_94,gtxe2_i_n_95}),
        .RXCHBONDSLAVE(1'b1),
        .RXCLKCORCNT({gtxe2_i_n_78,gtxe2_i_n_79}),
        .RXCOMINITDET(NLW_gtxe2_i_RXCOMINITDET_UNCONNECTED),
        .RXCOMMADET(gt3_rxcommadet_out),
        .RXCOMMADETEN(1'b1),
        .RXCOMSASDET(NLW_gtxe2_i_RXCOMSASDET_UNCONNECTED),
        .RXCOMWAKEDET(NLW_gtxe2_i_RXCOMWAKEDET_UNCONNECTED),
        .RXDATA({NLW_gtxe2_i_RXDATA_UNCONNECTED[63:16],\mgt_rxdata_reg_reg[63] }),
        .RXDATAVALID(NLW_gtxe2_i_RXDATAVALID_UNCONNECTED),
        .RXDDIEN(1'b0),
        .RXDFEAGCHOLD(1'b0),
        .RXDFEAGCOVRDEN(1'b0),
        .RXDFECM1EN(1'b0),
        .RXDFELFHOLD(1'b0),
        .RXDFELFOVRDEN(1'b0),
        .RXDFELPMRESET(gt3_rxdfelpmreset_in),
        .RXDFETAP2HOLD(1'b0),
        .RXDFETAP2OVRDEN(1'b0),
        .RXDFETAP3HOLD(1'b0),
        .RXDFETAP3OVRDEN(1'b0),
        .RXDFETAP4HOLD(1'b0),
        .RXDFETAP4OVRDEN(1'b0),
        .RXDFETAP5HOLD(1'b0),
        .RXDFETAP5OVRDEN(1'b0),
        .RXDFEUTHOLD(1'b0),
        .RXDFEUTOVRDEN(1'b0),
        .RXDFEVPHOLD(1'b0),
        .RXDFEVPOVRDEN(1'b0),
        .RXDFEVSEN(1'b0),
        .RXDFEXYDEN(1'b1),
        .RXDFEXYDHOLD(1'b0),
        .RXDFEXYDOVRDEN(1'b0),
        .RXDISPERR({NLW_gtxe2_i_RXDISPERR_UNCONNECTED[7:2],\mgt_rxdisperr_reg_reg[7] }),
        .RXDLYBYPASS(1'b1),
        .RXDLYEN(1'b0),
        .RXDLYOVRDEN(1'b0),
        .RXDLYSRESET(1'b0),
        .RXDLYSRESETDONE(NLW_gtxe2_i_RXDLYSRESETDONE_UNCONNECTED),
        .RXELECIDLE(NLW_gtxe2_i_RXELECIDLE_UNCONNECTED),
        .RXELECIDLEMODE({1'b1,1'b1}),
        .RXGEARBOXSLIP(1'b0),
        .RXHEADER(NLW_gtxe2_i_RXHEADER_UNCONNECTED[2:0]),
        .RXHEADERVALID(NLW_gtxe2_i_RXHEADERVALID_UNCONNECTED),
        .RXLPMEN(gt3_rxlpmen_in),
        .RXLPMHFHOLD(1'b0),
        .RXLPMHFOVRDEN(1'b0),
        .RXLPMLFHOLD(1'b0),
        .RXLPMLFKLOVRDEN(1'b0),
        .RXMCOMMAALIGNEN(mgt_enable_align),
        .RXMONITOROUT(gt3_rxmonitorout_out),
        .RXMONITORSEL(gt3_rxmonitorsel_in),
        .RXNOTINTABLE({NLW_gtxe2_i_RXNOTINTABLE_UNCONNECTED[7:2],\mgt_rxnotintable_reg_reg[7] }),
        .RXOOBRESET(1'b0),
        .RXOSHOLD(1'b0),
        .RXOSOVRDEN(1'b0),
        .RXOUTCLK(gtxe2_i_n_23),
        .RXOUTCLKFABRIC(NLW_gtxe2_i_RXOUTCLKFABRIC_UNCONNECTED),
        .RXOUTCLKPCS(NLW_gtxe2_i_RXOUTCLKPCS_UNCONNECTED),
        .RXOUTCLKSEL({1'b0,1'b1,1'b0}),
        .RXPCOMMAALIGNEN(mgt_enable_align),
        .RXPCSRESET(gt3_rxpcsreset_in),
        .RXPD({gt3_txelecidle_in,gt3_txelecidle_in}),
        .RXPHALIGN(1'b0),
        .RXPHALIGNDONE(NLW_gtxe2_i_RXPHALIGNDONE_UNCONNECTED),
        .RXPHALIGNEN(1'b0),
        .RXPHDLYPD(1'b0),
        .RXPHDLYRESET(1'b0),
        .RXPHMONITOR(NLW_gtxe2_i_RXPHMONITOR_UNCONNECTED[4:0]),
        .RXPHOVRDEN(1'b0),
        .RXPHSLIPMONITOR(NLW_gtxe2_i_RXPHSLIPMONITOR_UNCONNECTED[4:0]),
        .RXPMARESET(gt3_rxpmareset_in),
        .RXPOLARITY(gt3_rxpolarity_in),
        .RXPRBSCNTRESET(gt3_rxprbscntreset_in),
        .RXPRBSERR(gt3_rxprbserr_out),
        .RXPRBSSEL(gt3_rxprbssel_in),
        .RXQPIEN(1'b0),
        .RXQPISENN(NLW_gtxe2_i_RXQPISENN_UNCONNECTED),
        .RXQPISENP(NLW_gtxe2_i_RXQPISENP_UNCONNECTED),
        .RXRATE(gt3_rxrate_in),
        .RXRATEDONE(gtxe2_i_n_30),
        .RXRESETDONE(gt3_rxresetdone_out),
        .RXSLIDE(1'b0),
        .RXSTARTOFSEQ(NLW_gtxe2_i_RXSTARTOFSEQ_UNCONNECTED),
        .RXSTATUS(NLW_gtxe2_i_RXSTATUS_UNCONNECTED[2:0]),
        .RXSYSCLKSEL({1'b1,1'b1}),
        .RXUSERRDY(gt3_txuserrdy_in),
        .RXUSRCLK(CLK),
        .RXUSRCLK2(CLK),
        .RXVALID(NLW_gtxe2_i_RXVALID_UNCONNECTED),
        .SETERRSTATUS(1'b0),
        .TSTIN({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .TSTOUT(NLW_gtxe2_i_TSTOUT_UNCONNECTED[9:0]),
        .TX8B10BBYPASS({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TX8B10BEN(1'b1),
        .TXBUFDIFFCTRL({1'b1,1'b0,1'b0}),
        .TXBUFSTATUS(NLW_gtxe2_i_TXBUFSTATUS_UNCONNECTED[1:0]),
        .TXCHARDISPMODE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXCHARDISPVAL({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXCHARISK({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,mgt_txcharisk}),
        .TXCOMFINISH(NLW_gtxe2_i_TXCOMFINISH_UNCONNECTED),
        .TXCOMINIT(1'b0),
        .TXCOMSAS(1'b0),
        .TXCOMWAKE(1'b0),
        .TXDATA({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,mgt_txdata}),
        .TXDEEMPH(1'b0),
        .TXDETECTRX(1'b0),
        .TXDIFFCTRL(gt3_txdiffctrl_in),
        .TXDIFFPD(1'b0),
        .TXDLYBYPASS(1'b0),
        .TXDLYEN(1'b0),
        .TXDLYHOLD(1'b0),
        .TXDLYOVRDEN(1'b0),
        .TXDLYSRESET(gt3_txdlysreset_in),
        .TXDLYSRESETDONE(gt3_txdlysresetdone_out),
        .TXDLYUPDOWN(1'b0),
        .TXELECIDLE(gt3_txelecidle_in),
        .TXGEARBOXREADY(NLW_gtxe2_i_TXGEARBOXREADY_UNCONNECTED),
        .TXHEADER({1'b0,1'b0,1'b0}),
        .TXINHIBIT(gt3_txinhibit_in),
        .TXMAINCURSOR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXMARGIN({1'b0,1'b0,1'b0}),
        .TXOUTCLK(gtxe2_i_n_37),
        .TXOUTCLKFABRIC(gtxe2_i_n_38),
        .TXOUTCLKPCS(gtxe2_i_n_39),
        .TXOUTCLKSEL({1'b0,1'b1,1'b1}),
        .TXPCSRESET(gt3_txpcsreset_in),
        .TXPD({gt3_txelecidle_in,gt3_txelecidle_in}),
        .TXPDELECIDLEMODE(1'b0),
        .TXPHALIGN(gt3_txphalign_in),
        .TXPHALIGNDONE(gt3_txphaligndone_out),
        .TXPHALIGNEN(1'b1),
        .TXPHDLYPD(1'b0),
        .TXPHDLYRESET(1'b0),
        .TXPHDLYTSTCLK(1'b0),
        .TXPHINIT(gt3_txphinit_in),
        .TXPHINITDONE(gt3_txphinitdone_out),
        .TXPHOVRDEN(1'b0),
        .TXPISOPD(1'b0),
        .TXPMARESET(gt3_txpmareset_in),
        .TXPOLARITY(gt3_txpolarity_in),
        .TXPOSTCURSOR(gt3_txpostcursor_in),
        .TXPOSTCURSORINV(1'b0),
        .TXPRBSFORCEERR(gt3_txprbsforceerr_in),
        .TXPRBSSEL(gt3_txprbssel_in),
        .TXPRECURSOR(gt3_txprecursor_in),
        .TXPRECURSORINV(1'b0),
        .TXQPIBIASEN(1'b0),
        .TXQPISENN(NLW_gtxe2_i_TXQPISENN_UNCONNECTED),
        .TXQPISENP(NLW_gtxe2_i_TXQPISENP_UNCONNECTED),
        .TXQPISTRONGPDOWN(1'b0),
        .TXQPIWEAKPUP(1'b0),
        .TXRATE({1'b0,1'b0,1'b0}),
        .TXRATEDONE(NLW_gtxe2_i_TXRATEDONE_UNCONNECTED),
        .TXRESETDONE(D),
        .TXSEQUENCE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .TXSTARTSEQ(1'b0),
        .TXSWING(1'b0),
        .TXSYSCLKSEL({1'b1,1'b1}),
        .TXUSERRDY(gt3_txuserrdy_in),
        .TXUSRCLK(CLK),
        .TXUSRCLK2(CLK));
  LUT2 #(
    .INIT(4'hE)) 
    gtxe2_i_i_1__2
       (.I0(uclk_loopback_int),
        .I1(gt3_loopback_in[1]),
        .O(gt3_loopback_in0_out));
endmodule

(* ORIG_REF_NAME = "xaui_gt_wrapper_tx_sync_manual" *) 
module xaui_xaui_gt_wrapper_tx_sync_manual
   (debug,
    mgt_tx_reset,
    gt3_txdlysreset_in,
    gt2_txdlysreset_in,
    gt1_txdlysreset_in,
    \TXDLYSRESET_reg[0]_0 ,
    \TXPHINIT_reg[0]_0 ,
    gt3_txphinit_in,
    gt2_txphinit_in,
    gt1_txphinit_in,
    \TXPHALIGN_reg[0]_0 ,
    gt3_txphalign_in,
    gt2_txphalign_in,
    gt1_txphalign_in,
    \TXDLYEN_reg[0]_0 ,
    uclk_mgt_rx_reset_reg,
    uclk_mgt_tx_reset,
    uclk_txsync_start_phase_align_reg,
    gt0_txphaligndone_out,
    gt0_txdlysresetdone_out,
    gt1_txphaligndone_out,
    gt1_txdlysresetdone_out,
    gt2_txphaligndone_out,
    gt2_txdlysresetdone_out,
    gt3_txphaligndone_out,
    gt3_txdlysresetdone_out,
    gt0_txphinitdone_out,
    gt1_txphinitdone_out,
    gt2_txphinitdone_out,
    gt3_txphinitdone_out);
  output [0:0]debug;
  output [0:0]mgt_tx_reset;
  output gt3_txdlysreset_in;
  output gt2_txdlysreset_in;
  output gt1_txdlysreset_in;
  output \TXDLYSRESET_reg[0]_0 ;
  output \TXPHINIT_reg[0]_0 ;
  output gt3_txphinit_in;
  output gt2_txphinit_in;
  output gt1_txphinit_in;
  output \TXPHALIGN_reg[0]_0 ;
  output gt3_txphalign_in;
  output gt2_txphalign_in;
  output gt1_txphalign_in;
  output \TXDLYEN_reg[0]_0 ;
  input uclk_mgt_rx_reset_reg;
  input uclk_mgt_tx_reset;
  input uclk_txsync_start_phase_align_reg;
  input gt0_txphaligndone_out;
  input gt0_txdlysresetdone_out;
  input gt1_txphaligndone_out;
  input gt1_txdlysresetdone_out;
  input gt2_txphaligndone_out;
  input gt2_txdlysresetdone_out;
  input gt3_txphaligndone_out;
  input gt3_txdlysresetdone_out;
  input gt0_txphinitdone_out;
  input gt1_txphinitdone_out;
  input gt2_txphinitdone_out;
  input gt3_txphinitdone_out;

  wire \FSM_onehot_tx_phalign_manual_state[8]_i_3_n_0 ;
  wire \FSM_onehot_tx_phalign_manual_state[8]_i_4_n_0 ;
  wire \FSM_onehot_tx_phalign_manual_state[8]_i_6_n_0 ;
  wire \FSM_onehot_tx_phalign_manual_state[8]_i_7_n_0 ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_tx_phalign_manual_state_reg_n_0_[1] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_tx_phalign_manual_state_reg_n_0_[2] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_tx_phalign_manual_state_reg_n_0_[3] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_tx_phalign_manual_state_reg_n_0_[4] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_tx_phalign_manual_state_reg_n_0_[5] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_tx_phalign_manual_state_reg_n_0_[6] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_tx_phalign_manual_state_reg_n_0_[7] ;
  (* RTL_KEEP = "yes" *) wire \FSM_onehot_tx_phalign_manual_state_reg_n_0_[8] ;
  wire PHASE_ALIGNMENT_DONE_i_1_n_0;
  wire \TXDLYEN[0]_i_1_n_0 ;
  wire \TXDLYEN_reg[0]_0 ;
  wire \TXDLYSRESET[0]_i_1_n_0 ;
  wire \TXDLYSRESET[1]_i_1_n_0 ;
  wire \TXDLYSRESET[2]_i_1_n_0 ;
  wire \TXDLYSRESET[3]_i_1_n_0 ;
  wire \TXDLYSRESET_reg[0]_0 ;
  wire \TXPHALIGN[0]_i_1_n_0 ;
  wire \TXPHALIGN[1]_i_1_n_0 ;
  wire \TXPHALIGN[2]_i_1_n_0 ;
  wire \TXPHALIGN[3]_i_1_n_0 ;
  wire \TXPHALIGN_reg[0]_0 ;
  wire \TXPHINIT[0]_i_1_n_0 ;
  wire \TXPHINIT[1]_i_1_n_0 ;
  wire \TXPHINIT[2]_i_1_n_0 ;
  wire \TXPHINIT[3]_i_1_n_0 ;
  wire \TXPHINIT_reg[0]_0 ;
  wire \cdc[0].xaui_gt_wrapper_tx_sync_manual_TXPHALIGNDONE_n_0 ;
  wire \cdc[0].xaui_gt_wrapper_tx_sync_manual_TXPHINITDONE_n_1 ;
  wire data_out0_out;
  wire data_out1_out;
  wire data_out2_out;
  wire [0:0]debug;
  wire gt0_txdlysresetdone_out;
  wire gt0_txphaligndone_out;
  wire gt0_txphinitdone_out;
  wire gt1_txdlysreset_in;
  wire gt1_txdlysresetdone_out;
  wire gt1_txphalign_in;
  wire gt1_txphaligndone_out;
  wire gt1_txphinit_in;
  wire gt1_txphinitdone_out;
  wire gt2_txdlysreset_in;
  wire gt2_txdlysresetdone_out;
  wire gt2_txphalign_in;
  wire gt2_txphaligndone_out;
  wire gt2_txphinit_in;
  wire gt2_txphinitdone_out;
  wire gt3_txdlysreset_in;
  wire gt3_txdlysresetdone_out;
  wire gt3_txphalign_in;
  wire gt3_txphaligndone_out;
  wire gt3_txphinit_in;
  wire gt3_txphinitdone_out;
  wire [0:0]mgt_tx_reset;
  wire p_2_in;
  wire \txdlysresetdone_store[0]_i_1_n_0 ;
  wire \txdlysresetdone_store[1]_i_1_n_0 ;
  wire \txdlysresetdone_store[2]_i_1_n_0 ;
  wire \txdlysresetdone_store[3]_i_1_n_0 ;
  wire \txdlysresetdone_store_reg_n_0_[0] ;
  wire \txdlysresetdone_store_reg_n_0_[1] ;
  wire \txdlysresetdone_store_reg_n_0_[3] ;
  wire txdlysresetdone_sync_3;
  wire txdone_clear_i_1_n_0;
  wire txdone_clear_reg_n_0;
  wire [3:0]txphaligndone_prev;
  wire [3:0]txphaligndone_store;
  wire \txphaligndone_store[0]_i_1_n_0 ;
  wire \txphaligndone_store[1]_i_1_n_0 ;
  wire \txphaligndone_store[2]_i_1_n_0 ;
  wire \txphaligndone_store[3]_i_1_n_0 ;
  wire txphaligndone_sync_0;
  wire txphaligndone_sync_1;
  wire txphaligndone_sync_2;
  wire txphaligndone_sync_3;
  (* RTL_KEEP = "yes" *) wire txphinitdone_clear_slave;
  wire [3:0]txphinitdone_prev;
  wire [3:0]txphinitdone_store_edge;
  wire \txphinitdone_store_edge[0]_i_1_n_0 ;
  wire \txphinitdone_store_edge[1]_i_1_n_0 ;
  wire \txphinitdone_store_edge[2]_i_1_n_0 ;
  wire \txphinitdone_store_edge[3]_i_1_n_0 ;
  wire txphinitdone_sync_0;
  wire txphinitdone_sync_1;
  wire txphinitdone_sync_2;
  wire txphinitdone_sync_3;
  wire uclk_mgt_rx_reset_reg;
  wire uclk_mgt_tx_reset;
  wire uclk_txsync_start_phase_align_reg;

  LUT5 #(
    .INIT(32'h80000000)) 
    \FSM_onehot_tx_phalign_manual_state[8]_i_3 
       (.I0(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[6] ),
        .I1(txphaligndone_store[1]),
        .I2(txphaligndone_store[0]),
        .I3(txphaligndone_store[2]),
        .I4(txphaligndone_store[3]),
        .O(\FSM_onehot_tx_phalign_manual_state[8]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h80000000)) 
    \FSM_onehot_tx_phalign_manual_state[8]_i_4 
       (.I0(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[5] ),
        .I1(txphinitdone_store_edge[1]),
        .I2(txphinitdone_store_edge[0]),
        .I3(txphinitdone_store_edge[2]),
        .I4(txphinitdone_store_edge[3]),
        .O(\FSM_onehot_tx_phalign_manual_state[8]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h80000000)) 
    \FSM_onehot_tx_phalign_manual_state[8]_i_6 
       (.I0(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[1] ),
        .I1(\txdlysresetdone_store_reg_n_0_[1] ),
        .I2(\txdlysresetdone_store_reg_n_0_[0] ),
        .I3(p_2_in),
        .I4(\txdlysresetdone_store_reg_n_0_[3] ),
        .O(\FSM_onehot_tx_phalign_manual_state[8]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \FSM_onehot_tx_phalign_manual_state[8]_i_7 
       (.I0(txphinitdone_clear_slave),
        .I1(uclk_txsync_start_phase_align_reg),
        .O(\FSM_onehot_tx_phalign_manual_state[8]_i_7_n_0 ));
  (* KEEP = "yes" *) 
  FDSE #(
    .INIT(1'b1)) 
    \FSM_onehot_tx_phalign_manual_state_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(\cdc[0].xaui_gt_wrapper_tx_sync_manual_TXPHALIGNDONE_n_0 ),
        .D(1'b0),
        .Q(txphinitdone_clear_slave),
        .S(uclk_mgt_tx_reset));
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_tx_phalign_manual_state_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(\cdc[0].xaui_gt_wrapper_tx_sync_manual_TXPHALIGNDONE_n_0 ),
        .D(txphinitdone_clear_slave),
        .Q(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[1] ),
        .R(uclk_mgt_tx_reset));
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_tx_phalign_manual_state_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(\cdc[0].xaui_gt_wrapper_tx_sync_manual_TXPHALIGNDONE_n_0 ),
        .D(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[1] ),
        .Q(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[2] ),
        .R(uclk_mgt_tx_reset));
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_tx_phalign_manual_state_reg[3] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(\cdc[0].xaui_gt_wrapper_tx_sync_manual_TXPHALIGNDONE_n_0 ),
        .D(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[2] ),
        .Q(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[3] ),
        .R(uclk_mgt_tx_reset));
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_tx_phalign_manual_state_reg[4] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(\cdc[0].xaui_gt_wrapper_tx_sync_manual_TXPHALIGNDONE_n_0 ),
        .D(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[3] ),
        .Q(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[4] ),
        .R(uclk_mgt_tx_reset));
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_tx_phalign_manual_state_reg[5] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(\cdc[0].xaui_gt_wrapper_tx_sync_manual_TXPHALIGNDONE_n_0 ),
        .D(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[4] ),
        .Q(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[5] ),
        .R(uclk_mgt_tx_reset));
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_tx_phalign_manual_state_reg[6] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(\cdc[0].xaui_gt_wrapper_tx_sync_manual_TXPHALIGNDONE_n_0 ),
        .D(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[5] ),
        .Q(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[6] ),
        .R(uclk_mgt_tx_reset));
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_tx_phalign_manual_state_reg[7] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(\cdc[0].xaui_gt_wrapper_tx_sync_manual_TXPHALIGNDONE_n_0 ),
        .D(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[6] ),
        .Q(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[7] ),
        .R(uclk_mgt_tx_reset));
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_tx_phalign_manual_state_reg[8] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(\cdc[0].xaui_gt_wrapper_tx_sync_manual_TXPHALIGNDONE_n_0 ),
        .D(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[7] ),
        .Q(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[8] ),
        .R(uclk_mgt_tx_reset));
  LUT3 #(
    .INIT(8'hBA)) 
    PHASE_ALIGNMENT_DONE_i_1
       (.I0(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[8] ),
        .I1(txphinitdone_clear_slave),
        .I2(debug),
        .O(PHASE_ALIGNMENT_DONE_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    PHASE_ALIGNMENT_DONE_reg
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(PHASE_ALIGNMENT_DONE_i_1_n_0),
        .Q(debug),
        .R(uclk_mgt_tx_reset));
  LUT6 #(
    .INIT(64'hFFFFFFDFFFFFFFD0)) 
    \TXDLYEN[0]_i_1 
       (.I0(txphaligndone_sync_0),
        .I1(txphaligndone_prev[0]),
        .I2(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[7] ),
        .I4(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[8] ),
        .I5(\TXDLYEN_reg[0]_0 ),
        .O(\TXDLYEN[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \TXDLYEN_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\TXDLYEN[0]_i_1_n_0 ),
        .Q(\TXDLYEN_reg[0]_0 ),
        .R(uclk_mgt_tx_reset));
  LUT5 #(
    .INIT(32'h8FFF8888)) 
    \TXDLYSRESET[0]_i_1 
       (.I0(uclk_txsync_start_phase_align_reg),
        .I1(txphinitdone_clear_slave),
        .I2(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[1] ),
        .I3(\txdlysresetdone_store_reg_n_0_[0] ),
        .I4(\TXDLYSRESET_reg[0]_0 ),
        .O(\TXDLYSRESET[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8FFF8888)) 
    \TXDLYSRESET[1]_i_1 
       (.I0(uclk_txsync_start_phase_align_reg),
        .I1(txphinitdone_clear_slave),
        .I2(\txdlysresetdone_store_reg_n_0_[1] ),
        .I3(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[1] ),
        .I4(gt1_txdlysreset_in),
        .O(\TXDLYSRESET[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8FFF8888)) 
    \TXDLYSRESET[2]_i_1 
       (.I0(uclk_txsync_start_phase_align_reg),
        .I1(txphinitdone_clear_slave),
        .I2(p_2_in),
        .I3(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[1] ),
        .I4(gt2_txdlysreset_in),
        .O(\TXDLYSRESET[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h8FFF8888)) 
    \TXDLYSRESET[3]_i_1 
       (.I0(uclk_txsync_start_phase_align_reg),
        .I1(txphinitdone_clear_slave),
        .I2(\txdlysresetdone_store_reg_n_0_[3] ),
        .I3(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[1] ),
        .I4(gt3_txdlysreset_in),
        .O(\TXDLYSRESET[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \TXDLYSRESET_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\TXDLYSRESET[0]_i_1_n_0 ),
        .Q(\TXDLYSRESET_reg[0]_0 ),
        .R(uclk_mgt_tx_reset));
  FDRE #(
    .INIT(1'b0)) 
    \TXDLYSRESET_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\TXDLYSRESET[1]_i_1_n_0 ),
        .Q(gt1_txdlysreset_in),
        .R(uclk_mgt_tx_reset));
  FDRE #(
    .INIT(1'b0)) 
    \TXDLYSRESET_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\TXDLYSRESET[2]_i_1_n_0 ),
        .Q(gt2_txdlysreset_in),
        .R(uclk_mgt_tx_reset));
  FDRE #(
    .INIT(1'b0)) 
    \TXDLYSRESET_reg[3] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\TXDLYSRESET[3]_i_1_n_0 ),
        .Q(gt3_txdlysreset_in),
        .R(uclk_mgt_tx_reset));
  LUT5 #(
    .INIT(32'hBB0FBB00)) 
    \TXPHALIGN[0]_i_1 
       (.I0(txphaligndone_prev[0]),
        .I1(txphaligndone_sync_0),
        .I2(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[6] ),
        .I3(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[3] ),
        .I4(\TXPHALIGN_reg[0]_0 ),
        .O(\TXPHALIGN[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h002E)) 
    \TXPHALIGN[1]_i_1 
       (.I0(gt1_txphalign_in),
        .I1(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[6] ),
        .I2(txphaligndone_store[1]),
        .I3(uclk_mgt_tx_reset),
        .O(\TXPHALIGN[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h002E)) 
    \TXPHALIGN[2]_i_1 
       (.I0(gt2_txphalign_in),
        .I1(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[6] ),
        .I2(txphaligndone_store[2]),
        .I3(uclk_mgt_tx_reset),
        .O(\TXPHALIGN[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h002E)) 
    \TXPHALIGN[3]_i_1 
       (.I0(gt3_txphalign_in),
        .I1(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[6] ),
        .I2(txphaligndone_store[3]),
        .I3(uclk_mgt_tx_reset),
        .O(\TXPHALIGN[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \TXPHALIGN_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\TXPHALIGN[0]_i_1_n_0 ),
        .Q(\TXPHALIGN_reg[0]_0 ),
        .R(uclk_mgt_tx_reset));
  FDRE #(
    .INIT(1'b0)) 
    \TXPHALIGN_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\TXPHALIGN[1]_i_1_n_0 ),
        .Q(gt1_txphalign_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \TXPHALIGN_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\TXPHALIGN[2]_i_1_n_0 ),
        .Q(gt2_txphalign_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \TXPHALIGN_reg[3] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\TXPHALIGN[3]_i_1_n_0 ),
        .Q(gt3_txphalign_in),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hBB0FBB00)) 
    \TXPHINIT[0]_i_1 
       (.I0(txphinitdone_prev[0]),
        .I1(txphinitdone_sync_0),
        .I2(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[5] ),
        .I3(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[2] ),
        .I4(\TXPHINIT_reg[0]_0 ),
        .O(\TXPHINIT[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h002E)) 
    \TXPHINIT[1]_i_1 
       (.I0(gt1_txphinit_in),
        .I1(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[5] ),
        .I2(txphinitdone_store_edge[1]),
        .I3(uclk_mgt_tx_reset),
        .O(\TXPHINIT[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h002E)) 
    \TXPHINIT[2]_i_1 
       (.I0(gt2_txphinit_in),
        .I1(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[5] ),
        .I2(txphinitdone_store_edge[2]),
        .I3(uclk_mgt_tx_reset),
        .O(\TXPHINIT[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h002E)) 
    \TXPHINIT[3]_i_1 
       (.I0(gt3_txphinit_in),
        .I1(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[5] ),
        .I2(txphinitdone_store_edge[3]),
        .I3(uclk_mgt_tx_reset),
        .O(\TXPHINIT[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \TXPHINIT_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\TXPHINIT[0]_i_1_n_0 ),
        .Q(\TXPHINIT_reg[0]_0 ),
        .R(uclk_mgt_tx_reset));
  FDRE #(
    .INIT(1'b0)) 
    \TXPHINIT_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\TXPHINIT[1]_i_1_n_0 ),
        .Q(gt1_txphinit_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \TXPHINIT_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\TXPHINIT[2]_i_1_n_0 ),
        .Q(gt2_txphinit_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \TXPHINIT_reg[3] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\TXPHINIT[3]_i_1_n_0 ),
        .Q(gt3_txphinit_in),
        .R(1'b0));
  xaui_xaui_gt_wrapper_tx_sync_manual_block \cdc[0].xaui_gt_wrapper_tx_sync_manual_TXDLYSRESETDONE 
       (.data_out(data_out2_out),
        .gt0_txdlysresetdone_out(gt0_txdlysresetdone_out),
        .uclk_mgt_rx_reset_reg(uclk_mgt_rx_reset_reg));
  xaui_xaui_gt_wrapper_tx_sync_manual_block_10 \cdc[0].xaui_gt_wrapper_tx_sync_manual_TXPHALIGNDONE 
       (.D({\FSM_onehot_tx_phalign_manual_state_reg_n_0_[7] ,\FSM_onehot_tx_phalign_manual_state_reg_n_0_[4] ,\FSM_onehot_tx_phalign_manual_state_reg_n_0_[3] }),
        .E(\cdc[0].xaui_gt_wrapper_tx_sync_manual_TXPHALIGNDONE_n_0 ),
        .\FSM_onehot_tx_phalign_manual_state_reg[0] (\FSM_onehot_tx_phalign_manual_state[8]_i_7_n_0 ),
        .\FSM_onehot_tx_phalign_manual_state_reg[1] (\FSM_onehot_tx_phalign_manual_state[8]_i_6_n_0 ),
        .\FSM_onehot_tx_phalign_manual_state_reg[2] (\cdc[0].xaui_gt_wrapper_tx_sync_manual_TXPHINITDONE_n_1 ),
        .\FSM_onehot_tx_phalign_manual_state_reg[5] (\FSM_onehot_tx_phalign_manual_state[8]_i_4_n_0 ),
        .\FSM_onehot_tx_phalign_manual_state_reg[6] (\FSM_onehot_tx_phalign_manual_state[8]_i_3_n_0 ),
        .Q(txphaligndone_prev[0]),
        .data_out(txphaligndone_sync_0),
        .gt0_txphaligndone_out(gt0_txphaligndone_out),
        .uclk_mgt_rx_reset_reg(uclk_mgt_rx_reset_reg));
  xaui_xaui_gt_wrapper_tx_sync_manual_sync_pulse \cdc[0].xaui_gt_wrapper_tx_sync_manual_TXPHINITDONE 
       (.D(\FSM_onehot_tx_phalign_manual_state_reg_n_0_[2] ),
        .\FSM_onehot_tx_phalign_manual_state_reg[0] (\cdc[0].xaui_gt_wrapper_tx_sync_manual_TXPHINITDONE_n_1 ),
        .Q(txphinitdone_prev[0]),
        .gt0_txphinitdone_out(gt0_txphinitdone_out),
        .txphinitdone_sync_0(txphinitdone_sync_0),
        .uclk_mgt_rx_reset_reg(uclk_mgt_rx_reset_reg));
  xaui_xaui_gt_wrapper_tx_sync_manual_block_11 \cdc[1].xaui_gt_wrapper_tx_sync_manual_TXDLYSRESETDONE 
       (.data_out(data_out1_out),
        .gt1_txdlysresetdone_out(gt1_txdlysresetdone_out),
        .uclk_mgt_rx_reset_reg(uclk_mgt_rx_reset_reg));
  xaui_xaui_gt_wrapper_tx_sync_manual_block_12 \cdc[1].xaui_gt_wrapper_tx_sync_manual_TXPHALIGNDONE 
       (.data_out(txphaligndone_sync_1),
        .gt1_txphaligndone_out(gt1_txphaligndone_out),
        .uclk_mgt_rx_reset_reg(uclk_mgt_rx_reset_reg));
  xaui_xaui_gt_wrapper_tx_sync_manual_sync_pulse_13 \cdc[1].xaui_gt_wrapper_tx_sync_manual_TXPHINITDONE 
       (.D(txphinitdone_sync_1),
        .gt1_txphinitdone_out(gt1_txphinitdone_out),
        .uclk_mgt_rx_reset_reg(uclk_mgt_rx_reset_reg));
  xaui_xaui_gt_wrapper_tx_sync_manual_block_14 \cdc[2].xaui_gt_wrapper_tx_sync_manual_TXDLYSRESETDONE 
       (.data_out(data_out0_out),
        .gt2_txdlysresetdone_out(gt2_txdlysresetdone_out),
        .uclk_mgt_rx_reset_reg(uclk_mgt_rx_reset_reg));
  xaui_xaui_gt_wrapper_tx_sync_manual_block_15 \cdc[2].xaui_gt_wrapper_tx_sync_manual_TXPHALIGNDONE 
       (.data_out(txphaligndone_sync_2),
        .gt2_txphaligndone_out(gt2_txphaligndone_out),
        .uclk_mgt_rx_reset_reg(uclk_mgt_rx_reset_reg));
  xaui_xaui_gt_wrapper_tx_sync_manual_sync_pulse_16 \cdc[2].xaui_gt_wrapper_tx_sync_manual_TXPHINITDONE 
       (.D(txphinitdone_sync_2),
        .gt2_txphinitdone_out(gt2_txphinitdone_out),
        .uclk_mgt_rx_reset_reg(uclk_mgt_rx_reset_reg));
  xaui_xaui_gt_wrapper_tx_sync_manual_block_17 \cdc[3].xaui_gt_wrapper_tx_sync_manual_TXDLYSRESETDONE 
       (.data_out(txdlysresetdone_sync_3),
        .gt3_txdlysresetdone_out(gt3_txdlysresetdone_out),
        .uclk_mgt_rx_reset_reg(uclk_mgt_rx_reset_reg));
  xaui_xaui_gt_wrapper_tx_sync_manual_block_18 \cdc[3].xaui_gt_wrapper_tx_sync_manual_TXPHALIGNDONE 
       (.data_out(txphaligndone_sync_3),
        .gt3_txphaligndone_out(gt3_txphaligndone_out),
        .uclk_mgt_rx_reset_reg(uclk_mgt_rx_reset_reg));
  xaui_xaui_gt_wrapper_tx_sync_manual_sync_pulse_19 \cdc[3].xaui_gt_wrapper_tx_sync_manual_TXPHINITDONE 
       (.D(txphinitdone_sync_3),
        .gt3_txphinitdone_out(gt3_txphinitdone_out),
        .uclk_mgt_rx_reset_reg(uclk_mgt_rx_reset_reg));
  LUT2 #(
    .INIT(4'hE)) 
    \txdlysresetdone_store[0]_i_1 
       (.I0(data_out2_out),
        .I1(\txdlysresetdone_store_reg_n_0_[0] ),
        .O(\txdlysresetdone_store[0]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \txdlysresetdone_store[1]_i_1 
       (.I0(data_out1_out),
        .I1(\txdlysresetdone_store_reg_n_0_[1] ),
        .O(\txdlysresetdone_store[1]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \txdlysresetdone_store[2]_i_1 
       (.I0(data_out0_out),
        .I1(p_2_in),
        .O(\txdlysresetdone_store[2]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \txdlysresetdone_store[3]_i_1 
       (.I0(txdlysresetdone_sync_3),
        .I1(\txdlysresetdone_store_reg_n_0_[3] ),
        .O(\txdlysresetdone_store[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \txdlysresetdone_store_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\txdlysresetdone_store[0]_i_1_n_0 ),
        .Q(\txdlysresetdone_store_reg_n_0_[0] ),
        .R(txdone_clear_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \txdlysresetdone_store_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\txdlysresetdone_store[1]_i_1_n_0 ),
        .Q(\txdlysresetdone_store_reg_n_0_[1] ),
        .R(txdone_clear_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \txdlysresetdone_store_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\txdlysresetdone_store[2]_i_1_n_0 ),
        .Q(p_2_in),
        .R(txdone_clear_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \txdlysresetdone_store_reg[3] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\txdlysresetdone_store[3]_i_1_n_0 ),
        .Q(\txdlysresetdone_store_reg_n_0_[3] ),
        .R(txdone_clear_reg_n_0));
  LUT3 #(
    .INIT(8'h74)) 
    txdone_clear_i_1
       (.I0(uclk_txsync_start_phase_align_reg),
        .I1(txphinitdone_clear_slave),
        .I2(txdone_clear_reg_n_0),
        .O(txdone_clear_i_1_n_0));
  FDSE #(
    .INIT(1'b0)) 
    txdone_clear_reg
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(txdone_clear_i_1_n_0),
        .Q(txdone_clear_reg_n_0),
        .S(uclk_mgt_tx_reset));
  FDRE #(
    .INIT(1'b0)) 
    \txphaligndone_prev_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(txphaligndone_sync_0),
        .Q(txphaligndone_prev[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txphaligndone_prev_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(txphaligndone_sync_1),
        .Q(txphaligndone_prev[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txphaligndone_prev_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(txphaligndone_sync_2),
        .Q(txphaligndone_prev[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txphaligndone_prev_reg[3] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(txphaligndone_sync_3),
        .Q(txphaligndone_prev[3]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hF2)) 
    \txphaligndone_store[0]_i_1 
       (.I0(txphaligndone_sync_0),
        .I1(txphaligndone_prev[0]),
        .I2(txphaligndone_store[0]),
        .O(\txphaligndone_store[0]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hF2)) 
    \txphaligndone_store[1]_i_1 
       (.I0(txphaligndone_sync_1),
        .I1(txphaligndone_prev[1]),
        .I2(txphaligndone_store[1]),
        .O(\txphaligndone_store[1]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hF2)) 
    \txphaligndone_store[2]_i_1 
       (.I0(txphaligndone_sync_2),
        .I1(txphaligndone_prev[2]),
        .I2(txphaligndone_store[2]),
        .O(\txphaligndone_store[2]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hF2)) 
    \txphaligndone_store[3]_i_1 
       (.I0(txphaligndone_sync_3),
        .I1(txphaligndone_prev[3]),
        .I2(txphaligndone_store[3]),
        .O(\txphaligndone_store[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \txphaligndone_store_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\txphaligndone_store[0]_i_1_n_0 ),
        .Q(txphaligndone_store[0]),
        .R(txdone_clear_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \txphaligndone_store_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\txphaligndone_store[1]_i_1_n_0 ),
        .Q(txphaligndone_store[1]),
        .R(txdone_clear_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \txphaligndone_store_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\txphaligndone_store[2]_i_1_n_0 ),
        .Q(txphaligndone_store[2]),
        .R(txdone_clear_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \txphaligndone_store_reg[3] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\txphaligndone_store[3]_i_1_n_0 ),
        .Q(txphaligndone_store[3]),
        .R(txdone_clear_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \txphinitdone_prev_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(txphinitdone_sync_0),
        .Q(txphinitdone_prev[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txphinitdone_prev_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(txphinitdone_sync_1),
        .Q(txphinitdone_prev[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txphinitdone_prev_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(txphinitdone_sync_2),
        .Q(txphinitdone_prev[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txphinitdone_prev_reg[3] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(txphinitdone_sync_3),
        .Q(txphinitdone_prev[3]),
        .R(1'b0));
  LUT4 #(
    .INIT(16'hFFAE)) 
    \txphinitdone_store_edge[0]_i_1 
       (.I0(txphinitdone_store_edge[0]),
        .I1(txphinitdone_sync_0),
        .I2(txphinitdone_prev[0]),
        .I3(txdone_clear_reg_n_0),
        .O(\txphinitdone_store_edge[0]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hF2)) 
    \txphinitdone_store_edge[1]_i_1 
       (.I0(txphinitdone_sync_1),
        .I1(txphinitdone_prev[1]),
        .I2(txphinitdone_store_edge[1]),
        .O(\txphinitdone_store_edge[1]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hF2)) 
    \txphinitdone_store_edge[2]_i_1 
       (.I0(txphinitdone_sync_2),
        .I1(txphinitdone_prev[2]),
        .I2(txphinitdone_store_edge[2]),
        .O(\txphinitdone_store_edge[2]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hF2)) 
    \txphinitdone_store_edge[3]_i_1 
       (.I0(txphinitdone_sync_3),
        .I1(txphinitdone_prev[3]),
        .I2(txphinitdone_store_edge[3]),
        .O(\txphinitdone_store_edge[3]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \txphinitdone_store_edge_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\txphinitdone_store_edge[0]_i_1_n_0 ),
        .Q(txphinitdone_store_edge[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txphinitdone_store_edge_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\txphinitdone_store_edge[1]_i_1_n_0 ),
        .Q(txphinitdone_store_edge[1]),
        .R(txdone_clear_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \txphinitdone_store_edge_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\txphinitdone_store_edge[2]_i_1_n_0 ),
        .Q(txphinitdone_store_edge[2]),
        .R(txdone_clear_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \txphinitdone_store_edge_reg[3] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\txphinitdone_store_edge[3]_i_1_n_0 ),
        .Q(txphinitdone_store_edge[3]),
        .R(txdone_clear_reg_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    xaui_core_i_9
       (.I0(debug),
        .O(mgt_tx_reset));
endmodule

(* ORIG_REF_NAME = "xaui_gt_wrapper_tx_sync_manual_block" *) 
module xaui_xaui_gt_wrapper_tx_sync_manual_block
   (data_out,
    gt0_txdlysresetdone_out,
    uclk_mgt_rx_reset_reg);
  output data_out;
  input gt0_txdlysresetdone_out;
  input uclk_mgt_rx_reset_reg;

  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt0_txdlysresetdone_out;
  wire uclk_mgt_rx_reset_reg;

  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg1
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(gt0_txdlysresetdone_out),
        .Q(data_sync1),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg2
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg3
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg4
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg5
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg6
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_gt_wrapper_tx_sync_manual_block" *) 
module xaui_xaui_gt_wrapper_tx_sync_manual_block_10
   (E,
    data_out,
    \FSM_onehot_tx_phalign_manual_state_reg[6] ,
    \FSM_onehot_tx_phalign_manual_state_reg[5] ,
    \FSM_onehot_tx_phalign_manual_state_reg[2] ,
    \FSM_onehot_tx_phalign_manual_state_reg[1] ,
    \FSM_onehot_tx_phalign_manual_state_reg[0] ,
    Q,
    D,
    gt0_txphaligndone_out,
    uclk_mgt_rx_reset_reg);
  output [0:0]E;
  output data_out;
  input \FSM_onehot_tx_phalign_manual_state_reg[6] ;
  input \FSM_onehot_tx_phalign_manual_state_reg[5] ;
  input \FSM_onehot_tx_phalign_manual_state_reg[2] ;
  input \FSM_onehot_tx_phalign_manual_state_reg[1] ;
  input \FSM_onehot_tx_phalign_manual_state_reg[0] ;
  input [0:0]Q;
  input [2:0]D;
  input gt0_txphaligndone_out;
  input uclk_mgt_rx_reset_reg;

  wire [2:0]D;
  wire [0:0]E;
  wire \FSM_onehot_tx_phalign_manual_state[8]_i_2_n_0 ;
  wire \FSM_onehot_tx_phalign_manual_state_reg[0] ;
  wire \FSM_onehot_tx_phalign_manual_state_reg[1] ;
  wire \FSM_onehot_tx_phalign_manual_state_reg[2] ;
  wire \FSM_onehot_tx_phalign_manual_state_reg[5] ;
  wire \FSM_onehot_tx_phalign_manual_state_reg[6] ;
  wire [0:0]Q;
  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt0_txphaligndone_out;
  wire uclk_mgt_rx_reset_reg;

  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \FSM_onehot_tx_phalign_manual_state[8]_i_1 
       (.I0(\FSM_onehot_tx_phalign_manual_state[8]_i_2_n_0 ),
        .I1(\FSM_onehot_tx_phalign_manual_state_reg[6] ),
        .I2(\FSM_onehot_tx_phalign_manual_state_reg[5] ),
        .I3(\FSM_onehot_tx_phalign_manual_state_reg[2] ),
        .I4(\FSM_onehot_tx_phalign_manual_state_reg[1] ),
        .I5(\FSM_onehot_tx_phalign_manual_state_reg[0] ),
        .O(E));
  LUT5 #(
    .INIT(32'h44444440)) 
    \FSM_onehot_tx_phalign_manual_state[8]_i_2 
       (.I0(Q),
        .I1(data_out),
        .I2(D[0]),
        .I3(D[1]),
        .I4(D[2]),
        .O(\FSM_onehot_tx_phalign_manual_state[8]_i_2_n_0 ));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg1
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(gt0_txphaligndone_out),
        .Q(data_sync1),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg2
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg3
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg4
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg5
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg6
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_gt_wrapper_tx_sync_manual_block" *) 
module xaui_xaui_gt_wrapper_tx_sync_manual_block_11
   (data_out,
    gt1_txdlysresetdone_out,
    uclk_mgt_rx_reset_reg);
  output data_out;
  input gt1_txdlysresetdone_out;
  input uclk_mgt_rx_reset_reg;

  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt1_txdlysresetdone_out;
  wire uclk_mgt_rx_reset_reg;

  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg1
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(gt1_txdlysresetdone_out),
        .Q(data_sync1),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg2
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg3
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg4
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg5
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg6
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_gt_wrapper_tx_sync_manual_block" *) 
module xaui_xaui_gt_wrapper_tx_sync_manual_block_12
   (data_out,
    gt1_txphaligndone_out,
    uclk_mgt_rx_reset_reg);
  output data_out;
  input gt1_txphaligndone_out;
  input uclk_mgt_rx_reset_reg;

  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt1_txphaligndone_out;
  wire uclk_mgt_rx_reset_reg;

  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg1
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(gt1_txphaligndone_out),
        .Q(data_sync1),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg2
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg3
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg4
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg5
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg6
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_gt_wrapper_tx_sync_manual_block" *) 
module xaui_xaui_gt_wrapper_tx_sync_manual_block_14
   (data_out,
    gt2_txdlysresetdone_out,
    uclk_mgt_rx_reset_reg);
  output data_out;
  input gt2_txdlysresetdone_out;
  input uclk_mgt_rx_reset_reg;

  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt2_txdlysresetdone_out;
  wire uclk_mgt_rx_reset_reg;

  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg1
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(gt2_txdlysresetdone_out),
        .Q(data_sync1),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg2
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg3
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg4
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg5
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg6
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_gt_wrapper_tx_sync_manual_block" *) 
module xaui_xaui_gt_wrapper_tx_sync_manual_block_15
   (data_out,
    gt2_txphaligndone_out,
    uclk_mgt_rx_reset_reg);
  output data_out;
  input gt2_txphaligndone_out;
  input uclk_mgt_rx_reset_reg;

  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt2_txphaligndone_out;
  wire uclk_mgt_rx_reset_reg;

  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg1
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(gt2_txphaligndone_out),
        .Q(data_sync1),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg2
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg3
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg4
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg5
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg6
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_gt_wrapper_tx_sync_manual_block" *) 
module xaui_xaui_gt_wrapper_tx_sync_manual_block_17
   (data_out,
    gt3_txdlysresetdone_out,
    uclk_mgt_rx_reset_reg);
  output data_out;
  input gt3_txdlysresetdone_out;
  input uclk_mgt_rx_reset_reg;

  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt3_txdlysresetdone_out;
  wire uclk_mgt_rx_reset_reg;

  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg1
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(gt3_txdlysresetdone_out),
        .Q(data_sync1),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg2
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg3
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg4
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg5
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg6
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_gt_wrapper_tx_sync_manual_block" *) 
module xaui_xaui_gt_wrapper_tx_sync_manual_block_18
   (data_out,
    gt3_txphaligndone_out,
    uclk_mgt_rx_reset_reg);
  output data_out;
  input gt3_txphaligndone_out;
  input uclk_mgt_rx_reset_reg;

  wire data_out;
  wire data_sync1;
  wire data_sync2;
  wire data_sync3;
  wire data_sync4;
  wire data_sync5;
  wire gt3_txphaligndone_out;
  wire uclk_mgt_rx_reset_reg;

  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg1
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(gt3_txphaligndone_out),
        .Q(data_sync1),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg2
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync1),
        .Q(data_sync2),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg3
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync2),
        .Q(data_sync3),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg4
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync3),
        .Q(data_sync4),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg5
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync4),
        .Q(data_sync5),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* SHREG_EXTRACT = "no" *) 
  (* XILINX_LEGACY_PRIM = "FD" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    data_sync_reg6
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(data_sync5),
        .Q(data_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_gt_wrapper_tx_sync_manual_sync_pulse" *) 
module xaui_xaui_gt_wrapper_tx_sync_manual_sync_pulse
   (txphinitdone_sync_0,
    \FSM_onehot_tx_phalign_manual_state_reg[0] ,
    uclk_mgt_rx_reset_reg,
    D,
    Q,
    gt0_txphinitdone_out);
  output txphinitdone_sync_0;
  output \FSM_onehot_tx_phalign_manual_state_reg[0] ;
  input uclk_mgt_rx_reset_reg;
  input [0:0]D;
  input [0:0]Q;
  input gt0_txphinitdone_out;

  wire [0:0]D;
  wire \FSM_onehot_tx_phalign_manual_state_reg[0] ;
  wire [0:0]Q;
  wire USER_DONE_i_1_n_0;
  wire gt0_txphinitdone_out;
  wire [2:0]stretch_r;
  wire \stretch_r[2]_i_1_n_0 ;
  (* async_reg = "true" *) (* shreg_extract = "no" *) wire [2:0]sync1_r;
  (* async_reg = "true" *) (* shreg_extract = "no" *) wire [2:0]sync2_r;
  wire txphinitdone_sync_0;
  wire uclk_mgt_rx_reset_reg;

  LUT3 #(
    .INIT(8'h20)) 
    \FSM_onehot_tx_phalign_manual_state[8]_i_5 
       (.I0(D),
        .I1(Q),
        .I2(txphinitdone_sync_0),
        .O(\FSM_onehot_tx_phalign_manual_state_reg[0] ));
  LUT2 #(
    .INIT(4'h8)) 
    USER_DONE_i_1
       (.I0(sync1_r[0]),
        .I1(sync2_r[0]),
        .O(USER_DONE_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    USER_DONE_reg
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(USER_DONE_i_1_n_0),
        .Q(txphinitdone_sync_0),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \stretch_r[2]_i_1 
       (.I0(gt0_txphinitdone_out),
        .O(\stretch_r[2]_i_1_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \stretch_r_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .CLR(\stretch_r[2]_i_1_n_0 ),
        .D(stretch_r[1]),
        .Q(stretch_r[0]));
  FDCE #(
    .INIT(1'b0)) 
    \stretch_r_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .CLR(\stretch_r[2]_i_1_n_0 ),
        .D(stretch_r[2]),
        .Q(stretch_r[1]));
  FDCE #(
    .INIT(1'b0)) 
    \stretch_r_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .CLR(\stretch_r[2]_i_1_n_0 ),
        .D(1'b1),
        .Q(stretch_r[2]));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync1_r[1]),
        .Q(sync1_r[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync1_r[2]),
        .Q(sync1_r[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(stretch_r[0]),
        .Q(sync1_r[2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync2_r_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync2_r[1]),
        .Q(sync2_r[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync2_r_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync2_r[2]),
        .Q(sync2_r[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync2_r_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(gt0_txphinitdone_out),
        .Q(sync2_r[2]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_gt_wrapper_tx_sync_manual_sync_pulse" *) 
module xaui_xaui_gt_wrapper_tx_sync_manual_sync_pulse_13
   (D,
    uclk_mgt_rx_reset_reg,
    gt1_txphinitdone_out);
  output [0:0]D;
  input uclk_mgt_rx_reset_reg;
  input gt1_txphinitdone_out;

  wire [0:0]D;
  wire USER_DONE_i_1__0_n_0;
  wire gt1_txphinitdone_out;
  wire \stretch_r[2]_i_1_n_0 ;
  wire \stretch_r_reg_n_0_[0] ;
  wire \stretch_r_reg_n_0_[1] ;
  wire \stretch_r_reg_n_0_[2] ;
  (* async_reg = "true" *) (* shreg_extract = "no" *) wire [2:0]sync1_r;
  (* async_reg = "true" *) (* shreg_extract = "no" *) wire [2:0]sync2_r;
  wire uclk_mgt_rx_reset_reg;

  LUT2 #(
    .INIT(4'h8)) 
    USER_DONE_i_1__0
       (.I0(sync1_r[0]),
        .I1(sync2_r[0]),
        .O(USER_DONE_i_1__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    USER_DONE_reg
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(USER_DONE_i_1__0_n_0),
        .Q(D),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \stretch_r[2]_i_1 
       (.I0(gt1_txphinitdone_out),
        .O(\stretch_r[2]_i_1_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \stretch_r_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .CLR(\stretch_r[2]_i_1_n_0 ),
        .D(\stretch_r_reg_n_0_[1] ),
        .Q(\stretch_r_reg_n_0_[0] ));
  FDCE #(
    .INIT(1'b0)) 
    \stretch_r_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .CLR(\stretch_r[2]_i_1_n_0 ),
        .D(\stretch_r_reg_n_0_[2] ),
        .Q(\stretch_r_reg_n_0_[1] ));
  FDCE #(
    .INIT(1'b0)) 
    \stretch_r_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .CLR(\stretch_r[2]_i_1_n_0 ),
        .D(1'b1),
        .Q(\stretch_r_reg_n_0_[2] ));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync1_r[1]),
        .Q(sync1_r[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync1_r[2]),
        .Q(sync1_r[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\stretch_r_reg_n_0_[0] ),
        .Q(sync1_r[2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync2_r_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync2_r[1]),
        .Q(sync2_r[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync2_r_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync2_r[2]),
        .Q(sync2_r[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync2_r_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(gt1_txphinitdone_out),
        .Q(sync2_r[2]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_gt_wrapper_tx_sync_manual_sync_pulse" *) 
module xaui_xaui_gt_wrapper_tx_sync_manual_sync_pulse_16
   (D,
    uclk_mgt_rx_reset_reg,
    gt2_txphinitdone_out);
  output [0:0]D;
  input uclk_mgt_rx_reset_reg;
  input gt2_txphinitdone_out;

  wire [0:0]D;
  wire USER_DONE_i_1__1_n_0;
  wire gt2_txphinitdone_out;
  wire \stretch_r[2]_i_1_n_0 ;
  wire \stretch_r_reg_n_0_[0] ;
  wire \stretch_r_reg_n_0_[1] ;
  wire \stretch_r_reg_n_0_[2] ;
  (* async_reg = "true" *) (* shreg_extract = "no" *) wire [2:0]sync1_r;
  (* async_reg = "true" *) (* shreg_extract = "no" *) wire [2:0]sync2_r;
  wire uclk_mgt_rx_reset_reg;

  LUT2 #(
    .INIT(4'h8)) 
    USER_DONE_i_1__1
       (.I0(sync1_r[0]),
        .I1(sync2_r[0]),
        .O(USER_DONE_i_1__1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    USER_DONE_reg
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(USER_DONE_i_1__1_n_0),
        .Q(D),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \stretch_r[2]_i_1 
       (.I0(gt2_txphinitdone_out),
        .O(\stretch_r[2]_i_1_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \stretch_r_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .CLR(\stretch_r[2]_i_1_n_0 ),
        .D(\stretch_r_reg_n_0_[1] ),
        .Q(\stretch_r_reg_n_0_[0] ));
  FDCE #(
    .INIT(1'b0)) 
    \stretch_r_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .CLR(\stretch_r[2]_i_1_n_0 ),
        .D(\stretch_r_reg_n_0_[2] ),
        .Q(\stretch_r_reg_n_0_[1] ));
  FDCE #(
    .INIT(1'b0)) 
    \stretch_r_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .CLR(\stretch_r[2]_i_1_n_0 ),
        .D(1'b1),
        .Q(\stretch_r_reg_n_0_[2] ));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync1_r[1]),
        .Q(sync1_r[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync1_r[2]),
        .Q(sync1_r[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\stretch_r_reg_n_0_[0] ),
        .Q(sync1_r[2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync2_r_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync2_r[1]),
        .Q(sync2_r[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync2_r_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync2_r[2]),
        .Q(sync2_r[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync2_r_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(gt2_txphinitdone_out),
        .Q(sync2_r[2]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_gt_wrapper_tx_sync_manual_sync_pulse" *) 
module xaui_xaui_gt_wrapper_tx_sync_manual_sync_pulse_19
   (D,
    uclk_mgt_rx_reset_reg,
    gt3_txphinitdone_out);
  output [0:0]D;
  input uclk_mgt_rx_reset_reg;
  input gt3_txphinitdone_out;

  wire [0:0]D;
  wire USER_DONE_i_1__2_n_0;
  wire gt3_txphinitdone_out;
  wire \stretch_r[2]_i_1_n_0 ;
  wire \stretch_r_reg_n_0_[0] ;
  wire \stretch_r_reg_n_0_[1] ;
  wire \stretch_r_reg_n_0_[2] ;
  (* async_reg = "true" *) (* shreg_extract = "no" *) wire [2:0]sync1_r;
  (* async_reg = "true" *) (* shreg_extract = "no" *) wire [2:0]sync2_r;
  wire uclk_mgt_rx_reset_reg;

  LUT2 #(
    .INIT(4'h8)) 
    USER_DONE_i_1__2
       (.I0(sync1_r[0]),
        .I1(sync2_r[0]),
        .O(USER_DONE_i_1__2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    USER_DONE_reg
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(USER_DONE_i_1__2_n_0),
        .Q(D),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \stretch_r[2]_i_1 
       (.I0(gt3_txphinitdone_out),
        .O(\stretch_r[2]_i_1_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \stretch_r_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .CLR(\stretch_r[2]_i_1_n_0 ),
        .D(\stretch_r_reg_n_0_[1] ),
        .Q(\stretch_r_reg_n_0_[0] ));
  FDCE #(
    .INIT(1'b0)) 
    \stretch_r_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .CLR(\stretch_r[2]_i_1_n_0 ),
        .D(\stretch_r_reg_n_0_[2] ),
        .Q(\stretch_r_reg_n_0_[1] ));
  FDCE #(
    .INIT(1'b0)) 
    \stretch_r_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .CLR(\stretch_r[2]_i_1_n_0 ),
        .D(1'b1),
        .Q(\stretch_r_reg_n_0_[2] ));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync1_r[1]),
        .Q(sync1_r[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync1_r[2]),
        .Q(sync1_r[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync1_r_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(\stretch_r_reg_n_0_[0] ),
        .Q(sync1_r[2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync2_r_reg[0] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync2_r[1]),
        .Q(sync2_r[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync2_r_reg[1] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(sync2_r[2]),
        .Q(sync2_r[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  (* SHREG_EXTRACT = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \sync2_r_reg[2] 
       (.C(uclk_mgt_rx_reset_reg),
        .CE(1'b1),
        .D(gt3_txphinitdone_out),
        .Q(sync2_r[2]),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_reset_counter" *) 
module xaui_xaui_reset_counter
   (D,
    gt0_qpllreset_in,
    dclk,
    out);
  output [0:0]D;
  output gt0_qpllreset_in;
  input dclk;
  input [0:0]out;

  wire [0:0]D;
  wire \count[7]_i_3_n_0 ;
  wire count_d1;
  wire \count_reg_n_0_[0] ;
  wire \count_reg_n_0_[1] ;
  wire \count_reg_n_0_[2] ;
  wire \count_reg_n_0_[3] ;
  wire \count_reg_n_0_[4] ;
  wire \count_reg_n_0_[5] ;
  wire \count_reg_n_0_[6] ;
  wire dclk;
  wire gt0_qpllreset_in;
  wire initial_reset;
  wire initial_reset_i_1_n_0;
  wire [0:0]out;
  wire [7:0]plusOp;
  wire sel;

  LUT1 #(
    .INIT(2'h1)) 
    \count[0]_i_1 
       (.I0(\count_reg_n_0_[0] ),
        .O(plusOp[0]));
  (* SOFT_HLUTNM = "soft_lutpair91" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \count[1]_i_1 
       (.I0(\count_reg_n_0_[0] ),
        .I1(\count_reg_n_0_[1] ),
        .O(plusOp[1]));
  (* SOFT_HLUTNM = "soft_lutpair91" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \count[2]_i_1 
       (.I0(\count_reg_n_0_[0] ),
        .I1(\count_reg_n_0_[1] ),
        .I2(\count_reg_n_0_[2] ),
        .O(plusOp[2]));
  (* SOFT_HLUTNM = "soft_lutpair90" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \count[3]_i_1 
       (.I0(\count_reg_n_0_[1] ),
        .I1(\count_reg_n_0_[0] ),
        .I2(\count_reg_n_0_[2] ),
        .I3(\count_reg_n_0_[3] ),
        .O(plusOp[3]));
  (* SOFT_HLUTNM = "soft_lutpair90" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \count[4]_i_1 
       (.I0(\count_reg_n_0_[2] ),
        .I1(\count_reg_n_0_[0] ),
        .I2(\count_reg_n_0_[1] ),
        .I3(\count_reg_n_0_[3] ),
        .I4(\count_reg_n_0_[4] ),
        .O(plusOp[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \count[5]_i_1 
       (.I0(\count_reg_n_0_[3] ),
        .I1(\count_reg_n_0_[1] ),
        .I2(\count_reg_n_0_[0] ),
        .I3(\count_reg_n_0_[2] ),
        .I4(\count_reg_n_0_[4] ),
        .I5(\count_reg_n_0_[5] ),
        .O(plusOp[5]));
  (* SOFT_HLUTNM = "soft_lutpair93" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \count[6]_i_1 
       (.I0(\count[7]_i_3_n_0 ),
        .I1(\count_reg_n_0_[6] ),
        .O(plusOp[6]));
  LUT1 #(
    .INIT(2'h1)) 
    \count[7]_i_1 
       (.I0(D),
        .O(sel));
  (* SOFT_HLUTNM = "soft_lutpair93" *) 
  LUT3 #(
    .INIT(8'hD2)) 
    \count[7]_i_2 
       (.I0(\count_reg_n_0_[6] ),
        .I1(\count[7]_i_3_n_0 ),
        .I2(D),
        .O(plusOp[7]));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \count[7]_i_3 
       (.I0(\count_reg_n_0_[5] ),
        .I1(\count_reg_n_0_[3] ),
        .I2(\count_reg_n_0_[1] ),
        .I3(\count_reg_n_0_[0] ),
        .I4(\count_reg_n_0_[2] ),
        .I5(\count_reg_n_0_[4] ),
        .O(\count[7]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    count_d1_reg
       (.C(dclk),
        .CE(1'b1),
        .D(D),
        .Q(count_d1),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[0] 
       (.C(dclk),
        .CE(sel),
        .D(plusOp[0]),
        .Q(\count_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[1] 
       (.C(dclk),
        .CE(sel),
        .D(plusOp[1]),
        .Q(\count_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[2] 
       (.C(dclk),
        .CE(sel),
        .D(plusOp[2]),
        .Q(\count_reg_n_0_[2] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[3] 
       (.C(dclk),
        .CE(sel),
        .D(plusOp[3]),
        .Q(\count_reg_n_0_[3] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[4] 
       (.C(dclk),
        .CE(sel),
        .D(plusOp[4]),
        .Q(\count_reg_n_0_[4] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[5] 
       (.C(dclk),
        .CE(sel),
        .D(plusOp[5]),
        .Q(\count_reg_n_0_[5] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[6] 
       (.C(dclk),
        .CE(sel),
        .D(plusOp[6]),
        .Q(\count_reg_n_0_[6] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[7] 
       (.C(dclk),
        .CE(sel),
        .D(plusOp[7]),
        .Q(D),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair92" *) 
  LUT3 #(
    .INIT(8'hF8)) 
    gtxe2_common_0_i_i_1
       (.I0(D),
        .I1(out),
        .I2(initial_reset),
        .O(gt0_qpllreset_in));
  (* SOFT_HLUTNM = "soft_lutpair92" *) 
  LUT2 #(
    .INIT(4'h2)) 
    initial_reset_i_1
       (.I0(D),
        .I1(count_d1),
        .O(initial_reset_i_1_n_0));
  FDRE initial_reset_reg
       (.C(dclk),
        .CE(1'b1),
        .D(initial_reset_i_1_n_0),
        .Q(initial_reset),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xaui_v12_2_3_top" *) (* c_family = "kintex7" *) (* c_has_mdio = "FALSE" *) 
(* c_is_dxaui = "FALSE" *) 
module xaui_xaui_v12_2_3_top
   (reset,
    xgmii_txd,
    xgmii_txc,
    xgmii_rxd,
    xgmii_rxc,
    usrclk,
    mgt_txdata,
    mgt_txcharisk,
    mgt_rxdata,
    mgt_rxcharisk,
    mgt_codevalid,
    mgt_codecomma,
    mgt_enable_align,
    mgt_enchansync,
    mgt_rxlock,
    mgt_loopback,
    mgt_powerdown,
    mgt_tx_reset,
    mgt_rx_reset,
    soft_reset,
    signal_detect,
    align_status,
    sync_status,
    mdc,
    mdio_in,
    mdio_out,
    mdio_tri,
    type_sel,
    prtad,
    configuration_vector,
    status_vector);
  input reset;
  input [63:0]xgmii_txd;
  input [7:0]xgmii_txc;
  output [63:0]xgmii_rxd;
  output [7:0]xgmii_rxc;
  input usrclk;
  output [63:0]mgt_txdata;
  output [7:0]mgt_txcharisk;
  input [63:0]mgt_rxdata;
  input [7:0]mgt_rxcharisk;
  input [7:0]mgt_codevalid;
  input [7:0]mgt_codecomma;
  output [3:0]mgt_enable_align;
  output mgt_enchansync;
  input [3:0]mgt_rxlock;
  output mgt_loopback;
  output mgt_powerdown;
  input [3:0]mgt_tx_reset;
  input [3:0]mgt_rx_reset;
  output soft_reset;
  input [3:0]signal_detect;
  output align_status;
  output [3:0]sync_status;
  input mdc;
  input mdio_in;
  output mdio_out;
  output mdio_tri;
  input [1:0]type_sel;
  input [4:0]prtad;
  input [6:0]configuration_vector;
  (* keep = "true" *) output [7:0]status_vector;

  wire \<const0> ;
  wire [6:2]\^configuration_vector ;
  wire [7:0]mgt_codecomma;
  wire [7:0]mgt_codevalid;
  wire [3:0]mgt_enable_align;
  wire mgt_enchansync;
  (* RTL_KEEP = "true" *) wire mgt_loopback_keep;
  (* RTL_KEEP = "true" *) wire mgt_powerdown_keep;
  wire [3:0]mgt_rx_reset;
  wire [7:0]mgt_rxcharisk;
  wire [63:0]mgt_rxdata;
  wire [3:0]mgt_rxlock;
  wire [3:0]mgt_tx_reset;
  wire [7:0]mgt_txcharisk;
  wire [63:0]mgt_txdata;
  wire reset;
  wire [3:0]signal_detect;
  (* RTL_KEEP = "true" *) wire [7:0]status_vector;
  (* RTL_KEEP = "true" *) wire [7:0]status_vector_int;
  wire usrclk;
  wire [7:0]xgmii_rxc;
  wire [63:0]xgmii_rxd;
  wire [7:0]xgmii_txc;
  wire [63:0]xgmii_txd;

  assign \^configuration_vector [6:2] = configuration_vector[6:2];
  assign align_status = status_vector_int[6];
  assign mdio_out = \<const0> ;
  assign mdio_tri = \<const0> ;
  assign mgt_loopback = mgt_loopback_keep;
  assign mgt_loopback_keep = configuration_vector[0];
  assign mgt_powerdown = mgt_powerdown_keep;
  assign mgt_powerdown_keep = configuration_vector[1];
  assign soft_reset = \<const0> ;
  assign sync_status[3:0] = status_vector_int[5:2];
  GND GND
       (.G(\<const0> ));
  LUT1 #(
    .INIT(2'h2)) 
    i_0
       (.I0(status_vector_int[7]),
        .O(status_vector[7]));
  LUT1 #(
    .INIT(2'h2)) 
    i_1
       (.I0(status_vector_int[6]),
        .O(status_vector[6]));
  LUT1 #(
    .INIT(2'h2)) 
    i_2
       (.I0(status_vector_int[5]),
        .O(status_vector[5]));
  LUT1 #(
    .INIT(2'h2)) 
    i_3
       (.I0(status_vector_int[4]),
        .O(status_vector[4]));
  LUT1 #(
    .INIT(2'h2)) 
    i_4
       (.I0(status_vector_int[3]),
        .O(status_vector[3]));
  LUT1 #(
    .INIT(2'h2)) 
    i_5
       (.I0(status_vector_int[2]),
        .O(status_vector[2]));
  LUT1 #(
    .INIT(2'h2)) 
    i_6
       (.I0(status_vector_int[1]),
        .O(status_vector[1]));
  LUT1 #(
    .INIT(2'h2)) 
    i_7
       (.I0(status_vector_int[0]),
        .O(status_vector[0]));
  xaui_xaui_gen xaui_inst
       (.configuration_vector(\^configuration_vector ),
        .in0(status_vector_int),
        .mgt_codecomma(mgt_codecomma),
        .mgt_codevalid(mgt_codevalid),
        .mgt_enable_align(mgt_enable_align),
        .mgt_enchansync(mgt_enchansync),
        .mgt_rx_reset(mgt_rx_reset),
        .mgt_rxcharisk(mgt_rxcharisk),
        .mgt_rxdata(mgt_rxdata),
        .mgt_rxlock(mgt_rxlock),
        .mgt_tx_reset(mgt_tx_reset),
        .mgt_txcharisk(mgt_txcharisk),
        .mgt_txdata(mgt_txdata),
        .reset(reset),
        .signal_detect(signal_detect),
        .usrclk(usrclk),
        .xgmii_rxc(xgmii_rxc),
        .xgmii_rxd(xgmii_rxd),
        .xgmii_txc(xgmii_txc),
        .xgmii_txd(xgmii_txd));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
