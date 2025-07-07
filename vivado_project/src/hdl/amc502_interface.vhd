--------------------------------------------------------------------------------
--
-- Company:
-- Engineer:       Matthew Jones - Purdue University
-- 
-- Create Date:    10:56:38 06/14/2016 
-- Design Name:    amc502
-- Module Name:    amc502_interface - RTL
-- Project Name:   AMC502 firmware
-- Target Devices: xc7k420tffv1156-1
-- Tool versions:  Vivado 2016.1
-- Description:    VadaTech amc502 slave
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
library unimacro;
use unimacro.vcomponents.all;

library hep337dev;
use hep337dev.iobus.ALL;
use hep337dev.amc502.ALL;

entity amc502_interface is
  generic (
    nclock : integer := 8;
    modulus : integer := 100000000
  );
  port (
    clk20mhz : in std_logic;
    scl_l1 : out std_logic;
    sda_l1_out : out std_logic;
    sda_l1_in : in std_logic;
    sda_l1_t : out std_logic;
    scl_lllx : in std_logic;
    sda_lllx_out : out std_logic;
    sda_lllx_in : in std_logic;
    sda_lllx_t : out std_logic;
    io_address_strobe : out std_logic;
    io_read_strobe : out std_logic;
    io_write_strobe : out std_logic;
    io_address : out std_logic_vector(31 downto 0);
    io_write_data : out std_logic_vector(31 downto 0);
    io_read_data : in std_logic_vector(31 downto 0);
    pll_rst_n : out std_logic;
    fpclka : in std_logic;
    fpclkb : in std_logic;
    tclka : in std_logic;
    tclkb : out std_logic;
    bcoclk : out std_logic;
    sysclk : out std_logic;
    sysclk2 : out std_logic;
    bco : out std_logic_vector(47 downto 0);
    fei4_lv1 : out std_logic;
    fpclk : in std_logic_vector(15 downto 0);
    cmd_strobe : out std_logic_vector(15 downto 0);
    stop_timer : in std_logic;
    uled : out std_logic_vector(3 downto 0);
    uled_select : out std_logic;

    xgbe_stream_clk : in std_logic;
    xgbe_stream_dout : out std_logic_vector(63 downto 0);
    xgbe_stream_wren : out std_logic;
    xgbe_stream_strobe : out std_logic;
    xgbe_trigger_stream_enable : in std_logic;
    xgbe_trigger_stream_data : in std_logic_vector(63 downto 0);
    systrig : out std_logic;

    busclk : in std_logic;
    onepps : out std_logic;
    iobus : in iobus_t;
    write_data : out std_logic_vector(31 downto 0);
    iobus_ready : out std_logic
  );
end amc502_interface;

architecture RTL of amc502_interface is

  component i2c
    port (
      clk20mhz : in std_logic;
      scl : out std_logic;
      sda_out : out std_logic;
      sda_in : in std_logic;
      sda_t : out std_logic;
      strobe : in std_logic;
      ready : out std_logic;
      len : in std_logic_vector(7 downto 0);
      address : in std_logic_vector(6 downto 0);
      rw : in std_logic;
      din : in std_logic_vector(7 downto 0);
      den : out std_logic;
      dout : out std_logic_vector(7 downto 0);
      wen : out std_logic;
      nack : out std_logic;
      nbyte : out std_logic_vector(7 downto 0)
    );
  end component;

  component i2c_slave
    port (
      clk : in std_logic;
      scl : in std_logic;
      sda_in : in std_logic;
      sda_out : out std_logic;
      sda_t : out std_logic;
      address : out std_logic_vector(31 downto 0);
      write_data : out std_logic_vector(31 downto 0);
      read_data : in std_logic_vector(31 downto 0);
      address_strobe : out std_logic;
      read_strobe : out std_logic;
      write_strobe : out std_logic
    );
  end component;

  component clkfreq
    port (
      clk100mhz : in std_logic;
      onepps : in std_logic;
      clk : in std_logic;
      count : out std_logic_vector(31 downto 0)
    );
  end component;

  component tclkb_driver
  port (
    sysclk : in std_logic;
    bcoclk : in std_logic;
    d : in std_logic_vector(3 downto 0);
    dv : in std_logic;
    d16 : in std_logic_vector(15 downto 0);
    dv16 : in std_logic;
    ack16 : out std_logic;
    tclkb_out : out std_logic
  );
  end component;
  
  component tclka_receiver
  generic (
    iobdelay_value : integer := 0
  );
  port (
    sysclk : in std_logic;
    bcoclk : in std_logic;
    tclka_in : in std_logic;
    do_idelay : in std_logic;
    idelay_busy : out std_logic;
    idelay_rst : in std_logic;
    idelay_inc : in std_logic;
    idelay_tap : out std_logic_vector(5 downto 0);
    strobe : out std_logic_vector(15 downto 0)
  );
  end component;

  component tclka_counter
  port (
    clk : in std_logic;
    strobe : in std_logic_vector(15 downto 0);
    stop : in std_logic;
    sel : in std_logic_vector(3 downto 0);
    count : out std_logic_vector(47 downto 0);
    timer : out std_logic_vector(47 downto 0);
    reset : in std_logic;
    busy : out std_logic
  );
  end component;

  component latch_generator
  port (
    bcoclk : in std_logic;
    strobe : in std_logic;
    busy : out std_logic;
    period : in std_logic_vector(15 downto 0);
    count : in std_logic_vector(7 downto 0);
    latch : out std_logic
  );
  end component;

  component event_generator
  port (
    bcoclk : in std_logic;
    strobe : in std_logic;
    busy : out std_logic;
    period : in std_logic_vector(15 downto 0);
    count : in std_logic_vector(7 downto 0);
    bco_counter : in std_logic_vector(47 downto 0);
    xgmii_clk : in std_logic;
    dout : out std_logic_vector(63 downto 0);
    wren : out std_logic;
    send : out std_logic;
    debug : out std_logic_vector(7 downto 0)
  );
  end component;

  component trigger
  port (
    clk_in : in std_logic;
    run : in std_logic;
    trig_in : in std_logic_vector(63 downto 0);
    write_en : in std_logic;
    addr_in : in std_logic_vector(7 downto 0);
    trig_data : out std_logic_vector(63 downto 0);
    bcoclk : in std_logic;
    bco_set : in std_logic_vector(47 downto 0);
    set_bco : in std_logic;
    trig_out : out std_logic_vector(15 downto 0);
    trig_bco : out std_logic_vector(47 downto 0)
  );
  end component;

  constant fast_modulus : unsigned(27 downto 0) := to_unsigned(modulus,28);
  constant base_address : std_logic_vector(15 downto 0) := x"c000";
  constant address_mask : std_logic_vector(15 downto 0) := x"ffff";
  constant address_amc502_csr : std_logic_vector(15 downto 0) := x"0000";
  constant address_i2c_l1 : std_logic_vector(15 downto 0) := x"0004";
  constant address_tclk_data : std_logic_vector(15 downto 0) := x"0008";
  constant address_slave_pll : std_logic_vector(15 downto 0) := x"000c";
  constant address_tclka_count_lo : std_logic_vector(15 downto 0) := x"0010";
  constant address_tclka_count_hi : std_logic_vector(15 downto 0) := x"0014";
  constant address_tclka_timer_lo : std_logic_vector(15 downto 0) := x"0018";
  constant address_tclka_timer_hi : std_logic_vector(15 downto 0) := x"001c";
  constant address_clock_time : std_logic_vector(15 downto 0) := x"0020";
  constant address_latch : std_logic_vector(15 downto 0) := x"0024";
  constant address_event : std_logic_vector(15 downto 0) := x"0028";
  constant address_bco_counter_lo : std_logic_vector(15 downto 0) := x"0030";
  constant address_bco_counter_hi : std_logic_vector(15 downto 0) := x"0034";
  constant address_trigger_csr : std_logic_vector(15 downto 0) := x"0040";
  constant address_trigger_spy_lo : std_logic_vector(15 downto 0) := x"0044";
  constant address_trigger_spy_hi : std_logic_vector(15 downto 0) := x"0048";
  constant address_i2c_addr_lllx : std_logic_vector(15 downto 0) := x"0054";
  constant address_i2c_data_lllx : std_logic_vector(15 downto 0) := x"0058";

  constant address_freq : std_logic_vector(15 downto 0) := x"0080";
  constant address_clk156_25mhz_freq : std_logic_vector(15 downto 0) := x"0080";

  constant address_i2c_wbuf : std_logic_vector(15 downto 0) := x"0100";
  constant address_i2c_rbuf : std_logic_vector(15 downto 0) := x"0200";

  signal masked_address : std_logic_vector(15 downto 0);
  signal amc502_csr : std_logic_vector(31 downto 0) := x"40000000";
  signal trigger_csr : std_logic_vector(31 downto 0) := x"00000000";
  signal trigger_spy : std_logic_vector(63 downto 0);
  signal trigger_bco : std_logic_vector(47 downto 0);
  signal trigger_word : std_logic_vector(15 downto 0);
  signal latched_data : std_logic_vector(31 downto 0);

  signal flasher : std_logic := '0';
  signal flash_count : unsigned(31 downto 0) := ( others => '0' );
  signal clock_time : unsigned(31 downto 0);
  signal clock_load_time : std_logic_vector(31 downto 0);
  signal clock_load_now : std_logic := '0';
  signal clock_load_done : std_logic;
  signal fast_counter : unsigned(27 downto 0) := x"0000000";
  signal bco_count_enabled : std_logic := '1';
  signal enable_bco_count : std_logic := '0';
  signal bco_count_load_enable : std_logic;
  signal bco_counter : std_logic_vector(47 downto 0);
  signal bco_count_load : std_logic;
  signal do_bco_load : std_logic := '0';
  signal bco_loaded : std_logic := '1';
  signal bco_count_reset : std_logic;
  signal write_bco_counter : std_logic_vector(47 downto 0);

  signal i2c_strobe : std_logic := '0';
  signal i2c_ready : std_logic;
  signal i2c_ready_r : std_logic;
  signal i2c_busy : std_logic;
  signal i2c_address : std_logic_vector(6 downto 0);
  signal i2c_rw : std_logic;
  signal i2c_len : std_logic_vector(7 downto 0);
  signal i2c_dout : std_logic_vector(7 downto 0);
  signal i2c_den : std_logic;
  signal i2c_din : std_logic_vector(7 downto 0);
  signal i2c_wen : std_logic;
  signal i2c_nack : std_logic;
  signal i2c_nbyte : std_logic_vector(7 downto 0);
  signal i2c_next_addr : std_logic;
  signal i2c_addr_lllx : std_logic_vector(31 downto 0);
  signal i2c_data_lllx : std_logic_vector(31 downto 0);

  type i2c_buffer_t is array(255 downto 0) of std_logic_vector(7 downto 0);
  signal i2c_addr : integer range 0 to 255;
  signal i2c_wbuf : i2c_buffer_t;
  signal i2c_rbuf : i2c_buffer_t;

  type freq_array_t is array(4+nclock downto 0) of std_logic_vector(31 downto 0);
  signal freq : freq_array_t;
  signal fpclk_internal : std_logic_vector(5+nclock downto 0);

  signal tclk_data : std_logic_vector(31 downto 0);
  signal tclk_data_valid : std_logic := '0';
  signal tclk_data_busy : std_logic;
  signal do_idelay : std_logic;
  signal idelay_busy : std_logic;
  signal idelay_rst : std_logic;
  signal idelay_inc : std_logic;
  signal idelay_tap : std_logic_vector(5 downto 0);
  signal tclka_strobe : std_logic_vector(15 downto 0);
  signal tclka_count_select : std_logic_vector(3 downto 0);
  signal tclka_counter_reset : std_logic := '0';
  signal counter_reset_busy : std_logic;
  signal tclk_counters : std_logic_vector(47 downto 0);
  signal tclk_count : std_logic_vector(47 downto 0);
  signal tclk_timer : std_logic_vector(47 downto 0);

  signal sysclk_sel : std_logic;
  signal one_pulse_per_second : std_logic := '0';
  signal master_sysclk : std_logic;
  signal master_bcoclk : std_logic;
  signal slave_sysclk2 : std_logic;
  signal slave_sysclk : std_logic;
  signal slave_bcoclk : std_logic;
  signal master_fb : std_logic;
  signal master_fb_bufg : std_logic;
  signal slave_fb : std_logic;
  signal slave_fb_bufg : std_logic;
  signal master_clkout0 : std_logic;
  signal master_clkout1 : std_logic;
  signal slave_clkout0 : std_logic;
  signal slave_clkout1 : std_logic;
  signal slave_clkout2 : std_logic;
  signal pll_locked : std_logic_vector(1 downto 0);

  signal slave_pll_daddr : std_logic_vector(6 downto 0);
  signal slave_pll_di : std_logic_vector(15 downto 0);
  signal slave_pll_do : std_logic_vector(15 downto 0);
  signal slave_pll_dwe : std_logic := '0';
  signal slave_pll_den : std_logic := '0';
  signal slave_pll_drdy : std_logic;

  signal latch_control : std_logic_vector(31 downto 0);
  signal do_latch : std_logic;
  signal latch_busy : std_logic;
  signal latch_cmd : std_logic;
  signal tclkb_cmd : std_logic_vector(3 downto 0);
  signal tclkb_dv : std_logic;
  signal event_control : std_logic_vector(31 downto 0);
  signal do_event : std_logic;
  signal event_busy : std_logic;
  signal event_busy_r : std_logic;
  signal event_generator_debug : std_logic_vector(7 downto 0);

--
--  These are useful for checking the system trigger pipeline
--
--  attribute mark_debug : string;
--  attribute mark_debug of trigger_word : signal is "true";
--  attribute mark_debug of xgbe_trigger_stream_enable : signal is "true";
--  attribute mark_debug of bco_counter : signal is "true";
--  attribute mark_debug of trigger_bco : signal is "true";
--

begin

  i2c_l1_imp : i2c
  port map (
    clk20mhz => clk20mhz,
    scl => scl_l1,
    sda_out => sda_l1_out,
    sda_in => sda_l1_in,
    sda_t => sda_l1_t,
    strobe => i2c_strobe,
    ready => i2c_ready,
    len => i2c_len,
    address => i2c_address,
    rw => i2c_rw,
    din => i2c_din,
    den => i2c_den,
    dout => i2c_dout,
    wen => i2c_wen,
    nack => i2c_nack,
    nbyte => i2c_nbyte
  );

  i2c_lllx_imp : i2c_slave
  port map (
    clk => busclk,
    scl => scl_lllx,
    sda_in => sda_lllx_in,
    sda_out => sda_lllx_out,
    sda_t => sda_lllx_t,
    address => i2c_addr_lllx,
    write_data => i2c_data_lllx,
    read_data => io_read_data,
    address_strobe => io_address_strobe,
    read_strobe => io_read_strobe,
    write_strobe => io_write_strobe 
  );
  io_address <= i2c_addr_lllx;
  io_write_data <= i2c_data_lllx;

  master_pll_imp : plle2_base
  generic map (
    bandwidth => "HIGH",
    clkin1_period => 25.000,
    clkfbout_mult => 40,
    clkout0_divide => 40,
    clkout1_divide => 20
  )
  port map (
    clkin1 => fpclkb,
    clkfbin => master_fb_bufg,
    rst => amc502_csr(24),
    pwrdwn => '0',
    clkfbout => master_fb,
    clkout0 => master_clkout0,
    clkout1 => master_clkout1,
    clkout2 => open,
    clkout3 => open,
    clkout4 => open,
    clkout5 => open,
    locked => pll_locked(0)
  );

  master_sysclk_bufg_imp : bufg
  port map (
    i => master_clkout1,
    o => master_sysclk
  );

  master_bcoclk_bufg_imp : bufg
  port map (
    i => master_clkout0,
    o => master_bcoclk
  );

  master_fb_bufg_imp : bufg
  port map (
    i => master_fb,
    o => master_fb_bufg
  );

  slave_pll_imp : plle2_adv
  generic map (
    bandwidth => "HIGH",
    clkin1_period => 25.000,
    clkin2_period => 25.000,
    clkfbout_mult => 40,
    clkout0_divide => 40,
    clkout1_divide => 20,
    clkout2_divide => 10
  )
  port map (
    clkin2 => master_bcoclk,
    clkin1 => fpclka,
    clkinsel => sysclk_sel,   -- low selects clkin2
    clkfbin => slave_fb_bufg,
    rst => amc502_csr(25),
    pwrdwn => '0',
    daddr => slave_pll_daddr,
    di => slave_pll_di,
    dwe => slave_pll_dwe,
    den => slave_pll_den,
    dclk => busclk,
    clkfbout => slave_fb,
    clkout0 => slave_clkout0,
    clkout1 => slave_clkout1,
    clkout2 => slave_clkout2,
    clkout3 => open,
    clkout4 => open,
    clkout5 => open,
    locked => pll_locked(1),
    do => slave_pll_do,
    drdy => slave_pll_drdy
  );

  slave_sysclk2_bufg_imp : bufg
  port map (
    i => slave_clkout2,
    o => slave_sysclk2
  );

  slave_sysclk_bufg_imp : bufg
  port map (
    i => slave_clkout1,
    o => slave_sysclk
  );

  slave_bcoclk_bufg_imp : bufg
  port map (
    i => slave_clkout0,
    o => slave_bcoclk
  );

  slave_fb_bufg_imp : bufg
  port map (
    i => slave_fb,
    o => slave_fb_bufg
  );

  tclkb_imp : tclkb_driver
  port map (
    sysclk => master_sysclk,
    bcoclk => master_bcoclk,
    d => tclkb_cmd,
    dv => tclkb_dv,
    d16 => tclk_data(15 downto 0),
    dv16 => tclk_data_valid,
    ack16 => tclk_data_busy,
    tclkb_out => tclkb
  );

  tclka_imp : tclka_receiver
  port map (
    sysclk => slave_sysclk,
    bcoclk => slave_bcoclk,
    tclka_in => tclka,
    do_idelay => do_idelay,
    idelay_busy => idelay_busy,
    idelay_rst => '0',
    idelay_inc => tclk_data(30),
    idelay_tap => idelay_tap,
    strobe => tclka_strobe
  );

  count_imp : tclka_counter
  port map (
    clk => slave_bcoclk,
    strobe => tclka_strobe,
    stop => stop_timer,
    sel => amc502_csr(11 downto 8),
    count => tclk_counters,
    timer => tclk_timer,
    reset => tclka_counter_reset,
    busy => counter_reset_busy 
  );

  latch_imp : latch_generator
  port map (
    bcoclk => slave_bcoclk,
    strobe => do_latch,
    busy => latch_busy,
    period => latch_control(15 downto 0),
    count => latch_control(23 downto 16),
    latch => latch_cmd
  );

  event_imp : event_generator
  port map (
    bcoclk => slave_bcoclk,
    strobe => do_event,
    busy => event_busy,
    period => event_control(15 downto 0),
    count => event_control(23 downto 16),
    bco_counter => bco_counter,
    xgmii_clk => xgbe_stream_clk,
    dout => xgbe_stream_dout,
    wren => xgbe_stream_wren,
    send => xgbe_stream_strobe,
    debug => event_generator_debug
  );

  trig_imp : trigger
  port map (
    clk_in => xgbe_stream_clk,
    run => trigger_csr(15),
    trig_in => xgbe_trigger_stream_data,
    write_en => xgbe_trigger_stream_enable,
    addr_in => trigger_csr(7 downto 0),
    trig_data => trigger_spy,
    bcoclk => slave_bcoclk,
    bco_set => bco_counter,
    set_bco => trigger_csr(14),
    trig_out => trigger_word,
    trig_bco => trigger_bco
  );

  g: for i in 0 to 4+nclock generate
    clkfreq_imp : clkfreq
    port map (
      clk100mhz => busclk,
      onepps => one_pulse_per_second,
      clk => fpclk_internal(i),
      count => freq(i)
    );
  end generate;

  bco_imp : counter_load_macro
  generic map (
    count_by => x"000000000001",
    device => "7SERIES",
    width_data => 48
  )
  port map (
    clk => slave_bcoclk,
    ce => bco_count_load_enable,
    load => bco_count_load,
    rst => bco_count_reset,
    direction => '1',
    load_data => write_bco_counter,
    q => bco_counter
  );
  bco_count_reset <= amc502_csr(17);
  bco_count_load_enable <= bco_count_enabled or bco_count_load;
  bco <= bco_counter;

  process ( slave_bcoclk ) begin
    if ( slave_bcoclk'event and slave_bcoclk = '1' ) then
--  synchronous halt command
      if ( tclka_strobe(13) = '1' ) then    -- halt
        bco_count_enabled <= '0';
--  synchronous run command
      elsif ( tclka_strobe(8) = '1' ) then  -- run
        bco_count_enabled <= '1';
-- request to enable/disable counter
      elsif ( enable_bco_count = '1' ) then
        bco_count_enabled <= amc502_csr(16);
      end if;

      if ( do_bco_load = '1' ) then
        if ( bco_count_load = '0' ) then
          bco_count_load <= '1';
        else
          bco_loaded <= '1';
        end if;
      else
        bco_count_load <= '0';
        bco_loaded <= '0';
      end if;
    end if;
  end process;

  process ( busclk )
    variable i : integer range 0 to 63;
  begin
    if ( busclk'event and busclk= '1' ) then
      event_busy_r <= event_busy;
      i2c_ready_r <= i2c_ready;
      tclk_count <= tclk_counters;

      if ( bco_count_enabled = '1' ) then
        enable_bco_count <= '0';
      end if;
      if ( bco_loaded = '1' ) then
        do_bco_load <= '0';
      end if;

      if ( i2c_ready_r = '0' ) then
        i2c_strobe <= '0';
      end if;
      if ( tclk_data_busy = '1' ) then
        tclk_data_valid <= '0';
      end if;
      if ( do_idelay = '1' and idelay_busy = '1' ) then
        do_idelay <= '0';
      end if;
      if ( counter_reset_busy = '1' ) then
        tclka_counter_reset <= '0';
      end if;
      if ( slave_pll_drdy = '1' ) then
        slave_pll_den <= '0';
        slave_pll_dwe <= '0';
      end if;
      if ( clock_load_done = '1' ) then
        clock_load_now <= '0';
        clock_load_time <= ( others => '0' );
      end if;
      if ( latch_busy = '1' and latch_control(23 downto 16) /= x"00" ) then
        do_latch <= '0';
      end if;
      if ( event_busy_r = '1' and event_control(23 downto 16) /= x"00" ) then
        do_event <= '0';
      end if;

      if ( iobus.io_addr_strobe = '1' and masked_address = base_address ) then
        iobus_ready <= '1';
        if ( iobus.io_write_strobe = '1' ) then
          case iobus.io_address(15 downto 0) is
            when address_amc502_csr =>
              amc502_csr <= iobus.io_write_data;
              enable_bco_count <= '1';    -- Request to enable bco counter
            when address_i2c_l1 =>
              i2c_address <= iobus.io_write_data(7 downto 1);
              i2c_rw <= iobus.io_write_data(0);
              i2c_len <= iobus.io_write_data(15 downto 8);

              if ( i2c_ready_r = '1' ) then
                i2c_strobe <= '1';
              end if;
            when address_tclk_data =>
              if ( tclk_data_busy = '0' ) then
                tclk_data_valid <= not iobus.io_write_data(31);
              end if;
              if ( idelay_busy = '0' ) then
                do_idelay <= iobus.io_write_data(31);
              end if;
              tclk_data <= iobus.io_write_data;
            when address_tclka_count_lo =>
              if ( iobus.io_write_data = x"00000000" ) then
                tclka_counter_reset <= '1';
              end if;
            when address_tclka_count_hi =>
              if ( iobus.io_write_data = x"00000000" ) then
                tclka_counter_reset <= '1';
              end if;
            when address_slave_pll =>
              slave_pll_daddr <= iobus.io_write_data(22 downto 16);
              slave_pll_di <= iobus.io_write_data(15 downto 0);
              slave_pll_dwe <= iobus.io_write_data(31);
              slave_pll_den <= '1';
            when address_clock_time =>
              clock_load_now <= '1';
              clock_load_time <= iobus.io_write_data;
            when address_latch =>
              latch_control <= iobus.io_write_data;
              do_latch <= iobus.io_write_data(31);
            when address_event =>
              event_control <= iobus.io_write_data;
              do_event <= iobus.io_write_data(31);
            when address_bco_counter_hi =>
              write_bco_counter(47 downto 32) <= iobus.io_write_data(15 downto 0);
              do_bco_load <= '1';
            when address_bco_counter_lo =>
              write_bco_counter(31 downto 0) <= iobus.io_write_data;
              do_bco_load <= '1';
            when address_trigger_csr =>
              trigger_csr <= iobus.io_write_data;
            when others =>
              if ( iobus.io_address(15 downto 8) = address_i2c_wbuf(15 downto 8) ) then
                i := to_integer(unsigned(iobus.io_address(7 downto 2)));
                for j in 0 to 3 loop
                  i2c_wbuf(4*i+j) <= iobus.io_write_data(8*j+7 downto 8*j);
                end loop;
              end if;
          end case;
        end if;

        if ( iobus.io_read_strobe = '1' ) then
          case iobus.io_address(15 downto 0) is
            when address_amc502_csr =>
              latched_data <= amc502_csr(31 downto 28) & pll_locked & amc502_csr(25 downto 18) & bco_count_reset & bco_count_enabled & amc502_csr(15 downto 0);
            when address_i2c_l1 =>
              latched_data <= i2c_busy & i2c_nack & "000000" & i2c_nbyte & i2c_len & i2c_address & i2c_rw;
            when address_i2c_addr_lllx =>
              latched_data <= i2c_addr_lllx;
            when address_i2c_data_lllx =>
              latched_data <= i2c_data_lllx;
            when address_tclk_data =>
              latched_data <= idelay_busy & tclk_data(30) & idelay_tap & tclk_data(23 downto 0);
            when address_tclka_count_lo =>
              latched_data <= tclk_count(31 downto 0);
            when address_tclka_count_hi =>
              latched_data <= x"0000" & tclk_count(47 downto 32);
            when address_tclka_timer_lo =>
              latched_data <= tclk_timer(31 downto 0);
            when address_tclka_timer_hi =>
              latched_data <= x"0000" & tclk_timer(47 downto 32);

            when address_slave_pll =>
              latched_data <= slave_pll_drdy & "00000000" & slave_pll_daddr & slave_pll_do;
            when address_clock_time =>
              latched_data <= std_logic_vector(clock_time);
            when address_latch =>
              latched_data <= latch_busy & latch_control(30 downto 0);
            when address_event =>
              latched_data <= event_busy_r & event_control(30 downto 0);
            when address_bco_counter_lo =>
              latched_data <= bco_counter(31 downto 0);
            when address_bco_counter_hi =>
              latched_data <= x"0000" & bco_counter(47 downto 32);
            when address_trigger_csr =>
              latched_data <= trigger_csr;
            when address_trigger_spy_lo =>
              latched_data <= trigger_spy(31 downto 0);
            when address_trigger_spy_hi =>
              latched_data <= trigger_spy(63 downto 32);
            when others =>
              i := to_integer(unsigned(iobus.io_address(7 downto 2))-unsigned(address_freq(7 downto 2)));
              if ( i >= 0 and i <= 4+nclock ) then
                latched_data <= freq(i);
              else
                latched_data <= x"f8f8f8f8";
              end if;
              if ( iobus.io_address(15 downto 8) = address_i2c_wbuf(15 downto 8) ) then
                i := to_integer(unsigned(iobus.io_address(7 downto 2)));
                for j in 0 to 3 loop
                  latched_data(8*j+7 downto 8*j) <= i2c_wbuf(4*i+j);
                end loop;
              end if;
              if ( iobus.io_address(15 downto 8) = address_i2c_rbuf(15 downto 8) ) then
                i := to_integer(unsigned(iobus.io_address(7 downto 2)));
                for j in 0 to 3 loop
                  latched_data(8*j+7 downto 8*j) <= i2c_rbuf(4*i+j);
                end loop;
              end if;
          end case;
        end if;
      else
        iobus_ready <= '0';
        latched_data <= ( others => '0' );
      end if;
    end if;
  end process;

  process ( busclk, clock_load_now ) begin
    if ( busclk'event and busclk = '1' ) then
      if ( clock_load_now = '1' ) then
        clock_time <= unsigned(clock_load_time);
        clock_load_done <= '1';
      else
        clock_load_done <= '0';
      end if;
      if ( fast_counter = fast_modulus ) then
        fast_counter <= ( others => '0' );
        clock_time <= clock_time + 1;
        one_pulse_per_second <= '1';
      else
        fast_counter <= fast_counter + 1;
        one_pulse_per_second <= '0';
      end if;
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

      if ( i2c_strobe = '1' and i2c_ready_r = '1' ) then
        i2c_addr <= 0;
        i2c_next_addr <= '0';
      elsif ( i2c_next_addr = '1' ) then
        i2c_addr <= i2c_addr + 1;
        i2c_next_addr <= '0';
      end if;

      if ( i2c_den = '1' ) then
        i2c_din <= i2c_wbuf(i2c_addr);
        i2c_next_addr <= '1';
      end if;

      if ( i2c_wen = '1' ) then
        i2c_rbuf(i2c_addr) <= i2c_dout;
        i2c_next_addr <= '1';
      end if;

    end if;
  end process;

  bcoclk <= slave_bcoclk;
  sysclk <= slave_sysclk;
  sysclk2 <= slave_sysclk2;

  fei4_lv1 <= '0';   -- just for now...

  tclkb_cmd <= latch_control(27 downto 24) when latch_cmd = '1' else ( others => '0' );
  tclkb_dv <= '1' when latch_cmd = '1' else '0';

  i2c_busy <= i2c_strobe or not i2c_ready_r;
  fpclk_internal(0) <= master_bcoclk;
  fpclk_internal(1) <= master_sysclk;
  fpclk_internal(2) <= slave_bcoclk;
  fpclk_internal(3) <= slave_sysclk;
  fpclk_internal(4) <= fpclkb;
  fpclk_internal(4+nclock downto 5) <= fpclk(nclock-1 downto 0);

  masked_address <= iobus.io_address(31 downto 16) and address_mask;
  write_data <= latched_data;

  systrig <= '1' when trigger_word = x"0009" else '0';

  onepps <= one_pulse_per_second;

  cmd_strobe <= tclka_strobe;

  uled(0) <= amc502_csr(0);
  uled(1) <= amc502_csr(1);
  uled(2) <= amc502_csr(2);
  uled(3) <= flasher;
  uled_select <= amc502_csr(7);
  pll_rst_n <= not amc502_csr(31);
  sysclk_sel <= amc502_csr(30);

end RTL;
