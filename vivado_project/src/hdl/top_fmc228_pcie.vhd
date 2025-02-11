----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/24/2018 05;13:07 AM
-- Design Name: 
-- Module Name: top_fmc228_pcie - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.00 - File Created
--
-- Additional Comments:
--
--   This top level design is for an AMC502+PCIe with an FMC228 in slot 1.
--   PCIe not implemented yet.  This is mainly a place holder.
--   
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

library hep337dev;
use hep337dev.iobus.all;
use hep337dev.amc502.all;
--use hep337dev.gbe.all;
-- use hep337dev.pciei.all;
--use hep337dev.fmc228.all;

entity top_fmc228_pcie is
  port (
    clk100mhz1_p : in std_logic;
    clk100mhz1_n : in std_logic;
    clk125mhz2_p : in std_logic;
    clk125mhz2_n : in std_logic;
    amc_tx0_p : out std_logic;
    amc_tx0_n : out std_logic;
    amc_rx0_p : in std_logic;
    amc_rx0_n : in std_logic;
    amc502_pll_rst_n : out std_logic;
    amc502_scl_l1 : out std_logic;
    amc502_sda_l1 : inout std_logic;
    amc502_scl_lllx : in std_logic;
    amc502_sda_lllx : inout std_logic;
    amc502_fpclka_p : in std_logic;
    amc502_fpclka_n : in std_logic;
    amc502_fpclkb_p : in std_logic;
    amc502_fpclkb_n : in std_logic;
    amc502_fpclkc_p : in std_logic;
    amc502_fpclkc_n : in std_logic;
    amc502_fpclkd_p : in std_logic;
    amc502_fpclkd_n : in std_logic;
    amc502_fpclke_p : out std_logic;
    amc502_fpclke_n : out std_logic;
    amc502_fpclkf_p : in std_logic;
    amc502_fpclkf_n : in std_logic;
    amc502_fpclkg_p : in std_logic;
    amc502_fpclkg_n : in std_logic;
    amc502_fpclkh_p : out std_logic;
    amc502_fpclkh_n : out std_logic;

    clk156_25mhz2_p : in std_logic;
    clk156_25mhz2_n : in std_logic;
    amc_tx4_p : out std_logic;
    amc_tx4_n : out std_logic;
    amc_rx4_p : in std_logic;
    amc_rx4_n : in std_logic;
    amc_tx5_p : out std_logic;
    amc_tx5_n : out std_logic;
    amc_rx5_p : in std_logic;
    amc_rx5_n : in std_logic;
    amc_tx6_p : out std_logic;
    amc_tx6_n : out std_logic;
    amc_rx6_p : in std_logic;
    amc_rx6_n : in std_logic;
    amc_tx7_p : out std_logic;
    amc_tx7_n : out std_logic;
    amc_rx7_p : in std_logic;
    amc_rx7_n : in std_logic;

    fmc228_uled : out std_logic_vector(2 downto 0);
    fmc228_lmk_cs : out std_logic;
    fmc228_lmk_sclk : out std_logic;
    fmc228_lmk_sdio : inout std_logic;
    fmc228_lmk_sdio_dir : out std_logic;
    fmc228_lmk_reset : out std_logic;
    fmc228_lmk_clkoe : out std_logic;
    fmc228_lmk_sync : inout std_logic;
    fmc228_lmk_sync_dir : out std_logic;
    fmc228_lmk_status_ld : in std_logic_vector(1 downto 0);
    fmc228_hmc_chip_en : out std_logic;
    fmc228_hmc_ldo : in std_logic;
    fmc228_hmc_sck : out std_logic;
    fmc228_hmc_sdi : out std_logic;
    fmc228_hmc_sdo : in std_logic;
    fmc228_hmc_sen : out std_logic;
    fmc228_adc_cs : out std_logic_vector(1 downto 0);
    fmc228_adc_sck : out std_logic_vector(1 downto 0);
    fmc228_adc_sdio : inout std_logic_vector(1 downto 0);
    fmc228_adc_spi_dir : out std_logic_vector(1 downto 0);
    fmc228_adc_pdwn : out std_logic_vector(1 downto 0);
    fmc228_adc_sync_p : out std_logic_vector(1 downto 0);
    fmc228_adc_sync_n : out std_logic_vector(1 downto 0);
    fmc228_adc_fd : in std_logic_vector(3 downto 0);
    fmc228_dclkout0_p : in std_logic;
    fmc228_dclkout0_n : in std_logic;
    fmc228_dclkout10_p : in std_logic;
    fmc228_dclkout10_n : in std_logic;
    fmc228_dclkout12_p : in std_logic;
    fmc228_dclkout12_n : in std_logic;
    fmc228_dclkout2_p : in std_logic;
    fmc228_dclkout2_n : in std_logic;
    fmc228_sysref11_p : in std_logic;
    fmc228_sysref11_n : in std_logic;
    fmc228_sysref13_p : in std_logic;
    fmc228_sysref13_n : in std_logic;
    fmc228_rx_p : in std_logic_vector(7 downto 0);
    fmc228_rx_n : in std_logic_vector(7 downto 0);
    fmc228_trig_in_p : in std_logic;
    fmc228_trig_in_n : in std_logic;
    fmc228_trig_out_p : out std_logic;
    fmc228_trig_out_n : out std_logic;

    fmc228_uled_card1 : out std_logic_vector(2 downto 0);
    fmc228_lmk_cs_card1 : out std_logic;
    fmc228_lmk_sclk_card1 : out std_logic;
    fmc228_lmk_sdio_card1 : inout std_logic;
    fmc228_lmk_sdio_dir_card1 : out std_logic;
    fmc228_lmk_reset_card1 : out std_logic;
    fmc228_lmk_clkoe_card1 : out std_logic;
    fmc228_lmk_sync_card1 : inout std_logic;
    fmc228_lmk_sync_dir_card1 : out std_logic;
    fmc228_lmk_status_ld_card1 : in std_logic_vector(1 downto 0);
    fmc228_hmc_chip_en_card1 : out std_logic;
    fmc228_hmc_ldo_card1 : in std_logic;
    fmc228_hmc_sck_card1 : out std_logic;
    fmc228_hmc_sdi_card1 : out std_logic;
    fmc228_hmc_sdo_card1 : in std_logic;
    fmc228_hmc_sen_card1 : out std_logic;
    fmc228_adc_cs_card1 : out std_logic_vector(1 downto 0);
    fmc228_adc_sck_card1 : out std_logic_vector(1 downto 0);
    fmc228_adc_sdio_card1 : inout std_logic_vector(1 downto 0);
    fmc228_adc_spi_dir_card1 : out std_logic_vector(1 downto 0);
    fmc228_adc_pdwn_card1 : out std_logic_vector(1 downto 0);
    fmc228_adc_sync_p_card1 : out std_logic_vector(1 downto 0);
    fmc228_adc_sync_n_card1 : out std_logic_vector(1 downto 0);
    fmc228_adc_fd_card1 : in std_logic_vector(3 downto 0);
    fmc228_dclkout0_p_card1 : in std_logic;
    fmc228_dclkout0_n_card1 : in std_logic;
    fmc228_dclkout10_p_card1 : in std_logic;
    fmc228_dclkout10_n_card1 : in std_logic;
    fmc228_dclkout12_p_card1 : in std_logic;
    fmc228_dclkout12_n_card1 : in std_logic;
    fmc228_dclkout2_p_card1 : in std_logic;
    fmc228_dclkout2_n_card1 : in std_logic;
    fmc228_sysref11_p_card1 : in std_logic;
    fmc228_sysref11_n_card1 : in std_logic;
    fmc228_sysref13_p_card1 : in std_logic;
    fmc228_sysref13_n_card1 : in std_logic;
    fmc228_rx_p_card1 : in std_logic_vector(7 downto 0);
    fmc228_rx_n_card1 : in std_logic_vector(7 downto 0);
    fmc228_trig_in_p_card1 : in std_logic;
    fmc228_trig_in_n_card1 : in std_logic;
    fmc228_trig_out_p_card1 : out std_logic;
    fmc228_trig_out_n_card1 : out std_logic;


    fpga_rx_uart : in std_logic;
    fpga_tx_uart : out std_logic;
    user : in std_logic_vector(6 downto 0);
    nuled : out std_logic_vector(3 downto 0)
  );
end top_fmc228_pcie;

architecture behavioral of top_fmc228_pcie is

  component microblaze_mcs_0 is
  port (
    clk : in std_logic;
    reset : in std_logic;
    uart_interrupt : out std_logic;
    fit1_toggle : out std_logic;
    intc_interrupt : in std_logic_vector ( 0 to 0 );
    intc_irq : out std_logic;
    io_addr_strobe : out std_logic;
    io_address : out std_logic_vector ( 31 downto 0 );
    io_byte_enable : out std_logic_vector ( 3 downto 0 );
    io_read_data : in std_logic_vector ( 31 downto 0 );
    io_read_strobe : out std_logic;
    io_ready : in std_logic;
    io_write_data : out std_logic_vector ( 31 downto 0 );
    io_write_strobe : out std_logic;
    uart_rxd : in std_logic;
    uart_txd : out std_logic
  );
  end component microblaze_mcs_0;

  component gig_ethernet_pcs_pma_0
  port (
    gtrefclk_p : in std_logic;
    gtrefclk_n : in std_logic;
    gtrefclk_out : out std_logic;
    gtrefclk_bufg_out : out std_logic;
    txn : out std_logic;
    txp : out std_logic;
    rxn : in std_logic;
    rxp : in std_logic;
    independent_clock_bufg : in std_logic;
    userclk_out : out std_logic;
    userclk2_out : out std_logic;
    rxuserclk_out : out std_logic;
    rxuserclk2_out : out std_logic;
    resetdone : out std_logic;
    pma_reset_out : out std_logic;
    mmcm_locked_out : out std_logic;
    gmii_txd : in std_logic_vector(7 downto 0);
    gmii_tx_en : in std_logic;
    gmii_tx_er : in std_logic;
    gmii_rxd : out std_logic_vector(7 downto 0);
    gmii_rx_dv : out std_logic;
    gmii_rx_er : out std_logic;
    gmii_isolate : out std_logic;
    configuration_vector : in std_logic_vector(4 downto 0);
    status_vector : out std_logic_vector(15 downto 0);
    reset : in std_logic;
    signal_detect : in std_logic;
    gt0_qplloutclk_out : out std_logic;
    gt0_qplloutrefclk_out : out std_logic
  );
  end component;

--
--  Define PCIe interface component here
--

  signal clk100mhz1_pre : std_logic;
  signal clk100mhz : std_logic;
  signal uart_rxd : std_logic;
  signal uart_txd : std_logic;
  signal scl_l1 : std_logic;
  signal sda_l1_out : std_logic;
  signal sda_l1_in : std_logic;
  signal sda_l1_t : std_logic;
  signal scl_lllx : std_logic;
  signal sda_lllx_out : std_logic;
  signal sda_lllx_in : std_logic;
  signal sda_lllx_t : std_logic;
  signal pll_rst_n : std_logic;
  signal onepps_strobe : std_logic;

  signal gmii_txd : std_logic_vector(7 downto 0);
  signal gmii_tx_en : std_logic;
  signal gmii_tx_er : std_logic;
  signal gmii_rxd : std_logic_vector(7 downto 0);
  signal gmii_rx_dv : std_logic;
  signal gmii_rx_er : std_logic;
  signal gmii_rxclk : std_logic;
  signal pcs_pma_status : std_logic_vector(15 downto 0);
  signal pcs_pma_reset : std_logic;
  signal pcs_pma_reset_done : std_logic;
  signal pcs_pma_mmcm_locked : std_logic;
  signal gt0_qplloutclk : std_logic;
  signal gt0_qplloutrefclk : std_logic;
  signal gbe_stream_clka : std_logic;
  signal gbe_stream_wren : std_logic_vector(1 downto 0);
  signal gbe_stream_busy : std_logic_vector(1 downto 0);
  signal gbe_stream_strobe : std_logic_vector(1 downto 0);

  type stream_data_array_t is array(1 downto 0) of std_logic_vector(31 downto 0);
  type stream_free_array_t is array(1 downto 0) of std_logic_vector(15 downto 0);
  
  signal gbe_stream_data : stream_data_array_t; --(1 downto 0);
  signal gbe_stream_free : stream_free_array_t; --(1 downto 0);
  
  signal udp_busy : std_logic_vector(1 downto 0);

  signal fmc_card0_stream_wren : std_logic;
  signal fmc_card0_stream_strobe : std_logic;
  signal fmc_card0_stream_data : stream_data_array_t;--(1 downto 0);

  signal fmc_card1_stream_wren : std_logic;
  signal fmc_card1_stream_strobe : std_logic;
  signal fmc_card1_stream_data : stream_data_array_t;--(1 downto 0);


--
--  Define PCIe signals
--


--

  signal amc502_clocks : std_logic_vector(15 downto 0);
  signal amc502_fpclka : std_logic;  -- slave 40 MHz input
  signal amc502_fpclkb : std_logic;  -- master 40 MHz input
  signal amc502_fpclkc : std_logic;  -- extra PLL input
  signal amc502_fpclkd : std_logic;  -- extra PLL input
  signal amc502_fpclke : std_logic;  -- 10 MHz primary time source output
  signal amc502_fpclkf : std_logic;  -- tclka input
  signal amc502_fpclkg : std_logic;  -- unused
  signal amc502_fpclkh : std_logic;  -- tclkb output
  signal fpclka : std_logic;
  signal fpclkb : std_logic;
  signal fpclkc : std_logic;
  signal fpclkd : std_logic;
  signal fpclke : std_logic;
  signal fpclkg : std_logic;
  signal clkfb : std_logic;
  signal clk200mhz_out : std_logic;
  signal clk80mhz_out : std_logic;
  signal clk160mhz_out : std_logic;
  signal clk40mhz_out : std_logic;
  signal clk20mhz_out : std_logic;
  signal clk10mhz_out : std_logic;
  signal mmcm_locked : std_logic;
  signal idelay_rst : std_logic;
  signal idelay_rst_pipe : std_logic_vector(63 downto 0) := ( others => '0' );
  signal clk200mhz : std_logic;
  signal clk160mhz : std_logic;
  signal clk80mhz : std_logic;
  signal clk40mhz : std_logic;
  signal clk20mhz : std_logic;
  signal bco_counter : std_logic_vector(47 downto 0);
  signal bco_counter_card1 : std_logic_vector(47 downto 0);


  constant nslave : integer := 4;
  signal core_reset : std_logic := '0';
  signal core_interrupt : std_logic_vector(0 downto 0) := "0";
  signal io_ready : std_logic;
  signal io_read_data : std_logic_vector(31 downto 0);
  signal core_intc_irq : std_logic;
  signal master_iobus : iobus_t;
  signal second_iobus : iobus_t;
  signal slave_iobus : iobus_array_t(nslave-1 downto 0);
  signal slave_write_data : data_array_t(nslave-1 downto 0);
  signal slave_ready : ready_array_t(nslave-1 downto 0);

-- FMC228 signals

  signal fmc_trig_in : std_logic;
  signal fmc_trig_out : std_logic;
  signal fmc_led : std_logic_vector(2 downto 0);

  signal fmc_refclk : std_logic;
  signal fmc_dclkout0 : std_logic;
  signal fmc_dclkout10 : std_logic;
  signal fmc_dclkout12 : std_logic;
  signal fmc_dclkout2 : std_logic;
  signal fmc_sysref11 : std_logic;
  signal fmc_sysref13 : std_logic;
  signal fmc_sysref : std_logic_vector(1 downto 0);

  signal lmk_cs : std_logic;
  signal lmk_sdi : std_logic;
  signal lmk_sdo : std_logic;
  signal lmk_sclk : std_logic;
  signal lmk_sdio_dir : std_logic;
  signal lmk_sdio_t : std_logic;
  signal lmk_reset : std_logic;
  signal lmk_sync : std_logic;
  signal lmk_sysref_req : std_logic;
  signal lmk_sync_dir : std_logic;
  signal lmk_sync_dir_t : std_logic;
  signal lmk_status_ld : std_logic_vector(1 downto 0);
  signal lmk_clkoe : std_logic;

  signal hmc_chip_en : std_logic;
  signal hmc_ldo : std_logic;
  signal hmc_sck : std_logic;
  signal hmc_sdi : std_logic;
  signal hmc_sdo : std_logic;
  signal hmc_sen : std_logic;

  signal adc_cs : std_logic_vector(1 downto 0);
  signal adc_sck : std_logic_vector(1 downto 0);
  signal adc_sdi : std_logic_vector(1 downto 0);
  signal adc_sdo : std_logic_vector(1 downto 0);
  signal adc_spi_dir : std_logic_vector(1 downto 0);
  signal adc_spi_dir_t : std_logic_vector(1 downto 0);
  signal adc_pdwn : std_logic_vector(1 downto 0);
  signal adc_sync : std_logic_vector(1 downto 0);
  signal adc_fd : std_logic_vector(3 downto 0);
  signal test_led : std_logic;
  signal jesd204_core_clk : std_logic;
  
  signal adc_trig : std_logic;
  signal self_trig_card0 : std_logic;

  signal fmc_card0_ack : std_logic;

  signal count : unsigned(31 downto 0);
  type state_t is ( state1, state2, state3, state4, state5, state6 );
  signal state : state_t := state1;


component gbe_interface is
generic (
    mac_address : string := "00:00:00:00:00:00";
    ip_address : string := "192.168.40.253";
    netmask : string := "255.255.255.0";
    gateway : string := "192.168.40.1";
    jumpers : boolean := false;
    nstream : integer := 1;    
    dhcp : boolean := false
  );
  port (
    busclk : in std_logic;
    iobus : in iobus_t;
    write_data : out std_logic_vector(31 downto 0);
    iobus_ready : out std_logic;
    interrupt : out std_logic;
    reset_out : out std_logic;
    reset_done : in std_logic;
    mmcm_locked : in std_logic;
    jumpered_address : in std_logic_vector(6 downto 0);
    gmii_clk : in std_logic;
    gmii_txd : out std_logic_vector(7 downto 0);
    gmii_tx_en : out std_logic;
    gmii_tx_er : out std_logic;
    gmii_rxd : in std_logic_vector(7 downto 0);
    gmii_rx_dv : in std_logic;
    gmii_rx_er : in std_logic;
    udp_busy : out std_logic_vector(1 downto 0);
    gbe_stream_clka : out std_logic;
    gbe_stream_wren : in std_logic_vector(nstream-1 downto 0);
    gbe_stream_busy : out std_logic_vector(nstream-1 downto 0);
    gbe_stream_strobe : in std_logic_vector(nstream-1 downto 0);
    gbe_stream_data : in stream_data_array_t; --(nstream-1 downto 0);
    gbe_stream_free : out stream_free_array_t --(nstream-1 downto 0)
  );
end component;



  component fmc228_interface is
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
    gbe_stream_strobe : out std_logic;
    gbe_stream_dout : out std_logic_vector(31 downto 0);
    gbe_stream_free : in std_logic_vector(15 downto 0);
    gbe_stream_busy : in std_logic;
    
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
  end component;


-- FMC228 card1 signals

  signal fmc_trig_in_card1 : std_logic;
  signal fmc_trig_out_card1 : std_logic;
  signal fmc_led_card1 : std_logic_vector(2 downto 0);

  signal fmc_refclk_card1 : std_logic;
  signal fmc_dclkout0_card1 : std_logic;
  signal fmc_dclkout10_card1 : std_logic;
  signal fmc_dclkout12_card1 : std_logic;
  signal fmc_dclkout2_card1 : std_logic;
  signal fmc_sysref11_card1 : std_logic;
  signal fmc_sysref13_card1 : std_logic;
  signal fmc_sysref_card1 : std_logic_vector(1 downto 0);

  signal lmk_cs_card1 : std_logic;
  signal lmk_sdi_card1 : std_logic;
  signal lmk_sdo_card1 : std_logic;
  signal lmk_sclk_card1 : std_logic;
  signal lmk_sdio_dir_card1 : std_logic;
  signal lmk_sdio_t_card1 : std_logic;
  signal lmk_reset_card1 : std_logic;
  signal lmk_sync_card1 : std_logic;
  signal lmk_sysref_req_card1 : std_logic;
  signal lmk_sync_dir_card1 : std_logic;
  signal lmk_sync_dir_t_card1 : std_logic;
  signal lmk_status_ld_card1 : std_logic_vector(1 downto 0);
  signal lmk_clkoe_card1 : std_logic;

  signal hmc_chip_en_card1 : std_logic;
  signal hmc_ldo_card1 : std_logic;
  signal hmc_sck_card1 : std_logic;
  signal hmc_sdi_card1 : std_logic;
  signal hmc_sdo_card1 : std_logic;
  signal hmc_sen_card1 : std_logic;

  signal adc_cs_card1 : std_logic_vector(1 downto 0);
  signal adc_sck_card1 : std_logic_vector(1 downto 0);
  signal adc_sdi_card1 : std_logic_vector(1 downto 0);
  signal adc_sdo_card1 : std_logic_vector(1 downto 0);
  signal adc_spi_dir_card1 : std_logic_vector(1 downto 0);
  signal adc_spi_dir_t_card1 : std_logic_vector(1 downto 0);
  signal adc_pdwn_card1 : std_logic_vector(1 downto 0);
  signal adc_sync_card1 : std_logic_vector(1 downto 0);
  signal adc_fd_card1 : std_logic_vector(3 downto 0);
  signal test_led_card1 : std_logic;
  signal fmc_card1_ack : std_logic;

  signal jesd204_core_clk_card1 : std_logic;

  signal count_card1 : unsigned(31 downto 0);
  type state_t_card1 is ( state1_card1, state2_card1, state3_card1, state4_card1, state5_card1, state6_card1 );
  signal state_card1 : state_t_card1 := state1_card1;

  component fmc228card1_interface is
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
    fmc_stream_wren : out std_logic;
    fmc_stream_strobe : out std_logic;
    fmc_stream_dout : out std_logic_vector(31 downto 0);

    adc_clk : out std_logic;
    adc_valid : out std_logic_vector(3 downto 0);
    adc_data0 : out std_logic_vector(63 downto 0);
    adc_data1 : out std_logic_vector(63 downto 0);
    adc_data2 : out std_logic_vector(63 downto 0);
    adc_data3 : out std_logic_vector(63 downto 0);

    oack : out std_logic;

    busclk : in std_logic;
    iobus : in iobus_t;
    write_data : out std_logic_vector(31 downto 0);
    iobus_ready : out std_logic
    );
  end component;

 signal amc_req1 : std_logic;
 signal amc_req2 : std_logic;
 signal amc_busy : std_logic;

component event_amc is
  port (
    clk : in std_logic;
    intrig : in std_logic;

    outreq1 : out std_logic;
    datain1 : in std_logic_vector(31 downto 0);
    inwr1 : in std_logic;    
    done1 : in std_logic;
    inack1  : in std_logic;

    outreq2 : out std_logic;
    datain2 : in std_logic_vector(31 downto 0);
    done2 : in std_logic;
    inwr2 : in std_logic;
    inack2  : in std_logic;

    wren : out std_logic;
    dout : out std_logic_vector(31 downto 0);
    obusy : out std_logic;
    strobe : out std_logic
  );
end component;


begin

  mcs_imp : microblaze_mcs_0
  port map (
    clk => clk100mhz,
    intc_interrupt => core_interrupt,
    intc_irq => core_intc_irq,
    io_addr_strobe => master_iobus.io_addr_strobe,
    io_address => master_iobus.io_address,
    io_byte_enable => master_iobus.io_byte_enable,
    io_read_data  => io_read_data,
    io_read_strobe => master_iobus.io_read_strobe,
    io_ready => io_ready,
    io_write_data => master_iobus.io_write_data,
    io_write_strobe => master_iobus.io_write_strobe,
    reset => core_reset,
    uart_rxd => uart_rxd,
    uart_txd => uart_txd
  );

  pcs_pma : gig_ethernet_pcs_pma_0
  port map (
    gtrefclk_p => clk125mhz2_p,
    gtrefclk_n => clk125mhz2_n,
    gtrefclk_out => open,
    gtrefclk_bufg_out => open,
    txn => amc_tx0_n,
    txp => amc_tx0_p,
    rxn => amc_rx0_n,
    rxp => amc_rx0_p,
    independent_clock_bufg => clk200mhz,
    userclk_out => open,
    userclk2_out => gmii_rxclk,
    rxuserclk_out => open,
    rxuserclk2_out => open,
    resetdone => pcs_pma_reset_done,
    pma_reset_out => open,
    mmcm_locked_out => pcs_pma_mmcm_locked,
    gmii_txd => gmii_txd,
    gmii_tx_en => gmii_tx_en,
    gmii_tx_er => gmii_tx_er,
    gmii_rxd => gmii_rxd,
    gmii_rx_dv => gmii_rx_dv,
    gmii_rx_er => gmii_rx_er,
    configuration_vector => "00000",
    status_vector => pcs_pma_status,
    reset => pcs_pma_reset,
    signal_detect => '1',
    gt0_qplloutclk_out => gt0_qplloutclk,
    gt0_qplloutrefclk_out => gt0_qplloutrefclk
  );

--
--  Instantiate PCIe interface here
--

  -- Primitive: Advanced Mixed Mode Clock Manager
  
  mmcm_imp : mmcme2_base
  generic map (
    -- Specifies the amount to multiply all CLKOUT clock outputs if a different frequency is desired. 
    -- This number, in combination with the associated CLKOUT#_DIVIDE value and DIVCLK_DIVIDE value, will determine the output frequency.
    clkfbout_mult_f => 8.000,
    clkin1_period => 10.000,  -- Specifies the input period in ns to the MMCM CLKIN inputs
    clkout0_divide_f => 4.000,
    clkout1_divide => 40,
    clkout2_divide => 20,
    clkout3_divide => 10,
    clkout4_divide => 5,
    clkout6_divide => 80
  )
  port map (
    clkfbin => clkfb,  -- Feedback clock pin to the MMCM.
    clkin1 => clk100mhz,  -- Primary clock input.
    pwrdwn => '0',
    rst => '0',
    clkfbout => clkfb,  -- Dedicated MMCM Feedback clock output.
    clkfboutb => open,
    clkout0 => clk200mhz_out,
    clkout0b => open,
    clkout1 => clk20mhz_out,
    clkout1b => open,
    clkout2 => clk40mhz_out,
    clkout2b => open,
    clkout3 => clk80mhz_out,
    clkout3b => open,
    clkout4 => clk160mhz_out,
    clkout5 => open,
    clkout6 => clk10mhz_out,
    locked => mmcm_locked
  );

  iobus_imp : iobus_interface
  generic map (
    nslave => nslave
  )
  port map (
    clk => clk100mhz,
    master => master_iobus,
    second_master => second_iobus,
    io_read_data => io_read_data,
    io_ready => io_ready,
    slave => slave_iobus,
    io_write_data => slave_write_data,
    slave_ready => slave_ready
  );

  amc502_imp : amc502_interface
  generic map (
    nclock => 8
  )
  port map (
    clk20mhz => clk20mhz,
    bco => bco_counter,
    scl_l1 => scl_l1,
    sda_l1_out => sda_l1_out,
    sda_l1_in => sda_l1_in,
    sda_l1_t => sda_l1_t,
    scl_lllx => scl_lllx,
    sda_lllx_out => sda_lllx_out,
    sda_lllx_in => sda_lllx_in,
    sda_lllx_t => sda_lllx_t,
    io_address_strobe => second_iobus.io_addr_strobe,
    io_read_strobe => second_iobus.io_read_strobe,
    io_write_strobe => second_iobus.io_write_strobe,
    io_address => second_iobus.io_address,
    io_write_data => second_iobus.io_write_data,
    io_read_data => io_read_data,
    pll_rst_n => pll_rst_n,
    fpclka => fpclka,              -- slave recovered 40 MHz bcoclk input
    fpclkb => fpclkb,              -- master 40 MHz bcoclk input
    tclka => amc502_fpclkf,        -- slave trigger-encoded system clock input
    tclkb => amc502_fpclkh,        -- master trigger-encoded system clock output
    fpclk => amc502_clocks,
    cmd_strobe => open,
    stop_timer => '0',
    uled => open,
    uled_select => open,

    xgbe_stream_clk => '0',
    xgbe_stream_dout => open,
    xgbe_stream_wren => open,
    xgbe_stream_strobe => open,
    xgbe_trigger_stream_enable => '0',
    xgbe_trigger_stream_data => ( others => '0' ),
    systrig => open,

    busclk => clk100mhz,
    onepps => onepps_strobe,
    iobus => slave_iobus(0),
    write_data => slave_write_data(0),
    iobus_ready => slave_ready(0)
  );

  gbe_imp : gbe_interface
  generic map (
    mac_address => "00:80:55:ec:00:0c",
    ip_address => "192.168.40.245",
    netmask => "255.255.255.0",
    gateway => "192.168.40.1",
    jumpers => false,
    nstream => 2,    
    dhcp => false
  )
  port map (
    busclk => clk100mhz,
    iobus => slave_iobus(1),
    write_data => slave_write_data(1),
    iobus_ready => slave_ready(1),
    interrupt => core_interrupt(0),
    reset_out => pcs_pma_reset,
    reset_done => pcs_pma_reset_done,
    mmcm_locked => pcs_pma_mmcm_locked,
    jumpered_address => user,
    gmii_txd => gmii_txd,
    gmii_tx_en => gmii_tx_en,
    gmii_tx_er => gmii_tx_er,
    gmii_clk => gmii_rxclk,
    gmii_rxd => gmii_rxd,
    gmii_rx_dv => gmii_rx_dv,
    gmii_rx_er => gmii_rx_er,
    
    udp_busy => udp_busy,

    gbe_stream_clka => gbe_stream_clka,
    gbe_stream_wren => gbe_stream_wren,
    gbe_stream_busy => gbe_stream_busy,
    gbe_stream_strobe => gbe_stream_strobe,
    gbe_stream_data => gbe_stream_data,
    gbe_stream_free => gbe_stream_free

  );

--
--  Instantiate PCIe stuff here
--

  fmc228_card0_imp : fmc228_interface
  port map (
    u => fmc_led,
    trig_in => adc_trig, --fmc_trig_in, --amc_req1, --
    trig_out => open,

    clk20mhz => clk20mhz,
    bco => bco_counter,

    lmk_cs => lmk_cs,
    lmk_sclk => lmk_sclk,
    lmk_sdi => lmk_sdi,
    lmk_sdo => lmk_sdo,
    lmk_sdio_dir => lmk_sdio_dir,
    lmk_reset => lmk_reset,
    lmk_sync => lmk_sync,
    lmk_sysref_req => lmk_sysref_req,
    lmk_sync_dir => lmk_sync_dir,
    lmk_clkoe => lmk_clkoe,
    lmk_status_ld => lmk_status_ld,

    hmc_chip_en => hmc_chip_en,
    hmc_ldo => hmc_ldo,
    hmc_sck => hmc_sck,
    hmc_sdi => hmc_sdi,
    hmc_sdo => hmc_sdo,
    hmc_sen => hmc_sen,
    adc_cs => adc_cs,
    adc_sck => adc_sck,
    adc_sdi => adc_sdi,
    adc_sdo => adc_sdo,
    adc_spi_dir => adc_spi_dir,
    adc_pdwn => adc_pdwn,
    adc_sync => adc_sync,
    adc_fd => adc_fd,

    gte_refclk => fmc_refclk,
    sysref => fmc_sysref,
    rx_p => fmc228_rx_p,
    rx_n => fmc228_rx_n,

    oself_trig => self_trig_card0,
    oack => fmc_card0_ack,

    gbe_stream_clk => gbe_stream_clka,
    gbe_stream_wren => gbe_stream_wren(0), --fmc_card0_stream_wren, --
    gbe_stream_busy => gbe_stream_busy(0),
    gbe_stream_strobe => gbe_stream_strobe(0), --fmc_card0_stream_strobe, --
    gbe_stream_dout => gbe_stream_data(0), --fmc_card0_stream_data(0), --
    gbe_stream_free => gbe_stream_free(0),
    udp_busy => udp_busy,

    busclk => clk100mhz,
    iobus => slave_iobus(2),
    write_data => slave_write_data(2),
    iobus_ready => slave_ready(2)
  );

  --gbe_stream_wren(0) <= fmc_card0_stream_wren;
  --gbe_stream_strobe(0) <= fmc_card0_stream_strobe;
  --gbe_stream_data(0) <= fmc_card0_stream_data(0);

  --gbe_stream_wren(1) <= fmc_card1_stream_wren;
  --gbe_stream_strobe(1) <= fmc_card1_stream_strobe;
  --gbe_stream_data(1) <= fmc_card1_stream_data(0);
    
  bco_counter_card1 <= bco_counter;

  fmc228_card1_imp : fmc228card1_interface
  port map (
    u => fmc_led_card1,
    trig_in => amc_req2, --fmc_trig_in_card1,
    trig_out => open,

    clk20mhz => clk20mhz,
    bco => bco_counter,

    lmk_cs => lmk_cs_card1,
    lmk_sclk => lmk_sclk_card1,
    lmk_sdi => lmk_sdi_card1,
    lmk_sdo => lmk_sdo_card1,
    lmk_sdio_dir => lmk_sdio_dir_card1,
    lmk_reset => lmk_reset_card1,
    lmk_sync => lmk_sync_card1,
    lmk_sysref_req => lmk_sysref_req_card1,
    lmk_sync_dir => lmk_sync_dir_card1,
    lmk_clkoe => lmk_clkoe_card1,
    lmk_status_ld => lmk_status_ld_card1,

    hmc_chip_en => hmc_chip_en_card1,
    hmc_ldo => hmc_ldo_card1,
    hmc_sck => hmc_sck_card1,
    hmc_sdi => hmc_sdi_card1,
    hmc_sdo => hmc_sdo_card1,
    hmc_sen => hmc_sen_card1,
    adc_cs => adc_cs_card1,
    adc_sck => adc_sck_card1,
    adc_sdi => adc_sdi_card1,
    adc_sdo => adc_sdo_card1,
    adc_spi_dir => adc_spi_dir_card1,
    adc_pdwn => adc_pdwn_card1,
    adc_sync => adc_sync_card1,
    adc_fd => adc_fd_card1,

    gte_refclk => fmc_refclk_card1,
    sysref => fmc_sysref_card1,
    rx_p => fmc228_rx_p_card1,
    rx_n => fmc228_rx_n_card1,

    gbe_stream_clk => gbe_stream_clka,

    fmc_stream_wren =>  fmc_card1_stream_wren, --gbe_stream_wren(1),
    fmc_stream_strobe => fmc_card1_stream_strobe, --gbe_stream_strobe(1),
    fmc_stream_dout => fmc_card1_stream_data(0), --gbe_stream_data(1),

    oack => fmc_card1_ack,

    busclk => clk100mhz,
    iobus => slave_iobus(3),
    write_data => slave_write_data(3),
    iobus_ready => slave_ready(3)
  );


event_amc_imp : event_amc
  port map (
    clk => gbe_stream_clka,
    intrig => adc_trig,

    outreq1 => amc_req1,
    datain1 => fmc_card0_stream_data(0),
    inwr1 => fmc_card0_stream_wren,    
    done1 => fmc_card0_stream_strobe,
    inack1=> fmc_card0_ack,

    outreq2 => amc_req2,
    datain2 => fmc_card1_stream_data(0),
    done2 => fmc_card1_stream_strobe,
    inwr2 => fmc_card1_stream_wren,
    inack2=> fmc_card1_ack,

    wren => open, --gbe_stream_wren(0),
    dout => open, --gbe_stream_data(0),
    obusy => amc_busy,
    strobe => open --gbe_stream_strobe(0)
  );


  clk100mhz1_ibufds_gte2_inst : ibufds_gte2
  generic map (
    clkcm_cfg => true,
    clkrcv_trst => true,
    clkswing_cfg => "11"
  )
  port map (
    o => clk100mhz1_pre,
    odiv2 => open,
    ceb => '0',
    i => clk100mhz1_p,
    ib => clk100mhz1_n
  );

  clk100mhz1_bufg_inst : bufg
  port map (
    o => clk100mhz,
    i => clk100mhz1_pre
  );

  clk200mhz_bufg_inst : bufg
  port map (
    o => clk200mhz,
    i => clk200mhz_out
  );

  clk20mhz_bufg_inst : bufg
  port map (
    o => clk20mhz,
    i => clk20mhz_out
  );

  idelayctrl_imp : idelayctrl
  port map (
    rdy => open,
    refclk => clk200mhz,
    rst => idelay_rst
  );

  amc502_fpclka_ibufds : ibufds
  generic map (
    diff_term => true,
    ibuf_low_pwr => false,
    iostandard => "LVDS_25"
  )
  port map (
    i => amc502_fpclka_p,
    ib => amc502_fpclka_n,
    o => amc502_fpclka
  );
  fpclka_bufg : bufg
  port map (
    i => amc502_fpclka,
    o => fpclka
  );

  amc502_fpclkb_ibufds : ibufds
  generic map (
    diff_term => true,
    ibuf_low_pwr => false,
    iostandard => "LVDS_25"
  )
  port map (
    i => amc502_fpclkb_p,
    ib => amc502_fpclkb_n,
    o => amc502_fpclkb
  );
  fpclkb_bufg : bufg
  port map (
    i => amc502_fpclkb,
    o => fpclkb
  );

  amc502_fpclkc_ibufds : ibufds
  generic map (
    diff_term => true,
    ibuf_low_pwr => false,
    iostandard => "LVDS_25"
  )
  port map (
    i => amc502_fpclkc_p,
    ib => amc502_fpclkc_n,
    o => amc502_fpclkc
  );
  fpclkc_bufg : bufg
  port map (
    i => amc502_fpclkc,
    o => fpclkc
  );

  amc502_fpclkd_ibufds : ibufds
  generic map (
    diff_term => true,
    ibuf_low_pwr => false,
    iostandard => "LVDS_25"
  )
  port map (
    i => amc502_fpclkd_p,
    ib => amc502_fpclkd_n,
    o => amc502_fpclkd
  );
  fpclkd_bufg : bufg
  port map (
    i => amc502_fpclkd,
    o => fpclkd
  );

  amc502_fpclke_obufds : obufds
  generic map (
    iostandard => "LVDS_25"
  )
  port map (
    i => fpclke,
    o => amc502_fpclke_p,
    ob => amc502_fpclke_n
  );
  fpclke_bufg : bufg
  port map (
    i => clk10mhz_out,
    o => fpclke
  );

  amc502_fpclkf_ibufds : ibufds
  generic map (
    diff_term => true,
    ibuf_low_pwr => false,
    iostandard => "LVDS_25"
  )
  port map (
    i => amc502_fpclkf_p,
    ib => amc502_fpclkf_n,
    o => amc502_fpclkf
  );

  amc502_fpclkg_ibufds : ibufds
  generic map (
    diff_term => true,
    ibuf_low_pwr => false,
    iostandard => "LVDS_25"
  )
  port map (
    i => amc502_fpclkg_p,
    ib => amc502_fpclkg_n,
    o => amc502_fpclkg
  );
  fpclkg_bufg : bufg
  port map (
    i => amc502_fpclkg,
    o => fpclkg
  );

  amc502_fpclkh_obufds : obufds
  generic map (
    iostandard => "LVDS_25"
  )
  port map (
    i => amc502_fpclkh,
    o => amc502_fpclkh_p,
    ob => amc502_fpclkh_n
  );

  amc502_i2c_sda_l1_iobuf : iobuf
  generic map (
    drive => 12,
    slew => "slow"
  )
  port map (
    i => sda_l1_out,
    o => sda_l1_in,
    t => sda_l1_t,
    io => amc502_sda_l1
  );

  amc502_i2c_scl_l1_obuf : obuf
  generic map (
    drive => 12,
    slew => "slow"
  )
  port map (
    i => scl_l1,
    o => amc502_scl_l1
  );

  amc502_i2c_sda_llx_iobuf : iobuf
  generic map (
    drive => 12,
    slew => "slow"
  )
  port map (
    i => sda_lllx_out,
    o => sda_lllx_in,
    t => sda_lllx_t,
    io => amc502_sda_lllx
  );

  amc502_i2c_scl_llx_iobuf : ibuf
  port map (
    i => amc502_scl_lllx,
    o => scl_lllx
  );

  uart_txd_obuf : obuf
  port map (
    i => uart_txd,
    o => fpga_tx_uart
  );

  uart_rxd_obuf : ibuf
  port map (
    i => fpga_rx_uart,
    o => uart_rxd
  );

-- FMC228 signal interfaces

  --g_fmc_uled : for i in 0 to 2 generate
  --  fmc_uled_obuf : obuf
  --  port map (
  --    i => fmc_led(i),
  --    o => fmc228_uled(i)
  --  );
  --end generate;

--test led with trig in card0
   fmc_uled_obuf_0 : obuf
     port map (
       i => fmc_led(0),
       o => fmc228_uled(0)
    );
   fmc_uled_obuf_1 : obuf
      port map (
        i => fmc_led(1),
        o => fmc228_uled(1)
     );

   fmc_uled_obuf_2 : obuf
      port map (
        i => test_led,
        o => fmc228_uled(2)
     );

    test_led <= not fmc_trig_in;     

  process ( gbe_stream_clka ) begin
     if ( gbe_stream_clka'event and gbe_stream_clka = '1' ) then
        if ( fmc_trig_in = '1'  or self_trig_card0 = '1') then
             adc_trig <= '1';
        else
             adc_trig <= '0';
        end if;
      end if;
    end process;
--end test



  dclkout0_gtbclk0_inst : ibufds_gte2
  generic map (
    clkcm_cfg => true,
    clkrcv_trst => true,
    clkswing_cfg => "11"
  )
  port map (
    o => fmc_dclkout0,
    odiv2 => open,
    ceb => '0',
    i => fmc228_dclkout0_p,
    ib => fmc228_dclkout0_n
  );
  fmc_refclk <= fmc_dclkout0;

  dclkout2_gtbclk0_inst : ibufds_gte2
  generic map (
    clkcm_cfg => true,
    clkrcv_trst => true,
    clkswing_cfg => "11"
  )
  port map (
    o => fmc_dclkout2,
    odiv2 => open,
    ceb => '0',
    i => fmc228_dclkout2_p,
    ib => fmc228_dclkout2_n
  );

  sysref11_ibufds_imp : ibufds
  generic map (
    diff_term => true,
    ibuf_low_pwr => false,
    iostandard => "LVDS_25"
  )
  port map (
    i => fmc228_sysref11_p,
    ib => fmc228_sysref11_n,
    o => fmc_sysref11
  );

  sysref13_ibufds_imp : ibufds
  generic map (
    diff_term => true,
    ibuf_low_pwr => false,
    iostandard => "LVDS_25"
  )
  port map (
    i => fmc228_sysref13_p,
    ib => fmc228_sysref13_n,
    o => fmc_sysref13
  );

  dclkout10_ibufds_imp : ibufds
  generic map (
    diff_term => true,
    ibuf_low_pwr => false,
    iostandard => "LVDS_25"
  )
  port map (
    i => fmc228_dclkout10_p,
    ib => fmc228_dclkout10_n,
    o => fmc_dclkout10
  );

  dclkout12_ibufds_imp : ibufds
  generic map (
    diff_term => true,
    ibuf_low_pwr => false,
    iostandard => "LVDS_25"
  )
  port map (
    i => fmc228_dclkout12_p,
    ib => fmc228_dclkout12_n,
    o => fmc_dclkout12
  );

  fmc_adc0_sync_obufds : obufds
  generic map (
    iostandard => "LVDS_25"
  )
  port map (
    i => adc_sync(0),
    o => fmc228_adc_sync_p(0),
    ob => fmc228_adc_sync_n(0)
  );

  fmc_adc1_sync_obufds : obufds
  generic map (
    iostandard => "LVDS_25"
  )
  port map (
    i => adc_sync(1),
    o => fmc228_adc_sync_p(1),
    ob => fmc228_adc_sync_n(1)
  );

  fmc_trig_in_ibufds : ibufds
  port map (
    i => fmc228_trig_in_p,
   ib => fmc228_trig_in_n,
    o => fmc_trig_in
  );

  fmc_trig_out_obufds : obufds
  port map (
    o => fmc228_trig_out_p,
    ob => fmc228_trig_out_n,
    i => fmc_trig_out
  );
  fmc_trig_out <= fpclkg;  -- Allows monitoring of encoded clock

  fmc_lmk_sdio_buf : iobuf
  generic map (
    drive => 12,
    slew => "slow"
  )
  port map (
    i => lmk_sdi,
    o => lmk_sdo,
    io => fmc228_lmk_sdio,
    t => lmk_sdio_t
  );
  lmk_sdio_t <= not lmk_sdio_dir;

  fmc_lmk_cs_obuf : obuf
  generic map (
    drive => 12,
    slew => "slow"
  )
  port map (
    i => lmk_cs,
    o => fmc228_lmk_cs
  );

  fmc_lmk_sclk_obuf : obuf
  generic map (
    drive => 12,
    slew => "slow"
  )
  port map (
    i => lmk_sclk,
    o => fmc228_lmk_sclk
  );

  fmc_lmk_sdir_obuf : obuf
  generic map (
    drive => 12,
    slew => "slow"
  )
  port map (
    i => lmk_sdio_dir,
    o => fmc228_lmk_sdio_dir
  );

  fmc_lmk_reset_obuf : obuf
  generic map (
    drive => 12,
    slew => "slow"
  )
  port map (
    i => lmk_reset,
    o => fmc228_lmk_reset
  );

  fmc_lmk_clkoe_obuf : obuf
  generic map (
    drive => 12,
    slew => "slow"
  )
  port map (
    i => lmk_clkoe,
    o => fmc228_lmk_clkoe
  );

  fmc_lmk_sync_iobuf : iobuf
  port map (
    i => lmk_sync,
    o => lmk_sysref_req,
    io => fmc228_lmk_sync,
    t => lmk_sync_dir_t
  );
  lmk_sync_dir_t <= not lmk_sync_dir;

  fmc_lmk_sync_dir_obuf : obuf
  generic map (
    drive => 12,
    slew => "slow"
  )
  port map (
    i => lmk_sync_dir,
    o => fmc228_lmk_sync_dir
  );

  fmc_lmk_status_ibuf_0 : ibuf
  port map (
    i => fmc228_lmk_status_ld(0),
    o => lmk_status_ld(0)
  );

  fmc_lmk_status_ibuf_1 : ibuf
  port map (
    i => fmc228_lmk_status_ld(1),
    o => lmk_status_ld(1)
  );

  fmc_hmc_chip_en_obuf : obuf
  port map (
    i => hmc_chip_en,
    o => fmc228_hmc_chip_en
  );

  fmc_hmc_ldo_ibuf : ibuf
  port map (
    i => fmc228_hmc_ldo,
    o => hmc_ldo
  );

  fmc_hmc_sck_obuf : obuf
  generic map (
    drive => 12,
    slew => "slow"
  )
  port map (
    i => hmc_sck,
    o => fmc228_hmc_sck
  );

  fmc_hmc_sdi_obuf : obuf
  generic map (
    drive => 12,
    slew => "slow"
  )
  port map (
    i => hmc_sdi,
    o => fmc228_hmc_sdi
  );

  fmc_hmc_sdo_ibuf : ibuf
  port map (
    i => fmc228_hmc_sdo,
    o => hmc_sdo
  );

  fmc_hmc_sen_obuf : obuf
  generic map (
    drive => 12,
    slew => "slow"
  )
  port map (
    i => hmc_sen,
    o => fmc228_hmc_sen
  );

  g_adc : for i in 0 to 1 generate
    adc_cs_obuf : obuf
    generic map (
      drive => 12,
      slew => "slow"
    )
    port map (
      i => adc_cs(i),
      o => fmc228_adc_cs(i)
    );

    adc_sck_obuf : obuf
    generic map (
      drive => 12,
      slew => "slow"
    )
    port map (
      i => adc_sck(i),
      o => fmc228_adc_sck(i)
    );

    adc_pdwn_obuf : obuf
    generic map (
      drive => 12,
      slew => "slow"
    )
    port map (
      i => adc_pdwn(i),
      o => fmc228_adc_pdwn(i)
    );

    adc_spi_dir_obuf : obuf
    generic map (
      drive => 12,
      slew => "slow"
    )
    port map (
      i => adc_spi_dir(i),
      o => fmc228_adc_spi_dir(i)
    );

    adc_sdio_iobuf : iobuf
    generic map (
      drive => 12,
      slew => "slow"
    )
    port map (
      i => adc_sdi(i),
      o => adc_sdo(i),
      io => fmc228_adc_sdio(i),
      t => adc_spi_dir_t(i)
    );
    adc_spi_dir_t(i) <= not adc_spi_dir(i);

  end generate;

  g_fmc_adc_fd : for i in 0 to 3 generate
    fmc_adc_fd_ibuf : ibuf
    port map (
      i => fmc228_adc_fd(i),
      o => adc_fd(i)
    );
  end generate;

 --fmc228 card1 signal interface 
 
  -- g_fmc_uled_card1 : for i in 0 to 2 generate
  --   fmc_uled_obuf_card1 : obuf
  --   port map (
  --     i => fmc_led_card1(i),
  --     o => fmc228_uled_card1(i)
  --   );
  -- end generate;

--test led with trig in card1
     fmc_uled_obuf_card1_0 : obuf
       port map (
         i => fmc_led_card1(0),
         o => fmc228_uled_card1(0)
      );
     fmc_uled_obuf_card1_1 : obuf
        port map (
          i => fmc_led_card1(1),
          o => fmc228_uled_card1(1)
       );
  
     fmc_uled_obuf_card1_2 : obuf
        port map (
          i => test_led_card1,
          o => fmc228_uled_card1(2)
       );
  
      test_led_card1 <= fmc_trig_in_card1;     
  
  --  process ( clk20mhz ) begin
  --     if ( clk20mhz'event and clk20mhz = '1' ) then
  --        if ( fmc_trig_in = '1' ) then
  --             test_led <= '1';
  --        else
  --             test_led <= '0';
  --        end if;
  --      end if;
  --    end process;
  --end test 
 
 
   dclkout0_gtbclk0_inst_card1 : ibufds_gte2
   generic map (
     clkcm_cfg => true,
     clkrcv_trst => true,
     clkswing_cfg => "11"
   )
   port map (
     o => fmc_dclkout0_card1,
     odiv2 => open,
     ceb => '0',
     i => fmc228_dclkout0_p_card1,
     ib => fmc228_dclkout0_n_card1
   );
   fmc_refclk_card1 <= fmc_dclkout0_card1;
 
   dclkout2_gtbclk0_inst_card1 : ibufds_gte2
   generic map (
     clkcm_cfg => true,
     clkrcv_trst => true,
     clkswing_cfg => "11"
   )
   port map (
     o => fmc_dclkout2_card1,
     odiv2 => open,
     ceb => '0',
     i => fmc228_dclkout2_p_card1,
     ib => fmc228_dclkout2_n_card1
   );
 
   sysref11_ibufds_imp_card1 : ibufds
   generic map (
     diff_term => true,
     ibuf_low_pwr => false,
     iostandard => "LVDS_25"
   )
   port map (
     i => fmc228_sysref11_p_card1,
     ib => fmc228_sysref11_n_card1,
     o => fmc_sysref11_card1
   );
 
   sysref13_ibufds_imp_card1 : ibufds
   generic map (
     diff_term => true,
     ibuf_low_pwr => false,
     iostandard => "LVDS_25"
   )
   port map (
     i => fmc228_sysref13_p_card1,
     ib => fmc228_sysref13_n_card1,
     o => fmc_sysref13_card1
   );
 
   dclkout10_ibufds_imp_card1 : ibufds
   generic map (
     diff_term => true,
     ibuf_low_pwr => false,
     iostandard => "LVDS_25"
   )
   port map (
     i => fmc228_dclkout10_p_card1,
     ib => fmc228_dclkout10_n_card1,
     o => fmc_dclkout10_card1
   );
 
   dclkout12_ibufds_imp_card1 : ibufds
   generic map (
     diff_term => true,
     ibuf_low_pwr => false,
     iostandard => "LVDS_25"
   )
   port map (
     i => fmc228_dclkout12_p_card1,
     ib => fmc228_dclkout12_n_card1,
     o => fmc_dclkout12_card1
   );
 
   fmc_adc0_sync_obufds_card1 : obufds
   generic map (
     iostandard => "LVDS_25"
   )
   port map (
     i => adc_sync_card1(0),
     o => fmc228_adc_sync_p_card1(0),
     ob => fmc228_adc_sync_n_card1(0)
   );
 
   fmc_adc1_sync_obufds_card1 : obufds
   generic map (
     iostandard => "LVDS_25"
   )
   port map (
     i => adc_sync_card1(1),
     o => fmc228_adc_sync_p_card1(1),
     ob => fmc228_adc_sync_n_card1(1)
   );
 
   fmc_trig_in_ibufds_card1 : ibufds
   port map (
     i => fmc228_trig_in_p_card1,
     ib => fmc228_trig_in_n_card1,
     o => fmc_trig_in_card1
   );
 
   fmc_trig_out_obufds_card1 : obufds
   port map (
     o => fmc228_trig_out_p_card1,
     ob => fmc228_trig_out_n_card1,
     i => fmc_trig_out_card1
   );
   --fmc_trig_out_card1 <= fpclkg_card1;  -- Allows monitoring of encoded clock
 
   fmc_lmk_sdio_buf_card1 : iobuf
   generic map (
     drive => 12,
     slew => "slow"
   )
   port map (
     i => lmk_sdi_card1,
     o => lmk_sdo_card1,
     io => fmc228_lmk_sdio_card1,
     t => lmk_sdio_t_card1
   );
   lmk_sdio_t_card1 <= not lmk_sdio_dir_card1;
 
   fmc_lmk_cs_obuf_card1 : obuf
   generic map (
     drive => 12,
     slew => "slow"
   )
   port map (
     i => lmk_cs_card1,
     o => fmc228_lmk_cs_card1
   );
 
   fmc_lmk_sclk_obuf_card1 : obuf
   generic map (
     drive => 12,
     slew => "slow"
   )
   port map (
     i => lmk_sclk_card1,
     o => fmc228_lmk_sclk_card1
   );
 
   fmc_lmk_sdir_obuf_card1 : obuf
   generic map (
     drive => 12,
     slew => "slow"
   )
   port map (
     i => lmk_sdio_dir_card1,
     o => fmc228_lmk_sdio_dir_card1
   );
 
   fmc_lmk_reset_obuf_card1 : obuf
   generic map (
     drive => 12,
     slew => "slow"
   )
   port map (
     i => lmk_reset_card1,
     o => fmc228_lmk_reset_card1
   );
 
   fmc_lmk_clkoe_obuf_card1 : obuf
   generic map (
     drive => 12,
     slew => "slow"
   )
   port map (
     i => lmk_clkoe_card1,
     o => fmc228_lmk_clkoe_card1
   );
 
   fmc_lmk_sync_iobuf_card1 : iobuf
   port map (
     i => lmk_sync_card1,
     o => lmk_sysref_req_card1,
     io => fmc228_lmk_sync_card1,
     t => lmk_sync_dir_t_card1
   );
   lmk_sync_dir_t_card1 <= not lmk_sync_dir_card1;
 
   fmc_lmk_sync_dir_obuf_card1 : obuf
   generic map (
     drive => 12,
     slew => "slow"
   )
   port map (
     i => lmk_sync_dir_card1,
     o => fmc228_lmk_sync_dir_card1
   );
 
   fmc_lmk_status_ibuf_0_card1 : ibuf
   port map (
     i => fmc228_lmk_status_ld_card1(0),
     o => lmk_status_ld_card1(0)
   );
 
   fmc_lmk_status_ibuf_1_card1 : ibuf
   port map (
     i => fmc228_lmk_status_ld_card1(1),
     o => lmk_status_ld_card1(1)
   );
 
   fmc_hmc_chip_en_obuf_card1 : obuf
   port map (
     i => hmc_chip_en_card1,
     o => fmc228_hmc_chip_en_card1
   );
 
   fmc_hmc_ldo_ibuf_card1 : ibuf
   port map (
     i => fmc228_hmc_ldo_card1,
     o => hmc_ldo_card1
   );
 
   fmc_hmc_sck_obuf_card1 : obuf
   generic map (
     drive => 12,
     slew => "slow"
   )
   port map (
     i => hmc_sck_card1,
     o => fmc228_hmc_sck_card1
   );
 
   fmc_hmc_sdi_obuf_card1 : obuf
   generic map (
     drive => 12,
     slew => "slow"
   )
   port map (
     i => hmc_sdi_card1,
     o => fmc228_hmc_sdi_card1
   );
 
   fmc_hmc_sdo_ibuf_card1 : ibuf
   port map (
     i => fmc228_hmc_sdo_card1,
     o => hmc_sdo_card1
   );
 
   fmc_hmc_sen_obuf_card1 : obuf
   generic map (
     drive => 12,
     slew => "slow"
   )
   port map (
     i => hmc_sen_card1,
     o => fmc228_hmc_sen_card1
   );
 
   g_adc_card1 : for i in 0 to 1 generate
     adc_cs_obuf_card1 : obuf
     generic map (
       drive => 12,
       slew => "slow"
     )
     port map (
       i => adc_cs_card1(i),
       o => fmc228_adc_cs_card1(i)
     );
 
     adc_sck_obuf_card1 : obuf
     generic map (
       drive => 12,
       slew => "slow"
     )
     port map (
       i => adc_sck_card1(i),
       o => fmc228_adc_sck_card1(i)
     );
 
     adc_pdwn_obuf_card1 : obuf
     generic map (
       drive => 12,
       slew => "slow"
     )
     port map (
       i => adc_pdwn_card1(i),
       o => fmc228_adc_pdwn_card1(i)
     );
 
     adc_spi_dir_obuf_card1 : obuf
     generic map (
       drive => 12,
       slew => "slow"
     )
     port map (
       i => adc_spi_dir_card1(i),
       o => fmc228_adc_spi_dir_card1(i)
     );
 
     adc_sdio_iobuf_card1 : iobuf
     generic map (
       drive => 12,
       slew => "slow"
     )
     port map (
       i => adc_sdi_card1(i),
       o => adc_sdo_card1(i),
       io => fmc228_adc_sdio_card1(i),
       t => adc_spi_dir_t_card1(i)
     );
     adc_spi_dir_t_card1(i) <= not adc_spi_dir_card1(i);
 
   end generate;
 
   g_fmc_adc_fd_card1 : for i in 0 to 3 generate
     fmc_adc_fd_ibuf_card1 : ibuf
     port map (
       i => fmc228_adc_fd_card1(i),
       o => adc_fd_card1(i)
     );
   end generate;
 -- end fmc228 card1 signal interface


  process ( clk20mhz ) begin
    if ( clk20mhz'event and clk20mhz = '1' ) then
      idelay_rst_pipe <= idelay_rst_pipe(idelay_rst_pipe'left-1 downto 0) &
                         mmcm_locked;
    end if;
  end process;
  idelay_rst <= not idelay_rst_pipe(idelay_rst_pipe'left);

  process ( clk100mhz ) begin
    if ( clk100mhz'event and clk100mhz = '1' ) then
      if ( count = x"01c9c380" ) then
        count <= ( others => '0' );
        case state is
        when state1 =>
          state <= state2;
        when state2 => 
          state <= state3;
        when state3 => 
          state <= state4;
        when state4 => 
          state <= state5;
        when state5 => 
          state <= state6;
        when state6 => 
          state <= state1;
        end case;
      else
        count <= count + 1;
      end if;
    end if;
  end process;

  amc502_clocks <= ( 0 => clk100mhz,
                     1 => gmii_rxclk,
                     2 => fmc_dclkout0,
                     3 => fmc_dclkout2,
                     4 => fmc_dclkout10,
                     5 => fmc_dclkout12,
                     6 => fmc_sysref11,
                     7 => fmc_sysref13,
                     others => '0' );


  nuled <= "1110" when state = state1 else
           "1101" when state = state2 else
           "1011" when state = state3 else
           "0111" when state = state4 else
           "1011" when state = state5 else
           "1101" when state = state6 else "0000";

end behavioral;
