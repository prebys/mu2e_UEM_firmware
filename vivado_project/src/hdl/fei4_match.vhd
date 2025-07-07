--------------------------------------------------------------------------------
--
-- Company:
-- Engineer:       Matthew Jones - Purdue University
-- 
-- Create Date:    18:50;13 01/16/2015
-- Design Name:    genesys_fei4
-- Module Name:    fei4_match - RTL
-- Project Name:   FEI4B readout
-- Target Devices: xc5vlx50
-- Tool versions:  ISE 14.4 / 14.6
-- Description:    Matches pixel data found in the FE-I4B data stream
--
-- Dependencies:
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library UNISIM;
use UNISIM.VComponents.all;

entity fei4_match is
  port (
    clk : in std_logic;
    pixel_data : in std_logic_vector(23 downto 0);
    bcid : in std_logic_vector(7 downto 0);
    pixel_dv : in std_logic;
    match : in std_logic_vector(31 downto 0);
    clear : in std_logic;
    match_data : out std_logic_vector(31 downto 0)
  );
end fei4_match;

architecture RTL of fei4_match is

  signal count : unsigned(15 downto 0) := ( others => '0' );
  signal row : std_logic_vector(8 downto 0);
  signal next_row : std_logic_vector(8 downto 0);
  signal col : std_logic_vector(6 downto 0);
  signal matched : std_logic;
  signal match_row : std_logic;
  signal match_col : std_logic;
  signal match_other_row : std_logic;
  signal match_tot : std_logic;
  signal match_bcid : std_logic;
  signal tot : std_logic_vector(3 downto 0);
  signal bc : std_logic_vector(7 downto 0);

begin

  process ( clk, pixel_dv ) begin
    if ( clk'event and clk = '1' ) then
      if ( clear = '1' ) then
        count <= ( others => '0' );
      elsif ( matched = '1' ) then
        if ( count /= x"ffff" ) then
          count <= count + 1;
        end if;
      end if;
    end if;
  end process;
  row <= match(24 downto 16);
  next_row <= std_logic_vector(unsigned(match(24 downto 16))-1);
  col <= match(31 downto 25);
  tot <= match(7 downto 4);
  bc <= match(15 downto 8);
  match_col <= '1' when pixel_data(23 downto 17) = col else '0';
  match_row <= '1' when pixel_data(16 downto 8) = row else '0';
  match_other_row <= '1' when pixel_data(16 downto 8) = next_row and
                              pixel_data(3 downto 0) /= "1111" else '0';
  match_tot <= '1' when pixel_data(7 downto 4) = tot and match_row = '1' else
               '1' when pixel_data(3 downto 0) = tot and match_other_row = '1' else '0';
  match_bcid <= '1' when bcid(7 downto 0) = match(15 downto 8) else '0';

  matched <= pixel_dv and ( match(0) or match_col ) and
                          ( match(1) or match_row or match_other_row ) and
                          ( match(2) or match_tot ) and
                          ( match(3) or match_bcid );
    
  match_data <= match(31 downto 16) & std_logic_vector(count);

end RTL;
