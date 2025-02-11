----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/24/2018 13:10:13
-- Design Name: 
-- Module Name: event_generator - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description:   This generates packets of data containing trigger/timing
--                information to be sent peridically or continuously.
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
--   The process sends XAUI packets at fixed bcoclk intervals.
--   The request to send a packet is sent from the bcoclk domain to the
--   xgmii_clk domain, and the packet data is sent out.  Data is sent on
--   the rising edge of send_pakcet which is sampled at a higher frequency
--   in the xgmii_clk domain than it is generated in the bcoclk domain.
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity event_generator is
port (
  bcoclk : in std_logic;
  strobe : in std_logic;
  busy : out std_logic;
  period : in std_logic_vector(15 downto 0);
  count : in std_logic_vector(7 downto 0);
  bco_counter : in std_logic_vector(47 downto 0);
  xgmii_clk : in std_logic;
  dout : out std_logic_vector(63 downto 0);
  wren : out std_logic;
  send : out std_logic;
  debug : out std_logic_vector(7 downto 0)
 
);
end event_generator;

architecture Behavioral of event_generator is

  type state_t is ( Idle, SendStrobe, WaitPeriod, Finished, SendContinuous,
                    WaitContinuous );
  signal state : state_t := Idle;
  type xgmii_state_t is ( Idle, SendPacketWord1, SendPacketWord2,
                          SendPacketWords, Done );
  signal xgmii_state : xgmii_state_t := Idle;
  signal latched_strobe : std_logic;
  signal latched_count : std_logic_vector(7 downto 0);
  signal latched_period : std_logic_vector(15 downto 0);
  signal counter : unsigned(7 downto 0);
  signal bco_count : unsigned(15 downto 0);
  signal send_packet : std_logic;
  signal send_packet_r : std_logic;
  signal bco_counter_r : std_logic_vector(47 downto 0);
  signal compter : unsigned(31 downto 0) := ( others => '0' );
  signal word_count : std_logic_vector(3 downto 0);

begin

  process ( bcoclk ) begin
    if ( bcoclk'event and bcoclk = '1' ) then
      latched_strobe <= strobe;
      latched_count <= count;
      latched_period <= period;
      case state is
      when Idle =>
        debug <= x"01";
        busy <= '0';
        if ( latched_strobe = '1' ) then
          counter <= unsigned(latched_count);
          if ( latched_count /= x"00" ) then
            state <= SendStrobe;
          else
            state <= SendContinuous;
          end if;
        else
          state <= Idle;
        end if;
      when SendStrobe =>
        debug <= x"02";
        busy <= '1';
--
--  This compensates for two extra clock cycles while servicing the
--  strobe.
--
        bco_count <= unsigned(latched_period)-2;
        if ( counter /= x"00" ) then
          counter <= counter - 1;
          state <= WaitPeriod;
        else
          state <= Finished;
        end if;
      when WaitPeriod =>
        debug <= x"03";
        busy <= '1';
        if ( to_integer(bco_count) = 0 ) then
          state <= SendStrobe;
        else
          bco_count <= bco_count - 1;
          state <= WaitPeriod;
        end if;
      when Finished =>
        debug <= x"04";
        busy <= '1';
        if ( latched_strobe = '0' ) then
          state <= Idle;
        else
          state <= Finished;
        end if;
      when SendContinuous =>
        debug <= x"05";
        busy <= '1';
        bco_count <= unsigned(latched_period)-2;
        state <= WaitContinuous;
      when WaitContinuous =>
        debug <= x"06";
        busy <= '1';
        if ( to_integer(bco_count) = 0 ) then
          if ( latched_strobe = '1' ) then
            state <= SendContinuous;
          else
            state <= Finished;
          end if;
        else
          bco_count <= bco_count - 1;
          state <= WaitContinuous;
        end if;
      when others =>
        debug <= x"08";
        busy <= '1';
        state <= Idle;
      end case;
    end if;
  end process;

  send_packet <= '1' when state = SendStrobe else
                 '1' when state = SendContinuous else '0';

  process ( xgmii_clk ) begin
    if ( xgmii_clk'event and xgmii_clk = '1' ) then
      send_packet_r <= send_packet;
      bco_counter_r <= bco_counter;
      case xgmii_state is
      when Idle =>
        dout <= x"0000000000000000";
        wren <= '0';
        send <= '0';
        if ( send_packet_r = '1' ) then
          compter <= compter + 1;   -- counts trigger blcoks sent
          xgmii_state <= SendPacketWord1;
          report "------------ event_generator: sending packet -------------";
        else
          xgmii_state <= Idle;
        end if;
      when SendPacketWord1 =>
        dout <= x"8000" & std_logic_vector(unsigned(bco_counter_r)-4);
        wren <= '1';
        send <= '0';
        xgmii_state <= SendPacketWord2;
      when SendPacketWord2 =>
        dout <= x"c0000000" & std_logic_vector(compter);
        wren <= '1';
        send <= '0';
        word_count <= ( others => '0' );
        xgmii_state <= SendPacketWords;
      when SendPacketWords =>
        dout <= x"0" & word_count & x"040" & word_count & x"030" & 
                word_count & x"020" & word_count & x"01";
        wren <= '1';
        send <= '0';
        if ( word_count = "1111" ) then
          xgmii_state <= Done;
        else
          word_count <= std_logic_vector(unsigned(word_count) + 1);
          xgmii_state <= SendPacketWords;
        end if;
      when Done =>
        dout <= x"0000000000000000";
        wren <= '0';
        send <= '1';
        if ( send_packet_r = '0' ) then
          xgmii_state <= Idle;
        else
          xgmii_state <= Done;
        end if;
      end case;
    end if;
  end process;

end Behavioral;
