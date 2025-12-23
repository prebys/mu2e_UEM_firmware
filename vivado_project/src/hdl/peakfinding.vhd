----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/20/2019 08:43:39 PM
-- Design Name: 
-- Module Name: peakfinding - Behavioral
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

entity peakfinding is
  port (
    rst : in std_logic;
    clk_a : in std_logic;
    intrig : in std_logic;
    inwr : in std_logic;
    inreq1 : in std_logic;
    ibusy : in std_logic;
    datain1 : in std_logic_vector(63 downto 0);
    inthr : in std_logic_vector(31 downto 0);
    inpeakhigh_count : in std_logic_vector(31 downto 0);
    inpeakarea_count : in std_logic_vector(31 downto 0);

    
    clk_b : in std_logic;
    outdone : out std_logic;
    outwr : out std_logic;
    peakvalue : out std_logic_vector(15 downto 0);
    sumvalue : out std_logic_vector(31 downto 0);
    outevn_number : out std_logic_vector(31 downto 0);
    outsumevn_number : out std_logic_vector(31 downto 0);
    --startprocess : in std_logic;
    dout : out std_logic_vector(31 downto 0)
  );
end peakfinding;

architecture Behavioral of peakfinding is

 component min_module
   port (
    rst : in std_logic;
    clk_a : in std_logic; 
    datain1 : in std_logic_vector(63 downto 0);
    doutsum : out std_logic_vector(31 downto 0);
    mintime : out std_logic_vector(1 downto 0);
    doutmin : out std_logic_vector(15 downto 0);
    --dout0 : out std_logic_vector(15 downto 0);
    --dout1 : out std_logic_vector(15 downto 0);
    --dout2 : out std_logic_vector(15 downto 0);
    --dout3 : out std_logic_vector(15 downto 0);    
    doutmax : out std_logic_vector(15 downto 0)
    );
 end component;

 component sumarea_module
   port (
    rst : in std_logic;
    clk_a : in std_logic; 
    inwr : in std_logic;
    startplus : in std_logic;
    --datainmin : in std_logic_vector(15 downto 0);
    --datainsum : in std_logic_vector(31 downto 0);

    datain_org0 : in std_logic_vector(15 downto 0);
    datain_org1 : in std_logic_vector(15 downto 0);
    datain_org2 : in std_logic_vector(15 downto 0);
    datain_org3 : in std_logic_vector(15 downto 0);
    ithr : in std_logic_vector(31 downto 0);
    
    inbusy : in std_logic;
    clk_b : in std_logic;
    wrdata : out std_logic;
    --rden : in std_logic;
    --outvalid : out std_logic;
    --outempty : out std_logic;
    outevent_number : out std_logic_vector(31 downto 0);
    sumpeak_out : out std_logic_vector(31 downto 0);

    orst : out std_logic;
    owr_peak_sum: out std_logic;
    dout_sum : out std_logic_vector(31 downto 0);
    
    --rden_height : in std_logic;
    --outvalid_height : out std_logic;
    --outempty_height : out std_logic;     
    owr_peak_height : out std_logic;   
    dout_height : out std_logic_vector(63 downto 0)    
    
    );
 end component;

-- component peakhigh_module
--   port (
--    rst : in std_logic;
--    clk_a : in std_logic; 
--    intrigger : in std_logic;
--    inwr : in std_logic;
--    inbusy : in std_logic;
--    startplus : in std_logic;
--    datain : in std_logic_vector(15 downto 0);
--    datain_org0 : in std_logic_vector(15 downto 0);
--    datain_org1 : in std_logic_vector(15 downto 0);
--    datain_org2 : in std_logic_vector(15 downto 0);
--    datain_org3 : in std_logic_vector(15 downto 0);
--    datain_max : in std_logic_vector(15 downto 0);
--    ithr : in std_logic_vector(31 downto 0);
    
--    dintime : in std_logic_vector(1 downto 0);
--    clk_b : in std_logic;
--    wrdata : out std_logic;
--    rden : in std_logic;
--    peakhigh_out : out std_logic_vector(15 downto 0);
--    outevent_number : out std_logic_vector(31 downto 0);
--    outempty : out std_logic;
--    outvalid : out std_logic;
--    --startproc : in std_logic;
--    dout : out std_logic_vector(31 downto 0)
--    );
-- end component;

 component sumarea_fifo
  port(
   rst : in std_logic;
   wr_clk: in std_logic;
   full : out std_logic;
   din : in std_logic_vector(31 downto 0);
   wr_en : in std_logic;
   rd_clk : in std_logic;
   valid : out std_logic;
   empty : out std_logic;
   dout : out std_logic_vector(31 downto 0);
   rd_en : in std_logic
  );
  end component;

 component peakhigh_fifo
  port(
   rst : in std_logic;
   wr_clk: in std_logic;
   full : out std_logic;
   --din : in std_logic_vector(31 downto 0);
   din : in std_logic_vector(63 downto 0);
   wr_en : in std_logic;
   rd_clk : in std_logic;
   empty : out std_logic;
   valid : out std_logic;
   dout : out std_logic_vector(31 downto 0);
   rd_en : in std_logic
  );
  end component;



  constant word_count : integer := 1;
  signal count : integer range 0 to word_count-1;

  signal data : std_logic_vector(63 downto 0);

  signal even_clock : std_logic;
  signal datamin_sum : std_logic_vector(31 downto 0);
  signal datamin_time : std_logic_vector(1 downto 0);
  signal datamin_value : std_logic_vector(15 downto 0);
  signal datamax_value : std_logic_vector(15 downto 0);
  signal min_module_out0 : std_logic_vector(15 downto 0);  
  signal min_module_out1 : std_logic_vector(15 downto 0);
  signal min_module_out2 : std_logic_vector(15 downto 0);  
  signal min_module_out3 : std_logic_vector(15 downto 0);  


  signal data_org0 : std_logic_vector(15 downto 0);  
  signal data_org1 : std_logic_vector(15 downto 0);
  signal data_org2 : std_logic_vector(15 downto 0);  
  signal data_org3 : std_logic_vector(15 downto 0);  

  signal sumarea_wr : std_logic;
  signal wr_peak_sum : std_logic;
  signal sumarea_data : std_logic_vector(31 downto 0);
  signal fifo_sumarea_data : std_logic_vector(31 downto 0);
  signal fifo_full_sumarea : std_logic;
  signal fifo_empty_sumarea: std_logic;
  signal sumarea_startplus : std_logic;
  signal sumarea_rden : std_logic;
  signal sumarea_empty : std_logic;
  signal sumarea_valid : std_logic;


  signal peakhigh_wr : std_logic;
  signal wr_peak_height: std_logic;
  signal fifo_full_height : std_logic;
  signal fifo_empty_height: std_logic;
  signal fifo_peakhigh_data : std_logic_vector(63 downto 0);
  signal peakhigh_data : std_logic_vector(31 downto 0);
  signal peakhigh_rden : std_logic;
  signal peakhigh_value : std_logic_vector(15 downto 0);
  signal peakhigh_empty : std_logic;
  signal peakhigh_valid : std_logic;

  signal evn_number : std_logic_vector(31 downto 0);
  signal sumevn_number : std_logic_vector(31 downto 0);
  signal sumpeak_value : std_logic_vector(31 downto 0);
  signal inwrdata : std_logic;
  signal fifo_rst : std_logic;
  --constant peak_count : integer := to_integer(unsigned(inpeakhigh_count));  --81;  --81; 
  --constant sum_count : integer := to_integer(unsigned(inpeakhigh_count));  --123;  --123; 
    
  --signal count_high : integer range 0 to peak_count - 1;
  --signal count_sum : integer range 0 to sum_count - 1;
  
  signal count_high : unsigned(31 downto 0);
  signal count_sum : unsigned(31 downto 0);
   
  signal inbusy : std_logic;      
  signal last_inreq1 : std_logic;
  
  type state_t is ( Idle,
                    SendPeakfindingHeader,
                    SendDataPeakHeader,
                    SendDataPeak_wait,
                    SendDataPeak,
                    SendDataPeakEndWait,
                    SendDataPeakEnd,
                    SendDataSumHeader,
                    SendDataSum_wait,
                    SendDataSum,
                    SendDataSumEndWait,
                    SendDataSumEnd,
                    SendPeakfindingEnd,
                    SendPeakfindingDone
                     );
  signal state : state_t;

begin
 
 data <= datain1;
 
 --data_org0 <= datain1(63 downto 48);
 --data_org1 <= datain1(47 downto 32);
 --data_org2 <= datain1(31 downto 16);
 --data_org3 <= datain1(15 downto 0);
 
 data_org0 <= datain1(47 downto 32);
 data_org1 <= datain1(63 downto 48);
 data_org2 <= datain1(15 downto 0);
 data_org3 <= datain1(31 downto 16);
  
 peakvalue <= peakhigh_value;
 outevn_number <= evn_number;
 outsumevn_number <= sumevn_number;
 sumvalue <= sumpeak_value;

 inbusy <= ibusy;
 inwrdata <= inwr;
 
 --min_imp : min_module
 -- port map (
 --  rst => rst,
 --  clk_a => clk_a,
 --  datain1 => data, --x"01ff02ff03ff04ff", 
 --  doutsum => datamin_sum,
 --  mintime => datamin_time,
 --  doutmin => datamin_value,
 --  --dout0 => min_module_out0,
 --  --dout1 => min_module_out1,
 --  --dout2 => min_module_out2,
 --  --dout3 => min_module_out3,         
 --  doutmax => datamax_value
 -- );

 sum_imp : sumarea_module
   port map (
    rst => rst,
    clk_a => clk_a, 
    inwr => inwrdata,
    startplus => sumarea_startplus,
    --datainmin => datamin_value,
    --datainsum => datamin_sum,
    
    datain_org0 => data_org0,
    datain_org1 => data_org1,
    datain_org2 => data_org2,
    datain_org3 => data_org3,            
    ithr => inthr, 
        
    inbusy => inbusy,
    clk_b => clk_b,
    wrdata => sumarea_wr,
    --rden => '0',--sumarea_rden,
    --outvalid => sumarea_valid,
    --outempty => sumarea_empty,
    outevent_number => sumevn_number,
    sumpeak_out=>sumpeak_value,

    orst => fifo_rst,
    owr_peak_sum => wr_peak_sum,
    dout_sum => fifo_sumarea_data, 

    --rden_height  => peakhigh_rden,
    --outvalid_height => peakhigh_valid,
    --outempty_height => peakhigh_empty,        
    owr_peak_height => wr_peak_height,
    dout_height => fifo_peakhigh_data    
    
   );

-- ph_imp : peakhigh_module
--   port map (
--    rst => rst,
--    clk_a => clk_a, 
--    intrigger => intrig,
--    inwr => inwrdata, 
--    inbusy => inbusy,
--    startplus => sumarea_startplus,
--    datain => datamin_value,
--    datain_org0 => data_org0,
--    datain_org1 => data_org1,
--    datain_org2 => data_org2,
--    datain_org3 => data_org3,        
--    datain_max => datamax_value,
--    ithr => inthr,
--    dintime => datamin_time,    
--     
--    clk_b => clk_b,
--    wrdata => peakhigh_wr,
--    rden => '0', --peakhigh_rden,
--    peakhigh_out => open, --peakhigh_value,
--    outevent_number =>open, --evn_number,
--    outempty => open, --peakhigh_empty,
--    outvalid => open, --peakhigh_valid,
--    --startproc => startprocess,
--    dout => open --peakhigh_data 
--   );

  peakhighfifo_imp : peakhigh_fifo
    port map (
        rst => fifo_rst, --rst,
        wr_clk => clk_a,
        full => fifo_full_height,
        din => fifo_peakhigh_data, --peak_data_64bit, --peak_data,
        wr_en => wr_peak_height,
        rd_clk => clk_b,
        valid => peakhigh_valid, --outvalid_height, --fifo_valid_height,
        empty => fifo_empty_height,
        dout => peakhigh_data, --fifo_data_out_height,
        rd_en => peakhigh_rden --rden_height --fifo_rden_height 
   );

 sumareafifo_imp : sumarea_fifo
    port map (
        rst => fifo_rst, --rst,
        wr_clk => clk_a,
        full => fifo_full_sumarea,
        din => fifo_sumarea_data, --fifo_data_in,
        wr_en => wr_peak_sum,
        rd_clk => clk_b,
        valid => sumarea_valid, --outvalid, --fifo_valid,
        empty => fifo_empty_sumarea,
        dout => sumarea_data, --fifo_data_out,
        rd_en => sumarea_rden --fifo_rden 
   );



  process ( rst, clk_b )
    variable stat : std_logic_vector(31 downto 0);
  begin
    if ( clk_b'event and clk_b = '1' ) then
      last_inreq1 <= inreq1;
      if ( rst = '1' ) then
      else
        case state is
        when Idle =>
          outdone <= '0';
          outwr <= '0';
          count <= word_count-1;
          sumarea_startplus <= '0';
          sumarea_rden <= '0';
          count_high <= unsigned(inpeakhigh_count); --peak_count - 1;
          count_sum <= unsigned(inpeakarea_count); --sum_count - 1; --peak_count - 1;
          if ( inreq1 = '1' and last_inreq1 ='0' ) then
            state <= SendPeakfindingHeader;
            outdone <= '0';
          else
            state <= Idle;
          end if;


        when SendPeakfindingHeader =>
          outdone <= '0';
          dout <= x"aaaaaaaa";
          outwr <= '1';
          state <= SendDataPeakHeader;
          
        when SendDataPeakHeader =>
          dout <= x"cccccccc";
          outwr <= '1';
          --peakhigh_rden <= '1';
          --count_high <= count_high - 1;
          state <= SendDataPeak_wait;                  

        when SendDataPeak_wait =>
          outwr <= '0';
          peakhigh_rden <= '1';
          state <= SendDataPeak;                  

        when SendDataPeak =>
          even_clock <= not even_clock;
          --peakhigh_rden <= '1';
          if(peakhigh_valid = '1') then
              dout <=peakhigh_data;
              --count_high <= count_high - 1;
              outwr <= '1';
          else
              outwr <= '0';
          end if;
          --if( count = 0 ) then
          --if(peakhigh_empty = '1') then
          if(count_high = 0) then
              state <= SendDataPeakEndWait;
              count <= word_count-1;
              --outwr <= '0';
              peakhigh_rden <= '0';
          else 
              count <= count - 1;
              count_high <= count_high - 1;
              state <= SendDataPeak;
          end if;

        when SendDataPeakEndWait =>
          state <= SendDataPeakEnd;
          if(peakhigh_valid = '1') then
              dout <=peakhigh_data;
              outwr <= '1';
          else
              outwr <= '0';
          end if;

        when SendDataPeakEnd =>
            peakhigh_rden <= '0';
            dout <= x"cececece";
            outwr <= '1';
            state <= SendDataSumHeader;
                                                  
        when SendDataSumHeader =>
                dout <= x"dddddddd";
                outwr <= '1';
                --sumarea_rden <= '1';
                --count_sum <= count_sum - 1;
                state <= SendDataSum_wait;
                
        when SendDataSum_wait =>
                outwr <= '0';
                sumarea_rden <= '1';
                state <= SendDataSum;

        when SendDataSum =>
          sumarea_rden <= '1';

          if (sumarea_valid = '1') then
          -- there's valid data to send
            dout <= sumarea_data;
            outwr <= '1';

          if (count_sum = 1) then
            sumarea_rden <= '0';
            state <= SendDataSumEndWait;
          else
            count <= count - 1;
            count_sum <= count_sum - 1;
            state <= SendDataSum;
          end if;

          else
          -- there's no valid data right now
          -- there's a chance of getting stuck here right now, will fix later
            outwr <= '0';
            state <= SendDataSum;
          end if;
           
        when SendDataSumEndWait =>
          outwr <= '0';
          sumarea_rden <= '0';  
          if (sumarea_valid = '0') then
            -- fifo has closed, move on
            state <= SendDataSumEnd;
          else
            -- fifo has not closed
            state <= SendDataSumEndWait;
          end if;

        when SendDataSumEnd =>
          sumarea_rden <= '0';
          dout <= x"dededede";
          outwr <= '1';
          state <= SendPeakfindingEnd;
           
      when SendPeakfindingEnd =>
          dout <= x"bbbbbbbb";
          outwr <= '1';
          outdone <= '0';
          state <= SendPeakfindingDone;

      when SendPeakfindingDone =>
          dout <= x"f8f8f8f8";
          outwr <= '0';
          outdone <= '1';
          state <= Idle;
                         
        end case;
      end if;
    end if;
  end process;
  
  
end Behavioral;