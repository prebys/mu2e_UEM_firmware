--------------------------------------------------------------------------------
--
-- Company:
-- Engineer:       Matthew Jones - Purdue University
-- 
-- Create Date:    13:44:37 07/11/2016 
-- Design Name:    amc502
-- Module Name:    jesd204_adc - RTL
-- Project Name:   amc502 firmware
-- Target Devices: xc7k420tffv1156-1
-- Tool versions:  Vivado 2016.1
-- Description:    JESD204 interface to ADC
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity jesd204_adc is
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
--    addr_strobe : in std_logic;
--    read_strobe : in std_logic;
--    write_strobe : in std_logic;
--    address : in std_logic_vector(11 downto 0);
--    byte_enable : in std_logic_vector(3 downto 0);
--    write_data : in std_logic_vector(31 downto 0);
--    read_data : out std_logic_vector(31 downto 0);
--    io_ready : out std_logic
  );
end jesd204_adc;

architecture RTL of jesd204_adc is

  component jesd204_phy_1
  port (
    tx_sys_reset : in STD_LOGIC;
    rx_sys_reset : in STD_LOGIC;
    tx_reset_gt : in STD_LOGIC;
    rx_reset_gt : in STD_LOGIC;
    tx_reset_done : out STD_LOGIC;
    rx_reset_done : out STD_LOGIC;
    qpll_refclk : in STD_LOGIC;
    common0_qpll_lock_out : out STD_LOGIC;
    common0_qpll_refclk_out : out STD_LOGIC;
    common0_qpll_clk_out : out STD_LOGIC;
    rxencommaalign : in STD_LOGIC;
    tx_core_clk : in STD_LOGIC;
    txoutclk : out STD_LOGIC;
    rx_core_clk : in STD_LOGIC;
    rxoutclk : out STD_LOGIC;
    drpclk : in STD_LOGIC;
    gt_prbssel : in STD_LOGIC_VECTOR ( 2 downto 0 );
    gt0_txdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    gt0_txcharisk : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gt1_txdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    gt1_txcharisk : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gt2_txdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    gt2_txcharisk : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gt3_txdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    gt3_txcharisk : in STD_LOGIC_VECTOR ( 3 downto 0 );
    gt0_rxdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gt0_rxcharisk : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt0_rxdisperr : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt0_rxnotintable : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt1_rxdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gt1_rxcharisk : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt1_rxdisperr : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt1_rxnotintable : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt2_rxdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gt2_rxcharisk : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt2_rxdisperr : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt2_rxnotintable : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt3_rxdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    gt3_rxcharisk : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt3_rxdisperr : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gt3_rxnotintable : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rxn_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rxp_in : in STD_LOGIC_VECTOR ( 3 downto 0 );
    txn_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    txp_out : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  end component;

  component ilas
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
  end component;

  signal reset_pipe : std_logic_vector(7 downto 0) := "00000000";

  signal rxcommaalign : std_logic;
  signal rx_comma_align : std_logic_vector(3 downto 0);
  signal rx_reset_done : std_logic;
  signal rx_reset_gt : std_logic;
  signal rx_sys_reset : std_logic;
  type gt_rxdata_t is array(3 downto 0) of std_logic_vector(31 downto 0);
  signal gt_rxdata : gt_rxdata_t;
  type gt_rxcharisk_t is array(3 downto 0) of std_logic_vector(3 downto 0);
  signal gt_rxcharisk : gt_rxcharisk_t;
  type gt_rxdisperr_t is array(3 downto 0) of std_logic_vector(3 downto 0);
  signal gt_rxdisperr : gt_rxdisperr_t;
  type gt_rxnotintable_t is array(3 downto 0) of std_logic_vector(3 downto 0);
  signal gt_rxnotintable : gt_rxnotintable_t;
  signal rxdata_out : gt_rxdata_t;
  signal rxcharisk_out : gt_rxcharisk_t;

  signal hold : std_logic := '0';
  signal cgs : std_logic_vector(3 downto 0);
  signal align : std_logic_vector(3 downto 0);
  type align_array_t is array(3 downto 0) of std_logic_vector(1 downto 0);
  signal lane_align : align_array_t;
  type offset_array_t is array(3 downto 0) of std_logic_vector(5 downto 0);
  signal lane_offset : offset_array_t;
  signal sync_busy : std_logic_vector(3 downto 0);
  signal user_data : std_logic_vector(3 downto 0);

begin

  jesd204_phy_imp : jesd204_phy_1
  port map (
    rx_sys_reset => rx_sys_reset,
    tx_sys_reset => '0',
    rx_reset_gt => rx_reset_gt,
    tx_reset_gt => '0',
    rx_reset_done => rx_reset_done,
    qpll_refclk => refclk,
    common0_qpll_lock_out => qpll_lock,
    common0_qpll_refclk_out => open,
    common0_qpll_clk_out => open,
    rxencommaalign => rxcommaalign,
    rx_core_clk => core_clk,
    tx_core_clk => core_clk,
    rxoutclk => open,
    drpclk => clk,
    gt_prbssel => "000",
    gt0_rxdata => gt_rxdata(0),
    gt0_rxcharisk => gt_rxcharisk(0),
    gt0_rxdisperr => gt_rxdisperr(0),
    gt0_rxnotintable => gt_rxnotintable(0),
    gt1_rxdata => gt_rxdata(1),
    gt1_rxcharisk => gt_rxcharisk(1),
    gt1_rxdisperr => gt_rxdisperr(1),
    gt1_rxnotintable => gt_rxnotintable(1),
    gt2_rxdata => gt_rxdata(2),
    gt2_rxcharisk => gt_rxcharisk(2),
    gt2_rxdisperr => gt_rxdisperr(2),
    gt2_rxnotintable => gt_rxnotintable(2),
    gt3_rxdata => gt_rxdata(3),
    gt3_rxcharisk => gt_rxcharisk(3),
    gt3_rxdisperr => gt_rxdisperr(3),
    gt3_rxnotintable => gt_rxnotintable(3),
    gt0_txdata => ( others => '0' ),
    gt0_txcharisk => "0000",
    gt1_txdata => ( others => '0' ),
    gt1_txcharisk => "0000",
    gt2_txdata => ( others => '0' ),
    gt2_txcharisk => "0000",
    gt3_txdata => ( others => '0' ),
    gt3_txcharisk => "0000",
    rxn_in => rxn_in(3 downto 0),
    rxp_in => rxp_in(3 downto 0)
  );

  g_ilas: for i in 0 to 3 generate
    ilas_imp : ilas
    port map (
      clk => core_clk,
      data_in => gt_rxdata(i),
      charisk_in => gt_rxcharisk(i),
      sync => align_cgs,
      scram_en => enable_descrambler,
      busy => sync_busy(i),
      rxcommaalign => rx_comma_align(i),
      hold => hold,
      cgs => cgs(i),
      align => align(i),
      lane_align => lane_align(i),
      lane_offset => lane_offset(i),
      data_out => rxdata_out(i),
      charisk_out => rxcharisk_out(i),
      user_data => user_data(i)
    );
  end generate;

  adc_data_a <= rxdata_out(0)(31 downto 24) & rxdata_out(1)(31 downto 24) &
                rxdata_out(0)(23 downto 16) & rxdata_out(1)(23 downto 16) &
                rxdata_out(0)(15 downto 8) & rxdata_out(1)(15 downto 8) &
                rxdata_out(0)(7 downto 0) & rxdata_out(1)(7 downto 0);
  adc_data_b <= rxdata_out(2)(31 downto 24) & rxdata_out(3)(31 downto 24) &
                rxdata_out(2)(23 downto 16) & rxdata_out(3)(23 downto 16) &
                rxdata_out(2)(15 downto 8) & rxdata_out(3)(15 downto 8) &
                rxdata_out(2)(7 downto 0) & rxdata_out(3)(7 downto 0);

  process ( clk ) begin
    if ( clk'event and clk = '1' ) then

      if ( reset = '1' ) then
        reset_pipe <= ( 7 => '1', others => '0' );
        adc_dv <= '0';
      else
        reset_pipe <= '0' & reset_pipe(7 downto 1);
        if ( user_data = "1111" ) then
          adc_dv <= '1';
        else
          adc_dv <= '0';
        end if;
      end if;

    end if;
  end process;

  hold <= '0' when align = "1111" else '1';
  align_busy <= '0' when sync_busy = "0000" else '1';
  rxcommaalign <= '0' when rx_comma_align = "0000" else '1';
  sync <= not rxcommaalign;

  rx_sys_reset <= reset_pipe(0);
  rx_reset_gt <= reset_pipe(7);
  lane_sync <= lane_offset(3) & lane_align(3) & lane_offset(2) & lane_align(2) &
               lane_offset(1) & lane_align(1) & lane_offset(0) & lane_align(0);

end RTL;
