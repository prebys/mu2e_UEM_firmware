----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:00:55 01/06/2015 
-- Design Name: 
-- Module Name:    fei4_pulser - RTL 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity fei4_pulser is
  port ( reset : in std_logic;
         strobe : in std_logic;
         continuous : in std_logic;
         internal_state : out std_logic_vector(2 downto 0);
         busy : out std_logic;
         outclk : in std_logic;
         cal : out std_logic;
         lv1 : out std_logic;
         count : in std_logic_vector(7 downto 0);
         delay : in std_logic_vector(7 downto 0);
         freq : in std_logic_vector(7 downto 0);
         bco : in std_logic_vector(47 downto 0)
       );
end fei4_pulser;

architecture RTL of fei4_pulser is

  type state_t is ( Idle, Waiting, Calibrate, Delaying, Trigger, Done );
  signal state : state_t := Idle;
  signal wait_count : unsigned(7 downto 0);
  signal delay_count : unsigned(7 downto 0);
  signal pulse_count : unsigned(7 downto 0);
begin

  process ( outclk, strobe ) begin
    if ( outclk'event and outclk = '1' ) then
      if ( reset = '1' ) then
        state <= Idle;
      else
        case state is
          when Idle =>
            if ( strobe = '1' ) then
              state <= Waiting;
              wait_count <= unsigned(freq);
              pulse_count <= unsigned(count);
            end if;
          when Waiting =>
            if ( wait_count = "00000000" ) then
              state <= Calibrate;
            elsif ( bco(7 downto 0) = "00000000" ) then
              wait_count <= wait_count - 1;
            end if;
          when Calibrate =>
            delay_count <= unsigned(delay);
            if ( continuous = '0' and pulse_count /= "00000000" ) then
              pulse_count <= pulse_count - 1;
            end if;
            state <= Delaying;
          when Delaying =>
            if ( delay_count = "00000000" ) then
              state <= Trigger;
            else
              delay_count <= delay_count - 1;
            end if;
          when Trigger =>
            wait_count <= unsigned(freq);
            if ( continuous = '0' and pulse_count = "00000000" ) then
              state <= Done;
            else
              state <= Waiting;
            end if;
          when Done =>
            if ( strobe = '0' ) then
              state <= Idle;
            end if;
        end case;
      end if;
    end if;
  end process;

  busy <= '0' when state = Idle else '1';
  cal <= '1' when state = Calibrate else '0';
  lv1 <= '1' when state = Trigger else '0';
  internal_state <= "000" when state = Idle else
                    "001" when state = Waiting else
                    "010" when state = Calibrate else
                    "011" when state = Delaying else
                    "100" when state = Trigger else
                    "101" when state = Done else
                    "111";

end RTL;
