----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/21/2016 09:26:13 AM
-- Design Name: 
-- Module Name: fei4_bcocounter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

entity fei4_bcocounter is
port (
  bcoclk : in std_logic;
  reset : in std_logic;
  bco_enable : in std_logic;
  bco_clear : in std_logic;
  bco : out std_logic_vector(47 downto 0)
);
end fei4_bcocounter;

architecture Behavioral of fei4_bcocounter is
  signal count : unsigned(bco'left downto 0) := ( others => '0' );
begin

  process ( bcoclk, reset, bco_enable, bco_clear ) begin
    if ( bcoclk'event and bcoclk = '1' ) then
      bco <= std_logic_vector(count);
      if ( bco_enable = '1' ) then
        count <= count + 1;
      end if;
    end if;
  end process;

end Behavioral;
