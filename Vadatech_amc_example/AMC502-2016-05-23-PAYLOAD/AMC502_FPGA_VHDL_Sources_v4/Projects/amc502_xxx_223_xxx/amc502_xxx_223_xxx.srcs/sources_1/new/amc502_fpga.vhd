----------------------------------------------------------------------------------
-- Company: 	VadaTech Incorporated
-- Engineer: 	Mike McDermott
-- 
-- Create Date: 05/20/2016
-- Design Name: AMC502 FPGA Reference Design
-- Module Name: amc502_fpga - behavioral
-- Project Name: 
-- Target Devices: Kintex-7 420T FFG1156
-- Tool Versions: Vivado 2015.4
-- Description:  This reference design project tests:
--                    * PCIe Gen2 x8 to AMC Ports 4-11
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity amc502_fpga is
port ( 
	-- Resets
	nLVDS_CBS_RST		:   out std_logic;
	nPLL_RST		:   out std_logic;

	-- Primary I2C bus (FMC 0, M-LVDS CBS, QPLL, others)
	SCL_L1			: inout std_logic;
	SDA_L1			: inout std_logic;

	-- Secondary I2C bus (FMC 1)
	SDA_L2			: inout std_logic;
	SCL_L2			: inout std_logic;

	-- CPU's I2C bus
	SCL_LLLX		: inout std_logic;
	SDA_LLLX		: inout std_logic;

	-- Thermal alert
	nTHERM			:    in std_logic;

	-- User LEDs
	nULED			:   out std_logic_vector(3 downto 0);

	-- User DIP switches
	USER			:    in std_logic_vector(6 downto 0);

	-- FPGA RS-232 port
	FPGA_RX_UART		:    in std_logic;
	FPGA_TX_UART		:   out std_logic;

	-- Configuration clock
	CLK50MHZ		:    in std_logic;

	-- Configuration QSPI flash
	-- NOTE: QSPI flash clock is FPGA's CCLK.
	-- NOTE: iMX6 CPU can take control of this flash for field upgrade purposes.
	--       The FPGA doesn't know when this is occurring.
	D00_MOSIX		:   out std_logic;
	D01_MISOX		:    in std_logic;
	D02			: inout std_logic;	-- *WP/IO2
	D03			: inout std_logic;	-- *HOLD/IO3
	nFCSX			:   out std_logic;

	-- AMC TX3 Pair LVDS input when ordering option A=1
	AMC_TX3SEL_P		:    in std_logic;
	AMC_TX3SEL_N		:    in std_logic;

	-- LVDS Clock Inputs from Quad PLL
	FPCLKA_P		:    in std_logic;
	FPCLKA_N		:    in std_logic;
	FPCLKB_P		:    in std_logic;
	FPCLKB_N		:    in std_logic;
	FPCLKC_P		:    in std_logic;
	FPCLKC_N		:    in std_logic;
	FPCLKD_P		:    in std_logic;
	FPCLKD_N		:    in std_logic;

	-- LVDS Clocks to/from M-LVDS CBS (used as input in this image)
	FPCLKE_P		:    in std_logic;
	FPCLKE_N		:    in std_logic;
	FPCLKF_P		:    in std_logic;
	FPCLKF_N		:    in std_logic;
	FPCLKG_P		:    in std_logic;
	FPCLKG_N		:    in std_logic;
	FPCLKH_P		:    in std_logic;
	FPCLKH_N		:    in std_logic;

	-- FMC0 Infrastructure
	nPRSNT_M2C0		:    in std_logic;
	CLK_DIR0		:    in std_logic;

	-- FMC1 Infrastructure
	nPRSNT_M2C1		:    in std_logic;
	CLK_DIR1		:    in std_logic;

	-- FMC0 LA Pairs
	FMC0_LA00_CC_P		: inout std_logic;
	FMC0_LA00_CC_N		: inout std_logic;
	FMC0_LA01_CC_P		: inout std_logic;
	FMC0_LA01_CC_N		: inout std_logic;
	FMC0_LA02_P		: inout std_logic;
	FMC0_LA02_N		: inout std_logic;
	FMC0_LA03_P		: inout std_logic;
	FMC0_LA03_N		: inout std_logic;
	FMC0_LA04_P		: inout std_logic;
	FMC0_LA04_N		: inout std_logic;
	FMC0_LA05_P		: inout std_logic;
	FMC0_LA05_N		: inout std_logic;
	FMC0_LA06_P		: inout std_logic;
	FMC0_LA06_N		: inout std_logic;
	FMC0_LA07_P		: inout std_logic;
	FMC0_LA07_N		: inout std_logic;
	FMC0_LA08_P		: inout std_logic;
	FMC0_LA08_N		: inout std_logic;
	FMC0_LA09_P		: inout std_logic;
	FMC0_LA09_N		: inout std_logic;
	FMC0_LA10_P		: inout std_logic;
	FMC0_LA10_N		: inout std_logic;
	FMC0_LA11_P		: inout std_logic;
	FMC0_LA11_N		: inout std_logic;
	FMC0_LA12_P		: inout std_logic;
	FMC0_LA12_N		: inout std_logic;
	FMC0_LA13_P		: inout std_logic;
	FMC0_LA13_N		: inout std_logic;
	FMC0_LA14_P		: inout std_logic;
	FMC0_LA14_N		: inout std_logic;
	FMC0_LA15_P		: inout std_logic;
	FMC0_LA15_N		: inout std_logic;
	FMC0_LA16_P		: inout std_logic;
	FMC0_LA16_N		: inout std_logic;
	FMC0_LA19_P		: inout std_logic;
	FMC0_LA19_N		: inout std_logic;
	FMC0_LA20_P		: inout std_logic;
	FMC0_LA20_N		: inout std_logic;
	FMC0_LA21_P		: inout std_logic;
	FMC0_LA21_N		: inout std_logic;
	FMC0_LA22_P		: inout std_logic;
	FMC0_LA22_N		: inout std_logic;
	FMC0_LA23_P		: inout std_logic;
	FMC0_LA23_N		: inout std_logic;
	FMC0_LA24_P		: inout std_logic;
	FMC0_LA24_N		: inout std_logic;
	FMC0_LA17_CC_P		: inout std_logic;
	FMC0_LA17_CC_N		: inout std_logic;
	FMC0_LA18_CC_P		: inout std_logic;
	FMC0_LA18_CC_N		: inout std_logic;
	FMC0_LA25_P		: inout std_logic;
	FMC0_LA25_N		: inout std_logic;
	FMC0_LA26_P		: inout std_logic;
	FMC0_LA26_N		: inout std_logic;
	FMC0_LA27_P		: inout std_logic;
	FMC0_LA27_N		: inout std_logic;
	FMC0_LA28_P		: inout std_logic;
	FMC0_LA28_N		: inout std_logic;
	FMC0_LA29_P		: inout std_logic;
	FMC0_LA29_N		: inout std_logic;
	FMC0_LA30_P		: inout std_logic;
	FMC0_LA30_N		: inout std_logic;
	FMC0_LA31_P		: inout std_logic;
	FMC0_LA31_N		: inout std_logic;
	FMC0_LA32_P		: inout std_logic;
	FMC0_LA32_N		: inout std_logic;
	FMC0_LA33_P		: inout std_logic;
	FMC0_LA33_N		: inout std_logic;

	-- FMC0 HA Pairs
	FMC0_HA00_CC_P		: inout std_logic;
	FMC0_HA00_CC_N		: inout std_logic;
	FMC0_HA01_CC_P		: inout std_logic;
	FMC0_HA01_CC_N		: inout std_logic;
	FMC0_HA02_P		: inout std_logic;
	FMC0_HA02_N		: inout std_logic;
	FMC0_HA03_P		: inout std_logic;
	FMC0_HA03_N		: inout std_logic;
	FMC0_HA04_P		: inout std_logic;
	FMC0_HA04_N		: inout std_logic;
	FMC0_HA05_P		: inout std_logic;
	FMC0_HA05_N		: inout std_logic;
	FMC0_HA06_P		: inout std_logic;
	FMC0_HA06_N		: inout std_logic;
	FMC0_HA07_P		: inout std_logic;
	FMC0_HA07_N		: inout std_logic;
	FMC0_HA08_P		: inout std_logic;
	FMC0_HA08_N		: inout std_logic;
	FMC0_HA09_P		: inout std_logic;
	FMC0_HA09_N		: inout std_logic;
	FMC0_HA10_P		: inout std_logic;
	FMC0_HA10_N		: inout std_logic;
	FMC0_HA11_P		: inout std_logic;
	FMC0_HA11_N		: inout std_logic;
	FMC0_HA12_P		: inout std_logic;
	FMC0_HA12_N		: inout std_logic;
	FMC0_HA13_P		: inout std_logic;
	FMC0_HA13_N		: inout std_logic;
	FMC0_HA14_P		: inout std_logic;
	FMC0_HA14_N		: inout std_logic;
	FMC0_HA15_P		: inout std_logic;
	FMC0_HA15_N		: inout std_logic;
	FMC0_HA16_P		: inout std_logic;
	FMC0_HA17_CC_P		: inout std_logic;
	FMC0_HA17_CC_N		: inout std_logic;
	FMC0_HA18_CC_P		: inout std_logic;
	FMC0_HA18_CC_N		: inout std_logic;
	FMC0_HA16_N		: inout std_logic;
	FMC0_HA19_P		: inout std_logic;
	FMC0_HA19_N		: inout std_logic;
	FMC0_HA20_P		: inout std_logic;
	FMC0_HA20_N		: inout std_logic;
	FMC0_HA21_P		: inout std_logic;
	FMC0_HA21_N		: inout std_logic;
	FMC0_HA22_P		: inout std_logic;
	FMC0_HA22_N		: inout std_logic;
	FMC0_HA23_P		: inout std_logic;
	FMC0_HA23_N		: inout std_logic;

	-- FMC0 HB Pairs
	FMC0_HB00_CC_P		: inout std_logic;
	FMC0_HB00_CC_N		: inout std_logic;
	FMC0_HB01_P		: inout std_logic;
	FMC0_HB01_N		: inout std_logic;
	FMC0_HB02_P		: inout std_logic;
	FMC0_HB02_N		: inout std_logic;
	FMC0_HB03_P		: inout std_logic;
	FMC0_HB03_N		: inout std_logic;
	FMC0_HB04_P		: inout std_logic;
	FMC0_HB04_N		: inout std_logic;
	FMC0_HB05_P		: inout std_logic;
	FMC0_HB06_CC_P		: inout std_logic;
	FMC0_HB06_CC_N		: inout std_logic;
	FMC0_HB05_N		: inout std_logic;
	FMC0_HB07_P		: inout std_logic;
	FMC0_HB07_N		: inout std_logic;
	FMC0_HB08_P		: inout std_logic;
	FMC0_HB08_N		: inout std_logic;
	FMC0_HB09_P		: inout std_logic;
	FMC0_HB09_N		: inout std_logic;
	FMC0_HB10_P		: inout std_logic;
	FMC0_HB10_N		: inout std_logic;
	FMC0_HB11_P		: inout std_logic;
	FMC0_HB11_N		: inout std_logic;
	FMC0_HB12_P		: inout std_logic;
	FMC0_HB12_N		: inout std_logic;
	FMC0_HB13_P		: inout std_logic;
	FMC0_HB13_N		: inout std_logic;
	FMC0_HB14_P		: inout std_logic;
	FMC0_HB14_N		: inout std_logic;
	FMC0_HB15_P		: inout std_logic;
	FMC0_HB15_N		: inout std_logic;
	FMC0_HB16_P		: inout std_logic;
	FMC0_HB16_N		: inout std_logic;
	FMC0_HB17_CC_P		: inout std_logic;
	FMC0_HB17_CC_N		: inout std_logic;
	FMC0_HB18_P		: inout std_logic;
	FMC0_HB18_N		: inout std_logic;
	FMC0_HB19_P		: inout std_logic;
	FMC0_HB19_N		: inout std_logic;
	FMC0_HB20_P		: inout std_logic;
	FMC0_HB20_N		: inout std_logic;
	FMC0_HB21_P		: inout std_logic;
	FMC0_HB21_N		: inout std_logic;

	-- FMC1 LA Pairs
	FMC1_LA00_CC_P		: inout std_logic;
	FMC1_LA00_CC_N		: inout std_logic;
	FMC1_LA01_CC_P		: inout std_logic;
	FMC1_LA01_CC_N		: inout std_logic;
	FMC1_LA02_P		: inout std_logic;
	FMC1_LA02_N		: inout std_logic;
	FMC1_LA03_P		: inout std_logic;
	FMC1_LA03_N		: inout std_logic;
	FMC1_LA04_P		: inout std_logic;
	FMC1_LA04_N		: inout std_logic;
	FMC1_LA05_P		: inout std_logic;
	FMC1_LA05_N		: inout std_logic;
	FMC1_LA06_P		: inout std_logic;
	FMC1_LA06_N		: inout std_logic;
	FMC1_LA07_P		: inout std_logic;
	FMC1_LA07_N		: inout std_logic;
	FMC1_LA08_P		: inout std_logic;
	FMC1_LA08_N		: inout std_logic;
	FMC1_LA09_P		: inout std_logic;
	FMC1_LA09_N		: inout std_logic;
	FMC1_LA10_P		: inout std_logic;
	FMC1_LA10_N		: inout std_logic;
	FMC1_LA11_P		: inout std_logic;
	FMC1_LA11_N		: inout std_logic;
	FMC1_LA12_P		: inout std_logic;
	FMC1_LA12_N		: inout std_logic;
	FMC1_LA13_P		: inout std_logic;
	FMC1_LA13_N		: inout std_logic;
	FMC1_LA14_P		: inout std_logic;
	FMC1_LA14_N		: inout std_logic;
	FMC1_LA15_P		: inout std_logic;
	FMC1_LA15_N		: inout std_logic;
	FMC1_LA16_P		: inout std_logic;
	FMC1_LA16_N		: inout std_logic;
	FMC1_LA19_P		: inout std_logic;
	FMC1_LA19_N		: inout std_logic;
	FMC1_LA20_P		: inout std_logic;
	FMC1_LA20_N		: inout std_logic;
	FMC1_LA21_P		: inout std_logic;
	FMC1_LA21_N		: inout std_logic;
	FMC1_LA22_P		: inout std_logic;
	FMC1_LA22_N		: inout std_logic;
	FMC1_LA23_P		: inout std_logic;
	FMC1_LA23_N		: inout std_logic;
	FMC1_LA24_P		: inout std_logic;
	FMC1_LA24_N		: inout std_logic;
	FMC1_LA17_CC_P		: inout std_logic;
	FMC1_LA17_CC_N		: inout std_logic;
	FMC1_LA18_CC_P		: inout std_logic;
	FMC1_LA18_CC_N		: inout std_logic;
	FMC1_LA25_P		: inout std_logic;
	FMC1_LA25_N		: inout std_logic;
	FMC1_LA26_P		: inout std_logic;
	FMC1_LA26_N		: inout std_logic;
	FMC1_LA27_P		: inout std_logic;
	FMC1_LA27_N		: inout std_logic;
	FMC1_LA28_P		: inout std_logic;
	FMC1_LA28_N		: inout std_logic;
	FMC1_LA29_P		: inout std_logic;
	FMC1_LA29_N		: inout std_logic;
	FMC1_LA30_P		: inout std_logic;
	FMC1_LA30_N		: inout std_logic;
	FMC1_LA31_P		: inout std_logic;
	FMC1_LA31_N		: inout std_logic;
	FMC1_LA32_P		: inout std_logic;
	FMC1_LA32_N		: inout std_logic;
	FMC1_LA33_P		: inout std_logic;
	FMC1_LA33_N		: inout std_logic;

	-- FMC1 HA Pairs
	FMC1_HA00_CC_P		: inout std_logic;
	FMC1_HA00_CC_N		: inout std_logic;
	FMC1_HA01_CC_P		: inout std_logic;
	FMC1_HA01_CC_N		: inout std_logic;
	FMC1_HA02_P		: inout std_logic;
	FMC1_HA02_N		: inout std_logic;
	FMC1_HA03_P		: inout std_logic;
	FMC1_HA03_N		: inout std_logic;
	FMC1_HA04_P		: inout std_logic;
	FMC1_HA04_N		: inout std_logic;
	FMC1_HA05_P		: inout std_logic;
	FMC1_HA05_N		: inout std_logic;
	FMC1_HA06_P		: inout std_logic;
	FMC1_HA06_N		: inout std_logic;
	FMC1_HA07_P		: inout std_logic;
	FMC1_HA07_N		: inout std_logic;
	FMC1_HA08_P		: inout std_logic;
	FMC1_HA08_N		: inout std_logic;
	FMC1_HA09_P		: inout std_logic;
	FMC1_HA09_N		: inout std_logic;
	FMC1_HA10_P		: inout std_logic;
	FMC1_HA10_N		: inout std_logic;
	FMC1_HA11_P		: inout std_logic;
	FMC1_HA11_N		: inout std_logic;
	FMC1_HA12_P		: inout std_logic;
	FMC1_HA12_N		: inout std_logic;
	FMC1_HA13_P		: inout std_logic;
	FMC1_HA13_N		: inout std_logic;
	FMC1_HA14_P		: inout std_logic;
	FMC1_HA14_N		: inout std_logic;
	FMC1_HA15_P		: inout std_logic;
	FMC1_HA15_N		: inout std_logic;
	FMC1_HA16_P		: inout std_logic;
	FMC1_HA17_CC_P		: inout std_logic;
	FMC1_HA17_CC_N		: inout std_logic;
	FMC1_HA18_CC_P		: inout std_logic;
	FMC1_HA18_CC_N		: inout std_logic;
	FMC1_HA16_N		: inout std_logic;
	FMC1_HA19_P		: inout std_logic;
	FMC1_HA19_N		: inout std_logic;
	FMC1_HA20_P		: inout std_logic;
	FMC1_HA20_N		: inout std_logic;
	FMC1_HA21_P		: inout std_logic;
	FMC1_HA21_N		: inout std_logic;
	FMC1_HA22_P		: inout std_logic;
	FMC1_HA22_N		: inout std_logic;
	FMC1_HA23_P		: inout std_logic;
	FMC1_HA23_N		: inout std_logic;

	-- FMC1 HB Pairs
	FMC1_HB00_CC_P		: inout std_logic;
	FMC1_HB00_CC_N		: inout std_logic;
	FMC1_HB01_P		: inout std_logic;
	FMC1_HB01_N		: inout std_logic;
	FMC1_HB02_P		: inout std_logic;
	FMC1_HB02_N		: inout std_logic;
	FMC1_HB03_P		: inout std_logic;
	FMC1_HB03_N		: inout std_logic;
	FMC1_HB04_P		: inout std_logic;
	FMC1_HB04_N		: inout std_logic;
	FMC1_HB05_P		: inout std_logic;
	FMC1_HB06_CC_P		: inout std_logic;
	FMC1_HB06_CC_N		: inout std_logic;
	FMC1_HB05_N		: inout std_logic;
	FMC1_HB07_P		: inout std_logic;
	FMC1_HB07_N		: inout std_logic;
	FMC1_HB08_P		: inout std_logic;
	FMC1_HB08_N		: inout std_logic;
	FMC1_HB09_P		: inout std_logic;
	FMC1_HB09_N		: inout std_logic;
	FMC1_HB10_P		: inout std_logic;
	FMC1_HB10_N		: inout std_logic;
	FMC1_HB11_P		: inout std_logic;
	FMC1_HB11_N		: inout std_logic;
	FMC1_HB12_P		: inout std_logic;
	FMC1_HB12_N		: inout std_logic;
	FMC1_HB13_P		: inout std_logic;
	FMC1_HB13_N		: inout std_logic;
	FMC1_HB14_P		: inout std_logic;
	FMC1_HB14_N		: inout std_logic;
	FMC1_HB15_P		: inout std_logic;
	FMC1_HB15_N		: inout std_logic;
	FMC1_HB16_P		: inout std_logic;
	FMC1_HB16_N		: inout std_logic;
	FMC1_HB17_CC_P		: inout std_logic;
	FMC1_HB17_CC_N		: inout std_logic;
	FMC1_HB18_P		: inout std_logic;
	FMC1_HB18_N		: inout std_logic;
	FMC1_HB19_P		: inout std_logic;
	FMC1_HB19_N		: inout std_logic;
	FMC1_HB20_P		: inout std_logic;
	FMC1_HB20_N		: inout std_logic;
	FMC1_HB21_P		: inout std_logic;
	FMC1_HB21_N		: inout std_logic;

	-- MGT118: FMC0 SERDES Lanes
	--FMC0_TX7_P		:   out std_logic;
	--FMC0_TX7_N		:   out std_logic;
	--FMC0_RX7_P		:    in std_logic;
	--FMC0_RX7_N		:    in std_logic;
	--FMC0_TX6_P		:   out std_logic;
	--FMC0_TX6_N		:   out std_logic;
	--FMC0_RX6_P		:    in std_logic;
	--FMC0_RX6_N		:    in std_logic;
	--FMC0_TX5_P		:   out std_logic;
	--FMC0_TX5_N		:   out std_logic;
	--FMC0_RX5_P		:    in std_logic;
	--FMC0_RX5_N		:    in std_logic;
	--FMC0_TX4_P		:   out std_logic;
	--FMC0_TX4_N		:   out std_logic;
	--FMC0_RX4_P		:    in std_logic;
	--FMC0_RX4_N		:    in std_logic;
	CLK156_25MHZ3_P		:    in std_logic;
	CLK156_25MHZ3_N		:    in std_logic;
	CLK125MHZ3_N		:    in std_logic;
	CLK125MHZ3_P		:    in std_logic;

	-- MGT117: FMC0 SERDES Lanes
	--FMC0_TX3_P		:   out std_logic;
	--FMC0_TX3_N		:   out std_logic;
	--FMC0_RX3_P		:    in std_logic;
	--FMC0_RX3_N		:    in std_logic;
	--FMC0_TX2_P		:   out std_logic;
	--FMC0_TX2_N		:   out std_logic;
	--FMC0_RX2_P		:    in std_logic;
	--FMC0_RX2_N		:    in std_logic;
	--FMC0_TX1_P		:   out std_logic;
	--FMC0_TX1_N		:   out std_logic;
	--FMC0_RX1_P		:    in std_logic;
	--FMC0_RX1_N		:    in std_logic;
	--FMC0_TX0_P		:   out std_logic;
	--FMC0_TX0_N		:   out std_logic;
	--FMC0_RX0_P		:    in std_logic;
	--FMC0_RX0_N		:    in std_logic;
	FMC0_GBTCLK0_P		:    in std_logic;
	FMC0_GBTCLK0_N		:    in std_logic;
	FMC0_GBTCLK1_N		:    in std_logic;
	FMC0_GBTCLK1_P		:    in std_logic;

	-- MGT116: FMC0/AMC SERDES Lanes
	--FMC0_TX9_P		:   out std_logic;
	--FMC0_TX9_N		:   out std_logic;
	--FMC0_RX9_P		:    in std_logic;
	--FMC0_RX9_N		:    in std_logic;
	--FMC0_TX8_P		:   out std_logic;
	--FMC0_TX8_N		:   out std_logic;
	--FMC0_RX8_P		:    in std_logic;
	--FMC0_RX8_N		:    in std_logic;
	--AMC_TX1_P		:   out std_logic;
	--AMC_TX1_N		:   out std_logic;
	--AMC_RX1_P		:    in std_logic;
	--AMC_RX1_N		:    in std_logic;
	--AMC_TX0_P		:   out std_logic;
	--AMC_TX0_N		:   out std_logic;
	--AMC_RX0_P		:    in std_logic;
	--AMC_RX0_N		:    in std_logic;
	CLK156_25MHZ2_P		:    in std_logic;
	CLK156_25MHZ2_N		:    in std_logic;
	CLK125MHZ2_N		:    in std_logic;
	CLK125MHZ2_P		:    in std_logic;

	-- MGT115: AMC SERDES Lanes
	AMC_TX4_P		:   out std_logic;
	AMC_TX4_N		:   out std_logic;
	AMC_RX4_P		:    in std_logic;
	AMC_RX4_N		:    in std_logic;
	AMC_TX5_P		:   out std_logic;
	AMC_TX5_N		:   out std_logic;
	AMC_RX5_P		:    in std_logic;
	AMC_RX5_N		:    in std_logic;
	AMC_TX6_P		:   out std_logic;
	AMC_TX6_N		:   out std_logic;
	AMC_RX6_P		:    in std_logic;
	AMC_RX6_N		:    in std_logic;
	AMC_TX7_P		:   out std_logic;
	AMC_TX7_N		:   out std_logic;
	AMC_RX7_P		:    in std_logic;
	AMC_RX7_N		:    in std_logic;
	CLK100MHZ0_P		:    in std_logic;
	CLK100MHZ0_N		:    in std_logic;
	FCLKA_N			:    in std_logic;
	FCLKA_P			:    in std_logic;

	-- MGT114: AMC SERDES Lanes
	AMC_TX8_P		:   out std_logic;
	AMC_TX8_N		:   out std_logic;
	AMC_RX8_P		:    in std_logic;
	AMC_RX8_N		:    in std_logic;
	AMC_TX9_P		:   out std_logic;
	AMC_TX9_N		:   out std_logic;
	AMC_RX9_P		:    in std_logic;
	AMC_RX9_N		:    in std_logic;
	AMC_TX10_P		:   out std_logic;
	AMC_TX10_N		:   out std_logic;
	AMC_RX10_P		:    in std_logic;
	AMC_RX10_N		:    in std_logic;
	AMC_TX11_P		:   out std_logic;
	AMC_TX11_N		:   out std_logic;
	AMC_RX11_P		:    in std_logic;
	AMC_RX11_N		:    in std_logic;
	CLK100MHZ1_P		:    in std_logic;
	CLK100MHZ1_N		:    in std_logic;

	-- MGT113: FMC1/AMC SERDES Lanes
	--AMC_TX3_P		:   out std_logic;
	--AMC_TX3_N		:   out std_logic;
	--AMC_RX3_P		:    in std_logic;
	--AMC_RX3_N		:    in std_logic;
	--AMC_TX4_P		:   out std_logic;
	--AMC_TX4_N		:   out std_logic;
	--AMC_RX4_P		:    in std_logic;
	--AMC_RX4_N		:    in std_logic;
	--FMC1_TX9_P		:   out std_logic;
	--FMC1_TX9_N		:   out std_logic;
	--FMC1_RX9_P		:    in std_logic;
	--FMC1_RX9_N		:    in std_logic;
	--FMC1_TX8_P		:   out std_logic;
	--FMC1_TX8_N		:   out std_logic;
	--FMC1_RX8_P		:    in std_logic;
	--FMC1_RX8_N		:    in std_logic;
	CLK156_25MHZ1_P		:    in std_logic;
	CLK156_25MHZ1_N		:    in std_logic;
	CLK125MHZ1_N		:    in std_logic;
	CLK125MHZ1_P		:    in std_logic;
	
	-- MGT112: FMC1 SERDES Lanes
	--FMC1_TX3_P		:   out std_logic;
	--FMC1_TX3_N		:   out std_logic;
	--FMC1_RX3_P		:    in std_logic;
	--FMC1_RX3_N		:    in std_logic;
	--FMC1_TX2_P		:   out std_logic;
	--FMC1_TX2_N		:   out std_logic;
	--FMC1_RX2_P		:    in std_logic;
	--FMC1_RX2_N		:    in std_logic;
	--FMC1_TX1_P		:   out std_logic;
	--FMC1_TX1_N		:   out std_logic;
	--FMC1_RX1_P		:    in std_logic;
	--FMC1_RX1_N		:    in std_logic;
	--FMC1_TX0_P		:   out std_logic;
	--FMC1_TX0_N		:   out std_logic;
	--FMC1_RX0_P		:    in std_logic;
	--FMC1_RX0_N		:    in std_logic;
	FMC1_GBTCLK0_P		:    in std_logic;
	FMC1_GBTCLK0_N		:    in std_logic;
	FMC1_GBTCLK1_N		:    in std_logic;
	FMC1_GBTCLK1_P		:    in std_logic;

	-- MGT111: FMC1 SERDES Lanes
	--FMC1_TX7_P		:   out std_logic;
	--FMC1_TX7_N		:   out std_logic;
	--FMC1_RX7_P		:    in std_logic;
	--FMC1_RX7_N		:    in std_logic;
	--FMC1_TX6_P		:   out std_logic;
	--FMC1_TX6_N		:   out std_logic;
	--FMC1_RX6_P		:    in std_logic;
	--FMC1_RX6_N		:    in std_logic;
	--FMC1_TX5_P		:   out std_logic;
	--FMC1_TX5_N		:   out std_logic;
	--FMC1_RX5_P		:    in std_logic;
	--FMC1_RX5_N		:    in std_logic;
	--FMC1_TX4_P		:   out std_logic;
	--FMC1_TX4_N		:   out std_logic;
	--FMC1_RX4_P		:    in std_logic;
	--FMC1_RX4_N		:    in std_logic;
	CLK156_25MHZ0_P		:    in std_logic;
	CLK156_25MHZ0_N		:    in std_logic;
	CLK125MHZ0_N		:    in std_logic;
	CLK125MHZ0_P		:    in std_logic;

	-- VADJ/0 Test Points
	TP97			:   out std_logic;
	TP98			:   out std_logic;
	TP101			:   out std_logic;
	TP102			:   out std_logic;
	TP103			:   out std_logic;

	-- VADJ/1 Test Points
	TP81			:   out std_logic;
	TP96			:   out std_logic;

	-- VIO_B_M2C/0 Test Points (Only available when FMC0 is mounted and providing power)
	TP86			:   out std_logic;
	TP88			:   out std_logic;
	TP90			:   out std_logic;
	TP92			:   out std_logic;

	-- VIO_B_M2C/1 Test Points (Only available when FMC1 is mounted and providing power)
	TP83			:   out std_logic;
	TP84			:   out std_logic
);
end amc502_fpga;

architecture behavioral of amc502_fpga is
	ATTRIBUTE SYN_BLACK_BOX : BOOLEAN;

	component clk100mhz1_clocking_wizard
	port (
		clk100mhz1        : in     std_logic;
		clk200mhz         : out    std_logic;
		clk50mhz          : out    std_logic;
		reset             : in     std_logic;
		locked            : out    std_logic
	);
	end component;

	ATTRIBUTE SYN_BLACK_BOX OF clk100mhz1_clocking_wizard : COMPONENT IS TRUE;

	component vt_reset_sync is
	port (
		clk_i :  in std_logic;  -- Clock of the domain into which the reset will be driven
		en_i  :  in std_logic;  -- Tie enable to '1' or to PLL lock, etc
		rst_i :  in std_logic;  -- Asynchronous active high reset input
		rst_o : out std_logic   -- Synchronous active high reset output w/ minimum 2 clock power-on reset assertion
	);
	end component;

	component pcie_x8
	port (
		pci_exp_txp : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		pci_exp_txn : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		pci_exp_rxp : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		pci_exp_rxn : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		user_clk_out : OUT STD_LOGIC;
		user_reset_out : OUT STD_LOGIC;
		user_lnk_up : OUT STD_LOGIC;
		user_app_rdy : OUT STD_LOGIC;
		tx_buf_av : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		tx_cfg_req : OUT STD_LOGIC;
		tx_err_drop : OUT STD_LOGIC;
		s_axis_tx_tready : OUT STD_LOGIC;
		s_axis_tx_tdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		s_axis_tx_tkeep : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		s_axis_tx_tlast : IN STD_LOGIC;
		s_axis_tx_tvalid : IN STD_LOGIC;
		s_axis_tx_tuser : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		m_axis_rx_tdata : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
		m_axis_rx_tkeep : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		m_axis_rx_tlast : OUT STD_LOGIC;
		m_axis_rx_tvalid : OUT STD_LOGIC;
		m_axis_rx_tready : IN STD_LOGIC;
		m_axis_rx_tuser : OUT STD_LOGIC_VECTOR(21 DOWNTO 0);
		cfg_status : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		cfg_command : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		cfg_dstatus : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		cfg_dcommand : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		cfg_lstatus : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		cfg_lcommand : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		cfg_dcommand2 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		cfg_pcie_link_state : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		cfg_pmcsr_pme_en : OUT STD_LOGIC;
		cfg_pmcsr_powerstate : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		cfg_pmcsr_pme_status : OUT STD_LOGIC;
		cfg_received_func_lvl_rst : OUT STD_LOGIC;
		cfg_interrupt : IN STD_LOGIC;
		cfg_interrupt_rdy : OUT STD_LOGIC;
		cfg_interrupt_assert : IN STD_LOGIC;
		cfg_interrupt_di : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		cfg_interrupt_do : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		cfg_interrupt_mmenable : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		cfg_interrupt_msienable : OUT STD_LOGIC;
		cfg_interrupt_msixenable : OUT STD_LOGIC;
		cfg_interrupt_msixfm : OUT STD_LOGIC;
		cfg_interrupt_stat : IN STD_LOGIC;
		cfg_pciecap_interrupt_msgnum : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		cfg_to_turnoff : OUT STD_LOGIC;
		cfg_bus_number : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		cfg_device_number : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		cfg_function_number : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		cfg_bridge_serr_en : OUT STD_LOGIC;
		cfg_slot_control_electromech_il_ctl_pulse : OUT STD_LOGIC;
		cfg_root_control_syserr_corr_err_en : OUT STD_LOGIC;
		cfg_root_control_syserr_non_fatal_err_en : OUT STD_LOGIC;
		cfg_root_control_syserr_fatal_err_en : OUT STD_LOGIC;
		cfg_root_control_pme_int_en : OUT STD_LOGIC;
		cfg_aer_rooterr_corr_err_reporting_en : OUT STD_LOGIC;
		cfg_aer_rooterr_non_fatal_err_reporting_en : OUT STD_LOGIC;
		cfg_aer_rooterr_fatal_err_reporting_en : OUT STD_LOGIC;
		cfg_aer_rooterr_corr_err_received : OUT STD_LOGIC;
		cfg_aer_rooterr_non_fatal_err_received : OUT STD_LOGIC;
		cfg_aer_rooterr_fatal_err_received : OUT STD_LOGIC;
		pl_directed_link_change : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		pl_directed_link_width : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		pl_directed_link_speed : IN STD_LOGIC;
		pl_directed_link_auton : IN STD_LOGIC;
		pl_upstream_prefer_deemph : IN STD_LOGIC;
		pl_sel_lnk_rate : OUT STD_LOGIC;
		pl_sel_lnk_width : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		pl_ltssm_state : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		pl_lane_reversal_mode : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		pl_phy_lnk_up : OUT STD_LOGIC;
		pl_tx_pm_state : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		pl_rx_pm_state : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		pl_link_upcfg_cap : OUT STD_LOGIC;
		pl_link_gen2_cap : OUT STD_LOGIC;
		pl_link_partner_gen2_supported : OUT STD_LOGIC;
		pl_initial_link_width : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		pl_directed_change_done : OUT STD_LOGIC;
		pl_received_hot_rst : OUT STD_LOGIC;
		pl_transmit_hot_rst : IN STD_LOGIC;
		pl_downstream_deemph_source : IN STD_LOGIC;
		cfg_vc_tcvc_map : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		sys_clk : IN STD_LOGIC;
		sys_rst_n : IN STD_LOGIC
	);
	end component;

	signal clk100mhz1_pre		: std_logic;
	signal clk100mhz1		: std_logic;
	signal clk100mhz1_locked	: std_logic;
	signal clk200mhz		: std_logic;
	signal clk50mhz_int		: std_logic;

	signal fclka			: std_logic;

	signal sysrst			: std_logic;
	signal sysrst_n			: std_logic;

	signal toggle_4hz_from_100mhz	: std_logic;

	-- PCIe related signals
	signal pcie0_user_lnk_up	: std_logic;
	signal pcie0_user_app_rdy	: std_logic;
	signal cfg_lstatus		: std_logic_vector(15 downto 0);

	signal fpclka			: std_logic;
	signal fpclkb			: std_logic;
	signal fpclkc			: std_logic;
	signal fpclkd			: std_logic;
	signal fpclke			: std_logic;
	signal fpclkf			: std_logic;
	signal fpclkg			: std_logic;
	signal fpclkh			: std_logic;
begin
	-- Bring in the CLK100MHZ1 from the GTX since this is
	-- the best choice for a general-purpose clock for us to use
	clk100mhz1_ibufds_gte2_inst : IBUFDS_GTE2
	generic map (
		CLKCM_CFG 	=> TRUE,
		CLKRCV_TRST 	=> TRUE,
		CLKSWING_CFG 	=> "11"
	)
	port map (
		O 	=> clk100mhz1_pre,
		ODIV2 	=> open,
		CEB 	=> '0',
		I 	=> CLK100MHZ1_P,
		IB 	=> CLK100MHZ1_N
	);

	-- Put onto a BUFG
	clk100mhz1_bufg_inst : BUFG
	port map (
		O => clk100mhz1,
		I => clk100mhz1_pre
	);

	-- Use the clk100mhz1 clock to generate the 200MHz and 50MHz clocks
	-- that we need for various IP cores
	clk100mhz1_clocking_inst: clk100mhz1_clocking_wizard
	port map (
		clk100mhz1     => clk100mhz1,
		clk200mhz      => clk200mhz,
		clk50mhz       => clk50mhz_int,
		reset          => '0',
		locked         => clk100mhz1_locked 
	);

	-- Generate a startup reset pulse since we can't expect to get
	-- the nCOLDRST signal assertion during FPGA execution
	startup_reset_sync_inst: vt_reset_sync
	port map (
		clk_i => clk100mhz1,
		en_i  => clk100mhz1_locked,
		rst_i => '0',
		rst_o => sysrst
	);

	sysrst_n <= not(sysrst);

	-- generate a 4Hz blinking pattern from the 100MHz clock (shows CLK400MHZ1 input is OK)
	blink_4hz_proc: process( clk100mhz1, sysrst )
		variable count	: integer range 12499999 downto 0;
	begin
		if( sysrst='1' ) then
			count := 0;
			toggle_4hz_from_100mhz <= '1';
		elsif( rising_edge(clk100mhz1) ) then
			if( count < 12499999 ) then
				count := count + 1;
			else
				count := 0;
				toggle_4hz_from_100mhz <= not(toggle_4hz_from_100mhz);
			end if;
		end if;
	end process;

	-- Just loop the UART
	FPGA_TX_UART	<= FPGA_RX_UART;

	-- We won't be using the I2C buses
	SDA_L1		<= 'Z';
	SCL_L1		<= 'Z';
	SDA_L2		<= 'Z';
	SCL_L2		<= 'Z';
	SCL_LLLX	<= 'Z';
	SDA_LLLX	<= 'Z';

	-- Bring in the 100MHz FCLKA from the backplane for PCIe
	fclka_ibufds_gte2_inst : IBUFDS_GTE2
	generic map (
		CLKCM_CFG 	=> TRUE,
		CLKRCV_TRST 	=> TRUE,
		CLKSWING_CFG 	=> "11" )
	port map (
		O 	=> fclka,
		ODIV2 	=> open,
		CEB 	=> '0',
		I 	=> FCLKA_P,
		IB 	=> FCLKA_N
	);

	-- Instance the PCIe Gen2 x8 core for the backplane AMC Ports 4-11
	pcie0_inst: pcie_x8
	port map (
		pci_exp_txp(0)					=> AMC_TX4_P,
		pci_exp_txp(1)					=> AMC_TX5_P,
		pci_exp_txp(2)					=> AMC_TX6_P,
		pci_exp_txp(3)					=> AMC_TX7_P,
		pci_exp_txp(4)					=> AMC_TX8_P,
		pci_exp_txp(5)					=> AMC_TX9_P,
		pci_exp_txp(6)					=> AMC_TX10_P,
		pci_exp_txp(7)					=> AMC_TX11_P,

		pci_exp_txn(0)					=> AMC_TX4_N, 
		pci_exp_txn(1)					=> AMC_TX5_N, 
		pci_exp_txn(2)					=> AMC_TX6_N, 
		pci_exp_txn(3)					=> AMC_TX7_N, 
		pci_exp_txn(4)					=> AMC_TX8_N, 
		pci_exp_txn(5)					=> AMC_TX9_N, 
		pci_exp_txn(6)					=> AMC_TX10_N, 
		pci_exp_txn(7)					=> AMC_TX11_N, 

		pci_exp_rxp(0)					=> AMC_RX4_P, 
		pci_exp_rxp(1)					=> AMC_RX5_P, 
		pci_exp_rxp(2)					=> AMC_RX6_P, 
		pci_exp_rxp(3)					=> AMC_RX7_P, 
		pci_exp_rxp(4)					=> AMC_RX8_P, 
		pci_exp_rxp(5)					=> AMC_RX9_P, 
		pci_exp_rxp(6)					=> AMC_RX10_P, 
		pci_exp_rxp(7)					=> AMC_RX11_P, 

		pci_exp_rxn(0)					=> AMC_RX4_N, 
		pci_exp_rxn(1)					=> AMC_RX5_N, 
		pci_exp_rxn(2)					=> AMC_RX6_N, 
		pci_exp_rxn(3)					=> AMC_RX7_N, 
		pci_exp_rxn(4)					=> AMC_RX8_N, 
		pci_exp_rxn(5)					=> AMC_RX9_N, 
		pci_exp_rxn(6)					=> AMC_RX10_N, 
		pci_exp_rxn(7)					=> AMC_RX11_N, 

		user_clk_out 					=> open,
		user_reset_out 					=> open,
		user_lnk_up 					=> pcie0_user_lnk_up,
		user_app_rdy 					=> pcie0_user_app_rdy,
		tx_buf_av 					=> open,
		tx_cfg_req 					=> open,
		tx_err_drop 					=> open,
		s_axis_tx_tready 				=> open,
		s_axis_tx_tdata 				=> x"00000000000000000000000000000000",
		s_axis_tx_tkeep 				=> x"0000",
		s_axis_tx_tlast 				=> '0',
		s_axis_tx_tvalid 				=> '0',
		s_axis_tx_tuser 				=> x"0",
		m_axis_rx_tdata 				=> open,
		m_axis_rx_tkeep 				=> open,
		m_axis_rx_tlast 				=> open,
		m_axis_rx_tvalid				=> open,
		m_axis_rx_tready 				=> '1',
		m_axis_rx_tuser 				=> open,
		cfg_status 					=> open,
		cfg_command 					=> open,
		cfg_dstatus 					=> open,
		cfg_dcommand 					=> open,
		cfg_lstatus 					=> cfg_lstatus,
		cfg_lcommand 					=> open, 
		cfg_dcommand2 					=> open,
		cfg_pcie_link_state 				=> open,
		cfg_pmcsr_pme_en 				=> open,
		cfg_pmcsr_powerstate 				=> open,
		cfg_pmcsr_pme_status 				=> open,
		cfg_received_func_lvl_rst 			=> open,
		cfg_interrupt					=> '0',
		cfg_interrupt_rdy 				=> open,
		cfg_interrupt_assert 				=> '0',
		cfg_interrupt_di 				=> x"00",
		cfg_interrupt_do 				=> open,
		cfg_interrupt_mmenable 				=> open,
		cfg_interrupt_msienable 			=> open,
		cfg_interrupt_msixenable 			=> open,
		cfg_interrupt_msixfm 				=> open,
		cfg_interrupt_stat 				=> '0',
		cfg_pciecap_interrupt_msgnum 			=> "00000",
		cfg_to_turnoff 					=> open,
		cfg_bus_number 					=> open,
		cfg_device_number 				=> open,
		cfg_function_number 				=> open,
		cfg_bridge_serr_en 				=> open,
		cfg_slot_control_electromech_il_ctl_pulse 	=> open,
		cfg_root_control_syserr_corr_err_en 		=> open,
		cfg_root_control_syserr_non_fatal_err_en 	=> open,
		cfg_root_control_syserr_fatal_err_en 		=> open,
		cfg_root_control_pme_int_en 			=> open,
		cfg_aer_rooterr_corr_err_reporting_en 		=> open,
		cfg_aer_rooterr_non_fatal_err_reporting_en 	=> open,
		cfg_aer_rooterr_fatal_err_reporting_en 		=> open,
		cfg_aer_rooterr_corr_err_received 		=> open,
		cfg_aer_rooterr_non_fatal_err_received 		=> open,
		cfg_aer_rooterr_fatal_err_received 		=> open,
		pl_directed_link_change				=> "00", 
		pl_directed_link_width 				=> "00",
		pl_directed_link_speed 				=> '0',
		pl_directed_link_auton 				=> '0',
		pl_upstream_prefer_deemph 			=> '0',
		pl_sel_lnk_rate 				=> open,
		pl_sel_lnk_width 				=> open,
		pl_ltssm_state 					=> open,
		pl_lane_reversal_mode 				=> open,
		pl_phy_lnk_up 					=> open,
		pl_tx_pm_state 					=> open,
		pl_rx_pm_state 					=> open,
		pl_link_upcfg_cap 				=> open,
		pl_link_gen2_cap 				=> open,
		pl_link_partner_gen2_supported 			=> open,
		pl_initial_link_width 				=> open,
		pl_directed_change_done 			=> open,
		pl_received_hot_rst 				=> open,
		pl_transmit_hot_rst 				=> '0',
		pl_downstream_deemph_source 			=> '0',
		cfg_vc_tcvc_map 				=> open,
		sys_clk 					=> fclka,
		sys_rst_n 					=> sysrst_n
	);

	-- Drive the diagnostic user LEDs
	nULED(0) <= not(pcie0_user_app_rdy);					-- ON=APP Ready
	nULED(1) <= '0' when pcie0_user_lnk_up='1' else				-- ON=Link Up
		    '1';			
	nULED(2) <= '0' when cfg_lstatus(9 downto 4)="001000" else		-- ON=x8, BLINK=Not x8
	            toggle_4hz_from_100mhz;
	nULED(3) <= '0' when cfg_lstatus(3 downto 0)="0010" else		-- ON=Gen2, BLINK=Not Gen2
		    toggle_4hz_from_100mhz;
	
	-- Tri-state the external reset controls
	nPLL_RST 	<= 'Z';
	nLVDS_CBS_RST	<= 'Z';

	-- Bring in the clocks from the Quad PLL
	-- NOTE: The FPCLKA-D are always input from the Quad PLL
	-- and are available regardless of the bank VCCO.
	-- They use external terminations on the board.
	fpclka_ibufds_inst : IBUFDS
	generic map (
		DIFF_TERM     => FALSE, -- 100ohm termination is on the board
		IBUF_LOW_PWR  => FALSE,
		IOSTANDARD    => "LVDS_25" )
	port map (
		O  => fpclka,
		I  => FPCLKA_P,
		IB => FPCLKA_N
	);

	fpclkb_ibufds_inst : IBUFDS
	generic map (
		DIFF_TERM     => FALSE, -- 100ohm termination is on the board
		IBUF_LOW_PWR  => FALSE,
		IOSTANDARD    => "LVDS_25" )
	port map (
		O  => fpclkb,
		I  => FPCLKB_P,
		IB => FPCLKB_N
	);

	fpclkc_ibufds_inst : IBUFDS
	generic map (
		DIFF_TERM     => FALSE, -- 100ohm termination is on the board
		IBUF_LOW_PWR  => FALSE,
		IOSTANDARD    => "LVDS_25" )
	port map (
		O  => fpclkc,
		I  => FPCLKC_P,
		IB => FPCLKC_N
	);

	fpclkd_ibufds_inst : IBUFDS
	generic map (
		DIFF_TERM     => FALSE, -- 100ohm termination is NOT on the board
		IBUF_LOW_PWR  => FALSE,
		IOSTANDARD    => "LVDS_25" )
	port map (
		O  => fpclkd,
		I  => FPCLKD_P,
		IB => FPCLKD_N
	);

	-- Bring in the clocks from the M-LVDS CBS 0
	-- NOTE: The FPCLKE-H can be input or output
	-- and are only available with +2.5V VADJ/1.
	-- They do not have external terminations on the board.
	fpclke_ibufds_inst : IBUFDS
	generic map (
		DIFF_TERM     => TRUE, -- 100ohm termination is NOT on the board
		IBUF_LOW_PWR  => FALSE,
		IOSTANDARD    => "LVDS_25" )
	port map (
		O  => fpclke,
		I  => FPCLKE_P,
		IB => FPCLKE_N
	);

	fpclkf_ibufds_inst : IBUFDS
	generic map (
		DIFF_TERM     => TRUE, -- 100ohm termination is NOT on the board
		IBUF_LOW_PWR  => FALSE,
		IOSTANDARD    => "LVDS_25" )
	port map (
		O  => fpclkf,
		I  => FPCLKF_P,
		IB => FPCLKF_N
	);

	fpclkg_ibufds_inst : IBUFDS
	generic map (
		DIFF_TERM     => TRUE, -- 100ohm termination is NOT on the board
		IBUF_LOW_PWR  => FALSE,
		IOSTANDARD    => "LVDS_25" )
	port map (
		O  => fpclkg,
		I  => FPCLKG_P,
		IB => FPCLKG_N
	);

	fpclkh_ibufds_inst : IBUFDS
	generic map (
		DIFF_TERM     => TRUE, -- 100ohm termination is NOT on the board
		IBUF_LOW_PWR  => FALSE,
		IOSTANDARD    => "LVDS_25" )
	port map (
		O  => fpclkh,
		I  => FPCLKH_P,
		IB => FPCLKH_N
	);

	-- We won't be using the QSPI flash
	D00_MOSIX <= '0';
	D02	  <= 'Z';	-- Pull-up on board
	D03	  <= 'Z';	-- Pull-up on board
	nFCSX	  <= '1';

	-- We won't be using the FMC0 LA/HA/HB pins
	FMC0_LA00_CC_P	<= 'Z';
	FMC0_LA00_CC_N	<= 'Z';
	FMC0_LA01_CC_P	<= 'Z';
	FMC0_LA01_CC_N	<= 'Z';
	FMC0_LA02_P   	<= 'Z';
	FMC0_LA02_N   	<= 'Z';
	FMC0_LA03_P   	<= 'Z';
	FMC0_LA03_N   	<= 'Z';
	FMC0_LA04_P   	<= 'Z';
	FMC0_LA04_N   	<= 'Z';
	FMC0_LA05_P   	<= 'Z';
	FMC0_LA05_N   	<= 'Z';
	FMC0_LA06_P   	<= 'Z';
	FMC0_LA06_N   	<= 'Z';
	FMC0_LA07_P   	<= 'Z';
	FMC0_LA07_N   	<= 'Z';
	FMC0_LA08_P   	<= 'Z';
	FMC0_LA08_N   	<= 'Z';
	FMC0_LA09_P   	<= 'Z';
	FMC0_LA09_N   	<= 'Z';
	FMC0_LA10_P   	<= 'Z';
	FMC0_LA10_N   	<= 'Z';
	FMC0_LA11_P   	<= 'Z';
	FMC0_LA11_N   	<= 'Z';
	FMC0_LA12_P   	<= 'Z';
	FMC0_LA12_N   	<= 'Z';
	FMC0_LA13_P   	<= 'Z';
	FMC0_LA13_N   	<= 'Z';
	FMC0_LA14_P   	<= 'Z';
	FMC0_LA14_N   	<= 'Z';
	FMC0_LA15_P   	<= 'Z';
	FMC0_LA15_N   	<= 'Z';
	FMC0_LA16_P   	<= 'Z';
	FMC0_LA16_N   	<= 'Z';
	FMC0_LA17_CC_P	<= 'Z';
	FMC0_LA17_CC_N	<= 'Z';
	FMC0_LA18_CC_P	<= 'Z';
	FMC0_LA18_CC_N	<= 'Z';
	FMC0_LA19_P   	<= 'Z';
	FMC0_LA19_N   	<= 'Z';
	FMC0_LA20_P   	<= 'Z';
	FMC0_LA20_N   	<= 'Z';
	FMC0_LA21_P   	<= 'Z';
	FMC0_LA21_N   	<= 'Z';
	FMC0_LA22_P   	<= 'Z';
	FMC0_LA22_N   	<= 'Z';
	FMC0_LA23_P   	<= 'Z';
	FMC0_LA23_N   	<= 'Z';
	FMC0_LA24_P   	<= 'Z';
	FMC0_LA24_N   	<= 'Z';
	FMC0_LA25_P   	<= 'Z';
	FMC0_LA25_N   	<= 'Z';
	FMC0_LA26_P   	<= 'Z';
	FMC0_LA26_N   	<= 'Z';
	FMC0_LA27_P   	<= 'Z';
	FMC0_LA27_N   	<= 'Z';
	FMC0_LA28_P   	<= 'Z';
	FMC0_LA28_N   	<= 'Z';
	FMC0_LA29_P   	<= 'Z';
	FMC0_LA29_N   	<= 'Z';
	FMC0_LA30_P   	<= 'Z';
	FMC0_LA30_N   	<= 'Z';
	FMC0_LA31_P   	<= 'Z';
	FMC0_LA31_N   	<= 'Z';
	FMC0_LA32_P   	<= 'Z';
	FMC0_LA32_N   	<= 'Z';
	FMC0_LA33_P   	<= 'Z';
	FMC0_LA33_N   	<= 'Z';
	FMC0_HA00_CC_P	<= 'Z';
	FMC0_HA00_CC_N	<= 'Z';
	FMC0_HA01_CC_P	<= 'Z';
	FMC0_HA01_CC_N	<= 'Z';
	FMC0_HA02_P   	<= 'Z';
	FMC0_HA02_N   	<= 'Z';
	FMC0_HA03_P   	<= 'Z';
	FMC0_HA03_N   	<= 'Z';
	FMC0_HA04_P   	<= 'Z';
	FMC0_HA04_N   	<= 'Z';
	FMC0_HA05_P   	<= 'Z';
	FMC0_HA05_N   	<= 'Z';
	FMC0_HA06_P   	<= 'Z';
	FMC0_HA06_N   	<= 'Z';
	FMC0_HA07_P   	<= 'Z';
	FMC0_HA07_N   	<= 'Z';
	FMC0_HA08_P   	<= 'Z';
	FMC0_HA08_N   	<= 'Z';
	FMC0_HA09_P   	<= 'Z';
	FMC0_HA09_N   	<= 'Z';
	FMC0_HA10_P   	<= 'Z';
	FMC0_HA10_N   	<= 'Z';
	FMC0_HA11_P   	<= 'Z';
	FMC0_HA11_N   	<= 'Z';
	FMC0_HA12_P   	<= 'Z';
	FMC0_HA12_N   	<= 'Z';
	FMC0_HA13_P   	<= 'Z';
	FMC0_HA13_N   	<= 'Z';
	FMC0_HA14_P   	<= 'Z';
	FMC0_HA14_N   	<= 'Z';
	FMC0_HA15_P   	<= 'Z';
	FMC0_HA15_N   	<= 'Z';
	FMC0_HA16_P   	<= 'Z';
	FMC0_HA16_N   	<= 'Z';
	FMC0_HA17_CC_P	<= 'Z';
	FMC0_HA17_CC_N	<= 'Z';
	FMC0_HA18_CC_P	<= 'Z';
	FMC0_HA18_CC_N	<= 'Z';
	FMC0_HA19_P   	<= 'Z';
	FMC0_HA19_N   	<= 'Z';
	FMC0_HA20_P   	<= 'Z';
	FMC0_HA20_N   	<= 'Z';
	FMC0_HA21_P   	<= 'Z';
	FMC0_HA21_N   	<= 'Z';
	FMC0_HA22_P   	<= 'Z';
	FMC0_HA22_N   	<= 'Z';
	FMC0_HA23_P   	<= 'Z';
	FMC0_HA23_N   	<= 'Z';
	FMC0_HB00_CC_P	<= 'Z';
	FMC0_HB00_CC_N	<= 'Z';
	FMC0_HB01_P   	<= 'Z';
	FMC0_HB01_N   	<= 'Z';
	FMC0_HB02_P   	<= 'Z';
	FMC0_HB02_N   	<= 'Z';
	FMC0_HB03_P   	<= 'Z';
	FMC0_HB03_N   	<= 'Z';
	FMC0_HB04_P   	<= 'Z';
	FMC0_HB04_N   	<= 'Z';
	FMC0_HB05_P   	<= 'Z';
	FMC0_HB05_N   	<= 'Z';
	FMC0_HB06_CC_P	<= 'Z';
	FMC0_HB06_CC_N	<= 'Z';
	FMC0_HB07_P   	<= 'Z';
	FMC0_HB07_N   	<= 'Z';
	FMC0_HB08_P   	<= 'Z';
	FMC0_HB08_N   	<= 'Z';
	FMC0_HB09_P   	<= 'Z';
	FMC0_HB09_N   	<= 'Z';
	FMC0_HB10_P   	<= 'Z';
	FMC0_HB10_N   	<= 'Z';
	FMC0_HB11_P   	<= 'Z';
	FMC0_HB11_N   	<= 'Z';
	FMC0_HB12_P   	<= 'Z';
	FMC0_HB12_N   	<= 'Z';
	FMC0_HB13_P   	<= 'Z';
	FMC0_HB13_N   	<= 'Z';
	FMC0_HB14_P   	<= 'Z';
	FMC0_HB14_N   	<= 'Z';
	FMC0_HB15_P   	<= 'Z';
	FMC0_HB15_N   	<= 'Z';
	FMC0_HB16_P   	<= 'Z';
	FMC0_HB16_N   	<= 'Z';
	FMC0_HB17_CC_P	<= 'Z';
	FMC0_HB17_CC_N	<= 'Z';
	FMC0_HB18_P   	<= 'Z';
	FMC0_HB18_N   	<= 'Z';
	FMC0_HB19_P   	<= 'Z';
	FMC0_HB19_N   	<= 'Z';
	FMC0_HB20_P   	<= 'Z';
	FMC0_HB20_N   	<= 'Z';
	FMC0_HB21_P   	<= 'Z';
	FMC0_HB21_N   	<= 'Z';

	-- We won't be using the FMC1 LA/HA/HB pins
	FMC1_LA00_CC_P	<= 'Z';
	FMC1_LA00_CC_N	<= 'Z';
	FMC1_LA01_CC_P	<= 'Z';
	FMC1_LA01_CC_N	<= 'Z';
	FMC1_LA02_P   	<= 'Z';
	FMC1_LA02_N   	<= 'Z';
	FMC1_LA03_P   	<= 'Z';
	FMC1_LA03_N   	<= 'Z';
	FMC1_LA04_P   	<= 'Z';
	FMC1_LA04_N   	<= 'Z';
	FMC1_LA05_P   	<= 'Z';
	FMC1_LA05_N   	<= 'Z';
	FMC1_LA06_P   	<= 'Z';
	FMC1_LA06_N   	<= 'Z';
	FMC1_LA07_P   	<= 'Z';
	FMC1_LA07_N   	<= 'Z';
	FMC1_LA08_P   	<= 'Z';
	FMC1_LA08_N   	<= 'Z';
	FMC1_LA09_P   	<= 'Z';
	FMC1_LA09_N   	<= 'Z';
	FMC1_LA10_P   	<= 'Z';
	FMC1_LA10_N   	<= 'Z';
	FMC1_LA11_P   	<= 'Z';
	FMC1_LA11_N   	<= 'Z';
	FMC1_LA12_P   	<= 'Z';
	FMC1_LA12_N   	<= 'Z';
	FMC1_LA13_P   	<= 'Z';
	FMC1_LA13_N   	<= 'Z';
	FMC1_LA14_P   	<= 'Z';
	FMC1_LA14_N   	<= 'Z';
	FMC1_LA15_P   	<= 'Z';
	FMC1_LA15_N   	<= 'Z';
	FMC1_LA16_P   	<= 'Z';
	FMC1_LA16_N   	<= 'Z';
	FMC1_LA17_CC_P	<= 'Z';
	FMC1_LA17_CC_N	<= 'Z';
	FMC1_LA18_CC_P	<= 'Z';
	FMC1_LA18_CC_N	<= 'Z';
	FMC1_LA19_P   	<= 'Z';
	FMC1_LA19_N   	<= 'Z';
	FMC1_LA20_P   	<= 'Z';
	FMC1_LA20_N   	<= 'Z';
	FMC1_LA21_P   	<= 'Z';
	FMC1_LA21_N   	<= 'Z';
	FMC1_LA22_P   	<= 'Z';
	FMC1_LA22_N   	<= 'Z';
	FMC1_LA23_P   	<= 'Z';
	FMC1_LA23_N   	<= 'Z';
	FMC1_LA24_P   	<= 'Z';
	FMC1_LA24_N   	<= 'Z';
	FMC1_LA25_P   	<= 'Z';
	FMC1_LA25_N   	<= 'Z';
	FMC1_LA26_P   	<= 'Z';
	FMC1_LA26_N   	<= 'Z';
	FMC1_LA27_P   	<= 'Z';
	FMC1_LA27_N   	<= 'Z';
	FMC1_LA28_P   	<= 'Z';
	FMC1_LA28_N   	<= 'Z';
	FMC1_LA29_P   	<= 'Z';
	FMC1_LA29_N   	<= 'Z';
	FMC1_LA30_P   	<= 'Z';
	FMC1_LA30_N   	<= 'Z';
	FMC1_LA31_P   	<= 'Z';
	FMC1_LA31_N   	<= 'Z';
	FMC1_LA32_P   	<= 'Z';
	FMC1_LA32_N   	<= 'Z';
	FMC1_LA33_P   	<= 'Z';
	FMC1_LA33_N   	<= 'Z';
	FMC1_HA00_CC_P	<= 'Z';
	FMC1_HA00_CC_N	<= 'Z';
	FMC1_HA01_CC_P	<= 'Z';
	FMC1_HA01_CC_N	<= 'Z';
	FMC1_HA02_P   	<= 'Z';
	FMC1_HA02_N   	<= 'Z';
	FMC1_HA03_P   	<= 'Z';
	FMC1_HA03_N   	<= 'Z';
	FMC1_HA04_P   	<= 'Z';
	FMC1_HA04_N   	<= 'Z';
	FMC1_HA05_P   	<= 'Z';
	FMC1_HA05_N   	<= 'Z';
	FMC1_HA06_P   	<= 'Z';
	FMC1_HA06_N   	<= 'Z';
	FMC1_HA07_P   	<= 'Z';
	FMC1_HA07_N   	<= 'Z';
	FMC1_HA08_P   	<= 'Z';
	FMC1_HA08_N   	<= 'Z';
	FMC1_HA09_P   	<= 'Z';
	FMC1_HA09_N   	<= 'Z';
	FMC1_HA10_P   	<= 'Z';
	FMC1_HA10_N   	<= 'Z';
	FMC1_HA11_P   	<= 'Z';
	FMC1_HA11_N   	<= 'Z';
	FMC1_HA12_P   	<= 'Z';
	FMC1_HA12_N   	<= 'Z';
	FMC1_HA13_P   	<= 'Z';
	FMC1_HA13_N   	<= 'Z';
	FMC1_HA14_P   	<= 'Z';
	FMC1_HA14_N   	<= 'Z';
	FMC1_HA15_P   	<= 'Z';
	FMC1_HA15_N   	<= 'Z';
	FMC1_HA16_P   	<= 'Z';
	FMC1_HA16_N   	<= 'Z';
	FMC1_HA17_CC_P	<= 'Z';
	FMC1_HA17_CC_N	<= 'Z';
	FMC1_HA18_CC_P	<= 'Z';
	FMC1_HA18_CC_N	<= 'Z';
	FMC1_HA19_P   	<= 'Z';
	FMC1_HA19_N   	<= 'Z';
	FMC1_HA20_P   	<= 'Z';
	FMC1_HA20_N   	<= 'Z';
	FMC1_HA21_P   	<= 'Z';
	FMC1_HA21_N   	<= 'Z';
	FMC1_HA22_P   	<= 'Z';
	FMC1_HA22_N   	<= 'Z';
	FMC1_HA23_P   	<= 'Z';
	FMC1_HA23_N   	<= 'Z';
	FMC1_HB00_CC_P	<= 'Z';
	FMC1_HB00_CC_N	<= 'Z';
	FMC1_HB01_P   	<= 'Z';
	FMC1_HB01_N   	<= 'Z';
	FMC1_HB02_P   	<= 'Z';
	FMC1_HB02_N   	<= 'Z';
	FMC1_HB03_P   	<= 'Z';
	FMC1_HB03_N   	<= 'Z';
	FMC1_HB04_P   	<= 'Z';
	FMC1_HB04_N   	<= 'Z';
	FMC1_HB05_P   	<= 'Z';
	FMC1_HB05_N   	<= 'Z';
	FMC1_HB06_CC_P	<= 'Z';
	FMC1_HB06_CC_N	<= 'Z';
	FMC1_HB07_P   	<= 'Z';
	FMC1_HB07_N   	<= 'Z';
	FMC1_HB08_P   	<= 'Z';
	FMC1_HB08_N   	<= 'Z';
	FMC1_HB09_P   	<= 'Z';
	FMC1_HB09_N   	<= 'Z';
	FMC1_HB10_P   	<= 'Z';
	FMC1_HB10_N   	<= 'Z';
	FMC1_HB11_P   	<= 'Z';
	FMC1_HB11_N   	<= 'Z';
	FMC1_HB12_P   	<= 'Z';
	FMC1_HB12_N   	<= 'Z';
	FMC1_HB13_P   	<= 'Z';
	FMC1_HB13_N   	<= 'Z';
	FMC1_HB14_P   	<= 'Z';
	FMC1_HB14_N   	<= 'Z';
	FMC1_HB15_P   	<= 'Z';
	FMC1_HB15_N   	<= 'Z';
	FMC1_HB16_P   	<= 'Z';
	FMC1_HB16_N   	<= 'Z';
	FMC1_HB17_CC_P	<= 'Z';
	FMC1_HB17_CC_N	<= 'Z';
	FMC1_HB18_P   	<= 'Z';
	FMC1_HB18_N   	<= 'Z';
	FMC1_HB19_P   	<= 'Z';
	FMC1_HB19_N   	<= 'Z';
	FMC1_HB20_P   	<= 'Z';
	FMC1_HB20_N   	<= 'Z';
	FMC1_HB21_P   	<= 'Z';
	FMC1_HB21_N   	<= 'Z';

	-- VADJ/0 Test Points
	TP97		<= 'Z';
	TP98		<= 'Z';
	TP101		<= 'Z';
	TP102		<= 'Z';
	TP103		<= 'Z';

	-- VADJ/1 Test Points
	TP81		<= 'Z';
	TP96		<= 'Z';

	-- VIO_B_M2C/0 Test Points (Only available when FMC0 is mounted and providing power)
	TP86		<= 'Z';
	TP88		<= 'Z';
	TP90		<= 'Z';
	TP92		<= 'Z';

	-- VIO_B_M2C/1 Test Points (Only available when FMC1 is mounted and providing power)
	TP83		<= 'Z';
	TP84		<= 'Z';
end behavioral;
