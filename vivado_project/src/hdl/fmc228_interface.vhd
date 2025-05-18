--------------------------------------------------------------------------------
--
-- Company:
-- Engineer:       Matthew Jones - Purdue University
-- 
-- Create Date:    10:56:38 06/14/2016 
-- Design Name:    amc502
-- Module Name:    fmc228_interface - RTL
-- Project Name:   AMC502 firmware
-- Target Devices: xc7k420tffv1156-1
-- Tool versions:  Vivado 2016.1
-- Description:    VadaTech FMC228 slave
--
-- Dependencies:
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

library hep337dev;
use hep337dev.iobus.ALL;
use hep337dev.fmc228.ALL;

entity fmc228_interface is
  port (
    u : out std_logic_vector(2 downto 0);
    trig_in : in std_logic;
    trig_out : out std_logic;

    clk20mhz : in std_logic;
    bco : in std_logic_vector(47 downto 0);

    lmk_cs : out std_logic;
    lmk_sclk : out std_logic;
    lmk_sdi : out std_logic;
    lmk_sdo : in std_logic;
    lmk_sdio_dir : out std_logic;
    lmk_reset : out std_logic;
    lmk_sync : out std_logic;
    lmk_sysref_req : in std_logic;
    lmk_sync_dir : out std_logic;
    lmk_clkoe : out std_logic;
    lmk_status_ld : in std_logic_vector(1 downto 0);

    hmc_chip_en : out std_logic;
    hmc_ldo : in std_logic;
    hmc_sck : out std_logic;
    hmc_sdi : out std_logic;
    hmc_sdo : in std_logic;
    hmc_sen : out std_logic;

    adc_cs : out std_logic_vector(1 downto 0);
    adc_sck : out std_logic_vector(1 downto 0);
    adc_sdi : out std_logic_vector(1 downto 0);
    adc_sdo : in std_logic_vector(1 downto 0);
    adc_spi_dir : out std_logic_vector(1 downto 0);
    adc_pdwn : out std_logic_vector(1 downto 0);
    adc_sync : out std_logic_vector(1 downto 0);
    adc_fd : in std_logic_vector(3 downto 0);

    gte_refclk : in std_logic;
    sysref : in std_logic_vector(1 downto 0);
    rx_p : in std_logic_vector(7 downto 0); 
    rx_n : in std_logic_vector(7 downto 0); 

    gbe_stream_clk : in std_logic;
    gbe_stream_wren : out std_logic;
    gbe_stream_busy : in std_logic;
    gbe_stream_strobe : out std_logic;
    gbe_stream_dout : out std_logic_vector(31 downto 0);
    gbe_stream_free : in std_logic_vector(15 downto 0);

    udp_busy : in std_logic_vector(1 downto 0);

    adc_clk : out std_logic;
    adc_valid : out std_logic_vector(3 downto 0);
    adc_data0 : out std_logic_vector(63 downto 0);
    adc_data1 : out std_logic_vector(63 downto 0);
    adc_data2 : out std_logic_vector(63 downto 0);
    adc_data3 : out std_logic_vector(63 downto 0);

    oself_trig : out std_logic;
    oack : out std_logic;

    busclk : in std_logic;
    iobus : in iobus_t;
    write_data : out std_logic_vector(31 downto 0);
    iobus_ready : out std_logic
  );
end fmc228_interface;

architecture RTL of fmc228_interface is

  component lmk_spi
    port (
      clk : in std_logic;
      strobe : in std_logic;
      ready : out std_logic;
      dout : in std_logic_vector(23 downto 0);
      din : out std_logic_vector(7 downto 0);
      sclk : out std_logic;
      cs : out std_logic;
      sdi : out std_logic;
      sdo : in std_logic;
      sdir : out std_logic
    );
  end component;

  component hmc_spi
    port (
      clk : in std_logic;
      strobe : in std_logic;
      ready : out std_logic;
      dout : in std_logic_vector(31 downto 0);
      din : out std_logic_vector(31 downto 0);
      sck : out std_logic;
      sen : out std_logic;
      sdi : out std_logic;
      sdo : in std_logic
    );
  end component;

  component adc_spi
    port (
      clk : in std_logic;
      strobe : in std_logic;
      ready : out std_logic;
      dout : in std_logic_vector(23 downto 0);
      din : out std_logic_vector(7 downto 0);
      cs : out std_logic;
      sck : out std_logic;
      sdi : out std_logic;
      sdo : in std_logic;
      spi_dir : out std_logic
    );
  end component;

  component jesd204_adc
    port (
      rxn_in : in std_logic_vector(3 downto 0);
      rxp_in : in std_logic_vector(3 downto 0);
      reset : in std_logic;
      refclk : in std_logic;
      core_clk : in std_logic;
      qpll_lock : out std_logic;
      jesd204_sysref : in std_logic;
      enable_descrambler : in std_logic;
      adc_data_a : out std_logic_vector(63 downto 0);
      adc_data_b : out std_logic_vector(63 downto 0);
      adc_dv : out std_logic;
      align_cgs : in std_logic;
      align_busy : out std_logic;
      sync : out std_logic;
      clk : in std_logic;
      lane_sync : out std_logic_vector(31 downto 0)
    );
  end component;

  component adc_trigger
  port (
    clk : in std_logic;
    adc_fd : in std_logic_vector(3 downto 0);
    ext_trig : in std_logic;   
    inhibit : in std_logic;   
    mask : in std_logic_vector(7 downto 0);
    pres : in std_logic_vector(15 downto 0);
    delay : in std_logic_vector(31 downto 0);
    trig : out std_logic;
    wrdata : out std_logic;
    wrdata_raw : out std_logic;
    outrst : out std_logic;
    ibusy : in std_logic;
    outevn_number : out std_logic_vector(31 downto 0);
    algorithm : out std_logic_vector(7 downto 0)
  );
  end component;

  component adc_buffer_pool
  generic (
    nbuf : integer;
    buffer_size : integer;
    address_width : integer;
    input_width : integer
  );
  port (
    rst : in std_logic;
    clk_a : in std_logic;
    buffer_offset : in std_logic_vector(address_width-1 downto 0);
    wen_a : in std_logic;
    din_a : in std_logic_vector(63 downto 0);
    trigbits_a : in std_logic_vector(7 downto 0);
    trig : in std_logic;
    busy : out std_logic;
    ready : out std_logic;
    clk_b : in std_logic;
    rden_b : in std_logic;
    dout_b : out std_logic_vector(31 downto 0);
    status_b : out std_logic_vector(31 downto 0);
    trigbits_b : out std_logic_vector(7 downto 0);
    done_b : out std_logic;
    testmode : in std_logic_vector(3 downto 0);
    wa : out std_logic_vector(address_width-1 downto 0);
    pa : out std_logic_vector(address_width-1 downto 0);
    full : out std_logic
  );
  end component;

  component adc_buffer_streamer
  port (
    rst : in std_logic;
    clk : in std_logic;
    valid : in std_logic_vector(3 downto 0);
    done : in std_logic_vector(3 downto 0);
    rden : out std_logic_vector(3 downto 0);
    bco : in std_logic_vector(47 downto 0);
    din0 : in std_logic_vector(31 downto 0);
    din1 : in std_logic_vector(31 downto 0);
    din2 : in std_logic_vector(31 downto 0);
    din3 : in std_logic_vector(31 downto 0);
    infifo_empty0 : in std_logic;
    infifo_empty1 : in std_logic;    
    infifo_empty2 : in std_logic;
    infifo_empty3 : in std_logic;
    
    infifo_valid0 : in std_logic;
    infifo_valid1 : in std_logic;
    infifo_valid2 : in std_logic;
    infifo_valid3 : in std_logic;
    
    status0 : in std_logic_vector(31 downto 0);
    status1 : in std_logic_vector(31 downto 0);
    status2 : in std_logic_vector(31 downto 0);
    status3 : in std_logic_vector(31 downto 0);
    trig0 : in std_logic_vector(15 downto 0);
    trig1 : in std_logic_vector(15 downto 0);
    trig2 : in std_logic_vector(15 downto 0);
    trig3 : in std_logic_vector(15 downto 0);
    testmode : in std_logic_vector(3 downto 0);
    data_adc_length : in std_logic_vector(31 downto 0);
    wren : out std_logic;
    dout : out std_logic_vector(31 downto 0);
    inreq1 : in std_logic;
    inbusy1 : in std_logic;
    strobe : out std_logic
  );
  end component;

 component fifo_generator_0
  port(
   rst : in std_logic;
   wr_clk: in std_logic;
   full : out std_logic;
   din : in std_logic_vector(63 downto 0);
   wr_en : in std_logic;
   rd_clk : in std_logic;
   empty : out std_logic;
   dout : out std_logic_vector(31 downto 0);
   rd_en : in std_logic;
   valid : out std_logic      
  );
  end component;

  component peakfinding
   port (
   rst : in std_logic;
   clk_a : in std_logic;
   intrig: in std_logic;
   inwr : in std_logic;
   inreq1 : in std_logic;
   ibusy : in std_logic;
   datain1 : in std_logic_vector(63 downto 0);
   inthr : in std_logic_vector(31 downto 0);
   inpeakhigh_count : in std_logic_vector(31 downto 0);
   inpeakarea_count : in std_logic_vector(31 downto 0);
   
   clk_b : in std_logic;
   outdone : out std_logic;
   outwr : out std_logic;
   --peakvalue : out std_logic_vector(15 downto 0); 
   --sumvalue : out std_logic_vector(31 downto 0);
   --outevn_number : out std_logic_vector(31 downto 0);
   --outsumevn_number : out std_logic_vector(31 downto 0);
   --startprocess : in std_logic;
   dout : out std_logic_vector(31 downto 0)
    );
 end component;


component peakdata_stream
  port (
  rst : in std_logic;
  clk : in std_logic;
  inreq : in std_logic;
  inbusy : in std_logic;
  outreq0 : out std_logic;
  outreq1 : out std_logic;
  outreq2 : out std_logic;
  outreq3 : out std_logic;
  inwr0 : in std_logic;
  inwr1 : in std_logic;
  inwr2 : in std_logic;
  inwr3 : in std_logic;
  indone0 : in std_logic;
  indone1 : in std_logic;
  indone2 : in std_logic;
  indone3 : in std_logic;   
  datain0 : in std_logic_vector(31 downto 0);
  datain1 : in std_logic_vector(31 downto 0);
  datain2 : in std_logic_vector(31 downto 0);
  datain3 : in std_logic_vector(31 downto 0);

  outdone : out std_logic;
  outwr : out std_logic;
  dout : out std_logic_vector(31 downto 0)
 );
 end component;

component event_module
  port (
  rst : in std_logic;
  clk : in std_logic;
  intrig : in std_logic;
  inevntrig : in std_logic_vector(31 downto 0);
  inevn_submax : in std_logic_vector(31 downto 0);

  
  inbusy : in std_logic;

  outreq1 : out std_logic;
  datain1 : in std_logic_vector(31 downto 0);
  done1 : in std_logic;
  inwr1 : in std_logic;
  outbusy1 : out std_logic;

  outreq2 : out std_logic;
  datain2 : in std_logic_vector(31 downto 0);
  done2 : in std_logic;
  inwr2 : in std_logic;
  outbusy2 : out std_logic;

  --peakhigh : in std_logic_vector(15 downto 0);
  --inevn : in std_logic_vector(31 downto 0);
  --insumevn : in std_logic_vector(31 downto 0);
  --peaksum : in std_logic_vector(31 downto 0);
    
  oack : out std_logic;              
  wren : out std_logic;
  dout : out std_logic_vector(31 downto 0);
  obusy : out std_logic;
  strobe : out std_logic
    );
end component;  

  constant adc_buffer_address_width : integer := 12;
  constant adc_buffer_size : integer := 2**(adc_buffer_address_width+2);

  constant base_address : std_logic_vector(15 downto 0) := x"cf00";
  constant address_mask : std_logic_vector(15 downto 0) := x"ffff";
  constant address_fmc228_csr : std_logic_vector(15 downto 0) := x"0000";
  constant address_fmc228_lmk_spi : std_logic_vector(15 downto 0) := x"0010";
  constant address_fmc228_hmc_spi : std_logic_vector(15 downto 0) := x"0014";
  constant address_fmc228_adc0_spi : std_logic_vector(15 downto 0) := x"0018";
  constant address_fmc228_adc1_spi : std_logic_vector(15 downto 0) := x"001c";
  constant address_fmc228_adc0_sync : std_logic_vector(15 downto 0) := x"0020";
  constant address_fmc228_adc1_sync : std_logic_vector(15 downto 0) := x"0024";
  constant address_fmc228_adc0_lane : std_logic_vector(15 downto 0) := x"0028";
  constant address_fmc228_adc1_lane : std_logic_vector(15 downto 0) := x"002c";
  constant address_fmc228_adc0_thr : std_logic_vector(15 downto 0) := x"0030";
  constant address_fmc228_adc1_thr : std_logic_vector(15 downto 0) := x"0034";

  constant address_fmc228_buf_csr : std_logic_vector(15 downto 0) := x"0038";
  constant address_fmc228_trigger_mask : std_logic_vector(15 downto 0) := x"003c";
  constant address_fmc228_trigger_pres : std_logic_vector(15 downto 0) := x"0040";
  constant address_fmc228_trigger_delay : std_logic_vector(15 downto 0) := x"0044";
  constant address_fmc228_raw_adc : std_logic_vector(15 downto 0) := x"0048";
  constant address_fmc228_submax : std_logic_vector(15 downto 0) := x"004c";

  constant address_fmc228_thr_peakfinding : std_logic_vector(15 downto 0) := x"0050";
  constant address_fmc228_peakhigh_count : std_logic_vector(15 downto 0) := x"0054";
  constant address_fmc228_peakarea_count : std_logic_vector(15 downto 0) := x"0058";
    
  constant address_fmc228_stat_ch0 : std_logic_vector(15 downto 0) := x"0060";
  constant address_fmc228_stat_ch1 : std_logic_vector(15 downto 0) := x"0064";
  constant address_fmc228_stat_ch2 : std_logic_vector(15 downto 0) := x"0068";
  constant address_fmc228_stat_ch3 : std_logic_vector(15 downto 0) := x"006c";

  signal adc_buffer_csr : std_logic_vector(31 downto 0) := x"00000001";
  type adc_buffer_status_t is array(3 downto 0) of std_logic_vector(31 downto 0);
  signal adc_buffer_status : adc_buffer_status_t;
  signal latched_adc_buffer_status : adc_buffer_status_t;

  type trigger_bits_t is array(3 downto 0) of std_logic_vector(7 downto 0);
  signal trigger_bits : trigger_bits_t;
  type trigger_maskbits_t is array(3 downto 0) of std_logic_vector(15 downto 0);
  signal trigger_maskbits : trigger_maskbits_t;

  signal buffer_busy : std_logic_vector(3 downto 0);
  signal buffer_done : std_logic_vector(3 downto 0);
  signal buffer_rden : std_logic_vector(3 downto 0) := ( others => '0' );
  signal buffer_ready : std_logic_vector(3 downto 0) := ( others => '0' );
  signal all_buffers_full : std_logic_vector(3 downto 0);
  signal ch0_wa : std_logic_vector(7 downto 0);
  signal ch0_pa : std_logic_vector(7 downto 0);
  signal ch1_wa : std_logic_vector(7 downto 0);
  signal ch1_pa : std_logic_vector(7 downto 0);
  signal ch2_wa : std_logic_vector(7 downto 0);
  signal ch2_pa : std_logic_vector(7 downto 0);
  signal ch3_wa : std_logic_vector(7 downto 0);
  signal ch3_pa : std_logic_vector(7 downto 0);
  signal bco_counter : std_logic_vector(47 downto 0);
  
  type adc_buffer_data_t is array(3 downto 0) of std_logic_vector(31 downto 0);
  signal adc_buffer_data : adc_buffer_data_t;

  signal masked_address : std_logic_vector(15 downto 0);
  signal fmc228_csr : std_logic_vector(31 downto 0);
  signal latched_data : std_logic_vector(31 downto 0);
  signal trig : std_logic := '0';
  signal lmk_strobe : std_logic := '0';
  signal lmk_ready : std_logic;
  signal lmk_ready_r : std_logic;
  signal lmk_busy : std_logic;
  signal lmk_din : std_logic_vector(7 downto 0);
  signal lmk_din_r : std_logic_vector(7 downto 0);
  signal lmk_dout : std_logic_vector(23 downto 0);
  signal sync_sysref_req : std_logic;
  signal flasher : std_logic := '0';
  signal flash_count : unsigned(31 downto 0) := ( others => '0' );
  signal trigger_prescale : std_logic_vector(15 downto 0);

  signal hmc_dout : std_logic_vector(31 downto 0);
  signal hmc_din : std_logic_vector(31 downto 0);
  signal hmc_din_r : std_logic_vector(31 downto 0);
  signal hmc_ready : std_logic;
  signal hmc_ready_r : std_logic;
  signal hmc_busy : std_logic;
  signal hmc_strobe : std_logic := '0';

  type adc_dout_array_t is array(1 downto 0) of std_logic_vector(23 downto 0);
  signal adc_dout : adc_dout_array_t;
  type adc_din_array_t is array(1 downto 0) of std_logic_vector(7 downto 0);
  signal adc_din : adc_din_array_t;
  signal adc_din_r : adc_din_array_t;
  signal adc_ready : std_logic_vector(1 downto 0);
  signal adc_ready_r : std_logic_vector(1 downto 0);
  signal adc_strobe : std_logic_vector(1 downto 0) := ( others => '0' );
  signal adc_busy : std_logic_vector(1 downto 0);

  signal jesd204_core_clk : std_logic;
  signal jesd204_sys_reset : std_logic;
  signal jesd204_phy_qpll_lock : std_logic_vector(1 downto 0);
  type jesd204_rdata_t is array(1 downto 0) of std_logic_vector(31 downto 0);
  signal adc_data : std_logic_vector(31 downto 0);
  signal adc_addr_strobe : std_logic_vector(1 downto 0);
  signal buffer_read_strobe : std_logic;
  signal adc0_sync_csr : std_logic_vector(31 downto 0);
  signal adc1_sync_csr : std_logic_vector(31 downto 0);
  signal do_cgs : std_logic_vector(1 downto 0);
  signal align_busy : std_logic_vector(1 downto 0);
  signal sync : std_logic_vector(1 downto 0);
  type adc_data_t is array(3 downto 0) of std_logic_vector(63 downto 0);
  signal adc_data_out : adc_data_t;
  signal adc_dv : std_logic_vector(1 downto 0);
  signal waveform_we : std_logic_vector(1 downto 0);
  signal buffer_read : std_logic_vector(3 downto 0);
  signal trig_pipe : std_logic_vector(15 downto 0);
  signal trig_busy : std_logic;
  signal lane_sync_adc0 : std_logic_vector(31 downto 0);
  signal lane_sync_adc1 : std_logic_vector(31 downto 0);
  signal threshold_adc0 : std_logic_vector(31 downto 0) := ( others => '0' );
  signal threshold_adc1 : std_logic_vector(31 downto 0) := ( others => '0' );

  signal adc_fd_r : std_logic_vector(3 downto 0);
  signal trigger_output : std_logic;
  signal trigger_mask : std_logic_vector(7 downto 0);
  signal trigger_delay : std_logic_vector(31 downto 0);
  signal trigger_algorithm : std_logic_vector(7 downto 0);
  signal trigger_inhibit : std_logic;

  signal raw_adc_length : std_logic_vector(31 downto 0);
  signal evn_submax : std_logic_vector(31 downto 0);

  signal thr_peakfinding : std_logic_vector(31 downto 0);
  signal peakhigh_count : std_logic_vector(31 downto 0);
  signal peakarea_count : std_logic_vector(31 downto 0);

  
  signal adc_buffer_stream_data : std_logic_vector(31 downto 0);
  signal adc_buffer_stream_done: std_logic;
  signal adc_buffer_stream_wr: std_logic;
  signal adc_buffer_stream_ack: std_logic;
  
  signal wr_data : std_logic;
  signal wr_data_raw : std_logic;


  type fifo_data_t is array(3 downto 0) of std_logic_vector(31 downto 0);
  signal fifo_data_out : fifo_data_t;  
  signal fifo_full : std_logic_vector(3 downto 0);
  signal fifo_empty0 : std_logic;
  signal fifo_empty1 : std_logic;
  signal fifo_empty2 : std_logic;
  signal fifo_empty3 : std_logic;
  signal fifo_valid0 : std_logic;
  signal fifo_valid1 : std_logic;
  signal fifo_valid2 : std_logic;
  signal fifo_valid3 : std_logic;

  signal fifo_wr : std_logic;
  signal fifo_rden0 : std_logic;
  signal fifo_rden1 : std_logic;
  signal fifo_rden2 : std_logic;
  signal fifo_rden3 : std_logic;
  signal fifo_rst : std_logic;
  signal fifo_adc_data_in : adc_data_t;



  signal evn_req1 : std_logic;
  signal evn_req2 : std_logic;
  signal evn_busy : std_logic;
  signal evn_busy1 : std_logic;
  signal evn_busy2 : std_logic;
  
  signal evn_number : std_logic_vector(31 downto 0);
  signal evn_ack : std_logic;


  signal peakdata_stream_wr : std_logic;
  signal peakdata_stream_done : std_logic;
  signal peakdata_stream_data : std_logic_vector(31 downto 0);
  signal peakfinding_req0 : std_logic;
  signal peakfinding_req1 : std_logic;
  signal peakfinding_req2 : std_logic;
  signal peakfinding_req3 : std_logic;
  signal peakfinding_wr0 : std_logic;
  signal peakfinding_wr1 : std_logic;
  signal peakfinding_wr2 : std_logic;
  signal peakfinding_wr3 : std_logic;
  signal peakfinding_done0 : std_logic;
  signal peakfinding_done1 : std_logic;
  signal peakfinding_done2 : std_logic;
  signal peakfinding_done3 : std_logic;
  signal peakfinding_data0 : std_logic_vector(31 downto 0);
  signal peakfinding_data1 : std_logic_vector(31 downto 0);
  signal peakfinding_data2 : std_logic_vector(31 downto 0);  
  signal peakfinding_data3 : std_logic_vector(31 downto 0);
  
  signal gbe_busy : std_logic;
  signal free_buff : std_logic_vector(11 downto 0);

  attribute mark_debug : string;
  attribute mark_debug of gbe_stream_wren : signal is "true";
  attribute mark_debug of gbe_stream_strobe : signal is "true";
  attribute mark_debug of buffer_busy : signal is "true";
  attribute mark_debug of buffer_done : signal is "true";
  attribute mark_debug of trigger_output : signal is "true";
  attribute mark_debug of adc_fd_r : signal is "true";

begin

  lmk_spi_imp : lmk_spi
  port map (
    clk => clk20mhz,
    strobe => lmk_strobe,
    ready => lmk_ready,
    dout => lmk_dout,
    din => lmk_din,
    sclk => lmk_sclk,
    cs => lmk_cs,
    sdi => lmk_sdi,
    sdo => lmk_sdo,
    sdir => lmk_sdio_dir
  );

  hmc_spi_imp : hmc_spi
  port map (
    clk => clk20mhz,
    strobe => hmc_strobe,
    ready => hmc_ready,
    dout => hmc_dout,
    din => hmc_din,
    sck => hmc_sck,
    sen => hmc_sen,
    sdi => hmc_sdi,
    sdo => hmc_sdo
  );

  g_adc_spi : for i in 0 to 1 generate
    adc_spi_imp : adc_spi
    port map (
      clk => clk20mhz,
      strobe => adc_strobe(i),
      ready => adc_ready(i),
      dout => adc_dout(i),
      din => adc_din(i),
      sck => adc_sck(i), 
      cs => adc_cs(i), 
      sdi => adc_sdi(i),
      sdo => adc_sdo(i),
      spi_dir => adc_spi_dir(i)
    );
  end generate;

  -- 250 MHz
  jesd204_core_clk_bufg : bufg
  port map (
    i => gte_refclk,
    o => jesd204_core_clk
  );

  jesd204_adc0_imp : jesd204_adc
  port map (
    rxn_in => rx_n(3 downto 0),
    rxp_in => rx_p(3 downto 0),
    reset => jesd204_sys_reset,
    refclk => gte_refclk,  -- 250 MHz
    core_clk => jesd204_core_clk,  -- 250 MHz
    qpll_lock => jesd204_phy_qpll_lock(0),
    jesd204_sysref => sysref(0),
    enable_descrambler => adc0_sync_csr(1),
    adc_data_a => adc_data_out(0),
    adc_data_b => adc_data_out(1),
    adc_dv => adc_dv(0),
    align_cgs => do_cgs(0),
    align_busy => align_busy(0),
    sync => adc_sync(0),
    clk => busclk,  -- 100 MHz
    lane_sync => lane_sync_adc0
  );

  jesd204_adc1_imp : jesd204_adc
  port map (
    rxn_in => rx_n(7 downto 4),
    rxp_in => rx_p(7 downto 4),
    reset => jesd204_sys_reset,
    refclk => gte_refclk,
    core_clk => jesd204_core_clk,
    qpll_lock => jesd204_phy_qpll_lock(1),
    jesd204_sysref => sysref(1),
    enable_descrambler => adc1_sync_csr(1),
    adc_data_a => adc_data_out(2),
    adc_data_b => adc_data_out(3),
    adc_dv => adc_dv(1),
    align_cgs => do_cgs(1),
    align_busy => align_busy(1),
    sync => adc_sync(1),
    clk => busclk,
    lane_sync => lane_sync_adc1
  );

  trig_imp : adc_trigger
  port map (
    clk => jesd204_core_clk,
    adc_fd => adc_fd,
    ext_trig => trig_in,
    inhibit => trigger_inhibit,
    mask => trigger_mask,
    pres => trigger_prescale,
    delay => trigger_delay,
    trig => trigger_output,
    wrdata => wr_data,
    wrdata_raw => wr_data_raw,
    outrst => fifo_rst,
    ibusy => evn_busy,
    outevn_number => evn_number, 
    algorithm => trigger_algorithm
  );
  
  oself_trig <= trigger_output;
  --g_bp : for i in 0 to 3 generate
  --  bp_imp : adc_buffer_pool
  --  generic map (
  --    nbuf => 2,
  --    buffer_size => adc_buffer_size,
  --    address_width => adc_buffer_address_width,
  --    input_width => 64
  --  )
  --  port map (
  --    rst => adc_buffer_csr(31),
  --    clk_a => jesd204_core_clk,
  --    buffer_offset => adc_buffer_csr(adc_buffer_address_width-1 downto 0),
  --    wen_a => adc_dv(i/2),
  --    din_a => adc_data_out(i),
  --    trigbits_a => trigger_algorithm,
  --    trig => trigger_output,
  --    busy => buffer_busy(i),
  --    ready => buffer_ready(i),
  --    clk_b => gbe_stream_clk,
  --    rden_b => buffer_rden(i),
  --    dout_b => adc_buffer_data(i),
  --    status_b => adc_buffer_status(i),
  --    trigbits_b => trigger_bits(i),
  --    done_b => buffer_done(i),
  --    testmode => adc_buffer_csr(23 downto 20),
  --    wa => open,
  --    pa => open,
  --    full => all_buffers_full(i)
  --  );
  --  trigger_maskbits(i) <= trigger_mask & trigger_bits(i);
  --end generate;



  fifo_adc_data_in(0) <= adc_data_out(0)(31 downto 0) & adc_data_out(0)(63 downto 32) ;
  fifo_adc_data_in(1) <= adc_data_out(1)(31 downto 0) & adc_data_out(1)(63 downto 32) ;
  fifo_adc_data_in(2) <= adc_data_out(2)(31 downto 0) & adc_data_out(2)(63 downto 32);
  fifo_adc_data_in(3) <= adc_data_out(3)(31 downto 0) & adc_data_out(3)(63 downto 32) ;      

--g_fifo : for i in 0 to 3 generate
  fifo_0_imp : fifo_generator_0
     port map (
        rst => fifo_rst,--adc_buffer_csr(31), --
        wr_clk => jesd204_core_clk,
        full => fifo_full(0),
        din => fifo_adc_data_in(0), --adc_data_out(0),
        wr_en => wr_data_raw, --wr_data, ----fifo_wr, --wr_data, --write_buffer_data(0),
        rd_clk => gbe_stream_clk,
        empty => fifo_empty0,
        dout => fifo_data_out(0),
        rd_en => buffer_rden(0), 
        valid => fifo_valid0      
        );
        

  fifo_1_imp : fifo_generator_0
     port map (
        rst => fifo_rst,-- adc_buffer_csr(31), --
        wr_clk => jesd204_core_clk,
        full => fifo_full(1),
        din => fifo_adc_data_in(1), --adc_data_out(1),
        wr_en => wr_data_raw, --wr_data, --write_buffer_data(1),
        rd_clk => gbe_stream_clk,
        empty => fifo_empty1,
        dout => fifo_data_out(1),
        rd_en => buffer_rden(1), 
        valid => fifo_valid1      
        );

  fifo_2_imp : fifo_generator_0
     port map (
        rst => fifo_rst,--adc_buffer_csr(31), --
        wr_clk => jesd204_core_clk,
        full => fifo_full(2),
        din => fifo_adc_data_in(2), --adc_data_out(2),
        wr_en => wr_data_raw, --wr_data, --write_buffer_data(2),
        rd_clk => gbe_stream_clk,
        empty => fifo_empty2,
        dout => fifo_data_out(2),
        rd_en => buffer_rden(2), 
        valid => fifo_valid2      
        );

  fifo_3_imp : fifo_generator_0
     port map (
        rst => fifo_rst,--adc_buffer_csr(31), --
        wr_clk => jesd204_core_clk,
        full => fifo_full(3),
        din => fifo_adc_data_in(3), --adc_data_out(3),
        wr_en => wr_data_raw, --wr_data, --write_buffer_data(3),
        rd_clk => gbe_stream_clk,
        empty => fifo_empty3,
        dout => fifo_data_out(3),
        rd_en => buffer_rden(3), 
        valid => fifo_valid3      
        );
 --end generate;


  bs_imp : adc_buffer_streamer
  port map (
    rst => adc_buffer_csr(31), --fifo_rst, --
    clk => gbe_stream_clk,
    valid => buffer_busy,
    done => buffer_done,
    rden => buffer_rden,
    bco => bco_counter,
    din0 => fifo_data_out(0), -- adc_buffer_data(0),
    din1 => fifo_data_out(1), --adc_buffer_data(1),
    din2 => fifo_data_out(2), --adc_buffer_data(2),
    din3 => fifo_data_out(3), --adc_buffer_data(3),
    infifo_empty0 => fifo_empty0,
    infifo_empty1 => fifo_empty1,
    infifo_empty2 => fifo_empty2,
    infifo_empty3 => fifo_empty3,
    
    infifo_valid0 => fifo_valid0,
    infifo_valid1 => fifo_valid1,
    infifo_valid2 => fifo_valid2,
    infifo_valid3 => fifo_valid3,

    status0 => adc_buffer_status(0),
    status1 => adc_buffer_status(1),
    status2 => adc_buffer_status(2),
    status3 => adc_buffer_status(3),
    trig0 => trigger_maskbits(0),
    trig1 => trigger_maskbits(1),
    trig2 => trigger_maskbits(2),
    trig3 => trigger_maskbits(3),
    testmode => adc_buffer_csr(27 downto 24),

    inreq1 => evn_req1,
    inbusy1 => '0', --evn_busy1,
    data_adc_length => raw_adc_length, 
    wren => adc_buffer_stream_wr , --gbe_stream_wren,
    dout => adc_buffer_stream_data, --gbe_stream_dout,
    strobe => adc_buffer_stream_done --gbe_stream_strobe
  );


 pf_0_imp : peakfinding
    port map (
      rst => fifo_rst,--adc_buffer_csr(31), --
      clk_a => jesd204_core_clk,  
      intrig => trigger_output, 
      inwr =>  wr_data, --adc_dv(0),
      inreq1 => peakfinding_req0, --peakfinding_req0, 
      ibusy => evn_busy,
      datain1 => fifo_adc_data_in(0), --adc_data_out(0), --
      inthr => thr_peakfinding,
      inpeakhigh_count => peakhigh_count,
      inpeakarea_count => peakarea_count,
      clk_b => gbe_stream_clk,      
      outdone => peakfinding_done0,
      outwr => peakfinding_wr0,
      --peakvalue => open, --peak_value,
      --sumvalue => sum_value,
      --outevn_number => peakfinding_evn,
      --outsumevn_number => sum_evn,
      --startprocess => fifo_wr, --startdata,
      dout => peakfinding_data0
    );
    
 pf_1_imp : peakfinding
   port map (
      rst => fifo_rst,--adc_buffer_csr(31), --
      clk_a => jesd204_core_clk,  
      intrig => peakfinding_req1, --trigger_output, 
      inwr => wr_data, -- adc_dv(0), --
      inreq1 => peakfinding_req1, 
      ibusy => evn_busy,
      datain1 => fifo_adc_data_in(1), --adc_data_out(1),
      inthr => thr_peakfinding,
      inpeakhigh_count => peakhigh_count,
      inpeakarea_count => peakarea_count,
      clk_b => gbe_stream_clk,      
      outdone => peakfinding_done1,
      outwr => peakfinding_wr1,
      --peakvalue => open, --peak_value,
      --sumvalue => open, --sum_value,
      --outevn_number => open, --peakfinding_evn,
      --outsumevn_number => open, --sum_evn,
      --startprocess => fifo_wr, --startdata,
      dout => peakfinding_data1
    );

 pf_2_imp : peakfinding
   port map (
     rst => fifo_rst,--adc_buffer_csr(31), --
     clk_a => jesd204_core_clk,  
     intrig => peakfinding_req2, --trigger_output, 
     inwr => wr_data, --adc_dv(1), --
     inreq1 => peakfinding_req2, 
     ibusy => evn_busy,
     datain1 => fifo_adc_data_in(2), --adc_data_out(2),
     inthr => thr_peakfinding,
     inpeakhigh_count => peakhigh_count,
     inpeakarea_count => peakarea_count,
     clk_b => gbe_stream_clk,      
     outdone => peakfinding_done2,
     outwr => peakfinding_wr2,
     --peakvalue => open, --peak_value,
     --sumvalue => open, --sum_value,
     --outevn_number => open, --peakfinding_evn,
     --outsumevn_number => open, --sum_evn,
     --startprocess => fifo_wr, --startdata,
     dout => peakfinding_data2
    );

 pf_3_imp : peakfinding
   port map (
    rst => fifo_rst,--adc_buffer_csr(31), --
    clk_a => jesd204_core_clk,  
    intrig => peakfinding_req3, --trigger_output, 
    inwr => wr_data, --adc_dv(1), --
    inreq1 => peakfinding_req3, 
    ibusy => evn_busy,
    datain1 => fifo_adc_data_in(3), --adc_data_out(3),
    inthr => thr_peakfinding,
    inpeakhigh_count => peakhigh_count,
    inpeakarea_count => peakarea_count,    
    clk_b => gbe_stream_clk,      
    outdone => peakfinding_done3,
    outwr => peakfinding_wr3,
    --peakvalue => open, --peak_value,
    --sumvalue => open, --sum_value,
    --outevn_number => open, --peakfinding_evn,
    --outsumevn_number => open, --sum_evn,
    --startprocess => fifo_wr, --startdata,
    dout => peakfinding_data3
   );

 peakst_imp : peakdata_stream
  port map (
    rst => adc_buffer_csr(31), --fifo_rst,--
    clk => gbe_stream_clk,
    inreq => evn_req2,
    inbusy => '0', --evn_busy2, 
    
    outreq0 => peakfinding_req0,
    outreq1 => peakfinding_req1,
    outreq2 => peakfinding_req2,
    outreq3 => peakfinding_req3,
    inwr0 => peakfinding_wr0, --peakfinding_wr0,
    inwr1 => peakfinding_wr1,
    inwr2 => peakfinding_wr2,
    inwr3 => peakfinding_wr3,
    indone0 => peakfinding_done0, --peakfinding_done0,
    indone1 => peakfinding_done1,
    indone2 => peakfinding_done2,
    indone3 => peakfinding_done3,
    datain0 => peakfinding_data0, --x"1a2a3a4a",
    datain1 => peakfinding_data1, --x"1b2b3b4b",
    datain2 => peakfinding_data2, --x"1c2c3c4c",
    datain3 => peakfinding_data3, --x"1d2d3d4d",
                
    outdone => peakdata_stream_done,
    outwr => peakdata_stream_wr,
    dout => peakdata_stream_data
  );

  ev_imp : event_module
  port map (
    rst => adc_buffer_csr(31), --fifo_rst, --
    clk  => gbe_stream_clk,
    intrig  => trigger_output,
    inevntrig => evn_number,
    inevn_submax => evn_submax,
    
    inbusy => '0', --gbe_stream_busy,

    outreq1 => evn_req1,
    datain1 => adc_buffer_stream_data,
    done1 => adc_buffer_stream_done,
    inwr1 => adc_buffer_stream_wr,
    outbusy1 => evn_busy1,

    outreq2 => evn_req2,
    datain2 => peakdata_stream_data, --peakfinding_data, 
    done2 => peakdata_stream_done, --peakfinding_done,
    inwr2 => peakdata_stream_wr, --peakfinding_wr,
    outbusy2 => evn_busy2,

    --peakhigh => peak_value,
    --inevn => peakfinding_evn,
    --insumevn => sum_evn,
    --peaksum => sum_value,
    oack => evn_ack,
    wren => gbe_stream_wren,
    dout => gbe_stream_dout,
    obusy => evn_busy,
    strobe => gbe_stream_strobe
  );

  oack <= evn_ack; --oack of fmc228_interface 
  free_buff <= gbe_stream_free(15 downto 4);
  
  process (jesd204_core_clk) begin
    if(jesd204_core_clk'event and jesd204_core_clk='1') then
        if(wr_data = '1' and evn_busy = '0') then
            fifo_wr <= '1';
        else
            fifo_wr <= '0';
        end if;
        
        --if(gbe_stream_free = x"0fff") then
        if(udp_busy(0) = '0' and udp_busy(1) ='0') then
            gbe_busy <='0';
        else
            gbe_busy <= '1';
        end if;
            
        
       -- if (wr_data = '1' and fifo_full(0) = '1') then
       --     fifo_rden0 <= '1';
       -- elsif (buffer_rden(0)= '1') then
       --      fifo_rden0 <= '1';
       -- else
       --      fifo_rden0 <= '0';
       -- end if;

       --if (wr_data = '1' and fifo_full(1) = '1') then
       --     fifo_rden1 <= '1';
       -- elsif (buffer_rden(1)= '1') then
       --      fifo_rden1 <= '1';
       -- else
       --      fifo_rden1 <= '0';
       -- end if;

       -- if (wr_data = '1' and fifo_full(2) = '1') then
       --     fifo_rden2 <= '1';
       -- elsif (buffer_rden(2)= '1') then
       --      fifo_rden2 <= '1';
       -- else
       --      fifo_rden2 <= '1';
       -- end if;

       -- if (wr_data = '1' and fifo_full(3) = '1') then
       --     fifo_rden3 <= '1';
       -- elsif (buffer_rden(3)= '1') then
       --      fifo_rden3 <= '1';
       -- else
       --      fifo_rden3 <= '0';
       -- end if;

    end if;
  end process;


  process ( busclk ) begin
    if ( busclk'event and busclk= '1' ) then
      adc_fd_r <= adc_fd;
      hmc_din_r <= hmc_din;
      lmk_din_r <= lmk_din;
      adc_din_r <= adc_din;
      lmk_ready_r <= lmk_ready;
      hmc_ready_r <= hmc_ready;
      adc_ready_r <= adc_ready;
      if ( lmk_strobe = '1' and lmk_ready_r = '0' ) then
        lmk_strobe <= '0';
      end if;
      if ( hmc_strobe = '1' and hmc_ready_r = '0' ) then
        hmc_strobe <= '0';
      end if;
      if ( adc_strobe(0) = '1' and adc_ready_r(0) = '0' ) then
        adc_strobe(0) <= '0';
      end if;
      if ( adc_strobe(1) = '1' and adc_ready_r(1) = '0' ) then
        adc_strobe(1) <= '0';
      end if;
      if ( iobus.io_addr_strobe = '1' and masked_address = base_address ) then
        iobus_ready <= '1';
        if ( iobus.io_write_strobe = '1' ) then
          case iobus.io_address(15 downto 0) is
            when address_fmc228_csr =>
              fmc228_csr <= iobus.io_write_data;
              trig <= iobus.io_write_data(16);
            when address_fmc228_lmk_spi =>
              lmk_dout <= iobus.io_write_data(31 downto 8);
              if ( lmk_ready_r = '1' ) then
                lmk_strobe <= '1';
              end if;
            when address_fmc228_hmc_spi =>
              hmc_dout <= iobus.io_write_data(23 downto 0) & iobus.io_write_data(28 downto 24) & "000";
              if ( hmc_ready_r = '1' ) then
                hmc_strobe <= '1';
              end if;
            when address_fmc228_adc0_spi =>
              adc_dout(0) <= iobus.io_write_data(31 downto 8);
              if ( adc_ready_r(0) = '1' ) then
                adc_strobe(0) <= '1';
              end if;
            when address_fmc228_adc1_spi =>
              adc_dout(1) <= iobus.io_write_data(31 downto 8);
              if ( adc_ready_r(1) = '1' ) then
                adc_strobe(1) <= '1';
              end if;
            when address_fmc228_adc0_sync =>
              adc0_sync_csr <= iobus.io_write_data;
              if ( align_busy(0) = '0' ) then
                do_cgs(0) <= iobus.io_write_data(0);
              end if;
            when address_fmc228_adc1_sync =>
              adc1_sync_csr <= iobus.io_write_data;
              if ( align_busy(1) = '0' ) then
                do_cgs(1) <= iobus.io_write_data(0);
              end if;
            when address_fmc228_adc0_thr =>
              threshold_adc0 <= iobus.io_write_data;
            when address_fmc228_adc1_thr =>
              threshold_adc1 <= iobus.io_write_data;
            when address_fmc228_buf_csr =>
              adc_buffer_csr <= iobus.io_write_data;
            when address_fmc228_trigger_mask =>
              trigger_mask <= iobus.io_write_data(7 downto 0);
            when address_fmc228_trigger_pres =>
              trigger_prescale <= iobus.io_write_data(15 downto 0);
            when address_fmc228_trigger_delay =>
              trigger_delay <= iobus.io_write_data;
            when address_fmc228_raw_adc =>
              raw_adc_length <= iobus.io_write_data;
            when address_fmc228_submax =>
              evn_submax <= iobus.io_write_data;
            when address_fmc228_thr_peakfinding =>
              thr_peakfinding <= iobus.io_write_data;
            when address_fmc228_peakhigh_count =>
              peakhigh_count <= iobus.io_write_data;
            when address_fmc228_peakarea_count =>
              peakarea_count <= iobus.io_write_data;                

            when others =>
          end case;
        end if;

        if ( iobus.io_read_strobe = '1' ) then
          case iobus.io_address(15 downto 0) is
            when address_fmc228_csr =>
              latched_data <= fmc228_csr(31 downto 24) &
                              adc_fd_r & fmc228_csr(19 downto 18) &
                              trig_in & trig_busy & lmk_sysref_req &
                              fmc228_csr(14 downto 12) &
                              hmc_ldo & fmc228_csr(10 downto 5) & 
                              lmk_status_ld & fmc228_csr(2 downto 0);
            when address_fmc228_lmk_spi =>
              latched_data <= lmk_busy & lmk_dout(22 downto 0) & lmk_din_r;
            when address_fmc228_hmc_spi =>
              latched_data <= hmc_busy & "00" & hmc_din_r(7 downto 3) & hmc_din_r(31 downto 8);
            when address_fmc228_adc0_spi =>
              latched_data <= adc_busy(0) & adc_dout(0)(22 downto 0) & adc_din_r(0); 
            when address_fmc228_adc1_spi =>
              latched_data <= adc_busy(1) & adc_dout(1)(22 downto 0) & adc_din_r(1);
            when address_fmc228_adc0_sync =>
              latched_data <= jesd204_phy_qpll_lock(0) &
                              adc0_sync_csr(30 downto 1) & align_busy(0);
            when address_fmc228_adc1_sync =>
              latched_data <= jesd204_phy_qpll_lock(1) &
                              adc1_sync_csr(30 downto 1) & align_busy(1);
            when address_fmc228_adc0_lane =>
              latched_data <= lane_sync_adc0;
            when address_fmc228_adc1_lane =>
              latched_data <= lane_sync_adc1;
            when address_fmc228_adc0_thr =>
              latched_data <= threshold_adc0;
            when address_fmc228_adc1_thr =>
              latched_data <= threshold_adc1;
            when address_fmc228_buf_csr =>
              latched_data <= adc_buffer_csr;
            when address_fmc228_trigger_mask =>
              latched_data <= x"000000" & trigger_mask;
            when address_fmc228_trigger_pres =>
              latched_data <= x"0000" & trigger_prescale;
            when address_fmc228_trigger_delay =>
              latched_data <= trigger_delay;
            when address_fmc228_raw_adc =>
              latched_data <= raw_adc_length;
            when address_fmc228_submax =>
              latched_data <= evn_submax;
            when address_fmc228_thr_peakfinding =>
              latched_data <= thr_peakfinding; 
            when address_fmc228_peakhigh_count =>
              latched_data <= peakhigh_count; 
            when address_fmc228_peakarea_count =>
              latched_data <= peakarea_count; 
            when address_fmc228_stat_ch0 =>
              latched_data <= latched_adc_buffer_status(0);
            when address_fmc228_stat_ch1 =>
              latched_data <= latched_adc_buffer_status(1);
            when address_fmc228_stat_ch2 =>
              latched_data <= latched_adc_buffer_status(2);
            when address_fmc228_stat_ch3 =>
              latched_data <= latched_adc_buffer_status(3);
            when others =>
              latched_data <= x"f8f8f8f8";

          end case;
        end if;
      else
        iobus_ready <= '0';
        trig <= '0';
        latched_data <= ( others => '0' );
        if ( align_busy(0) = '1' ) then
          do_cgs(0) <= '0';
        end if;
        if ( align_busy(1) = '1' ) then
          do_cgs(1) <= '0';
        end if;
      end if;
      if ( trig = '1' ) then
        trig_pipe <= '0' & trig_pipe(15 downto 1);
      else
        trig_pipe <= x"00ff";
      end if;
      for i in 0 to 3 loop
        latched_adc_buffer_status(i) <= adc_buffer_status(i);
      end loop;
    end if;
  end process;

  process ( clk20mhz ) begin
    if ( clk20mhz'event and clk20mhz = '1' ) then
      if ( flash_count = to_unsigned(10000000,31) ) then
        flash_count <= ( others => '0' );
        flasher <= not flasher;
      else
        flash_count <= flash_count + 1;
      end if;
    end if;
  end process;

  process ( jesd204_core_clk, trig_in ) begin
    if ( jesd204_core_clk'event and jesd204_core_clk = '1' ) then
      bco_counter <= bco;
    end if;
  end process;

  lmk_busy <= lmk_strobe or not lmk_ready_r;
  hmc_busy <= hmc_strobe or not hmc_ready_r;
  adc_busy(0) <= adc_strobe(0) or not adc_ready_r(0);
  adc_busy(1) <= adc_strobe(1) or not adc_ready_r(1);

  --u(1 downto 0) <= not fmc228_csr(1 downto 0);
  u(0) <= not fmc228_csr(0);
  u(1) <= not flasher;
  u(2) <= not flasher;
  trig_out <= trig_pipe(0);

  masked_address <= iobus.io_address(31 downto 16) and address_mask;
  write_data <= latched_data;

  lmk_clkoe <= fmc228_csr(5);
  lmk_sync_dir <= '1';
  lmk_sync <= fmc228_csr(7);
  hmc_chip_en <= fmc228_csr(8);
  adc_pdwn(0) <= fmc228_csr(9);
  adc_pdwn(1) <= fmc228_csr(10);
  lmk_reset <= fmc228_csr(31);
  jesd204_sys_reset <= fmc228_csr(30);

  adc_addr_strobe(0) <= iobus.io_addr_strobe when
                        masked_address = base_address and
                        iobus.io_address(15 downto 12) = "0001" else '0';
  adc_addr_strobe(1) <= iobus.io_addr_strobe when
                        masked_address = base_address and
                        iobus.io_address(15 downto 12) = "0010" else '0';
  trig_busy <= '1' when trig_pipe /= x"0000" else '0';
  trigger_inhibit <= '1' when all_buffers_full /= "0000" else '0';


  adc_data0 <= adc_data_out(0);
  adc_data1 <= adc_data_out(1);
  adc_data2 <= adc_data_out(2);
  adc_data3 <= adc_data_out(3);
  adc_valid <= adc_dv(1) & adc_dv(1) & adc_dv(0) & adc_dv(0);
  adc_clk <= jesd204_core_clk;

end RTL;
