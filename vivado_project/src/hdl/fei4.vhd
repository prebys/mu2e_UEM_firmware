----------------------------------------------------------------------------------
-- Company:
-- Engineer:       Matthew Jones - Purdue University
-- 
-- Create Date:    11/18/2017 
-- Design Name:    mu2e_amc502
-- Package Name:   fei4
-- Project Name:   Mu2e
-- Target Devices: xc7k420tffv1156-1
-- Tool versions:  Vivado 2016.1
-- Description:    This defines the interface to the fei4 slave.
--
-- Dependencies:
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library hep337dev;
use hep337dev.iobus.all;

package fei4 is

  type fei4_data_array_t is array(integer range <>) of std_logic_vector(31 downto 0);

  component fei4_interface
  generic ( nsensor : integer := 2 );
  port (
    busclk : in std_logic;
    iobus : in iobus_t;
    write_data : out std_logic_vector(31 downto 0);
    iobus_ready : out std_logic;
    clkx : in std_logic;
    clk160mhz : in std_logic;
    clk80mhz : in std_logic;
    fei4_clk : in std_logic;
    fei4_cmd : out std_logic_vector(nsensor-1 downto 0);
    fei4_dob : in std_logic_vector(2*nsensor-1 downto 0);
    fei4_lv1 : in std_logic;
    bco : in std_logic_vector(47 downto 0);
    gbe_stream_clk : in std_logic;
    gbe_stream_wren : out std_logic;
    gbe_stream_strobe : out std_logic;
    gbe_stream_dout : out std_logic_vector(31 downto 0);
    gbe_stream_free : in std_logic_vector(15 downto 0);
    test_in : in std_logic;
    test_out : out std_logic;
    debug : out std_logic_vector(7 downto 0)
  );
  end component;

end package fei4;

