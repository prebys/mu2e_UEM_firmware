----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/21/2016 09:26:13 AM
-- Design Name: 
-- Module Name: fei4_pixel_fifo - Behavioral
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

entity fei4_pixel_fifo is
port (
  rst : in std_logic;
  wr_clk : in std_logic;
  rd_clk : in std_logic;
  din : in std_logic_vector(31 downto 0);
  wr_en : in std_logic;
  rd_en : in std_logic;
  dout : out std_logic_vector(31 downto 0);
  full : out std_logic;
  empty : out std_logic;
  valid : out std_logic
);
end fei4_pixel_fifo;

architecture Behavioral of fei4_pixel_fifo is

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

  constant fifo_size : integer := 1024;
  constant addr_width : natural := nbits(fifo_size);

  signal waddr : std_logic_vector(addr_width-1 downto 0);
  signal raddr : std_logic_vector(addr_width-1 downto 0);

  signal latched_waddr : std_logic_vector(waddr'left downto 0);
  signal latched_din : std_logic_vector(din'left downto 0);
  signal latched_wren : std_logic;

  type fifo_t is array(0 to fifo_size-1) of std_logic_vector(31 downto 0);
  signal fifo : fifo_t;

  
begin

--
--  Use Galois LFSR for read and write pointers for fast address increment
--

  waddr_imp : lfsr_n
  generic map (
    width => addr_width
  )
  port map (
    rst => rst,
    clk => wr_clk,
    en => latched_wren,
    dout => waddr,
    prev => open
  );

  raddr_imp : lfsr_n
  generic map (
    width => addr_width
  )
  port map (
    rst => rst,
    clk => rd_clk,
    en => rd_en,
    dout => raddr,
    prev => open
  );

  process ( wr_clk ) begin
    if ( wr_clk'event and wr_clk = '1' ) then
      latched_wren <= wr_en;
      latched_din <= din;
      latched_waddr <= waddr;
      if ( latched_wren = '1' ) then
        fifo(to_integer(unsigned(latched_waddr))) <= latched_din;
      end if;
    end if;
  end process;

  process ( rd_clk ) begin
    if ( rd_clk'event and rd_clk = '1' ) then
      dout <= fifo(to_integer(unsigned(raddr)));
      if ( waddr /= raddr ) then
        valid <= '1';
      else
        valid <= '0';
      end if;
    end if;
  end process;

  empty <= '1' when raddr = waddr else '0';
  full <= '0';

end Behavioral;
