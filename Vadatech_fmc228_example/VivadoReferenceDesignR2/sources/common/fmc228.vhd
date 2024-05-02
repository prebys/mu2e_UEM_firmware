
----------------------------------------------------------------------------------
-- Company:   		VadaTech Incorporated
-- Engineer: 		Maxwell S.
-- Copyright:		Copyright 2016 VadaTech Incorporated.  All rights reserved.
--
-- Create Date: 	4/13/2016
-- Design Name:
-- Module Name: 	fmc228 - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
--
-- Description: 	This is the main module of the fmc228 reference design
--
-- Version History:
-- 05/19/2016 	2	Added ordering option B=1 support in SDK (software change only)	
--			Updated to Vivado 2016.1
-- 04/13/2016	1	Initial
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity fmc228 is
generic (
	MAJOR_VERSION			: integer range 0 to 255	:= 2;
	MINOR_VERSION			: integer range 0 to 255	:= 0;
	PATCH_VERSION			: integer range 0 to 255	:= 0;
	REV_VERSION			: integer range 0 to 255	:= 0;
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
	-- ***************** FMC signals used ******************

	--============ FMC_LA ==============
	-- FMC228 LMK DCLKOUT12
	-- FMC_LA_P0			: in	std_logic;
	-- FMC_LA_N0			: in	std_logic;

	-- FMC228 LMK SDCLKOUT13
	FMC_LA_P1			: in	std_logic;
	FMC_LA_N1			: in	std_logic;

	-- TRIG_IN
	FMC_LA_P2			: in	std_logic;
	FMC_LA_N2			: in	std_logic;

	-- SYNC ADC0
	FMC_LA_P3			: out	std_logic;
	FMC_LA_N3			: out	std_logic;

	-- SYNC ADC1
	FMC_LA_P4			: out	std_logic;
	FMC_LA_N4			: out	std_logic;

	-- CSN ADC0, SCLK ADC0
	FMC_LA_P5			: out	std_logic;
	FMC_LA_N5			: out	std_logic;

	-- SDIO DIR ADC0, SDIO ADC0
	FMC_LA_P6			: out	std_logic;
	FMC_LA_N6			: inout	std_logic;

	-- PDWN/STBY ADC0, FD_A ADC0
	FMC_LA_P7			: out	std_logic;
	FMC_LA_N7			: in	std_logic;

	-- FD_B ADC0
	FMC_LA_P8			: in	std_logic;
	-- FMC_LA_N8			: out	std_logic;

	-- CSN ADC1, SCLK ADC1
	FMC_LA_P9			: out	std_logic;
	FMC_LA_N9			: out	std_logic;

	-- SDIO_DIR ADC1, SDIO ADC1
	FMC_LA_P10			: out	std_logic;
	FMC_LA_N10			: inout	std_logic;

	-- PDWN/STBY ADC1, FD_A ADC1
	FMC_LA_P11			: out	std_logic;
	FMC_LA_N11			: in	std_logic;

	-- FD_B ADC1, LMK RESET
	FMC_LA_P12			: in	std_logic;
	FMC_LA_N12			: out	std_logic;

	-- LMK CLK_CS, LMK SCK
	FMC_LA_P13			: out	std_logic;
	FMC_LA_N13			: out	std_logic;

	-- LMK SYNC/SYSREF_REQ, LMK SDIO_DIR
	FMC_LA_P14			: out	std_logic;
	FMC_LA_N14			: out	std_logic;

	-- LMK SYNC_DIR, LMK SDIO
	FMC_LA_P15			: out	std_logic;
	FMC_LA_N15			: inout	std_logic;

	-- LMK STATUS_LD1, LMK STATUS_LD2
	FMC_LA_P16			: in	std_logic;
	FMC_LA_N16			: in	std_logic;

	-- LMK DCLKOUT10
	-- FMC_LA_P17			: in	std_logic;
	-- FMC_LA_N17			: in	std_logic;

	-- LMK SDCLKOUT11
	FMC_LA_P18			: in	std_logic;
	FMC_LA_N18			: in	std_logic;

	-- HMC CHIP_EN, HMC SCK
	FMC_LA_P19			: out	std_logic;
	FMC_LA_N19			: out	std_logic;

	-- HMC SDO, HMC SDI
	FMC_LA_P20			: in	std_logic;
	FMC_LA_N20			: out	std_logic;

	-- HMC LD, HMC SEN
	FMC_LA_P21			: in	std_logic;
	FMC_LA_N21			: out	std_logic;

	-- FMC_LA_P22			: out	std_logic;
	-- FMC_LA_N22			: out	std_logic;

	-- TRIG_OUT
	FMC_LA_P23			: out	std_logic;
	FMC_LA_N23			: out	std_logic;

	-- nLED0, nLED1
	FMC_LA_P24			: out	std_logic;
	FMC_LA_N24			: out	std_logic;

	-- nLED3, 100MHz OSC CLKOE
	FMC_LA_P25			: out	std_logic;
	FMC_LA_N25			: out	std_logic;

	-- FMC_LA_P26			: out	std_logic;
	-- FMC_LA_N26			: out	std_logic;
	-- FMC_LA_P27			: out	std_logic;
	-- FMC_LA_N27			: out	std_logic;
	-- FMC_LA_P28			: out	std_logic;
	-- FMC_LA_N28			: out	std_logic;
	-- FMC_LA_P29			: out	std_logic;
	-- FMC_LA_N29			: out	std_logic;
	-- FMC_LA_P30			: out	std_logic;
	-- FMC_LA_N30			: out	std_logic;
	-- FMC_LA_P31			: out	std_logic;
	-- FMC_LA_N31			: out	std_logic;
	-- FMC_LA_P32			: out	std_logic;
	-- FMC_LA_N32			: out	std_logic;
	-- FMC_LA_P33			: out	std_logic;
	-- FMC_LA_N33			: out	std_logic;

	--============= FMC_HA ================
	-- FMC_HA_P0			:    in std_logic;
	-- FMC_HA_N0			:    in std_logic;
	-- FMC_HA_P1			:   out std_logic;
	-- FMC_HA_N1			:   out std_logic;
	-- FMC_HA_P2			: out	std_logic;
	-- FMC_HA_N2			: out	std_logic;
	-- FMC_HA_P3			:   out std_logic;
	-- FMC_HA_N3			:   out std_logic;
	-- FMC_HA_P4			:   out std_logic;
	-- FMC_HA_N4			:   out std_logic;
	-- FMC_HA_P5			:   out std_logic;
	-- FMC_HA_N5			:    in std_logic;
	-- FMC_HA_P6			:   out std_logic;
	-- FMC_HA_N6			:   out std_logic;
	-- FMC_HA_P7			:   out std_logic;
	-- FMC_HA_N7			:    in std_logic;
	-- FMC_HA_P8			:   out std_logic;
	-- FMC_HA_N8			:   out std_logic;
	-- FMC_HA_P9			:    in std_logic;
	-- FMC_HA_N9			:    in std_logic;
	-- FMC_HA_P10			:   out std_logic;
	-- FMC_HA_N10			:   out std_logic;
	-- FMC_HA_P11			:   out std_logic;
	-- FMC_HA_N11			:   out std_logic;
	-- FMC_HA_P12			:   out std_logic;
	-- FMC_HA_N12			:   out std_logic;
	-- FMC_HA_P13			:   out std_logic;
	-- FMC_HA_N13			:   out std_logic;
	-- FMC_HA_P14			: inout std_logic;
	-- FMC_HA_N14			:   out std_logic;
	-- FMC_HA_P15			: out	std_logic;
	-- FMC_HA_N15			: out	std_logic;
	-- FMC_HA_P16			: in	std_logic;
	-- FMC_HA_N16			: in	std_logic;
	-- FMC_HA_P17			:    in std_logic;
	-- FMC_HA_N17			:    in std_logic;
	-- FMC_HA_P18			:    in std_logic;
	-- FMC_HA_N18			:    in std_logic;
	-- FMC_HA_P19			:    in std_logic;
	-- FMC_HA_N19			:    in std_logic;
	-- FMC_HA_P20			:   out std_logic;
	-- FMC_HA_N20			:   out std_logic;
	-- FMC_HA_P21			:   out std_logic;
	-- FMC_HA_N21			:   out std_logic;
	-- FMC_HA_P22			:   out std_logic;
	-- FMC_HA_N22			:   out std_logic;
	-- FMC_HA_P23			:   out std_logic;
	-- FMC_HA_N23			:   out std_logic;

	--============= FMC_HB ================
	-- FMC_HB_P0			: out	std_logic;
	-- FMC_HB_N0			: in	std_logic
	-- FMC_HB_P			:    in std_logic_vector(21 downto 1);
	-- FMC_HB_N			:    in std_logic_vector(21 downto 1);

	--============= FMC GTH Lanes ======================
	-- MGT118
	FMC_RX0_P			:    in std_logic;
	FMC_RX0_N			:    in std_logic;
	FMC_RX1_P			:    in std_logic;
	FMC_RX1_N			:    in std_logic;
	FMC_RX2_P			:    in std_logic;
	FMC_RX2_N			:    in std_logic;
	FMC_RX3_P			:    in std_logic;
	FMC_RX3_N			:    in std_logic;
	-- MGT117
	FMC_RX4_P			:    in std_logic;
	FMC_RX4_N			:    in std_logic;
	FMC_RX5_P			:    in std_logic;
	FMC_RX5_N			:    in std_logic;
	FMC_RX6_P			:    in std_logic;
	FMC_RX6_N			:    in std_logic;
	FMC_RX7_P			:    in std_logic;
	FMC_RX7_N			:    in std_logic;
	-- MGT118 REFCLK: LMK DCLKOUT0, LMK DCLKOUT2. use only REFCLK0
	FMC_GBTCLK0_P			:    in std_logic;
	FMC_GBTCLK0_N			:    in std_logic

	-- ******************* End of FMC signals **********************
);
end fmc228;

architecture Behavioral of fmc228 is
	constant ADC_BITS    			: integer	:= 12;
	constant JESD204_LANES 			: integer	:= 4;

	constant NUM_OF_MASTERS			: integer	:= 2;
	constant MASTER_PORT0			: integer	:= 0;
	constant MASTER_PORT1			: integer	:= 1;

	constant NUM_OF_PORTS			: integer	:= 10;

	constant AMC_COMMON_PORT		: integer	:= 0;
	constant SDIO_CG_PORT		: integer	:= 1;
	constant SDIO_HMC_PORT		: integer	:= 2;
	constant SDIO_ADC0_PORT		: integer	:= 3;
	constant SDIO_ADC1_PORT		: integer	:= 4;
	constant AXI_GPIO_PORT		: integer	:= 5;
	constant JESD0_PORT		: integer	:= 6;
	constant JESD1_PORT		: integer	:= 7;
	constant ADC0_RD_PORT		: integer	:= 8;
	constant ADC1_RD_PORT		: integer	:= 9;

	constant AMC_COMMON_AWIDTH	: integer	:= 12;
	constant SDIO_CG_AWIDTH		: integer	:= 7;
	constant SDIO_HMC_AWIDTH	: integer	:= 7;
	constant SDIO_ADC0_AWIDTH	: integer	:= 7;
	constant SDIO_ADC1_AWIDTH	: integer	:= 7;
	constant AXI_GPIO_AWIDTH	: integer	:= 12;
	constant JESD0_AWIDTH		: integer	:= 12;
	constant JESD1_AWIDTH		: integer	:= 12;
	constant ADC0_RD_AWIDTH		: integer	:= 12;
	constant ADC1_RD_AWIDTH		: integer	:= 12;

	component ila_0 is
	port (
		clk				: in  std_logic;
		probe0				: in  std_logic_vector ( 3 downto 0 );
		probe1				: in  std_logic_vector ( 3 downto 0 );
		probe2				: in  std_logic_vector ( 15 downto 0 );
		probe3				: in  std_logic_vector ( 0 to 0 );
		probe4				: in  std_logic_vector ( 127 downto 0 )
	);
	end component;

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

	component clk_wiz_0 is
	port (
		clk_in1           		: in  std_logic;
		clk_out1          		: out std_logic;
		clk_out2          		: out std_logic;
		reset             		: in  std_logic;
		locked            		: out std_logic
	);
	end component;

	component fifo_generator_0 is
	port (
		rst				: in std_logic;
		wr_clk				: in std_logic;
		rd_clk				: in std_logic;
		din				: in std_logic_vector(127 downto 0);
		wr_en				: in std_logic;
		rd_en				: in std_logic;
		dout				: out std_logic_vector(31 downto 0);
		full				: out std_logic;
		empty				: out std_logic;
		almost_empty			: out STD_LOGIC;
		rd_data_count			: out std_logic_vector(11 downto 0)
	);
	end component;

	component axi_crossbar_0 is
	port (
		aclk 				: in  std_logic;
		aresetn 			: in  std_logic;
		s_axi_awaddr			: in std_logic_vector ( NUM_OF_MASTERS*32-1 downto 0 );
		s_axi_awprot			: in std_logic_vector ( NUM_OF_MASTERS*3-1 downto 0 );
		s_axi_awvalid			: in std_logic_vector ( NUM_OF_MASTERS-1 downto 0 );
		s_axi_awready			: out std_logic_vector ( NUM_OF_MASTERS-1 downto 0 );
		s_axi_wdata			: in std_logic_vector ( NUM_OF_MASTERS*32-1 downto 0 );
		s_axi_wstrb			: in std_logic_vector ( NUM_OF_MASTERS*4-1 downto 0 );
		s_axi_wvalid			: in std_logic_vector ( NUM_OF_MASTERS-1 downto 0 );
		s_axi_wready			: out std_logic_vector ( NUM_OF_MASTERS-1 downto 0 );
		s_axi_bresp			: out std_logic_vector ( NUM_OF_MASTERS*2-1 downto 0 );
		s_axi_bvalid			: out std_logic_vector ( NUM_OF_MASTERS-1 downto 0 );
		s_axi_bready			: in std_logic_vector ( NUM_OF_MASTERS-1 downto 0 );
		s_axi_araddr			: in std_logic_vector ( NUM_OF_MASTERS*32-1 downto 0 );
		s_axi_arprot			: in std_logic_vector ( NUM_OF_MASTERS*3-1 downto 0 );
		s_axi_arvalid			: in std_logic_vector ( NUM_OF_MASTERS-1 downto 0 );
		s_axi_arready			: out std_logic_vector ( NUM_OF_MASTERS-1 downto 0 );
		s_axi_rdata			: out std_logic_vector ( NUM_OF_MASTERS*32-1 downto 0 );
		s_axi_rresp			: out std_logic_vector ( NUM_OF_MASTERS*2-1 downto 0 );
		s_axi_rvalid			: out std_logic_vector ( NUM_OF_MASTERS-1 downto 0 );
		s_axi_rready			: in std_logic_vector ( NUM_OF_MASTERS-1 downto 0 );
		m_axi_awaddr			: out	std_logic_vector ( NUM_OF_PORTS*32-1 downto 0 );
		m_axi_awprot			: out	std_logic_vector ( NUM_OF_PORTS*3-1 downto 0 );
		m_axi_awvalid			: out	std_logic_vector ( NUM_OF_PORTS-1 downto 0 );
		m_axi_awready			: in	std_logic_vector ( NUM_OF_PORTS-1 downto 0 );
		m_axi_wdata			: out	std_logic_vector ( NUM_OF_PORTS*32-1 downto 0 );
		m_axi_wstrb			: out	std_logic_vector ( NUM_OF_PORTS*4-1 downto 0 );
		m_axi_wvalid			: out	std_logic_vector ( NUM_OF_PORTS-1 downto 0 );
		m_axi_wready			: in	std_logic_vector ( NUM_OF_PORTS-1 downto 0 );
		m_axi_bresp			: in	std_logic_vector ( NUM_OF_PORTS*2-1 downto 0 );
		m_axi_bvalid			: in	std_logic_vector ( NUM_OF_PORTS-1 downto 0 );
		m_axi_bready			: out	std_logic_vector ( NUM_OF_PORTS-1 downto 0 );
		m_axi_araddr			: out	std_logic_vector ( NUM_OF_PORTS*32-1 downto 0 );
		m_axi_arprot			: out	std_logic_vector ( NUM_OF_PORTS*3-1 downto 0 );
		m_axi_arvalid			: out	std_logic_vector ( NUM_OF_PORTS-1 downto 0 );
		m_axi_arready			: in	std_logic_vector ( NUM_OF_PORTS-1 downto 0 );
		m_axi_rdata			: in	std_logic_vector ( NUM_OF_PORTS*32-1 downto 0 );
		m_axi_rresp			: in	std_logic_vector ( NUM_OF_PORTS*2-1 downto 0 );
		m_axi_rvalid			: in	std_logic_vector ( NUM_OF_PORTS-1 downto 0 );
		m_axi_rready			: out	std_logic_vector ( NUM_OF_PORTS-1 downto 0 )
	);
	end component;

	component axi_gpio_32 is
	generic (
		MAJOR_VERSION			: integer range 0 to 255	:= 1;
		MINOR_VERSION			: integer range 0 to 255	:= 0;
		PATCH_VERSION			: integer range 0 to 255	:= 0;
		REV_VERSION			: integer range 0 to 255	:= 0;
		SIGNATURE			: std_logic_vector(15 downto 0) := x"0000";
		IMAGE_ID			: std_logic_vector(15 downto 0) := x"0001";

		GPIO_INIT_0			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_1			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_2			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_3			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_4			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_5			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_6			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_7			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_8			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_9			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_10			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_11			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_12			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_13			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_14			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_15			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_16			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_17			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_18			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_19			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_20			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_21			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_22			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_23			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_24			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_25			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_26			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_27			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_28			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_29			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_30			: std_logic_vector(31 downto 0)	:= x"00000000";
		GPIO_INIT_31			: std_logic_vector(31 downto 0)	:= x"00000000";
		-- Do not change
		C_S_AXI_ADDR_WIDTH		: integer			:= 12
	);
	port (
		-- Ports of AXI4-Lite interface
		s_axi_aclk			: in	std_logic;
		s_axi_aresetn			: in	std_logic;
		s_axi_awaddr			: in	std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		s_axi_awvalid			: in	std_logic;
		s_axi_awready			: out	std_logic;
		s_axi_wdata			: in	std_logic_vector(31 downto 0);
		s_axi_wstrb			: in	std_logic_vector(3 downto 0);
		s_axi_wvalid			: in	std_logic;
		s_axi_wready			: out	std_logic;
		s_axi_bresp			: out	std_logic_vector (1 downto 0);
		s_axi_bvalid			: out	std_logic;
		s_axi_bready			: in	std_logic;
		s_axi_araddr			: in	std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		s_axi_arvalid			: in	std_logic;
		s_axi_arready			: out	std_logic;
		s_axi_rdata			: out	std_logic_vector (31 downto 0);
		s_axi_rresp			: out	std_logic_vector (1 downto 0);
		s_axi_rvalid			: out	std_logic;
		s_axi_rready			: in	std_logic;

		-- IO
		gpio_out_0			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_0;
		gpio_out_1			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_1;
		gpio_out_2			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_2;
		gpio_out_3			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_3;
		gpio_out_4			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_4;
		gpio_out_5			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_5;
		gpio_out_6			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_6;
		gpio_out_7			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_7;
		gpio_out_8			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_8;
		gpio_out_9			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_9;
		gpio_out_10			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_10;
		gpio_out_11			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_11;
		gpio_out_12			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_12;
		gpio_out_13			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_13;
		gpio_out_14			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_14;
		gpio_out_15			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_15;
		gpio_out_16			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_16;
		gpio_out_17			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_17;
		gpio_out_18			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_18;
		gpio_out_19			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_19;
		gpio_out_20			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_20;
		gpio_out_21			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_21;
		gpio_out_22			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_22;
		gpio_out_23			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_23;
		gpio_out_24			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_24;
		gpio_out_25			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_25;
		gpio_out_26			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_26;
		gpio_out_27			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_27;
		gpio_out_28			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_28;
		gpio_out_29			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_29;
		gpio_out_30			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_30;
		gpio_out_31			: out	std_logic_vector(31 downto 0)	:= GPIO_INIT_31;

		gpio_out_en			: out	std_logic_vector(31 downto 0)	:= x"00000000";

		gpio_in_0			: in	std_logic_vector(31 downto 0);
		gpio_in_1			: in	std_logic_vector(31 downto 0);
		gpio_in_2			: in	std_logic_vector(31 downto 0);
		gpio_in_3			: in	std_logic_vector(31 downto 0);
		gpio_in_4			: in	std_logic_vector(31 downto 0);
		gpio_in_5			: in	std_logic_vector(31 downto 0);
		gpio_in_6			: in	std_logic_vector(31 downto 0);
		gpio_in_7			: in	std_logic_vector(31 downto 0);
		gpio_in_8			: in	std_logic_vector(31 downto 0);
		gpio_in_9			: in	std_logic_vector(31 downto 0);
		gpio_in_10			: in	std_logic_vector(31 downto 0);
		gpio_in_11			: in	std_logic_vector(31 downto 0);
		gpio_in_12			: in	std_logic_vector(31 downto 0);
		gpio_in_13			: in	std_logic_vector(31 downto 0);
		gpio_in_14			: in	std_logic_vector(31 downto 0);
		gpio_in_15			: in	std_logic_vector(31 downto 0);
		gpio_in_16			: in	std_logic_vector(31 downto 0);
		gpio_in_17			: in	std_logic_vector(31 downto 0);
		gpio_in_18			: in	std_logic_vector(31 downto 0);
		gpio_in_19			: in	std_logic_vector(31 downto 0);
		gpio_in_20			: in	std_logic_vector(31 downto 0);
		gpio_in_21			: in	std_logic_vector(31 downto 0);
		gpio_in_22			: in	std_logic_vector(31 downto 0);
		gpio_in_23			: in	std_logic_vector(31 downto 0);
		gpio_in_24			: in	std_logic_vector(31 downto 0);
		gpio_in_25			: in	std_logic_vector(31 downto 0);
		gpio_in_26			: in	std_logic_vector(31 downto 0);
		gpio_in_27			: in	std_logic_vector(31 downto 0);
		gpio_in_28			: in	std_logic_vector(31 downto 0);
		gpio_in_29			: in	std_logic_vector(31 downto 0);
		gpio_in_30			: in	std_logic_vector(31 downto 0);
		gpio_in_31			: in	std_logic_vector(31 downto 0);

		program_n			: out	std_logic	:= '1';
		scratch				: out	std_logic_vector(31 downto 0)
	);
	end component;

	component amc_common_reg is
	generic (
		MAJOR_VERSION			: integer range 0 to 255	:= 0;
		MINOR_VERSION			: integer range 0 to 255	:= 0;
		PATCH_VERSION			: integer range 0 to 255	:= 0;
		REV_VERSION			: integer range 0 to 255	:= 0;
		SIGNATURE			: std_logic_vector(15 downto 0) := x"0000";
		IMAGE_ID 			: std_logic_vector(15 downto 0) := x"0000";
		-- Do not change
		C_S_AXI_ADDR_WIDTH		: integer			:= 12
	);
	port (
		-- Ports of AXI4-Lite interface
		s_axi_aclk			: in std_logic;
		s_axi_aresetn			: in std_logic;
		s_axi_awaddr			: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		s_axi_awvalid			: in std_logic;
		s_axi_awready			: out std_logic;
		s_axi_wdata			: in std_logic_vector(31 downto 0);
		s_axi_wstrb			: in std_logic_vector(3 downto 0);
		s_axi_wvalid			: in std_logic;
		s_axi_wready			: out std_logic;
		s_axi_bresp			: out std_logic_vector (1 downto 0);
		s_axi_bvalid			: out std_logic;
		s_axi_bready			: in std_logic;
		s_axi_araddr			: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		s_axi_arvalid			: in std_logic;
		s_axi_arready			: out std_logic;
		s_axi_rdata			: out std_logic_vector (31 downto 0);
		s_axi_rresp			: out std_logic_vector (1 downto 0);
		s_axi_rvalid			: out std_logic;
		s_axi_rready			: in std_logic
	);
	end component;

	component axi_spi_sdio is
	generic (
		C_SDI_CS_IDLE			: std_logic	:= '1';
		C_SDI_NUM_OF_SLAVES		: integer	:= 1;
		C_SDI_FREQ_RATIO		: integer	:= 16;
		C_S_AXI_ADDR_WIDTH		: integer	:= 7
	);
	port (
		s_axi_aclk			: in std_logic;
		s_axi_aresetn			: in std_logic;
		s_axi_awaddr			: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		s_axi_awvalid			: in std_logic;
		s_axi_awready			: out std_logic;
		s_axi_wdata			: in std_logic_vector(31 downto 0);
		s_axi_wstrb			: in std_logic_vector(3 downto 0);
		s_axi_wvalid			: in std_logic;
		s_axi_wready			: out std_logic;
		s_axi_bresp			: out std_logic_vector(1 downto 0);
		s_axi_bvalid			: out std_logic;
		s_axi_bready			: in std_logic;
		s_axi_araddr			: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		s_axi_arvalid			: in std_logic;
		s_axi_arready			: out std_logic;
		s_axi_rdata			: out std_logic_vector(31 downto 0);
		s_axi_rresp			: out std_logic_vector(1 downto 0);
		s_axi_rvalid			: out std_logic;
		s_axi_rready			: in std_logic;
		spi_sdio_o			: out std_logic_vector(C_SDI_NUM_OF_SLAVES-1 downto 0);
		spi_sdio_i			: in std_logic_vector(C_SDI_NUM_OF_SLAVES-1 downto 0);
		spi_sclk			: out std_logic_vector(C_SDI_NUM_OF_SLAVES-1 downto 0);
		spi_sdio_t			: out std_logic_vector(C_SDI_NUM_OF_SLAVES-1 downto 0);
		spi_ncs				: out std_logic_vector(C_SDI_NUM_OF_SLAVES-1 downto 0);
		sclk_sb				: out std_logic;
		sdout_sb			: out std_logic;
		sdout_t_sb			: out std_logic;
		ip2intc_irpt			: out std_logic
	);
	end component;

	component axi_lite_rd_fifo is
	generic (
		FIFO_DWIDTH			: integer	:= 32;	-- support 32 only now
		C_S_AXI_ADDR_WIDTH		: integer	:= 12
	);
	port (
		-- Ports of AXI-Lite interface
		s_axi_aclk			: in std_logic;
		s_axi_aresetn			: in std_logic;
		s_axi_awaddr			: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		s_axi_awvalid			: in std_logic;
		s_axi_awready			: out std_logic;
		s_axi_wdata			: in std_logic_vector(31 downto 0);
		s_axi_wstrb			: in std_logic_vector(3 downto 0);
		s_axi_wvalid			: in std_logic;
		s_axi_wready			: out std_logic;
		s_axi_bresp			: out std_logic_vector (1 downto 0);
		s_axi_bvalid			: out std_logic;
		s_axi_bready			: in std_logic;
		s_axi_araddr			: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		s_axi_arvalid			: in std_logic;
		s_axi_arready			: out std_logic;
		s_axi_rdata			: out std_logic_vector (31 downto 0);
		s_axi_rresp			: out std_logic_vector (1 downto 0);
		s_axi_rvalid			: out std_logic;
		s_axi_rready			: in std_logic;
		fifo_rd_en			: out std_logic;
		fifo_dout			: in std_logic_vector(31 downto 0)
	);
	end component;

	component jesd204_0_support is
	port (
		refclk				: in  std_logic;
		rx_core_clk			: in  std_logic;
		common0_pll_clk_out		: out std_logic;
		common0_pll_refclk_out		: out std_logic;
		common0_pll_lock_out		: out std_logic;
		rx_reset			: in  std_logic;
		rx_core_clk_out			: out std_logic;
		rx_sysref			: in  std_logic;
		rx_sync				: out std_logic;
		rxp				: in  std_logic_vector ( 3 downto 0 );
		rxn				: in  std_logic_vector ( 3 downto 0 );
		rx_aresetn			: out std_logic;
		rx_start_of_frame		: out std_logic_vector ( 3 downto 0 );
		rx_end_of_frame			: out std_logic_vector ( 3 downto 0 );
		rx_frame_error			: out std_logic_vector ( 15 downto 0 );
		rx_tvalid			: out std_logic;
		rx_tdata			: out std_logic_vector ( 127 downto 0 );
		drpclk				: in  std_logic;
		s_axi_aclk			: in  std_logic;
		s_axi_aresetn			: in  std_logic;
		s_axi_awaddr			: in  std_logic_vector ( 11 downto 0 );
		s_axi_awvalid			: in  std_logic;
		s_axi_awready			: out std_logic;
		s_axi_wdata			: in  std_logic_vector ( 31 downto 0 );
		s_axi_wstrb			: in  std_logic_vector ( 3 downto 0 );
		s_axi_wvalid			: in  std_logic;
		s_axi_wready			: out std_logic;
		s_axi_bresp			: out std_logic_vector ( 1 downto 0 );
		s_axi_bvalid			: out std_logic;
		s_axi_bready			: in  std_logic;
		s_axi_araddr			: in  std_logic_vector ( 11 downto 0 );
		s_axi_arvalid			: in  std_logic;
		s_axi_arready			: out std_logic;
		s_axi_rdata			: out std_logic_vector ( 31 downto 0 );
		s_axi_rresp			: out std_logic_vector ( 1 downto 0 );
		s_axi_rvalid			: out std_logic;
		s_axi_rready			: in  std_logic
	);
	end component;

	--=================== signals ==================

	-- ADC JESD204 core reset and DAC reset, generated internally
	signal jesd204_core_rst			: std_logic	:= '1';
	signal jesd204_core_clk			: std_logic;
	signal j0_refclk			: std_logic;
	signal j1_refclk			: std_logic;

	-- JESD204 AXI4 Stream output clock and reset
	signal j0_rx_aclk			: std_logic;
	signal j0_rx_aresetn			: std_logic;
	signal j1_rx_aclk			: std_logic;
	signal j1_rx_aresetn			: std_logic;

	-- signals for gpio
	-- signals for GPIO
	signal gpio_out_0			: std_logic_vector(31 downto 0);
	signal gpio_out_1			: std_logic_vector(31 downto 0);
	signal gpio_out_2			: std_logic_vector(31 downto 0);
	signal gpio_out_3			: std_logic_vector(31 downto 0);
	signal gpio_out_4			: std_logic_vector(31 downto 0);
	signal gpio_out_5			: std_logic_vector(31 downto 0);
	signal gpio_out_6			: std_logic_vector(31 downto 0);
	signal gpio_out_7			: std_logic_vector(31 downto 0);
	signal gpio_out_8			: std_logic_vector(31 downto 0);
	signal gpio_out_9			: std_logic_vector(31 downto 0);
	signal gpio_out_10			: std_logic_vector(31 downto 0);
	signal gpio_out_11			: std_logic_vector(31 downto 0);
	signal gpio_out_12			: std_logic_vector(31 downto 0);
	signal gpio_out_13			: std_logic_vector(31 downto 0);
	signal gpio_out_14			: std_logic_vector(31 downto 0);
	signal gpio_out_15			: std_logic_vector(31 downto 0);
	signal gpio_out_16			: std_logic_vector(31 downto 0);
	signal gpio_out_17			: std_logic_vector(31 downto 0);
	signal gpio_out_18			: std_logic_vector(31 downto 0);
	signal gpio_out_19			: std_logic_vector(31 downto 0);
	signal gpio_out_20			: std_logic_vector(31 downto 0);
	signal gpio_out_21			: std_logic_vector(31 downto 0);
	signal gpio_out_22			: std_logic_vector(31 downto 0);
	signal gpio_out_23			: std_logic_vector(31 downto 0);
	signal gpio_out_24			: std_logic_vector(31 downto 0);
	signal gpio_out_25			: std_logic_vector(31 downto 0);
	signal gpio_out_26			: std_logic_vector(31 downto 0);
	signal gpio_out_27			: std_logic_vector(31 downto 0);
	signal gpio_out_28			: std_logic_vector(31 downto 0);
	signal gpio_out_29			: std_logic_vector(31 downto 0);
	signal gpio_out_30			: std_logic_vector(31 downto 0);
	signal gpio_out_31			: std_logic_vector(31 downto 0);
	signal gpio_out_en			: std_logic_vector(31 downto 0);
	signal gpio_in_0			: std_logic_vector(31 downto 0);
	signal gpio_in_1			: std_logic_vector(31 downto 0);
	signal gpio_in_2			: std_logic_vector(31 downto 0);
	signal gpio_in_3			: std_logic_vector(31 downto 0);
	signal gpio_in_4			: std_logic_vector(31 downto 0);
	signal gpio_in_5			: std_logic_vector(31 downto 0);
	signal gpio_in_6			: std_logic_vector(31 downto 0);
	signal gpio_in_7			: std_logic_vector(31 downto 0);
	signal gpio_in_8			: std_logic_vector(31 downto 0);
	signal gpio_in_9			: std_logic_vector(31 downto 0);
	signal gpio_in_10			: std_logic_vector(31 downto 0);
	signal gpio_in_11			: std_logic_vector(31 downto 0);
	signal gpio_in_12			: std_logic_vector(31 downto 0);
	signal gpio_in_13			: std_logic_vector(31 downto 0);
	signal gpio_in_14			: std_logic_vector(31 downto 0);
	signal gpio_in_15			: std_logic_vector(31 downto 0);
	signal gpio_in_16			: std_logic_vector(31 downto 0);
	signal gpio_in_17			: std_logic_vector(31 downto 0);
	signal gpio_in_18			: std_logic_vector(31 downto 0);
	signal gpio_in_19			: std_logic_vector(31 downto 0);
	signal gpio_in_20			: std_logic_vector(31 downto 0);
	signal gpio_in_21			: std_logic_vector(31 downto 0);
	signal gpio_in_22			: std_logic_vector(31 downto 0);
	signal gpio_in_23			: std_logic_vector(31 downto 0);
	signal gpio_in_24			: std_logic_vector(31 downto 0);
	signal gpio_in_25			: std_logic_vector(31 downto 0);
	signal gpio_in_26			: std_logic_vector(31 downto 0);
	signal gpio_in_27			: std_logic_vector(31 downto 0);
	signal gpio_in_28			: std_logic_vector(31 downto 0);
	signal gpio_in_29			: std_logic_vector(31 downto 0);
	signal gpio_in_30			: std_logic_vector(31 downto 0);
	signal gpio_in_31			: std_logic_vector(31 downto 0);
	signal scratch				: std_logic_vector(31 downto 0);

	signal jesd204_core_usr_rst		: std_logic;
	signal jesd204_clk_disable		: std_logic;
	signal jesd204_sysref_disable		: std_logic;
	signal acq_fifo_status			: std_logic_vector(31 downto 0);

	-- fifo signals
	signal rst_fifo				: std_logic;
	signal adc_wr_en			: std_logic;
	signal fifo_rd_en			: std_logic_vector(1 downto 0);
	signal fifo_rd_en_lbc			: std_logic_vector(1 downto 0);
	signal fifo_wr_en			: std_logic_vector(1 downto 0);
	signal fifo_empty			: std_logic_vector(1 downto 0);
	signal fifo_full			: std_logic_vector(1 downto 0);
	signal fifo_almost_empty		: std_logic_vector(1 downto 0);
	signal fifo_din				: std_logic_vector(128*2-1 downto 0);
	signal fifo_din_ar			: std_logic_vector(128*2-1 downto 0);
	signal fifo_dout			: std_logic_vector(32*2-1 downto 0);
	signal fifo_rd_data_count		: std_logic_vector(12*2-1 downto 0);

	-- sdio signals
	signal jesd204b_cg_sdio_i		: std_logic;
	signal jesd204b_cg_sdio_o		: std_logic;
	signal jesd204b_cg_sdio_t		: std_logic;

	signal adc0_sdio_i			: std_logic;
	signal adc0_sdio_o			: std_logic;
	signal adc0_sdio_t			: std_logic;

	signal adc1_sdio_i			: std_logic;
	signal adc1_sdio_o			: std_logic;
	signal adc1_sdio_t			: std_logic;

	signal hmc_adc_spi_sdio_o		: std_logic;
	signal hmc_adc_spi_sdio_i		: std_logic;
	signal hmc_adc_spi_sclk			: std_logic;
	signal hmc_adc_spi_ncs			: std_logic;


	-- JESD204 AXI4 Stream output clock and reset
	signal rx_aclk				: std_logic;
	signal rx_aresetn			: std_logic;
	signal rx_aresetn_inv			: std_logic;

	signal lite_m_axi_awaddr		: std_logic_vector(NUM_OF_MASTERS*32-1 downto 0)	:= (others => '0');
	signal lite_m_axi_awprot		: std_logic_vector(NUM_OF_MASTERS*3-1 downto 0);
	signal lite_m_axi_awvalid		: std_logic_vector(NUM_OF_MASTERS-1 downto 0);
	signal lite_m_axi_awready		: std_logic_vector(NUM_OF_MASTERS-1 downto 0);
	signal lite_m_axi_wdata			: std_logic_vector ( NUM_OF_MASTERS*32-1 downto 0 );
	signal lite_m_axi_wstrb			: std_logic_vector ( NUM_OF_MASTERS*4-1 downto 0 );
	signal lite_m_axi_wvalid		: std_logic_vector(NUM_OF_MASTERS-1 downto 0);
	signal lite_m_axi_wready		: std_logic_vector(NUM_OF_MASTERS-1 downto 0);
	signal lite_m_axi_bresp			: std_logic_vector ( NUM_OF_MASTERS*2-1 downto 0 );
	signal lite_m_axi_bvalid		: std_logic_vector(NUM_OF_MASTERS-1 downto 0);
	signal lite_m_axi_bready		: std_logic_vector(NUM_OF_MASTERS-1 downto 0);
	signal lite_m_axi_araddr		: std_logic_vector ( NUM_OF_MASTERS*32-1 downto 0 )	:= (others => '0');
	signal lite_m_axi_arprot		: std_logic_vector ( NUM_OF_MASTERS*3-1 downto 0 );
	signal lite_m_axi_arvalid		: std_logic_vector(NUM_OF_MASTERS-1 downto 0);
	signal lite_m_axi_arready		: std_logic_vector(NUM_OF_MASTERS-1 downto 0);
	signal lite_m_axi_rdata			: std_logic_vector ( NUM_OF_MASTERS*32-1 downto 0 );
	signal lite_m_axi_rresp			: std_logic_vector ( NUM_OF_MASTERS*2-1 downto 0 );
	signal lite_m_axi_rvalid		: std_logic_vector(NUM_OF_MASTERS-1 downto 0);
	signal lite_m_axi_rready		: std_logic_vector(NUM_OF_MASTERS-1 downto 0);

	signal cb_m_axi_awaddr 			: std_logic_vector (NUM_OF_PORTS*32-1 downto 0 );
	signal cb_m_axi_awprot 			: std_logic_vector (NUM_OF_PORTS*3-1 downto 0 );
	signal cb_m_axi_awvalid 		: std_logic_vector (NUM_OF_PORTS-1 downto 0 );
	signal cb_m_axi_awready 		: std_logic_vector (NUM_OF_PORTS-1 downto 0 );
	signal cb_m_axi_wdata 			: std_logic_vector (NUM_OF_PORTS*32-1 downto 0 );
	signal cb_m_axi_wstrb 			: std_logic_vector (NUM_OF_PORTS*4-1 downto 0 );
	signal cb_m_axi_wvalid 			: std_logic_vector (NUM_OF_PORTS-1 downto 0 );
	signal cb_m_axi_wready 			: std_logic_vector (NUM_OF_PORTS-1 downto 0 );
	signal cb_m_axi_bresp 			: std_logic_vector (NUM_OF_PORTS*2-1 downto 0 );
	signal cb_m_axi_bvalid 			: std_logic_vector (NUM_OF_PORTS-1 downto 0 );
	signal cb_m_axi_bready 			: std_logic_vector (NUM_OF_PORTS-1 downto 0 );
	signal cb_m_axi_araddr 			: std_logic_vector (NUM_OF_PORTS*32-1 downto 0 );
	signal cb_m_axi_arprot 			: std_logic_vector (NUM_OF_PORTS*3-1 downto 0 );
	signal cb_m_axi_arvalid 		: std_logic_vector (NUM_OF_PORTS-1 downto 0 );
	signal cb_m_axi_arready 		: std_logic_vector (NUM_OF_PORTS-1 downto 0 );
	signal cb_m_axi_rdata 			: std_logic_vector (NUM_OF_PORTS*32-1 downto 0 );
	signal cb_m_axi_rresp 			: std_logic_vector (NUM_OF_PORTS*2-1 downto 0 );
	signal cb_m_axi_rvalid 			: std_logic_vector (NUM_OF_PORTS-1 downto 0 );
	signal cb_m_axi_rready 			: std_logic_vector (NUM_OF_PORTS-1 downto 0 );

	-- trigger
	signal trigger_in			: std_logic;
	signal trigger_out			: std_logic;

	signal trig_sel0			: std_logic;
	signal trig_sel1			: std_logic;
	signal trig_to_adc_tmst_en		: std_logic;
	signal trig_to_fpga_en			: std_logic;

	-- JESD204 signals
	signal j0_rxp				: std_logic_vector ( JESD204_LANES-1 downto 0 );
	signal j0_rxn				: std_logic_vector ( JESD204_LANES-1 downto 0 );
	signal j1_rxp				: std_logic_vector ( JESD204_LANES-1 downto 0 );
	signal j1_rxn				: std_logic_vector ( JESD204_LANES-1 downto 0 );

	signal j0_jesd204b_sysref		: std_logic;
	signal j0_jesd204b_aclk			: std_logic;
	signal j0_jesd204b_start_of_frame	: std_logic_vector ( JESD204_LANES-1 downto 0 );
	signal j0_jesd204b_end_of_frame		: std_logic_vector ( JESD204_LANES-1 downto 0 );
	signal j0_jesd204b_frame_error		: std_logic_vector ( JESD204_LANES*4-1 downto 0 );
	signal j0_jesd204b_tvalid		: std_logic;
	signal j0_jesd204b_tdata		: std_logic_vector ( JESD204_LANES*32-1 downto 0 );

	signal j1_jesd204b_sysref		: std_logic;
	signal j1_jesd204b_aclk			: std_logic;
	signal j1_jesd204b_start_of_frame	: std_logic_vector ( JESD204_LANES-1 downto 0 );
	signal j1_jesd204b_end_of_frame		: std_logic_vector ( JESD204_LANES-1 downto 0 );
	signal j1_jesd204b_frame_error		: std_logic_vector ( JESD204_LANES*4-1 downto 0 );
	signal j1_jesd204b_tvalid		: std_logic;
	signal j1_jesd204b_tdata		: std_logic_vector ( JESD204_LANES*32-1 downto 0 );

	signal j0_common0_pll_lock_out		: std_logic;
	signal j0_common0_pll_clk_out		: std_logic;
	signal j0_common0_pll_refclk_out	: std_logic;
	signal j1_common0_pll_lock_out		: std_logic;
	signal j1_common0_pll_clk_out		: std_logic;
	signal j1_common0_pll_refclk_out	: std_logic;
	signal j0_sync				: std_logic;
	signal j1_sync				: std_logic;


	-- adc range signals
	signal adc_range_clear			: std_logic;
	signal adc_data_fmt			: std_logic;
	signal adc_0_range_clr			: std_logic;
	signal adc_1_range_clr			: std_logic;
	signal adc_0_a_min			: std_logic_vector(ADC_BITS-1 downto 0);
	signal adc_0_a_max			: std_logic_vector(ADC_BITS-1 downto 0);
	signal adc_1_a_min			: std_logic_vector(ADC_BITS-1 downto 0);
	signal adc_1_a_max			: std_logic_vector(ADC_BITS-1 downto 0);
	signal adc_0_b_min			: std_logic_vector(ADC_BITS-1 downto 0);
	signal adc_0_b_max			: std_logic_vector(ADC_BITS-1 downto 0);
	signal adc_1_b_min			: std_logic_vector(ADC_BITS-1 downto 0);
	signal adc_1_b_max			: std_logic_vector(ADC_BITS-1 downto 0);

	signal adc_0_a_min_sync			: std_logic_vector(ADC_BITS-1 downto 0);
	signal adc_0_a_max_sync			: std_logic_vector(ADC_BITS-1 downto 0);
	signal adc_1_a_min_sync			: std_logic_vector(ADC_BITS-1 downto 0);
	signal adc_1_a_max_sync			: std_logic_vector(ADC_BITS-1 downto 0);
	signal adc_0_b_min_sync			: std_logic_vector(ADC_BITS-1 downto 0);
	signal adc_0_b_max_sync			: std_logic_vector(ADC_BITS-1 downto 0);
	signal adc_1_b_min_sync			: std_logic_vector(ADC_BITS-1 downto 0);
	signal adc_1_b_max_sync			: std_logic_vector(ADC_BITS-1 downto 0);

	signal j0_tvalid_r			: std_logic;
	signal j1_tvalid_r			: std_logic;

	signal j0_tdata_r			: std_logic_vector(JESD204_LANES*32-1 downto 0);
	signal j1_tdata_r			: std_logic_vector(JESD204_LANES*32-1 downto 0);

	signal j0_valid				: std_logic;
	signal j1_valid				: std_logic;

	signal j0_valid_r			: std_logic;
	signal j1_valid_r			: std_logic;

	signal j0_a_data			: std_logic_vector(63 downto 0);
	signal j0_b_data			: std_logic_vector(63 downto 0);
	signal j1_a_data			: std_logic_vector(63 downto 0);
	signal j1_b_data			: std_logic_vector(63 downto 0);

	signal j0_a_data_r			: std_logic_vector(63 downto 0);
	signal j0_b_data_r			: std_logic_vector(63 downto 0);
	signal j1_a_data_r			: std_logic_vector(63 downto 0);
	signal j1_b_data_r			: std_logic_vector(63 downto 0);

	signal j0_max_i01			: std_logic_vector(ADC_BITS-1 downto 0);
	signal j0_max_i23			: std_logic_vector(ADC_BITS-1 downto 0);
	signal j0_max_q01			: std_logic_vector(ADC_BITS-1 downto 0);
	signal j0_max_q23			: std_logic_vector(ADC_BITS-1 downto 0);
	signal j0_min_i01			: std_logic_vector(ADC_BITS-1 downto 0);
	signal j0_min_i23			: std_logic_vector(ADC_BITS-1 downto 0);
	signal j0_min_q01			: std_logic_vector(ADC_BITS-1 downto 0);
	signal j0_min_q23			: std_logic_vector(ADC_BITS-1 downto 0);

	signal j1_max_i01			: std_logic_vector(ADC_BITS-1 downto 0);
	signal j1_max_i23			: std_logic_vector(ADC_BITS-1 downto 0);
	signal j1_max_q01			: std_logic_vector(ADC_BITS-1 downto 0);
	signal j1_max_q23			: std_logic_vector(ADC_BITS-1 downto 0);
	signal j1_min_i01			: std_logic_vector(ADC_BITS-1 downto 0);
	signal j1_min_i23			: std_logic_vector(ADC_BITS-1 downto 0);
	signal j1_min_q01			: std_logic_vector(ADC_BITS-1 downto 0);
	signal j1_min_q23			: std_logic_vector(ADC_BITS-1 downto 0);

	signal j0_max_i				: std_logic_vector(ADC_BITS-1 downto 0);
	signal j0_max_q				: std_logic_vector(ADC_BITS-1 downto 0);
	signal j0_min_i				: std_logic_vector(ADC_BITS-1 downto 0);
	signal j0_min_q				: std_logic_vector(ADC_BITS-1 downto 0);

	signal j1_max_i				: std_logic_vector(ADC_BITS-1 downto 0);
	signal j1_max_q				: std_logic_vector(ADC_BITS-1 downto 0);
	signal j1_min_i				: std_logic_vector(ADC_BITS-1 downto 0);
	signal j1_min_q				: std_logic_vector(ADC_BITS-1 downto 0);

	-- debug
	signal s_axi_aclk_div2			: std_logic;
	signal j0_rx_aclk_div2			: std_logic;
	signal j1_rx_aclk_div2			: std_logic;
	signal jesd204_core_clk_div2		: std_logic;
	signal misc_dbg_status			: std_logic_vector(29 downto 0);

begin

	lite_m_axi_awaddr		<= s01_axi_awaddr 	& s00_axi_awaddr;
	lite_m_axi_awvalid		<= s01_axi_awvalid 	& s00_axi_awvalid;
	lite_m_axi_wdata		<= s01_axi_wdata	& s00_axi_wdata;
	lite_m_axi_wstrb		<= s01_axi_wstrb	& s00_axi_wstrb;
	lite_m_axi_wvalid		<= s01_axi_wvalid	& s00_axi_wvalid;
	lite_m_axi_bready		<= s01_axi_bready	& s00_axi_bready;
	lite_m_axi_araddr		<= s01_axi_araddr	& s00_axi_araddr;
	lite_m_axi_arvalid		<= s01_axi_arvalid	& s00_axi_arvalid;
	lite_m_axi_rready		<= s01_axi_rready	& s00_axi_rready;

	s01_axi_awready			<= lite_m_axi_awready(1);
	s01_axi_wready	                <= lite_m_axi_wready(1);
	s01_axi_bresp	                <= lite_m_axi_bresp(3 downto 2);
	s01_axi_bvalid	                <= lite_m_axi_bvalid(1);
	s01_axi_arready	                <= lite_m_axi_arready(1);
	s01_axi_rdata	                <= lite_m_axi_rdata(63 downto 32);
	s01_axi_rresp	                <= lite_m_axi_rresp(3 downto 2);
	s01_axi_rvalid	                <= lite_m_axi_rvalid(1);

	s00_axi_awready			<= lite_m_axi_awready(0);
	s00_axi_wready	                <= lite_m_axi_wready(0);
	s00_axi_bresp	                <= lite_m_axi_bresp(1 downto 0);
	s00_axi_bvalid	                <= lite_m_axi_bvalid(0);
	s00_axi_arready	                <= lite_m_axi_arready(0);
	s00_axi_rdata	                <= lite_m_axi_rdata(31 downto 0);
	s00_axi_rresp	                <= lite_m_axi_rresp(1 downto 0);
	s00_axi_rvalid	                <= lite_m_axi_rvalid(0);

	lite_m_axi_awprot		<= (others => '0');
	lite_m_axi_arprot		<= (others => '0');
	
	
	axi_crossbar_0_inst: axi_crossbar_0
	port map(
		aclk				=> s_axi_aclk,
		aresetn				=> s_axi_aresetn,
		s_axi_awaddr			=> lite_m_axi_awaddr,
		s_axi_awprot			=> lite_m_axi_awprot,
		s_axi_awvalid			=> lite_m_axi_awvalid,
		s_axi_awready			=> lite_m_axi_awready,
		s_axi_wdata			=> lite_m_axi_wdata,
		s_axi_wstrb			=> lite_m_axi_wstrb,
		s_axi_wvalid			=> lite_m_axi_wvalid,
		s_axi_wready			=> lite_m_axi_wready,
		s_axi_bresp			=> lite_m_axi_bresp,
		s_axi_bvalid			=> lite_m_axi_bvalid,
		s_axi_bready			=> lite_m_axi_bready,
		s_axi_araddr			=> lite_m_axi_araddr,
		s_axi_arprot			=> lite_m_axi_arprot,
		s_axi_arvalid			=> lite_m_axi_arvalid,
		s_axi_arready			=> lite_m_axi_arready,
		s_axi_rdata			=> lite_m_axi_rdata,
		s_axi_rresp			=> lite_m_axi_rresp,
		s_axi_rvalid			=> lite_m_axi_rvalid,
		s_axi_rready			=> lite_m_axi_rready,
		m_axi_awaddr			=> cb_m_axi_awaddr,
		m_axi_awprot			=> cb_m_axi_awprot,
		m_axi_awvalid			=> cb_m_axi_awvalid,
		m_axi_awready			=> cb_m_axi_awready,
		m_axi_wdata			=> cb_m_axi_wdata,
		m_axi_wstrb			=> cb_m_axi_wstrb,
		m_axi_wvalid			=> cb_m_axi_wvalid,
		m_axi_wready			=> cb_m_axi_wready,
		m_axi_bresp			=> cb_m_axi_bresp,
		m_axi_bvalid			=> cb_m_axi_bvalid,
		m_axi_bready			=> cb_m_axi_bready,
		m_axi_araddr			=> cb_m_axi_araddr,
		m_axi_arprot			=> cb_m_axi_arprot,
		m_axi_arvalid			=> cb_m_axi_arvalid,
		m_axi_arready			=> cb_m_axi_arready,
		m_axi_rdata			=> cb_m_axi_rdata,
		m_axi_rresp			=> cb_m_axi_rresp,
		m_axi_rvalid			=> cb_m_axi_rvalid,
		m_axi_rready			=> cb_m_axi_rready
	);

	amc_common_reg_inst: amc_common_reg
	generic map(
		MAJOR_VERSION			=> MAJOR_VERSION,
		MINOR_VERSION			=> MINOR_VERSION,
		PATCH_VERSION			=> PATCH_VERSION,
		REV_VERSION			=> REV_VERSION,
		SIGNATURE			=> SIGNATURE,
		IMAGE_ID 			=> IMAGE_ID
	)
	port map(
		s_axi_aclk			=> s_axi_aclk,
		s_axi_aresetn			=> s_axi_aresetn,
		s_axi_awaddr			=> cb_m_axi_awaddr(32*AMC_COMMON_PORT+AMC_COMMON_AWIDTH-1 downto 32*AMC_COMMON_PORT),
		s_axi_awvalid			=> cb_m_axi_awvalid(AMC_COMMON_PORT),
		s_axi_awready			=> cb_m_axi_awready(AMC_COMMON_PORT),
		s_axi_wdata			=> cb_m_axi_wdata(32*(AMC_COMMON_PORT+1)-1 downto 32*AMC_COMMON_PORT),
		s_axi_wstrb			=> cb_m_axi_wstrb(4*(AMC_COMMON_PORT+1)-1 downto 4*AMC_COMMON_PORT),
		s_axi_wvalid			=> cb_m_axi_wvalid(AMC_COMMON_PORT),
		s_axi_wready			=> cb_m_axi_wready(AMC_COMMON_PORT),
		s_axi_bresp			=> cb_m_axi_bresp(2*(AMC_COMMON_PORT+1)-1 downto 2*AMC_COMMON_PORT),
		s_axi_bvalid			=> cb_m_axi_bvalid(AMC_COMMON_PORT),
		s_axi_bready			=> cb_m_axi_bready(AMC_COMMON_PORT),
		s_axi_araddr			=> cb_m_axi_araddr(32*AMC_COMMON_PORT+AMC_COMMON_AWIDTH-1 downto 32*AMC_COMMON_PORT),
		s_axi_arvalid			=> cb_m_axi_arvalid(AMC_COMMON_PORT),
		s_axi_arready			=> cb_m_axi_arready(AMC_COMMON_PORT),
		s_axi_rdata			=> cb_m_axi_rdata(32*(AMC_COMMON_PORT+1)-1 downto 32*AMC_COMMON_PORT),
		s_axi_rresp			=> cb_m_axi_rresp(2*(AMC_COMMON_PORT+1)-1 downto 2*AMC_COMMON_PORT),
		s_axi_rvalid			=> cb_m_axi_rvalid(AMC_COMMON_PORT),
		s_axi_rready			=> cb_m_axi_rready(AMC_COMMON_PORT)
	);

	-- ========== Xilinx JESD204 core rx_reset is asynchronous active high ========
	jesd204_core_rst			<= jesd204_core_usr_rst;

	-- Bring in the jesd204 refclk
	ibufds_gte2_inst_jesd204_0_refclk : IBUFDS_GTE2
	port map (
		O				=> j0_refclk,
		ODIV2				=> open,
		CEB				=> '0',
		I				=> FMC_GBTCLK0_P,
		IB				=> FMC_GBTCLK0_N
	);

	-- use jesd204_0 refclk for jesd204 core clock
	bufg_inst_jesd204_core_clk : BUFG
	port map (
		O				=> jesd204_core_clk,
		I				=> j0_refclk
	);

	-- Vivado 2016.1 change
	j0_rx_aclk				<= jesd204_core_clk;
	j1_rx_aclk				<= jesd204_core_clk;
	
	jesd204_0_inst_0: jesd204_0_support
	port map(
		-- refclk_p			=> FMC_GBTCLK0_P,
		-- refclk_n			=> FMC_GBTCLK0_N,
		-- glblclk_p			=> FMC_LA_P17,
		-- glblclk_n			=> FMC_LA_N17,
		refclk				=> j0_refclk,
		rx_core_clk			=> jesd204_core_clk,
		common0_pll_clk_out		=> j0_common0_pll_clk_out,
		common0_pll_refclk_out		=> j0_common0_pll_refclk_out,
		common0_pll_lock_out		=> j0_common0_pll_lock_out,
		rx_reset			=> jesd204_core_rst,
		rx_core_clk_out			=> open,
		rx_sysref			=> j0_jesd204b_sysref,
		rx_sync				=> j0_sync,
		rxp				=> j0_rxp,
		rxn				=> j0_rxn,
		rx_aresetn			=> j0_rx_aresetn,
		rx_start_of_frame		=> j0_jesd204b_start_of_frame,
		rx_end_of_frame			=> j0_jesd204b_end_of_frame,
		rx_frame_error			=> j0_jesd204b_frame_error,
		rx_tvalid			=> j0_jesd204b_tvalid,
		rx_tdata			=> j0_jesd204b_tdata,
		drpclk				=> s_axi_aclk,
		s_axi_aclk			=> s_axi_aclk,
		s_axi_aresetn			=> s_axi_aresetn,
		s_axi_awaddr			=> cb_m_axi_awaddr(32*JESD0_PORT+JESD0_AWIDTH-1 downto 32*JESD0_PORT),
		s_axi_awvalid			=> cb_m_axi_awvalid(JESD0_PORT),
		s_axi_awready			=> cb_m_axi_awready(JESD0_PORT),
		s_axi_wdata			=> cb_m_axi_wdata(32*(JESD0_PORT+1)-1 downto 32*JESD0_PORT),
		s_axi_wstrb			=> cb_m_axi_wstrb(4*(JESD0_PORT+1)-1 downto 4*JESD0_PORT),
		s_axi_wvalid			=> cb_m_axi_wvalid(JESD0_PORT),
		s_axi_wready			=> cb_m_axi_wready(JESD0_PORT),
		s_axi_bresp			=> cb_m_axi_bresp(2*(JESD0_PORT+1)-1 downto 2*JESD0_PORT),
		s_axi_bvalid			=> cb_m_axi_bvalid(JESD0_PORT),
		s_axi_bready			=> cb_m_axi_bready(JESD0_PORT),
		s_axi_araddr			=> cb_m_axi_araddr(32*JESD0_PORT+JESD0_AWIDTH-1 downto 32*JESD0_PORT),
		s_axi_arvalid			=> cb_m_axi_arvalid(JESD0_PORT),
		s_axi_arready			=> cb_m_axi_arready(JESD0_PORT),
		s_axi_rdata			=> cb_m_axi_rdata(32*(JESD0_PORT+1)-1 downto 32*JESD0_PORT),
		s_axi_rresp			=> cb_m_axi_rresp(2*(JESD0_PORT+1)-1 downto 2*JESD0_PORT),
		s_axi_rvalid			=> cb_m_axi_rvalid(JESD0_PORT),
		s_axi_rready			=> cb_m_axi_rready(JESD0_PORT)
	);

	OBUFDS_inst_j0_sync : OBUFDS
	generic map (
		IOSTANDARD 			=> LVDS_STANDARD
	)
	port map (
		O				=> FMC_LA_P3,
		OB				=> FMC_LA_N3,
		I				=> j0_sync
	);



	jesd204_0_inst_1: jesd204_0_support
	port map(
		-- refclk_p			=> FMC_GBTCLK1_P,
		-- refclk_n			=> FMC_GBTCLK1_N,
		-- glblclk_p			=> FMC_LA_P0,
		-- glblclk_n			=> FMC_LA_N0,
		refclk				=> j0_refclk,
		rx_core_clk			=> jesd204_core_clk,
		common0_pll_clk_out		=> j1_common0_pll_clk_out,
		common0_pll_refclk_out		=> j1_common0_pll_refclk_out,
		common0_pll_lock_out		=> j1_common0_pll_lock_out,
		rx_reset			=> jesd204_core_rst,
		rx_core_clk_out			=> open,
		rx_sysref			=> j1_jesd204b_sysref,
		rx_sync				=> j1_sync,
		rxp				=> j1_rxp,
		rxn				=> j1_rxn,
		rx_aresetn			=> j1_rx_aresetn,
		rx_start_of_frame		=> j1_jesd204b_start_of_frame,
		rx_end_of_frame			=> j1_jesd204b_end_of_frame,
		rx_frame_error			=> j1_jesd204b_frame_error,
		rx_tvalid			=> j1_jesd204b_tvalid,
		rx_tdata			=> j1_jesd204b_tdata,
		drpclk				=> s_axi_aclk,
		s_axi_aclk			=> s_axi_aclk,
		s_axi_aresetn			=> s_axi_aresetn,
		s_axi_awaddr			=> cb_m_axi_awaddr(32*JESD1_PORT+JESD1_AWIDTH-1 downto 32*JESD1_PORT),
		s_axi_awvalid			=> cb_m_axi_awvalid(JESD1_PORT),
		s_axi_awready			=> cb_m_axi_awready(JESD1_PORT),
		s_axi_wdata			=> cb_m_axi_wdata(32*(JESD1_PORT+1)-1 downto 32*JESD1_PORT),
		s_axi_wstrb			=> cb_m_axi_wstrb(4*(JESD1_PORT+1)-1 downto 4*JESD1_PORT),
		s_axi_wvalid			=> cb_m_axi_wvalid(JESD1_PORT),
		s_axi_wready			=> cb_m_axi_wready(JESD1_PORT),
		s_axi_bresp			=> cb_m_axi_bresp(2*(JESD1_PORT+1)-1 downto 2*JESD1_PORT),
		s_axi_bvalid			=> cb_m_axi_bvalid(JESD1_PORT),
		s_axi_bready			=> cb_m_axi_bready(JESD1_PORT),
		s_axi_araddr			=> cb_m_axi_araddr(32*JESD1_PORT+JESD1_AWIDTH-1 downto 32*JESD1_PORT),
		s_axi_arvalid			=> cb_m_axi_arvalid(JESD1_PORT),
		s_axi_arready			=> cb_m_axi_arready(JESD1_PORT),
		s_axi_rdata			=> cb_m_axi_rdata(32*(JESD1_PORT+1)-1 downto 32*JESD1_PORT),
		s_axi_rresp			=> cb_m_axi_rresp(2*(JESD1_PORT+1)-1 downto 2*JESD1_PORT),
		s_axi_rvalid			=> cb_m_axi_rvalid(JESD1_PORT),
		s_axi_rready			=> cb_m_axi_rready(JESD1_PORT)
	);

	OBUFDS_inst_j1_sync : OBUFDS
	generic map (
		IOSTANDARD 			=> LVDS_STANDARD
	)
	port map (
		O				=> FMC_LA_P4,
		OB				=> FMC_LA_N4,
		I				=> j1_sync
	);


	j1_rxp			<= FMC_RX7_P & FMC_RX6_P & FMC_RX5_P & FMC_RX4_P;
	j0_rxp			<= FMC_RX3_P & FMC_RX2_P & FMC_RX1_P & FMC_RX0_P;

	j1_rxn			<= FMC_RX7_N & FMC_RX6_N & FMC_RX5_N & FMC_RX4_N;
	j0_rxn			<= FMC_RX3_N & FMC_RX2_N & FMC_RX1_N & FMC_RX0_N;


	IBUFDS_inst_jesd204b_sysref_0 : IBUFDS_IBUFDISABLE
	generic map (
		IOSTANDARD 			=> LVDS_STANDARD,
		DIFF_TERM			=> "TRUE",
		USE_IBUFDISABLE			=> "TRUE"
	)
	port map (
		O				=> j0_jesd204b_sysref,
		I				=> FMC_LA_P1,
		IB				=> FMC_LA_N1,
		IBUFDISABLE			=> jesd204_sysref_disable
	);

	IBUFDS_inst_jesd204b_sysref_1 : IBUFDS_IBUFDISABLE
	generic map (
		IOSTANDARD 			=> LVDS_STANDARD,
		DIFF_TERM			=> "TRUE",
		USE_IBUFDISABLE			=> "TRUE"
	)
	port map (
		O				=> j1_jesd204b_sysref,
		I				=> FMC_LA_P18,
		IB				=> FMC_LA_N18,
		IBUFDISABLE			=> jesd204_sysref_disable
	);

	-- SPI_SDIO instantiation for accessing jesd204 clock generator LMK04828B registers
	axi_spi_sdio_inst_jesd204b_cg: axi_spi_sdio
	generic map(
		C_SDI_CS_IDLE			=> '1',
		C_SDI_NUM_OF_SLAVES		=> 1,
		C_SDI_FREQ_RATIO		=> 16,
		C_S_AXI_ADDR_WIDTH		=> 7
	)
	port map(
		s_axi_aclk			=> s_axi_aclk,
		s_axi_aresetn			=> s_axi_aresetn,
		s_axi_awaddr			=> cb_m_axi_awaddr(32*SDIO_CG_PORT+SDIO_CG_AWIDTH-1 downto 32*SDIO_CG_PORT),
		s_axi_awvalid			=> cb_m_axi_awvalid(SDIO_CG_PORT),
		s_axi_awready			=> cb_m_axi_awready(SDIO_CG_PORT),
		s_axi_wdata			=> cb_m_axi_wdata(32*(SDIO_CG_PORT+1)-1 downto 32*SDIO_CG_PORT),
		s_axi_wstrb			=> cb_m_axi_wstrb(4*(SDIO_CG_PORT+1)-1 downto 4*SDIO_CG_PORT),
		s_axi_wvalid			=> cb_m_axi_wvalid(SDIO_CG_PORT),
		s_axi_wready			=> cb_m_axi_wready(SDIO_CG_PORT),
		s_axi_bresp			=> cb_m_axi_bresp(2*(SDIO_CG_PORT+1)-1 downto 2*SDIO_CG_PORT),
		s_axi_bvalid			=> cb_m_axi_bvalid(SDIO_CG_PORT),
		s_axi_bready			=> cb_m_axi_bready(SDIO_CG_PORT),
		s_axi_araddr			=> cb_m_axi_araddr(32*SDIO_CG_PORT+SDIO_CG_AWIDTH-1 downto 32*SDIO_CG_PORT),
		s_axi_arvalid			=> cb_m_axi_arvalid(SDIO_CG_PORT),
		s_axi_arready			=> cb_m_axi_arready(SDIO_CG_PORT),
		s_axi_rdata			=> cb_m_axi_rdata(32*(SDIO_CG_PORT+1)-1 downto 32*SDIO_CG_PORT),
		s_axi_rresp			=> cb_m_axi_rresp(2*(SDIO_CG_PORT+1)-1 downto 2*SDIO_CG_PORT),
		s_axi_rvalid			=> cb_m_axi_rvalid(SDIO_CG_PORT),
		s_axi_rready			=> cb_m_axi_rready(SDIO_CG_PORT),
		spi_sdio_o(0)			=> jesd204b_cg_sdio_o,
		spi_sdio_i(0)			=> jesd204b_cg_sdio_i,
		spi_sclk(0)			=> FMC_LA_N13,
		spi_sdio_t(0)			=> jesd204b_cg_sdio_t,
		spi_ncs(0)			=> FMC_LA_P13,
		sclk_sb				=> open,
		sdout_sb			=> open,
		sdout_t_sb			=> open,
		ip2intc_irpt			=> open
	);

	IOBUF_inst_jesd204b_cg_sdio: IOBUF
	generic map (
		DRIVE				=> 12,
		SLEW				=> "SLOW"
	)
	port map (
		O				=> jesd204b_cg_sdio_i,
		IO				=> FMC_LA_N15,
		I				=> jesd204b_cg_sdio_o,
		T				=> jesd204b_cg_sdio_t
	);

	FMC_LA_N14				<= not(jesd204b_cg_sdio_t);
	FMC_LA_P15				<= '1';

	-- SPI_SDIO instantiation for accessing HMC835LP6GE frequency synthesizer (to ADC)
	axi_spi_sdio_inst_hmc_adc: axi_spi_sdio
	generic map(
		C_SDI_CS_IDLE			=> '1',
		C_SDI_NUM_OF_SLAVES		=> 1,
		C_SDI_FREQ_RATIO		=> 16,
		C_S_AXI_ADDR_WIDTH		=> 7
	)
	port map(
		s_axi_aclk			=> s_axi_aclk,
		s_axi_aresetn			=> s_axi_aresetn,
		s_axi_awaddr			=> cb_m_axi_awaddr(32*SDIO_HMC_PORT+SDIO_HMC_AWIDTH-1 downto 32*SDIO_HMC_PORT),
		s_axi_awvalid			=> cb_m_axi_awvalid(SDIO_HMC_PORT),
		s_axi_awready			=> cb_m_axi_awready(SDIO_HMC_PORT),
		s_axi_wdata			=> cb_m_axi_wdata(32*(SDIO_HMC_PORT+1)-1 downto 32*SDIO_HMC_PORT),
		s_axi_wstrb			=> cb_m_axi_wstrb(4*(SDIO_HMC_PORT+1)-1 downto 4*SDIO_HMC_PORT),
		s_axi_wvalid			=> cb_m_axi_wvalid(SDIO_HMC_PORT),
		s_axi_wready			=> cb_m_axi_wready(SDIO_HMC_PORT),
		s_axi_bresp			=> cb_m_axi_bresp(2*(SDIO_HMC_PORT+1)-1 downto 2*SDIO_HMC_PORT),
		s_axi_bvalid			=> cb_m_axi_bvalid(SDIO_HMC_PORT),
		s_axi_bready			=> cb_m_axi_bready(SDIO_HMC_PORT),
		s_axi_araddr			=> cb_m_axi_araddr(32*SDIO_HMC_PORT+SDIO_HMC_AWIDTH-1 downto 32*SDIO_HMC_PORT),
		s_axi_arvalid			=> cb_m_axi_arvalid(SDIO_HMC_PORT),
		s_axi_arready			=> cb_m_axi_arready(SDIO_HMC_PORT),
		s_axi_rdata			=> cb_m_axi_rdata(32*(SDIO_HMC_PORT+1)-1 downto 32*SDIO_HMC_PORT),
		s_axi_rresp			=> cb_m_axi_rresp(2*(SDIO_HMC_PORT+1)-1 downto 2*SDIO_HMC_PORT),
		s_axi_rvalid			=> cb_m_axi_rvalid(SDIO_HMC_PORT),
		s_axi_rready			=> cb_m_axi_rready(SDIO_HMC_PORT),
		spi_sdio_o(0)			=> hmc_adc_spi_sdio_o,
		spi_sdio_i(0)			=> hmc_adc_spi_sdio_i,
		spi_sclk(0)			=> hmc_adc_spi_sclk,
		spi_sdio_t			=> open,
		spi_ncs(0)			=> hmc_adc_spi_ncs,
		sclk_sb				=> open,
		sdout_sb			=> open,
		sdout_t_sb			=> open,
		ip2intc_irpt			=> open
	);

	FMC_LA_N20				<= hmc_adc_spi_sdio_o;
	hmc_adc_spi_sdio_i			<= FMC_LA_P20;
	FMC_LA_N19				<= hmc_adc_spi_sclk;
	FMC_LA_N21				<= hmc_adc_spi_ncs;


	-- SPI_SDIO instantiation for accessing ad9234 ADC 0
	axi_spi_sdio_inst_adc_0: axi_spi_sdio
	generic map(
		C_SDI_CS_IDLE			=> '1',
		C_SDI_NUM_OF_SLAVES		=> 1,
		C_SDI_FREQ_RATIO		=> 16,
		C_S_AXI_ADDR_WIDTH		=> 7
	)
	port map(
		s_axi_aclk			=> s_axi_aclk,
		s_axi_aresetn			=> s_axi_aresetn,
		s_axi_awaddr			=> cb_m_axi_awaddr(32*SDIO_ADC0_PORT+SDIO_ADC0_AWIDTH-1 downto 32*SDIO_ADC0_PORT),
		s_axi_awvalid			=> cb_m_axi_awvalid(SDIO_ADC0_PORT),
		s_axi_awready			=> cb_m_axi_awready(SDIO_ADC0_PORT),
		s_axi_wdata			=> cb_m_axi_wdata(32*(SDIO_ADC0_PORT+1)-1 downto 32*SDIO_ADC0_PORT),
		s_axi_wstrb			=> cb_m_axi_wstrb(4*(SDIO_ADC0_PORT+1)-1 downto 4*SDIO_ADC0_PORT),
		s_axi_wvalid			=> cb_m_axi_wvalid(SDIO_ADC0_PORT),
		s_axi_wready			=> cb_m_axi_wready(SDIO_ADC0_PORT),
		s_axi_bresp			=> cb_m_axi_bresp(2*(SDIO_ADC0_PORT+1)-1 downto 2*SDIO_ADC0_PORT),
		s_axi_bvalid			=> cb_m_axi_bvalid(SDIO_ADC0_PORT),
		s_axi_bready			=> cb_m_axi_bready(SDIO_ADC0_PORT),
		s_axi_araddr			=> cb_m_axi_araddr(32*SDIO_ADC0_PORT+SDIO_ADC0_AWIDTH-1 downto 32*SDIO_ADC0_PORT),
		s_axi_arvalid			=> cb_m_axi_arvalid(SDIO_ADC0_PORT),
		s_axi_arready			=> cb_m_axi_arready(SDIO_ADC0_PORT),
		s_axi_rdata			=> cb_m_axi_rdata(32*(SDIO_ADC0_PORT+1)-1 downto 32*SDIO_ADC0_PORT),
		s_axi_rresp			=> cb_m_axi_rresp(2*(SDIO_ADC0_PORT+1)-1 downto 2*SDIO_ADC0_PORT),
		s_axi_rvalid			=> cb_m_axi_rvalid(SDIO_ADC0_PORT),
		s_axi_rready			=> cb_m_axi_rready(SDIO_ADC0_PORT),
		spi_sdio_o(0)			=> adc0_sdio_o,
		spi_sdio_i(0)			=> adc0_sdio_i,
		spi_sclk(0)			=> FMC_LA_N5,
		spi_sdio_t(0)			=> adc0_sdio_t,
		spi_ncs(0)			=> FMC_LA_P5,
		sclk_sb				=> open,
		sdout_sb			=> open,
		sdout_t_sb			=> open,
		ip2intc_irpt			=> open
	);

	IOBUF_inst_adc0_sdio: IOBUF
	generic map (
		DRIVE				=> 12,
		SLEW				=> "SLOW"
	)
	port map (
		O				=> adc0_sdio_i,
		IO				=> FMC_LA_N6,
		I				=> adc0_sdio_o,
		T				=> adc0_sdio_t
	);

	FMC_LA_P6				<= not(adc0_sdio_t);

	-- SPI_SDIO instantiation for accessing ad9234 ADC 1
	axi_spi_sdio_inst_adc_1: axi_spi_sdio
	generic map(
		C_SDI_CS_IDLE			=> '1',
		C_SDI_NUM_OF_SLAVES		=> 1,
		C_SDI_FREQ_RATIO		=> 16,
		C_S_AXI_ADDR_WIDTH		=> 7
	)
	port map(
		s_axi_aclk			=> s_axi_aclk,
		s_axi_aresetn			=> s_axi_aresetn,
		s_axi_awaddr			=> cb_m_axi_awaddr(32*SDIO_ADC1_PORT+SDIO_ADC1_AWIDTH-1 downto 32*SDIO_ADC1_PORT),
		s_axi_awvalid			=> cb_m_axi_awvalid(SDIO_ADC1_PORT),
		s_axi_awready			=> cb_m_axi_awready(SDIO_ADC1_PORT),
		s_axi_wdata			=> cb_m_axi_wdata(32*(SDIO_ADC1_PORT+1)-1 downto 32*SDIO_ADC1_PORT),
		s_axi_wstrb			=> cb_m_axi_wstrb(4*(SDIO_ADC1_PORT+1)-1 downto 4*SDIO_ADC1_PORT),
		s_axi_wvalid			=> cb_m_axi_wvalid(SDIO_ADC1_PORT),
		s_axi_wready			=> cb_m_axi_wready(SDIO_ADC1_PORT),
		s_axi_bresp			=> cb_m_axi_bresp(2*(SDIO_ADC1_PORT+1)-1 downto 2*SDIO_ADC1_PORT),
		s_axi_bvalid			=> cb_m_axi_bvalid(SDIO_ADC1_PORT),
		s_axi_bready			=> cb_m_axi_bready(SDIO_ADC1_PORT),
		s_axi_araddr			=> cb_m_axi_araddr(32*SDIO_ADC1_PORT+SDIO_ADC1_AWIDTH-1 downto 32*SDIO_ADC1_PORT),
		s_axi_arvalid			=> cb_m_axi_arvalid(SDIO_ADC1_PORT),
		s_axi_arready			=> cb_m_axi_arready(SDIO_ADC1_PORT),
		s_axi_rdata			=> cb_m_axi_rdata(32*(SDIO_ADC1_PORT+1)-1 downto 32*SDIO_ADC1_PORT),
		s_axi_rresp			=> cb_m_axi_rresp(2*(SDIO_ADC1_PORT+1)-1 downto 2*SDIO_ADC1_PORT),
		s_axi_rvalid			=> cb_m_axi_rvalid(SDIO_ADC1_PORT),
		s_axi_rready			=> cb_m_axi_rready(SDIO_ADC1_PORT),
		spi_sdio_o(0)			=> adc1_sdio_o,
		spi_sdio_i(0)			=> adc1_sdio_i,
		spi_sclk(0)			=> FMC_LA_N9,
		spi_sdio_t(0)			=> adc1_sdio_t,
		spi_ncs(0)			=> FMC_LA_P9,
		sclk_sb				=> open,
		sdout_sb			=> open,
		sdout_t_sb			=> open,
		ip2intc_irpt			=> open
	);

	IOBUF_inst_adc1_sdio: IOBUF
	generic map (
		DRIVE				=> 12,
		SLEW				=> "SLOW"
	)
	port map (
		O				=> adc1_sdio_i,
		IO				=> FMC_LA_N10,
		I				=> adc1_sdio_o,
		T				=> adc1_sdio_t
	);

	FMC_LA_P10				<= not(adc1_sdio_t);

	-- ============= GPIO ==================
	axi_gpio_32_inst: axi_gpio_32
	generic map(
		MAJOR_VERSION			=> MAJOR_VERSION,
		MINOR_VERSION			=> MINOR_VERSION,
		PATCH_VERSION			=> PATCH_VERSION,
		REV_VERSION			=> REV_VERSION,
		SIGNATURE			=> SIGNATURE,
		IMAGE_ID			=> IMAGE_ID,
		GPIO_INIT_4			=> x"00000008",
		GPIO_INIT_8			=> x"00000003",
		GPIO_INIT_21			=> x"00000001",
		GPIO_INIT_28			=> x"00000007"

	)
	port map(
		s_axi_aclk			=> s_axi_aclk,
		s_axi_aresetn			=> s_axi_aresetn,
		s_axi_awaddr			=> cb_m_axi_awaddr(32*AXI_GPIO_PORT+AXI_GPIO_AWIDTH-1 downto 32*AXI_GPIO_PORT),
		s_axi_awvalid			=> cb_m_axi_awvalid(AXI_GPIO_PORT),
		s_axi_awready			=> cb_m_axi_awready(AXI_GPIO_PORT),
		s_axi_wdata			=> cb_m_axi_wdata(32*(AXI_GPIO_PORT+1)-1 downto 32*AXI_GPIO_PORT),
		s_axi_wstrb			=> cb_m_axi_wstrb(4*(AXI_GPIO_PORT+1)-1 downto 4*AXI_GPIO_PORT),
		s_axi_wvalid			=> cb_m_axi_wvalid(AXI_GPIO_PORT),
		s_axi_wready			=> cb_m_axi_wready(AXI_GPIO_PORT),
		s_axi_bresp			=> cb_m_axi_bresp(2*(AXI_GPIO_PORT+1)-1 downto 2*AXI_GPIO_PORT),
		s_axi_bvalid			=> cb_m_axi_bvalid(AXI_GPIO_PORT),
		s_axi_bready			=> cb_m_axi_bready(AXI_GPIO_PORT),
		s_axi_araddr			=> cb_m_axi_araddr(32*AXI_GPIO_PORT+AXI_GPIO_AWIDTH-1 downto 32*AXI_GPIO_PORT),
		s_axi_arvalid			=> cb_m_axi_arvalid(AXI_GPIO_PORT),
		s_axi_arready			=> cb_m_axi_arready(AXI_GPIO_PORT),
		s_axi_rdata			=> cb_m_axi_rdata(32*(AXI_GPIO_PORT+1)-1 downto 32*AXI_GPIO_PORT),
		s_axi_rresp			=> cb_m_axi_rresp(2*(AXI_GPIO_PORT+1)-1 downto 2*AXI_GPIO_PORT),
		s_axi_rvalid			=> cb_m_axi_rvalid(AXI_GPIO_PORT),
		s_axi_rready			=> cb_m_axi_rready(AXI_GPIO_PORT),

		gpio_out_0			=> gpio_out_0,
		gpio_out_1			=> gpio_out_1,
		gpio_out_2			=> gpio_out_2,
		gpio_out_3			=> gpio_out_3,
		gpio_out_4			=> gpio_out_4,
		gpio_out_5			=> gpio_out_5,
		gpio_out_6			=> gpio_out_6,
		gpio_out_7			=> gpio_out_7,
		gpio_out_8			=> gpio_out_8,
		gpio_out_9			=> gpio_out_9,
		gpio_out_10			=> gpio_out_10,
		gpio_out_11			=> gpio_out_11,
		gpio_out_12			=> gpio_out_12,
		gpio_out_13			=> gpio_out_13,
		gpio_out_14			=> gpio_out_14,
		gpio_out_15			=> gpio_out_15,
		gpio_out_16			=> gpio_out_16,
		gpio_out_17			=> gpio_out_17,
		gpio_out_18			=> gpio_out_18,
		gpio_out_19			=> gpio_out_19,
		gpio_out_20			=> gpio_out_20,
		gpio_out_21			=> gpio_out_21,
		gpio_out_22			=> gpio_out_22,
		gpio_out_23			=> gpio_out_23,
		gpio_out_24			=> gpio_out_24,
		gpio_out_25			=> gpio_out_25,
		gpio_out_26			=> gpio_out_26,
		gpio_out_27			=> gpio_out_27,
		gpio_out_28			=> gpio_out_28,
		gpio_out_29			=> gpio_out_29,
		gpio_out_30			=> gpio_out_30,
		gpio_out_31			=> gpio_out_31,
		gpio_out_en			=> gpio_out_en,
		gpio_in_0			=> gpio_in_0,
		gpio_in_1			=> gpio_in_1,
		gpio_in_2			=> gpio_in_2,
		gpio_in_3			=> gpio_in_3,
		gpio_in_4			=> gpio_in_4,
		gpio_in_5			=> gpio_in_5,
		gpio_in_6			=> gpio_in_6,
		gpio_in_7			=> gpio_in_7,
		gpio_in_8			=> gpio_in_8,
		gpio_in_9			=> gpio_in_9,
		gpio_in_10			=> gpio_in_10,
		gpio_in_11			=> gpio_in_11,
		gpio_in_12			=> gpio_in_12,
		gpio_in_13			=> gpio_in_13,
		gpio_in_14			=> gpio_in_14,
		gpio_in_15			=> gpio_in_15,
		gpio_in_16			=> gpio_in_16,
		gpio_in_17			=> gpio_in_17,
		gpio_in_18			=> gpio_in_18,
		gpio_in_19			=> gpio_in_19,
		gpio_in_20			=> gpio_in_20,
		gpio_in_21			=> gpio_in_21,
		gpio_in_22			=> gpio_in_22,
		gpio_in_23			=> gpio_in_23,
		gpio_in_24			=> gpio_in_24,
		gpio_in_25			=> gpio_in_25,
		gpio_in_26			=> gpio_in_26,
		gpio_in_27			=> gpio_in_27,
		gpio_in_28			=> gpio_in_28,
		gpio_in_29			=> gpio_in_29,
		gpio_in_30			=> gpio_in_30,
		gpio_in_31			=> gpio_in_31,

		program_n			=> open,
		scratch				=> scratch
	);

	-- 0 0x0: Ordering option B
	gpio_in_0(0)				<= ORDER_OPTION_B;

	-- 1 0x4: VXCO enable
	gpio_in_1(0)				<= gpio_out_1(0);
	FMC_LA_N25				<= gpio_out_1(0);

	-- 4 0x10: Trig ctrl
	gpio_in_4(3 downto 0)			<= gpio_out_4(3 downto 0);
	trig_sel0				<= gpio_out_4(0);
	trig_sel1				<= gpio_out_4(1);
	trig_to_adc_tmst_en			<= gpio_out_4(2);
	trig_to_fpga_en				<= gpio_out_4(3);	-- default = '1'

	-- 5 0x14: User LEDs: active low. '0' --> LED ON
	gpio_in_5(2 downto 0)			<= gpio_out_5(2 downto 0);
	FMC_LA_P24				<= gpio_out_5(0);
	FMC_LA_N24				<= gpio_out_5(1);
	FMC_LA_P25				<= gpio_out_5(2);

	-- 8 0x20: ADC I/O PWDN
	gpio_in_8(1 downto 0)			<= gpio_out_8(1 downto 0);
	FMC_LA_P7				<= gpio_out_8(0);	-- adc0 pdwn. default '1'
	FMC_LA_P11				<= gpio_out_8(1);	-- adc1 pdwn. default '1'

	-- 9 0x24: ADC I/O OVR
	gpio_in_9(0)				<= FMC_LA_N7;		-- adc0_or_t0
	gpio_in_9(1)				<= FMC_LA_P8;		-- adc0_or_t1
	gpio_in_9(2)				<= FMC_LA_N11;		-- adc1_or_t0
	gpio_in_9(3)				<= FMC_LA_P12;		-- adc1_or_t1

	-- 10 0x28: ADC range clear and data format
	adc_range_clear				<= gpio_out_10(0) and gpio_out_en(10);	-- self clear
	gpio_in_10(1)				<= gpio_out_10(1);
	adc_data_fmt				<= gpio_out_10(1);

	-- 11 0x2C: ADC 0 I range
	gpio_in_11				<= x"0" & adc_0_a_max & x"0" & adc_0_a_min;

	-- 12 0x30: ADC 0 Q range
	gpio_in_12				<= x"0" & adc_0_b_max & x"0" & adc_0_b_min;

	-- 13 0x34: ADC 1 I range
	gpio_in_13				<= x"0" & adc_1_a_max & x"0" & adc_1_a_min;

	-- 14 0x38: ADC 1 Q range
	gpio_in_14				<= x"0" & adc_1_b_max & x"0" & adc_1_b_min;

	-- 16 0x40: LMK I/O Reset
	gpio_in_16(0)				<= gpio_out_16(0);
	FMC_LA_N12				<= gpio_out_16(0);

	-- 17 0x44: LMK I/O status_ld
	gpio_in_17(0)				<= FMC_LA_P16;
	gpio_in_17(1)				<= FMC_LA_N16;

	-- 19 0x4C: LMK I/O sync/sysref req
	gpio_in_19(0)				<= gpio_out_19(0);
	FMC_LA_P14				<= gpio_out_19(0);

	-- 20 0x50: HMC LD
	gpio_in_20(0)				<= FMC_LA_P21;

	-- 21 0x54: HMC CE
	gpio_in_21(0)				<= gpio_out_21(0);	-- default '1'
	FMC_LA_P19				<= gpio_out_21(0);

	-- 28 0x70: JESD ctrl
	gpio_in_28(2 downto 0)			<= gpio_out_28(2 downto 0);
	jesd204_core_usr_rst			<= gpio_out_28(0);	-- default '1'
	jesd204_clk_disable			<= gpio_out_28(1);	-- default '1'
	jesd204_sysref_disable			<= gpio_out_28(2);	-- default '1'

	-- 29 0x74: ADC acq ctrl
	gpio_in_29(3 downto 2)			<= gpio_out_29(3 downto 2);
	rst_fifo				<= gpio_out_29(2);
	adc_wr_en				<= gpio_out_29(3);

	-- 30 0x78: ADC acq fifo status
	gpio_in_30				<= acq_fifo_status;


	--========== ADC related resets
	-- FIFO reset generation. The FIFO requires a minimum asynchronous reset pulse of write clock period.
	-- After reset is detected on the rising clock edge of write clock, 3 write
	--	clock periods are required to complete proper reset synchronization. During this time, the
	--	full, almost_full, and prog_full flags are asserted. After reset is deasserted, these
	--	flags deassert after three clock periods (wr_clk/clk) and the FIFO can then accept write
	--	operations.

	-- Synchronized with each clk_adc to enable write to fifo
	vt_single_sync_inst_fifo_wr_en_0: vt_single_sync
	generic map(
		STAGES				=> 2,
		STARTUP_VALUE			=> '0'
	)
	port map(
		clk				=> j0_rx_aclk,
		port_i				=> adc_wr_en,
		port_o				=> fifo_wr_en(0)
	);

	vt_single_sync_inst_fifo_wr_en_1: vt_single_sync
	generic map(
		STAGES				=> 2,
		STARTUP_VALUE			=> '0'
	)
	port map(
		clk				=> j1_rx_aclk,
		port_i				=> adc_wr_en,
		port_o				=> fifo_wr_en(1)
	);

	-- acquisition and fifo status
	acq_fifo_status				<= j1_rx_aclk & fifo_empty(1) & fifo_almost_empty(1) & fifo_full(1) & fifo_rd_data_count(12*1+11 downto 12*1) &
						   j0_rx_aclk & fifo_empty(0) & fifo_almost_empty(0) & fifo_full(0) & fifo_rd_data_count(12*0+11 downto 12*0);

	-- Read ADC
	axi_lite_rd_fifo_inst_0: axi_lite_rd_fifo
	port map(
		s_axi_aclk			=> s_axi_aclk,
		s_axi_aresetn			=> s_axi_aresetn,
		s_axi_awaddr			=> cb_m_axi_awaddr(32*ADC0_RD_PORT+ADC0_RD_AWIDTH-1 downto 32*ADC0_RD_PORT),
		s_axi_awvalid			=> cb_m_axi_awvalid(ADC0_RD_PORT),
		s_axi_awready			=> cb_m_axi_awready(ADC0_RD_PORT),
		s_axi_wdata			=> cb_m_axi_wdata(32*(ADC0_RD_PORT+1)-1 downto 32*ADC0_RD_PORT),
		s_axi_wstrb			=> cb_m_axi_wstrb(4*(ADC0_RD_PORT+1)-1 downto 4*ADC0_RD_PORT),
		s_axi_wvalid			=> cb_m_axi_wvalid(ADC0_RD_PORT),
		s_axi_wready			=> cb_m_axi_wready(ADC0_RD_PORT),
		s_axi_bresp			=> cb_m_axi_bresp(2*(ADC0_RD_PORT+1)-1 downto 2*ADC0_RD_PORT),
		s_axi_bvalid			=> cb_m_axi_bvalid(ADC0_RD_PORT),
		s_axi_bready			=> cb_m_axi_bready(ADC0_RD_PORT),
		s_axi_araddr			=> cb_m_axi_araddr(32*ADC0_RD_PORT+ADC0_RD_AWIDTH-1 downto 32*ADC0_RD_PORT),
		s_axi_arvalid			=> cb_m_axi_arvalid(ADC0_RD_PORT),
		s_axi_arready			=> cb_m_axi_arready(ADC0_RD_PORT),
		s_axi_rdata			=> cb_m_axi_rdata(32*(ADC0_RD_PORT+1)-1 downto 32*ADC0_RD_PORT),
		s_axi_rresp			=> cb_m_axi_rresp(2*(ADC0_RD_PORT+1)-1 downto 2*ADC0_RD_PORT),
		s_axi_rvalid			=> cb_m_axi_rvalid(ADC0_RD_PORT),
		s_axi_rready			=> cb_m_axi_rready(ADC0_RD_PORT),
		fifo_rd_en			=> fifo_rd_en(0),
		fifo_dout			=> fifo_dout(32*(0+1)-1 downto 32*0)
	);

	axi_lite_rd_fifo_inst_1: axi_lite_rd_fifo
	port map(
		s_axi_aclk			=> s_axi_aclk,
		s_axi_aresetn			=> s_axi_aresetn,
		s_axi_awaddr			=> cb_m_axi_awaddr(32*ADC1_RD_PORT+ADC1_RD_AWIDTH-1 downto 32*ADC1_RD_PORT),
		s_axi_awvalid			=> cb_m_axi_awvalid(ADC1_RD_PORT),
		s_axi_awready			=> cb_m_axi_awready(ADC1_RD_PORT),
		s_axi_wdata			=> cb_m_axi_wdata(32*(ADC1_RD_PORT+1)-1 downto 32*ADC1_RD_PORT),
		s_axi_wstrb			=> cb_m_axi_wstrb(4*(ADC1_RD_PORT+1)-1 downto 4*ADC1_RD_PORT),
		s_axi_wvalid			=> cb_m_axi_wvalid(ADC1_RD_PORT),
		s_axi_wready			=> cb_m_axi_wready(ADC1_RD_PORT),
		s_axi_bresp			=> cb_m_axi_bresp(2*(ADC1_RD_PORT+1)-1 downto 2*ADC1_RD_PORT),
		s_axi_bvalid			=> cb_m_axi_bvalid(ADC1_RD_PORT),
		s_axi_bready			=> cb_m_axi_bready(ADC1_RD_PORT),
		s_axi_araddr			=> cb_m_axi_araddr(32*ADC1_RD_PORT+ADC1_RD_AWIDTH-1 downto 32*ADC1_RD_PORT),
		s_axi_arvalid			=> cb_m_axi_arvalid(ADC1_RD_PORT),
		s_axi_arready			=> cb_m_axi_arready(ADC1_RD_PORT),
		s_axi_rdata			=> cb_m_axi_rdata(32*(ADC1_RD_PORT+1)-1 downto 32*ADC1_RD_PORT),
		s_axi_rresp			=> cb_m_axi_rresp(2*(ADC1_RD_PORT+1)-1 downto 2*ADC1_RD_PORT),
		s_axi_rvalid			=> cb_m_axi_rvalid(ADC1_RD_PORT),
		s_axi_rready			=> cb_m_axi_rready(ADC1_RD_PORT),
		fifo_rd_en			=> fifo_rd_en(1),
		fifo_dout			=> fifo_dout(32*(1+1)-1 downto 32*1)
	);

	-- Send fifo read enable only when the higher 2-byte is being read
	fifo_rd_en_lbc				<= fifo_rd_en and (not axi_ruser_strb_n(3) & not axi_ruser_strb_n(3));


	fifo_generator_0_inst_0: fifo_generator_0
	port map(
		rst				=> rst_fifo,
		wr_clk				=> j0_rx_aclk,
		rd_clk				=> s_axi_aclk,
		din				=> fifo_din_ar(128*(0+1)-1 downto 128*0),
		wr_en				=> fifo_wr_en(0),
		rd_en				=> fifo_rd_en_lbc(0),
		dout				=> fifo_dout(32*(0+1)-1 downto 32*0),
		full				=> fifo_full(0),
		empty				=> fifo_empty(0),
		almost_empty			=> fifo_almost_empty(0),
		rd_data_count			=> fifo_rd_data_count(12*(0+1)-1 downto 12*0)
	);

	fifo_generator_0_inst_1: fifo_generator_0
	port map(
		rst				=> rst_fifo,
		wr_clk				=> j1_rx_aclk,
		rd_clk				=> s_axi_aclk,
		din				=> fifo_din_ar(128*(1+1)-1 downto 128*1),
		wr_en				=> fifo_wr_en(1),
		rd_en				=> fifo_rd_en_lbc(1),
		dout				=> fifo_dout(32*(1+1)-1 downto 32*1),
		full				=> fifo_full(1),
		empty				=> fifo_empty(1),
		almost_empty			=> fifo_almost_empty(1),
		rd_data_count			=> fifo_rd_data_count(12*(1+1)-1 downto 12*1)
	);

	-- ========== Fifo output aspect ratio re-ordering
	-- j?_?_data format: S(N+3) S(N+2) S(N+1) S(N+0)
	fifo_din		<= j1_b_data & j1_a_data & j0_b_data & j0_a_data;

	-- the goal is to mix channel A & B when axi_lite_rd_fifo read (32-bits)
	-- fifo_din: 	B(3) B(2) B(1) B(0) A(3) A(2) A(1) A(0)
	-- fifo_din_ar:	B(0) A(0) B(1) A(1) B(2) A(2) B(3) A(3)
	-- the FIFO read MSB first
	process_fifo_ar_0: process(fifo_din(128*(0+1)-1 downto 128*0))
	begin
		for j in 3 downto 0 loop
			fifo_din_ar(128*0+j*32+16-1 downto 128*0+j*32)	<=
						fifo_din(128*0+(4-j)*16-1 downto 128*0+(4-j-1)*16);
			fifo_din_ar(128*0+j*32+31 downto 128*0+j*32+16)	<=
						fifo_din(128*0+64+(4-j)*16-1 downto 128*0+64+(4-j-1)*16);
		end loop;
	end process;

	process_fifo_ar_1: process(fifo_din(128*(1+1)-1 downto 128*1))
	begin
		for j in 3 downto 0 loop
			fifo_din_ar(128*1+j*32+16-1 downto 128*1+j*32)	<=
						fifo_din(128*1+(4-j)*16-1 downto 128*1+(4-j-1)*16);
			fifo_din_ar(128*1+j*32+31 downto 128*1+j*32+16)	<=
						fifo_din(128*1+64+(4-j)*16-1 downto 128*1+64+(4-j-1)*16);
		end loop;
	end process;


	-- connect trigger in to trigger out
	IBUFDS_inst_trigger : IBUFDS
	generic map (
		IOSTANDARD 			=> LVDS_STANDARD,
		DIFF_TERM			=> TRUE
	)
	port map (
		O				=> trigger_in,
		I				=> FMC_LA_P2,
		IB				=> FMC_LA_N2
	);

	OBUFDS_inst_trigger : OBUFDS
	generic map (
		IOSTANDARD 			=> LVDS_STANDARD
	)
	port map (
		O				=> FMC_LA_P23,
		OB				=> FMC_LA_N23,
		I				=> trigger_out
	);

	process(s_axi_aclk)
	begin
		if(rising_edge(s_axi_aclk)) then
			s_axi_aclk_div2		<= not s_axi_aclk_div2;
		end if;
	end process;

	process(j0_rx_aclk)
	begin
		if(rising_edge(j0_rx_aclk)) then
			j0_rx_aclk_div2		<= not j0_rx_aclk_div2;
		end if;
	end process;

	process(j1_rx_aclk)
	begin
		if(rising_edge(j1_rx_aclk)) then
			j1_rx_aclk_div2		<= not j1_rx_aclk_div2;
		end if;
	end process;

	process(jesd204_core_clk)
	begin
		if(rising_edge(jesd204_core_clk)) then
			jesd204_core_clk_div2	<= not jesd204_core_clk_div2;
		end if;
	end process;

	trigger_out				<= s_axi_aclk_div2		when scratch(3 downto 0) = x"1" else
						   j0_rx_aclk_div2		when scratch(3 downto 0) = x"2" else
						   j1_rx_aclk_div2		when scratch(3 downto 0) = x"3" else
						   jesd204_core_clk_div2	when scratch(3 downto 0) = x"4" else
						   trigger_in;


	-- ============= For production test ADC ranges
	vt_single_sync_inst_adc_0_range_clr: vt_single_sync
	generic map(
		STAGES				=> 4,
		STARTUP_VALUE			=> '0'
	)
	port map(
		clk				=> j0_rx_aclk,
		port_i				=> adc_range_clear,
		port_o				=> adc_0_range_clr
	);

	vt_single_sync_inst_adc_1_range_clr: vt_single_sync
	generic map(
		STAGES				=> 4,
		STARTUP_VALUE			=> '0'
	)
	port map(
		clk				=> j1_rx_aclk,
		port_i				=> adc_range_clear,
		port_o				=> adc_1_range_clr
	);

	-- Align samples
	process(j0_rx_aclk)
	begin
		if(rising_edge(j0_rx_aclk)) then

			j0_tvalid_r		<= j0_jesd204b_tvalid;
			j0_tdata_r		<= j0_jesd204b_tdata;

			j0_a_data		<= j0_tdata_r(31 downto 24) & j0_tdata_r(32+31 downto 32+24) &		-- A3
						   j0_tdata_r(23 downto 16) & j0_tdata_r(32+23 downto 32+16) &		-- A2
						   j0_tdata_r(15 downto 8) & j0_tdata_r(32+15 downto 32+8) &		-- A1
						   j0_tdata_r(7 downto 0) & j0_tdata_r(32+7 downto 32+0);		-- A0
			j0_valid		<= j0_tvalid_r;
			j0_b_data		<= j0_tdata_r(64+31 downto 64+24) & j0_tdata_r(96+31 downto 96+24) &	-- B3
						   j0_tdata_r(64+23 downto 64+16) & j0_tdata_r(96+23 downto 96+16) &	-- B2
						   j0_tdata_r(64+15 downto 64+8) & j0_tdata_r(96+15 downto 96+8) &	-- B1
						   j0_tdata_r(64+7  downto 64+0)  & j0_tdata_r(96+7 downto 96+0);	-- B0
		end if;
	end process;


	process(j1_rx_aclk)
	begin
		if(rising_edge(j1_rx_aclk)) then

			j1_tvalid_r		<= j1_jesd204b_tvalid;
			j1_tdata_r		<= j1_jesd204b_tdata;

			j1_a_data		<= j1_tdata_r(31 downto 24) & j1_tdata_r(32+31 downto 32+24) &		-- A3
						   j1_tdata_r(23 downto 16) & j1_tdata_r(32+23 downto 32+16) &		-- A2
						   j1_tdata_r(15 downto 8) & j1_tdata_r(32+15 downto 32+8) &		-- A1
						   j1_tdata_r(7 downto 0) & j1_tdata_r(32+7 downto 32+0);		-- A0
			j1_valid		<= j1_tvalid_r;
			j1_b_data		<= j1_tdata_r(64+31 downto 64+24) & j1_tdata_r(96+31 downto 96+24) &	-- B3
						   j1_tdata_r(64+23 downto 64+16) & j1_tdata_r(96+23 downto 96+16) &	-- B2
						   j1_tdata_r(64+15 downto 64+8) & j1_tdata_r(96+15 downto 96+8) &	-- B1
						   j1_tdata_r(64+7  downto 64+0)  & j1_tdata_r(96+7 downto 96+0);	-- B0
		end if;
	end process;

	-- Convert to offset binary data format
	process(j0_rx_aclk)
	begin
		if(rising_edge(j0_rx_aclk)) then
			j0_valid_r		<= j0_valid;
			for i in 3 downto 0 loop
				j0_a_data_r(i*16)
						<= j0_a_data(i*16);

				if(adc_data_fmt = '1') then
					j0_a_data_r(i*16 + 15 downto i*16 + 1)
						<= j0_a_data(i*16 + 15 downto i*16 + 1);
				elsif(j0_a_data(i*16 + 15) = '0') then
					j0_a_data_r(i*16 + 15 downto i*16 + 1)
						<= '1' & j0_a_data(i*16 + 14 downto i*16 + 1);
				else
					j0_a_data_r(i*16 + 15 downto i*16 + 1)
						<= '0' & j0_a_data(i*16 + 14 downto i*16 + 1);
				end if;

				j0_b_data_r(i*16)
						<= j0_b_data(i*16);

				if(adc_data_fmt = '1') then
					j0_b_data_r(i*16 + 15 downto i*16 + 1)
						<= j0_b_data(i*16 + 15 downto i*16 + 1);
				elsif(j0_b_data(i*16 + 15) = '0') then
					j0_b_data_r(i*16 + 15 downto i*16 + 1)
						<= '1' & j0_b_data(i*16 + 14 downto i*16 + 1);
				else
					j0_b_data_r(i*16 + 15 downto i*16 + 1)
						<= '0' & j0_b_data(i*16 + 14 downto i*16 + 1);
				end if;
			end loop;
		end if;
	end process;

	process(j1_rx_aclk)
	begin
		if(rising_edge(j1_rx_aclk)) then
			j1_valid_r		<= j1_valid;
			for i in 3 downto 0 loop
				j1_a_data_r(i*16)
						<= j1_a_data(i*16);

				if(adc_data_fmt = '1') then
					j1_a_data_r(i*16 + 15 downto i*16 + 1)
						<= j1_a_data(i*16 + 15 downto i*16 + 1);
				elsif(j1_a_data(i*16 + 15) = '0') then
					j1_a_data_r(i*16 + 15 downto i*16 + 1)
						<= '1' & j1_a_data(i*16 + 14 downto i*16 + 1);
				else
					j1_a_data_r(i*16 + 15 downto i*16 + 1)
						<= '0' & j1_a_data(i*16 + 14 downto i*16 + 1);
				end if;

				j1_b_data_r(i*16)
						<= j1_b_data(i*16);

				if(adc_data_fmt = '1') then
					j1_b_data_r(i*16 + 15 downto i*16 + 1)
						<= j1_b_data(i*16 + 15 downto i*16 + 1);
				elsif(j1_b_data(i*16 + 15) = '0') then
					j1_b_data_r(i*16 + 15 downto i*16 + 1)
						<= '1' & j1_b_data(i*16 + 14 downto i*16 + 1);
				else
					j1_b_data_r(i*16 + 15 downto i*16 + 1)
						<= '0' & j1_b_data(i*16 + 14 downto i*16 + 1);
				end if;
			end loop;
		end if;
	end process;

	-- Find max and min in one JESD204 core clock period
	process(j0_rx_aclk)
	begin
		if(rising_edge(j0_rx_aclk)) then
			if(j0_rx_aresetn = '0') then
				j0_max_i01	<= (others => '0');
				j0_max_i23	<= (others => '0');
				j0_max_q01	<= (others => '0');
				j0_max_q23	<= (others => '0');
				j0_min_i01	<= (others => '1');
				j0_min_i23	<= (others => '1');
				j0_min_q01	<= (others => '1');
				j0_min_q23	<= (others => '1');
			elsif(j0_valid_r = '1') then
				if(unsigned(j0_a_data_r(15 downto 4)) > unsigned(j0_a_data_r(31 downto 20))) then
					j0_max_i01	<= j0_a_data_r(15 downto 4);
					j0_min_i01	<= j0_a_data_r(31 downto 20);
				else
					j0_max_i01	<= j0_a_data_r(31 downto 20);
					j0_min_i01	<= j0_a_data_r(15 downto 4);
				end if;

				if(unsigned(j0_a_data_r(47 downto 36)) > unsigned(j0_a_data_r(63 downto 52))) then
					j0_max_i23	<= j0_a_data_r(47 downto 36);
					j0_min_i23	<= j0_a_data_r(63 downto 52);
				else
					j0_max_i23	<= j0_a_data_r(63 downto 52);
					j0_min_i23	<= j0_a_data_r(47 downto 36);
				end if;

				if(unsigned(j0_b_data_r(15 downto 4)) > unsigned(j0_b_data_r(31 downto 20))) then
					j0_max_q01	<= j0_b_data_r(15 downto 4);
					j0_min_q01	<= j0_b_data_r(31 downto 20);
				else
					j0_max_q01	<= j0_b_data_r(31 downto 20);
					j0_min_q01	<= j0_b_data_r(15 downto 4);
				end if;

				if(unsigned(j0_b_data_r(47 downto 36)) > unsigned(j0_b_data_r(63 downto 52))) then
					j0_max_q23	<= j0_b_data_r(47 downto 36);
					j0_min_q23	<= j0_b_data_r(63 downto 52);
				else
					j0_max_q23	<= j0_b_data_r(63 downto 52);
					j0_min_q23	<= j0_b_data_r(47 downto 36);
				end if;

			end if;
		end if;
	end process;

	process(j1_rx_aclk)
	begin
		if(rising_edge(j1_rx_aclk)) then
			if(j1_rx_aresetn = '0') then
				j1_max_i01	<= (others => '0');
				j1_max_i23	<= (others => '0');
				j1_max_q01	<= (others => '0');
				j1_max_q23	<= (others => '0');
				j1_min_i01	<= (others => '1');
				j1_min_i23	<= (others => '1');
				j1_min_q01	<= (others => '1');
				j1_min_q23	<= (others => '1');
			elsif(j1_valid_r = '1') then
				if(unsigned(j1_a_data_r(15 downto 4)) > unsigned(j1_a_data_r(31 downto 20))) then
					j1_max_i01	<= j1_a_data_r(15 downto 4);
					j1_min_i01	<= j1_a_data_r(31 downto 20);
				else
					j1_max_i01	<= j1_a_data_r(31 downto 20);
					j1_min_i01	<= j1_a_data_r(15 downto 4);
				end if;

				if(unsigned(j1_a_data_r(47 downto 36)) > unsigned(j1_a_data_r(63 downto 52))) then
					j1_max_i23	<= j1_a_data_r(47 downto 36);
					j1_min_i23	<= j1_a_data_r(63 downto 52);
				else
					j1_max_i23	<= j1_a_data_r(63 downto 52);
					j1_min_i23	<= j1_a_data_r(47 downto 36);
				end if;

				if(unsigned(j1_b_data_r(15 downto 4)) > unsigned(j1_b_data_r(31 downto 20))) then
					j1_max_q01	<= j1_b_data_r(15 downto 4);
					j1_min_q01	<= j1_b_data_r(31 downto 20);
				else
					j1_max_q01	<= j1_b_data_r(31 downto 20);
					j1_min_q01	<= j1_b_data_r(15 downto 4);
				end if;

				if(unsigned(j1_b_data_r(47 downto 36)) > unsigned(j1_b_data_r(63 downto 52))) then
					j1_max_q23	<= j1_b_data_r(47 downto 36);
					j1_min_q23	<= j1_b_data_r(63 downto 52);
				else
					j1_max_q23	<= j1_b_data_r(63 downto 52);
					j1_min_q23	<= j1_b_data_r(47 downto 36);
				end if;

			end if;
		end if;
	end process;

	process(j0_rx_aclk)
	begin
		if(rising_edge(j0_rx_aclk)) then
			if(unsigned(j0_max_i01) > unsigned(j0_max_i23)) then
				j0_max_i		<= j0_max_i01;
			else
				j0_max_i		<= j0_max_i23;
			end if;

			if(unsigned(j0_min_i01) > unsigned(j0_min_i23)) then
				j0_min_i		<= j0_min_i23;
			else
				j0_min_i		<= j0_min_i01;
			end if;

			if(unsigned(j0_max_q01) > unsigned(j0_max_q23)) then
				j0_max_q		<= j0_max_q01;
			else
				j0_max_q		<= j0_max_q23;
			end if;

			if(unsigned(j0_min_q01) > unsigned(j0_min_q23)) then
				j0_min_q		<= j0_min_q23;
			else
				j0_min_q		<= j0_min_q01;
			end if;

		end if;
	end process;

	process(j1_rx_aclk)
	begin
		if(rising_edge(j1_rx_aclk)) then
			if(unsigned(j1_max_i01) > unsigned(j1_max_i23)) then
				j1_max_i		<= j1_max_i01;
			else
				j1_max_i		<= j1_max_i23;
			end if;

			if(unsigned(j1_min_i01) > unsigned(j1_min_i23)) then
				j1_min_i		<= j1_min_i23;
			else
				j1_min_i		<= j1_min_i01;
			end if;

			if(unsigned(j1_max_q01) > unsigned(j1_max_q23)) then
				j1_max_q		<= j1_max_q01;
			else
				j1_max_q		<= j1_max_q23;
			end if;

			if(unsigned(j1_min_q01) > unsigned(j1_min_q23)) then
				j1_min_q		<= j1_min_q23;
			else
				j1_min_q		<= j1_min_q01;
			end if;

		end if;
	end process;

	process(j0_rx_aclk)
	begin
		if(rising_edge(j0_rx_aclk)) then
			if(adc_0_range_clr = '1' or j0_rx_aresetn = '0') then
				adc_0_a_max	<= (others => '0');
				adc_0_b_max	<= (others => '0');
				adc_0_a_min	<= (others => '1');
				adc_0_b_min	<= (others => '1');
			else
				if(unsigned(adc_0_a_max) < unsigned(j0_max_i)) then
					adc_0_a_max 	<= j0_max_i;
				end if;

				if(unsigned(adc_0_b_max) < unsigned(j0_max_q)) then
					adc_0_b_max 	<= j0_max_q;
				end if;

				if(unsigned(adc_0_a_min) > unsigned(j0_min_i)) then
					adc_0_a_min	<= j0_min_i;
				end if;

				if(unsigned(adc_0_b_min) > unsigned(j0_min_q)) then
					adc_0_b_min	<= j0_min_q;
				end if;
			end if;
		end if;
	end process;

	process(j1_rx_aclk)
	begin
		if(rising_edge(j1_rx_aclk)) then
			if(adc_1_range_clr = '1' or j1_rx_aresetn = '0') then
				adc_1_a_max	<= (others => '0');
				adc_1_b_max	<= (others => '0');
				adc_1_a_min	<= (others => '1');
				adc_1_b_min	<= (others => '1');
			else
				if(unsigned(adc_1_a_max) < unsigned(j1_max_i)) then
					adc_1_a_max	<= j1_max_i;
				end if;

				if(unsigned(adc_1_b_max) < unsigned(j1_max_q)) then
					adc_1_b_max	<= j1_max_q;
				end if;

				if(unsigned(adc_1_a_min) > unsigned(j1_min_i)) then
					adc_1_a_min	<= j1_min_i;
				end if;

				if(unsigned(adc_1_b_min) > unsigned(j1_min_q)) then
					adc_1_b_min	<= j1_min_q;
				end if;
			end if;
		end if;
	end process;

	-- For capturing ADC raw data
	ila_0_inst_0: ila_0
	port map(
		clk				=> j0_rx_aclk,
		probe0				=> j0_jesd204b_start_of_frame,
		probe1				=> j0_jesd204b_end_of_frame,
		probe2				=> j0_jesd204b_frame_error,
		probe3(0)			=> j0_jesd204b_tvalid,
		probe4				=> j0_jesd204b_tdata
	);

	ila_0_inst_1: ila_0
	port map(
		clk				=> j1_rx_aclk,
		probe0				=> j1_jesd204b_start_of_frame,
		probe1				=> j1_jesd204b_end_of_frame,
		probe2				=> j1_jesd204b_frame_error,
		probe3(0)			=> j1_jesd204b_tvalid,
		probe4				=> j1_jesd204b_tdata
	);

	-- debug
	process(s_axi_aclk)
	begin
		if(rising_edge(s_axi_aclk)) then
			misc_dbg_status		<= j0_rx_aresetn & j1_rx_aresetn & j0_common0_pll_lock_out
							& j1_common0_pll_lock_out & "00" &
							x"000000";
		end if;
	end process;

end Behavioral;
