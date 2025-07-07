----------------------------------------------------------------------------------
-- Company: UC Davis
-- Engineer: Nguyen Minh Truong
-- 
-- Create Date: 06/12/2019 08:43:39 PM
-- Design Name: 
-- Module Name: peakdata_stream - Behavioral
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

entity peakdata_stream is
  port (
    rst : in std_logic;
    clk : in std_logic;
    inreq : in std_logic;
    inbusy : in std_logic;
    outreq0 : out std_logic;
    outreq1 : out std_logic;
    outreq2 : out std_logic;
    outreq3 : out std_logic;
    inwr0 : in std_logic;
    inwr1 : in std_logic;
    inwr2 : in std_logic;
    inwr3 : in std_logic;
    indone0 : in std_logic;
    indone1 : in std_logic;
    indone2 : in std_logic;
    indone3 : in std_logic;    
    datain0 : in std_logic_vector(31 downto 0);
    datain1 : in std_logic_vector(31 downto 0);
    datain2 : in std_logic_vector(31 downto 0);
    datain3 : in std_logic_vector(31 downto 0);
                
    outdone : out std_logic;
    outwr : out std_logic;
    dout : out std_logic_vector(31 downto 0)
  );
end peakdata_stream;

architecture Behavioral of peakdata_stream is

 
  constant word_count : integer := 5;
  signal count : integer range 0 to word_count-1;
  
  --constant number_channel : integer := 5;
  --signal nchannel :  integer range 0 to number_channel-1;
  signal number_channel : std_logic_vector(3 downto 0) := "0011";
  signal nchannel : unsigned(3 downto 0) := "0011";

  signal data : std_logic_vector(63 downto 0);

  signal even_clock : std_logic;
  signal datamin_sum : std_logic_vector(31 downto 0);
  signal datamin_time : std_logic_vector(1 downto 0);
  signal datamin_value : std_logic_vector(15 downto 0);
  
  signal sumarea_wr : std_logic;
  signal sumarea_data : std_logic_vector(31 downto 0);
  signal sumarea_startplus : std_logic;
  signal sumarea_rden : std_logic;

  signal peakhigh_wr : std_logic;
  signal peakhigh_data : std_logic_vector(31 downto 0);
  signal peakhigh_rden : std_logic;
  signal peakhigh_value : std_logic_vector(15 downto 0);
  signal peakhigh_empty : std_logic;
  signal peakhigh_valid : std_logic;

  signal evn_number : std_logic_vector(31 downto 0);
  signal sumevn_number : std_logic_vector(31 downto 0);
  signal sumpeak_value : std_logic_vector(31 downto 0);
  signal inwrdata : std_logic;
  signal last_inreq : std_logic;
  
  --signal inbusy : std_logic;      
  type state_t is ( Idle,
                    SendPeakStreamHeader,
                    SendPeakStreamChannelHeader,
                    SendPeakStreamChannelReq,
                    SendPeakStreamChannelData,
                    SendPeakStreamChannelEnd,
                    SendPeakStreamChannelCheck,
                    SendPeakStreamEnd,
                    SendPeakStreamDone
                     );
  signal state : state_t;

begin
  

  process ( rst, clk )
    variable stat : std_logic_vector(31 downto 0);
  begin
    if ( clk'event and clk = '1' ) then
      last_inreq <= inreq;
      if ( rst = '1' ) then
      else
        case state is
        when Idle =>
          nchannel <= unsigned(number_channel);
          outdone <= '0';
          outwr <= '0';
          count <= word_count-1;
          if ( inreq = '1' and last_inreq = '0' and inbusy ='0') then
            state <= SendPeakStreamHeader;
            outdone <= '0';
          else
            state <= Idle;
          end if;

        when SendPeakStreamHeader =>
          outdone <= '0';
          dout <= x"efefefef";
          outwr <= '1';
          state <= SendPeakStreamChannelHeader;

        when SendPeakStreamChannelHeader =>
            dout <= x"ee" & "0000" & std_logic_vector(nchannel) & x"eeee" ;
            outwr <= '1';
            count <= word_count-1;
            state <= SendPeakStreamChannelReq;

        when SendPeakStreamChannelReq =>
          dout <=x"f7f7f7f7";
          outwr <= '0';
          if(nchannel = "0000") then
            outreq0 <= '1';
          else
            outreq0 <= '0';
          end if;
                      
          if(nchannel = "0001") then
            outreq1 <= '1';
          else
            outreq1 <= '0';
          end if;
            
          if(nchannel = "0010") then
            outreq2 <= '1';
          else
              outreq2 <= '0';
          end if;    
                  
          if(nchannel = "0011") then
            outreq3 <= '1';
          else
            outreq3 <= '0';
          end if;            
                
          count <= word_count-1;
          state <= SendPeakStreamChannelData;

        when SendPeakStreamChannelData =>
          if(nchannel = "0000") then
            if(inwr0 = '1') then
                dout <= datain0;
                outwr <= '1';
            else
                outwr <= '0';
            end if;
            --if(count = 0) then
            if(indone0 = '1') then
                state <= SendPeakStreamChannelEnd;
            else 
                count <= count -1;
            end if;            
         elsif(nchannel = "0001") then
            if(inwr1 = '1') then
                dout <= datain1;
                outwr <= '1';
            else
                outwr <= '0';
            end if;
            --if(count = 0) then
            if(indone1 = '1') then
                state <= SendPeakStreamChannelEnd;
            else 
                count <= count -1;
            end if;            

         elsif(nchannel = "0010") then
            if(inwr2 = '1') then
                dout <= datain2;
                outwr <= '1';
            else
                outwr <= '0';
            end if;
            --if(count = 0) then
            if(indone2 = '1') then
                state <= SendPeakStreamChannelEnd;
            else 
                count <= count -1;
            end if;            

         elsif(nchannel = "0011") then
            if(inwr3 = '1') then
                dout <= datain3;
                outwr <= '1';
            else
                outwr <= '0';
            end if;

            --if(count = 0) then
            if(indone3 = '1') then
                state <= SendPeakStreamChannelEnd;
            else 
                count <= count -1;
            end if;            

         end if;    

        when SendPeakStreamChannelEnd =>
          dout <=x"ecececec";
          outwr <= '1';
          outreq0 <= '0';
          outreq1 <= '0';
          outreq2 <= '0';
          outreq3 <= '0';
          --nchannel <= nchannel-1;
          state <= SendPeakStreamChannelCheck;

        when SendPeakStreamChannelCheck =>
          dout <=x"f7f7f7f7";
          outwr <= '0';
          if(nchannel = "0000") then --4) then
            state <= SendPeakStreamEnd;
          else
            state <= SendPeakStreamChannelHeader;
            nchannel <= nchannel-1;
          end if;

        when SendPeakStreamEnd =>
          dout <=x"edededed";
          outwr <= '1';
          state <= SendPeakStreamDone;                  

        when SendPeakStreamDone =>
          dout <= x"f7f7f7f7";
          outwr <= '0';
          outdone <= '1';
          state <= Idle;
                         
        end case;
      end if;
    end if;
  end process;
  
  
end Behavioral;