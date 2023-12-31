------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 3.6
--  \   \         Application : 7 Series FPGAs Transceivers Wizard
--  /   /         Filename : gtwizard_0.vho
-- /___/   /\      
-- \   \  /  \ 
--  \___\/\___\
--
--
-- Instantiation Template
-- Generated by Xilinx 7 Series FPGAs Transceivers Wizard


--**************************Wrapper Component Declarations*****************************


------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
component gtwizard_0
port
(
    SOFT_RESET_TX_IN                        : in   std_logic;
    SOFT_RESET_RX_IN                        : in   std_logic;
    DONT_RESET_ON_DATA_ERROR_IN             : in   std_logic;
    Q1_CLK0_GTREFCLK_PAD_N_IN               : in   std_logic;
    Q1_CLK0_GTREFCLK_PAD_P_IN               : in   std_logic;

    GT0_TX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT0_RX_FSM_RESET_DONE_OUT               : out  std_logic;
    GT0_DATA_VALID_IN                       : in   std_logic;
 
    GT0_TXUSRCLK_OUT                        : out  std_logic;
    GT0_TXUSRCLK2_OUT                       : out  std_logic;
    GT0_RXUSRCLK_OUT                        : out  std_logic;
    GT0_RXUSRCLK2_OUT                       : out  std_logic;

    --_________________________________________________________________________
    --GT0  (X0Y6)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
    gt0_cpllfbclklost_out                   : out  std_logic;
    gt0_cplllock_out                        : out  std_logic;
    gt0_cpllreset_in                        : in   std_logic;
    ---------------------------- Channel - DRP Ports  --------------------------
    gt0_drpaddr_in                          : in   std_logic_vector(8 downto 0);
    gt0_drpdi_in                            : in   std_logic_vector(15 downto 0);
    gt0_drpdo_out                           : out  std_logic_vector(15 downto 0);
    gt0_drpen_in                            : in   std_logic;
    gt0_drprdy_out                          : out  std_logic;
    gt0_drpwe_in                            : in   std_logic;
    --------------------------- Digital Monitor Ports --------------------------
    gt0_dmonitorout_out                     : out  std_logic_vector(7 downto 0);
    --------------------- RX Initialization and Reset Ports --------------------
    gt0_eyescanreset_in                     : in   std_logic;
    gt0_rxuserrdy_in                        : in   std_logic;
    -------------------------- RX Margin Analysis Ports ------------------------
    gt0_eyescandataerror_out                : out  std_logic;
    gt0_eyescantrigger_in                   : in   std_logic;
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
    gt0_rxdata_out                          : out  std_logic_vector(15 downto 0);
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt0_rxdisperr_out                       : out  std_logic_vector(1 downto 0);
    gt0_rxnotintable_out                    : out  std_logic_vector(1 downto 0);
    --------------------------- Receive Ports - RX AFE -------------------------
    gt0_gtxrxp_in                           : in   std_logic;
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt0_gtxrxn_in                           : in   std_logic;
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt0_rxbyteisaligned_out                 : out  std_logic;
    --------------------- Receive Ports - RX Equalizer Ports -------------------
    gt0_rxdfelpmreset_in                    : in   std_logic;
    gt0_rxmonitorout_out                    : out  std_logic_vector(6 downto 0);
    gt0_rxmonitorsel_in                     : in   std_logic_vector(1 downto 0);
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    gt0_rxoutclkfabric_out                  : out  std_logic;
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt0_gtrxreset_in                        : in   std_logic;
    gt0_rxpmareset_in                       : in   std_logic;
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
    gt0_rxcharisk_out                       : out  std_logic_vector(1 downto 0);
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt0_rxresetdone_out                     : out  std_logic;
    --------------------- TX Initialization and Reset Ports --------------------
    gt0_gttxreset_in                        : in   std_logic;
    gt0_txuserrdy_in                        : in   std_logic;
    ------------------ Transmit Ports - TX Data Path interface -----------------
    gt0_txdata_in                           : in   std_logic_vector(15 downto 0);
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
    gt0_gtxtxn_out                          : out  std_logic;
    gt0_gtxtxp_out                          : out  std_logic;
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt0_txoutclkfabric_out                  : out  std_logic;
    gt0_txoutclkpcs_out                     : out  std_logic;
    --------------------- Transmit Ports - TX Gearbox Ports --------------------
    gt0_txcharisk_in                        : in   std_logic_vector(1 downto 0);
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt0_txresetdone_out                     : out  std_logic;

    --____________________________COMMON PORTS________________________________
     GT0_QPLLOUTCLK_OUT  : out std_logic;
     GT0_QPLLOUTREFCLK_OUT : out std_logic;

          sysclk_in                               : in   std_logic

);

end component;
-- COMP_TAG_END ------ End COMPONENT Declaration ------------

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
    gtwizard_0_i : gtwizard_0
port map
(
    SOFT_RESET_TX_IN => SOFT_RESET_TX_IN,
    SOFT_RESET_RX_IN => SOFT_RESET_RX_IN,
    DONT_RESET_ON_DATA_ERROR_IN => DONT_RESET_ON_DATA_ERROR_IN,
    Q1_CLK0_GTREFCLK_PAD_N_IN => Q1_CLK0_GTREFCLK_PAD_N_IN,
    Q1_CLK0_GTREFCLK_PAD_P_IN => Q1_CLK0_GTREFCLK_PAD_P_IN,

     GT0_TX_FSM_RESET_DONE_OUT => GT0_TX_FSM_RESET_DONE_OUT,
     GT0_RX_FSM_RESET_DONE_OUT => GT0_RX_FSM_RESET_DONE_OUT,
     GT0_DATA_VALID_IN => GT0_DATA_VALID_IN,
 
     GT0_TXUSRCLK_OUT => GT0_TXUSRCLK_OUT,
     GT0_TXUSRCLK2_OUT => GT0_TXUSRCLK2_OUT,
     GT0_RXUSRCLK_OUT => GT0_RXUSRCLK_OUT,
     GT0_RXUSRCLK2_OUT => GT0_RXUSRCLK2_OUT,

    --_________________________________________________________________________
    --GT0  (X0Y6)
    --____________________________CHANNEL PORTS________________________________
    --------------------------------- CPLL Ports -------------------------------
        gt0_cpllfbclklost_out           =>      gt0_cpllfbclklost_out,
        gt0_cplllock_out                =>      gt0_cplllock_out,
        gt0_cpllreset_in                =>      gt0_cpllreset_in,
    ---------------------------- Channel - DRP Ports  --------------------------
        gt0_drpaddr_in                  =>      gt0_drpaddr_in,
        gt0_drpdi_in                    =>      gt0_drpdi_in,
        gt0_drpdo_out                   =>      gt0_drpdo_out,
        gt0_drpen_in                    =>      gt0_drpen_in,
        gt0_drprdy_out                  =>      gt0_drprdy_out,
        gt0_drpwe_in                    =>      gt0_drpwe_in,
    --------------------------- Digital Monitor Ports --------------------------
        gt0_dmonitorout_out             =>      gt0_dmonitorout_out,
    --------------------- RX Initialization and Reset Ports --------------------
        gt0_eyescanreset_in             =>      gt0_eyescanreset_in,
        gt0_rxuserrdy_in                =>      gt0_rxuserrdy_in,
    -------------------------- RX Margin Analysis Ports ------------------------
        gt0_eyescandataerror_out        =>      gt0_eyescandataerror_out,
        gt0_eyescantrigger_in           =>      gt0_eyescantrigger_in,
    ------------------ Receive Ports - FPGA RX interface Ports -----------------
        gt0_rxdata_out                  =>      gt0_rxdata_out,
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
        gt0_rxdisperr_out               =>      gt0_rxdisperr_out,
        gt0_rxnotintable_out            =>      gt0_rxnotintable_out,
    --------------------------- Receive Ports - RX AFE -------------------------
        gt0_gtxrxp_in                   =>      gt0_gtxrxp_in,
    ------------------------ Receive Ports - RX AFE Ports ----------------------
        gt0_gtxrxn_in                   =>      gt0_gtxrxn_in,
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
        gt0_rxbyteisaligned_out         =>      gt0_rxbyteisaligned_out,
    --------------------- Receive Ports - RX Equalizer Ports -------------------
        gt0_rxdfelpmreset_in            =>      gt0_rxdfelpmreset_in,
        gt0_rxmonitorout_out            =>      gt0_rxmonitorout_out,
        gt0_rxmonitorsel_in             =>      gt0_rxmonitorsel_in,
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
        gt0_rxoutclkfabric_out          =>      gt0_rxoutclkfabric_out,
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
        gt0_gtrxreset_in                =>      gt0_gtrxreset_in,
        gt0_rxpmareset_in               =>      gt0_rxpmareset_in,
    ------------------- Receive Ports - RX8B/10B Decoder Ports -----------------
        gt0_rxcharisk_out               =>      gt0_rxcharisk_out,
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
        gt0_rxresetdone_out             =>      gt0_rxresetdone_out,
    --------------------- TX Initialization and Reset Ports --------------------
        gt0_gttxreset_in                =>      gt0_gttxreset_in,
        gt0_txuserrdy_in                =>      gt0_txuserrdy_in,
    ------------------ Transmit Ports - TX Data Path interface -----------------
        gt0_txdata_in                   =>      gt0_txdata_in,
    ---------------- Transmit Ports - TX Driver and OOB signaling --------------
        gt0_gtxtxn_out                  =>      gt0_gtxtxn_out,
        gt0_gtxtxp_out                  =>      gt0_gtxtxp_out,
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
        gt0_txoutclkfabric_out          =>      gt0_txoutclkfabric_out,
        gt0_txoutclkpcs_out             =>      gt0_txoutclkpcs_out,
    --------------------- Transmit Ports - TX Gearbox Ports --------------------
        gt0_txcharisk_in                =>      gt0_txcharisk_in,
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
        gt0_txresetdone_out             =>      gt0_txresetdone_out,

    --____________________________COMMON PORTS________________________________
     GT0_QPLLOUTCLK_OUT  => GT0_QPLLOUTCLK_OUT,
     GT0_QPLLOUTREFCLK_OUT => GT0_QPLLOUTREFCLK_OUT,
     sysclk_in => sysclk_in

);
-- INST_TAG_END ------ End INSTANTIATION Template ---------



