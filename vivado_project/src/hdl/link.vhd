----------------------------------------------------------------------------------
-- Company:
-- Engineer:       Matthew Jones - Purdue University
-- 
-- Create Date:    05/31/2013 
-- Design Name:    mu2e_amc502
-- Package Name:   link
-- Project Name:   Mu2e
-- Target Devices: xc7k420tffv1156-1
-- Tool versions:  Vivado 2016.1
-- Description:    This defines the interface to the GTX links.
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

package link is

  component link_interface is
    port (
      rxd2_p : in std_logic;
      rxd2_n : in std_logic;
      txd2_p : out std_logic;
      txd2_n : out std_logic;
      rxd3_p : in std_logic;
      rxd3_n : in std_logic;
      txd3_p : out std_logic;
      txd3_n : out std_logic;
      refclk_p : in std_logic;
      refclk_n : in std_logic;
      bcoclk : in std_logic;
      bco : in std_logic_vector(47 downto 0);
      trigger_input : in std_logic_vector(3 downto 0);
      trigger_output : out std_logic;
      trig : out std_logic;
      busclk : in std_logic;
      iobus : in iobus_t;
      write_data : out std_logic_vector(31 downto 0);
      iobus_ready : out std_logic
    ); 
  end component;

end package link;
