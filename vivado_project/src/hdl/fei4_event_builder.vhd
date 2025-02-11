----------------------------------------------------------------------------------
-- Company:  Purdue University Department of Physics and Astronomy and Stuff
-- Engineer: M. Jones
-- 
-- Create Date: 08/30/2016 10:27:55 AM
-- Design Name: AMC502/FEI4b
-- Module Name: fei4_event_builder - Behavioral
-- Project Name: 
-- Target Devices:  xc7k420tffq1156-2
-- Tool Versions:   Vivado 2016.1
-- Description: Assemble event data and stream to the network interface.
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

library hep337dev;
use hep337dev.gbe.all;

entity fei4_event_builder is
generic (
  nsensor : integer := 2
);
port (
  stream_reset : in std_logic;
  stream_clk : in std_logic;
  stream_wren : out std_logic;
  stream_strobe : out std_logic;
  stream_dout : out std_logic_vector(31 downto 0);
  stream_free : in std_logic_vector(15 downto 0);
  pixel_clk : in std_logic;
  bco : in std_logic_vector(47 downto 0);
  pixels_eof : in std_logic_vector(2*nsensor-1 downto 0);
  pixels_in : in stream_data_array_t(2*nsensor-1 downto 0);
  pixels_dv : in std_logic_vector(2*nsensor-1 downto 0);
  pixels_read : out std_logic_vector(2*nsensor-1 downto 0)
);
end fei4_event_builder;

architecture Behavioral of fei4_event_builder is

  type stream_state_t is ( Idle, SendBcoLow, SendBcoHigh, BumpFifo, SendEvents, SendStrobe, SentStrobe, SendChannel, AddPadding );
  signal stream_state : stream_state_t := Idle;

  signal read_pixel_data : std_logic_vector(2*nsensor-1 downto 0);
  signal events_waiting : std_logic_vector(2*nsensor-1 downto 0) := ( others => '0' );
  signal end_of_event : std_logic_vector(2*nsensor-1 downto 0);
  signal i : integer range 0 to 2*nsensor;
  signal next_channel : integer range 0 to 2*nsensor;
  signal event_ready : std_logic;
  type pixel_data_array_t is array(2*nsensor-1 downto 0) of std_logic_vector(31 downto 0);
  signal pixel_data : pixel_data_array_t;
  signal pixel_data_valid : std_logic_vector(2*nsensor-1 downto 0);
  signal pixel_event_ready : std_logic_vector(2*nsensor-1 downto 0);
  type events_t is array(2*nsensor-1 downto 0) of unsigned(31 downto 0);
  signal events_in : events_t := ( others => ( others => '0') );
  signal events_out : events_t := ( others => ( others => '0') );
  signal packet_wren : std_logic;
  signal packet_dout : std_logic_vector(31 downto 0);
  signal packet_strobe : std_logic;
  signal latched_bco : std_logic_vector(47 downto 0);
  constant nothing_waiting : std_logic_vector(2*nsensor-1 downto 0) := ( others => '0' );

begin

  process ( stream_clk ) begin
    if ( stream_clk'event and stream_clk = '1' ) then
      latched_bco <= bco;
      if ( stream_reset = '1' ) then
        events_waiting <= ( others => '0' );
        events_out <= ( others => ( others => '0' ) );
        packet_wren <= '0';
        packet_strobe <= '0';
        stream_state <= Idle;
      else
        case stream_state is
        when Idle =>
          read_pixel_data <= ( others => '0' );
          packet_wren <= '0';
          packet_strobe <= '0';
          packet_dout <= ( others => '0' );
          if ( event_ready = '1' ) then
--
--  This is for when we expect a trigger to be received by all
--  channels in the system that gets reported regardless of whether
--  there are hit pixels.
--
--            events_waiting <= "11";
--
--  This is for when we just want to read out whatever channels
--  have data ready to go...
--
            events_waiting <= pixel_event_ready;
--
            stream_state <= SendBcoLow;
          end if;
        when SendBcoLow =>
          read_pixel_data <= ( others => '0' );
          packet_wren <= '1';
          packet_strobe <= '0';
          packet_dout <= "00100000" & latched_bco(23 downto 0);
          stream_state <= SendBcoHigh;
        when SendBcoHigh =>
          read_pixel_data <= ( others => '0' );
          packet_wren <= '1';
          packet_strobe <= '0';
          packet_dout <= "00100000" & latched_bco(47 downto 24);
          stream_state <= SendEvents;
        when SendEvents =>
          read_pixel_data <= ( others => '0' );
          packet_wren <= '0';
          packet_strobe <= '0';
          if ( events_waiting = nothing_waiting ) then
            stream_state <= AddPadding;
          else
            i <= next_channel;
            if ( i /= 0 ) then
              stream_state <= BumpFifo;
            end if;
          end if;
        when AddPadding =>
          packet_wren <= '1';
          packet_dout <= ( others => '0' );
          read_pixel_data(i-1) <= '0';
          stream_state <= SendStrobe;
        when BumpFifo =>
          packet_wren <= '0';
          packet_dout <= pixel_data(i-1);
          read_pixel_data(i-1) <= '1';
          stream_state <= SendChannel;
        when SendChannel =>
          packet_wren <= '1';
          packet_dout <= pixel_data(i-1);
          read_pixel_data(i-1) <= '1';
          if ( end_of_event(i-1) = '1' ) then
            events_waiting(i-1) <= '0';
            events_out(i-1) <= events_out(i-1) + 1;
            stream_state <= SendEvents;
          else
          end if;
        when SendStrobe =>
          read_pixel_data <= ( others => '0' );
          packet_wren <= '0';
          packet_strobe <= '1';
          stream_state <= SentStrobe;
        when SentStrobe =>
          read_pixel_data <= ( others => '0' );
          packet_wren <= '0';
          packet_strobe <= '0';
          stream_state <= Idle;
        end case;
      end if;
    end if;
  end process;

  process ( pixel_clk, pixels_eof, events_in, events_out ) begin
    if ( pixel_clk'event and pixel_clk = '1' ) then
      if ( stream_reset = '1' ) then
        events_in <= ( others => ( others => '0' ) );
        pixel_event_ready <= ( others => '0' );
      else
        for j in 0 to 2*nsensor-1 loop
          if ( pixels_eof(j) = '1' ) then
            events_in(j) <= events_in(j) + 1;
            pixel_event_ready(j) <= '1';
          end if;
          if ( events_in(j) /= events_out(j) ) then
            pixel_event_ready(j) <= '1';
          else
            pixel_event_ready(j) <= '0';
          end if;
        end loop;
      end if;
    end if;
  end process;

--
--  event_ready is 1 whenever a fifo contains an event
--
  process ( pixel_event_ready, events_waiting )
    variable events : std_logic := '0';
    variable chan : integer range 0 to 2*nsensor := 0;
  begin
    events := '0';
    chan := 0;
    for j in 0 to 2*nsensor-1 loop
      if ( pixel_event_ready(j) = '1' ) then
        events := '1';
        if ( events_waiting(j) = '1' ) then
          chan := j+1;
        end if;
      end if;
    end loop;
    event_ready <= events;
    next_channel <= chan;
  end process;

  g: for j in 0 to 2*nsensor-1 generate
    pixel_data(j) <= pixels_in(j);
    pixel_data_valid(j) <= pixels_dv(j);
    pixels_read(j) <= read_pixel_data(j);
    end_of_event(j) <= pixel_data(j)(31);
  end generate;

--  pixel_data(0) <= pixels_in0;
--  pixel_data(1) <= pixels_in1;
--  pixel_data_valid(0) <= pixels_dv(0);
--  pixel_data_valid(1) <= pixels_dv(1);
--  pixels_read(0) <= read_pixel_data(0);
--  pixels_read(1) <= read_pixel_data(1);
--  end_of_event(0) <= pixel_data(0)(31);
--  end_of_event(1) <= pixel_data(1)(31);

  stream_wren <= packet_wren;
  stream_strobe <= packet_strobe;
  stream_dout <= packet_dout;

end Behavioral;
