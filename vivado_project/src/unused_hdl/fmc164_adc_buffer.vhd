----------------------------------------------------------------------------------
-- Company:  Purdue University Department of Physics and Astronomy and Stuff
-- Engineer: M. Jones
-- 
-- Create Date: 08/30/2016 10:27:55 AM
-- Design Name: AMC502/FMC164
-- Module Name: fmc164_adc_buffer - Behavioral
-- Project Name: 
-- Target Devices:  xc7k420tffq1156-2
-- Tool Versions:   Vivado 2016.1
-- Description: Implements a circular dual port RAM buffer using inferred
--              block RAM resources
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fmc164_adc_buffer is
generic (
  address_width : integer := 8
);
port (
  clka : in std_logic;
  wea : in std_logic;
  addra : in std_logic_vector(address_width downto 0);
  dina : in std_logic_vector(15 downto 0);
  clkb : in std_logic;
  addrb : in std_logic_vector(address_width-1 downto 0);
  rdenb : in std_logic;
  doutb : out std_logic_vector(31 downto 0)
);
end fmc164_adc_buffer;

architecture Behavioral of fmc164_adc_buffer is

  type buffer_t is array(2**address_width-1 downto 0) of std_logic_vector(15 downto 0);
  signal buf1 : buffer_t;
  signal buf2 : buffer_t;

  attribute syn_ramstyle : string;
  attribute syn_ramstyle of buf1 : signal is "no_rw_check";
  attribute syn_ramstyle of buf2 : signal is "no_rw_check";
 
  signal latched_dina : std_logic_vector(15 downto 0);
  signal latched_addrb : std_logic_vector(address_width-1 downto 0);
  signal latched_addra : std_logic_vector(address_width downto 0);
  signal latched_wea : std_logic;

begin

  process ( clka ) begin
    if ( clka'event and clka = '1' ) then
      latched_dina <= dina;
      latched_addra <= addra;
      latched_wea <= wea;
      if ( latched_wea = '1' ) then
        if ( latched_addra(0) = '0' ) then
          buf1(to_integer(unsigned(latched_addra(address_width downto 1)))) <= latched_dina;
        else
          buf2(to_integer(unsigned(latched_addra(address_width downto 1)))) <= latched_dina;
        end if;
      end if;
    end if;
  end process;

  process ( clkb ) begin
    if ( clkb'event and clkb = '1' ) then
      if ( rdenb = '1' ) then
        doutb <= buf2(to_integer(unsigned(addrb))) & buf1(to_integer(unsigned(addrb)));
      end if;
    end if;
  end process;

end Behavioral;
