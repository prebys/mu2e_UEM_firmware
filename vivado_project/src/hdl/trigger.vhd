----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 1/1/2019  3:15 am
-- Design Name: 
-- Module Name: trigger_ram - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description:   Trigger pipeline for the DAQ system
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
--  clk_in . . . . 6.4 ns xgmii clock
--  run  . . . . . enables extracting triggers from the pipeline
--  trig_in  . . . Trigger data input
--  write_en . . . enables writing of trigger data to RAM
--  addr_in  . . . input address for spying on trigger pipeline
--  trig_data  . . otuput data for spying on trigger pipeline
--  bcoclk . . . . Output clock for pipeline
--  bco_set  . . . Input to set the current bco count
--  set_bco  . . . Sets the current BCO count to the input
--  trig_out . . . Output trigger word
--  trig_bco . . . BCO counter value associated with output trigger word
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library hep337dev;
use hep337dev.validation.all;

entity trigger is
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
end trigger;

architecture Behavioral of trigger is

  component trigger_ram
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
  end component;

  signal write_address : std_logic_vector(7 downto 0);
  signal read_address : std_logic_vector(7 downto 0);
  signal read_bco : std_logic_vector(47 downto 0);
  signal write_bco : std_logic_vector(47 downto 0);
  signal trigger_words : std_logic_vector(63 downto 0);
  signal trigger_input : std_logic_vector(63 downto 0);
  signal read_enable : std_logic;
  signal latched_run : std_logic;
  signal trigger_write_enable : std_logic;

begin

  ram_imp : trigger_ram
  port map (
    clk_a => clk_in,
    en_a => '1',
    wen_a => trigger_write_enable,
    din_a => trigger_input,
    addr_a => write_address,
    dout_a => trig_data,
    clk_b => bcoclk,
    en_b => read_enable,
    wen_b => run,
    addr_b => read_address,
    dout_b => trigger_words,
    din_b => x"f8f8f8f8f8f8f8f8"    -- Mark invalid after read
  );

  process ( clk_in ) begin
    if ( clk_in'event and clk_in = '1' ) then
      if ( run = '1' ) then
        if ( trig_in(63 downto 62) = "10" ) then
          write_bco <= std_logic_vector(unsigned(trig_in(47 downto 0)));
          report "Reset write bco pointer to " & dlong_to_string('0'&trig_in(62 downto 0));
        elsif ( trig_in(63) = '0' ) then
          write_address <= write_bco(9 downto 2);
          trigger_input <= trig_in;
          if ( write_en = '1' ) then
            report "Writing trigger words " & dlong_to_string(trig_in) &
                   " at BCO = " & dlong_to_string(x"0000" & std_logic_vector(unsigned(write_bco)));
            write_bco <= std_logic_vector(unsigned(write_bco)+4);
          end if;
        end if;
      else
        write_address <= addr_in;  -- Spying on trigger pipeline when stopped.
        trigger_input <= ( others => '0' );
      end if;
    end if;
  end process;

  trigger_write_enable <= write_en when run = '1' and trig_in(63) = '0' else '0';

  process ( bcoclk ) begin
    if ( bcoclk'event and bcoclk = '1' ) then
      latched_run <= run;
      if ( set_bco = '1' ) then
        read_bco <= std_logic_vector(unsigned(bco_set)-127);
        report "Set read BCO pointer to " &
               dlong_to_string(x"0000" & std_logic_vector(unsigned(bco_set)-127));
      elsif ( run = '1' ) then
        read_bco <= std_logic_vector(unsigned(read_bco)+1);
      end if;
    end if;
  end process;
  read_enable <= '1' when read_bco(1 downto 0) = "11" else '0';
  read_address <= read_bco(9 downto 2);
  trig_bco <= read_bco;
  trig_out <= ( others => '0' ) when run = '0' else
              trigger_words(15 downto 0) when read_bco(1 downto 0) = "00" else
              trigger_words(31 downto 16) when read_bco(1 downto 0) = "01" else
              trigger_words(47 downto 32) when read_bco(1 downto 0) = "10" else
              trigger_words(63 downto 48);
  
end Behavioral;
