--------------------------------------------------------------------------------
--
-- Company:
-- Engineer:       Matthew Jones - Purdue University
-- 
-- Create Date:    10:56:38 06/14/2016 
-- Design Name:    amc502
-- Module Name:    link_interface - RTL
-- Project Name:   AMC502 firmware
-- Target Devices: xc7k420tffv1156-1
-- Tool versions:  Vivado 2016.1
-- Description:    Slave interface to the GTX links
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
use hep337dev.iobus.all;
use hep337dev.link.all;

entity link_interface is
  port (
    rxd2_p : in std_logic;
    rxd2_n : in std_logic;
    txd2_p : out std_logic;
    txd2_n : out std_logic;
    rxd3_p : in std_logic;
    rxd3_n : in std_logic;
    txd3_p : out std_logic;
    txd3_n : out std_logic;
    refclk_p : in std_logic;
    refclk_n : in std_logic;
    bcoclk : in std_logic;
    bco : in std_logic_vector(47 downto 0);
    trigger_input : in std_logic_vector(3 downto 0);
    trigger_output : out std_logic;
    trig : out std_logic;
    busclk : in std_logic;
    iobus : in iobus_t;
    write_data : out std_logic_vector(31 downto 0);
    iobus_ready : out std_logic
  );
end link_interface;

architecture RTL of link_interface is

  component gtwizard_0
  port (
    SOFT_RESET_TX_IN : in STD_LOGIC;
    SOFT_RESET_RX_IN : in STD_LOGIC;
    DONT_RESET_ON_DATA_ERROR_IN : in STD_LOGIC;
    Q1_CLK0_GTREFCLK_PAD_N_IN : in STD_LOGIC;
    Q1_CLK0_GTREFCLK_PAD_P_IN : in STD_LOGIC;
    GT0_TX_FSM_RESET_DONE_OUT : out STD_LOGIC;
    GT0_RX_FSM_RESET_DONE_OUT : out STD_LOGIC;
    GT0_DATA_VALID_IN : in STD_LOGIC;
    GT0_TXUSRCLK_OUT : out STD_LOGIC;
    GT0_TXUSRCLK2_OUT : out STD_LOGIC;
    GT0_RXUSRCLK_OUT : out STD_LOGIC;
    GT0_RXUSRCLK2_OUT : out STD_LOGIC;
    gt0_cpllfbclklost_out : out STD_LOGIC;
    gt0_cplllock_out : out STD_LOGIC;
    gt0_cpllreset_in : in STD_LOGIC;
    gt0_drpaddr_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    gt0_drpdi_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    gt0_drpdo_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    gt0_drpen_in : in STD_LOGIC;
    gt0_drprdy_out : out STD_LOGIC;
    gt0_drpwe_in : in STD_LOGIC;
    gt0_dmonitorout_out : out STD_LOGIC_VECTOR ( 7 downto 0 );
    gt0_eyescanreset_in : in STD_LOGIC;
    gt0_rxuserrdy_in : in STD_LOGIC;
    gt0_eyescandataerror_out : out STD_LOGIC;
    gt0_eyescantrigger_in : in STD_LOGIC;
    gt0_rxdata_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    gt0_rxdisperr_out : out STD_LOGIC_VECTOR ( 1 downto 0 );
    gt0_rxnotintable_out : out STD_LOGIC_VECTOR ( 1 downto 0 );
    gt0_gtxrxp_in : in STD_LOGIC;
    gt0_gtxrxn_in : in STD_LOGIC;
    gt0_rxbyteisaligned_out : out STD_LOGIC;
    gt0_rxdfelpmreset_in : in STD_LOGIC;
    gt0_rxmonitorout_out : out STD_LOGIC_VECTOR ( 6 downto 0 );
    gt0_rxmonitorsel_in : in STD_LOGIC_VECTOR ( 1 downto 0 );
    gt0_rxoutclkfabric_out : out STD_LOGIC;
    gt0_gtrxreset_in : in STD_LOGIC;
    gt0_rxpmareset_in : in STD_LOGIC;
    gt0_rxcharisk_out : out STD_LOGIC_VECTOR ( 1 downto 0 );
    gt0_rxresetdone_out : out STD_LOGIC;
    gt0_gttxreset_in : in STD_LOGIC;
    gt0_txuserrdy_in : in STD_LOGIC;
    gt0_txdata_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    gt0_gtxtxn_out : out STD_LOGIC;
    gt0_gtxtxp_out : out STD_LOGIC;
    gt0_txoutclkfabric_out : out STD_LOGIC;
    gt0_txoutclkpcs_out : out STD_LOGIC;
    gt0_txcharisk_in : in STD_LOGIC_VECTOR ( 1 downto 0 );
    gt0_txresetdone_out : out STD_LOGIC;
    GT0_QPLLOUTCLK_OUT : out STD_LOGIC;
    GT0_QPLLOUTREFCLK_OUT : out STD_LOGIC;
    sysclk_in : in STD_LOGIC
  );
  end component;

  component trigger_pipeline
  port (
    rst : in std_logic;
    clk_a : in std_logic;
    en_a : in std_logic;
    bco_a : in std_logic_vector(15 downto 0);
    data_a : in std_logic_vector(15 downto 0);
    bcoclk : in std_logic;
    bco : in std_logic_vector(47 downto 0);
    bco_b : out std_logic_vector(15 downto 0);
    data_b : out std_logic_vector(15 downto 0)
  );
  end component;

  constant base_address : std_logic_vector(15 downto 0) := x"c200";
  constant address_mask : std_logic_vector(15 downto 0) := x"ffff";

  constant address_link_csr : std_logic_vector(15 downto 0) := x"0000";
  constant address_gt0_txrx : std_logic_vector(15 downto 0) := x"0004";
  constant address_gt0_drp : std_logic_vector(15 downto 0) := x"0008";

  signal latched_data : std_logic_vector(31 downto 0);
  signal masked_address : std_logic_vector(15 downto 0);

  signal link_csr : std_logic_vector(31 downto 0);
  signal gt0_txrx : std_logic_vector(31 downto 0);
  signal gt0_drp : std_logic_vector(31 downto 0);
  signal fsm_tx_reset_done : std_logic;
  signal fsm_rx_reset_done : std_logic;
  signal cpll_fbclklost : std_logic;
  signal cpll_lock : std_logic;
  signal rxdata : std_logic_vector(15 downto 0);
  signal gtx_tx_data : std_logic_vector(15 downto 0);
  signal rxdisperr : std_logic_vector(1 downto 0);
  signal rxnotintable : std_logic_vector(1 downto 0);
  signal gtx_rx_charisk : std_logic_vector(1 downto 0);
  signal gtx_rx_charisk_r : std_logic_vector(1 downto 0);
  signal gtx_tx_charisk : std_logic_vector(1 downto 0) := "00";
  signal rx_data_r : std_logic_vector(15 downto 0);
  signal gtx_rx_reset_done : std_logic;
  signal gtx_tx_reset_done : std_logic;
  signal gtx_rx_data : std_logic_vector(31 downto 0);
  signal rx_byte_aligned : std_logic;
  signal send_word : std_logic := '0';
  signal send_word_r : std_logic := '0';

  signal usrclk : std_logic;
  signal outclk : std_logic;
  type send_state_t is ( Idle, SendHigh, SendBco, Waiting );
  signal send_state : send_state_t := Idle;
  signal send_state_r : send_state_t := Idle;
  signal latched_bco : std_logic_vector(47 downto 0);
  signal latched_bcoclk : std_logic_vector(1 downto 0);
  signal streaming_triggers : std_logic;

  signal link_ena : std_logic;
  signal link_bco : std_logic_vector(15 downto 0);
  signal link_data : std_logic_vector(15 downto 0);
  signal bco_pipeline : std_logic_vector(15 downto 0);
  signal data_pipeline : std_logic_vector(15 downto 0);
  signal bco_output : std_logic_vector(15 downto 0);
  signal data_output : std_logic_vector(15 downto 0);

  attribute mark_debug : string;
  attribute mark_debug of gtx_rx_charisk_r : signal is "true";
  attribute mark_debug of rx_data_r : signal is "true";
  attribute mark_debug of send_state : signal is "true";
  attribute mark_debug of gtx_tx_data : signal is "true";
  attribute mark_debug of gtx_tx_charisk : signal is "true";

begin

  gt0_imp : gtwizard_0
  port map (
    SOFT_RESET_TX_IN => link_csr(27),
    SOFT_RESET_RX_IN => link_csr(26),
    DONT_RESET_ON_DATA_ERROR_IN => '1',
    Q1_CLK0_GTREFCLK_PAD_N_IN => refclk_n,
    Q1_CLK0_GTREFCLK_PAD_P_IN => refclk_p,
    GT0_TX_FSM_RESET_DONE_OUT => fsm_tx_reset_done,
    GT0_RX_FSM_RESET_DONE_OUT => fsm_rx_reset_done,
    GT0_DATA_VALID_IN => '1',

    GT0_TXUSRCLK_OUT => usrclk,
    GT0_TXUSRCLK2_OUT => open,
    GT0_RXUSRCLK_OUT => outclk,
    GT0_RXUSRCLK2_OUT => open,

    gt0_cpllfbclklost_out => cpll_fbclklost,
    gt0_cplllock_out => cpll_lock,
    gt0_cpllreset_in => link_csr(29),

    gt0_drpaddr_in => gt0_drp(24 downto 16),
    gt0_drpdi_in => gt0_drp(15 downto 0),
    gt0_drpdo_out => open,
    gt0_drpen_in => '0',
    gt0_drprdy_out => open,
    gt0_drpwe_in => '0',

    gt0_dmonitorout_out => open,
    gt0_eyescanreset_in => '0',
    gt0_eyescandataerror_out => open,
    gt0_eyescantrigger_in => '0',
    gt0_rxuserrdy_in => '1',
    gt0_rxdata_out => rxdata,
    gt0_rxdisperr_out => rxdisperr,
    gt0_rxnotintable_out => rxnotintable,
    gt0_gtxrxp_in => rxd2_p,
    gt0_gtxrxn_in => rxd2_n,
    gt0_rxbyteisaligned_out => rx_byte_aligned,

    gt0_rxdfelpmreset_in => link_csr(28),
    gt0_rxmonitorout_out => open,
    gt0_rxmonitorsel_in => "00",
    gt0_rxoutclkfabric_out => open,

    gt0_gtrxreset_in => link_csr(30),
    gt0_rxpmareset_in => link_csr(25),
    gt0_rxcharisk_out => gtx_rx_charisk,
    gt0_rxresetdone_out => gtx_rx_reset_done,

    gt0_gttxreset_in => link_csr(31),
    gt0_txuserrdy_in => '1',
    gt0_txdata_in => gtx_tx_data,
    gt0_gtxtxn_out => txd2_n,
    gt0_gtxtxp_out => txd2_p,

    gt0_txoutclkfabric_out => open,
    gt0_txoutclkpcs_out => open,
    gt0_txcharisk_in => gtx_tx_charisk,
    gt0_txresetdone_out => gtx_tx_reset_done,

    GT0_QPLLOUTCLK_OUT => open,
    GT0_QPLLOUTREFCLK_OUT => open, 

    sysclk_in => busclk
  );

  input_imp : trigger_pipeline
  port map (
    rst => link_csr(24),
    clk_a => bcoclk,
    en_a => '1',
    bco_a => bco(15 downto 0),
    data_a => "000000000000" & trigger_input,
    bcoclk => bcoclk,
    bco => bco,
    bco_b => bco_output,
    data_b => data_output
  );

  output_imp : trigger_pipeline
  port map (
    rst => link_csr(24),
    clk_a => outclk,
    en_a => link_ena,
    bco_a => link_bco,
    data_a => link_data,
    bcoclk => bcoclk,
    bco => bco,
    bco_b => bco_pipeline,
    data_b => data_pipeline
  );

  process ( outclk, bcoclk ) begin
    if ( outclk'event and outclk = '1' ) then
      gtx_rx_charisk_r <= gtx_rx_charisk;
      rx_data_r <= rxdata;
      link_ena <= '0';
      if ( gtx_rx_charisk = "00" ) then
        if ( gtx_rx_charisk_r = "00" ) then
          gtx_rx_data(15 downto 0) <= rxdata;
          link_bco <= rxdata;
          link_ena <= '1';
        else
          gtx_rx_data(31 downto 16) <= rxdata;
          link_data <= rxdata;
        end if;
      end if;
    end if;
  end process;

  process ( usrclk, bcoclk ) begin
    if ( usrclk'event and usrclk = '1' ) then
      send_word_r <= send_word;
      latched_bco <= bco;
      latched_bcoclk <= latched_bcoclk(0) & bcoclk;
      streaming_triggers <= link_csr(0);
      case send_state is
      when Idle =>
        if ( send_word_r = '1' ) then
          gtx_tx_data <= gt0_txrx(15 downto 0);
          gtx_tx_charisk <= "00";
          send_state <= SendHigh;
        elsif ( streaming_triggers = '1' and latched_bcoclk = "01" ) then
          gtx_tx_data <= "100000000000" & trigger_input;
          gtx_tx_charisk <= "00";
          send_state <= SendBco;
        else
          gtx_tx_data <= x"3cbc";
          gtx_tx_charisk <= "11";
          send_state <= Idle;
        end if;
      when SendBco =>
        gtx_tx_data <= '0' & latched_bco(14 downto 0);
        gtx_tx_charisk <= "00";
        send_state <= Idle;
      when SendHigh =>
        gtx_tx_data <= gt0_txrx(31 downto 16);
        gtx_tx_charisk <= "00";
        send_state <= Waiting;
      when Waiting =>
        gtx_tx_data <= x"3cbc";
        gtx_tx_charisk <= "11";
        if ( send_word_r = '0' ) then
          send_state <= Idle;
        end if;
      end case;
    end if;
  end process;

  process ( busclk ) begin
    if ( busclk'event and busclk= '1' ) then
      send_state_r <= send_state;
      if ( send_state_r = Waiting ) then
        send_word <= '0';
      end if;
      if ( iobus.io_addr_strobe = '1' and masked_address = base_address ) then
        iobus_ready <= '1';
        if ( iobus.io_write_strobe = '1' ) then
          case iobus.io_address(15 downto 0) is
            when address_link_csr =>
              link_csr <= iobus.io_write_data;
            when address_gt0_txrx =>
              gt0_txrx <= iobus.io_write_data;
              send_word <= '1';
            when address_gt0_drp =>
              gt0_drp <= iobus.io_write_data;
            when others =>
          end case;
        end if;

        if ( iobus.io_read_strobe = '1' ) then
          case iobus.io_address(15 downto 0) is
            when address_link_csr =>
              latched_data <= link_csr(31 downto 24) & 
                              gtx_tx_reset_done & gtx_rx_reset_done &
                              fsm_tx_reset_done & fsm_rx_reset_done &
                              rx_byte_aligned & "000" &
                              link_csr(15 downto 0);
            when address_gt0_txrx =>
              latched_data <= gtx_rx_data;
            when address_gt0_drp =>
              latched_data <= gt0_drp;
            when others =>
              latched_data <= x"f8f8f8f8";
          end case;
        end if;
      else
        iobus_ready <= '0';
        latched_data <= ( others => '0' );
      end if;
    end if;
  end process;

  masked_address <= iobus.io_address(31 downto 16) and address_mask;
  write_data <= latched_data;
  trig <= '1' when gtx_tx_charisk = "00" else
          '1' when gtx_rx_charisk = "00" else '0';
  trigger_output <= '1' when data_output(7 downto 0) = link_csr(15 downto 8) and
                             link_csr(1) = '0' else
                    '1' when data_pipeline(7 downto 0) = link_csr(15 downto 8) and
                             link_csr(1) = '1' else '0';

end RTL;
