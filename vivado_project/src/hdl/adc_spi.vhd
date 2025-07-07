--------------------------------------------------------------------------------
--
-- Company:
-- Engineer:       Matthew Jones - Purdue University
-- 
-- Create Date:    14:25:51 06/14/2016 
-- Design Name:    amc502
-- Module Name:    adc_spi - RTL
-- Project Name:   amc502 firmware
-- Target Devices: xc5k420tffv1156-1
-- Tool versions:  Vivado 2016.1
-- Description:    SPI interface to AD9234 ADC
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity adc_spi is
  port (  
    clk : in std_logic;
    strobe : in std_logic;
    ready : out std_logic;
    dout : in std_logic_vector(23 downto 0);
    din : out std_logic_vector(7 downto 0);
    cs : out std_logic;
    sck : out std_logic;
    sdi : out std_logic;
    sdo : in std_logic;
    spi_dir : out std_logic
  );
end adc_spi;

architecture RTL of adc_spi is

  signal i : integer range 0 to 23;
  type state_t is ( Idle, Command, CmdClock, Write, WriteClock, Read, ReadClock, Done );
  signal state : state_t := Idle;
  signal read_reg : std_logic_vector(7 downto 0);

begin

  process ( clk ) begin
    if ( clk'event and clk = '1' ) then
      case state is
        when Idle =>
          spi_dir <= '0';
          sck <= '0';
          cs <= '1';
          ready <= '1';
          i <= 23;
          if ( strobe = '1' ) then
            state <= Command;
          end if;
        when Command =>
          ready <= '0';
          spi_dir <= '1';
          cs <= '0';
          sck <= '0';
          sdi <= dout(i);
          state <= CmdClock;
        when CmdClock =>
          ready <= '0';
          spi_dir <= '1';
          cs <= '0';
          sck <= '1';
          if ( i = 8 ) then
            i <= 7;
            if ( dout(23) = '1' ) then
              state <= Read;
            else
              state <= Write;
            end if;
          else
            i <= i - 1;
            State <= Command;
          end if;
        when Write =>
          ready <= '0';
          spi_dir <= '1';
          cs <= '0';
          sck <= '0';
          sdi <= dout(i);
          state <= WriteClock;
        when WriteClock =>
          ready <= '0';
          spi_dir <= '1';
          cs <= '0';
          sck <= '1';
          if ( i = 0 ) then
            state <= Done;
          else
            i <= i - 1;
            state <= Write;
          end if;
        when Read =>
          ready <= '0';
          spi_dir <= '0';
          cs <= '0';
          sck <= '0';
          sdi <= '0';
          state <= ReadClock;
        when ReadClock =>
          ready <= '0';
          spi_dir <= '0';
          cs <= '0';
          sck <= '1';
          read_reg(i) <= sdo;
          if ( i = 0 ) then
            state <= Done;
          else
            i <= i - 1;
            state <= Read;
          end if;
        when Done =>
          cs <= '1';
          spi_dir <= '0';
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

  din <= read_reg; 

end RTL;
