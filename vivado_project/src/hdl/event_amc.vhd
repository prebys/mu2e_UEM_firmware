----------------------------------------------------------------------------------
-- Company: UC Davis
-- Engineer:  Nguyen Minh Truong
-- 
-- Create Date: 05/20/2019 08:43:39 PM
-- Design Name: 
-- Module Name: event_amc - Behavioral
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

entity event_amc is
  port (
    --rst : in std_logic;
    clk : in std_logic;
    intrig : in std_logic;

    outreq1 : out std_logic;
    datain1 : in std_logic_vector(31 downto 0);
    inwr1 : in std_logic;    
    done1 : in std_logic;
    inack1 : std_logic;
    
    outreq2 : out std_logic;
    datain2 : in std_logic_vector(31 downto 0);
    done2 : in std_logic;
    inwr2 : in std_logic;
    inack2 : std_logic;

    wren : out std_logic;
    dout : out std_logic_vector(31 downto 0);
    obusy : out std_logic;
    strobe : out std_logic
  );
end event_amc;

architecture Behavioral of event_amc is


  signal even_clock : std_logic;
  signal last_intrig : std_logic := '0';
  signal event_number : unsigned(31 downto 0) := (others => '0');

  
  type state_t is ( Idle,
                    SendEventHeader,
                    SendByteOrder,
                    SendFmcCard0Check,
                    SendFmcCard0Data,
                    -- SendFmcCard1Check,
                    -- SendFmcCard1Data,
                    SendEventEnd,
                    SendStrobe
                     );
  signal state : state_t;

begin

  process ( clk )
    variable stat : std_logic_vector(31 downto 0);
  begin
    if ( clk'event and clk = '1' ) then
      --if ( rst = '1' ) then
      --    obusy <= '0';
      --    state <= Idle;
      --else
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
          else
            state <= Idle;
          end if;
          
        when SendEventHeader =>
          obusy <= '1';
          strobe <='0';
          wren <= '1';
          dout <= x"AA502C01";
          even_clock <= not even_clock;
          state <= SendByteOrder;
 
       when SendByteOrder =>
          strobe <='0';
          wren <= '1';
          dout <= x"f1f2f3f4";
          --state <= SendFmcCard1Data;
          state <= SendFmcCard0Data;
          outreq1 <= '1';

       when SendFmcCard0Check =>
          strobe <='0';
          wren <= '0';
          dout <= x"f0f0f0f0";
          if(inack1='1') then
             outreq1 <= '0';
             state <= SendFmcCard0Data;
          end if;

                        
       when SendFmcCard0Data =>
          --dout <= x"fc00fc00";
          --wren <= '1';
          --state <= SendFmcCard1Data;
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
            --state <= SendEventEnd;
            state <= SendEventEnd; --SendFmcCard1Data;
          else
            state <= SendFmcCard0Data;
          end if; 

      --  when SendFmcCard1Check =>
      --     strobe <='0';
      --     wren <= '0';
      --     dout <= x"f1f1f1f1";
      --     if(inack2='1') then
      --        outreq2 <= '0';
      --        state <= SendFmcCard1Data;
      --     end if;

      --  when SendFmcCard1Data =>
      --     --dout <= x"fc01fc01";
      --     --wren <= '1';
      --     --state <= SendEventEnd;
      --     if (inwr2 = '1') then
      --       dout <= datain2;
      --       wren <= '1';
      --     else
      --       wren <= '0';
      --     end if;
      --     even_clock <= not even_clock;
      --     strobe <= '0';
      --     if ( done2 = '1' ) then
      --       outreq1 <= '0';
      --       outreq2 <= '0';
      --       wren <= '0';
      --       --state <= SendFmcCard0Data;
      --       state <= SendEventEnd;
      --     else
      --       state <= SendFmcCard1Data;
      --     end if; 

           
      when SendEventEnd =>
         dout <= x"fafafafa";
         wren <= '1';
         strobe <= '0';
         state <= SendStrobe;      
          
        when SendStrobe =>
          dout <= x"f8f8f8f8";   -- Should never appear in data stream
          wren <= '0';
          strobe <= '1';
          obusy <= '1';
          state <= Idle;
                         
        end case;
      --end if;
    end if;
  end process;
  
  
end Behavioral;