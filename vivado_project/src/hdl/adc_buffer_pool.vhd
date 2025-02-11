----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/13/2016 09:07:53 AM
-- Design Name: 
-- Module Name: adc_buffer_pool - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adc_buffer_pool is
  generic (
    nbuf : integer := 4;
    buffer_size : integer := 1024;
    address_width : integer := 8;
    input_width : integer := 64
  );
  port (
    rst : in STD_LOGIC;
    clk_a : in STD_LOGIC;
    buffer_offset : in std_logic_vector(address_width-1 downto 0);
    wen_a : in std_logic;
    din_a : in std_logic_vector(input_width-1 downto 0);
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
end adc_buffer_pool;

architecture Behavioral of adc_buffer_pool is

  function nbits( n : integer ) return natural is
    variable i : natural;
  begin
    i := 0;
    while ( 2**i < n ) loop
      i := i + 1;
    end loop;
    return i;
  end function;

  component lfsr_n
  generic (
    width : integer := 4
  );
  port (
    rst : in std_logic;
    clk : in std_logic;
    en : in std_logic;
    dout : out std_logic_vector(width-1 downto 0);
    prev : out std_logic_vector(width-1 downto 0)
  );
  end component;

  component lfsr
  generic (
    width : integer := 4
  );
  port (
    rst : in std_logic;
    clk : in std_logic;
    en : in std_logic;
    dout : out std_logic_vector(width-1 downto 0);
    load : in std_logic;
    din : in std_logic_vector(width-1 downto 0)
  );
  end component;

  component adc_buffer
  generic (
    address_width : integer := 8
  );
  port (
    clka : in std_logic;
    wea : in std_logic;
    addra : in std_logic_vector(address_width-1 downto 0);
    dina : in std_logic_vector(31 downto 0);
    clkb : in std_logic;
    addrb : in std_logic_vector(address_width-1 downto 0);
    rdenb : in std_logic;
    doutb : out std_logic_vector(35 downto 0)
  );
  end component;
 
  constant bwidth : natural := nbits(buffer_size)-2;
  constant nbwidth : natural := nbits(nbuf);
  constant buffer_start : std_logic_vector(bwidth-1 downto 0)  := ( 0 => '1', others => '0' );

  signal parity_error : std_logic_vector(nbuf-1 downto 0);
  signal din : std_logic_vector(input_width-1 downto 0);
  signal count_word_a : std_logic_vector(input_width-1 downto 0);
  signal count_word_b : std_logic_vector(input_width-1 downto 0);
--  type din_array_t is array(nbuf-1 downto 0) of std_logic_vector(input_width/2-1 downto 0);
--  signal latched_data_a : din_array_t;
--  signal latched_data_b : din_array_t;
  
  type read_data_t is array(nbuf-1 downto 0) of std_logic_vector(35 downto 0);
  signal read_data_a : read_data_t;
  signal read_data_b : read_data_t;
  signal read_data : read_data_t;

  type trigger_bits_t is array(nbuf-1 downto 0) of std_logic_vector(7 downto 0);
  signal trigger_bits : trigger_bits_t;

  signal buffer_busy : std_logic_vector(nbuf-1 downto 0) := ( others => '0' );
  signal last_buffer_busy : std_logic_vector(nbuf-1 downto 0);
  signal free_buffer : std_logic_vector(nbuf-1 downto 0) := ( others => '0' );
  signal latched_free_buffer : std_logic_vector(nbuf-1 downto 0) := ( others => '0' );
  type addr_t is array(nbuf-1 downto 0) of std_logic_vector(bwidth-1 downto 0);
  signal waddr : addr_t;
  signal paddr : addr_t;
  signal raddr : addr_t;
  signal latched_waddr : addr_t;
  signal latched_paddr : addr_t;
  signal latched_raddr : addr_t;

  signal waddr_en : std_logic_vector(nbuf-1 downto 0) := ( others => '1' );
  signal gated_waddr_en : std_logic_vector(nbuf-1 downto 0) := ( others => '0' );
  signal paddr_en : std_logic_vector(nbuf-1 downto 0);
  signal gated_paddr_en : std_logic_vector(nbuf-1 downto 0) := ( others => '0' );
  signal raddr_en : std_logic_vector(nbuf-1 downto 0);
  signal raddr_load : std_logic_vector(nbuf-1 downto 0);
  signal waddr_load : std_logic_vector(nbuf-1 downto 0);
  signal triggered : std_logic_vector(nbuf-1 downto 0) := ( others => '0' );
  signal last_trig : std_logic;
  signal current_buffer : unsigned(nbwidth-1 downto 0) := ( others => '1');
  signal read_buffer : unsigned(nbwidth-1 downto 0) := ( others => '0' );
  signal read_token : std_logic_vector(nbuf-1 downto 0) := ( 0 => '1', others => '0' );
  signal read_wrapped : std_logic_vector(nbuf-1 downto 0) := ( others => '0' );
  signal upper_word : std_logic := '0';
  signal buffer_full : std_logic_vector(nbuf-1 downto 0);
  signal done : std_logic;
  signal count_a : unsigned(9 downto 0) := ( others => '0' );
  signal count_b : unsigned(13 downto 0) := ( others => '0' );

  type sum_array_t is array(15 downto 0) of signed(19 downto 0);
  signal sum_array : sum_array_t := ( others => ( others => '0' ) );
  signal sum_pipe : sum_array_t := ( others => ( others => '0' ) );

  attribute mark_debug : string;
  attribute mark_debug of raddr : signal is "true";
  attribute mark_debug of waddr : signal is "true";
  attribute mark_debug of paddr : signal is "true";
  attribute mark_debug of raddr_en : signal is "true";
  attribute mark_debug of waddr_en : signal is "true";
  attribute mark_debug of paddr_en : signal is "true";
  attribute mark_debug of trig : signal is "true";
  attribute mark_debug of done : signal is "true";
  attribute mark_debug of buffer_busy : signal is "true";
  attribute mark_debug of buffer_full : signal is "true";
  attribute mark_debug of read_data_a : signal is "true";
  attribute mark_debug of read_data_b : signal is "true";

begin

  g_addr : for i in 0 to nbuf-1 generate
    waddr_imp : lfsr
    generic map (
      width => bwidth
    )
    port map (
      rst => rst,
      clk => clk_a,
      en => gated_waddr_en(i),
      dout => waddr(i),
      load => waddr_load(i),
      din => buffer_offset
    );

    paddr_imp : lfsr
    generic map (
      width => bwidth
    )
    port map (
      rst => rst,
      clk => clk_a,
      en => gated_paddr_en(i),
      dout => paddr(i),
      load => waddr_load(i),
      din => buffer_start
    );

    raddr_imp : lfsr
    generic map (
      width => bwidth
    )
    port map (
      rst => rst,
      clk => clk_b,
      en => raddr_en(i),
      dout => raddr(i),
      load => raddr_load(i),
      din => paddr(i)
    );
  end generate;

  g_buf : for i in 0 to nbuf-1 generate

    buf_a_imp : adc_buffer
    generic map (
      address_width => address_width
    )
    port map (
      clka => clk_a,
      wea => wen_a,
      addra => waddr(i),
      dina => din(63 downto 32),
      clkb => clk_b,
      addrb => raddr(i),
      rdenb => raddr_en(i),
      doutb => read_data_a(i)
    );

    buf_b_imp : adc_buffer
    generic map (
      address_width => address_width
    )
    port map (
      clka => clk_a,
      wea => wen_a,
      addra => waddr(i),
      dina => din(31 downto 0),
      clkb => clk_b,
      addrb => raddr(i),
      rdenb => raddr_en(i),
      doutb => read_data_b(i)
    );

    process ( clk_a ) begin
      if ( clk_a'event and clk_a = '1' ) then
        if ( paddr_en(i) = '1' ) then
          latched_paddr(i) <= paddr(i);
          latched_waddr(i) <= waddr(i);
        end if;
      end if;
    end process;

--    read_data(i) <= read_data_a(i) when upper_word = '1' else read_data_b(i);

  end generate;

  din <= din_a when testmode = "0000" else
         count_word_a when testmode = "1001" else
         count_word_b when testmode = "1000" else ( others => '0' );

  count_word_a <= std_logic_vector(count_a) & "110000" & 
                  std_logic_vector(count_a) & "100000" & 
                  std_logic_vector(count_a) & "010000" & 
                  std_logic_vector(count_a) & "000000";
  count_word_b <= std_logic_vector(count_b) & "11" & 
                  std_logic_vector(count_b) & "10" & 
                  std_logic_vector(count_b) & "01" & 
                  std_logic_vector(count_b) & "00";

  process ( clk_a ) begin
    if ( clk_a'event and clk_a = '1' ) then
      if ( rst = '1' ) then
        buffer_busy <= ( others => '0' );
        current_buffer <= ( others => '1' );
        paddr_en <= ( others => '1' );
        waddr_en <= ( others => '1' );
        waddr_load <= ( others => '1' );
        count_a <= ( others => '0' );
        count_b <= ( others => '0' );
      else
        count_a <= count_a + 1;
        count_b <= count_b + 1;
        latched_free_buffer <= free_buffer;
        waddr_load <= free_buffer and not latched_free_buffer;
        for i in 0 to nbuf-1 loop
          if ( free_buffer(i) = '1' ) then
            buffer_busy(i) <= '0';
            paddr_en(i) <= '1';
            waddr_en(i) <= '1';
          end if;
        end loop;
        if ( trig = '1' and last_trig = '0' ) then
          paddr_en(to_integer(current_buffer+1)) <= '0';
          triggered(to_integer(current_buffer+1)) <= '1';
          buffer_busy(to_integer(current_buffer+1)) <= '1';
          trigger_bits(to_integer(current_buffer+1)) <= trigbits_a;
          current_buffer <= current_buffer + 1;
        end if;
        for i in 0 to nbuf-1 loop
          if ( triggered(i) = '1' and paddr_en(i) = '0' and
               waddr(i) = paddr(i) ) then
            waddr_en(i) <= '0';
            triggered(i) <= '0';
          end if;
        end loop;
      end if;
      last_trig <= trig;
    end if;
  end process;

  gated_waddr_en <= waddr_en;
  gated_paddr_en <= paddr_en;

--
--  Busy is asserted when data is available to be read.
--  When busy is detected by the clk_b process, the read address is
--  loaded with the pre-trigger data.  When rden_b is asserted, data is
--  presented on dout_b.
--

  process ( clk_b )
    variable status : std_logic_vector(31 downto 0);
  begin
    if ( clk_b'event and clk_b = '1' ) then
      if ( rst = '1' ) then
        read_buffer <= ( others => '0' );
        free_buffer <= ( others => '0' );
        read_token <= ( 0 => '1', others => '0' );
        upper_word <= '0';
      else
        if ( buffer_busy(to_integer(read_buffer)) = '1' and
             raddr(to_integer(read_buffer)) = latched_paddr(to_integer(read_buffer)) ) then
          done <= '1';
        else
          done <= '0';
        end if;
--
--  Is this a race condition or not?
--
        last_buffer_busy <= buffer_busy;
        raddr_load <= buffer_busy and not last_buffer_busy;
        if ( rden_b = '1' ) then
          upper_word <= not upper_word;
          if ( raddr(to_integer(read_buffer)) =
               latched_paddr(to_integer(read_buffer)) ) then
            if ( read_wrapped(to_integer(read_buffer)) = '0' ) then
              read_wrapped(to_integer(read_buffer)) <= '1';
            else
              read_wrapped(to_integer(read_buffer)) <= '0';
              free_buffer <= read_token;
              read_buffer <= read_buffer + 1;
              read_token <= read_token(nbuf-2 downto 0) & read_token(nbuf-1);
            end if;
          end if;
        end if;
      end if;
      status_b <= ( others => '0' );
      trigbits_b <= trigger_bits(to_integer(read_buffer));
    end if;
  end process;

--
--  This infers some multiplexers
--
  process ( rden_b, upper_word, triggered, read_data_a, read_data_b,
            latched_waddr, latched_paddr, read_buffer, read_data )
    variable data : std_logic_vector(31 downto 0);
    variable rden : std_logic_vector(nbuf-1 downto 0);
    variable full : std_logic_vector(nbuf-1 downto 0);
  begin
    rden := ( others => '0' );
    full := ( others => '0' );
    data := x"f8f8f8f8";
    for i in 0 to nbuf-1 loop
      if ( triggered(i) = '1' and latched_waddr(i) = latched_paddr(i) ) then
        full(i) := '1';
      end if;
      if ( read_buffer = i ) then
        if ( upper_word = '1' ) then
          data := read_data_a(i)(31 downto 0);
          rden(i) := rden_b;
        else
          data := read_data_b(i)(31 downto 0);
          rden(i) := '0';
        end if;
      end if;
    end loop;
    dout_b <= data;
    raddr_en <= rden;
    buffer_full <= full;
  end process;

--
--  The non-triggered buffers write to waddr, and advance both paddr and waddr.
--  After a buffer has been triggered, paddr does not advance, and waddr
--  advances until it equals paddr.
--

  process ( buffer_busy, waddr_en )
    variable vbusy : std_logic;
    variable vfull : std_logic;
    variable vready : std_logic;
  begin
    vbusy := '0';
    vready := '0';
    vfull := '1';
    for i in 0 to nbuf-1 loop
      if ( buffer_busy(i) = '1' ) then
        vbusy := '1';
      else
        vfull := '0';
      end if;
      if ( waddr_en(i) = '0' ) then
        vready := '1';
      end if;
    end loop;
    busy <= vbusy;
    full <= vfull;
    ready <= vready;
  end process;

  done_b <= done;
  wa <= waddr(to_integer(current_buffer));
  pa <= paddr(to_integer(current_buffer));

end Behavioral;
