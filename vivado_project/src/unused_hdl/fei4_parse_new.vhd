--------------------------------------------------------------------------------
--
-- Company:
-- Engineer:       Matthew Jones - Purdue University
-- 
-- Create Date:    04:44:19 07/30/2014 
-- Design Name:    genesys_fei4
-- Module Name:    fei4_parse - RTL
-- Project Name:   FEI4B readout
-- Target Devices: xc5vlx50
-- Tool versions:  ISE 14.4 / 14.6
-- Description:    Parses the FE-I4B data stream, recovering service records,
--                 address/data records
--
-- Dependencies:
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library UNISIM;
use UNISIM.VComponents.all;

entity fei4_parse_new is
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
end fei4_parse_new;

architecture RTL of fei4_parse_new is

  signal fei4_rdreg : std_logic_vector(31 downto 0);
  type state_t is ( Idle, Frame, Data0, Data1, Srec0, Srec1, Addr0, Addr1, Value0, Value1, Pixel0, Pixel1 );
  signal state : state_t := Idle;

  constant SOF : std_logic_vector(9 downto 0) := "0111111100";
  constant EOF : std_logic_vector(9 downto 0) := "0110111100";
  constant AR : std_logic_vector(9 downto 0) := "0011101010";
  constant DH : std_logic_vector(9 downto 0) := "0011101001";
  constant SR : std_logic_vector(9 downto 0) := "0011101111";
  constant VR : std_logic_vector(9 downto 0) := "0011101100";

  type srec_data_t is array(31 downto 0) of std_logic_vector(9 downto 0);
  signal srec_data : srec_data_t := ( others => "0000000000" );
  signal srec_stale : std_logic_vector(31 downto 0) := ( others => '0' );
  signal iaddr : integer range 0 to 31;
  signal kaddr : integer range 0 to 15;
  signal reg_rdreg : std_logic;
  signal data_frame : std_logic;
  signal valid : std_logic;
  signal sr_strobe : std_logic := '0';
  signal ar_strobe : std_logic := '0';
  signal vr_strobe : std_logic := '0';
  signal dh_strobe : std_logic := '0';
  signal pix_strobe : std_logic := '0';
  signal srec : std_logic_vector(15 downto 0);
  signal arec : std_logic_vector(15 downto 0);
  signal vrec : std_logic_vector(15 downto 0);
  signal drec : std_logic_vector(15 downto 0);
  signal pixel : std_logic_vector(23 downto 0);
  signal error_flag : std_logic;
  signal skipped : std_logic_vector(9 downto 0);
  signal truncated : std_logic;
  signal etc : std_logic_vector(4 downto 0);
  signal l1req : std_logic_vector(3 downto 0);
  signal rdreg_done : std_logic := '0';
  signal busy_rdreg : std_logic := '0';
begin

  process ( clk, dv ) begin
    if ( clk'event and clk = '1' ) then
      reg_rdreg <= do_rdreg;
      if ( dv = '1' ) then
        case state is
          when Idle =>
            data_frame <= '0';
            if ( busy_rdreg = '0' and reg_rdreg = '1' ) then
              busy_rdreg <= '1';
              fei4_rdreg <= x"f0000000";
              rdreg_done <= '0';
            end if;
            if ( rdreg_done = '1' and reg_rdreg = '0' ) then
              busy_rdreg <= '0';
            end if;
            if ( din = SOF ) then
              state <= Frame;
            else
              state <= Idle;
            end if;
          when Frame =>
            if ( busy_rdreg = '1' ) then
              fei4_rdreg(31) <= '0';
            end if;
            if ( din = EOF ) then
              if ( busy_rdreg = '1' ) then
                fei4_rdreg(30) <= '0';
              end if;
              if ( data_frame = '1' ) then
                pixel <= ( others => '0' );
              end if;
              eof_strobe <= '1';
              state <= Idle;
            end if;
            if ( din = SR ) then
              state <= Srec0;
            elsif ( din = AR ) then
              state <= Addr0;
            elsif ( din = VR ) then
              state <= Value0;
            elsif ( din = DH ) then
              state <= Data0;
            elsif ( data_frame = '1' and valid = '1' ) then
              pixel(23 downto 16) <= din(7 downto 0);
              state <= Pixel0;
            else
              rdreg_done <= busy_rdreg;
              state <= Idle;
            end if;
          when Srec0 =>
            if ( valid = '1' ) then
              srec(15 downto 8) <= din(7 downto 0);
              state <= Srec1;
            else
              state <= Idle;
            end if;
          when Srec1 =>
            if ( valid = '1' ) then
              srec(7 downto 0) <= din(7 downto 0);
              sr_strobe <= '1';
              state <= Frame;
            else
              state <= Idle;
            end if;
          when Addr0 =>
            if ( valid = '1' ) then
              arec(15 downto 8) <= din(7 downto 0);
              state <= Addr1;
            else
              state <= Idle;
            end if;
          when Addr1 =>
            if ( valid = '1' ) then
              arec(7 downto 0) <= din(7 downto 0);
              ar_strobe <= '1';
              if ( busy_rdreg = '1' ) then
                fei4_rdreg(29) <= '0';
              end if;
              state <= Frame;
            else
              state <= Idle;
            end if;
          when Value0 =>
            if ( valid = '1' ) then
              vrec(15 downto 8) <= din(7 downto 0);
              state <= Value1;
            else
              state <= Idle;
            end if;
          when Value1 =>
            if ( valid = '1' ) then
              vrec(7 downto 0) <= din(7 downto 0);
              vr_strobe <= '1';
              if ( busy_rdreg = '1' ) then
                fei4_rdreg(28) <= '0';
              end if;
              state <= Frame;
            else
              state <= Idle;
            end if;
          when Data0 =>
            if ( valid = '1' ) then
              drec(15 downto 8) <= din(7 downto 0);
              state <= Data1;
            else
              state <= Idle;
            end if;
          when Data1 =>
            if ( valid = '1' ) then
              drec(7 downto 0) <= din(7 downto 0);
              dh_strobe <= '1';
              data_frame <= '1';
              state <= Frame;
            else
              state <= Idle;
            end if;
          when Pixel0 =>
            if ( valid = '1' ) then
              pixel(15 downto 8) <= din(7 downto 0);
              state <= Pixel1;
            else
              state <= Idle;
            end if;
          when Pixel1 =>
            if ( valid = '1' ) then
              pixel(7 downto 0) <= din(7 downto 0);
              pix_strobe <= '1';
              state <= Frame;
            else
              state <= Idle;
            end if;
        end case;
      else
        sr_strobe <= '0';
        ar_strobe <= '0';
        vr_strobe <= '0';
        dh_strobe <= '0';
        eof_strobe <= '0';
        pix_strobe <= '0';
      end if;
--
--  Process recently validated data...
--
      if ( dh_strobe = '1' ) then
        error_flag <= drec(15);
        lv1id <= "0000000" & drec(14 downto 10);
        bcid <= "000" & drec(9 downto 0);
        evt_strobe <= '1';
      else
        evt_strobe <= '0';
      end if;

      if ( sr_strobe = '1' ) then
        if ( data_frame = '1' and iaddr = 14 ) then
          lv1id(11 downto 5) <= srec(9 downto 3);
          bcid(12 downto 10) <= srec(2 downto 0);
          evtsr_strobe <= '1';
        else
          evtsr_strobe <= '0';
        end if;
        if ( data_frame = '1' and iaddr = 15 ) then
          skipped <= srec(9 downto 0);
        end if;
        if ( data_frame = '1' and iaddr = 16 ) then
          truncated <= srec(9);
          etc <= srec(8 downto 4);
          l1req <= srec(3 downto 0);
        end if;
        srec_data(iaddr) <= srec(9 downto 0);
        srec_stale(iaddr) <= '1';
      else
        evtsr_strobe <= '0';
      end if;

      if ( ar_strobe = '1' and busy_rdreg = '1' ) then
        fei4_rdreg(27 downto 16) <= arec(11 downto 0);
      end if;
      if ( vr_strobe = '1' and busy_rdreg = '1' ) then
        fei4_rdreg(15 downto 0) <= vrec;
      end if;

    end if;
  end process;

  valid <= '1' when din(9 downto 8) = "00" else '0';
  iaddr <= to_integer(unsigned(srec(15 downto 10)));
  kaddr <= to_integer(unsigned(address));
  data <= "000000" & srec_data(2*kaddr+1) & "000000" & srec_data(2*kaddr);
  rdreg <= fei4_rdreg;
  busy <= busy_rdreg;
  pixel_data <= pixel;
  pixel_dv <= pix_strobe;

end RTL;
