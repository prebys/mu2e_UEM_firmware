--------------------------------------------------------------------------------
--
-- Company:
-- Engineer:       Matthew Jones - Purdue University
-- 
-- Create Date:    14:25:51 06/14/2016 
-- Design Name:    amc502
-- Module Name:    hmc_spi - RTL
-- Project Name:   amc502 firmware
-- Target Devices: xc5k420tffv1156-1
-- Tool versions:  Vivado 2016.1
-- Description:    SPI interface to HMC835LP6GE
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity hmc_spi is
  port (  
    clk : in std_logic;
    strobe : in std_logic;
    ready : out std_logic;
    dout : in std_logic_vector(31 downto 0);
    din : out std_logic_vector(31 downto 0);
    sck : out std_logic;
    sen : out std_logic;
    sdo : in std_logic;
    sdi : out std_logic
  );
end hmc_spi;

architecture RTL of hmc_spi is

  signal i : integer range 0 to 31;
  signal j : integer range 0 to 31;

  type state_t is ( Idle, Write, Clock, Latch, Done );
  signal state : state_t := Idle;

begin

  process ( clk ) begin
    if ( clk'event and clk = '1' ) then
      case state is
        when Idle =>
          sck <= '1';
          sen <= '1';
          ready <= '1';
          i <= 31;
          j <= 0;
          if ( strobe = '1' ) then
            state <= Write;
          end if;
        when Write =>
          ready <= '0';
          sen <= '1';
          sck <= '0';
          sdi <= dout(i);
          din(j) <= sdo;
          state <= Clock;
        when Clock =>
          ready <= '0';
          sck <= '1';
          j <= i;
          if ( i = 0 ) then
            sen <= '0';
            state <= Latch;
          else
            sen <= '1';
            i <= i - 1;
            state <= Write;
          end if;
        when Latch =>
          din(j) <= sdo;
          sen <= '0';
          sck <= '1';
          sdi <= '0';
          state <= Done;
        when Done =>
          sen <= '1';
          sck <= '1';
          if ( strobe = '0' ) then
            ready <= '1';
            state <= Idle;
          else
            ready <= '0';
            state <= Done;
          end if;
      end case;
    end if;
  end process;

end RTL;
