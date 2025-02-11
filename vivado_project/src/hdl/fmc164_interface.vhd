--------------------------------------------------------------------------------
--
-- Company:
-- Engineer:       Matthew Jones - Purdue University
-- 
-- Create Date:    10:56:38 06/14/2016 
-- Design Name:    fmc164
-- Module Name:    fmc164_interface - RTL
-- Project Name:   AMC502 firmware
-- Target Devices: xc7k420tffv1156-1
-- Tool versions:  Vivado 2016.1
-- Description:    VadaTech fmc164 slave
--
-- Dependencies:
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

library hep337dev;
use hep337dev.iobus.ALL;
use hep337dev.fmc164.ALL;

entity fmc164_interface is
  generic (
    nclock : integer := 8
  );
  port (
    clk20mhz : in std_logic;
    cha_clk : in std_logic;
    cha_data : in std_logic_vector(7 downto 0);
    chc_data : in std_logic_vector(7 downto 0);
    che_clk : in std_logic;
    che_data : in std_logic_vector(7 downto 0);
    chg_data : in std_logic_vector(7 downto 0);
    gbe_stream_clk : in std_logic;
    gbe_stream_wren : out std_logic;
    gbe_stream_strobe : out std_logic;
    gbe_stream_dout : out std_logic_vector(31 downto 0);
    gbe_stream_free : in std_logic_vector(15 downto 0);
    busclk : in std_logic;
    iobus : in iobus_t;
    write_data : out std_logic_vector(31 downto 0);
    iobus_ready : out std_logic
  );
end fmc164_interface;

architecture RTL of fmc164_interface is

  component fmc164_readout_buffer
  generic (
    length : integer := 512
  );
  port (
    clka : in std_logic;
    wea : in std_logic;
    dina : in std_logic_vector(15 downto 0);
    offset : in std_logic_vector(15 downto 0);
    trig : in std_logic;
    triggered : out std_logic;
    clkb : in std_logic;
    dvb : out std_logic;
    strobe : out std_logic;
    doutb : out std_logic_vector(31 downto 0);
    free : in std_logic_vector(15 downto 0)
  );
  end component;

  component fmc164_threshold_trigger
  port (
    clk : in std_logic;
    din : in std_logic_vector(15 downto 0);
    offset : in std_logic_vector(15 downto 0);
    threshold : in std_logic_vector(15 downto 0);
    trigger : out std_logic;
    ack : in std_logic
  );
  end component;

  constant base_address : std_logic_vector(15 downto 0) := x"ce00";
  constant address_mask : std_logic_vector(15 downto 0) := x"ffff";
  constant address_fmc164_csr : std_logic_vector(15 downto 0) := x"0000";

  constant address_fmc164_ch01_data : std_logic_vector(15 downto 0) := x"0010";
  constant address_fmc164_ch23_data : std_logic_vector(15 downto 0) := x"0014";
  constant address_fmc164_threshold : std_logic_vector(15 downto 0) := x"0018";
  constant address_fmc164_offset : std_logic_vector(15 downto 0) := x"001c";

  signal masked_address : std_logic_vector(15 downto 0);
  signal latched_data : std_logic_vector(31 downto 0);
  signal fmc164_csr : std_logic_vector(31 downto 0) := ( others => '0' );
  signal threshold : std_logic_vector(31 downto 0);
  signal offset : std_logic_vector(31 downto 0);

  signal cha_q1 : std_logic_vector(7 downto 0);
  signal cha_q2 : std_logic_vector(7 downto 0);
  signal chc_q1 : std_logic_vector(7 downto 0);
  signal chc_q2 : std_logic_vector(7 downto 0);
  signal che_q1 : std_logic_vector(7 downto 0);
  signal che_q2 : std_logic_vector(7 downto 0);
  signal chg_q1 : std_logic_vector(7 downto 0);
  signal chg_q2 : std_logic_vector(7 downto 0);
  type adc_data_array_t is array(3 downto 0) of std_logic_vector(15 downto 0);
  signal adc_data : adc_data_array_t;
  signal adc_data_select : std_logic_vector(15 downto 0);
  signal offset_select : std_logic_vector(15 downto 0);

  signal trigger_busy : std_logic;
  signal stream_trigger: std_logic;
  signal manual_trigger: std_logic;
  signal self_trigger: std_logic;

begin

  g_lane : for i in 0 to 7 generate
    cha_iddr : iddr
    generic map (
      ddr_clk_edge => "SAME_EDGE_PIPELINED"
    )
    port map (
      q1 => cha_q1(i),
      q2 => cha_q2(i),
      c => cha_clk,
      ce => '1',
      d => cha_data(i),
      r => '0',
      s => '0'
    );
    chc_iddr : iddr
    generic map (
      ddr_clk_edge => "SAME_EDGE_PIPELINED"
    )
    port map (
      q1 => chc_q1(i),
      q2 => chc_q2(i),
      c => cha_clk,
      ce => '1',
      d => chc_data(i),
      r => '0',
      s => '0'
    );
    che_iddr : iddr
    generic map (
      ddr_clk_edge => "SAME_EDGE_PIPELINED"
    )
    port map (
      q1 => che_q1(i),
      q2 => che_q2(i),
      c => che_clk,
      ce => '1',
      d => che_data(i),
      r => '0',
      s => '0'
    );
    chg_iddr : iddr
    generic map (
      ddr_clk_edge => "SAME_EDGE_PIPELINED"
    )
    port map (
      q1 => chg_q1(i),
      q2 => chg_q2(i),
      c => che_clk,
      ce => '1',
      d => chg_data(i),
      r => '0',
      s => '0'
    );

  end generate;

  process ( cha_clk ) begin
    if ( cha_clk'event and cha_clk = '1' ) then
      adc_data(0) <= cha_q2(7) & cha_q1(7) &
                     cha_q2(6) & cha_q1(6) &
                     cha_q2(5) & cha_q1(5) &
                     cha_q2(4) & cha_q1(4) &
                     cha_q2(3) & cha_q1(3) &
                     cha_q2(2) & cha_q1(2) &
                     cha_q2(1) & cha_q1(1) &
                     cha_q2(0) & cha_q1(0);
      adc_data(1) <= chc_q2(7) & chc_q1(7) &
                     chc_q2(6) & chc_q1(6) &
                     chc_q2(5) & chc_q1(5) &
                     chc_q2(4) & chc_q1(4) &
                     chc_q2(3) & chc_q1(3) &
                     chc_q2(2) & chc_q1(2) &
                     chc_q2(1) & chc_q1(1) &
                     chc_q2(0) & chc_q1(0);
    end if;
  end process;

  process ( che_clk ) begin
    if ( che_clk'event and che_clk = '1' ) then
      adc_data(2) <= che_q2(7) & che_q1(7) &
                     che_q2(6) & che_q1(6) &
                     che_q2(5) & che_q1(5) &
                     che_q2(4) & che_q1(4) &
                     che_q2(3) & che_q1(3) &
                     che_q2(2) & che_q1(2) &
                     che_q2(1) & che_q1(1) &
                     che_q2(0) & che_q1(0);
      adc_data(3) <= chg_q2(7) & chg_q1(7) &
                     chg_q2(6) & chg_q1(6) &
                     chg_q2(5) & chg_q1(5) &
                     chg_q2(4) & chg_q2(4) &
                     chg_q2(3) & chg_q1(3) &
                     chg_q2(2) & chg_q1(2) &
                     chg_q2(1) & chg_q1(1) &
                     chg_q2(0) & chg_q1(0);
    end if;
  end process;

  ch0_buf_imp : fmc164_readout_buffer
  generic map (
    length => 512
  )
  port map (
    clka => cha_clk,
    wea => '1',
    dina => adc_data_select,
    offset => offset_select,
    trig => stream_trigger,
    triggered => trigger_busy,
    clkb => gbe_stream_clk,
    dvb => gbe_stream_wren,
    strobe => gbe_stream_strobe,
    doutb => gbe_stream_dout,
    free => gbe_stream_free
  );

  trig_imp : fmc164_threshold_trigger
  port map (
    clk => cha_clk,
    din => adc_data_select,
    offset => offset_select,
    threshold => threshold(15 downto 0),
    trigger => self_trigger,
    ack => trigger_busy
  );

  process ( busclk )
    variable i : integer range 0 to 63;
  begin
    if ( busclk'event and busclk= '1' ) then

      if ( trigger_busy = '1' ) then
        manual_trigger <= '0';
      end if;

      if ( iobus.io_addr_strobe = '1' and masked_address = base_address ) then
        iobus_ready <= '1';
        if ( iobus.io_write_strobe = '1' ) then
          case iobus.io_address(15 downto 0) is
            when address_fmc164_csr =>
              fmc164_csr <= iobus.io_write_data;
              if ( trigger_busy = '0' ) then
                manual_trigger <= iobus.io_write_data(31);
              end if;
            when address_fmc164_threshold =>
              threshold <= iobus.io_write_data;
            when address_fmc164_offset =>
              offset <= iobus.io_write_data;
            when others =>
          end case;
        end if;

        if ( iobus.io_read_strobe = '1' ) then
          case iobus.io_address(15 downto 0) is
            when address_fmc164_csr =>
              latched_data <= trigger_busy & fmc164_csr(30 downto 0);
            when address_fmc164_ch01_data =>
              latched_data <= adc_data(1) & adc_data(0);
            when address_fmc164_ch23_data =>
              latched_data <= adc_data(3) & adc_data(2);
            when address_fmc164_threshold =>
              latched_data <= threshold;
            when address_fmc164_offset =>
              latched_data <= offset;
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

  adc_data_select <= adc_data(0) when fmc164_csr(1 downto 0) = "00" else
                     adc_data(1) when fmc164_csr(1 downto 0) = "01" else
                     adc_data(2) when fmc164_csr(1 downto 0) = "10" else adc_data(3);
  offset_select <= offset(15 downto 0) when fmc164_csr(1 downto 0) = "00" else
                   offset(31 downto 16) when fmc164_csr(1 downto 0) = "01" else
                   offset(15 downto 0) when fmc164_csr(1 downto 0) = "10" else offset(31 downto 16);

  stream_trigger <= manual_trigger or ( self_trigger and fmc164_csr(30) );
  masked_address <= iobus.io_address(31 downto 16) and address_mask;
  write_data <= latched_data;

end RTL;
