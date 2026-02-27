----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/31/2018 07:20:02 PM
-- Design Name: 
-- Module Name: trigger_in - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description:   Infer a dual-port RAM for the trigger pipeline input
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

library hep337dev;
use hep337dev.validation.all;

entity trigger_in is
port (
  rst : in std_logic;
  clk_a : in std_logic;
  bco_a : in std_logic_vector(47 downto 0);
  data_a : in std_logic_vector(15 downto 0);
  clk_b : in std_logic;
  ready_b : out std_logic;
  count_b : out std_logic_vector(7 downto 0);
  send_b : in std_logic;
  data_b : out std_logic_vector(63 downto 0);
  dv_b : out std_logic
);
end trigger_in;

architecture Behavioral of trigger_in is

  type ram_t is array(255 downto 0) of std_logic_vector(63 downto 0);
  shared variable ram : ram_t := ( others => ( others => '0' ) );
  signal data : std_logic_vector(63 downto 0);
  signal waddr : std_logic_vector(9 downto 0);
  signal raddr : std_logic_vector(7 downto 0);
  signal count : std_logic_vector(7 downto 0);
  signal zero_count : std_logic_vector(7 downto 0);
  signal zero_count_r : std_logic_vector(7 downto 0);
  signal zero_b : std_logic;
  signal add : std_logic := '0';
  signal add_r : std_logic := '0';
  signal done_add : std_logic := '0';
  signal done_add_r : std_logic := '0';
  signal read_counter : std_logic_vector(4 downto 0);
  signal sending : std_logic;
  signal dumping : std_logic;
  signal latched_bco : std_logic_vector(47 downto 0);

  attribute mark_debug : string;
  attribute mark_debug of count : signal is "true";
  attribute mark_debug of add : signal is "true";
  attribute mark_debug of done_add : signal is "true";
  attribute mark_debug of sending : signal is "true";
  attribute mark_debug of dumping : signal is "true";
  attribute mark_debug of zero_b : signal is "true";
  attribute mark_debug of zero_count_r : signal is "true";

begin

  process ( clk_a )
    variable data : std_logic_vector(63 downto 0);
  begin
    if ( clk_a'event and clk_a = '1' ) then
      data := ram(to_integer(unsigned(waddr(9 downto 2))));
      case waddr(1 downto 0) is
      when "00" =>
        data(15 downto 0) := data_a;
      when "01" =>
        data(31 downto 16) := data_a;
      when "10" =>
        data(47 downto 32) := data_a;
      when "11" =>
        data(63 downto 48) := data_a;
      when others =>
      end case;
      ram(to_integer(unsigned(waddr(9 downto 2)))) := data;
    end if;
  end process;

  process ( clk_b ) begin
    if ( clk_b'event and clk_b = '1' ) then
      data <= ram(to_integer(unsigned(raddr)));
    end if;
  end process;

  process ( clk_a ) begin
    if ( clk_a'event and clk_a = '1' ) then
      done_add_r <= done_add;
      if ( rst = '1' ) then
        waddr <= "0000000000";
        zero_count <= ( others => '0' );
      else
        waddr <= std_logic_vector(unsigned(waddr)+1);
        if ( data_a /= x"0000" ) then
          zero_count <= ( others => '0' );
        elsif ( zero_count /= "11111111" ) then
          zero_count <= std_logic_vector(unsigned(zero_count)+1);
        end if;
        if ( done_add_r = '0' ) then
          if ( waddr(1 downto 0) = "00" ) then
            add <= '1';
          end if;
        else
          add <= '0';
        end if;
      end if;
    end if;
  end process;

  process ( clk_b )
    variable new_count : std_logic_vector(7 downto 0);
  begin
    if ( clk_b'event and clk_b = '1' ) then
      add_r <= add;
      zero_count_r <= zero_count;
      if ( rst = '1' ) then
        raddr <= "00000000";
        count <= ( others => '0' );
        sending <= '0';
        dumping <= '0';
      else
        new_count := count;
        if ( done_add = '0' ) then
          if ( add_r = '1' ) then
            new_count := std_logic_vector(unsigned(new_count)+4);
            done_add <= '1';
          end if;
        else
          if ( add_r = '0' ) then
            done_add <= '0';
          end if;
        end if;

        if ( sending = '0' and send_b = '1' ) then
          sending <= '1';
          read_counter <= ( others => '0' );
        end if;
        if ( dumping = '0' and zero_b = '1' ) then
          dumping <= '1';
          read_counter <= ( others => '0' );
        end if;
        if ( sending = '1' ) then
          if ( read_counter = "10000" ) then
            sending <= '0';
            latched_bco <= bco_a;
          elsif ( read_counter = "00000" ) then
            read_counter <= std_logic_vector(unsigned(read_counter)+1);
            raddr <= std_logic_vector(unsigned(raddr)+1);
          else
            read_counter <= std_logic_vector(unsigned(read_counter)+1);
            new_count := std_logic_vector(unsigned(new_count)-4);
            raddr <= std_logic_vector(unsigned(raddr)+1);
          end if;
        end if;
        if ( dumping = '1' ) then
          if ( read_counter = "10000" ) then
            dumping <= '0';
            latched_bco <= bco_a;
          elsif ( read_counter = "00000" ) then
            read_counter <= std_logic_vector(unsigned(read_counter)+1);
            raddr <= std_logic_vector(unsigned(raddr)+1);
          else
            read_counter <= std_logic_vector(unsigned(read_counter)+1);
            new_count := std_logic_vector(unsigned(new_count)-4);
            raddr <= std_logic_vector(unsigned(raddr)+1);
          end if;
        end if;
        count <= new_count;
      end if;
    end if;
  end process;

  count_b <= count;
  ready_b <= '1' when to_integer(unsigned(count)) > 64 and
                      to_integer(unsigned(zero_count_r)) < 96 else '0';
  zero_b <= '1' when to_integer(unsigned(count)) > 64 and
                     to_integer(unsigned(zero_count_r)) >= 96 else '0';
  dv_b <= sending;
  data_b <= data when read_counter /= "00000" else x"8000" & latched_bco;

end Behavioral;
