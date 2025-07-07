----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/15/2018 12:10:17 PM
-- Design Name: 
-- Module Name: sim_crc_tb.vhd - Behavioral
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
--   This test bench compares the result of the crc32x64 code which is based
--   on combinatorial logic, and the crc32x64rom code which uses 8x32 bit
--   lookup tables.
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

library hep337dev;
use hep337dev.validation.all;

entity sim_trigger_tb is
--  Port ( );
end sim_trigger_tb;

architecture behavioral of sim_trigger_tb is

  component trigger
    port (
      clk_in : in std_logic;
      run : in std_logic;
      trig_in : in std_logic_vector(63 downto 0);
      write_en : in std_logic;
      addr_in : in std_logic_vector(7 downto 0);
      trig_data : out std_logic_vector(63 downto 0);
      bcoclk : in std_logic;
      bco_set : in std_logic_vector(47 downto 0);
      set_bco : in std_logic;
      trig_out : out std_logic_vector(15 downto 0);
      trig_bco : out std_logic_vector(47 downto 0)
    );
  end component;

  constant bcoclk_period : time := 25.0 ns;
  constant busclk_period : time := 10.0 ns;
  constant xgmii_clk_period : time := 6.4 ns;

  signal clk : std_logic;
  signal bcoclk : std_logic;
  signal busclk : std_logic;
  signal bco_counter : std_logic_vector(47 downto 0) := x"000000001100";
  signal write_bco : std_logic_vector(47 downto 0) := ( others => '0' );
  signal trigger_bco : std_logic_vector(47 downto 0) := ( others => '0' );
  signal trig : std_logic_vector(15 downto 0);
  signal spy_address : std_logic_vector(7 downto 0) := ( others => '0' );
  signal spy_data : std_logic_vector(63 downto 0);
  signal input_word : std_logic_vector(63 downto 0);
  signal input_count : std_logic_vector(4 downto 0) := "10000";
  signal reading_triggers : std_logic := '0';
  signal dumping : std_logic := '0';
  signal trig_run : std_logic := '1';
  signal write_enable : std_logic := '1';
  signal set_bco : std_logic := '1';

begin

  trig_imp : trigger
  port map (
    clk_in => clk,
    run => trig_run,
    trig_in => input_word,
    write_en => write_enable,
    addr_in => spy_address,
    trig_data => spy_data,
    bcoclk => bcoclk,
    bco_set => bco_counter,
    set_bco => set_bco,
    trig_out => trig,
    trig_bco => trigger_bco
  );

  xgmii_clk_proc : process begin
    clk <= '0';
    wait for xgmii_clk_period/2;
    clk <= '1';
    wait for xgmii_clk_period/2;
  end process;

  bcoclk_proc : process begin
    bcoclk <= '0';
    wait for bcoclk_period/2;
    bcoclk <= '1';
    wait for bcoclk_period/2;
  end process;

  busclk_proc : process begin
    busclk <= '0';
    wait for busclk_period/2;
    busclk <= '1';
    wait for busclk_period/2;
  end process;

  process ( bcoclk ) begin
    if ( bcoclk'event and bcoclk = '1' ) then
      bco_counter <= std_logic_vector(unsigned(bco_counter)+1);
      report "BCO counter = " & dlong_to_string(x"0000" & bco_counter) &
             "   trigger @ " & dlong_to_string(x"0000" & trigger_bco) &
             " = " & short_to_string(trig);
      if ( set_bco = '1' ) then
        report "Set BCO counter.";
        set_bco <= '0';
      end if;
    end if;
  end process;

  process ( clk )
    file infile : text open read_mode is "/tmp/trigger.dat";
    variable input_line : line;
    variable td : string(1 to 16);
  begin
    if ( clk'event and clk = '1' ) then
      if ( not endfile(infile) ) then
        readline(infile,input_line);
        read(input_line,td);
        input_word <= parse_hex_dlong(td);
        if ( input_word(63) = '1' ) then
          write_bco <= input_word(47 downto 0);
          input_count <= "00000";
          report "New trigger block @ " & dlong_to_string(x"0000" & input_word(47 downto 0));
        elsif ( input_count(4) = '0' ) then
          write_bco <= std_logic_vector(unsigned(write_bco)+4);
          input_count <= std_logic_vector(unsigned(input_count)+1);
        else
          write_bco <= std_logic_vector(unsigned(write_bco)+4);
        end if;
      elsif ( dumping = '0' ) then
        report "End of file - BCO = " & dlong_to_string(x"0000" & bco_counter) &
               " - dumping trigger RAM:";
        report "trigger_bco = " & dlong_to_string(x"0000" & trigger_bco);

        trig_run <= '0';
        spy_address <= ( 0 => '1', others => '0' );       
        dumping <= '1';
      elsif ( to_integer(unsigned(spy_address)) /= 0 ) then
        spy_address <= std_logic_vector(unsigned(spy_address)+1);
        if ( spy_address = trigger_bco(9 downto 2) ) then
          report "Trigger read pointer " & dlong_to_string(x"0000" & trigger_bco) & " ==>";
        end if;
        report byte_to_string(spy_address) & " : " & dlong_to_string(spy_data);
      end if;
    end if;
  end process;
  write_enable <= '1' when input_word(63) = '1' else not input_count(4);

end Behavioral;
