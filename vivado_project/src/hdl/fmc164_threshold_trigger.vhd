----------------------------------------------------------------------------------
-- Company:  Purdue University Department of Physics and Astronomy and Stuff
-- Engineer: M. Jones
-- 
-- Create Date: 12/22/2018 9:42:55 AM
-- Design Name: AMC502/FMC164
-- Module Name: fmc164_threshold_trigger - Behavioral
-- Project Name: 
-- Target Devices:  xc7k420tffq1156-2
-- Tool Versions:   Vivado 2016.1
-- Description: Implements a threshold trigger on one data stream
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

entity fmc164_threshold_trigger is
generic (
  length : integer := 512
);
port (
  clk : in std_logic;
  din : in std_logic_vector(15 downto 0);
  offset : in std_logic_vector(15 downto 0);
  threshold : in std_logic_vector(15 downto 0);
  trigger : out std_logic;
  ack : in std_logic
);
end fmc164_threshold_trigger;

architecture Behavioral of fmc164_threshold_trigger is

  signal latched_threshold : std_logic_vector(15 downto 0);
  signal latched_ack : std_logic;
  signal prev_above_threshold : std_logic;

begin

  -- Note: This module does not have a reset signal in its interface.
  -- The prev_above_threshold signal will initialize to its default state on FPGA configuration.
  -- The ack signal serves as a functional reset for the trigger logic.
  
  process ( clk ) begin
    if ( clk'event and clk = '1' ) then
      latched_threshold <= threshold;
      latched_ack <= ack;
      
      -- Check if current sample crosses threshold
      if ( signed(latched_threshold)-signed(offset) < 0 and signed(din)-signed(offset) < signed(latched_threshold) ) then
        -- For negative threshold, current sample is more negative than threshold (exceeds it)
        -- Only trigger if previous sample also exceeded threshold to filter single-sample spikes
        if ( prev_above_threshold = '1' ) then
          trigger <= '1';
        else
          trigger <= '0';
        end if;
        prev_above_threshold <= '1';
      elsif ( signed(latched_threshold)-signed(offset) > 0 and signed(din)-signed(offset) > signed(latched_threshold) ) then
        -- For positive threshold, current sample exceeds positive threshold
        -- Only trigger if previous sample also exceeded threshold to filter single-sample spikes
        if ( prev_above_threshold = '1' ) then
          trigger <= '1';
        else
          trigger <= '0';
        end if;
        prev_above_threshold <= '1';
      elsif ( latched_ack = '1' ) then
        trigger <= '0';
        prev_above_threshold <= '0';
      else
        -- Current sample does not exceed threshold
        trigger <= '0';
        prev_above_threshold <= '0';
      end if;
    end if;
  end process;

end Behavioral;
