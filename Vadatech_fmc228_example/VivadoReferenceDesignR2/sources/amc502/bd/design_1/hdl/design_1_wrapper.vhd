--Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
--Date        : Tue Mar  9 19:59:00 2021
--Host        : mu2etest.fnal.gov running 64-bit Scientific Linux release 7.9 (Nitrogen)
--Command     : generate_target design_1_wrapper.bd
--Design      : design_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_wrapper is
  port (
    M00_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    REFCLK : in STD_LOGIC;
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_arid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_awid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    S_AXI_rid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_rlast : out STD_LOGIC;
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    S_AXI_wlast : in STD_LOGIC;
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    S_AXI_wvalid : in STD_LOGIC;
    UART_rxd : in STD_LOGIC;
    UART_txd : out STD_LOGIC;
    clk : in STD_LOGIC;
    dcm_locked : in STD_LOGIC;
    ext_reset_in : in STD_LOGIC;
    m00_axi_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 );
    mmcm_lock : out STD_LOGIC;
    pcie_7x_mgt_rxn : in STD_LOGIC_VECTOR ( 3 downto 0 );
    pcie_7x_mgt_rxp : in STD_LOGIC_VECTOR ( 3 downto 0 );
    pcie_7x_mgt_txn : out STD_LOGIC_VECTOR ( 3 downto 0 );
    pcie_7x_mgt_txp : out STD_LOGIC_VECTOR ( 3 downto 0 );
    pcie_axi_aclk_out : out STD_LOGIC;
    pcie_axi_aresetn : in STD_LOGIC
  );
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  port (
    UART_rxd : in STD_LOGIC;
    UART_txd : out STD_LOGIC;
    S_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_arid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_arready : out STD_LOGIC;
    S_AXI_arregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_arvalid : in STD_LOGIC;
    S_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_AXI_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_awid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    S_AXI_awready : out STD_LOGIC;
    S_AXI_awregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S_AXI_awvalid : in STD_LOGIC;
    S_AXI_bid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_bready : in STD_LOGIC;
    S_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_bvalid : out STD_LOGIC;
    S_AXI_rdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
    S_AXI_rid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    S_AXI_rlast : out STD_LOGIC;
    S_AXI_rready : in STD_LOGIC;
    S_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S_AXI_rvalid : out STD_LOGIC;
    S_AXI_wdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
    S_AXI_wlast : in STD_LOGIC;
    S_AXI_wready : out STD_LOGIC;
    S_AXI_wstrb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    S_AXI_wvalid : in STD_LOGIC;
    pcie_7x_mgt_rxn : in STD_LOGIC_VECTOR ( 3 downto 0 );
    pcie_7x_mgt_rxp : in STD_LOGIC_VECTOR ( 3 downto 0 );
    pcie_7x_mgt_txn : out STD_LOGIC_VECTOR ( 3 downto 0 );
    pcie_7x_mgt_txp : out STD_LOGIC_VECTOR ( 3 downto 0 );
    clk : in STD_LOGIC;
    dcm_locked : in STD_LOGIC;
    ext_reset_in : in STD_LOGIC;
    m00_axi_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 );
    mmcm_lock : out STD_LOGIC;
    pcie_axi_aclk_out : out STD_LOGIC;
    pcie_axi_aresetn : in STD_LOGIC;
    REFCLK : in STD_LOGIC;
    M00_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    M00_AXI_rready : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component design_1;
begin
design_1_i: component design_1
     port map (
      M00_AXI_araddr(31 downto 0) => M00_AXI_araddr(31 downto 0),
      M00_AXI_arprot(2 downto 0) => M00_AXI_arprot(2 downto 0),
      M00_AXI_arready(0) => M00_AXI_arready(0),
      M00_AXI_arvalid(0) => M00_AXI_arvalid(0),
      M00_AXI_awaddr(31 downto 0) => M00_AXI_awaddr(31 downto 0),
      M00_AXI_awprot(2 downto 0) => M00_AXI_awprot(2 downto 0),
      M00_AXI_awready(0) => M00_AXI_awready(0),
      M00_AXI_awvalid(0) => M00_AXI_awvalid(0),
      M00_AXI_bready(0) => M00_AXI_bready(0),
      M00_AXI_bresp(1 downto 0) => M00_AXI_bresp(1 downto 0),
      M00_AXI_bvalid(0) => M00_AXI_bvalid(0),
      M00_AXI_rdata(31 downto 0) => M00_AXI_rdata(31 downto 0),
      M00_AXI_rready(0) => M00_AXI_rready(0),
      M00_AXI_rresp(1 downto 0) => M00_AXI_rresp(1 downto 0),
      M00_AXI_rvalid(0) => M00_AXI_rvalid(0),
      M00_AXI_wdata(31 downto 0) => M00_AXI_wdata(31 downto 0),
      M00_AXI_wready(0) => M00_AXI_wready(0),
      M00_AXI_wstrb(3 downto 0) => M00_AXI_wstrb(3 downto 0),
      M00_AXI_wvalid(0) => M00_AXI_wvalid(0),
      REFCLK => REFCLK,
      S_AXI_araddr(31 downto 0) => S_AXI_araddr(31 downto 0),
      S_AXI_arburst(1 downto 0) => S_AXI_arburst(1 downto 0),
      S_AXI_arid(3 downto 0) => S_AXI_arid(3 downto 0),
      S_AXI_arlen(7 downto 0) => S_AXI_arlen(7 downto 0),
      S_AXI_arready => S_AXI_arready,
      S_AXI_arregion(3 downto 0) => S_AXI_arregion(3 downto 0),
      S_AXI_arsize(2 downto 0) => S_AXI_arsize(2 downto 0),
      S_AXI_arvalid => S_AXI_arvalid,
      S_AXI_awaddr(31 downto 0) => S_AXI_awaddr(31 downto 0),
      S_AXI_awburst(1 downto 0) => S_AXI_awburst(1 downto 0),
      S_AXI_awid(3 downto 0) => S_AXI_awid(3 downto 0),
      S_AXI_awlen(7 downto 0) => S_AXI_awlen(7 downto 0),
      S_AXI_awready => S_AXI_awready,
      S_AXI_awregion(3 downto 0) => S_AXI_awregion(3 downto 0),
      S_AXI_awsize(2 downto 0) => S_AXI_awsize(2 downto 0),
      S_AXI_awvalid => S_AXI_awvalid,
      S_AXI_bid(3 downto 0) => S_AXI_bid(3 downto 0),
      S_AXI_bready => S_AXI_bready,
      S_AXI_bresp(1 downto 0) => S_AXI_bresp(1 downto 0),
      S_AXI_bvalid => S_AXI_bvalid,
      S_AXI_rdata(127 downto 0) => S_AXI_rdata(127 downto 0),
      S_AXI_rid(3 downto 0) => S_AXI_rid(3 downto 0),
      S_AXI_rlast => S_AXI_rlast,
      S_AXI_rready => S_AXI_rready,
      S_AXI_rresp(1 downto 0) => S_AXI_rresp(1 downto 0),
      S_AXI_rvalid => S_AXI_rvalid,
      S_AXI_wdata(127 downto 0) => S_AXI_wdata(127 downto 0),
      S_AXI_wlast => S_AXI_wlast,
      S_AXI_wready => S_AXI_wready,
      S_AXI_wstrb(15 downto 0) => S_AXI_wstrb(15 downto 0),
      S_AXI_wvalid => S_AXI_wvalid,
      UART_rxd => UART_rxd,
      UART_txd => UART_txd,
      clk => clk,
      dcm_locked => dcm_locked,
      ext_reset_in => ext_reset_in,
      m00_axi_aresetn(0) => m00_axi_aresetn(0),
      mmcm_lock => mmcm_lock,
      pcie_7x_mgt_rxn(3 downto 0) => pcie_7x_mgt_rxn(3 downto 0),
      pcie_7x_mgt_rxp(3 downto 0) => pcie_7x_mgt_rxp(3 downto 0),
      pcie_7x_mgt_txn(3 downto 0) => pcie_7x_mgt_txn(3 downto 0),
      pcie_7x_mgt_txp(3 downto 0) => pcie_7x_mgt_txp(3 downto 0),
      pcie_axi_aclk_out => pcie_axi_aclk_out,
      pcie_axi_aresetn => pcie_axi_aresetn
    );
end STRUCTURE;
