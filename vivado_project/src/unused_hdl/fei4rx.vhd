----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:23:53 09/11/2013 
-- Design Name: 
-- Module Name:    fei4rx - RTL 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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

use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity fei4rx is
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
    bypass : in std_logic;
    dout : out std_logic_vector(9 downto 0);
    dv : out std_logic;
    do_idelay : in std_logic;
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
end fei4rx;

architecture RTL of fei4rx is

  component decoder_10b8b_rom
  port (
    clka : in std_logic;
    addra : in std_logic_vector(9 downto 0);
    douta : out std_logic_vector(9 downto 0)
  );
  end component;

--  component decoder10b8b
--  port (
--    clka : in std_logic;
--    addra : in std_logic_vector(9 downto 0);
--    douta : out std_logic_vector(9 downto 0)
--  );
--  end component;

  component fei4_parse_new
  port (
    clk : in std_logic;
    din : in std_logic_vector(9 downto 0);
    dv : in std_logic;
    reset : in std_logic;
    do_rdreg : in std_logic;
    busy : out std_logic;
    rdreg : out std_logic_vector(31 downto 0);
    address : in std_logic_vector(3 downto 0);
    address_strobe : in std_logic;
    data : out std_logic_vector(31 downto 0);
    bcid : out std_logic_vector(12 downto 0);
    lv1id : out std_logic_vector(11 downto 0);
    evt_strobe : out std_logic;
    evtsr_strobe : out std_logic;
    eof_strobe : out std_logic;
    pixel_data : out std_logic_vector(23 downto 0);
    pixel_dv : out std_logic
  );
  end component;

  component fei4_match
  port (
    clk : in std_logic;
    pixel_data : in std_logic_vector(23 downto 0);
    bcid : in std_logic_vector(7 downto 0);
    pixel_dv : in std_logic;
    match : in std_logic_vector(31 downto 0);
    clear : in std_logic;
    match_data : out std_logic_vector(31 downto 0)
  );
  end component;

  component fei4_lv1count
  port (
    clk : in std_logic;
    lv1 : in std_logic;
    clear : in std_logic;
    count : out std_logic_vector(31 downto 0)
  );
  end component;

  signal tap : unsigned(5 downto 0) := to_unsigned(iobdelay_value,6);
  signal pipe : std_logic_vector(21 downto 0);
  signal encoded_data : std_logic_vector(9 downto 0);
  signal rin : std_logic;
  signal sd : std_logic_vector(1 downto 0);
  signal count : integer range 0 to 9;
  signal k281p : std_logic;
  signal k281n : std_logic;
  signal k287p : std_logic;
  signal k287n : std_logic;
  signal k285p : std_logic;
  signal k285n : std_logic;
  signal sof : std_logic;
  signal eof : std_logic;
  signal idle : std_logic;
  signal comma : std_logic;
  signal valid : std_logic_vector(2 downto 0) := "000";
  signal decoded_data : std_logic_vector(9 downto 0);
  signal misalign : unsigned(3 downto 0) := ( others => '0' );
  signal align : unsigned(3 downto 0) := ( others => '0' );
  signal tap_busy : std_logic := '0';
  signal idelay_clken : std_logic := '0';
  signal sof_count : unsigned(31 downto 0) := ( others => '0' );
  signal eof_count : unsigned(31 downto 0) := ( others => '0' );
  signal badframe_count : unsigned(31 downto 0) := ( others => '0' );
  signal decoder_errors : unsigned(31 downto 0) := ( others => '0' );
  signal alignment_errors : unsigned(31 downto 0) := ( others => '0' );
  signal align_count : unsigned(31 downto 0) := ( others => '0' );
  type state_t is ( Acquire, Frame );
  signal state : state_t := Acquire; 
  signal decoder_state : std_logic_vector(2 downto 0);
  signal parse_data : std_logic_vector(31 downto 0);
  signal parse_strobe : std_logic;
  signal rdreg : std_logic_vector(31 downto 0);
--  signal capture_pipeline : std_logic_vector(127 downto 0);
--  signal latched_capture_pipeline : std_logic_vector(127 downto 0);
  signal capture_delay : std_logic_vector(31 downto 0);
  signal capturing : std_logic := '0';
  signal missed : unsigned(3 downto 0);
  signal pixel_data : std_logic_vector(23 downto 0);
  signal pixel_dv : std_logic;

  signal comma_even : std_logic;
  signal comma_odd : std_logic;
  signal even : std_logic;
  signal input_word : std_logic_vector(9 downto 0);
  signal input_word_marker : std_logic;
  signal output_word_marker : std_logic;
  signal data_valid : std_logic;
  signal aligned : std_logic;
  signal srec_stale_flags : std_logic_vector(31 downto 0) := x"ffe0e7ff";

  type match_array_t is array(15 downto 0) of std_logic_vector(31 downto 0);
  signal match : match_array_t;
  type match_data_t is array(15 downto 0) of std_logic_vector(31 downto 0);
  signal match_data : match_data_t;
--  signal lv1_count : std_logic_vector(31 downto 0);
  signal match_address : integer range 0 to 15;
  signal bcid : std_logic_vector(12 downto 0);
  signal lv1id : std_logic_vector(11 downto 0);
  signal evt_strobe : std_logic;
  signal evtsr_strobe : std_logic;
  signal eof_strobe : std_logic;
  signal cntvalueout : std_logic_vector(4 downto 0);
  signal cinvctrl : std_logic := '0';
  signal latched_alignment_errors : std_logic_vector(31 downto 0);
  signal latched_decoder_errors : std_logic_vector(31 downto 0);
  signal latched_sof_count : std_logic_vector(31 downto 0);
  signal latched_eof_count : std_logic_vector(31 downto 0);
  signal latched_badframe_count : std_logic_vector(31 downto 0);
  signal latched_align_count : std_logic_vector(31 downto 0);

begin

  idly_imp : idelaye2
  generic map (
    idelay_type => "VAR_LOAD",
    delay_src => "IDATAIN"
  )
  port map (
    c => clk,
    regrst => idelay_rst,
    ld => '0',
    ce => idelay_clken,
    inc => idelay_inc,
    cinvctrl => cinvctrl,
    cntvaluein => "00000",
    idatain => din,
    datain => '0',
    dataout => rin,
    ldpipeen => '0',
    cntvalueout => cntvalueout
  );

  process ( clk ) begin
    if ( clk'event and clk = '1' ) then
      if ( idelay_clken = '1' ) then
        if ( idelay_inc = '1' ) then
          if ( cntvalueout = "11111" ) then
            cinvctrl <= not cinvctrl;
          end if;
        else
          if ( cntvalueout = "00000" ) then
            cinvctrl <= not cinvctrl;
          end if;
        end if;
      end if;
    end if;
  end process;

  iddr_imp : iddr
  generic map (
    ddr_clk_edge => "SAME_EDGE"
  )
  port map (
    d => rin,
    c => clk,
    ce => '1',
    q1 => sd(0),
    q2 => sd(1),
    r => '0',
    s => '0'
  );
    
  dec_imp : decoder_10b8b_rom
  port map (
    clka => clk,
    addra => encoded_data,
    douta => decoded_data
  );

--  dec_imp : decoder10b8b
--  port map (
--    clka => clk,
--    addra => encoded_data,
--    douta => decoded_data
--  );

  parse_imp : fei4_parse_new
  port map (
    clk => clk,
    din => decoded_data,
    dv => data_valid,
    reset => reset,
    do_rdreg => do_rdreg,
    busy => chan_busy,
    rdreg => rdreg,
    address => address(3 downto 0),
    address_strobe => parse_strobe,
    data => parse_data,
    bcid => bcid,
    lv1id => lv1id,
    evt_strobe => evt_strobe,
    evtsr_strobe => evtsr_strobe,
    eof_strobe => eof_strobe,
    pixel_data => pixel_data,
    pixel_dv => pixel_dv
  );

  m0 : for i in 1 to 15 generate
    match_imp : fei4_match
    port map (
      clk => clk,
      pixel_data => pixel_data,
      bcid => bcid(7 downto 0),
      pixel_dv => pixel_dv,
      match => match(i),
      clear => do_match,
      match_data => match_data(i)
    );
  end generate;

  lv1count_imp : fei4_lv1count
  port map (
    clk => clk,
    lv1 => lv1,
    clear => do_match,
    count => match_data(0)
  );

  process ( clk, do_idelay ) begin
    if ( clk'event and clk = '1' ) then
      if ( idelay_clken = '1' ) then
        if ( idelay_rst = '1' ) then
          tap <= "000000";
        elsif ( idelay_inc = '1' ) then
          tap <= tap + 1;
        else
          tap <= tap - 1;
        end if;
      end if;
    end if;
  end process;

  process ( clk, do_idelay ) begin
    if ( clk'event and clk = '1' ) then
      if ( idelay_clken = '1' ) then
        idelay_clken <= '0';
      end if;
      if ( do_idelay = '1' and tap_busy = '0' ) then
        idelay_clken <= '1';
        tap_busy <= '1';
      elsif ( do_idelay = '0' and tap_busy = '1' ) then
        tap_busy <= '0';
      end if;
    end if;
  end process;
--   idelay_tap <= std_logic_vector(tap);
  idelay_tap <= cinvctrl & cntvalueout;
  idelay_busy <= tap_busy;

  process ( clk ) begin
    if ( clk'event and clk = '1' ) then
      if ( reset = '1' ) then
        alignment_errors <= ( others => '0' );
        decoder_errors <= ( others => '0' );
        sof_count <= ( others => '0' );
        eof_count <= ( others => '0' );
        badframe_count <= ( others => '0' );
        aligned <= '0';
        count <= 0;
        dv <= '0';
        decoder_state <= "000";
        align_count <= ( others => '0' );
        state <= Acquire;
      elsif ( state = Acquire ) then
        dv <= '0';
        if ( count = 0 ) then
          encoded_data <= input_word;
        end if;
        if ( comma_even = '1' ) then
          if ( count /= 0 or even = '0' ) then
            aligned <= '0';
            alignment_errors <= alignment_errors + 1;
          else
            aligned <= '1';
            if ( sof = '1' ) then
              sof_count <= sof_count + 1;
              decoder_state <= "100";
              state <= Frame;
            end if;
          end if;
          count <= 1;
          even <= '1';
          decoder_state <= "010";
        elsif ( comma_odd = '1' ) then
          if ( count /= 0 or even = '1' ) then
            aligned <= '0';
            alignment_errors <= alignment_errors + 1;
          else
            aligned <= '1';
            if ( sof = '1' ) then
              sof_count <= sof_count + 1;
              decoder_state <= "100";
              state <= Frame;
            end if;
          end if;
          count <= 1;
          even <= '0';
          decoder_state <= "011";
        elsif ( count = 4 ) then
          decoder_state <= "001";
          count <= 0;
        else
          decoder_state <= "001";
          count <= count + 1;
        end if;
        if ( do_clear = '1' ) then
          alignment_errors <= ( others => '0' );
          decoder_errors <= ( others => '0' );
          sof_count <= ( others => '0' );
          eof_count <= ( others => '0' );
          badframe_count <= ( others => '0' );
        end if;
        if ( aligned = '0' ) then
          align_count <= align_count + 1;
        end if;
      elsif ( state = Frame ) then
        if ( count = 0 ) then
          encoded_data <= input_word;
        end if;
        if ( count = 3 ) then
          if ( bypass = '1' ) then
            dout <= encoded_data;
          else
            dout <= decoded_data;
          end if;
          dv <= '1';
          if ( decoded_data(9) = '1' ) then
            decoder_errors <= decoder_errors + 1;
            align_count <= ( others => '0' );
            state <= Acquire;
          elsif ( decoded_data(8) = '1' ) then
            if ( decoded_data(7 downto 0) = "10111100" ) then   -- match end-of-frame
              eof_count <= eof_count + 1;
              align_count <= ( others => '0' );
              state <= Acquire;
            elsif ( decoded_data(7 downto 0) /= "11111100" ) then   -- anything but start-of-frame
              badframe_count <= badframe_count + 1;
              align_count <= ( others => '0' );
              state <= Acquire;
            end if;
          end if;
        else
          dv <= '0';
        end if;
        if ( count = 4 ) then
          count <= 0;
        else
          count <= count + 1;
        end if;
        if ( do_clear = '1' ) then
          alignment_errors <= ( others => '0' );
          decoder_errors <= ( others => '0' );
          sof_count <= ( others => '0' );
          eof_count <= ( others => '0' );
          badframe_count <= ( others => '0' );
        end if;
      end if;
      pipe <= pipe(pipe'length-3 downto 0) & sd;
      if ( do_capture = '1' ) then
        capturing <= '1';
      elsif ( aligned = '0' ) then
        capturing <= '0';
      end if;
--      capture_delay <= capture_delay(capture_delay'length-2 downto 0) & capturing;
--      if ( capture_delay(capture_delay'length-1) = '1' ) then
--        capture_pipeline <= capture_pipeline(capture_pipeline'length-3 downto 0) & sd;
--      end if;
    end if;
  end process;

  process ( busclk ) begin
    if ( busclk'event and busclk = '1' ) then
      latched_alignment_errors <= std_logic_vector(alignment_errors);
      latched_decoder_errors <= std_logic_vector(decoder_errors);
      latched_sof_count <= std_logic_vector(sof_count);
      latched_eof_count <= std_logic_vector(eof_count);
      latched_badframe_count <= std_logic_vector(badframe_count);
      latched_align_count <= std_logic_vector(align_count);
--      latched_capture_pipeline <= capture_pipeline;
      if ( write_strobe = '1' ) then
        if ( address(5 downto 4) = "11" ) then
          match(match_address) <= bus_data;
        end if;
      end if;
    end if;
  end process;

  stream_data <= "000" & std_logic_vector(to_unsigned(channel,5)) & pixel_data when pixel_dv = '1' else
                 "010" & std_logic_vector(to_unsigned(channel,5)) & lv1id(11 downto 0) & bcid(11 downto 0) when evtsr_strobe = '1' else
                 "100" & std_logic_vector(to_unsigned(channel,5)) & lv1id(11 downto 0) & bcid(11 downto 0) when eof_strobe = '1' else
                 ( others => '0' );
  stream_dv <= pixel_dv or evtsr_strobe or eof_strobe;
  stream_eof <= eof_strobe;

  serdes_input <= rin;
  sync <= aligned;

  comma_even <= '1' when pipe(19 downto 0) = "00111110011100000110" else      -- K28.1+, K28.1-
                '1' when pipe(19 downto 0) = "11000001100011111001" else      -- K28.1-, K28.1+
                '1' when pipe(19 downto 0) = "00111110011100000111" else      -- K28.1+, K28.7-
                '1' when pipe(19 downto 0) = "11000001100011111000" else      -- K28.1-, K28.7+
                '1' when pipe(19 downto 0) = "00111110101100000111" else      -- K28.5+, K28.7-
                '1' when pipe(19 downto 0) = "11000001010011111000" else      -- K28.5-, K28.7+
                '1' when pipe(19 downto 0) = "00111110101100000110" else      -- K28.5+, K28.1-
                '1' when pipe(19 downto 0) = "11000001010011111001" else '0'; -- K28.5-, K28.1+
  comma_odd <= '1' when pipe(20 downto 1) = "00111110011100000110" else      -- K28.1+, K28.1-
               '1' when pipe(20 downto 1) = "11000001100011111001" else      -- K28.1-, K28.1+
               '1' when pipe(20 downto 1) = "00111110011100000111" else      -- K28.1+, K28.7-
               '1' when pipe(20 downto 1) = "11000001100011111000" else      -- K28.1-, K28.7+
               '1' when pipe(20 downto 1) = "00111110101100000111" else      -- K28.5+, K28.7-
               '1' when pipe(20 downto 1) = "11000001010011111000" else      -- K28.5-, K28.7+
               '1' when pipe(20 downto 1) = "00111110101100000110" else      -- K28.5+, K28.1-
               '1' when pipe(20 downto 1) = "11000001010011111001" else '0'; -- K28.5-, K28.1+
  input_word <= pipe(9 downto 0) when even = '1' else pipe(10 downto 1);
--  input_word_marker <= '1' when count = 0 else '0';
--  output_word_marker <= '1' when count = 2 else '0';

  data_valid <= '1' when count = 2 else '0';

  k281p <= '1' when input_word = "0011111001" else '0';
  k281n <= '1' when input_word = "1100000110" else '0';
  k287p <= '1' when input_word = "0011111000" else '0';
  k287n <= '1' when input_word = "1100000111" else '0';
  k285p <= '1' when input_word = "0011111010" else '0';
  k285n <= '1' when input_word = "1100000101" else '0';

  idle <= k281p or k281n;
  sof <= k287p or k287n;
  eof <= k285p or k285n;

  match_address <= to_integer(unsigned(address(3 downto 0)));

  capture_busy <= capturing;
  parse_strobe <= '1' when address(5 downto 4) = "10" else '0';
  data <= even & decoder_state & std_logic_vector(to_unsigned(count,4)) & "00" & pipe when address = "010000" else
          latched_alignment_errors when address = "010001" else
          latched_decoder_errors when address = "010010" else
          latched_sof_count when address = "010011" else
          latched_eof_count when address = "010100" else
          latched_badframe_count when address = "010101" else
          latched_align_count when address = "010110" else
          srec_stale_flags when address = "011111" else
--          latched_capture_pipeline(31 downto 0) when address = "001100" else
--          latched_capture_pipeline(63 downto 32) when address = "001101" else
--          latched_capture_pipeline(95 downto 64) when address = "001110" else
--          latched_capture_pipeline(127 downto 96) when address = "001111" else
          rdreg when address = "000100" else
          match_data(match_address) when address(5 downto 4) = "11" else
          parse_data when parse_strobe = '1' else ( others => '0' );

end RTL;
