----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/21/2016 09:29:02 AM
-- Design Name: 
-- Module Name: ilas - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity ilas is
  port (
    clk : in std_logic;
    data_in : in std_logic_vector(31 downto 0);
    charisk_in : in std_logic_vector(3 downto 0);
    sync : in std_logic;
    scram_en : in std_logic;
    busy : out std_logic;
    rxcommaalign : out std_logic;
    hold : in std_logic;
    cgs : out std_logic;
    align : out std_logic;
    lane_align : out std_logic_vector(1 downto 0);
    lane_offset : out std_logic_vector(5 downto 0);
    data_out : out std_logic_vector(31 downto 0);
    charisk_out : out std_logic_vector(3 downto 0);
    user_data : out std_logic
  );
end ilas;

architecture Behavioral of ilas is

  function descramble(
    din : std_logic_vector(15 downto 0);
    scram : std_logic_vector(15 downto 0)
  ) return std_logic_vector is
    variable dout : std_logic_vector(15 downto 0);
  begin
    dout(0) := din(0) xor din(14) xor din(15);
    dout(1) := din(1) xor scram(0) xor din(15);
    dout(2) := din(2) xor scram(1) xor scram(0);
    dout(3) := din(3) xor scram(2) xor scram(1);
    dout(4) := din(4) xor scram(3) xor scram(2);
    dout(5) := din(5) xor scram(4) xor scram(3);
    dout(6) := din(6) xor scram(5) xor scram(4);
    dout(7) := din(7) xor scram(6) xor scram(5);
    dout(8) := din(8) xor scram(7) xor scram(6);
    dout(9) := din(9) xor scram(8) xor scram(7);
    dout(10) := din(10) xor scram(9) xor scram(8);
    dout(11) := din(11) xor scram(10) xor scram(9);
    dout(12) := din(12) xor scram(11) xor scram(10);
    dout(13) := din(13) xor scram(12) xor scram(11);
    dout(14) := din(14) xor scram(13) xor scram(12);
    dout(15) := din(15) xor scram(14) xor scram(13);
    return dout;
  end;

  function remap(
    din : std_logic_vector(31 downto 0)
  ) return std_logic_vector is
    variable dout : std_logic_vector(31 downto 0);
  begin
    dout(7 downto 0) := din(15 downto 8);
    dout(15 downto 8) := din(7 downto 0);
    dout(23 downto 16) := din(31 downto 24);
    dout(31 downto 24) := din(23 downto 16);
    return dout;
  end;

  function nbits( n : integer ) return natural is
    variable i : natural;
  begin
    i := 0;
    while ( 2**i < n ) loop
      i := i + 1;
    end loop;
    return i;
  end function;

  component lfsr_n
  generic (
    width : integer := 4
  );
  port (
    rst : in std_logic;
    clk : in std_logic;
    en : in std_logic;
    dout : out std_logic_vector(width-1 downto 0);
    prev : out std_logic_vector(width-1 downto 0)
  );
  end component;

  signal data_pipe : std_logic_vector(63 downto 0);
  signal charisk_pipe : std_logic_vector(7 downto 0);
  type state_t is ( Idle, AlignChar, AlignLane, Waiting, Done );
  signal state : state_t := Idle;
  signal byte_align : std_logic_vector(1 downto 0) := "00";
  signal word_offset : unsigned(5 downto 0);

  constant elastic_buffer_size : integer := 32;
  type elastic_buffer_t is array(elastic_buffer_size-1 downto 0) of std_logic_vector(35 downto 0);
  signal elastic_buffer : elastic_buffer_t;
  attribute syn_ramstyle : string;
  attribute syn_ramstyle of elastic_buffer : signal is "no_rw_check";

  signal read_address : std_logic_vector(nbits(elastic_buffer_size)-1 downto 0);
  signal write_address : std_logic_vector(nbits(elastic_buffer_size)-1 downto 0);
  signal aligned : std_logic := '0';
  signal scram : std_logic_vector(15 downto 0) := x"0000";
  signal lane_data : std_logic_vector(31 downto 0);
  signal lane_charisk : std_logic_vector(3 downto 0);
  signal rev_out : std_logic_vector(31 downto 0);
  signal buffer_data : std_logic_vector(31 downto 0);
  signal buffer_charisk : std_logic_vector(3 downto 0);
  signal enable_descrambler : std_logic;
  signal ilas_mf_counter : unsigned(2 downto 0) := "100";
  signal user_data_pipe : std_logic_vector(63 downto 0);
  signal lfsr_rst : std_logic := '1';
  signal wa_en : std_logic;
  signal ra_en : std_logic;
  signal selected_user_data : std_logic;
  signal elastic_buffer_read : std_logic_vector(35 downto 0);

begin

  waddr_imp : lfsr_n
  generic map (
    width => nbits(elastic_buffer_size)
  )
  port map (
    rst => lfsr_rst,
    clk => clk,
    en => wa_en,
    dout => write_address,
    prev => open
  );

  raddr_imp : lfsr_n
  generic map (
    width => nbits(elastic_buffer_size)
  )
  port map (
    rst => lfsr_rst,
    clk => clk,
    en => ra_en,
    dout => read_address,
    prev => open
  );

  process ( clk ) begin
    if ( clk'event and clk = '1' ) then
      case state is
        when Idle =>
          if ( sync = '1' ) then
            busy <= '1';
            byte_align <= ( others => '0' );
            word_offset <= ( others => '0' );
            cgs <= '0';
            ilas_mf_counter <= "000";
            rxcommaalign <= '1';
            aligned <= '0';
            state <= AlignChar;
          else
            rxcommaalign <= '0';
            busy <= '0';
          end if;
        when AlignChar =>
          busy <= '1';
          if ( charisk_in = "1111" and data_in = x"bcbcbcbc" ) then
            cgs <= '1';
            rxcommaalign <= '0';
            state <= AlignLane;
          else
            cgs <= '0';
            rxcommaalign <= '1';
            state <= AlignChar;
          end if;
        when AlignLane =>
          busy <= '1';
          rxcommaalign <= '0';
          cgs <= '1';
--
--  We sometimes seem to get words that look like 1cbc1cbc where it is the
--  last /R/ character that signals the start of the frame.
--
          if ( charisk_in(3) = '1' and data_in(31 downto 24) = x"1c" ) then
            byte_align <= "11";
            aligned <= '1';
            state <= Waiting;
          elsif ( charisk_in(2) = '1' and data_in(23 downto 16) = x"1c" ) then
            byte_align <= "10";
            aligned <= '1';
            state <= Waiting;
          elsif ( charisk_in(1) = '1' and data_in(15 downto 8) = x"1c" ) then
            byte_align <= "01";
            aligned <= '1';
            state <= Waiting;
          elsif ( charisk_in(0) = '1' and data_in(7 downto 0) = x"1c" ) then
            byte_align <= "00";
            aligned <= '1';
            state <= Waiting;
          end if;
        when Waiting =>
          busy <= '1';
          rxcommaalign <= '0';
          cgs <= '1';
          word_offset <= word_offset + 1;
          if ( lane_data(31 downto 24) = x"7c" and lane_charisk(3) = '1' ) then
            ilas_mf_counter <= ilas_mf_counter + 1;
          end if;
          if ( hold = '0' ) then
            state <= Done;
          end if;
        when Done =>
          rxcommaalign <= '0';
          cgs <= '1';
          busy <= '1';
          if ( lane_data(31 downto 24) = x"7c" and lane_charisk(3) = '1' ) then
            ilas_mf_counter <= ilas_mf_counter + 1;
          end if;
          if ( sync = '0' and ilas_mf_counter = "100" ) then
            state <= Idle;
          end if;
      end case;

      data_pipe <= data_in & data_pipe(63 downto 32);
      charisk_pipe <= charisk_in & charisk_pipe(7 downto 4);
      user_data_pipe <= user_data_pipe(62 downto 0) & ilas_mf_counter(2);

    end if;
  end process;

  process ( clk )
    variable rev_in : std_logic_vector(31 downto 0);
  begin
    if ( clk'event and clk = '1' ) then
      if ( aligned = '1' ) then
        rev_in := remap(lane_data);
        rev_out <= descramble(rev_in(31 downto 16),
                              rev_in(15 downto 0)) &
                   descramble(rev_in(15 downto 0),scram);
        scram <= rev_in(31 downto 16);
      end if;
      user_data <= selected_user_data;
    end if;
  end process;

--
--  Infer block RAM
--
  process ( clk ) begin
    if ( clk'event and clk = '1' ) then
      if ( aligned = '1' ) then
        elastic_buffer(to_integer(unsigned(write_address))) <= buffer_charisk & buffer_data;
      end if;
      elastic_buffer_read <= elastic_buffer(to_integer(unsigned(read_address)));
    end if;
  end process;

  buffer_data <= remap(rev_out) when enable_descrambler = '1' else lane_data;
  buffer_charisk <= lane_charisk;
  data_out <= elastic_buffer_read(31 downto 0);
  charisk_out <= elastic_buffer_read(35 downto 32);

  process ( clk ) begin
    if ( clk'event and clk = '1' ) then
      if ( state = AlignLane ) then
        lfsr_rst <= '1';
        ra_en <= '0';
        wa_en <= '0';
      elsif ( state = Waiting ) then
        lfsr_rst <= '0';
        ra_en <= '0';
        wa_en <= '1';
      else
        lfsr_rst <= '0';
        ra_en <= '1';
        wa_en <= '1';
      end if;
    end if;
  end process;

  lane_charisk <= charisk_pipe(to_integer(unsigned(byte_align))+3 downto
                               to_integer(unsigned(byte_align)));
  lane_data <= data_pipe(to_integer(unsigned(byte_align))*8+31 downto
                         to_integer(unsigned(byte_align))*8);

  lane_align <= byte_align;
  lane_offset <= std_logic_vector(word_offset);
  align <= aligned;
  enable_descrambler <= scram_en when ilas_mf_counter = "100" else '0';
  selected_user_data <= user_data_pipe(to_integer(word_offset));

end Behavioral;
