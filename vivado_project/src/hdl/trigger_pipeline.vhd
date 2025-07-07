----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/31/2018 07:20:02 PM
-- Design Name: 
-- Module Name: trigger_in - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description:   Infer a dual-port RAM for the trigger pipeline
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

entity trigger_pipeline is
  port (
    rst : in std_logic;
    clk_a : in std_logic;
    en_a : in std_logic;
    bco_a : in std_logic_vector(15 downto 0);
    data_a : in std_logic_vector(15 downto 0);
    bcoclk : in std_logic;
    bco : in std_logic_vector(47 downto 0);
    bco_b : out std_logic_vector(15 downto 0);
    data_b : out std_logic_vector(15 downto 0)
  );
end trigger_pipeline;

architecture Behavioral of trigger_pipeline is

  type ram_t is array(255 downto 0) of std_logic_vector(31 downto 0);
  shared variable ram : ram_t := ( others => ( others => '0' ) );
  signal waddr : std_logic_vector(7 downto 0);
  signal raddr : std_logic_vector(7 downto 0);
  signal data : std_logic_vector(31 downto 0);
  signal en_r : std_logic;
  signal bco_r : std_logic_vector(15 downto 0);
  signal data_r : std_logic_vector(15 downto 0);

begin

  process ( clk_a ) begin
    if ( clk_a'event and clk_a = '1' ) then
      if ( en_r = '1' ) then
        ram(to_integer(unsigned(waddr))) := bco_r & data_r;
      end if;
    end if;
  end process;

  process ( bcoclk ) begin
    if ( bcoclk'event and bcoclk = '1' ) then
      data <= ram(to_integer(unsigned(raddr)));
    end if;
  end process;

  process ( clk_a ) begin
    if ( clk_a'event and clk_a = '1' ) then
      en_r <= en_a;
      data_r <= data_a;
      bco_r <= bco_a;
      waddr <= bco_a(7 downto 0);
    end if;
  end process;

--
--   This is where the fixed trigger latency is determined...
--
  process ( bcoclk ) begin
    if ( bcoclk'event and bcoclk = '1' ) then
      raddr <= std_logic_vector(unsigned(bco(7 downto 0))-x"60");
    end if;
  end process;

  data_b <= data(15 downto 0);
  bco_b <= data(31 downto 16);

end Behavioral;
