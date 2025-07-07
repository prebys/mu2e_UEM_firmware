----------------------------------------------------------------------------------
-- Company:  Purdue University Department of Physics and Astronomy and Stuff
-- Engineer: M. Jones
-- 
-- Create Date: 08/30/2016 10:27:55 AM
-- Design Name: AMC502/FEI4b
-- Module Name: fei4_readout_buffer - Behavioral
-- Project Name: 
-- Target Devices:  xc7k420tffq1156-2
-- Tool Versions:   Vivado 2016.1
-- Description: Implements a circular dual port RAM buffer using inferred
--              block RAM resources
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

entity fei4_readout_buffer is
generic (
  length : integer := 512
);
port (
  clka : in std_logic;
  wea : in std_logic;
  dina : in std_logic_vector(31 downto 0);
  clkb : in std_logic;
  dvb : out std_logic;
  strobe : out std_logic;
  doutb : out std_logic_vector(31 downto 0);
  free : in std_logic_vector(15 downto 0)
);
end fei4_readout_buffer;

architecture Behavioral of fei4_readout_buffer is

  function nbits( n : integer ) return natural is
    variable i : natural;
  begin
    i := 0;
    while ( 2**i < n ) loop
      i := i + 1;
    end loop;
    return i;
  end function;

  type buffer_t is array(length-1 downto 1) of std_logic_vector(31 downto 0);
  signal buf : buffer_t;

  attribute syn_ramstyle : string;
  attribute syn_ramstyle of buf : signal is "no_rw_check";
 
  signal latched_dina : std_logic_vector(31 downto 0);
  signal latched_doutb : std_logic_vector(31 downto 0);
  signal latched_addra : std_logic_vector(nbits(length)-1 downto 0);
  signal latched_wea : std_logic;
  signal addra : std_logic_vector(nbits(length)-1 downto 0) := ( others => '0' );
  signal addrb : std_logic_vector(nbits(length)-1 downto 0) := ( others => '0' );
  signal wrenb : std_logic;
  signal stream_strobe : std_logic := '0';
  signal unclogging : std_logic := '0';

  type write_state_t is ( Waiting, Triggered, Full );
  signal write_state : write_state_t := Waiting;

  type read_state_t is ( Idle, Reading, Finished, Flush, Flushed );
  signal read_state : read_state_t := Idle;

--  attribute mark_debug : string;
--  attribute mark_debug of addra : signal is "true";
--  attribute mark_debug of latched_dina : signal is "true";
--  attribute mark_debug of latched_addra : signal is "true";
--  attribute mark_debug of latched_wea : signal is "true";

--  attribute mark_debug of addrb : signal is "true";
--  attribute mark_debug of latched_doutb : signal is "true";
--  attribute mark_debug of stream_strobe : signal is "true";
--  attribute mark_debug of wrenb : signal is "true";
--  attribute mark_debug of read_state : signal is "true";

begin

  process ( clka ) begin
    if ( clka'event and clka = '1' ) then
      latched_dina <= dina;
      latched_addra <= addra;
      latched_wea <= wea;
      if ( wea = '1' ) then
        addra <= std_logic_vector(unsigned(addra)+1);
      end if;
    end if;
  end process;

  process ( clka ) begin
    if ( clka'event and clka = '1' ) then
      if ( latched_wea = '1' ) then
        buf(to_integer(unsigned(latched_addra))) <= latched_dina;
      end if;
    end if;
  end process;

  process ( clkb ) begin
    if ( clkb'event and clkb = '1' ) then
      latched_doutb <= buf(to_integer(unsigned(addrb)));
      case read_state is
      when Idle =>
        if ( addrb /= addra ) then
          addrb <= std_logic_vector(unsigned(addrb)+1);
          read_state <= Reading;
          wrenb <= '1';
          stream_strobe <= '0';
        else
          wrenb <= '0';
          stream_strobe <= '0';
        end if;
      when Reading =>
        if ( addrb /= addra ) then
          addrb <= std_logic_vector(unsigned(addrb)+1);
          wrenb <= '1';
          stream_strobe <= '0';
          if ( latched_doutb = x"00000000" ) then
            read_state <= Finished;
          else
            read_state <= Reading;
          end if;
        else
          wrenb <= '0';
        end if;
      when Finished =>
        wrenb <= '0';
        stream_strobe <= '0';
        read_state <= Flush;
      when Flush =>
        wrenb <= '0';
        stream_strobe <= '1';
        read_state <= Flushed;
      when Flushed =>
        wrenb <= '0';
        stream_strobe <= '0';
        read_state <= Idle;
      end case;       
    end if;
  end process;

  dvb <= wrenb;
  strobe <= stream_strobe;
  doutb <= latched_doutb;

end Behavioral;
