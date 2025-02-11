----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/21/2016 09:26:13 AM
-- Design Name: 
-- Module Name: fei4_lv1count - Behavioral
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

entity fei4_lv1count is
port (
  clk : in std_logic;
  lv1 : in std_logic;
  clear : in std_logic;
  count : out std_logic_vector(31 downto 0)
);
end fei4_lv1count;

architecture Behavioral of fei4_lv1count is
  signal lv1count : unsigned(count'left downto 0) := ( others => '0' );
  signal last_lv1 : std_logic;
begin

  process ( clk, lv1, clear ) begin
    if ( clk'event and clk = '1' ) then
      if ( clear = '1' ) then
        lv1count <= ( others => '0' );
        count <= ( others => '0' );
        last_lv1 <= '0';
      else
        if ( lv1 = '1' and last_lv1 = '0' ) then
          lv1count <= lv1count + 1;
        end if;
        last_lv1 <= lv1;
        count <= std_logic_vector(lv1count);
      end if;
    end if;
  end process;

end Behavioral;
