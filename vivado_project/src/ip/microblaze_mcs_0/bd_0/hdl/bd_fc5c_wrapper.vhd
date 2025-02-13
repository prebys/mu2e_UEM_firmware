--Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
--Date        : Thu May  2 16:16:00 2019
--Host        : mu2etest.fnal.gov running 64-bit Scientific Linux Fermi release 6.10 (Ramsey)
--Command     : generate_target bd_fc5c_wrapper.bd
--Design      : bd_fc5c_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_fc5c_wrapper is
  port (
    Clk : in STD_LOGIC;
    FIT1_Toggle : out STD_LOGIC;
    INTC_IRQ : out STD_LOGIC;
    INTC_Interrupt : in STD_LOGIC_VECTOR ( 0 to 0 );
    IO_addr_strobe : out STD_LOGIC;
    IO_address : out STD_LOGIC_VECTOR ( 31 downto 0 );
    IO_byte_enable : out STD_LOGIC_VECTOR ( 3 downto 0 );
    IO_read_data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    IO_read_strobe : out STD_LOGIC;
    IO_ready : in STD_LOGIC;
    IO_write_data : out STD_LOGIC_VECTOR ( 31 downto 0 );
    IO_write_strobe : out STD_LOGIC;
    Reset : in STD_LOGIC;
    UART_Interrupt : out STD_LOGIC;
    UART_rxd : in STD_LOGIC;
    UART_txd : out STD_LOGIC
  );
end bd_fc5c_wrapper;

architecture STRUCTURE of bd_fc5c_wrapper is
  component bd_fc5c is
  port (
    IO_addr_strobe : out STD_LOGIC;
    IO_address : out STD_LOGIC_VECTOR ( 31 downto 0 );
    IO_byte_enable : out STD_LOGIC_VECTOR ( 3 downto 0 );
    IO_read_data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    IO_read_strobe : out STD_LOGIC;
    IO_ready : in STD_LOGIC;
    IO_write_data : out STD_LOGIC_VECTOR ( 31 downto 0 );
    IO_write_strobe : out STD_LOGIC;
    UART_rxd : in STD_LOGIC;
    UART_txd : out STD_LOGIC;
    Clk : in STD_LOGIC;
    Reset : in STD_LOGIC;
    UART_Interrupt : out STD_LOGIC;
    FIT1_Toggle : out STD_LOGIC;
    INTC_Interrupt : in STD_LOGIC_VECTOR ( 0 to 0 );
    INTC_IRQ : out STD_LOGIC
  );
  end component bd_fc5c;
begin
bd_fc5c_i: component bd_fc5c
     port map (
      Clk => Clk,
      FIT1_Toggle => FIT1_Toggle,
      INTC_IRQ => INTC_IRQ,
      INTC_Interrupt(0) => INTC_Interrupt(0),
      IO_addr_strobe => IO_addr_strobe,
      IO_address(31 downto 0) => IO_address(31 downto 0),
      IO_byte_enable(3 downto 0) => IO_byte_enable(3 downto 0),
      IO_read_data(31 downto 0) => IO_read_data(31 downto 0),
      IO_read_strobe => IO_read_strobe,
      IO_ready => IO_ready,
      IO_write_data(31 downto 0) => IO_write_data(31 downto 0),
      IO_write_strobe => IO_write_strobe,
      Reset => Reset,
      UART_Interrupt => UART_Interrupt,
      UART_rxd => UART_rxd,
      UART_txd => UART_txd
    );
end STRUCTURE;
