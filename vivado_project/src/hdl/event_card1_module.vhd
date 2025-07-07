----------------------------------------------------------------------------------
-- Company: UC Davis
-- Engineer:  Nguyen Minh Truong
-- 
-- Create Date: 05/20/2019 08:43:39 PM
-- Design Name: 
-- Module Name: event_module - Behavioral
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

entity event_card1_module is
  port (
    rst : in std_logic;
    clk : in std_logic;
    intrig : in std_logic;
    inevntrig : in std_logic_vector(31 downto 0);

    outreq1 : out std_logic;
    datain1 : in std_logic_vector(31 downto 0);
    inwr1 : in std_logic;    
    done1 : in std_logic;

    outreq2 : out std_logic;
    datain2 : in std_logic_vector(31 downto 0);
    done2 : in std_logic;
    inwr2 : in std_logic;
    
    oack : out std_logic;

    --peakhigh : in std_logic_vector(15 downto 0);
    --inevn : in std_logic_vector(31 downto 0);
    --insumevn : in std_logic_vector(31 downto 0);
    --peaksum : in std_logic_vector(31 downto 0);


    wren : out std_logic;
    dout : out std_logic_vector(31 downto 0);
    obusy : out std_logic;
    strobe : out std_logic
  );
end event_card1_module;

architecture Behavioral of event_card1_module is


  signal even_clock : std_logic;
  signal last_intrig : std_logic := '0';
  signal event_number : unsigned(31 downto 0) := (others => '0');

  
  type state_t is ( Idle,
                    SendEventHeader,
                    SendByteOrder,
                    SendFmcNumber,
                    SendEvnTrig,
                    SendEvnNumber,
                    SendDataRaw,
                    SendDataPeak,
                    
                    SendEventEnd,
                    SendStrobe
                     );
  signal state : state_t;

begin

  process ( rst, clk )
    variable stat : std_logic_vector(31 downto 0);
  begin
    if ( clk'event and clk = '1' ) then
      if ( rst = '1' ) then
          obusy <= '0';
          state <= Idle;
      else
        last_intrig <= intrig;
        case state is
        when Idle =>
          strobe <= '0';
          wren <= '0';
          outreq1 <= '0';
          outreq2 <= '0';
          obusy <= '0';
          if ( intrig = '1' and last_intrig='0' ) then
            state <= SendEventHeader;
            obusy <= '1';
            oack <= '1';
          else
            state <= Idle;
          end if;
          
        when SendEventHeader =>
          obusy <= '1';
          strobe <='0';
          even_clock <= not even_clock;
          if(intrig ='0') then
             wren <= '1';
             dout <= x"ffffffff";
             event_number <= event_number + 1;
             state <= SendByteOrder;
          end if;


 
       when SendByteOrder =>
          strobe <='0';
          wren <= '1';
          dout <= x"f1f2f3f4";
          state <= SendFmcNumber;
          outreq1 <= '0';
         
       when SendFmcNumber =>
          strobe <='0';
          wren <= '1';
          dout <= x"fccccc01";
          state <= SendEvnTrig;
          outreq1 <= '0';

      when SendEvnTrig =>
             strobe <='0';
             wren <= '1';
             dout <= inevntrig;
             state <= SendEvnNumber;

       when SendEvnNumber =>
             strobe <='0';
             wren <= '1';
             dout <= std_logic_vector(event_number);
             state <= SendDataRaw;
             outreq1 <= '1';
             
       when SendDataRaw =>
                 if (inwr1 = '1') then
                   dout <= datain1;
                   wren <= '1';
                 else
                   wren <= '0';
                 end if;
                 even_clock <= not even_clock;
                 strobe <= '0';
                 if ( done1 = '1' ) then
                   outreq1 <= '0';
                   outreq2 <= '1';
                   wren <= '0';
                   state <= SendDataPeak;
                 else
                   state <= SendDataRaw;
                 end if; 
       
       
                
             when SendDataPeak =>
                 if (inwr2 = '1') then
                    dout <= datain2;
                    wren <= '1';
                 else
                    wren <= '0';
                 end if;
                 even_clock <= not even_clock;
                 strobe <= '0';
                 if ( done2 = '1' ) then
                   outreq2 <= '0';
                   wren <= '0';
                   state <= SendEventEnd; --SendMinBegin; --SendEventEnd;
                 else
                   state <= SendDataPeak;
                 end if; 
          

   
      when SendEventEnd =>
         dout <= x"fcfcfcfc";
         wren <= '1';
         strobe <= '0';
         state <= SendStrobe;      
          
        when SendStrobe =>
          dout <= x"f8f8f8f8";   -- Should never appear in data stream
          wren <= '0';
          strobe <= '1';
          obusy <= '1';
          oack <= '0';
          state <= Idle;
                         
        end case;
      end if;
    end if;
  end process;
  
  
end Behavioral;