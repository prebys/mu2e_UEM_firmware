----------------------------------------------------------------------------------
-- Company:
-- Engineer:       Matthew Jones - Purdue University
-- 
-- Create Date:    10:52:39 06/14/2016 
-- Design Name:    fmc164
-- Package Name:   fmc164
-- Project Name:   FMC164 firmware
-- Target Devices: xc7k420tffv1156-1
-- Tool versions:  Vivado 2016.1
-- Description:    Interface for Abaco FMC164 board components
--
-- Dependencies:
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

library hep337dev;
use hep337dev.iobus.all;

package fmc164 is

  component fmc164_interface is
    generic (
      nclock : integer := 8
    );
    port (
      clk20mhz : in std_logic;
      cha_clk : in std_logic;
      cha_data : in std_logic_vector(7 downto 0);
      chc_data : in std_logic_vector(7 downto 0);
      che_clk : in std_logic;
      che_data : in std_logic_vector(7 downto 0);
      chg_data : in std_logic_vector(7 downto 0);
      gbe_stream_clk : in std_logic;
      gbe_stream_wren : out std_logic;
      gbe_stream_strobe : out std_logic;
      gbe_stream_dout : out std_logic_vector(31 downto 0);
      gbe_stream_free : in std_logic_vector(15 downto 0);
      busclk : in std_logic;
      iobus : in iobus_t;
      write_data : out std_logic_vector(31 downto 0);
      iobus_ready : out std_logic
    ); 
  end component;

end package fmc164;
