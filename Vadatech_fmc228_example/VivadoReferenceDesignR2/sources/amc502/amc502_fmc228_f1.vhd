----------------------------------------------------------------------------------
-- Company:   		VadaTech Incorporated
-- Engineer: 		Maxwell S.
-- Copyright:		Copyright 2016 VadaTech Incorporated.  All rights reserved.
--
-- Create Date: 	04/13/2016
-- Design Name:
-- Module Name: 	amc502_fmc228_fpga_f1 - Behavioral
-- Project Name:
-- Target Devices: 	Kintex-7 420T FFG1156
-- Tool Versions: 	Vivado
--
-- Description: 	This is the top module of the FMC228 reference design on AMC502 FMC1 connector
--
--
-- Version History:
-- See fmc228.vhd 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

-- Version numbers are defined in fmc228.vhd

entity amc502_fmc228_fpga_f1 is
generic (
	SIGNATURE			: std_logic_vector(15 downto 0) := x"A502";
	IMAGE_ID 			: std_logic_vector(15 downto 0) := x"F228";
	SPEED_GRADE			: integer range 1 to 3 		:= 2;	-- Only speed grade >=2 is currently supported
	
	ORDER_OPTION_B			: std_logic 			:= '0' 	-- FMC228 ordering option B: RF sampling clock
										-- 0: onboard PLL
										-- 1: direct RF sampling clock from front panel CLK IN
										
);
port (
	-- UART
	FPGA_RX_UART			: in	std_logic;
	FPGA_TX_UART			: out	std_logic;

	-- Configuration clock
	-- CLK50MHZ			: in 	std_logic;
	
	-- PCIe
	-- AMC_RX11_P			: in	std_logic;
	-- AMC_RX11_N			: in	std_logic;
	-- AMC_TX11_P			: out	std_logic;
	-- AMC_TX11_N			: out	std_logic;
	-- AMC_RX10_P			: in	std_logic;
	-- AMC_RX10_N			: in	std_logic;
	-- AMC_TX10_P			: out	std_logic;
	-- AMC_TX10_N			: out	std_logic;
	-- AMC_RX9_P 	     		: in	std_logic;
	-- AMC_RX9_N 	      		: in	std_logic;
	-- AMC_TX9_P 	      		: out	std_logic;
	-- AMC_TX9_N 	      		: out	std_logic;
	-- AMC_RX8_P 	      		: in	std_logic;
	-- AMC_RX8_N 	      		: in	std_logic;
	-- AMC_TX8_P 	      		: out	std_logic;
	-- AMC_TX8_N 	      		: out	std_logic;
	
	AMC_RX7_P 	      		: in	std_logic;
	AMC_RX7_N 	      		: in	std_logic;
	AMC_TX7_P 	      		: out	std_logic;
	AMC_TX7_N 	      		: out	std_logic;
	AMC_RX6_P 	      		: in	std_logic;
	AMC_RX6_N 	      		: in	std_logic;
	AMC_TX6_P 	      		: out	std_logic;
	AMC_TX6_N 	        	: out	std_logic;
	AMC_RX5_P 	        	: in	std_logic;
	AMC_RX5_N 	        	: in	std_logic;
	AMC_TX5_P 	        	: out	std_logic;
	AMC_TX5_N 	        	: out	std_logic;
	AMC_RX4_P 	        	: in	std_logic;
	AMC_RX4_N 	        	: in	std_logic;
	AMC_TX4_P 	        	: out	std_logic;
 	AMC_TX4_N 	       		: out	std_logic;
	CLK100MHZ1_P			: in	std_logic;
	CLK100MHZ1_N			: in	std_logic;
	FCLKA_P				: in	std_logic;
	FCLKA_N				: in	std_logic;

	-- User LEDs
	nULED				: out	std_logic_vector(3 downto 0);
	
	-- ***************** FMC signals ******************

	--============ FMC1_LA ==============
	-- FMC228 LMK DCLKOUT12
	-- FMC1_LA_P0			: in	std_logic;
	-- FMC1_LA_N0			: in	std_logic;
	-- FMC228 LMK SDCLKOUT13
	FMC1_LA_P1			: in	std_logic;
	FMC1_LA_N1			: in	std_logic;
	-- TRIG_IN
	FMC1_LA_P2			: in	std_logic;
	FMC1_LA_N2			: in	std_logic;
	-- SYNC ADC0
	FMC1_LA_P3			: out	std_logic;
	FMC1_LA_N3			: out	std_logic;
	-- SYNC ADC1
	FMC1_LA_P4			: out	std_logic;
	FMC1_LA_N4			: out	std_logic;
	-- CSN ADC0, SCLK ADC0
	FMC1_LA_P5			: out	std_logic;
	FMC1_LA_N5			: out	std_logic;
	-- SDIO DIR ADC0, SDIO ADC0
	FMC1_LA_P6			: out	std_logic;
	FMC1_LA_N6			: inout	std_logic;
	-- PDWN/STBY ADC0, FD_A ADC0
	FMC1_LA_P7			: out	std_logic;
	FMC1_LA_N7			: in	std_logic;
	-- FD_B ADC0
	FMC1_LA_P8			: in	std_logic;
	-- FMC1_LA_N8			: out	std_logic;
	-- CSN ADC1, SCLK ADC1
	FMC1_LA_P9			: out	std_logic;
	FMC1_LA_N9			: out	std_logic;
	-- SDIO_DIR ADC1, SDIO ADC1
	FMC1_LA_P10			: out	std_logic;
	FMC1_LA_N10			: inout	std_logic;
	-- PDWN/STBY ADC1, FD_A ADC1
	FMC1_LA_P11			: out	std_logic;
	FMC1_LA_N11			: in	std_logic;
	-- FD_B ADC1, LMK RESET
	FMC1_LA_P12			: in	std_logic;
	FMC1_LA_N12			: out	std_logic;
	-- LMK CLK_CS, LMK SCK
	FMC1_LA_P13			: out	std_logic;
	FMC1_LA_N13			: out	std_logic;
	-- LMK SYNC/SYSREF_REQ, LMK SDIO_DIR
	FMC1_LA_P14			: out	std_logic;
	FMC1_LA_N14			: out	std_logic;
	-- LMK SYNC_DIR, LMK SDIO
	FMC1_LA_P15			: out	std_logic;
	FMC1_LA_N15			: inout	std_logic;
	-- LMK STATUS_LD1, LMK STATUS_LD2
	FMC1_LA_P16			: in	std_logic;
	FMC1_LA_N16			: in	std_logic;
	-- LMK DCLKOUT10
	-- FMC1_LA_P17			: in	std_logic;
	-- FMC1_LA_N17			: in	std_logic;
	-- LMK SDCLKOUT11
	FMC1_LA_P18			: in	std_logic;
	FMC1_LA_N18			: in	std_logic;
	-- HMC CHIP_EN, HMC SCK
	FMC1_LA_P19			: out	std_logic;
	FMC1_LA_N19			: out	std_logic;
	-- HMC SDO, HMC SDI
	FMC1_LA_P20			: in	std_logic;
	FMC1_LA_N20			: out	std_logic;
	-- HMC LD, HMC SEN
	FMC1_LA_P21			: in	std_logic;
	FMC1_LA_N21			: out	std_logic;
	-- FMC1_LA_P22			: out	std_logic;
	-- FMC1_LA_N22			: out	std_logic;
	-- TRIG_OUT
	FMC1_LA_P23			: out	std_logic;
	FMC1_LA_N23			: out	std_logic;
	-- nLED0, nLED1
	FMC1_LA_P24			: out	std_logic;
	FMC1_LA_N24			: out	std_logic;
	-- nLED3, 100MHz OSC CLKOE
	FMC1_LA_P25			: out	std_logic;
	FMC1_LA_N25			: out	std_logic;
	-- FMC1_LA_P26			: out	std_logic;
	-- FMC1_LA_N26			: out	std_logic;
	-- FMC1_LA_P27			: out	std_logic;
	-- FMC1_LA_N27			: out	std_logic;
	-- FMC1_LA_P28			: out	std_logic;
	-- FMC1_LA_N28			: out	std_logic;
	-- FMC1_LA_P29			: out	std_logic;
	-- FMC1_LA_N29			: out	std_logic;
	-- FMC1_LA_P30			: out	std_logic;
	-- FMC1_LA_N30			: out	std_logic;
	-- FMC1_LA_P31			: out	std_logic;
	-- FMC1_LA_N31			: out	std_logic;
	-- FMC1_LA_P32			: out	std_logic;
	-- FMC1_LA_N32			: out	std_logic;
	-- FMC1_LA_P33			: out	std_logic;
	-- FMC1_LA_N33			: out	std_logic;

	--============= FMC1_HA ================
	-- FMC1_HA_P0			:    in std_logic;
	-- FMC1_HA_N0			:    in std_logic;
	-- FMC1_HA_P1			:   out std_logic;
	-- FMC1_HA_N1			:   out std_logic;
	-- FMC1_HA_P2			: out	std_logic;
	-- FMC1_HA_N2			: out	std_logic;
	-- FMC1_HA_P3			:   out std_logic;
	-- FMC1_HA_N3			:   out std_logic;
	-- FMC1_HA_P4			:   out std_logic;
	-- FMC1_HA_N4			:   out std_logic;
	-- FMC1_HA_P5			:   out std_logic;
	-- FMC1_HA_N5			:    in std_logic;
	-- FMC1_HA_P6			:   out std_logic;
	-- FMC1_HA_N6			:   out std_logic;
	-- FMC1_HA_P7			:   out std_logic;
	-- FMC1_HA_N7			:    in std_logic;
	-- FMC1_HA_P8			:   out std_logic;
	-- FMC1_HA_N8			:   out std_logic;
	-- FMC1_HA_P9			:    in std_logic;
	-- FMC1_HA_N9			:    in std_logic;
	-- FMC1_HA_P10			:   out std_logic;
	-- FMC1_HA_N10			:   out std_logic;
	-- FMC1_HA_P11			:   out std_logic;
	-- FMC1_HA_N11			:   out std_logic;
	-- FMC1_HA_P12			:   out std_logic;
	-- FMC1_HA_N12			:   out std_logic;
	-- FMC1_HA_P13			:   out std_logic;
	-- FMC1_HA_N13			:   out std_logic;
	-- FMC1_HA_P14			: inout std_logic;
	-- FMC1_HA_N14			:   out std_logic;
	-- FMC1_HA_P15			: out	std_logic;
	-- FMC1_HA_N15			: out	std_logic;
	-- FMC1_HA_P16			: in	std_logic;
	-- FMC1_HA_N16			: in	std_logic;
	-- FMC1_HA_P17			:    in std_logic;
	-- FMC1_HA_N17			:    in std_logic;
	-- FMC1_HA_P18			:    in std_logic;
	-- FMC1_HA_N18			:    in std_logic;
	-- FMC1_HA_P19			:    in std_logic;
	-- FMC1_HA_N19			:    in std_logic;
	-- FMC1_HA_P20			:   out std_logic;
	-- FMC1_HA_N20			:   out std_logic;
	-- FMC1_HA_P21			:   out std_logic;
	-- FMC1_HA_N21			:   out std_logic;
	-- FMC1_HA_P22			:   out std_logic;
	-- FMC1_HA_N22			:   out std_logic;
	-- FMC1_HA_P23			:   out std_logic;
	-- FMC1_HA_N23			:   out std_logic;

	--============= FMC1_HB ================
	-- FMC1_HB_P0			: out	std_logic;
	-- FMC1_HB_N0			: in	std_logic
	-- FMC1_HB_P			:    in std_logic_vector(21 downto 1);
	-- FMC1_HB_N			:    in std_logic_vector(21 downto 1);

	--============= FMC GTH Lanes ======================
	-- MGT118
	FMC1_RX0_P			:    in std_logic;
	FMC1_RX0_N			:    in std_logic;
	FMC1_RX1_P			:    in std_logic;
	FMC1_RX1_N			:    in std_logic;
	FMC1_RX2_P			:    in std_logic;
	FMC1_RX2_N			:    in std_logic;
	FMC1_RX3_P			:    in std_logic;
	FMC1_RX3_N			:    in std_logic;
	-- MGT117
	FMC1_RX4_P			:    in std_logic;
	FMC1_RX4_N			:    in std_logic;
	FMC1_RX5_P			:    in std_logic;
	FMC1_RX5_N			:    in std_logic;
	FMC1_RX6_P			:    in std_logic;
	FMC1_RX6_N			:    in std_logic;
	FMC1_RX7_P			:    in std_logic;
	FMC1_RX7_N			:    in std_logic;
	-- MGT118 REFCLK: LMK DCLKOUT0, LMK DCLKOUT2. use only REFCLK0
	FMC1_GBTCLK0_P			:    in std_logic;
	FMC1_GBTCLK0_N			:    in std_logic
	-- FMC1_GBTCLK1_P			:    in std_logic;
	-- FMC1_GBTCLK1_N			:    in std_logic
	-- Unused: All TX, RX8, RX9

	-- ******************* End of FMC1 signals **********************

);
end amc502_fmc228_fpga_f1;

architecture Behavioral of amc502_fmc228_fpga_f1 is

	constant NUM_OF_PCIE_LANES		: integer	:= 4;
	constant PCIE_AXI4_DWIDTH		: integer	:= 128;

	constant NUM_OF_MASTERS			: integer	:= 1;
	constant MASTER_PORT0			: integer	:= 0;
	constant MASTER0_AWIDTH			: integer	:= 32;


	component vt_single_sync is
	generic (
		STAGES				: integer	:= 2;
		STARTUP_VALUE			: std_logic	:= '1'
	);
	port (
		clk				: in  std_logic;	 -- Clock of the domain into which the outputs are going
		port_i				: in  std_logic;	 -- Asynchronous inputs
		port_o				: out std_logic	  -- Synchronous outputs
	);
	end component;

	component design_1 is
	port (
		m00_axi_aresetn 		: out std_logic_vector ( 0 to 0 );
		m00_axi_araddr 			: out std_logic_vector ( 31 downto 0 );
		m00_axi_arprot 			: out std_logic_vector ( 2 downto 0 );
		m00_axi_arready 		: in std_logic_vector ( 0 to 0 );
		m00_axi_arvalid 		: out std_logic_vector ( 0 to 0 );
		m00_axi_awaddr 			: out std_logic_vector ( 31 downto 0 );
		m00_axi_awprot 			: out std_logic_vector ( 2 downto 0 );
		m00_axi_awready 		: in std_logic_vector ( 0 to 0 );
		m00_axi_awvalid 		: out std_logic_vector ( 0 to 0 );
		m00_axi_bready 			: out std_logic_vector ( 0 to 0 );
		m00_axi_bresp 			: in std_logic_vector ( 1 downto 0 );
		m00_axi_bvalid 			: in std_logic_vector ( 0 to 0 );
		m00_axi_rdata 			: in std_logic_vector ( 31 downto 0 );
		m00_axi_rready 			: out std_logic_vector ( 0 to 0 );
		m00_axi_rresp 			: in std_logic_vector ( 1 downto 0 );
		m00_axi_rvalid 			: in std_logic_vector ( 0 to 0 );
		m00_axi_wdata 			: out std_logic_vector ( 31 downto 0 );
		m00_axi_wready 			: in std_logic_vector ( 0 to 0 );
		m00_axi_wstrb 			: out std_logic_vector ( 3 downto 0 );
		m00_axi_wvalid 			: out std_logic_vector ( 0 to 0 );
		refclk 				: in std_logic;
		s_axi_araddr  			: in std_logic_vector ( 31 downto 0 );
		s_axi_arburst 			: in std_logic_vector ( 1 downto 0 );
		s_axi_arid    			: in std_logic_vector ( 3 downto 0 );
		s_axi_arlen   			: in std_logic_vector ( 7 downto 0 );
		s_axi_arready 			: out std_logic;
		s_axi_arregion  		: in std_logic_vector ( 3 downto 0 );
		s_axi_arsize 			: in std_logic_vector ( 2 downto 0 );
		s_axi_arvalid 			: in std_logic;
		s_axi_awaddr 			: in std_logic_vector ( 31 downto 0 );
		s_axi_awburst 			: in std_logic_vector ( 1 downto 0 );
		s_axi_awid 			: in std_logic_vector ( 3 downto 0 );
		s_axi_awlen 			: in std_logic_vector ( 7 downto 0 );
		s_axi_awready 			: out std_logic;
		s_axi_awregion 			: in std_logic_vector ( 3 downto 0 );
		s_axi_awsize 			: in std_logic_vector ( 2 downto 0 );
		s_axi_awvalid 			: in std_logic;
		s_axi_bid 			: out std_logic_vector ( 3 downto 0 );
		s_axi_bready 			: in std_logic;
		s_axi_bresp 			: out std_logic_vector ( 1 downto 0 );
		s_axi_bvalid 			: out std_logic;
		s_axi_rdata 			: out std_logic_vector ( 127 downto 0 );
		s_axi_rid 			: out std_logic_vector ( 3 downto 0 );
		s_axi_rlast 			: out std_logic;
		s_axi_rready 			: in std_logic;
		s_axi_rresp 			: out std_logic_vector ( 1 downto 0 );
		s_axi_rvalid 			: out std_logic;
		s_axi_wdata 			: in std_logic_vector ( 127 downto 0 );
		s_axi_wlast 			: in std_logic;
		s_axi_wready 			: out std_logic;
		s_axi_wstrb 			: in std_logic_vector ( 15 downto 0 );
		s_axi_wvalid 			: in std_logic;		
		uart_rxd 			: in std_logic;
		uart_txd 			: out std_logic;
		clk 				: in std_logic;
		dcm_locked   			: in std_logic;
		ext_reset_in 			: in std_logic;
		mmcm_lock   			: out std_logic;
		pcie_7x_mgt_rxn 		: in std_logic_vector ( NUM_OF_PCIE_LANES-1 downto 0 );
		pcie_7x_mgt_rxp 		: in std_logic_vector ( NUM_OF_PCIE_LANES-1 downto 0 );
		pcie_7x_mgt_txn 		: out std_logic_vector ( NUM_OF_PCIE_LANES-1 downto 0 );
		pcie_7x_mgt_txp 		: out std_logic_vector ( NUM_OF_PCIE_LANES-1 downto 0 );
		pcie_axi_aclk_out 		: out std_logic;
		pcie_axi_aresetn 		: in std_logic
	);
	end component;

	component fmc228 is
	generic (
		SIGNATURE			: std_logic_vector(15 downto 0) := x"0000";
		IMAGE_ID 			: std_logic_vector(15 downto 0) := x"0000";
		LVDS_STANDARD			: string 			:= "LVDS";
		
		ORDER_OPTION_B			: std_logic 	 		:= '0' 	-- FMC228 ordering option B

	);
	port (
		-- Ports of AXI4-Lite interface
		s_axi_aclk			: in 	std_logic;
		s_axi_aresetn			: in 	std_logic;
		s00_axi_awaddr			: in 	std_logic_vector(31 downto 0);
		s00_axi_awvalid			: in 	std_logic;
		s00_axi_awready			: out 	std_logic;
		s00_axi_wdata			: in  	std_logic_vector(31 downto 0);
		s00_axi_wstrb			: in  	std_logic_vector(3 downto 0);
		s00_axi_wvalid			: in  	std_logic;
		s00_axi_wready			: out 	std_logic;
		s00_axi_bresp			: out 	std_logic_vector (1 downto 0);
		s00_axi_bvalid			: out 	std_logic;
		s00_axi_bready			: in  	std_logic;
		s00_axi_araddr			: in  	std_logic_vector(31 downto 0);
		s00_axi_arvalid			: in  	std_logic;
		s00_axi_arready			: out 	std_logic;
		s00_axi_rdata			: out 	std_logic_vector (31 downto 0);
		s00_axi_rresp			: out 	std_logic_vector (1 downto 0);
		s00_axi_rvalid			: out 	std_logic;
		s00_axi_rready			: in 	std_logic;
		
		s01_axi_awaddr			: in 	std_logic_vector(31 downto 0);
		s01_axi_awvalid			: in 	std_logic;
		s01_axi_awready			: out 	std_logic;
		s01_axi_wdata			: in  	std_logic_vector(31 downto 0);
		s01_axi_wstrb			: in  	std_logic_vector(3 downto 0);
		s01_axi_wvalid			: in  	std_logic;
		s01_axi_wready			: out 	std_logic;
		s01_axi_bresp			: out 	std_logic_vector (1 downto 0);
		s01_axi_bvalid			: out 	std_logic;
		s01_axi_bready			: in  	std_logic;
		s01_axi_araddr			: in  	std_logic_vector(31 downto 0);
		s01_axi_arvalid			: in  	std_logic;
		s01_axi_arready			: out 	std_logic;
		s01_axi_rdata			: out 	std_logic_vector (31 downto 0);
		s01_axi_rresp			: out 	std_logic_vector (1 downto 0);
		s01_axi_rvalid			: out 	std_logic;
		s01_axi_rready			: in 	std_logic;
		
		axi_ruser_strb_n		: in	std_logic_vector(3 downto 0);
		FMC_LA_P1			: in	std_logic;
		FMC_LA_N1			: in	std_logic;
		FMC_LA_P2			: in	std_logic;
		FMC_LA_N2			: in	std_logic;
		FMC_LA_P3			: out	std_logic;
		FMC_LA_N3			: out	std_logic;
		FMC_LA_P4			: out	std_logic;
		FMC_LA_N4			: out	std_logic;
		FMC_LA_P5			: out	std_logic;
		FMC_LA_N5			: out	std_logic;
		FMC_LA_P6			: out	std_logic;
		FMC_LA_N6			: inout	std_logic;
		FMC_LA_P7			: out	std_logic;
		FMC_LA_N7			: in	std_logic;
		FMC_LA_P8			: in	std_logic;
		FMC_LA_P9			: out	std_logic;
		FMC_LA_N9			: out	std_logic;
		FMC_LA_P10			: out	std_logic;
		FMC_LA_N10			: inout	std_logic;
		FMC_LA_P11			: out	std_logic;
		FMC_LA_N11			: in	std_logic;
		FMC_LA_P12			: in	std_logic;
		FMC_LA_N12			: out	std_logic;
		FMC_LA_P13			: out	std_logic;
		FMC_LA_N13			: out	std_logic;
		FMC_LA_P14			: out	std_logic;
		FMC_LA_N14			: out	std_logic;
		FMC_LA_P15			: out	std_logic;
		FMC_LA_N15			: inout	std_logic;
		FMC_LA_P16			: in	std_logic;
		FMC_LA_N16			: in	std_logic;
		FMC_LA_P18			: in	std_logic;
		FMC_LA_N18			: in	std_logic;
		FMC_LA_P19			: out	std_logic;
		FMC_LA_N19			: out	std_logic;
		FMC_LA_P20			: in	std_logic;
		FMC_LA_N20			: out	std_logic;
		FMC_LA_P21			: in	std_logic;
		FMC_LA_N21			: out	std_logic;
		FMC_LA_P23			: out	std_logic;
		FMC_LA_N23			: out	std_logic;
		FMC_LA_P24			: out	std_logic;
		FMC_LA_N24			: out	std_logic;
		FMC_LA_P25			: out	std_logic;
		FMC_LA_N25			: out	std_logic;
		FMC_RX0_P			: in 	std_logic;
		FMC_RX0_N			: in 	std_logic;
		FMC_RX1_P			: in 	std_logic;
		FMC_RX1_N			: in 	std_logic;
		FMC_RX2_P			: in 	std_logic;
		FMC_RX2_N			: in 	std_logic;
		FMC_RX3_P			: in 	std_logic;
		FMC_RX3_N			: in 	std_logic;
		FMC_RX4_P			: in 	std_logic;
		FMC_RX4_N			: in 	std_logic;
		FMC_RX5_P			: in 	std_logic;
		FMC_RX5_N			: in 	std_logic;
		FMC_RX6_P			: in 	std_logic;
		FMC_RX6_N			: in 	std_logic;
		FMC_RX7_P			: in 	std_logic;
		FMC_RX7_N			: in 	std_logic;
		FMC_GBTCLK0_P			: in 	std_logic;
		FMC_GBTCLK0_N			: in 	std_logic
	);
	end component;

	--=================== signals ==================

	signal axi_aresetn			: std_logic;
	signal axi_aclk				: std_logic;
	signal axi_aclk_pre			: std_logic;
	signal axi_areset			: std_logic	:= '1';

	-- ============== PCIe signals =========================
	signal pci_exp_txn			: std_logic_vector(NUM_OF_PCIE_LANES-1 downto 0);
	signal pci_exp_txp			: std_logic_vector(NUM_OF_PCIE_LANES-1 downto 0);
	signal pci_exp_rxn			: std_logic_vector(NUM_OF_PCIE_LANES-1 downto 0);
	signal pci_exp_rxp			: std_logic_vector(NUM_OF_PCIE_LANES-1 downto 0);
	signal pcie_refclk      		: std_logic;
	signal pcie_mmcm_lock                   : std_logic;
	signal pcie_axi_aclk	                : std_logic;
	signal pcie_axi_aresetn			: std_logic;
	signal pcie_axi_areset			: std_logic;
	signal pcie_axi_areset_p		: std_logic;
	
	-- axi4 connection signals
	signal mb_axi_aresetn			: std_logic_vector(0 downto 0);
	signal mb_axi_awaddr			: std_logic_vector ( 31 downto 0 )	:= (others => '0');
	signal mb_axi_awprot			: std_logic_vector ( 2 downto 0 );
	signal mb_axi_awvalid			: std_logic_vector(0 downto 0);
	signal mb_axi_awready			: std_logic_vector(0 downto 0);
	signal mb_axi_wdata			: std_logic_vector ( 31 downto 0 );
	signal mb_axi_wstrb			: std_logic_vector ( 3 downto 0 );
	signal mb_axi_wvalid			: std_logic_vector(0 downto 0);
	signal mb_axi_wready			: std_logic_vector(0 downto 0);
	signal mb_axi_bresp			: std_logic_vector ( 1 downto 0 );
	signal mb_axi_bvalid			: std_logic_vector(0 downto 0);
	signal mb_axi_bready			: std_logic_vector(0 downto 0);
	signal mb_axi_araddr			: std_logic_vector ( 31 downto 0 )	:= (others => '0');
	signal mb_axi_arprot			: std_logic_vector ( 2 downto 0 );
	signal mb_axi_arvalid			: std_logic_vector(0 downto 0);
	signal mb_axi_arready			: std_logic_vector(0 downto 0);
	signal mb_axi_rdata			: std_logic_vector ( 31 downto 0 );
	signal mb_axi_rresp			: std_logic_vector ( 1 downto 0 );
	signal mb_axi_rvalid			: std_logic_vector(0 downto 0);
	signal mb_axi_rready			: std_logic_vector(0 downto 0);
	signal axi_ruser_strb_n			: std_logic_vector(3 downto 0)	:= x"0";


begin
	--========== axi_aresetn & clock axi_aclk =========
	-- Bring in the on-board 100MHz clock
	ibufds_gte2_inst_clk100mhz0 : IBUFDS_GTE2
	generic map (
		CLKCM_CFG			=> TRUE,
		CLKRCV_TRST			=> TRUE,
		CLKSWING_CFG			=> "11"
	)
	port map (
		O				=> axi_aclk_pre,
		ODIV2				=> open,
		CEB				=> '0',
		I				=> CLK100MHZ1_P,
		IB				=> CLK100MHZ1_N
	);

	bufg_inst_clk100mhz1 : BUFG
	port map (
		O 				=> axi_aclk,
		I 				=> axi_aclk_pre
	);

	-- follow Xilinx's recommendation using synchronized reset
	vt_single_inst_pwr_rst: vt_single_sync
	generic map(
		STAGES				=> 16,
		STARTUP_VALUE			=> '1'
	)
	port map(
		clk				=> axi_aclk,
		port_i				=> '0',
		port_o				=> axi_areset
	);

	axi_aresetn				<= mb_axi_aresetn(0);

	-- =========== block design =================
	design_1_wrapper_inst: design_1
	port map(
		m00_axi_aresetn			=> mb_axi_aresetn,
		m00_axi_awaddr(31 downto 16)	=> open,
		m00_axi_awaddr(15 downto 0)	=> mb_axi_awaddr(15 downto 0),
		m00_axi_awprot			=> mb_axi_awprot,
		m00_axi_awvalid			=> mb_axi_awvalid,
		m00_axi_awready			=> mb_axi_awready,
		m00_axi_wdata			=> mb_axi_wdata,
		m00_axi_wstrb			=> mb_axi_wstrb,
		m00_axi_wvalid			=> mb_axi_wvalid,
		m00_axi_wready			=> mb_axi_wready,
		m00_axi_bresp			=> mb_axi_bresp,
		m00_axi_bvalid			=> mb_axi_bvalid,
		m00_axi_bready			=> mb_axi_bready,
		m00_axi_araddr(31 downto 16)	=> open,
		m00_axi_araddr(15 downto 0)	=> mb_axi_araddr(15 downto 0),
		m00_axi_arprot			=> mb_axi_arprot,
		m00_axi_arvalid			=> mb_axi_arvalid,
		m00_axi_arready			=> mb_axi_arready,
		m00_axi_rdata			=> mb_axi_rdata,
		m00_axi_rresp			=> mb_axi_rresp,
		m00_axi_rvalid			=> mb_axi_rvalid,
		m00_axi_rready			=> mb_axi_rready,
		refclk 				=> pcie_refclk,
		s_axi_araddr  			=> (others => '0'), 
		s_axi_arburst 			=> (others => '0'), 
		s_axi_arid    			=> (others => '0'), 
		s_axi_arlen   			=> (others => '0'), 
		s_axi_arready 			=> open, 
		s_axi_arregion  		=> (others => '0'), 
		s_axi_arsize 			=> (others => '0'), 
		s_axi_arvalid 			=> '0',
		s_axi_awaddr 			=> (others => '0'), 
		s_axi_awburst 			=> (others => '0'), 
		s_axi_awid 			=> (others => '0'), 
		s_axi_awlen 			=> (others => '0'), 
		s_axi_awready 			=> open,
		s_axi_awregion 			=> (others => '0'), 
		s_axi_awsize 			=> (others => '0'), 
		s_axi_awvalid 			=> '0',
		s_axi_bid 			=> open,
		s_axi_bready 			=> '0',
		s_axi_bresp 			=> open,
		s_axi_bvalid 			=> open,
		s_axi_rdata 			=> open,
		s_axi_rid 			=> open,
		s_axi_rlast 			=> open,
		s_axi_rready 			=> '0',
		s_axi_rresp 			=> open,
		s_axi_rvalid 			=> open,
		s_axi_wdata 			=> (others => '0'), 
		s_axi_wlast 			=> '0',
		s_axi_wready 			=> open,
		s_axi_wstrb 			=> (others => '0'), 
		s_axi_wvalid 			=> '0',
		uart_rxd 			=> FPGA_RX_UART,
		uart_txd 			=> FPGA_TX_UART,
		clk 				=> axi_aclk,
		dcm_locked   			=> '1',
		ext_reset_in 			=> axi_areset,
		mmcm_lock   			=> pcie_mmcm_lock,
		pcie_7x_mgt_rxn 		=> pci_exp_rxn,
		pcie_7x_mgt_rxp 		=> pci_exp_rxp,
		pcie_7x_mgt_txn 		=> pci_exp_txn,
		pcie_7x_mgt_txp 		=> pci_exp_txp,
		pcie_axi_aclk_out 		=> pcie_axi_aclk,
		pcie_axi_aresetn 		=> pcie_axi_aresetn 
	);

	-- ============ PCIe interface ==============
	-- PCIe reference clock
	ibufds_gte2_inst : IBUFDS_GTE2
	generic map (
		CLKCM_CFG			=> TRUE,
		CLKRCV_TRST			=> TRUE,
		CLKSWING_CFG			=> "11"
	)
	port map (
		O				=> pcie_refclk,
		ODIV2				=> open,
		CEB				=> '0',
		I				=> FCLKA_P,
		IB				=> FCLKA_N
	);


	-- AMC_TX8_N				<= pci_exp_txn(0);
	-- AMC_TX8_P				<= pci_exp_txp(0);
	-- AMC_TX9_N				<= pci_exp_txn(1);
	-- AMC_TX9_P				<= pci_exp_txp(1);
	-- AMC_TX10_N				<= pci_exp_txn(2);
	-- AMC_TX10_P				<= pci_exp_txp(2);
	-- AMC_TX11_N				<= pci_exp_txn(3);
	-- AMC_TX11_P				<= pci_exp_txp(3);
	
	AMC_TX4_N				<= pci_exp_txn(0);
	AMC_TX4_P				<= pci_exp_txp(0);
	AMC_TX5_N				<= pci_exp_txn(1);
	AMC_TX5_P				<= pci_exp_txp(1);
	AMC_TX6_N				<= pci_exp_txn(2);
	AMC_TX6_P				<= pci_exp_txp(2);
	AMC_TX7_N				<= pci_exp_txn(3);
	AMC_TX7_P				<= pci_exp_txp(3);
	
	-- AMC_TX8_N				<= pci_exp_txn(4);
	-- AMC_TX8_P				<= pci_exp_txp(4);
	-- AMC_TX9_N				<= pci_exp_txn(5);
	-- AMC_TX9_P				<= pci_exp_txp(5);
	-- AMC_TX10_N				<= pci_exp_txn(6);
	-- AMC_TX10_P				<= pci_exp_txp(6);
	-- AMC_TX11_N				<= pci_exp_txn(7);
	-- AMC_TX11_P				<= pci_exp_txp(7);

	pci_exp_rxn				<= 
						   -- AMC_RX11_N & 
						   -- AMC_RX10_N & 
						   -- AMC_RX9_N & 
						   -- AMC_RX8_N ;
						   AMC_RX7_N & 
						   AMC_RX6_N & 
						   AMC_RX5_N & 
						   AMC_RX4_N;

	pci_exp_rxp				<= 
						   -- AMC_RX11_P & 
						   -- AMC_RX10_P & 
						   -- AMC_RX9_P & 
						   -- AMC_RX8_P ;
						   AMC_RX7_P & 
						   AMC_RX6_P & 
						   AMC_RX5_P & 
						   AMC_RX4_P;

	-- Create pcie_axi_aresetn which is held active for 16 clocks after pcie_mmcm_lock becomes active
	pcie_axi_areset_p			<= not pcie_mmcm_lock;

	vt_single_sync_inst_pcie: vt_single_sync
	generic map(
		STAGES				=> 16,
		STARTUP_VALUE			=> '1'
	)
	port map(
		clk				=> pcie_axi_aclk,
		port_i				=> pcie_axi_areset_p,
		port_o				=> pcie_axi_areset
	);
	
	pcie_axi_aresetn			<= not pcie_axi_areset;
	

	-- debug
	nULED(0)				<= pcie_axi_aresetn;
	nULED(1)				<= axi_aresetn;
	nULED(2)				<= axi_areset;
	nULED(3)				<= pcie_mmcm_lock;
	
	-- ============ Main fmc228 design instantiation ==============
	fmc228_inst: fmc228
	generic map(
		SIGNATURE			=> SIGNATURE,
		IMAGE_ID 			=> IMAGE_ID,
		LVDS_STANDARD			=> "LVDS_25",
		ORDER_OPTION_B			=> ORDER_OPTION_B
	)
	port map(
		s_axi_aclk			=> axi_aclk,
		s_axi_aresetn			=> axi_aresetn,
		s00_axi_awaddr			=> mb_axi_awaddr,
		s00_axi_awvalid			=> mb_axi_awvalid(0),
		s00_axi_awready			=> mb_axi_awready(0),
		s00_axi_wdata			=> mb_axi_wdata,
		s00_axi_wstrb			=> mb_axi_wstrb,
		s00_axi_wvalid			=> mb_axi_wvalid(0),
		s00_axi_wready			=> mb_axi_wready(0),
		s00_axi_bresp			=> mb_axi_bresp,
		s00_axi_bvalid			=> mb_axi_bvalid(0),
		s00_axi_bready			=> mb_axi_bready(0),
		s00_axi_araddr			=> mb_axi_araddr,
		s00_axi_arvalid			=> mb_axi_arvalid(0),
		s00_axi_arready			=> mb_axi_arready(0),
		s00_axi_rdata			=> mb_axi_rdata,
		s00_axi_rresp			=> mb_axi_rresp,
		s00_axi_rvalid			=> mb_axi_rvalid(0),
		s00_axi_rready			=> mb_axi_rready(0),
		s01_axi_awaddr			=> (others => '0'),
		s01_axi_awvalid			=> '0',
		s01_axi_awready			=> open,
		s01_axi_wdata			=> (others => '0'),
		s01_axi_wstrb			=> (others => '0'),
		s01_axi_wvalid			=> '0',
		s01_axi_wready			=> open,
		s01_axi_bresp			=> open,
		s01_axi_bvalid			=> open,
		s01_axi_bready			=> '0',
		s01_axi_araddr			=> (others => '0'),
		s01_axi_arvalid			=> '0',
		s01_axi_arready			=> open,
		s01_axi_rdata			=> open,
		s01_axi_rresp			=> open,
		s01_axi_rvalid			=> open,
		s01_axi_rready			=> '0',		
		axi_ruser_strb_n		=> axi_ruser_strb_n,
		FMC_LA_P1			=> FMC1_LA_P1,
		FMC_LA_N1			=> FMC1_LA_N1,
		FMC_LA_P2			=> FMC1_LA_P2,
		FMC_LA_N2			=> FMC1_LA_N2,
		FMC_LA_P3			=> FMC1_LA_P3,
		FMC_LA_N3			=> FMC1_LA_N3,
		FMC_LA_P4			=> FMC1_LA_P4,
		FMC_LA_N4			=> FMC1_LA_N4,
		FMC_LA_P5			=> FMC1_LA_P5,
		FMC_LA_N5			=> FMC1_LA_N5,
		FMC_LA_P6			=> FMC1_LA_P6,
		FMC_LA_N6			=> FMC1_LA_N6,
		FMC_LA_P7			=> FMC1_LA_P7,
		FMC_LA_N7			=> FMC1_LA_N7,
		FMC_LA_P8			=> FMC1_LA_P8,
		FMC_LA_P9			=> FMC1_LA_P9,
		FMC_LA_N9			=> FMC1_LA_N9,
		FMC_LA_P10			=> FMC1_LA_P10,
		FMC_LA_N10			=> FMC1_LA_N10,
		FMC_LA_P11			=> FMC1_LA_P11,
		FMC_LA_N11			=> FMC1_LA_N11,
		FMC_LA_P12			=> FMC1_LA_P12,
		FMC_LA_N12			=> FMC1_LA_N12,
		FMC_LA_P13			=> FMC1_LA_P13,
		FMC_LA_N13			=> FMC1_LA_N13,
		FMC_LA_P14			=> FMC1_LA_P14,
		FMC_LA_N14			=> FMC1_LA_N14,
		FMC_LA_P15			=> FMC1_LA_P15,
		FMC_LA_N15			=> FMC1_LA_N15,
		FMC_LA_P16			=> FMC1_LA_P16,
		FMC_LA_N16			=> FMC1_LA_N16,
		FMC_LA_P18			=> FMC1_LA_P18,
		FMC_LA_N18			=> FMC1_LA_N18,
		FMC_LA_P19			=> FMC1_LA_P19,
		FMC_LA_N19			=> FMC1_LA_N19,
		FMC_LA_P20			=> FMC1_LA_P20,
		FMC_LA_N20			=> FMC1_LA_N20,
		FMC_LA_P21			=> FMC1_LA_P21,
		FMC_LA_N21			=> FMC1_LA_N21,
		FMC_LA_P23			=> FMC1_LA_P23,
		FMC_LA_N23			=> FMC1_LA_N23,
		FMC_LA_P24			=> FMC1_LA_P24,
		FMC_LA_N24			=> FMC1_LA_N24,
		FMC_LA_P25			=> FMC1_LA_P25,
		FMC_LA_N25			=> FMC1_LA_N25,
		FMC_RX0_P			=> FMC1_RX0_P,
		FMC_RX0_N			=> FMC1_RX0_N,
		FMC_RX1_P			=> FMC1_RX1_P,
		FMC_RX1_N			=> FMC1_RX1_N,
		FMC_RX2_P			=> FMC1_RX2_P,
		FMC_RX2_N			=> FMC1_RX2_N,
		FMC_RX3_P			=> FMC1_RX3_P,
		FMC_RX3_N			=> FMC1_RX3_N,
		FMC_RX4_P			=> FMC1_RX4_P,
		FMC_RX4_N			=> FMC1_RX4_N,
		FMC_RX5_P			=> FMC1_RX5_P,
		FMC_RX5_N			=> FMC1_RX5_N,
		FMC_RX6_P			=> FMC1_RX6_P,
		FMC_RX6_N			=> FMC1_RX6_N,
		FMC_RX7_P			=> FMC1_RX7_P,
		FMC_RX7_N			=> FMC1_RX7_N,
		FMC_GBTCLK0_P			=> FMC1_GBTCLK0_P,
		FMC_GBTCLK0_N			=> FMC1_GBTCLK0_N
	);

end Behavioral;
