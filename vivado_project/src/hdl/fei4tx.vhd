----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:23:53 09/11/2013 
-- Design Name: 
-- Module Name:    fei4tx - RTL 
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
library ieee;
use ieee.std_logic_1164.all;

use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity fei4tx is
  port ( reset : in  std_logic;
         strobe : in  std_logic;
         wfe : in std_logic;
         cal : in std_logic;
         trig : in std_logic;
         bcr : in std_logic;
         ecr : in std_logic;
         bco_zero : in std_logic;
         bco_zero_offset : in std_logic_vector(12 downto 0);
         sync_bco_zero : in std_logic;
         ext_cal : in std_logic;
         ext_lv1 : in std_logic;
         disable : in std_logic;
         busy : out std_logic;
         data : in  std_logic_vector (31 downto 0);
         front_end : in  std_logic_vector (671 downto 0);
         outclk : in  std_logic;
         dout : out  std_logic);
end fei4tx;

architecture RTL of fei4tx is

  type state_t is ( idle, shifting, done );
  signal state : state_t := idle;
  signal count : unsigned(9 downto 0);
  signal output_word : std_logic_vector(697 downto 0) := ( others => '0' );

  signal reg_strobe : std_logic;
  signal reg_bcr : std_logic;
  signal reg_ecr : std_logic;
  signal reg_trig : std_logic;
  signal reg_cal : std_logic;
  signal sync_bco : std_logic;
  signal reg_dout : std_logic;
  signal bco : unsigned(12 downto 0);

begin

  process ( outclk, trig, ecr, bcr, cal, strobe ) begin
    if ( outclk'event and outclk = '1' ) then
      reg_trig <= trig;
      reg_ecr <= ecr;
      reg_bcr <= bcr;
      reg_cal <= cal;
      reg_strobe <= strobe;
      sync_bco <= sync_bco_zero;
      if ( bco_zero = '1' ) then
        bco <= ( others => '0' );
      else
        bco <= bco + 1;
      end if;
    end if;
  end process;

  process ( outclk, strobe, ext_lv1, ext_cal ) begin
    if ( outclk'event and outclk = '0' ) then
      case state is
        when idle =>
          if ( reg_trig = '1' or ext_lv1 = '1' ) then
            busy <= '1';
            count <= to_unsigned(8,10);
            output_word(output_word'length-1 downto output_word'length-8) <= "00011101";
            reg_dout <= '0';
            state <= shifting;
          elsif ( reg_cal = '1' or ext_cal = '1' ) then
            busy <= '1';
            count <= to_unsigned(12,10);
            output_word(output_word'length-1 downto output_word'length-12) <= "000101100100";
            reg_dout <= '0';
            state <= shifting;
          elsif ( reg_bcr = '1' and sync_bco = '0' ) then
            busy <= '1';
            count <= to_unsigned(12,10);
            output_word(output_word'length-1 downto output_word'length-12) <= "000101100001";
            reg_dout <= '0';
            state <= shifting;
          elsif ( reg_bcr = '1' and sync_bco = '1' and std_logic_vector(bco) = bco_zero_offset ) then
            busy <= '1';
            count <= to_unsigned(12,10);
            output_word(output_word'length-1 downto output_word'length-12) <= "000101100001";
            reg_dout <= '0';
            state <= shifting;
          elsif ( reg_ecr = '1' ) then
            busy <= '1';
            count <= to_unsigned(12,10);
            output_word(output_word'length-1 downto output_word'length-12) <= "000101100010";
            reg_dout <= '0';
            state <= shifting;
          elsif ( reg_strobe = '1' ) then
            busy <= '1';
            if ( wfe = '0' ) then
              count <= to_unsigned(12+30-1,10);
              output_word(output_word'length-1 downto output_word'length-42) <= "000101101000" & data(29 downto 0);
            else
              count <= to_unsigned(12+14+672-1,10);
              output_word <= "000101101000" & data(29 downto 16) & front_end;
            end if;
            reg_dout <= '0';
            state <= shifting;
          else
            busy <= '0';
            reg_dout <= output_word(output_word'length-1);
            if ( output_word(output_word'length-1 downto output_word'length-7) = "0000000" ) then
              output_word(output_word'length-1 downto output_word'length-7) <= "0000001";
            else
              output_word(output_word'length-1 downto output_word'length-7) <=
                output_word(output_word'length-2 downto output_word'length-7) & '0';
            end if;
          end if;
        when shifting =>
          reg_dout <= output_word(output_word'length-1);
          output_word <= output_word(output_word'length-2 downto 0) & '0';
          if ( count = "0000000000" ) then
            state <= done;
          else
            count <= count - 1;
          end if;
        when done =>
          reg_dout <= '0';
          if ( reg_strobe = '0' and reg_cal = '0' and reg_bcr = '0' and reg_ecr = '0' and reg_trig = '0' ) then
            busy <= '0';
            state <= idle;
          end if;
      end case;
    end if;
  end process;

  dout <= reg_dout;

--  status(4 downto 0) <= strobe & cal & bcr & ecr & trig;
--  status(7 downto 5) <= "000" when state = idle else
--                        "001" when state = shifting else
--                        "010" when state = done;

end RTL;
