----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/31/2018 07:20:02 PM
-- Design Name: 
-- Module Name: trigger_ram - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description:   Infer a dual-port RAM for trigger distribution.
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

library hep337dev;
use hep337dev.validation.all;

entity trigger_ram is
port (
  clk_a : in std_logic;
  en_a : in std_logic;
  wen_a : in std_logic;
  din_a : in std_logic_vector(63 downto 0);
  addr_a : in std_logic_vector(7 downto 0);
  dout_a : out std_logic_vector(63 downto 0);
  clk_b : in std_logic;
  en_b : in std_logic;
  wen_b : in std_logic;
  addr_b : in std_logic_vector(7 downto 0);
  dout_b : out std_logic_vector(63 downto 0);
  din_b : in std_logic_vector(63 downto 0)
);
end trigger_ram;

architecture Behavioral of trigger_ram is

  type ram_t is array(255 downto 0) of std_logic_vector(63 downto 0);
  shared variable ram : ram_t := ( others => ( others => '0' ) );

begin

  process ( clk_a ) begin
    if ( clk_a'event and clk_a = '1' ) then
      if ( en_a = '1' ) then
        dout_a <= ram(to_integer(unsigned(addr_a)));
        if ( wen_a = '1' ) then
          ram(to_integer(unsigned(addr_a))) := din_a;
        end if;
      end if;
    end if;
  end process;

  process ( clk_b ) begin
    if ( clk_b'event and clk_b = '1' ) then
      if ( en_b = '1' ) then
        dout_b <= ram(to_integer(unsigned(addr_b)));
        if ( wen_b = '1' ) then
          ram(to_integer(unsigned(addr_b))) := din_b;
        end if;
      end if;
    end if;
  end process;

end Behavioral;
