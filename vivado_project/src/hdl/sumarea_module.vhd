----------------------------------------------------------------------------------
-- Company:  UC Davis
-- Engineer: Nguyen Minh Truong
-- 
-- Create Date: 05/22/2019 08:43:39 PM
-- Design Name: 
-- Module Name: sumarea_module - Behavioral
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

library common;
use common.TextUtil.all;

entity sumarea_module is
  port (
    rst : in std_logic;
    clk_a : in std_logic;
    inwr : in std_logic;
    startplus : in std_logic;

    datain_org0 : in std_logic_vector(15 downto 0);
    datain_org1 : in std_logic_vector(15 downto 0);
    datain_org2 : in std_logic_vector(15 downto 0);
    datain_org3 : in std_logic_vector(15 downto 0);
    ithr : in std_logic_vector(31 downto 0);

    inbusy : in std_logic;
    clk_b : in std_logic;
    wrdata : out std_logic;
    outevent_number : out std_logic_vector(31 downto 0);
    sumpeak_out : out std_logic_vector(31 downto 0);

    orst : out std_logic;
    owr_peak_sum: out std_logic;
    dout_sum : out std_logic_vector(31 downto 0);

    owr_peak_height: out std_logic;
    dout_height : out std_logic_vector(63 downto 0)


  );
end sumarea_module;

architecture Behavioral of sumarea_module is

-- signal thr : std_logic_vector(15 downto 0) := x"F380"; --thr = -200
signal thr : std_logic_vector(15 downto 0) := x"B000";  -- 0xB000 = -20480
-- IMPORTANT: when passing in a threshold value through minicom, only assign up to 16 bits
--   For example, passing in 0xB000 would be fine, it will get passed in as 0x0000_B000, and 
--   the top 16 bits will be ignored. 
--   No extra logic is needed to convert the 32-bit value to 16 bits

signal sum : std_logic_vector(31 downto 0):=( others => '0' );
signal sum0 : std_logic_vector(31 downto 0):=( others => '0' );
signal sum_pulse : std_logic_vector(31 downto 0):=( others => '0' );
signal sum0_stop : std_logic;
signal minpeak_stop : std_logic;

signal datainsum : std_logic_vector(31 downto 0):=( others => '0' );
signal latch_datainsum : std_logic_vector(31 downto 0):=( others => '0' );
signal latch2_datainsum : std_logic_vector(31 downto 0):=( others => '0' );
signal latch3_datainsum : std_logic_vector(31 downto 0):=( others => '0' );

signal datasum0 : std_logic_vector(31 downto 0);
signal datasum1 : std_logic_vector(31 downto 0);
signal datasum2 : std_logic_vector(31 downto 0);
signal datasum3 : std_logic_vector(31 downto 0);

constant data_count : integer := 4096; --8192;

signal counter : integer range 0 to data_count-1;
signal latch_counter1 : integer range 0 to data_count-1;
signal latch_counter2 : integer range 0 to data_count-1;

constant data_count_64bit : integer := 200000000; --8192;

signal counter_64bit : integer range 0 to data_count_64bit - 1;
signal latch_counter0_64bit : integer range 0 to data_count_64bit - 1;
signal latch_counter1_64bit : integer range 0 to data_count_64bit - 1;
signal latch_counter2_64bit : integer range 0 to data_count_64bit - 1;

signal fifo_rst : std_logic;

signal last_inwr : std_logic;
signal event_number : unsigned(31 downto 0):=( others => '0');
signal last_ibusy : std_logic;
signal ibusy : std_logic;

signal peak_data0_64bit : std_logic_vector (31 downto 0);
signal peak_data0_tmp : std_logic_vector (15 downto 0);
signal minpeak : std_logic_vector (15 downto 0);
signal maxdata : std_logic_vector(15 downto 0) := x"8000";

constant WINDOW_TOP_INDEX : integer := 19; -- 20 samples in the window

type sample_old_data_array is array (0 to WINDOW_TOP_INDEX - 4) of signed(15 downto 0);
type sample_new_input_array is array (0 to 3) of signed(15 downto 0);
type full_sample_array is array (0 to WINDOW_TOP_INDEX) of signed(15 downto 0);
type min_pipeline_array is array (0 to 4) of signed(15 downto 0); -- min pipeline for the four samples
type min_index_pipeline_array is array (0 to 4) of integer range 0 to 3; -- min index pipeline for the four samples


signal samples : sample_old_data_array;   -- latched values t-2 and t-1
signal inputs  : sample_new_input_array;  -- direct wires for t
signal samples_full : full_sample_array; -- all values (inc. direct wires) from t-2, t-1, and t

signal min_pipeline: min_pipeline_array; -- min pipeline for the four samples
signal min_index_pipeline : min_index_pipeline_array; -- min index pipeline for the four samples

signal peak_found : boolean := false;  -- flag to indicate if a peak was found


  type sumstate_t is ( Idle,
                    WaitCount,
                    SendSum1,
                    SendSum2,
                    SendSum3,
                    SendStrobeCheck,
                    SendStrobe0,
                    SendStrobe1,
                    SendStrobe2,
                    SendStrobe3,
                    SendStrobe4,
                    SendStrobe5,
                    SendStrobe6
                     );
  signal sumstate : sumstate_t;

function all_above_threshold(v: full_sample_array; thr : signed(15 downto 0)) return boolean is 
begin
   -- Tells if all of the middle data points are "above" the threshold
   -- Remember, signals are negative, so "above" threshold means outside the threshold
   return (
      v(4) > thr and
      v(5) > thr and
      v(6) > thr and
      v(7) > thr
   );
end function;

begin

  ibusy <= inbusy;

  datasum0 <= std_logic_vector(resize(samples_full(8), datasum0'length));
  datasum1 <= std_logic_vector(resize(samples_full(9), datasum1'length));
  datasum2 <= std_logic_vector(resize(samples_full(10), datasum2'length));
  datasum3 <= std_logic_vector(resize(samples_full(11), datasum3'length));

  orst <= fifo_rst;

   -- latch0 
   inputs(0) <= signed(datain_org0);  -- latch_datain_org0
   inputs(1) <= signed(datain_org1);  -- latch_datain_org1
   inputs(2) <= signed(datain_org2);  -- latch_datain_org2
   inputs(3) <= signed(datain_org3);  -- latch_datain_org3

  --  --  latch3         latch2     (these come from latches)
  --  samples_full(0) <= samples(0);  -- latch3_datain_org0  OLDEST (t=11)
  --  samples_full(1) <= samples(1);  -- latch3_datain_org1
  --  samples_full(2) <= samples(2);  -- latch3_datain_org2
  --  samples_full(3) <= samples(3);  -- latch3_datain_org3  ~old (t=8)

  --  --  latch2         latch1     (these come from latches)
  --  samples_full(4) <= samples(4);  -- latch2_datain_org0  mid-old (t=7)
  --  samples_full(5) <= samples(5);  -- latch2_datain_org1
  --  samples_full(6) <= samples(6);  -- latch2_datain_org2
  --  samples_full(7) <= samples(7);  -- latch2_datain_org3  mid-new (t=4)

  --  --  latch1         latch0      (these should all be instant wires)
  --  samples_full(8) <= inputs(0);  -- latch_datain_org0  ~new (t=3)
  --  samples_full(9) <= inputs(1);  -- latch_datain_org1
  --  samples_full(10) <= inputs(2); -- latch_datain_org2
  --  samples_full(11) <= inputs(3); -- latch_datain_org3  NEWEST (t=0)

  -- set samples_full(0 to 15) to samples(0 to 15)
  gen_samples : for i in 0 to WINDOW_TOP_INDEX - 4 generate  -- from 0 to 15
    samples_full(i) <= samples(i);
  end generate;

  -- set samples_full(16 to 19) to inputs(0 to 3)
  gen_inputs : for i in 0 to 3 generate
    samples_full(i + 16) <= inputs(i);
  end generate;

 -- SIGNAL PROCESSING
 process (clk_a) 
  variable min01 : integer range 0 to 4;
  variable min23 : integer range 0 to 4;
  variable min0123 : integer range 0 to 4;
  variable min01234 : integer range 0 to 4;
  variable abs_min : signed(15 downto 0);

  variable min_index : integer range 0 to 3;  -- index of the minimum value in the min_pipeline array
  variable min_in_center : boolean;

  variable current_min : signed(15 downto 0) := to_signed(0, 16);  -- initialize to zero
 begin
  if ( clk_a'event and clk_a = '1' ) then

    -- datainsum processing
    datainsum <= std_logic_vector(signed(datasum0) + signed(datasum1) + signed(datasum2) + signed(datasum3));
    latch_datainsum <= datainsum;
    latch2_datainsum <= latch_datainsum;
    latch3_datainsum <= latch2_datainsum;

    last_inwr <= inwr;
    last_ibusy <= ibusy;

    -- shift the samples down by 4
    -- samples(0) is the oldest sample (t=12 or 20 depending on the window size)
    -- newest samples will be added to top of array (highest indices) 
    
    -- set samples(0 to 11) <= samples(4 to 15) (assuming WINDOW_TOP_INDEX = 19)
    samples(0 to WINDOW_TOP_INDEX - 8) <= samples(4 to WINDOW_TOP_INDEX - 4);  
    -- then samples(12 to 15) <= inputs(0 to 3) (on a latch, so they come in next clock cycle)
    samples(WINDOW_TOP_INDEX - 8 + 1) <= inputs(0);  -- latch_datain_org0
    samples(WINDOW_TOP_INDEX - 8 + 2) <= inputs(1);  -- latch_datain_org1
    samples(WINDOW_TOP_INDEX - 8 + 3) <= inputs(2);  -- latch_datain_org2
    samples(WINDOW_TOP_INDEX - 8 + 4) <= inputs(3);  -- latch_datain_org3
    -- samples (16 to 19) will be directly wired to inputs(0 to 3) in the current clock cycle

    -- PROCESS MIN VALUES
    current_min := inputs(0);  -- start with current_min equal to value of samples_full(0)
    min_index := 0;
    for i in 1 to 3 loop
      if (inputs(i) < current_min) then
        current_min := inputs(i);
        min_index := i;
      end if;
    end loop;

    -- min_pipeline is array of five min values, one for each window
    min_pipeline(4) <= current_min;  -- min of samples_full(16 to 19)
    min_pipeline(3) <= min_pipeline(4); 
    min_pipeline(2) <= min_pipeline(3);
    min_pipeline(1) <= min_pipeline(2);
    min_pipeline(0) <= min_pipeline(1);
    -- 0 is oldest min, 4 is newest min, old entries are pushed to left

    -- pipeline for index of max in each sub-window
    min_index_pipeline(4) <= min_index;  -- index of min in samples_full(16 to 19)
    min_index_pipeline(3) <= min_index_pipeline(4);
    min_index_pipeline(2) <= min_index_pipeline(3);
    min_index_pipeline(1) <= min_index_pipeline(2);
    min_index_pipeline(0) <= min_index_pipeline(1);

    -- FIND ABS MIN VALUE (comparison tree)
    -- these integer values specify which window # the minimum value is in
    -- it will output the position of the left-most minimum among the five windows

    -- redo below code as priority encoder, will delete below code after finishing this
    if min_pipeline(0) <= min_pipeline(1) and
       min_pipeline(0) <= min_pipeline(2) and
       min_pipeline(0) <= min_pipeline(3) and
       min_pipeline(0) <= min_pipeline(4) then
      min01234 := 0;  -- min in window # 0 (oldest, leftmost)
    elsif min_pipeline(0) > min_pipeline(1) and
          min_pipeline(1) <= min_pipeline(2) and
          min_pipeline(1) <= min_pipeline(3) and
          min_pipeline(1) <= min_pipeline(4) then
      min01234 := 1;  -- min in window # 1
    elsif min_pipeline(0) > min_pipeline(1) and
          min_pipeline(1) > min_pipeline(2) and
          min_pipeline(2) <= min_pipeline(3) and
          min_pipeline(2) <= min_pipeline(4) then
      min01234 := 2;  -- min in window # 2
    elsif min_pipeline(0) > min_pipeline(1) and
          min_pipeline(1) > min_pipeline(2) and
          min_pipeline(2) > min_pipeline(3) and
          min_pipeline(3) <= min_pipeline(4) then
      min01234 := 3;  -- min in window # 3
    else
      min01234 := 4;  -- min in window # 4 (newest, rightmost)
    end if;

    -- old code, tournament style binary tree
    if min_pipeline(0) <= min_pipeline(1) then
      min01 := 0;  -- min in window # 0 (oldest, leftmost)
    else
      min01 := 1;  -- min in window # 1
    end if;

    if min_pipeline(2) <= min_pipeline(3) then
      min23 := 2;  -- min in window # 2
    else
      min23 := 3;  -- min in window # 3
    end if;

    if min_pipeline(min01) <= min_pipeline(min23) then
      min0123 := min01;  -- min in window # 0 or 1
    else
      min0123 := min23;  -- min in window # 2 or 3
    end if;

    if min_pipeline(min0123) <= min_pipeline(4) then
      min01234 := min0123;  -- min in window # 0, 1, 2, or 3 (older ones)
    else
      min01234 := 4;  -- min in window # 4 (newest, rightmost)
    end if;

    if min01234 = 4 then
      abs_min := min_pipeline(4);  -- if the minimum is in the newest window, then it's the current_min
    else
      abs_min := min_pipeline(min01234);  -- otherwise, it's the minimum in the pipeline
    end if;

    min_in_center := (min01234 = 2);  -- if the minimum is in window #2

    peak_found <= (min_in_center and abs_min < signed(thr));
    
  end if;

end process;

-- STATE MACHINE
 process ( clk_a )
  begin
    if ( clk_a'event and clk_a = '1' ) then
      if ( rst = '1' ) then
          event_number <= (others => '0');
          sum <= ( others => '0' );
          sum0 <= ( others => '0' );
          sum_pulse <= ( others => '0' );
          counter <= 0;
          counter_64bit <=0;
          sumstate <= Idle;
          thr <= ithr(15 downto 0);
      else
        case sumstate is

          when Idle =>
             sum <= sum;
             event_number <= event_number;
             counter <= 0;
             counter_64bit <= 0;
             owr_peak_height <= '0';
             owr_peak_sum <= '0';
             thr <= ithr(15 downto 0);
             if(inwr = '1' and last_inwr = '0') then
                       sumstate <= WaitCount;
                       sum <= ( others => '0' );
                       counter <= 0; --counter + 1;
                       counter_64bit <= 0;
                       fifo_rst <= '1';
                       event_number <= event_number + 1;
             end if;

         when WaitCount =>
            fifo_rst <='0';
            owr_peak_height <= '0';
            owr_peak_sum <= '0';
            sum0_stop <='0';
            minpeak_stop <='0';
               if(counter = 4) then
                   sumstate <= SendSum1;
                else
                    counter <= counter + 1;
                    counter_64bit <= counter_64bit + 1;
                end if;

          when SendSum1 =>
             sum0_stop <='0';
             minpeak_stop <='0';
             owr_peak_height <= '0';
             owr_peak_sum <= '0';
             counter <= counter + 1;
             counter_64bit <= counter_64bit + 1;
             if (inwr='1') then
               --------------------------------------------------------------
               --  sum area condition at latch_datain_org
               --  ----------------------------------------------------------
               if(    (samples_full(4) < signed(thr) )                   
               and (samples_full(5) < signed(thr) )                   
               and (samples_full(6) < signed(thr) )                   
               and (samples_full(7) < signed(thr) )
               --------------------------------------------------------------
               --  end sum area condition at latch_datain_org
               --------------------------------------------------------------

               --------------------------------------------------------------
               --  sum area condition at datain_org
               --  ----------------------------------------------------------

               ) then
                   sumstate <= SendSum2;
                   sum <= ( others => '0' );
                   sum0 <= ( others => '0' );
                   sum_pulse <= ( others => '0' );
                   minpeak <= ( others => '0' );
                   peak_data0_tmp <= ( others => '0' );
                   sum0_stop <='0';
                   minpeak_stop <='0';
                   latch_counter1 <= counter;
                   latch_counter1_64bit <= counter_64bit;
                   --counter <= counter + 1;
                   event_number <= event_number + 1;
               end if;

             else
                 sumstate <= Idle;
                 --wr_area <= '0';
                 owr_peak_sum <= '0';
                 counter <= 0;
                 counter_64bit <= 0;
             end if;

          when SendSum2 =>

            
             counter <= counter + 1;
             counter_64bit <= counter_64bit + 1;
             sum <= std_logic_vector(signed(sum) + signed(latch2_datainsum));
             owr_peak_sum <= '0';
                if( all_above_threshold(samples_full, signed(thr)) ) then
                    sumstate <= SendStrobeCheck; --SendStrobe0;
                    latch_counter2 <= counter;
                    latch_counter2_64bit <= counter_64bit;
                 elsif (sum0_stop = '1') then
			               sum0 <= sum;
                        latch_counter0_64bit <= counter_64bit;
                        sumstate <= SendSum3;
		            else
			               sum0 <= sum0;
                        sumstate <= SendSum2;
                 end if;

                  -- -- Print comparisons between adjacent samples from 0 to 11
                  -- PrintT("");  -- print a blank line for spacing
                  -- for i in 0 to 10 loop
                  --    Print("samples_full(" & integer'image(i) & ") > samples_full(" & integer'image(i+1) & ") = " &
                  --          boolean'image(samples_full(i) > samples_full(i+1)));
                  -- end loop;



                --=============================================================
                -- peak high with data one by one
                --==============================================================

               -- assume no peak. if a peak is found, this will be overwritten
               owr_peak_height <= '0';  -- signals "there is no peak"

               if peak_found then
                  owr_peak_height <= '1';  -- signals "there is a peak", 

                  -- Format: [2-bit peak_type ("01")] & [2-bit position] & [28-bit counter] & [16-bit padding] & [12-bit peak]
                  dout_height <= 
                    "01" &  -- this is always 01, not sure what it means, maybe it means it's a peak in the middle four peaks of the 20
                    std_logic_vector(to_unsigned(min_index_pipeline(1), 2)) &  -- this shows where in the middle four points is the peak
                    std_logic_vector(to_unsigned((counter_64bit + 1), 28)) &  -- a counter that just increments every clock cycle
                    x"0000" &  -- idk what this is, maybe just padding, they ran out of things to put here
                    std_logic_vector(samples_full(4 + min_index_pipeline(1)));  -- the peak height
                  
                  minpeak <= std_logic_vector(samples_full(4 + min_index_pipeline(1)));  -- the peak height (again)
                  sum0_stop <= '1';  -- signals for this sumstate to end and move onto SendSum3
                end if;

                  --==================================================================
                  -- end
                  --==================================================================
                     
          when SendSum3 =>
             sum0_stop <= sum0_stop;
             counter <= counter + 1;
             counter_64bit <= counter_64bit + 1;
             owr_peak_sum <= '0';
             sum <= std_logic_vector(signed(sum) + signed(latch2_datainsum));
                if( all_above_threshold(samples_full, signed(thr)) ) then
                    sumstate <= SendStrobeCheck; --SendStrobe0;
                    latch_counter2 <= counter;
                    latch_counter2_64bit <= counter_64bit;
		                sum_pulse <= sum;
                 else
	                sum_pulse <= sum_pulse;
                   sumstate <= SendSum3;
                 end if;

                if(                    --minpeak_stop ='1'
                    signed(minpeak) >  signed(peak_data0_tmp)
                   ) then
                      peak_data0_64bit <=  x"0000" & std_logic_vector(signed(peak_data0_tmp(15 downto 0) ));
                      sum0 <= sum;
                      minpeak <= peak_data0_tmp;
                else
                      sum0 <= sum0;
                      peak_data0_64bit <=  x"0000" & std_logic_vector(signed(minpeak(15 downto 0) ));
                      minpeak <= minpeak;
                end if;

                --=============================================================
                -- peak high with data one by one
                --==============================================================

                -- default these to '0' for the state, and they still stay zero unless set to '1' in the loop below
                owr_peak_height <= '0';
                minpeak_stop <= '0';

               if peak_found then
                  owr_peak_height <= '1';  -- signals "there is a peak", 

                  -- Format: [2-bit peak_type ("01")] & [2-bit position] & [28-bit counter] & [16-bit padding] & [12-bit peak]
                  dout_height <= 
                    "01" &  -- this is always 01, not sure what it means, maybe it means it's a peak in the middle four peaks of the 12
                    -- min_index_pipeline is an array of integers 0-3 showing where the mininum was in each of those windows
                    -- min_index_pipeline(2) is the index of the minimum in the middle four samples (samples_full(8) to samples_full(11))
                    std_logic_vector(to_unsigned(min_index_pipeline(1), 2)) &  -- this shows where in the middle four points is the peak
                    std_logic_vector(to_unsigned((counter_64bit + 1), 28)) &  -- a counter that just increments every clock cycle
                    x"0000" &  -- idk what this is, maybe just padding, they ran out of things to put here

                    -- we want to pull the data out of the middle window, so samples_full(8) to samples_full(11)
                    std_logic_vector(samples_full(4 + min_index_pipeline(1)));  -- the peak height

                  peak_data0_tmp <= std_logic_vector(samples_full(4 + min_index_pipeline(1)));  -- the peak height (again)
                  minpeak_stop <='1';
                end if;

                  --==================================================================
                  -- end
                  --==================================================================



          when SendStrobeCheck =>
               owr_peak_height <= '0';
	            owr_peak_sum <= '0';
               sumstate <= SendStrobe0;
               counter <= counter + 1;
               counter_64bit <= counter_64bit + 1;
               if(sum0_stop = '1') then
                   sumstate <= SendStrobe0;
               else
                   sumstate <= SendStrobe6;
               end if;
          when SendStrobe0 =>
                 owr_peak_height <= '0';
	               owr_peak_sum <= '1';
                  dout_sum <= x"1111" & std_logic_vector(signed(minpeak(15 downto 0) ));
                  --dout_sum <= sum0;

                 counter <= counter + 1;
                 counter_64bit <= counter_64bit + 1;
                 sumstate <= SendStrobe1;

          when SendStrobe1 =>
                 owr_peak_height <= '0';
                  owr_peak_sum <= '1';
                  dout_sum <= sum_pulse;

                 counter <= counter + 1;
                 counter_64bit <= counter_64bit + 1;
                 sumstate <= SendStrobe2;

          when SendStrobe2 =>
                 owr_peak_height <= '0';
                 owr_peak_sum <= '1';
                 --dout_sum <= peak_data0_64bit; --x"0000" & std_logic_vector(signed(minpeak(15 downto 0) ));
                 dout_sum <= sum0;

                 counter <= counter + 1;
                 counter_64bit <= counter_64bit + 1;
                 sumstate <= SendStrobe3;

          when SendStrobe3 =>
                 owr_peak_height <= '0';
                 owr_peak_sum <= '1';
                 dout_sum <= x"0" & std_logic_vector(to_unsigned((latch_counter0_64bit+1),28));

                 counter <= counter + 1;
                 counter_64bit <= counter_64bit + 1;
                 sumstate <= SendStrobe4;

          when SendStrobe4 =>
                 owr_peak_height <= '0';
                 owr_peak_sum <= '1';
                 dout_sum <= x"0" & std_logic_vector(to_unsigned((latch_counter1_64bit+1),28));

                 counter <= counter + 1;
                 counter_64bit <= counter_64bit + 1;
                 sumstate <= SendStrobe5;

          when SendStrobe5 =>
                 owr_peak_sum <= '1';
                 dout_sum <= x"0" & std_logic_vector(to_unsigned((latch_counter2_64bit+1),28));

                 counter <= counter + 1;
                 counter_64bit <= counter_64bit + 1;
                 event_number <= event_number;
	         sum0_stop <= '0';
                 sumstate <= SendStrobe6;

          when SendStrobe6 =>
                 owr_peak_sum <= '0';
                 counter <= counter + 1;
                 counter_64bit <= counter_64bit + 1;
                 if(inwr = '1') then
                   sumstate <= SendSum1;
                   --wr_area <='0';
                 else
                   sumstate <= Idle;
                   --wr_area <= '0';
                 end if;





      end case;

    end if;  -- ending "if ( rst = '1' ) then"

    end if;  -- ending: if ( clk_a'event and clk_a = '1' )

  end process;


end Behavioral;
