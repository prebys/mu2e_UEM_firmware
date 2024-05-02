----------------------------------------------------------------------------------
-- Company: 	VadaTech Incorporated
-- Engineer: 	Mike McDermott
-- 
-- Create Date: 03/02/2015 05:49:00 PM
-- Design Name: AMC502 FPGA Reference Design
-- Module Name: amc502_fpga - behavioral
-- Project Name: 
-- Target Devices: Kintex-7 420T FFG1156
-- Tool Versions: Vivado 2014.4
-- Description:  This reference design project tests:
--                    * Dual 1000Base-X to AMC Ports 0 & 1
--                    * M-LVDS CBS/Quad PLL Clocking
--                      (MicroBlaze/I2C/UART included to facilitate clock setup)
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

	-- LVDS Clocks to/from M-LVDS CBS (used as output in this image)
	FPCLKE_P		:   out std_logic;
	FPCLKE_N		:   out std_logic;
	FPCLKF_P		:   out std_logic;
	FPCLKF_N		:   out std_logic;
	FPCLKG_P		:   out std_logic;
	FPCLKG_N		:   out std_logic;
	FPCLKH_P		:   out std_logic;
	FPCLKH_N		:   out std_logic;

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
	AMC_TX1_P		:   out std_logic;
	AMC_TX1_N		:   out std_logic;
	AMC_RX1_P		:    in std_logic;
	AMC_RX1_N		:    in std_logic;
	AMC_TX0_P		:   out std_logic;
	AMC_TX0_N		:   out std_logic;
	AMC_RX0_P		:    in std_logic;
	AMC_RX0_N		:    in std_logic;
	CLK156_25MHZ2_P		:    in std_logic;
	CLK156_25MHZ2_N		:    in std_logic;
	CLK125MHZ2_N		:    in std_logic;
	CLK125MHZ2_P		:    in std_logic;

	-- MGT115: AMC SERDES Lanes
	--AMC_TX4_P		:   out std_logic;
	--AMC_TX4_N		:   out std_logic;
	--AMC_RX4_P		:    in std_logic;
	--AMC_RX4_N		:    in std_logic;
	--AMC_TX5_P		:   out std_logic;
	--AMC_TX5_N		:   out std_logic;
	--AMC_RX5_P		:    in std_logic;
	--AMC_RX5_N		:    in std_logic;
	--AMC_TX6_P		:   out std_logic;
	--AMC_TX6_N		:   out std_logic;
	--AMC_RX6_P		:    in std_logic;
	--AMC_RX6_N		:    in std_logic;
	--AMC_TX7_P		:   out std_logic;
	--AMC_TX7_N		:   out std_logic;
	--AMC_RX7_P		:    in std_logic;
	--AMC_RX7_N		:    in std_logic;
	CLK100MHZ0_P		:    in std_logic;
	CLK100MHZ0_N		:    in std_logic;
	FCLKA_N			:    in std_logic;
	FCLKA_P			:    in std_logic;

	-- MGT114: AMC SERDES Lanes
	--AMC_TX8_P		:   out std_logic;
	--AMC_TX8_N		:   out std_logic;
	--AMC_RX8_P		:    in std_logic;
	--AMC_RX8_N		:    in std_logic;
	--AMC_TX9_P		:   out std_logic;
	--AMC_TX9_N		:   out std_logic;
	--AMC_RX9_P		:    in std_logic;
	--AMC_RX9_N		:    in std_logic;
	--AMC_TX10_P		:   out std_logic;
	--AMC_TX10_N		:   out std_logic;
	--AMC_RX10_P		:    in std_logic;
	--AMC_RX10_N		:    in std_logic;
	--AMC_TX11_P		:   out std_logic;
	--AMC_TX11_N		:   out std_logic;
	--AMC_RX11_P		:    in std_logic;
	--AMC_RX11_N		:    in std_logic;
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

	component mb_cpu_wrapper is
	port (
		Clk : in STD_LOGIC;
		dcm_locked : in STD_LOGIC;
		iic_rtl_scl_io : inout STD_LOGIC;
		iic_rtl_sda_io : inout STD_LOGIC;
		reset_rtl : in STD_LOGIC;
		uart_rtl_rxd : in STD_LOGIC;
		uart_rtl_txd : out STD_LOGIC
	);
	end component mb_cpu_wrapper;

	component gbe_master
	port (
		gtrefclk_p : IN STD_LOGIC;
		gtrefclk_n : IN STD_LOGIC;
		gtrefclk_out : OUT STD_LOGIC;
		txn : OUT STD_LOGIC;
		txp : OUT STD_LOGIC;
		rxn : IN STD_LOGIC;
		rxp : IN STD_LOGIC;
		independent_clock_bufg : IN STD_LOGIC;
		userclk_out : OUT STD_LOGIC;
		userclk2_out : OUT STD_LOGIC;
		rxuserclk_out : OUT STD_LOGIC;
		rxuserclk2_out : OUT STD_LOGIC;
		resetdone : OUT STD_LOGIC;
		pma_reset_out : OUT STD_LOGIC;
		mmcm_locked_out : OUT STD_LOGIC;
		gmii_txd : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		gmii_tx_en : IN STD_LOGIC;
		gmii_tx_er : IN STD_LOGIC;
		gmii_rxd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		gmii_rx_dv : OUT STD_LOGIC;
		gmii_rx_er : OUT STD_LOGIC;
		gmii_isolate : OUT STD_LOGIC;
		configuration_vector : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		an_interrupt : OUT STD_LOGIC;
		an_adv_config_vector : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		an_restart_config : IN STD_LOGIC;
		status_vector : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		reset : IN STD_LOGIC;
		signal_detect : IN STD_LOGIC;
		gt0_qplloutclk_out : OUT STD_LOGIC;
		gt0_qplloutrefclk_out : OUT STD_LOGIC
	);
	end component;

	component gbe_slave
	port (
		gtrefclk : IN STD_LOGIC;
		txn : OUT STD_LOGIC;
		txp : OUT STD_LOGIC;
		rxn : IN STD_LOGIC;
		rxp : IN STD_LOGIC;
		independent_clock_bufg : IN STD_LOGIC;
		txoutclk : OUT STD_LOGIC;
		rxoutclk : OUT STD_LOGIC;
		resetdone : OUT STD_LOGIC;
		cplllock : OUT STD_LOGIC;
		userclk : IN STD_LOGIC;
		userclk2 : IN STD_LOGIC;
		pma_reset : IN STD_LOGIC;
		mmcm_locked : IN STD_LOGIC;
		rxuserclk : IN STD_LOGIC;
		rxuserclk2 : IN STD_LOGIC;
		gmii_txd : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		gmii_tx_en : IN STD_LOGIC;
		gmii_tx_er : IN STD_LOGIC;
		gmii_rxd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		gmii_rx_dv : OUT STD_LOGIC;
		gmii_rx_er : OUT STD_LOGIC;
		gmii_isolate : OUT STD_LOGIC;
		configuration_vector : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		an_interrupt : OUT STD_LOGIC;
		an_adv_config_vector : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		an_restart_config : IN STD_LOGIC;
		status_vector : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		reset : IN STD_LOGIC;
		signal_detect : IN STD_LOGIC;
		gt0_qplloutclk_in : IN STD_LOGIC;
		gt0_qplloutrefclk_in : IN STD_LOGIC
	);
	end component;

	signal clk100mhz1_pre		: std_logic;
	signal clk100mhz1		: std_logic;
	signal clk100mhz1_locked	: std_logic;
	signal clk200mhz		: std_logic;
	signal clk50mhz_int		: std_logic;

	signal sysrst			: std_logic;
	signal sysrst_n			: std_logic;

	signal toggle_4hz_from_100mhz	: std_logic;

	signal fpclka			: std_logic;
	signal fpclkb			: std_logic;
	signal fpclkc			: std_logic;
	signal fpclkd			: std_logic;

	signal amc_port0_status_vector	: std_logic_vector(15 downto 0);
	signal amc_port1_status_vector	: std_logic_vector(15 downto 0);
	signal clk125mhz_ref		: std_logic;
	signal gbe_userclk		: std_logic;
	signal gbe_userclk2		: std_logic;
	signal gbe_pma_reset		: std_logic;
	signal gbe_mmcm_locked		: std_logic;
	signal gbe_rxuserclk		: std_logic;
	signal gbe_rxuserclk2		: std_logic;
	signal gbe_gt0_qplloutclk	: std_logic;
	signal gbe_gt0_qplloutrefclk	: std_logic;
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

	-- Instance the MicroBlaze CPU/I2C/UART subsystem which is used to configure the
	-- M-LVDS CBS and Quad PLL for clock testing
	mb_cpu_inst: mb_cpu_wrapper
	port map (
		Clk 		=> clk100mhz1,
		dcm_locked 	=> clk100mhz1_locked,
		iic_rtl_scl_io  => SCL_L1,
		iic_rtl_sda_io  => SDA_L1,
		reset_rtl 	=> sysrst,
		uart_rtl_rxd 	=> FPGA_RX_UART,
		uart_rtl_txd 	=> FPGA_TX_UART
	);

	-- We won't be using the other I2C buses
	SDA_L2		<= 'Z';
	SCL_L2		<= 'Z';
	SCL_LLLX	<= 'Z';
	SDA_LLLX	<= 'Z';

	amc_port0_inst: gbe_master
	port map (
		gtrefclk_p 			=> CLK125MHZ2_P,
		gtrefclk_n 			=> CLK125MHZ2_N,
		gtrefclk_out 			=> clk125mhz_ref,
		txn 				=> AMC_TX0_N,
		txp 				=> AMC_TX0_P,
		rxn 				=> AMC_RX0_N,
		rxp 				=> AMC_RX0_P,
		independent_clock_bufg 		=> clk200mhz,
		userclk_out 			=> gbe_userclk,
		userclk2_out 			=> gbe_userclk2,
		rxuserclk_out 			=> gbe_rxuserclk,
		rxuserclk2_out 			=> gbe_rxuserclk2,
		resetdone 			=> open,
		pma_reset_out 			=> gbe_pma_reset,
		mmcm_locked_out 		=> gbe_mmcm_locked,
		gmii_txd 			=> x"00",
		gmii_tx_en 			=> '0',
		gmii_tx_er 			=> '0',
		gmii_rxd 			=> open,
		gmii_rx_dv 			=> open,
		gmii_rx_er 			=> open,
		gmii_isolate 			=> open,
		configuration_vector		=> "10000",
		an_interrupt 			=> open,
		an_adv_config_vector		=> "0000000110100000",
		an_restart_config 		=> '0',
		status_vector 			=> amc_port0_status_vector,
		reset 				=> sysrst,
		signal_detect 			=> '1',
		gt0_qplloutclk_out 		=> gbe_gt0_qplloutclk,
		gt0_qplloutrefclk_out 		=> gbe_gt0_qplloutrefclk
	);

	amc_port1_inst: gbe_slave
	port map (
		gtrefclk			=> clk125mhz_ref,
		txn 				=> AMC_TX1_N,
		txp 				=> AMC_TX1_P,
		rxn 				=> AMC_RX1_N,
		rxp 				=> AMC_RX1_P,
		independent_clock_bufg 		=> clk200mhz,
		txoutclk 			=> open,
		rxoutclk 			=> open,
		resetdone 			=> open,
		cplllock 			=> open,
		userclk 			=> gbe_userclk,
		userclk2			=> gbe_userclk2,
		pma_reset 			=> gbe_pma_reset,
		mmcm_locked			=> gbe_mmcm_locked,
		rxuserclk 			=> gbe_rxuserclk,
		rxuserclk2			=> gbe_rxuserclk2,
		gmii_txd			=> x"00",
		gmii_tx_en 			=> '0',
		gmii_tx_er 			=> '0',
		gmii_rxd 			=> open,
		gmii_rx_dv 			=> open,
		gmii_rx_er 			=> open,
		gmii_isolate 			=> open,
		configuration_vector 		=> "10000",
		an_interrupt 			=> open,
		an_adv_config_vector 		=> "0000000110100000",
		an_restart_config 		=> '0',
		status_vector 			=> amc_port1_status_vector,
		reset 				=> sysrst,
		signal_detect 			=> '1',
		gt0_qplloutclk_in 		=> gbe_gt0_qplloutclk,
		gt0_qplloutrefclk_in 		=> gbe_gt0_qplloutrefclk
	);

	-- Drive the User LEDs
	nULED(0) <= '0';
	nULED(1) <= toggle_4hz_from_100mhz;
	nULED(2) <= '0' when amc_port0_status_vector(0)='1' else 
		    '1';
	nULED(3) <= '0' when amc_port1_status_vector(0)='1' else
		    '1';
	
	-- Tri-state the external reset controls
	nPLL_RST 	<= 'Z';
	nLVDS_CBS_RST	<= 'Z';

	-- Bring in the clocks from the Quad PLL for testing purposes
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
		DIFF_TERM     => FALSE, -- 100ohm termination is on the board
		IBUF_LOW_PWR  => FALSE,
		IOSTANDARD    => "LVDS_25" )
	port map (
		O  => fpclkd,
		I  => FPCLKD_P,
		IB => FPCLKD_N
	);

	-- Route the Quad PLL clocks right back out to the M-LVDS CBS for diagnostic purposes.
	-- NOTE: The FPCLKE-H may be input or output (we use them as output here),
	-- do not have external terminations on the board, and are only
	-- usable for input or output when +VADJ/1=2.5V.
	fpclke_obufds_inst : OBUFDS
	generic map (
		IOSTANDARD => "LVDS_25",
		SLEW => "FAST" )
	port map (
		O  => FPCLKE_P,
		OB => FPCLKE_N,
		I  => fpclka
	);

	fpclkf_obufds_inst : OBUFDS
	generic map (
		IOSTANDARD => "LVDS_25",
		SLEW => "FAST" )
	port map (
		O  => FPCLKF_P,
		OB => FPCLKF_N,
		I  => fpclkb
	);

	fpclkg_obufds_inst : OBUFDS
	generic map (
		IOSTANDARD => "LVDS_25",
		SLEW => "FAST" )
	port map (
		O  => FPCLKG_P,
		OB => FPCLKG_N,
		I  => fpclkc
	);

	fpclkh_obufds_inst : OBUFDS
	generic map (
		IOSTANDARD => "LVDS_25",
		SLEW => "FAST" )
	port map (
		O  => FPCLKH_P,
		OB => FPCLKH_N,
		I  => fpclkd
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
	TP97		<= CLK50MHZ;		-- Preserve EMCCLK (CLK50MHZ) as an input (See AR #44635)
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
