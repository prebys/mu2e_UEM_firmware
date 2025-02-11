--------------------------------------------------------------------------------
--
-- Company:
-- Engineer:       Matthew Jones - Purdue University
-- 
-- Create Date:    14:25:51 06/14/2016 
-- Design Name:    amc502
-- Module Name:    lmk_spi - RTL
-- Project Name:   amc502 firmware
-- Target Devices: xc5k420tffv1156-1
-- Tool versions:  Vivado 2016.1
-- Description:    SPI interface to LMK04828 PLL
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity lmk_spi is
  port (  
    clk : in std_logic;
    strobe : in std_logic;
    ready : out std_logic;
    dout : in std_logic_vector(23 downto 0);
    din : out std_logic_vector(7 downto 0);
    sclk : out std_logic;
    cs : out std_logic;
    sdi : out std_logic;
    sdo : in std_logic;
    sdir : out std_logic
  );
end lmk_spi;

architecture RTL of lmk_spi is

  signal i : integer range 0 to 23;
  type state_t is ( Idle, Command, CmdClock, Write, WriteClock, Read, ReadClock, Done );
  signal state : state_t := Idle;
  signal read_reg : std_logic_vector(7 downto 0);

begin

  process ( clk ) begin
    if ( clk'event and clk = '1' ) then
--      if ( count = "11" ) then
        case state is
          when Idle =>
            sdir <= '0';
            sclk <= '0';
            cs <= '1';
            ready <= '1';
            i <= 23;
            if ( strobe = '1' ) then
              state <= Command;
            end if;
          when Command =>
            ready <= '0';
            cs <= '0';
            sdir <= '1';
            sclk <= '0';
            sdi <= dout(i);
            state <= CmdClock;
          when CmdClock =>
            ready <= '0';
            cs <= '0';
            sdir <= '1';
            sclk <= '1';
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
            cs <= '0';
            sdir <= '1';
            sclk <= '0';
            sdi <= dout(i);
            state <= WriteClock;
          when WriteClock =>
            ready <= '0';
            cs <= '0';
            sdir <= '1';
            sclk <= '1';
            if ( i = 0 ) then
              state <= Done;
            else
              i <= i - 1;
              state <= Write;
            end if;
          when Read =>
            ready <= '0';
            cs <= '0';
            sdir <= '0';
            sclk <= '0';
            state <= ReadClock;
          when ReadClock =>
            ready <= '0';
            cs <= '0';
            sdir <= '0';
            sclk <= '1';
            read_reg(i) <= sdo;
            if ( i = 0 ) then
              state <= Done;
            else
              i <= i - 1;
              state <= Read;
            end if;
          when Done =>
            cs <= '1';
            sclk <= '1';
            sdir <= '0';
            din <= read_reg; 
            if ( strobe = '0' ) then
              ready <= '1';
              state <= Idle;
            else
              ready <= '0';
              state <= Done;
            end if;
        end case;
      end if;
--      count <= count + 1;
--    end if;
  end process;

end RTL;
