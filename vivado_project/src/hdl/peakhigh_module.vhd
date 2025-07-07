----------------------------------------------------------------------------------
-- Company:  UC Davis
-- Engineer: Nguyen Minh Truong
-- 
-- Create Date: 05/22/2019 08:43:39 PM
-- Design Name: 
-- Module Name: peakhigh_module - Behavioral
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
--use ieee.std_logic_unsigned.all;


entity peakhigh_module is
  port (
    rst : in std_logic;
    clk_a : in std_logic; 
    intrigger : in std_logic;
    inwr : in std_logic;
    inbusy : in std_logic;
    startplus : in std_logic;
    datain : in std_logic_vector(15 downto 0);
    datain_org0 : in std_logic_vector(15 downto 0);
    datain_org1 : in std_logic_vector(15 downto 0);
    datain_org2 : in std_logic_vector(15 downto 0);
    datain_org3 : in std_logic_vector(15 downto 0);
    datain_max : in std_logic_vector(15 downto 0);
    ithr : in std_logic_vector(31 downto 0);
    dintime : in std_logic_vector(1 downto 0);
    clk_b : in std_logic;
    wrdata : out std_logic;
    rden : in std_logic;
    peakhigh_out : out std_logic_vector(15 downto 0);
    outevent_number : out std_logic_vector(31 downto 0);
    outempty : out std_logic;
    outvalid : out std_logic;
    dout : out std_logic_vector(31 downto 0)
  );
end peakhigh_module;

architecture Behavioral of peakhigh_module is


 component peakhigh_fifo
  port(
   rst : in std_logic;
   wr_clk: in std_logic;
   full : out std_logic;
   din : in std_logic_vector(63 downto 0);
   wr_en : in std_logic;
   rd_clk : in std_logic;
   empty : out std_logic;
   valid : out std_logic;
   dout : out std_logic_vector(31 downto 0);
   rd_en : in std_logic
  );
  end component;
  
signal peak_data : std_logic_vector(31 downto 0);
signal peak_data_64bit : std_logic_vector(63 downto 0);

constant data_count : integer := 8192;

signal counter : integer range 0 to data_count-1;

constant data_count_64bit : integer := 200000000;

signal counter_64bit : integer range 0 to data_count_64bit-1;

signal wr_peak : std_logic;
signal fifo_empty : std_logic;
signal fifo_data_out : std_logic_vector(31 downto 0);
signal fifo_rden : std_logic;
signal fifo_valid : std_logic;
signal latch_data : std_logic_vector(15 downto 0);
signal latch_data0 : std_logic_vector(15 downto 0);
signal latch_data1 : std_logic_vector(15 downto 0);
signal latch_data2 : std_logic_vector(15 downto 0);
signal latch_data3 : std_logic_vector(15 downto 0);
signal latch_data4 : std_logic_vector(15 downto 0);

signal latch_datain_org0 : signed(15 downto 0);
signal latch_datain_org1 : signed(15 downto 0);
signal latch_datain_org2 : signed(15 downto 0);
signal latch_datain_org3 : signed(15 downto 0);

signal latch2_datain_org0 : signed(15 downto 0);
signal latch2_datain_org1 : signed(15 downto 0);
signal latch2_datain_org2 : signed(15 downto 0);
signal latch2_datain_org3 : signed(15 downto 0);

signal latch_maxdata0 : std_logic_vector(15 downto 0);
signal latch_maxdata1 : std_logic_vector(15 downto 0);
signal latch_maxdata2 : std_logic_vector(15 downto 0);
signal latch_maxdata3 : std_logic_vector(15 downto 0);
signal latch_maxdata4 : std_logic_vector(15 downto 0);

signal latch_dintime0 : std_logic_vector(1 downto 0);
signal latch_dintime1 : std_logic_vector(1 downto 0);
signal latch_dintime2 : std_logic_vector(1 downto 0);
signal latch_dintime3 : std_logic_vector(1 downto 0);
signal latch_dintime4 : std_logic_vector(1 downto 0);
signal peak_high : std_logic_vector(15 downto 0) := ( others => '0' );
signal last_inwr : std_logic;
signal event_number : unsigned (31 downto 0):= ( others => '0' );
signal thr : std_logic_vector(15 downto 0) := ithr(15 downto 0);

signal maxdata : std_logic_vector(15 downto 0) := x"8000";
type peakhigh_state_t is ( Idle,
                           Peakhighfinding, 
                           --SendWait,
                           Strobe );
signal peakhigh_state : peakhigh_state_t := Idle;

type peakfind_state_t is ( Idle,
                           WaitCount,
                           PeakFinding, 
                           Strobe );
signal peakfind_state : peakfind_state_t := Idle;

constant word_count : integer := 256;
signal countdata : integer range 0 to word_count-1;

signal fifo_full : std_logic;
signal fifo_rst : std_logic;
signal ibusy : std_logic;
signal last_ibusy : std_logic;

signal timepeak : integer range 0 to 3;


begin

  peakhighfifo_imp : peakhigh_fifo
    port map (
        rst => fifo_rst, --rst,
        wr_clk => clk_a,
        full => fifo_full,
        din => peak_data_64bit,
        wr_en => wr_peak,
        rd_clk => clk_b,
        valid => fifo_valid,
        empty => fifo_empty,
        dout => fifo_data_out,
        rd_en => fifo_rden 
   );

  dout <= fifo_data_out;
  fifo_rden <= rden;
  peakhigh_out <= std_logic_vector(signed(peak_high));
  outevent_number <= std_logic_vector(event_number);
  ibusy <= inbusy;
  outempty <= fifo_empty;
  outvalid <= fifo_valid;
  timepeak <= to_integer(unsigned(dintime));
  
 process ( clk_a )
 begin
   if ( clk_a'event and clk_a = '1' ) then
        latch_data <= datain;
        
        latch_data0 <= datain;
        latch_maxdata0 <= datain_max;           
        latch_dintime0 <= dintime;
        
        latch_data1 <= latch_data0;
        latch_maxdata1 <= latch_maxdata0;
        latch_dintime1 <= latch_dintime0;
        
        latch_data2 <= latch_data1;
        latch_maxdata2 <= latch_maxdata1;
        latch_dintime2 <= latch_dintime1;
        
        latch_data3 <= latch_data2;
        latch_maxdata3 <= latch_maxdata2;                
        latch_dintime3 <= latch_dintime2;
        
        latch_data4 <= latch_data3;
        latch_maxdata4 <= latch_maxdata3;
        latch_dintime4 <= latch_dintime3;
        
        latch_datain_org0 <= signed(datain_org0);
        latch_datain_org1 <= signed(datain_org1);
        latch_datain_org2 <= signed(datain_org2);
        latch_datain_org3 <= signed(datain_org3);
        
        latch2_datain_org0 <= latch_datain_org0;
        latch2_datain_org1 <= latch_datain_org1;
        latch2_datain_org2 <= latch_datain_org2;
        latch2_datain_org3 <= latch_datain_org3;

                
        last_inwr <= inwr;        
      if (rst ='1') then
            counter <= 0;
            counter_64bit <= 0;
            wr_peak <= '0';
            peakfind_state <= Idle;
      else
        case peakfind_state is
     
             when Idle =>                           
                wr_peak <= '0';
                counter <= 0;
                if( last_inwr ='0' and inwr = '1') then
                        --counter <= counter + 1;
                        fifo_rst <= '1';
                        counter <= 0;
                        counter_64bit <= 0;
                        peakfind_state <= WaitCount;
                 end if;
             
             when WaitCount =>
                wr_peak <= '0';
                fifo_rst <='0';
                if(counter = 4) then
                        peakfind_state <= PeakFinding;
                else 
                    counter <= counter + 1;
                    counter_64bit <= counter_64bit + 1;
                end if; 
             
             when PeakFinding =>
                counter <= counter + 1;
                counter_64bit <= counter_64bit + 1;
                
                if( last_inwr = '1' and inwr = '0') then
                    peakfind_state <= Strobe; 
                    wr_peak <= '0'; 
                end if;
                
                --=============================================================
                -- peak high with data one by one
                --==============================================================

                -- peak at latch_datain_org0
                --  \   /
                --   \/
                if (    latch2_datain_org2 > latch2_datain_org3
                        and latch2_datain_org3 > latch_datain_org0
                        and latch_datain_org1 > latch_datain_org0
                        and latch_datain_org2 > latch_datain_org1
                        and latch_datain_org0 < signed(thr) 
                        and latch2_datain_org2 < signed(thr)
                        ) then
                           wr_peak <= '1';
                            peak_data <=  "1" & "00" & std_logic_vector(to_unsigned((counter+1),13)) & std_logic_vector(latch_datain_org0);
                            peak_data_64bit <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch_datain_org0);

                -- \   /
                --  \_/            
                elsif ( latch2_datain_org1 > latch2_datain_org2
                        and latch2_datain_org2 > latch2_datain_org3
                        and latch2_datain_org3 = latch_datain_org0
                        and latch_datain_org1 > latch_datain_org0                        
                        and latch_datain_org2 > latch_datain_org1                        
                        and latch_datain_org0 < signed(thr) 
                        and latch2_datain_org1 < signed(thr)
                        ) then
                           wr_peak <= '1';
                           peak_data <=  "1" & "00" & std_logic_vector(to_unsigned((counter+1),13)) & std_logic_vector(latch_datain_org0);
                           peak_data_64bit <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch_datain_org0);

                elsif ( latch2_datain_org2 > latch2_datain_org3
                        and latch2_datain_org3 > latch_datain_org0
                        and latch_datain_org1 = latch_datain_org0
                        and latch_datain_org2 > latch_datain_org1                        
                        and latch_datain_org3 > latch_datain_org2                        
                        and latch_datain_org0 < signed(thr) 
                        and latch2_datain_org2 < signed(thr)
                        ) then
                           wr_peak <= '1';
                           peak_data <=   "1" & "00" & std_logic_vector(to_unsigned((counter+1),13)) & std_logic_vector(latch_datain_org0);
                           peak_data_64bit <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch_datain_org0);


                -- \     /
                --  \/\/
                --
                elsif ( latch2_datain_org2 > latch2_datain_org3
                        and latch2_datain_org3 > latch_datain_org0
                        and latch_datain_org1 > latch_datain_org0
                        and latch_datain_org2 < latch_datain_org1
                        and latch_datain_org3 > latch_datain_org2
                        --and signed(datain_org0) > latch_datain_org3
                        and latch2_datain_org2 < signed(thr)
                        ) then
                           wr_peak <= '1';
                           peak_data <=  "1" & "00" & std_logic_vector(to_unsigned((counter+1),13)) & std_logic_vector(latch_datain_org0);
                           peak_data_64bit <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch_datain_org0);



                -- peak at latch_datain_org1
                -- \  /
                --  \/                           
                elsif ( latch2_datain_org3 > latch_datain_org0
                        and latch_datain_org0 > latch_datain_org1
                        and latch_datain_org2 > latch_datain_org1
                        and latch_datain_org3 > latch_datain_org2
                        and latch_datain_org1 < signed(thr)
                        and latch2_datain_org3 < signed(thr) 
                        ) then
                           wr_peak <= '1';
                           peak_data <=  "1" & "01" & std_logic_vector(to_unsigned((counter+1),13)) & std_logic_vector(latch_datain_org1);
                           peak_data_64bit <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch_datain_org1);

                -- \   /
                --  \_/
                elsif ( latch2_datain_org3 > latch_datain_org0
                        and latch_datain_org0 > latch_datain_org1
                        and latch_datain_org2 = latch_datain_org1
                        and latch_datain_org3 > latch_datain_org1
                        and signed(datain_org0) > latch_datain_org3
                        and latch_datain_org1 < signed(thr) 
                        and latch2_datain_org3 < signed(thr)
                        ) then
                           wr_peak <= '1';
                           peak_data <=  "1" & "01" & std_logic_vector(to_unsigned((counter+1),13)) & std_logic_vector(latch_datain_org1);
                           peak_data_64bit <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch_datain_org1);

 
                -- \     /
                --  \/\/
                elsif ( latch2_datain_org3 > latch_datain_org0
                        and latch_datain_org0 > latch_datain_org1
                        and latch_datain_org2 > latch_datain_org1
                        and latch_datain_org3 < latch_datain_org2
                        and signed(datain_org0) > latch_datain_org3
                       -- and signed(datain_org1) > signed(datain_org0)
                        and latch2_datain_org3 < signed(thr) 
                        ) then
                           wr_peak <= '1';
                           peak_data <=  "1" & "01" & std_logic_vector(to_unsigned((counter+1),13)) & std_logic_vector(latch_datain_org1);
                           peak_data_64bit <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch_datain_org1);


                -- peak at latch_datain_org2
                -- \  /
                --  \/                           
                elsif ( latch_datain_org0 > latch_datain_org1
                        and latch_datain_org1 > latch_datain_org2
                        and latch_datain_org3 > latch_datain_org2
                        and signed(datain_org0) > latch_datain_org3
                        and latch_datain_org2 < signed(thr)
                        and latch_datain_org0 < signed(thr) 
                        ) then
                           wr_peak <= '1';
                           peak_data <=  "1" & "10" & std_logic_vector(to_unsigned((counter+1),13)) & std_logic_vector(latch_datain_org2);
                           peak_data_64bit <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch_datain_org2);     

                -- \   /
                --  \_/
                elsif ( latch_datain_org0 > latch_datain_org1
                        and latch_datain_org1 > latch_datain_org2
                        and latch_datain_org3 = latch_datain_org2
                        and signed(datain_org0) > latch_datain_org2
                        and signed(datain_org1) > signed(datain_org0)
                        and latch_datain_org2 < signed(thr)
                        and latch_datain_org0 < signed(thr) 
                        ) then
                           wr_peak <= '1';
                           peak_data <=  "1" & "10" & std_logic_vector(to_unsigned((counter+1),13)) & std_logic_vector(latch_datain_org2);
                           peak_data_64bit <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch_datain_org2);

                --\    /
                -- \/\/
                elsif ( latch_datain_org0 > latch_datain_org1
                         and latch_datain_org1 > latch_datain_org2
                         and latch_datain_org3 > latch_datain_org2
                         and signed(datain_org0) < latch_datain_org3
                         and signed(datain_org1) > signed(datain_org0)
                         --and signed(datain_org2) > signed(datain_org1)
                         and latch_datain_org0 < signed(thr)
                         ) then
                            wr_peak <= '1';
                            peak_data <=  "1" & "10" & std_logic_vector(to_unsigned((counter+1),13)) & std_logic_vector(latch_datain_org2);
                            peak_data_64bit <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch_datain_org2);

                -- peak at latch_datain_org3
                -- \  /
                --  \/                           
                elsif ( latch_datain_org1 > latch_datain_org2
                        and latch_datain_org2 > latch_datain_org3
                        and signed(datain_org0) > latch_datain_org3
                        and signed(datain_org1) > signed(datain_org0)
                        and latch_datain_org3 < signed(thr)
                        and latch_datain_org1 < signed(thr) 
                        ) then
                           wr_peak <= '1';
                           peak_data <=  "1" & "11" & std_logic_vector(to_unsigned((counter+1),13)) & std_logic_vector(latch_datain_org3);
                           peak_data_64bit <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch_datain_org3);

                -- \   /
                --  \_/
                elsif ( latch_datain_org1 > latch_datain_org2
                        and latch_datain_org2 > latch_datain_org3
                        and signed(datain_org0) = latch_datain_org3
                        and signed(datain_org1) > latch_datain_org3
                        and signed(datain_org2) > signed(datain_org1)
                        and latch_datain_org3 < signed(thr)
                        and latch_datain_org1 < signed(thr) 
                        ) then
                           wr_peak <= '1';
                           peak_data <=  "1" & "11" & std_logic_vector(to_unsigned((counter+1),13)) & std_logic_vector(latch_datain_org3);
                           peak_data_64bit <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch_datain_org3);


                --\    /
                -- \/\/
                elsif ( latch_datain_org1 > latch_datain_org2
                        and latch_datain_org2 > latch_datain_org3
                        and signed(datain_org0) > latch_datain_org3
                        and signed(datain_org1) < signed(datain_org0)
                        and signed(datain_org2) > signed(datain_org1)
                        --and signed(datain_org3) > signed(datain_org2)
                        and latch_datain_org3 < signed(thr) 
                        and latch_datain_org1 < signed(thr)
                        ) then
                           wr_peak <= '1';
                           peak_data <=  "1" & "11" & std_logic_vector(to_unsigned((counter+1),13)) & std_logic_vector(latch_datain_org3);
                           peak_data_64bit <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch_datain_org3);

                                                                 
                -- saturation at latch_datain_org0         
                elsif ( (latch_datain_org0 and x"fff0") = signed(maxdata)
                        and (latch_datain_org1 and x"fff0") = signed(maxdata)                          
                        and (latch_datain_org2 and x"fff0") = signed(maxdata)
                        and (latch_datain_org3 and x"fff0") = signed(maxdata)
                        ) then
                           wr_peak <= '1';
                           peak_data <=  "1" & "00" & std_logic_vector(to_unsigned((counter+1),13)) & std_logic_vector(latch_datain_org0);
                           peak_data_64bit <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch_datain_org0); 
                                                   
                elsif ( (latch_datain_org0 and x"fff0") = signed(maxdata)
                        and (latch_datain_org1 and x"fff0") = signed(maxdata)                          
                        and (latch_datain_org2 and x"fff0") = signed(maxdata)
                        and (latch_datain_org3 and x"fff0") > signed(maxdata)
                        ) then
                           wr_peak <= '1';
                           peak_data <=  "1" & "00" & std_logic_vector(to_unsigned((counter+1),13)) & std_logic_vector(latch_datain_org0);
                           peak_data_64bit <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch_datain_org0);         

                -- saturation at latch_datain_org1         
                elsif ( (latch_datain_org0 and x"fff0") > signed(maxdata)
                        and (latch_datain_org1 and x"fff0") = signed(maxdata)                          
                        and (latch_datain_org2 and x"fff0") = signed(maxdata)
                        and (latch_datain_org3 and x"fff0") = signed(maxdata)
                        ) then
                           wr_peak <= '1';
                           peak_data <=  "1" & "01" & std_logic_vector(to_unsigned((counter+1),13)) & std_logic_vector(latch_datain_org1);
                           peak_data_64bit <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch_datain_org1);
                
                -- saturation at latch_datain_org2                                 
                elsif ( (latch_datain_org0 and x"fff0") > signed(maxdata)
                        and (latch_datain_org1 and x"fff0") > signed(maxdata)                          
                        and (latch_datain_org2 and x"fff0") = signed(maxdata)
                        and (latch_datain_org3 and x"fff0") = signed(maxdata)
                        ) then
                           wr_peak <= '1';
                            peak_data <=  "1" & "10" & std_logic_vector(to_unsigned((counter+1),13)) & std_logic_vector(latch_datain_org2);
                            peak_data_64bit <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch_datain_org2);

                -- saturation at latch_datain_org3                                 
                elsif ( (latch_datain_org0 and x"fff0") > signed(maxdata)
                        and (latch_datain_org1 and x"fff0") > signed(maxdata)                          
                        and (latch_datain_org2 and x"fff0") > signed(maxdata)
                        and (latch_datain_org3 and x"fff0") = signed(maxdata)
                        ) then
                           wr_peak <= '1';
                           peak_data <=  "1" & "11" & std_logic_vector(to_unsigned((counter+1),13)) & std_logic_vector(latch_datain_org3);
                           peak_data_64bit <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch_datain_org3);


                --==================================================================
                -- end
                --==================================================================
                                    
                else
                     wr_peak <= '0';
                     peak_data <=  x"f2f2f2f2";
                end if;
                
             when Strobe =>
                    peakfind_state <= Idle;
                    wr_peak <= '0';
                    counter <= 0;
                    peak_data <=  x"f2f2f2f2";
       end case;
                   
    end if;    
  end if;  
 end process;

  process ( rst, clk_a )
  begin
    if ( clk_a'event and clk_a = '1' ) then
          last_ibusy <= ibusy;

      if ( rst = '1' ) then
          event_number <= (others =>'0');
          peak_high <= x"0000";
          peakhigh_state <= Idle;
      else

        case peakhigh_state is

        when Idle =>         
             event_number <= event_number;
             peak_high <= peak_high;
          if ( last_inwr ='0' and inwr = '1') then
             event_number <= event_number + 1;
             countdata <= word_count-1;
             peak_high <= x"0000";
             peakhigh_state <= Peakhighfinding;
          else
            peakhigh_state <= Idle;
          end if; 
         
        when Peakhighfinding =>         
            if(inwr = '0' and last_inwr ='1') then
                    peakhigh_state <= Strobe; --SendWait;
            else
                if(signed(datain) < signed(peak_high)) then
                    peak_high <= std_logic_vector(signed(datain));            
                end if;
                peakhigh_state <= Peakhighfinding;
                countdata <= countdata -1 ;
            end if;
            
        when Strobe =>         
                peak_high <= peak_high;    
                event_number <= event_number;
                peakhigh_state <= Idle; 
  
        end case;
      end if;
    end if;
  end process;

end Behavioral;