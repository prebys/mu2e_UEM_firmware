----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/21/2016 09:26:13 AM
-- Design Name: 
-- Module Name: adc_fifo - Behavioral
-- Project Name: fmc164
-- Target Devices: xc7k420tffq1156-2
-- Tool Versions: 2016.2
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adc_fifo is
generic (
  depth : integer := 4;
  width : integer := 15
);
port (
  clka : in std_logic;
  wea : in std_logic;
  dina : in std_logic_vector(width-1 downto 0);
  clkb : in std_logic;
  rdenb : in std_logic;
  doutb : out std_logic_vector(width-1 downto 0);
  full : out std_logic;
  empty : out std_logic
);
end adc_fifo;

architecture Behavioral of adc_fifo is

  function nbits( n : integer ) return natural is
    variable i : natural;
  begin
    i := 0;
    while ( 2**i < n ) loop
      i := i + 1;
    end loop;
    return i;
  end function;

  type ram_type is array(depth-1 downto 0) of std_logic_vector(width-1 downto 0);
  signal ram : ram_type;
  signal raddr : unsigned(nbits(depth)-1 downto 0) := ( others => '0' );
  signal waddr : unsigned(nbits(depth)-1 downto 0) := ( others => '0' );
  signal paddr : unsigned(nbits(depth)-1 downto 0) := ( others => '1' );
  
begin

  process ( clka ) begin
    if ( clka'event and clka = '1' ) then
      if ( wea = '1' and waddr /= paddr ) then
        ram(to_integer(waddr)) <= dina;
        waddr <= waddr + 1;
      end if;
    end if;
  end process;

  process ( clkb ) begin
    if ( clkb'event and clkb = '1' ) then
      doutb <= ram(to_integer(raddr));
      if ( rdenb = '1' and raddr /= waddr ) then
        raddr <= raddr + 1;
        paddr <= paddr + 1;
      end if;
    end if;
  end process;

  full <= '1' when waddr = paddr else '0';
  empty <= '1' when waddr = raddr else '0';

end Behavioral;
