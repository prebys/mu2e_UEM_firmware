--------------------------------------------------------------------------------
--
-- Company:
-- Engineer:       Matthew Jones - Purdue University
-- 
-- Create Date:    04:44:19 07/30/2014 
-- Design Name:    stib
-- Module Name:    fei4_readout - RTL
-- Project Name:   STIB firmware for FEI4B readout
-- Target Devices: xc5vlx50
-- Tool versions:  ISE 14.4 / 14.6
-- Description:    Deserializes data from FE-I4B
--
-- Dependencies:
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library hep337dev;
use hep337dev.fei4.all;

library UNISIM;
use UNISIM.VComponents.all;

entity fei4_readout is
  generic (
    nsensor : integer := 2
  );
  port (
    clk : in std_logic;
    din : in std_logic_vector(2*nsensor-1 downto 0);
    serdes_input : out std_logic_vector(2*nsensor-1 downto 0);
    sync : out std_logic_vector(2*nsensor-1 downto 0);
    bypass : in std_logic;
    reset : in std_logic;
    do_rdreg : in std_logic_vector(2*nsensor-1 downto 0);
    do_match : in std_logic_vector(2*nsensor-1 downto 0);
    do_clear : in std_logic_vector(2*nsensor-1 downto 0);
    do_capture : in std_logic_vector(2*nsensor-1 downto 0);
    lv1 : in std_logic;
    bco_counter : in std_logic_vector(47 downto 0);
    trigger_counter : in std_logic_vector(31 downto 0);
    capture_busy : out std_logic_vector(2*nsensor-1 downto 0);
    chan_busy : out std_logic_vector(2*nsensor-1 downto 0);
    spy_select : in std_logic_vector(3 downto 0);
    spy_dout : out std_logic_vector(9 downto 0);
    spy_dv : out std_logic;
    stream_reset : in std_logic;
    stream_clk : in std_logic;
    stream_data : out fei4_data_array_t;
    stream_data_valid : out std_logic_vector(2*nsensor-1 downto 0);
    stream_fifo_read : in std_logic_vector(2*nsensor-1 downto 0);
    stream_event_ready : out std_logic_vector(2*nsensor-1 downto 0);
    do_idelay : in std_logic;
    idelay_busy : out std_logic;
    idelay_inc : in std_logic;
    idelay_rst : in std_logic;
    idelay_tap : out std_logic_vector(5 downto 0);
    idelay_select : in std_logic_vector(3 downto 0);
    address : in std_logic_vector(9 downto 0);
    address_strobe : in std_logic;
    data : out std_logic_vector(31 downto 0);
    busclk : in std_logic;
    write_strobe : in std_logic;
    bus_data : in std_logic_vector(31 downto 0);
    test_out : out std_logic;
    debug : out std_logic_vector(7 downto 0)
  );
end fei4_readout;

architecture RTL of fei4_readout is

  component fei4rx  
  generic (
    channel : integer := 0;
    iobdelay_value : integer := 0
  );
  port (
    reset : in std_logic;
    clk : in std_logic;
    din : in std_logic;
    serdes_input : out std_logic;
    sync : out std_logic;
    dout : out std_logic_vector(9 downto 0);
    bypass : in std_logic;
    dv : out std_logic;
    do_rdreg : in std_logic;
    do_match : in std_logic;
    do_clear : in std_logic;
    do_capture : in std_logic;
    lv1 : in std_logic;
    stream_data : out std_logic_vector(31 downto 0);
    stream_dv : out std_logic;
    stream_eof : out std_logic;
    capture_busy : out std_logic;
    chan_busy : out std_logic;
    do_idelay : in std_logic;
    idelay_busy : out std_logic;
    idelay_rst : in std_logic;
    idelay_inc : in std_logic;
    idelay_tap : out std_logic_vector(5 downto 0);
    address : in std_logic_vector(5 downto 0);
    busclk : in std_logic;
    write_strobe : in std_logic;
    bus_data : in std_logic_vector(31 downto 0);
    data : out std_logic_vector(31 downto 0)
  );
  end component;

  component fei4_pixel_fifo
  port (
    empty : out std_logic;
    dout : out std_logic_vector(31 downto 0);
    rd_en : in std_logic;
    full : out std_logic;
    din : in std_logic_vector(31 downto 0);
    wr_en : in std_logic;
    rst : in std_logic;
    wr_clk : in std_logic;
    rd_clk : in std_logic;
    valid : out std_logic
  );
  end component;

  signal pf_full : std_logic_vector(2*nsensor-1 downto 0);
  signal pf_empty : std_logic_vector(2*nsensor-1 downto 0);
  signal pf_valid : std_logic_vector(2*nsensor-1 downto 0);
  signal pixel_fifo_read : std_logic_vector(2*nsensor-1 downto 0);

  type tap_array_t is array(15 downto 0) of std_logic_vector(5 downto 0);
  signal tap_array : tap_array_t;
  signal sel : std_logic_vector(15 downto 0) := ( 0 => '1', others => '0' );
  signal busy : std_logic := '0';
  signal idelay_sel : std_logic_vector(2*nsensor-1 downto 0) := ( others => '0' );
  signal busy_idelay : std_logic_vector(2*nsensor-1 downto 0);
  signal fei4_din : std_logic_vector(2*nsensor-1 downto 0);
  signal fei4_sync : std_logic_vector(2*nsensor-1 downto 0);
  type fei4_dout_t is array(2*nsensor-1 downto 0) of std_logic_vector(9 downto 0);
  signal fei4_dout : fei4_dout_t;
  signal fei4_dv : std_logic_vector(2*nsensor-1 downto 0);
  signal dout_sel : std_logic_vector(9 downto 0);
  signal dv_sel : std_logic;
  type iobdelay_array_t is array(0 to 15) of integer;
  constant iobdelay : iobdelay_array_t := ( 0, 0, 0, 0,
                                            0, 0, 0, 0,
                                            0, 0, 0, 0,
                                            0, 0, 0, 0 );

  signal channel_data : fei4_data_array_t(2*nsensor-1 downto 0);
  signal pixel_data : fei4_data_array_t(2*nsensor-1 downto 0);
  signal pixel_fifo_output : fei4_data_array_t(2*nsensor-1 downto 0);

  signal pixel_dv : std_logic_vector(2*nsensor-1 downto 0);
  signal capturing : std_logic_vector(2*nsensor-1 downto 0);
  signal readout_write_strobe : std_logic_vector(2*nsensor-1 downto 0);
  signal pixel_eof : std_logic_vector(2*nsensor-1 downto 0);

  signal trigger_data : std_logic_vector(63 downto 0);
  signal trigger_dv : std_logic;
  signal trigger_fifo_read : std_logic;
  signal trigger_fifo_output : std_logic_vector(31 downto 0);
  signal tf_full : std_logic;
  signal tf_empty : std_logic;
  signal tf_valid : std_logic;

  type bcid_state_t is ( Expired, Valid, Send_high, Send_low );
  signal bcid_state : bcid_state_t := Expired;
  signal bcid_output_word_low : std_logic_vector(31 downto 0);
  signal bcid_output_word_high : std_logic_vector(31 downto 0);

  signal expire_counter : unsigned(11 downto 0) := ( others => '0' );
  signal expire_count : unsigned(11 downto 0) := x"400";

begin

  g1: for i in 0 to 2*nsensor-1 generate
    fei4rx_imp : fei4rx
    generic map (
      channel => i,
      iobdelay_value => iobdelay(i)
    )
    port map (
      reset => reset,
      clk => clk,
      din => din(i),
      serdes_input => fei4_din(i),
      sync => fei4_sync(i),
      dout => fei4_dout(i),
      bypass => bypass,
      dv => fei4_dv(i),
      do_rdreg => do_rdreg(i),
      do_match => do_match(i),
      do_clear => do_clear(i),
      do_capture => do_capture(i),
      lv1 => lv1,
      stream_data => pixel_data(i),
      stream_dv => pixel_dv(i),
      stream_eof => open,
      capture_busy => capturing(i),
      chan_busy => chan_busy(i),
      do_idelay => idelay_sel(i),
      idelay_busy => busy_idelay(i),
      idelay_rst => idelay_rst,
      idelay_inc => idelay_inc,
      idelay_tap => tap_array(i),
      address => address(5 downto 0),
      busclk => busclk,
      bus_data => bus_data,
      write_strobe => readout_write_strobe(i),
      data => channel_data(i)
    );

    pf_imp : fei4_pixel_fifo
    port map (
      empty => pf_empty(i),
      dout => pixel_fifo_output(i),
      rd_en => pixel_fifo_read(i),
      full => pf_full(i),
      din => pixel_data(i),
      wr_en => pixel_dv(i),
      wr_clk => clk,
      rd_clk => stream_clk,
      rst => stream_reset,
      valid => pf_valid(i)
    );

    pixel_eof(i) <= '0' when pixel_dv(i) = '0' else
                    '1' when pixel_data(i)(31) = '1' else '0';

  end generate;

  process ( clk ) begin
    if ( clk'event and clk = '1' ) then
      if ( bcid_state = Valid ) then
        if ( expire_counter = expire_count ) then
          if ( tf_valid = '0' ) then
            bcid_state <= Expired;
          end if; 
        else
          expire_counter <= expire_counter + 1;
        end if; 
      end if;
      if ( bcid_state = Expired ) then
        expire_counter <= ( others => '0' );
        if ( tf_valid = '1' or pf_valid(0) = '1' or pf_valid(1) = '1' ) then
          bcid_output_word_low <= "10100000" & bco_counter(23 downto 0);   
          bcid_output_word_high <= "10100001" & bco_counter(47 downto 24);
          bcid_state <= Send_low;
        end if;
      end if;
      if ( bcid_state = Send_low ) then
        bcid_state <= Send_high;
      end if;
      if ( bcid_state = Send_high ) then
        bcid_state <= Valid;
      end if;
    end if;
  end process;

  process ( write_strobe, address )
    variable strobe : std_logic_vector(2*nsensor-1 downto 0);
  begin
    strobe := ( others => '0' );
    for i in 0 to 2*nsensor-1 loop
      if ( to_integer(unsigned(address(9 downto 6))) = i ) then
        strobe(i) := write_strobe;
      end if;
    end loop;
    readout_write_strobe <= strobe;
  end process;

  trigger_fifo_read <= '1' when bcid_state = Valid and tf_valid = '1' else '0';

  stream_data <= pixel_fifo_output;

  g2: for i in 0 to 2*nsensor-1 generate
    stream_data_valid(i) <= pf_valid(i);
    pixel_fifo_read(i) <= stream_fifo_read(i);
    stream_event_ready(i) <= pixel_eof(i);
  end generate;

  process ( busy_idelay )
    variable b : std_logic;
  begin
    b := '0';
    for i in 0 to 2*nsensor-1 loop
      b := b or busy_idelay(i);
    end loop;
    busy <= b;
  end process;
  idelay_busy <= busy;

  capture_busy <= capturing;

  idelay_tap <= tap_array(0) when idelay_select = "0000" else
                tap_array(1) when idelay_select = "0001" else
                tap_array(2) when idelay_select = "0010" else
                tap_array(3) when idelay_select = "0011" else
                tap_array(4) when idelay_select = "0100" else
                tap_array(5) when idelay_select = "0101" else
                tap_array(6) when idelay_select = "0110" else
                tap_array(7) when idelay_select = "0111" else
                tap_array(8) when idelay_select = "1000" else
                tap_array(9) when idelay_select = "1001" else
                tap_array(10) when idelay_select = "1010" else
                tap_array(11) when idelay_select = "1011" else
                ( others => '0' );

  dout_sel <= fei4_dout(to_integer(unsigned(spy_select)));
  dv_sel <= fei4_dv(to_integer(unsigned(spy_select)));

  idelay_sel <= ( 0 => do_idelay, others => '0' ) when idelay_select = "0000" else
                ( 1 => do_idelay, others => '0' ) when idelay_select = "0001" else
                ( 2 => do_idelay, others => '0' ) when idelay_select = "0010" else
                ( 3 => do_idelay, others => '0' ) when idelay_select = "0011" else
                ( 4 => do_idelay, others => '0' ) when idelay_select = "0100" else
                ( 5 => do_idelay, others => '0' ) when idelay_select = "0101" else
                ( 6 => do_idelay, others => '0' ) when idelay_select = "0110" else
                ( 7 => do_idelay, others => '0' ) when idelay_select = "0111" else
                ( 8 => do_idelay, others => '0' ) when idelay_select = "1000" else
                ( 9 => do_idelay, others => '0' ) when idelay_select = "1001" else
                ( 10 => do_idelay, others => '0' ) when idelay_select = "1010" else
                ( 11 => do_idelay, others => '0' ) when idelay_select = "1011" else
                ( others => '0' );
  data <= channel_data(0) when address_strobe = '1' and address(9 downto 6) = "0000" else
          channel_data(1) when address_strobe = '1' and address(9 downto 6) = "0001" else
          channel_data(2) when address_strobe = '1' and address(9 downto 6) = "0010" else
          channel_data(3) when address_strobe = '1' and address(9 downto 6) = "0011" else
          channel_data(4) when address_strobe = '1' and address(9 downto 6) = "0100" else
          channel_data(5) when address_strobe = '1' and address(9 downto 6) = "0101" else
          channel_data(6) when address_strobe = '1' and address(9 downto 6) = "0110" else
          channel_data(7) when address_strobe = '1' and address(9 downto 6) = "0111" else
          channel_data(8) when address_strobe = '1' and address(9 downto 6) = "1000" else
          channel_data(9) when address_strobe = '1' and address(9 downto 6) = "1001" else
          channel_data(10) when address_strobe = '1' and address(9 downto 6) = "1010" else
          channel_data(11) when address_strobe = '1' and address(9 downto 6) = "1011" else
          ( others => '0' );
  spy_dout <= dout_sel;
  spy_dv <= dv_sel;

  debug <= "00" & tf_valid & trigger_fifo_read & pixel_fifo_read(1) & pixel_dv(1) & pixel_fifo_read(0) & pixel_dv(0);

  test_out <= fei4_din(1);

  serdes_input <= fei4_din;
  sync <= fei4_sync;

end RTL;
