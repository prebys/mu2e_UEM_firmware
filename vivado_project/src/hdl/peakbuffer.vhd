----------------------------------------------------------------------------------
-- Company: UC Davis
-- Engineer: Nguyen Minh Truong
-- 
-- Create Date: 05/17/2019 03:24:39 PM
-- Design Name: 
-- Module Name: peakbuffer - Behavioral
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

entity peakbuffer is
generic (
  address_width : integer := 8
);
port (
  clka : in std_logic;
  wea : in std_logic;
  addra : in std_logic_vector(address_width-1 downto 0);
  dina : in std_logic_vector(32 downto 0);
  clkb : in std_logic;
  addrb : in std_logic_vector(address_width-1 downto 0);
  rdenb : in std_logic;
  doutb : out std_logic_vector(35 downto 0)
);
end peakbuffer;

architecture Behavioral of peakbuffer is

  function parity( w : std_logic_vector(7 downto 0) ) return std_logic is
    variable p : std_logic;
  begin
    p := '0';
    for j in 0 to 7 loop
      p := p xor w(j);
    end loop;
    return p;
  end function;

  type buffer_t is array(2**address_width-1 downto 0) of std_logic_vector(35 downto 0);
  signal buf : buffer_t;

  attribute syn_ramstyle : string;
  attribute syn_ramstyle of buf : signal is "no_rw_check";
 
  signal parity_bits : std_logic_vector(3 downto 0);
  signal latched_bits : std_logic_vector(3 downto 0);
  signal latched_dina : std_logic_vector(31 downto 0);
  signal latched_addrb : std_logic_vector(address_width-1 downto 0);
  signal latched_addra : std_logic_vector(address_width-1 downto 0);
  signal latched_wea : std_logic;

begin

  g_parity: for i in 0 to 3 generate
    parity_bits(i) <= parity(dina(8*i+7 downto 8*i));
  end generate;

  process ( clka ) begin
    if ( clka'event and clka = '1' ) then
      latched_dina <= dina;
      latched_bits <= parity_bits;
      latched_addra <= addra;
      latched_wea <= wea;
    end if;
  end process;

  process ( clka ) begin
    if ( clka'event and clka = '1' ) then
      if ( latched_wea = '1' ) then
        buf(to_integer(unsigned(latched_addra))) <= latched_bits & latched_dina;
      end if;
    end if;
  end process;

  process ( clkb ) begin
    if ( clkb'event and clkb = '1' ) then
--      latched_addrb <= addrb;
      if ( rdenb = '1' ) then
--        doutb <= buf(to_integer(unsigned(latched_addrb)));
        doutb <= buf(to_integer(unsigned(addrb)));
      end if;
    end if;
  end process;

end Behavioral;
