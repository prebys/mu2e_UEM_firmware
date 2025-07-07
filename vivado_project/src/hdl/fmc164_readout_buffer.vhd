----------------------------------------------------------------------------------
-- Company:  Purdue University Department of Physics and Astronomy and Stuff
-- Engineer: M. Jones
-- 
-- Create Date: 08/30/2016 10:27:55 AM
-- Design Name: AMC502/FMC164
-- Module Name: fmc164_readout_buffer - Behavioral
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fmc164_readout_buffer is
generic (
  length : integer := 512
);
port (
  clka : in std_logic;
  wea : in std_logic;
  dina : in std_logic_vector(15 downto 0);
  offset : in std_logic_vector(15 downto 0);
  trig : in std_logic;
  triggered : out std_logic;
  clkb : in std_logic;
  dvb : out std_logic;
  strobe : out std_logic;
  doutb : out std_logic_vector(31 downto 0);
  free : in std_logic_vector(15 downto 0)
);
end fmc164_readout_buffer;

architecture Behavioral of fmc164_readout_buffer is

  function nbits( n : integer ) return natural is
    variable i : natural;
  begin
    i := 0;
    while ( 2**i < n ) loop
      i := i + 1;
    end loop;
    return i;
  end function;

  type buffer_t is array(length-1 downto 1) of std_logic_vector(15 downto 0);
  signal buf0 : buffer_t;
  signal buf1 : buffer_t;

  attribute syn_ramstyle : string;
  attribute syn_ramstyle of buf0 : signal is "no_rw_check";
  attribute syn_ramstyle of buf1 : signal is "no_rw_check";
 
  signal latched_dina : std_logic_vector(15 downto 0);
  signal latched_offset : std_logic_vector(15 downto 0);
  signal latched_doutb : std_logic_vector(31 downto 0);
  signal latched_addra : std_logic_vector(nbits(length)-1 downto 0);
  signal latched_wea : std_logic_vector(1 downto 0);
  signal addra : std_logic_vector(nbits(length)-1 downto 0) := ( others => '0' );
  signal addrb : std_logic_vector(nbits(length)-2 downto 0) := ( others => '0' );
  signal addrc : std_logic_vector(nbits(length)-1 downto 0) := ( others => '0' );
  signal addrd : std_logic_vector(nbits(length)-1 downto 0) := ( others => '0' );
  signal latched_addrd : std_logic_vector(nbits(length)-1 downto 0) := ( others => '0' );
  signal latched_addrc : std_logic_vector(nbits(length)-1 downto 0) := ( others => '0' );
  signal we : std_logic_vector(1 downto 0);
  signal buffer_offset : integer := length*3/4;
  signal wrenb : std_logic;
  signal stream_strobe : std_logic := '0';
  signal unclogging : std_logic := '0';
  signal latched_trig_a : std_logic;

  type write_state_t is ( Waiting, Trigged, Full, Done );
  signal write_state : write_state_t := Waiting;
  signal latched_write_state : write_state_t := Waiting;

  type read_state_t is ( Idle, Reading, Finished, Flush, Flushed, Done );
  signal read_state : read_state_t := Idle;

begin

  process ( clka ) begin
    if ( clka'event and clka = '1' ) then
      latched_dina <= dina;
      latched_offset <= offset;
      latched_addra <= addra;
      latched_wea <= we;
      latched_trig_a <= trig;
      case write_state is
      when Waiting =>
        addra <= std_logic_vector(unsigned(addra)+1);
        if ( latched_trig_a = '1' ) then
          write_state <= Trigged;
          triggered <= '1';
          addrc <= std_logic_vector(unsigned(addra)+buffer_offset);
          addrd <= std_logic_vector(unsigned(addra)+buffer_offset-2);
        end if;
      when Trigged =>
        addra <= std_logic_vector(unsigned(addra)+1);
        if ( addra = addrc ) then
          write_state <= Full;
        end if;
      when Full =>
        if ( read_state = Done ) then
          write_state <= Done;
        end if;
      when Done =>
        if ( latched_trig_a = '0' ) then
          triggered <= '0';
          write_state <= Waiting;
        end if;
      end case;
    end if;
  end process;

  process ( clka ) begin
    if ( clka'event and clka = '1' ) then
      if ( latched_wea(0) = '1' ) then
        buf0(to_integer(unsigned(latched_addra(latched_addra'left downto 1)))) <= std_logic_vector(signed(latched_dina)-signed(offset));
      end if;
    end if;
  end process;

  process ( clka ) begin
    if ( clka'event and clka = '1' ) then
      if ( latched_wea(1) = '1' ) then
        buf1(to_integer(unsigned(latched_addra(latched_addra'left downto 1)))) <= std_logic_vector(signed(latched_dina)-signed(offset));
      end if;
    end if;
  end process;

  process ( clkb ) begin
    if ( clkb'event and clkb = '1' ) then
      latched_doutb <= buf1(to_integer(unsigned(addrb))) &
                       buf0(to_integer(unsigned(addrb)));
      latched_write_state <= write_state;
      latched_addrd <= addrd;
      latched_addrc <= addrc;

      case read_state is
      when Idle =>
        stream_strobe <= '0';
        wrenb <= '0';
        if ( latched_write_state = Full ) then
          read_state <= Reading;
          addrb <= latched_addrc(addrc'left downto 1);
        end if;
      when Reading =>
        stream_strobe <= '0';
        wrenb <= '1';
        addrb <= std_logic_vector(unsigned(addrb)+1);
        if ( addrb = latched_addrd(addrd'left downto 1) ) then
          read_state <= Finished;
        end if;
      when Finished =>
        stream_strobe <= '0';
        wrenb <= '0';
        read_state <= Flush;
      when Flush =>
        if ( unclogging = '1' ) then
          if ( free(free'left downto free'left-1) = "11" ) then
            unclogging <= '0';
          end if;
        else
          if ( free(free'left) = '0' ) then
            unclogging <= '1';
          end if;
        end if;
        wrenb <= '0';
        stream_strobe <= '1';
        read_state <= Flushed;
      when Flushed =>
        stream_strobe <= '0'; 
        wrenb <= '0';
        read_state <= Done;
      when Done =>
        if ( latched_write_state = Waiting ) then
          read_state <= Idle;       
        end if;
      end case;
    end if;
  end process;

  we <= "00" when write_state = Full else
        "00" when wea = '0' else
        "01" when addra(0) = '0' else
        "10" when addra(0) = '1';

  dvb <= wrenb;
  strobe <= stream_strobe;
  doutb <= latched_doutb;

end Behavioral;
