-- (c) Copyright 1995-2019 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:ip:microblaze_mcs:3.0
-- IP Revision: 1

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY microblaze_mcs_0 IS
  PORT (
    Clk : IN STD_LOGIC;
    Reset : IN STD_LOGIC;
    UART_Interrupt : OUT STD_LOGIC;
    FIT1_Toggle : OUT STD_LOGIC;
    INTC_Interrupt : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    INTC_IRQ : OUT STD_LOGIC;
    IO_addr_strobe : OUT STD_LOGIC;
    IO_address : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    IO_byte_enable : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    IO_read_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    IO_read_strobe : OUT STD_LOGIC;
    IO_ready : IN STD_LOGIC;
    IO_write_data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    IO_write_strobe : OUT STD_LOGIC;
    UART_rxd : IN STD_LOGIC;
    UART_txd : OUT STD_LOGIC
  );
END microblaze_mcs_0;

ARCHITECTURE microblaze_mcs_0_arch OF microblaze_mcs_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF microblaze_mcs_0_arch: ARCHITECTURE IS "yes";
  COMPONENT bd_fc5c IS
    PORT (
      Clk : IN STD_LOGIC;
      Reset : IN STD_LOGIC;
      UART_Interrupt : OUT STD_LOGIC;
      FIT1_Toggle : OUT STD_LOGIC;
      INTC_Interrupt : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      INTC_IRQ : OUT STD_LOGIC;
      IO_addr_strobe : OUT STD_LOGIC;
      IO_address : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      IO_byte_enable : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      IO_read_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      IO_read_strobe : OUT STD_LOGIC;
      IO_ready : IN STD_LOGIC;
      IO_write_data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      IO_write_strobe : OUT STD_LOGIC;
      UART_rxd : IN STD_LOGIC;
      UART_txd : OUT STD_LOGIC
    );
  END COMPONENT bd_fc5c;
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF Clk: SIGNAL IS "xilinx.com:signal:clock:1.0 CLK.Clk CLK";
  ATTRIBUTE X_INTERFACE_INFO OF Reset: SIGNAL IS "xilinx.com:signal:reset:1.0 RST.Reset RST";
  ATTRIBUTE X_INTERFACE_INFO OF UART_Interrupt: SIGNAL IS "xilinx.com:signal:interrupt:1.0 INTR.UART_Interrupt INTERRUPT";
  ATTRIBUTE X_INTERFACE_INFO OF INTC_Interrupt: SIGNAL IS "xilinx.com:signal:interrupt:1.0 INTR.INTC_Interrupt INTERRUPT";
  ATTRIBUTE X_INTERFACE_INFO OF INTC_IRQ: SIGNAL IS "xilinx.com:signal:interrupt:1.0 INTR.INTC_IRQ INTERRUPT";
  ATTRIBUTE X_INTERFACE_INFO OF IO_addr_strobe: SIGNAL IS "xilinx.com:interface:mcsio_bus:1.0 IO ADDR_STROBE";
  ATTRIBUTE X_INTERFACE_INFO OF IO_address: SIGNAL IS "xilinx.com:interface:mcsio_bus:1.0 IO ADDRESS";
  ATTRIBUTE X_INTERFACE_INFO OF IO_byte_enable: SIGNAL IS "xilinx.com:interface:mcsio_bus:1.0 IO BYTE_ENABLE";
  ATTRIBUTE X_INTERFACE_INFO OF IO_read_data: SIGNAL IS "xilinx.com:interface:mcsio_bus:1.0 IO READ_DATA";
  ATTRIBUTE X_INTERFACE_INFO OF IO_read_strobe: SIGNAL IS "xilinx.com:interface:mcsio_bus:1.0 IO READ_STROBE";
  ATTRIBUTE X_INTERFACE_INFO OF IO_ready: SIGNAL IS "xilinx.com:interface:mcsio_bus:1.0 IO READY";
  ATTRIBUTE X_INTERFACE_INFO OF IO_write_data: SIGNAL IS "xilinx.com:interface:mcsio_bus:1.0 IO WRITE_DATA";
  ATTRIBUTE X_INTERFACE_INFO OF IO_write_strobe: SIGNAL IS "xilinx.com:interface:mcsio_bus:1.0 IO WRITE_STROBE";
  ATTRIBUTE X_INTERFACE_INFO OF UART_rxd: SIGNAL IS "xilinx.com:interface:uart:1.0 UART RxD";
  ATTRIBUTE X_INTERFACE_INFO OF UART_txd: SIGNAL IS "xilinx.com:interface:uart:1.0 UART TxD";
BEGIN
  U0 : bd_fc5c
    PORT MAP (
      Clk => Clk,
      Reset => Reset,
      UART_Interrupt => UART_Interrupt,
      FIT1_Toggle => FIT1_Toggle,
      INTC_Interrupt => INTC_Interrupt,
      INTC_IRQ => INTC_IRQ,
      IO_addr_strobe => IO_addr_strobe,
      IO_address => IO_address,
      IO_byte_enable => IO_byte_enable,
      IO_read_data => IO_read_data,
      IO_read_strobe => IO_read_strobe,
      IO_ready => IO_ready,
      IO_write_data => IO_write_data,
      IO_write_strobe => IO_write_strobe,
      UART_rxd => UART_rxd,
      UART_txd => UART_txd
    );
END microblaze_mcs_0_arch;
