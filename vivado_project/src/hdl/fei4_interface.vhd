--------------------------------------------------------------------------------
--
-- Company:
-- Engineer:       Matthew Jones - Purdue University
-- 
-- Create Date:    08:44:16 06/06/2013 
-- Design Name:    fei4
-- Module Name:    fei4_interface - RTL
-- Project Name:   test beam
-- Target Devices: xc5vfx50
-- Tool versions:  ISE 14.4 / 14.6
-- Description:    Defines a MicroBlaze LMB slave that interfaces with the
--                 FE-I4b chip.
--
-- Dependencies:
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
--------------------------------------------------------------------------------
--
--  Description:
--
--  Base C8000000
--
--  Register FEI4_CSR 0000 control/status register
--    Bit 31 rw CLKRST reset clock synthesis DCM
--    Bit 30 r  DCMLCK lock status of clock synthesis DCM
--    Bit 29 rw BCOCLR bunch counter enable (w), serdes input chan 0 (r)
--    Bit 28 rw BCOEN  bunch counter clear (w), serdes input chan 1 (r)
--    Bit 27 rw STRESET reset stream interface
--    Bit 26 rw STREAM enable streaming data
--    Bit 25 rw FLUSH flush stream data
--    Bit 24..16 -- -- unused
--    Bit 15 rw DEBUG enable debug output
--    Bit 14..9 -- -- unused
--    Bit 8    rw TRIGSEL selects between system (0) and pulser (1) triggers.
--    Bit 7..5 rw PKTSIZE stream packet size
--    Bit 4..0  r NCHAN number of channels synthesized in design
--
--  Register FEI4_PULSER 0004 pulser control register
--    Bit 31    rw STROBE generate CAL/LV1 sequence/pulser busy
--    Bit 30    rw REPEAT repeat CAL/LV1 sequence
--    Bit 29..24 -- -- unused
--    Bit 23..16 rw DELAY delay between CAL and LV1 pulses
--    Bit 15..8 rw COUNT number of CAL/LV1 cycles to generate
--    Bit 7..0 rw FREQ frequency at which CAL/LV1 sequence is generated
--
--  Register FEI4_IDELAY 0014 IDELAY control register
--    Bit 31 rw STROBE perform IDELAY tap increment/decrement
--    Bit 30 rw TAPRST reset IDELAY tap count
--    Bit 29 rw CLRERR clear error count
--    Bit 28 rw TAPINC increment (decrement) IDELAY tap count when set (clear)
--    Bit 27..22 -- -- unused
--    Bit 21..16 r TAPCNT IDELAY tap count
--    Bit 15..4 r ERRCNT Error count
--    Bit 3..0 rw SELECT channel select
--
--  Register FEI4_SPY_FIFO_CSR 0024 spy FIFO control/status register
--    Bit 3..0 rw SELECT channel select
--    Bit   4 rw BYPASS bypass 10b8b decoder
--    Bit 28  r  VALID FIFO empty
--    Bit 29  r  VALID FIFO full
--    Bit 30  r  VALID FIFO valid
--    Bit 31  rw RESET reset FIFO
--
--  Register FEI4_STREAMER 004c stream status register
--    Bit 31..24 r STATE internal state
--    Bit 23 r STUFFED set whenever FIFO's overflow
--    Bit 22 r ALMOSTFULL FIFO almost full status
--    Bit 21 r FULL FIFO full status
--    Bit 20 r EMPTY FIFO empty  status
--    Bit 19 r STROBE packet strobe
--    Bit 18 r READY stream ready
--    Bit 17 r PKTFULL packet FIFO full flag
--    Bit 16 r PKTEMPTY packet FIFO empty flag
--    Bit 15..8 r IDLE idle count
--    Bit 7..0 r COUNT word count
--
--  Register FEI4_CHANNEL_y_CSR 1y00 channel y decoder control/status register
--    Bit 31  rw RDREG      parse RdRegister response/busy status
--    Bit 30  rw MATCH      clears match counters - self clearing
--    Bit 29  rw CLEAR      clear decoder counters - self clearing
--    Bit 28  rw CAPTURE    enable bitstream capture until error detected
--
--  Register FEI4_DECODER_y_RDREG 1y10 channel y RdRegister response buffer
--    Bit 31      w   RESET  sets read bits 31-29
--    Bit 31      r   GOTSOF cleared when SOF marker received
--    Bit 30      r   GOTEOF cleared when EOF marker received
--    Bit 29      r   GOTAR  cleared when address record marker received
--    Bit 28      r   GOTDR  cleared when value record marker received
--    Bit 27..16  r   ADDR   address record
--    Bit 15..0   r   VALUE  value record
--
--  Register FEI4_DECODER_y_CAPTURE0 1y30 channel y capture buffer (low 32 bits)
--    Bit 31..0   r   CAPTURE_0 capture buffer bits 31..0
--
--  Register FEI4_DECODER_y_CAPTURE1 1y34 channel y capture buffer (next 32 bits)
--    Bit 31..0   r   CAPTURE_1 capture buffer bits 63..32
--
--  Register FEI4_DECODER_y_STATE 1y40 channel y decoder state
--    Bit 31       rw  CNTRST  counters reset
--    Bit 30..28   r   STATE   decoder state
--    Bit 27..24   r   SYNC    bit alignment count
--    Bit 23..20   --  --      unused
--    Bit 19..0    r   SAMPLE  latched encoded data
--
--  Register FEI4_DECODER_y_EACNT 1y44 channel y alignment error count
--    Bit 31..0   r   EACNT alignment error count
--
--  Register FEI4_DECODER_y_EDCNT 1y48 channel y decoder error count
--    Bit 31..0   r   EDCNT decoder error count
--
--  Register FEI4_DECODER_y_SFCNT 1y4c channel y SOF count
--    Bit 31..0   r   SFCNT start-of-frame marker count
--
--  Register FEI4_DECODER_y_EFCNT 1y50 channel y EOF count
--    Bit 31..0  r   EFCNT end-of-frame marker count
--
--  Register FEI4_DECODER_y_BFCNT 1y54 channel y bad frame count
--    Bit 31..0  r   BFCNT bad frame count
--
--  Register FEI4_DECODER_y_SREC 1y80-1yfc Service record counters
--    Bit 15..0   r    service record i
--    Bit 31..16  r    service record i+1
--
--  Register FEI4_LV1COUNT_y 1yc0 Level 1 trigger counter
--    Bit 31..0   r    number of Lv1 triggers requested
--
--  Register FEI4_MATCH_y_COUNT_1 1yc4 Matched pixel count 1
--    Bit 31..16  rw   pixel pattern 1 to match
--    Bit 15..0   r    count of matching pixels in readout
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library hep337dev;
use hep337dev.iobus.all;
use hep337dev.fei4.all;

library unisim;
use unisim.vcomponents.all;

entity fei4_interface is
  generic ( nsensor : integer := 2 );
  port (
    busclk : in std_logic;
    iobus : in iobus_t;
    write_data : out std_logic_vector(31 downto 0);
    iobus_ready : out std_logic;
    clkx : in std_logic;
    clk80mhz : in std_logic;
    clk160mhz : in std_logic;
    fei4_clk : in std_logic;
    fei4_cmd : out std_logic_vector(nsensor-1 downto 0);
    fei4_dob : in std_logic_vector(2*nsensor-1 downto 0);
    fei4_lv1 : in std_logic;
    bco : in std_logic_vector(47 downto 0);
    gbe_stream_clk : in std_logic;
    gbe_stream_wren : out std_logic;
    gbe_stream_strobe : out std_logic;
    gbe_stream_dout : out std_logic_vector(31 downto 0);
    gbe_stream_free : in std_logic_vector(15 downto 0);
    test_in : in std_logic;
    test_out : out std_logic;
    debug : out std_logic_vector(7 downto 0)
  );
end fei4_interface;

architecture Behavioral of fei4_interface is

  component fei4tx
  port (
    reset : in std_logic;
    strobe : in  std_logic;
    wfe : in std_logic;
    cal : in std_logic;
    trig : in std_logic;
    ecr : in std_logic;
    bcr : in std_logic;
    bco_zero : in std_logic;
    bco_zero_offset : in std_logic_vector(12 downto 0);
    sync_bco_zero : in std_logic;
    ext_cal : in std_logic;
    ext_lv1 : in std_logic;
    disable : in std_logic;
    busy : out std_logic;
--    status : out std_logic_vector(7 downto 0);
    data : in  std_logic_vector (31 downto 0);
    front_end : in std_logic_vector(671 downto 0);
    outclk : in  std_logic;
    dout : out  std_logic
  );
  end component;

  component fei4_pulser
  port (
    reset : in std_logic;
    strobe : in std_logic;
    continuous : in std_logic;
    busy : out std_logic;
    internal_state : out std_logic_vector(2 downto 0);
    outclk : in std_logic;
    cal : out std_logic;
    lv1 : out std_logic;
    count : in std_logic_vector(7 downto 0);
    delay : in std_logic_vector(7 downto 0);
    freq : in std_logic_vector(7 downto 0);
    bco : in std_logic_vector(47 downto 0)
  );
  end component;

  component fei4_readout
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
      spy_select : in std_logic_vector(3 downto 0);
      spy_dout : out std_logic_vector(9 downto 0);
      spy_dv : out std_logic;
      stream_reset : in std_logic;
      stream_clk : in std_logic;
      stream_data : out fei4_data_array_t;
--      stream_data0 : out std_logic_vector(31 downto 0);
--      stream_data1 : out std_logic_vector(31 downto 0);
      stream_data_valid : out std_logic_vector(2*nsensor-1 downto 0);
      stream_fifo_read : in std_logic_vector(2*nsensor-1 downto 0);
      stream_event_ready : out std_logic_vector(2*nsensor-1 downto 0);
      do_rdreg : in std_logic_vector(2*nsensor-1 downto 0);
      do_match : in std_logic_vector(2*nsensor-1 downto 0);
      do_clear : in std_logic_vector(2*nsensor-1 downto 0);
      do_capture : in std_logic_vector(2*nsensor-1 downto 0);
      bco_counter : in std_logic_vector(47 downto 0);
      trigger_counter : in std_logic_vector(31 downto 0);
      lv1 : in std_logic;
--      trig : in std_logic;
--      trigclk : in std_logic;
      capture_busy : out std_logic_vector(2*nsensor-1 downto 0);
      chan_busy : out std_logic_vector(2*nsensor-1 downto 0);
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
  end component;

  component fei4_spy_fifo
    port (
      empty : out std_logic;
      dout : out std_logic_vector(35 downto 0);
      rd_en : in std_logic;
      full : out std_logic;
      din : in std_logic_vector(35 downto 0);
      wr_en : in std_logic;
      rd_clk : in std_logic;
      rst : in std_logic;
      valid : out std_logic;
      wr_clk : in std_logic
    );
  end component;

  component fei4_fifo
    port (
      rst : in std_logic;
      wr_clk : in std_logic;
      rd_clk : in std_logic;
      din : in std_logic_vector(35 downto 0);
      wr_en : in std_logic;
      rd_en : in std_logic;
      dout : out std_logic_vector(35 downto 0);
      empty : out std_logic;
      full : out std_logic;
      valid : out std_logic
    );
  end component;

  component fei4_event_builder
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
--    pixels_eof : in std_logic_vector(1 downto 0);
    pixels_eof : in std_logic_vector(2*nsensor-1 downto 0);
--    pixels_in0 : in std_logic_vector(31 downto 0);
--    pixels_in1 : in std_logic_vector(31 downto 0);
    pixels_in : in fei4_data_array_t;
--    pixels_dv : in std_logic_vector(1 downto 0);
    pixels_dv : in std_logic_vector(2*nsensor-1 downto 0);
--    pixels_read : out std_logic_vector(1 downto 0)
    pixels_read : out std_logic_vector(2*nsensor-1 downto 0)
  );
  end component;

  component fei4_bcocounter
  port (
    bcoclk : in std_logic;
    reset : in std_logic;
    bco_enable : in std_logic;
    bco_clear : in std_logic;
    bco : out std_logic_vector(47 downto 0)
  );
  end component;

  constant base_address : std_logic_vector(15 downto 0) := x"c800";
  constant address_mask : std_logic_vector(15 downto 0) := x"ffff";
  signal masked_address : std_logic_vector(15 downto 0);

  constant address_fei4_csr : std_logic_vector(15 downto 0) := x"0000";
  constant address_fei4_pulser_csr : std_logic_vector(15 downto 0) := x"0004";
  constant address_fei4_sync : std_logic_vector(15 downto 0) := x"0010";
  constant address_fei4_idelay : std_logic_vector(15 downto 0) := x"0014";
  constant address_fei4_cmdcount : std_logic_vector(15 downto 0) := x"0018";

  constant address_fei4_spy_fifo_csr : std_logic_vector(15 downto 0) := x"0024";
  constant address_fei4_spy_fifo_data : std_logic_vector(15 downto 0) := x"0028";
  constant address_fei4_bco_counter_low : std_logic_vector(15 downto 0) := x"0040";
  constant address_fei4_bco_counter_high : std_logic_vector(15 downto 0) := x"0044";
  constant address_fei4_streamer : std_logic_vector(15 downto 0) := x"004c";
  constant address_fei4_front_end_0 : std_logic_vector(15 downto 0) := x"00a0";
  constant address_fei4_front_end_1 : std_logic_vector(15 downto 0) := x"00a4";
  constant address_fei4_front_end_2 : std_logic_vector(15 downto 0) := x"00a8";
  constant address_fei4_front_end_3 : std_logic_vector(15 downto 0) := x"00ac";
  constant address_fei4_front_end_4 : std_logic_vector(15 downto 0) := x"00b0";
  constant address_fei4_front_end_5 : std_logic_vector(15 downto 0) := x"00b4";
  constant address_fei4_front_end_6 : std_logic_vector(15 downto 0) := x"00b8";
  constant address_fei4_front_end_7 : std_logic_vector(15 downto 0) := x"00bc";
  constant address_fei4_front_end_8 : std_logic_vector(15 downto 0) := x"00c0";
  constant address_fei4_front_end_9 : std_logic_vector(15 downto 0) := x"00c4";
  constant address_fei4_front_end_10 : std_logic_vector(15 downto 0) := x"00c8";
  constant address_fei4_front_end_11 : std_logic_vector(15 downto 0) := x"00cc";
  constant address_fei4_front_end_12 : std_logic_vector(15 downto 0) := x"00d0";
  constant address_fei4_front_end_13 : std_logic_vector(15 downto 0) := x"00d4";
  constant address_fei4_front_end_14 : std_logic_vector(15 downto 0) := x"00d8";
  constant address_fei4_front_end_15 : std_logic_vector(15 downto 0) := x"00dc";
  constant address_fei4_front_end_16 : std_logic_vector(15 downto 0) := x"00e0";
  constant address_fei4_front_end_17 : std_logic_vector(15 downto 0) := x"00e4";
  constant address_fei4_front_end_18 : std_logic_vector(15 downto 0) := x"00e8";
  constant address_fei4_front_end_19 : std_logic_vector(15 downto 0) := x"00ec";
  constant address_fei4_front_end_20 : std_logic_vector(15 downto 0) := x"00f0";

  constant address_fei4_channel : std_logic_vector(15 downto 0) := x"1000";
  constant address_fei4_channel_csr : std_logic_vector(15 downto 0) := x"1000";
  constant address_fei4_cmd : std_logic_vector(15 downto 0) := x"1004";
  constant address_fei4_rdreg : std_logic_vector(15 downto 0) := x"1010";

  signal addressed : std_logic;
  signal bus_data : std_logic_vector(31 downto 0);
  signal ready : std_logic;

  signal fei4clk : std_logic;
  signal fei4_clk_locked : std_logic;
  signal fei4_bco_counter : std_logic_vector(47 downto 0);
  signal bco_zero : std_logic;
  signal txen : std_logic_vector(nsensor-1 downto 0) := ( others => '0' );
  signal trig : std_logic_vector(nsensor-1 downto 0) := ( others => '0' );
  signal cal : std_logic_vector(nsensor-1 downto 0) := ( others => '0' );
  signal ecr : std_logic_vector(nsensor-1 downto 0) := ( others => '0' );
  signal bcr : std_logic_vector(nsensor-1 downto 0) := ( others => '0' );
  signal bco_zero_offset : std_logic_vector(12 downto 0) := ( others => '0' );
  signal sync_bco_zero : std_logic := '0';
  signal txbusy : std_logic_vector(nsensor-1 downto 0);
  signal cmd_busy : std_logic;
  type cmd_t is array(nsensor-1 downto 0) of std_logic_vector(31 downto 0);
  signal fei4_command : cmd_t;
  signal ichan : integer range 0 to 15;
  signal fei4_csr : std_logic_vector(31 downto 0) := x"10000000";
  signal fei4_pulser_csr : std_logic_vector(31 downto 0);
  signal do_pulser : std_logic;
  signal pulser_busy : std_logic;
  signal pulser_cal : std_logic;
  signal pulser_lv1 : std_logic;
  signal system_lv1 : std_logic;
  signal select_lv1 : std_logic;
  signal pulser_state : std_logic_vector(2 downto 0);
  signal fei4_serdes : std_logic_vector(2*nsensor-1 downto 0);
  signal fei4_idelay : std_logic_vector(31 downto 0) := x"00000000";
  signal fei4_idelay_tap : std_logic_vector(5 downto 0);
  signal do_idelay : std_logic := '0';
  signal idelay_busy : std_logic;
  signal fei4_sync : std_logic_vector(2*nsensor-1 downto 0);
  signal fei4_debug : std_logic_vector(7 downto 0);
  signal spy_fifo_csr : std_logic_vector(31 downto 0);
  signal fei4_spy_dout : std_logic_vector(9 downto 0);
  signal fei4_spy_dv : std_logic;
  signal fei4_errcount : std_logic_vector(11 downto 0);
  signal spy_fifo_addressed : std_logic := '0';
  signal spy_fifo_empty : std_logic;
  signal spy_fifo_valid : std_logic;
  signal spy_fifo_full : std_logic;
  signal spy_fifo_output : std_logic_vector(35 downto 0);
  signal fifo_input : std_logic_vector(35 downto 0);
  signal do_rdreg : std_logic_vector(2*nsensor-1 downto 0) := ( others => '0' );
  signal do_match : std_logic_vector(2*nsensor-1 downto 0) := ( others => '0' );
  signal do_clear : std_logic_vector(2*nsensor-1 downto 0) := ( others => '0' );
  signal chan_busy : std_logic_vector(2*nsensor-1 downto 0);
  signal do_capture : std_logic_vector(2*nsensor-1 downto 0) := ( others => '0' );
  signal capture_busy : std_logic_vector(2*nsensor-1 downto 0) := ( others => '0' );
  signal fei4_rx_addr_strobe : std_logic;
  signal fei4_decoder_data : std_logic_vector(31 downto 0);
  signal front_end : std_logic_vector(671 downto 0);
  type channel_csr_t is array(2*nsensor-1 downto 0) of std_logic_vector(31 downto 0);
  signal channel_csr : channel_csr_t;
  signal extra_clock : std_logic := '0';
  signal fei4_cmd_out : std_logic_vector(nsensor-1 downto 0);
  type tx_status_t is array(nsensor-1 downto 0) of std_logic_vector(7 downto 0);
  signal tx_status : tx_status_t;

  signal readout_write_strobe : std_logic;

  signal evb_data_valid : std_logic_vector(2*nsensor-1 downto 0) := ( others => '0' );
  signal evb_eof : std_logic_vector(2*nsensor-1 downto 0);
  signal evb_fifo_read : std_logic_vector(2*nsensor-1 downto 0) := ( others => '0' );
  signal evb_data : fei4_data_array_t(2*nsensor-1 downto 0);
--  signal evb_data0 : std_logic_vector(31 downto 0);
--  signal evb_data1 : std_logic_vector(31 downto 0);
  signal stream_words_dumped : std_logic_vector(31 downto 0);
  signal packet_size : std_logic_vector(4 downto 0) := "00100"; 
  signal idle_count : std_logic_vector(1 downto 0) := "00";
  signal stream_reset : std_logic;
  signal stream_status : std_logic_vector(31 downto 0);

  signal ext_trig : std_logic;
  signal ext_halt : std_logic;
  signal ext_start : std_logic;
  signal cmd_counter : std_logic_vector(31 downto 0);
  signal trigger_counter : std_logic_vector(31 downto 0);

  signal reset_cmdcount : std_logic := '0';
  signal cmdcount_reset_done : std_logic;

  attribute mark_debug : string;
  attribute mark_debug of fei4_decoder_data : signal is "true";
  attribute mark_debug of fei4_rx_addr_strobe : signal is "true";
  attribute mark_debug of readout_write_strobe : signal is "true";

begin

  clksel_imp : bufgmux
  port map (
    i0 => clk80mhz,
    i1 => clk160mhz,
    o => fei4clk,
    s => fei4_csr(15)
  );

  fei4_bco_counter <= bco;

  fei4cmd : for i in 0 to nsensor-1 generate
    fei4tx_imp : fei4tx
    port map (
      reset => fei4_csr(31),
      strobe => txen(i),
      wfe => fei4_command(i)(30),
      cal => cal(i),
      trig => trig(i),
      bcr => bcr(i),
      ecr => ecr(i),
      bco_zero => bco_zero,
      bco_zero_offset => bco_zero_offset,
      sync_bco_zero => sync_bco_zero,
      ext_cal => pulser_cal,
      ext_lv1 => select_lv1,
      disable => '0',
      busy => txbusy(i),
--      status => tx_status(i),
      data => iobus.io_write_data,
      front_end => front_end,
      outclk => fei4_clk,
      dout => fei4_cmd_out(i)
    );
  end generate;

  fei4_readout_imp : fei4_readout
  generic map (
    nsensor => nsensor
  )
  port map (
    clk => fei4clk,
    din => fei4_dob,
    serdes_input => fei4_serdes,
    sync => fei4_sync,
    bypass => spy_fifo_csr(4),
    reset => fei4_idelay(30),
    do_rdreg => do_rdreg,
    do_match => do_match,
    do_clear => do_clear,
    do_capture => do_capture,
    lv1 => select_lv1,
--    trig => ext_trig,
--    trigclk => trigclk,
    bco_counter => fei4_bco_counter,
    trigger_counter => trigger_counter,
    capture_busy => capture_busy,
    chan_busy => chan_busy,
    spy_select => spy_fifo_csr(3 downto 0),
    spy_dout => fei4_spy_dout,
    spy_dv => fei4_spy_dv,
    stream_reset => fei4_csr(27),
    stream_clk => gbe_stream_clk,
    stream_data => evb_data,
--    stream_data0 => evb_data0,
--    stream_data1 => evb_data1,
    stream_data_valid => evb_data_valid,
    stream_fifo_read => evb_fifo_read,
    stream_event_ready => evb_eof,
    do_idelay => do_idelay,
    idelay_busy => idelay_busy,
    idelay_inc => fei4_idelay(28),
    idelay_rst => fei4_idelay(29),
    idelay_tap => fei4_idelay_tap,
    idelay_select => fei4_idelay(3 downto 0),
    address => iobus.io_address(11 downto 2),
    address_strobe => fei4_rx_addr_strobe,
    data => fei4_decoder_data,
    busclk => busclk,
    write_strobe => readout_write_strobe,
    bus_data => iobus.io_write_data,
    test_out => test_out,
    debug => fei4_debug
  );

  fei4_evb_imp : fei4_event_builder
  generic map (
    nsensor => nsensor
  )
  port map (
    stream_reset => fei4_csr(27),
    stream_clk => gbe_stream_clk,
    stream_wren => gbe_stream_wren,
    stream_strobe => gbe_stream_strobe,
    stream_dout => gbe_stream_dout,
    stream_free => gbe_stream_free,
    pixel_clk => fei4clk,
    bco => fei4_bco_counter,
    pixels_eof => evb_eof,
    pixels_in => evb_data,
    pixels_dv => evb_data_valid,
    pixels_read => evb_fifo_read
  );

--  evb_data(8) <= evb_data0;
--  evb_data(10) <= evb_data1;

  fei4_pulser_imp : fei4_pulser
  port map (
    reset => fei4_csr(31),
    strobe => do_pulser,
    continuous => fei4_pulser_csr(30),
    busy => pulser_busy,
    internal_state => pulser_state,
    outclk => fei4_clk,
    cal => pulser_cal,
    lv1 => pulser_lv1,
    delay => fei4_pulser_csr(23 downto 16),
    count => fei4_pulser_csr(15 downto 8),
    freq => fei4_pulser_csr(7 downto 0),
    bco => fei4_bco_counter
  );

  fei4_spy_fifo_imp : fei4_spy_fifo
  port map (
    empty => spy_fifo_empty,
    dout => spy_fifo_output,
    rd_en => spy_fifo_addressed,
    full => spy_fifo_full,
    din => fifo_input,
    wr_en => fei4_spy_dv,
    rd_clk => busclk,
    rst => spy_fifo_csr(31),
    valid => spy_fifo_valid,
    wr_clk => fei4clk
  );

  process ( fei4_clk ) begin
    if ( fei4_clk'event and fei4_clk = '1' ) then
      system_lv1 <= fei4_lv1;
    end if;
  end process;

  process ( busclk ) begin
    if ( busclk'event and busclk = '1' ) then
      if ( cmd_busy = '1' ) then
        txen <= ( others => '0' );
        trig <= ( others => '0' );
        cal <= ( others => '0' );
        bcr <= ( others => '0' );
        ecr <= ( others => '0' );
        sync_bco_zero <= '0';
      end if;

      if ( do_idelay = '1' and idelay_busy = '1' ) then
        do_idelay <= '0';
      end if;

      for i in 0 to 2*nsensor-1 loop
        if ( do_rdreg(i) = '1' and chan_busy(i) = '1' ) then
          do_rdreg(i) <= '0';
        end if;
        if ( do_capture(i) = '1' and capture_busy(i) = '1' ) then
          do_capture(i) <= '0';
        end if;
      end loop;

      if ( do_pulser = '1' and pulser_busy = '1' ) then
        do_pulser <= '0';
      end if;

      if ( cmdcount_reset_done = '1' and reset_cmdcount = '1' ) then
        reset_cmdcount <= '0';
      end if;

      if ( iobus.io_addr_strobe = '1' and masked_address = base_address ) then
        iobus_ready <= '1';
        if ( iobus.io_write_strobe = '1' ) then
          case iobus.io_address(15 downto 0) is
            when address_fei4_csr =>
              fei4_csr <= iobus.io_write_data;
            when address_fei4_pulser_csr =>
              if ( pulser_busy = '0' ) then
                do_pulser <= iobus.io_write_data(31);
              end if;
              fei4_pulser_csr <= iobus.io_write_data;
            when address_fei4_idelay =>
              if ( idelay_busy = '0' ) then
                do_idelay <= iobus.io_write_data(31);
              end if;
              fei4_idelay <= iobus.io_write_data;
            when address_fei4_cmdcount =>
              reset_cmdcount <= '1';
            when address_fei4_spy_fifo_csr =>
              spy_fifo_csr <= iobus.io_write_data;
            when address_fei4_front_end_0 =>
              front_end(31 downto 0) <= iobus.io_write_data;
            when address_fei4_front_end_1 =>
              front_end(32+31 downto 32) <= iobus.io_write_data;
            when address_fei4_front_end_2 =>
              front_end(2*32+31 downto 2*32) <= iobus.io_write_data;
            when address_fei4_front_end_3 =>
              front_end(3*32+31 downto 3*32) <= iobus.io_write_data;
            when address_fei4_front_end_4 =>
              front_end(4*32+31 downto 4*32) <= iobus.io_write_data;
            when address_fei4_front_end_5 =>
              front_end(5*32+31 downto 5*32) <= iobus.io_write_data;
            when address_fei4_front_end_6 =>
              front_end(6*32+31 downto 6*32) <= iobus.io_write_data;
            when address_fei4_front_end_7 =>
              front_end(7*32+31 downto 7*32) <= iobus.io_write_data;
            when address_fei4_front_end_8 =>
              front_end(8*32+31 downto 8*32) <= iobus.io_write_data;
            when address_fei4_front_end_9 =>
              front_end(9*32+31 downto 9*32) <= iobus.io_write_data;
            when address_fei4_front_end_10 =>
              front_end(10*32+31 downto 10*32) <= iobus.io_write_data;
            when address_fei4_front_end_11 =>
              front_end(11*32+31 downto 11*32) <= iobus.io_write_data;
            when address_fei4_front_end_12 =>
              front_end(12*32+31 downto 12*32) <= iobus.io_write_data;
            when address_fei4_front_end_13 =>
              front_end(13*32+31 downto 13*32) <= iobus.io_write_data;
            when address_fei4_front_end_14 =>
              front_end(14*32+31 downto 14*32) <= iobus.io_write_data;
            when address_fei4_front_end_15 =>
              front_end(15*32+31 downto 15*32) <= iobus.io_write_data;
            when address_fei4_front_end_16 =>
              front_end(16*32+31 downto 16*32) <= iobus.io_write_data;
            when address_fei4_front_end_17 =>
              front_end(17*32+31 downto 17*32) <= iobus.io_write_data;
            when address_fei4_front_end_18 =>
              front_end(18*32+31 downto 18*32) <= iobus.io_write_data;
            when address_fei4_front_end_19 =>
              front_end(19*32+31 downto 19*32) <= iobus.io_write_data;
            when address_fei4_front_end_20 =>
              front_end(20*32+31 downto 20*32) <= iobus.io_write_data;
            when others =>
              if ( iobus.io_address(15 downto 12) = address_fei4_channel(15 downto 12) and ichan < 2*nsensor ) then
                if ( iobus.io_address(7 downto 0) = address_fei4_channel_csr(7 downto 0) ) then
                  channel_csr(ichan) <= iobus.io_write_data;
                  if ( chan_busy(ichan) = '0' ) then
                    do_rdreg(ichan) <= iobus.io_write_data(31);
                  end if;
                  extra_clock <= '1';
                  do_match(ichan) <= iobus.io_write_data(30);
                  do_clear(ichan) <= iobus.io_write_data(29);
                  if ( capture_busy(ichan) = '0' ) then
                    do_capture(ichan) <= iobus.io_write_data(28);
                  end if;
                end if;
                if ( iobus.io_address(7 downto 0) = address_fei4_cmd(7 downto 0) ) then
                  fei4_command(ichan/2) <= iobus.io_write_data;
                  if ( cmd_busy = '0' ) then
                    if ( iobus.io_write_data(29 downto 26) = "1111" ) then
                      trig(ichan/2) <= iobus.io_write_data(31);
                    elsif ( iobus.io_write_data(29 downto 26) = "1110" ) then
                      cal(ichan/2) <= iobus.io_write_data(31);
                    elsif ( iobus.io_write_data(29 downto 26) = "1101" ) then
                      ecr(ichan/2) <= iobus.io_write_data(31);
                    elsif ( iobus.io_write_data(29 downto 26) = "1100" ) then
                      bcr(ichan/2) <= iobus.io_write_data(31);
                      sync_bco_zero <= iobus.io_write_data(16);
                      bco_zero_offset <= iobus.io_write_data(12 downto 0);
                    else
                      txen(ichan/2) <= iobus.io_write_data(31);
                    end if;
                  end if;
                end if;
              end if;
          end case;
        end if;
        if ( iobus.io_read_strobe = '1' ) then
          case iobus.io_address(15 downto 0) is
            when address_fei4_csr =>
              bus_data <= fei4_csr(31) & fei4_clk_locked & fei4_serdes(1 downto 0) & fei4_csr(27 downto 3) &
                          std_logic_vector(to_unsigned(nsensor,3));
            when address_fei4_pulser_csr =>
              bus_data <= pulser_busy & fei4_pulser_csr(30 downto 27) & pulser_state & fei4_pulser_csr(23 downto 0);
            when address_fei4_sync =>
              bus_data <= ( 0 => fei4_sync(0),
                            1 => fei4_sync(1),
                            2 => fei4_sync(2),
                            3 => fei4_sync(3),
                            others => '0' );
            when address_fei4_cmdcount =>
              bus_data <= cmd_counter;
            when address_fei4_idelay =>
              bus_data <= idelay_busy & fei4_idelay(30 downto 28) & "000000" & fei4_idelay_tap & fei4_errcount & fei4_idelay(3 downto 0);
            when address_fei4_spy_fifo_csr =>
              bus_data <= spy_fifo_csr(31) & spy_fifo_valid & spy_fifo_full & spy_fifo_empty & spy_fifo_csr(27 downto 0);
            when address_fei4_spy_fifo_data =>
              bus_data <= spy_fifo_output(31 downto 0);
              spy_fifo_addressed <= '1';
            when address_fei4_bco_counter_low =>
              bus_data <= fei4_bco_counter(31 downto 0);
            when address_fei4_bco_counter_high =>
              bus_data <= x"0000" & fei4_bco_counter(47 downto 32);
            when address_fei4_streamer =>
              bus_data <= stream_status;
            when address_fei4_front_end_0 =>
              bus_data <= front_end(31 downto 0);
            when address_fei4_front_end_1 =>
              bus_data <= front_end(32+31 downto 32);
            when address_fei4_front_end_2 =>
              bus_data <= front_end(2*32+31 downto 2*32);
            when address_fei4_front_end_3 =>
              bus_data <= front_end(3*32+31 downto 3*32);
            when address_fei4_front_end_4 =>
              bus_data <= front_end(4*32+31 downto 4*32);
            when address_fei4_front_end_5 =>
              bus_data <= front_end(5*32+31 downto 5*32);
            when address_fei4_front_end_6 =>
              bus_data <= front_end(6*32+31 downto 6*32);
            when address_fei4_front_end_7 =>
              bus_data <= front_end(7*32+31 downto 7*32);
            when address_fei4_front_end_8 =>
              bus_data <= front_end(8*32+31 downto 8*32);
            when address_fei4_front_end_9 =>
              bus_data <= front_end(9*32+31 downto 9*32);
            when address_fei4_front_end_10 =>
              bus_data <= front_end(10*32+31 downto 10*32);
            when address_fei4_front_end_11 =>
              bus_data <= front_end(11*32+31 downto 11*32);
            when address_fei4_front_end_12 =>
              bus_data <= front_end(12*32+31 downto 12*32);
            when address_fei4_front_end_13 =>
              bus_data <= front_end(13*32+31 downto 13*32);
            when address_fei4_front_end_14 =>
              bus_data <= front_end(14*32+31 downto 14*32);
            when address_fei4_front_end_15 =>
              bus_data <= front_end(15*32+31 downto 15*32);
            when address_fei4_front_end_16 =>
              bus_data <= front_end(16*32+31 downto 16*32);
            when address_fei4_front_end_17 =>
              bus_data <= front_end(17*32+31 downto 17*32);
            when address_fei4_front_end_18 =>
              bus_data <= front_end(18*32+31 downto 18*32);
            when address_fei4_front_end_19 =>
              bus_data <= front_end(19*32+31 downto 19*32);
            when address_fei4_front_end_20 =>
              bus_data <= front_end(20*32+31 downto 20*32);
            when others =>
              if ( iobus.io_address(15 downto 12) = address_fei4_channel(15 downto 12) and ichan < 2*nsensor ) then
                if ( iobus.io_address(7 downto 0) = address_fei4_channel_csr(7 downto 0) ) then
                  bus_data <= chan_busy(ichan) & do_match(ichan) & do_clear(ichan) & capture_busy(ichan) & channel_csr(ichan)(27 downto 0);
                end if;
                if ( iobus.io_address(7 downto 0) = address_fei4_cmd(7 downto 0) ) then
                  bus_data <= txbusy(ichan/2) & fei4_command(ichan/2)(30 downto 8) & tx_status(ichan/2)(7 downto 0);
                end if;
                if ( iobus.io_address(7 downto 0) = address_fei4_rdreg(7 downto 0) ) then
                  fei4_rx_addr_strobe <= '1';
                end if;
                if ( iobus.io_address(7) = '1' or iobus.io_address(6) = '1' ) then
                  fei4_rx_addr_strobe <= '1';
                end if;
                if ( iobus.io_address(7 downto 4) = "0011" or
                     iobus.io_address(7 downto 4) = "0100" ) then   -- capture buffer
                  fei4_rx_addr_strobe <= '1';
                end if;
              else
                bus_data <= x"c8f8f8f8";
              end if;
          end case;
        end if;
      else
        fei4_rx_addr_strobe <= '0';
        spy_fifo_addressed <= '0';
        iobus_ready <= '0';
        if ( extra_clock = '1' ) then
          extra_clock <= '0';
        else
          do_clear <= ( others => '0' );
          do_match <= ( others => '0' );
        end if;
      end if;
    end if;
  end process;

  process ( txbusy )
    variable busy : std_logic;
  begin
    busy := '0';
    for i in 0 to nsensor-1 loop
      if ( txbusy(i) = '1' ) then
        busy := '1';
      end if;
    end loop;
    cmd_busy <= busy;
  end process;

  readout_write_strobe <= iobus.io_write_strobe
    when ( iobus.io_addr_strobe = '1' and
           masked_address = base_address and
           iobus.io_address(15 downto 12) = address_fei4_channel(15 downto 12)
           and ichan/2 < nsensor )
    else '0';

  cmd_counter(15 downto 0) <= trigger_counter(15 downto 0);

  fei4_cmd <= fei4_cmd_out;
  bco_zero <= '1' when fei4_bco_counter(12 downto 0) = "0000000000000" else '0';
  select_lv1 <= system_lv1 when fei4_csr(8) = '0' else pulser_lv1;

  masked_address <= iobus.io_address(31 downto 16) and address_mask;
  ichan <= to_integer(unsigned(iobus.io_address(11 downto 8)));
  write_data <= fei4_decoder_data when fei4_rx_addr_strobe = '1' else bus_data;
  debug <= fei4_debug;

  fifo_input(35 downto 10) <= ( others => '0' );
  fifo_input(9 downto 0) <= fei4_spy_dout;

end Behavioral;
