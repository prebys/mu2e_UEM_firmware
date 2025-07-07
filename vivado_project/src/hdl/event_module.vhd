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

entity event_module is
  port (
    rst : in std_logic;
    clk : in std_logic;
    intrig : in std_logic;
    inevntrig : in std_logic_vector(31 downto 0);
    inevn_submax : in std_logic_vector(31 downto 0);
    
    inbusy : in std_logic;

    outreq1 : out std_logic;
    datain1 : in std_logic_vector(31 downto 0);
    inwr1 : in std_logic;    
    done1 : in std_logic;

    outreq2 : out std_logic;
    datain2 : in std_logic_vector(31 downto 0);
    done2 : in std_logic;
    inwr2 : in std_logic;

    --peakhigh : in std_logic_vector(15 downto 0);
    --inevn : in std_logic_vector(31 downto 0);
    --insumevn : in std_logic_vector(31 downto 0);
    --peaksum : in std_logic_vector(31 downto 0);

    outbusy1: out std_logic;
    outbusy2: out std_logic;    

    oack : out std_logic;
    wren : out std_logic;
    dout : out std_logic_vector(31 downto 0);
    obusy : out std_logic;
    strobe : out std_logic
  );
end event_module;

architecture Behavioral of event_module is


  signal even_clock : std_logic;
  signal last_intrig : std_logic := '0';
  signal event_number : unsigned(31 downto 0) := (others => '0');

  constant sub_evn : integer := 100;
  signal count_sub_evn : integer range 0 to sub_evn - 1;

  constant max_sub : integer := to_integer(unsigned(inevn_submax));  
  

  
  type state_t is ( Idle,
                    SendEventHeader0,
                    SendEventHeader1,
                    SendByteOrder,
                    SendFmcNumber,
                    SendEvnTrig,
                    SendEvnNumber,
                    SendDataRaw,
                    SendDataPeak,
                    --SendMinBegin,
                    SendEventEndSub,
                    SendSubEvnCheck,                    
                    SendStrobe1,
                    SendEventEnd,
                    SendStrobe2
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
          count_sub_evn <= 0;
          outbusy1<='0';
          outbusy2<='0';
      else
        last_intrig <= intrig;
        case state is
        when Idle =>
          strobe <= '0';
          wren <= '0';
          outreq1 <= '0';
          outreq2 <= '0';
          obusy <= '0';
          count_sub_evn <= 0;
          if ( intrig = '1' and last_intrig='0' and inbusy = '0' ) then
            state <= SendEventHeader0;
            obusy <= '1';
            oack <= '1';
            
          else
            state <= Idle;
          end if;

        when SendEventHeader0 =>
          obusy <= '1';
          strobe <='0';
          even_clock <= not even_clock;
          count_sub_evn <= 0;
          --if(intrig ='0') then    
          if(inbusy ='0') then      
             wren <= '1';
             dout <= x"ffffffff";
             state <= SendEventHeader1;
          --end if;
          else
             wren <='0';
          end if;
          
        when SendEventHeader1 =>
          obusy <= '1';
          strobe <='0';
          even_clock <= not even_clock;
          --count_sub_evn <= count_sub_evn + 1;
          --if(intrig ='0') then
          if(inbusy = '0') then
             wren <= '1';
             dout <= x"ffffff00";
             event_number <= event_number + 1;
             state <= SendByteOrder;
          else
                wren <='0';
          end if;
          
       when SendByteOrder =>
          strobe <='0';
          if(inbusy ='0') then
            wren <= '1';
            dout <= x"f1f2f3f4";
            state <= SendFmcNumber;
            outreq1 <= '0';
          else
               wren <='0';
          end if;
         
       when SendFmcNumber =>
          strobe <='0';
          if(inbusy ='0') then
            wren <= '1';
            dout <= x"fccccc00";
            state <= SendEvnTrig;
            outreq1 <= '0';
          else
               wren <='0';
          end if;

      when SendEvnTrig =>
          strobe <='0';
          if(inbusy='0') then   
             wren <= '1';
             --dout <= inevntrig;
             dout <= std_logic_vector(to_unsigned(count_sub_evn,32));
             state <= SendEvnNumber;
          else
                wren <='0';
          end if;

       when SendEvnNumber =>
             strobe <='0';
            if(inbusy='0') then
              wren <= '1';
              dout <= std_logic_vector(event_number);
              state <= SendDataRaw;
              outreq1 <= '1';
          else
                 wren <='0';
          end if;
          
       when SendDataRaw =>
          if(inbusy='0') then
              outbusy1 <='0';
         else
              outbusy1 <='1';
         end if;
                      
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
          outreq1 <= '0';
          
          if(inbusy='0') then
              outbusy2 <='0';
         else
              outbusy2 <='1';
         end if;

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
             --state <= SendEventEnd; --SendMinBegin; --SendEventEnd;
             state <= SendEventEndSub;
           else
             state <= SendDataPeak;
           end if; 
                                   
--     when SendMinBegin =>
--             strobe <='0';
--             wren <= '1';
--             dout <= x"eeeeeeee";
--             state <= SendEventEnd; --SendMinEvn;
   
      when SendEventEndSub =>
        outreq2 <= '0';
        if(inbusy ='0') then
          dout <= x"fcfcfc00";
          wren <= '1';
          strobe <= '0';
          state <= SendSubEvnCheck;
        end if;      
                    
        when SendSubEvnCheck =>
          wren <= '0';
          strobe <= '0';
          if(count_sub_evn = max_sub) then
          --if(count_sub_evn = 10) then
          --if(count_sub_evn = 5) then
                state <= SendEventEnd;
          else 
                state <= SendStrobe1;
                count_sub_evn <= count_sub_evn + 1;
          end if;      

        when SendStrobe1 =>
          dout <= x"f8f8f8f8";   -- Should never appear in data stream
          wren <= '0';
          --strobe <= '1';
          obusy <= '1';
          --oack <= '0';
          --state <= Idle;
          if(inbusy = '0') then
              state <= SendEventHeader1;
              strobe <= '1';
          else
              strobe <='0';
          end if;

      when SendEventEnd =>
        strobe <= '0';        
        if(inbusy ='0') then
         dout <= x"fcfcfcfc";
         wren <= '1';
         strobe <= '0';
         state <= SendStrobe2;      
        end if;

        when SendStrobe2 =>
          dout <= x"f8f8f8f8";   -- Should never appear in data stream
          wren <= '0';
          --strobe <= '1';
          obusy <= '1';
          oack <= '0';
          if(inbusy ='0') then
             state <= Idle;
             strobe <= '1';
          else
             strobe <= '0';
          end if;
          

                
                         
        end case;
      end if;
    end if;
  end process;
  
  
end Behavioral;