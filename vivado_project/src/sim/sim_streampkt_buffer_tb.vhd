----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/28/2018 16:21:17
-- Design Name: 
-- Module Name: sim_stream_buffer_tb.vhd - Behavioral
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
use std.textio.all;

library hep337dev;
use hep337dev.iobus.all;
use hep337dev.xaui.all;
use hep337dev.validation.all;

entity sim_streampkt_buffer_tb is
--  Port ( );
end sim_streampkt_buffer_tb;

architecture behavioral of sim_streampkt_buffer_tb is

  function parse_hex_character( c : character ) return std_logic_vector is
    variable v : std_logic_vector(3 downto 0);
  begin
    case c is
      when '0' =>
        v := "0000";
      when '1' =>
        v := "0001";
      when '2' =>
        v := "0010";
      when '3' =>
        v := "0011";
      when '4' =>
        v := "0100";
      when '5' =>
        v := "0101";
      when '6' =>
        v := "0110";
      when '7' =>
        v := "0111";
      when '8' =>
        v := "1000";
      when '9' =>
        v := "1001";
      when 'a' =>
        v := "1010";
      when 'b' =>
        v := "1011";
      when 'c' =>
        v := "1100";
      when 'd' =>
        v := "1101";
      when 'e' =>
        v := "1110";
      when 'f' =>
        v := "1111";
      when others =>
        v := "0000";
    end case;
    return v;
  end parse_hex_character;

  function parse_hex_byte( s : string ) return std_logic_vector is
    variable d : std_logic_vector(7 downto 0);
  begin
    for i in 1 to 2 loop
      d((2-i)*4+3 downto (2-i)*4) := parse_hex_character(s(i));
    end loop;
    return d;
  end parse_hex_byte;

  function parse_hex_long( s : string ) return std_logic_vector is
    variable d : std_logic_vector(31 downto 0);
  begin
    for i in 1 to 8 loop
      d((8-i)*4+3 downto (8-i)*4) := parse_hex_character(s(i));
    end loop;
    return d;
  end parse_hex_long;

  function parse_hex_dlong( s : string ) return std_logic_vector is
    variable d : std_logic_vector(63 downto 0);
  begin
    for i in 1 to 16 loop
      d((16-i)*4+3 downto (16-i)*4) := parse_hex_character(s(i));
    end loop;
    return d;
  end parse_hex_dlong;

component xaui_stream_buffer
  generic (
    index : integer := 0
  );
  port (
    rst : in std_logic;
    clk_a : in std_logic;
    wen_a : in std_logic;
    din_a : in std_logic_vector(63 downto 0);
    strobe_a : in std_logic;
    clk_b : in std_logic;
    dv_b : out std_logic;
    dout_b : out std_logic_vector(63 downto 0);
    rden_b : in std_logic;
    done_b : out std_logic;
    cksum : out std_logic_vector(15 downto 0);
    length : out std_logic_vector(11 downto 0);
    advance : in std_logic;
    free : out std_logic_vector(15 downto 0);
    lost : out std_logic_vector(15 downto 0)
  );
end component;

  constant xgmii_clk_period : time := 6.4 ns;
  constant bcoclk_period : time := 25.0 ns;
  constant clka_period : time := 10.0 ns;
  constant nstream : integer := 2;

  signal clk100mhz : std_logic := '0';
  signal bcoclk : std_logic := '0';
  signal xgmii_clk : std_logic := '0';

  signal xaui_reset : std_logic := '0';

  signal xgmii_txd : std_logic_vector(63 downto 0);
  signal xgmii_txc : std_logic_vector(7 downto 0);
  signal xgmii_rxd : std_logic_vector(63 downto 0);
  signal xgmii_rxc : std_logic_vector(7 downto 0);

  signal clka : std_logic;
  signal xgbe_stream_wren : std_logic_vector(1 downto 0);
  signal xgbe_stream_strobe : std_logic_vector(1 downto 0);
  signal xgbe_stream_data : xstream_data_array_t(1 downto 0);
  signal xgbe_stream_free : xstream_free_array_t(1 downto 0);

  signal done_b : std_logic_vector(1 downto 0) := ( others => '0' );

  signal streampkt_data_available : std_logic_vector(nstream-1 downto 0) := ( others => '0' );
  signal streampkt_done : std_logic_vector(nstream-1 downto 0) := ( others => '0' );
  signal streampkt_advance : std_logic_vector(nstream-1 downto 0) := ( others => '0' );
  type streampkt_protocol_t is array(nstream-1 downto 0) of std_logic_vector(7 downto 0);
  signal streampkt_protocol : streampkt_protocol_t := ( others => ( others => '0' ) );
  type streampkt_buffer_length_t is array(nstream-1 downto 0) of std_logic_vector(11 downto 0);
  signal streampkt_buffer_length : streampkt_buffer_length_t := ( others => x"028" );
  type streampkt_buffer_cksum_t is array(nstream-1 downto 0) of std_logic_vector(15 downto 0);
  signal streampkt_buffer_cksum : streampkt_buffer_cksum_t := ( others => ( others => '0' ) );
  type streampkt_buffer_data_t is array(nstream-1 downto 0) of std_logic_vector(63 downto 0);
  signal streampkt_buffer_data : streampkt_buffer_data_t;
  signal streampkt_buffer_rden : std_logic_vector(nstream-1 downto 0);
  type streampkt_length_t is array(nstream-1 downto 0) of std_logic_vector(15 downto 0);
  signal streampkt_length : streampkt_length_t := ( others => ( others => '0' ) );
  type streampkt_buffer_free_t is array(nstream-1 downto 0) of std_logic_vector(15 downto 0);
  signal streampkt_buffer_free : streampkt_buffer_free_t := ( others => ( others => '0' ) );
  type streampkt_lost_packets_t is array(nstream-1 downto 0) of std_logic_vector(15 downto 0);
  signal streampkt_lost_packets : streampkt_lost_packets_t := ( others => ( others => '0' ) );
  signal streampkt_gated_strobe : std_logic_vector(nstream-1 downto 0);
  signal streampkt_gated_wren : std_logic_vector(nstream-1 downto 0);
  signal streampkt_fcs : std_logic_vector(nstream-1 downto 0);

  type read_state_t is ( Waiting, Reading, Done );
  signal read_state : read_state_t := Waiting;

begin

  xgbe_clka_proc : process begin
    clka <= '0';
    wait for clka_period/2;
    clka <= '1';
    wait for clka_period/2;
  end process;

  xgmii_clk_proc : process begin
    xgmii_clk <= '0';
    wait for xgmii_clk_period/2;
    xgmii_clk <= '1';
    wait for xgmii_clk_period/2;
  end process;

  bcoclk_proc : process begin
    bcoclk <= '0';
    wait for bcoclk_period/2;
    bcoclk <= '1';
    wait for bcoclk_period/2;
  end process;

  event_proc : process begin
    report "------------------------- New Run -----------------------";

    wait;
  end process;

--
--  This process reads data from a file and streams it on the XAUI interface
--
  stim_process : process ( clka )
    file infile : text open read_mode is "/tmp/streampkt_data.dat";
    variable input_line : line;
    variable sc : string(1 to 2);
    variable c : character;
    variable sd : string(1 to 16);
    variable byte : std_logic_vector(7 downto 0);
  begin
    if ( clka'event and clka = '1' ) then
      if ( not endfile(infile) ) then
        readline(infile,input_line);
        read(input_line,sc);
        byte := parse_hex_byte(sc);
        xgbe_stream_wren(0) <= byte(0);
        xgbe_stream_strobe(0) <= byte(1);
        xgbe_stream_wren(1) <= byte(4);
        xgbe_stream_strobe(1) <= byte(5);
        read(input_line,c);
        read(input_line,sd);
        xgbe_stream_data(0) <= parse_hex_dlong(sd);
        xgbe_stream_data(1) <= parse_hex_dlong(sd);
        if ( byte(0) = '1' ) then
          report "Free words (0) = " & integer'image(to_integer(unsigned(streampkt_buffer_free(0))));
        end if;
        if ( byte(4) = '1' ) then
          report "Free words (1) = " & integer'image(to_integer(unsigned(streampkt_buffer_free(1))));
        end if;
      end if;
    end if;
  end process;

  process ( xgmii_clk ) begin
    if ( xgmii_clk'event and xgmii_clk = '1' ) then
      case read_state is
      when Waiting =>
        streampkt_advance(0) <= '0';
        if ( streampkt_data_available(0) = '1' ) then
          read_state <= Reading;
          report "Finished waiting.";
        end if;
      when Reading =>
        streampkt_advance(0) <= '0';
        report "Read word (0) = " & dlong_to_string(streampkt_buffer_data(0));
        if ( streampkt_data_available(0) = '0' ) then
          read_state <= Done;
        end if;
      when Done =>
        if ( done_b(0) = '1' ) then
          report "Advancing to next frame.";
          streampkt_advance(0) <= '1';
          read_state <= Waiting;
        else
          streampkt_advance(0) <= '0';
        end if;
      end case;
    end if;
  end process;

  streampkt_buffer_rden(0) <= streampkt_data_available(0);

  g_buf : for i in 0 to 1 generate
    buffer_imp : xaui_stream_buffer
    generic map (
      index => i
    )
    port map (
      rst => xaui_reset,
      clk_a => clka,
      wen_a => xgbe_stream_wren(i),
      din_a => xgbe_stream_data(i),
      strobe_a => xgbe_stream_strobe(i),
      clk_b => xgmii_clk,
      dv_b => streampkt_data_available(i),
      dout_b => streampkt_buffer_data(i),
      rden_b => streampkt_buffer_rden(i),
      done_b => done_b(i),
      cksum => streampkt_buffer_cksum(i),
      length => streampkt_buffer_length(i),
      advance => streampkt_advance(i),
      free => streampkt_buffer_free(i),
      lost => streampkt_lost_packets(i)
    );

  end generate;

end Behavioral;
