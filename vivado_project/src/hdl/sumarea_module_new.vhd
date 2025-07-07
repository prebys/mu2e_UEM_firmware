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

use work.TextUtil.all;

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

signal thr : std_logic_vector(15 downto 0) := x"F380"; --thr = -200
-- signal thr : std_logic_vector(15 downto 0) := ithr(15 downto 0);

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

type sample_array is array (0 to 7) of signed(15 downto 0);
type sample_input_array is array (0 to 3) of signed(15 downto 0);
type full_sample_array is array (0 to 11) of signed(15 downto 0);

signal samples : sample_array;        -- latched values t-2 and t-1
signal inputs  : sample_input_array;  -- direct wires for t
signal samples_full : full_sample_array; -- all values (inc. direct wires) from t-2, t-1, and t


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

  -- Peak detection functions
  -- Below function matches a simple V shape
  --     (i-2)                 (i+2)
  --          (i-1)      (i+1)
  --               (*i*)
function is_v_valley_centered_at(
    i : integer;
    v : full_sample_array;
    thr : signed(15 downto 0)
  ) return boolean is
  begin
    return (
      v(i-2) > v(i-1) and
      v(i-1) > v(i)   and
      v(i)   < v(i+1) and
      v(i+1) < v(i+2) and
      v(i)   < signed(thr)
    );
  end function;
  
  -- Below function matches a flat-bottom
  --      (i-2)                     (i+3)
  --           (i-1)           (i+2)
  --                (*i*) (i+1)
  -- 
  -- For the left-most point in the center four points (i=4), it also matches a flat-bottom extending into i=3
  --      (i-3)                     (i+2)
  --           (i-2)           (i+1)
  --                (i-1) (*i*)
  --

  function is_flat_bottom_valley_at_left(
    i : integer;
    v : full_sample_array;
    thr : signed(15 downto 0)
  ) return boolean is
  begin
    return (
      v(i-3) > v(i-2) and
      v(i-2) > v(i-1) and
      v(i-1) = v(i) and
      v(i)   < v(i+1) and
      v(i+1) < v(i+2) and
      v(i)   < signed(thr)
    );
  end function;

   function is_flat_bottom_valley_at_right(
    i : integer;
    v : full_sample_array;
    thr : signed(15 downto 0)
  ) return boolean is
  begin
    return (
      v(i-2) > v(i-1) and
      v(i-1) > v(i) and
      v(i)   = v(i+1) and
      v(i+1) < v(i+2) and
      v(i+2) < v(i+3) and
      v(i)   < signed(thr)
    );
  end function;

  function is_flat_bottom_valley_at(
    i : integer;
    v : full_sample_array;
    thr : signed(15 downto 0)
  ) return boolean is
   -- This function checks for a flat bottom valley at the given index
   -- if it's the leftmost index (i=4), then it also checks for if the flat-bottom 
   -- went to the left at i=3 or right at i=5
   -- for the base at i=5, it doesn't need to check left anymore because the right-sided i=4 
   -- case already checked for that
  begin
   if (i = 4) then
      return is_flat_bottom_valley_at_left(i, v, thr) or
             is_flat_bottom_valley_at_right(i, v, thr);
   else
      return is_flat_bottom_valley_at_right(i, v, thr);
   end if;
  end function;
  

  -- Matches patterns of the following form
  --  (i-2)                                 (i+4) 
  --        (i-1)        (i+1)        (i+3)
  --              (*i*)        (i+2) 
  function is_ripple_valley_at(
    i : integer;
    v : full_sample_array;
    thr : signed(15 downto 0)
  ) return boolean is
  begin
    return (
      v(i-2) > v(i-1) and
      v(i-1) > v(i) and
      v(i)   < v(i+1) and
      v(i+1) > v(i+2) and
      v(i+2) < v(i+3) and
      v(i+3) < v(i+4) and
      v(i)   < signed(thr)
    );
  end function;

-- Check if a saturation pattern exists starting at index i
function is_saturation_pattern_at(
  i       : integer;
  v       : full_sample_array;
  maxdata : signed(15 downto 0)
) return boolean is
begin
  return (
    signed(v(i)   and x"fff0") = maxdata and
    signed(v(i+1) and x"fff0") = maxdata and
    signed(v(i+2) and x"fff0") = maxdata and
    signed(v(i+3) and x"fff0") = maxdata
  );
end function;



    -- Refactored peak detection logic
function check_peaks(
    i : integer;
    v : full_sample_array;
    thr : signed(15 downto 0);
    maxdata : signed(15 downto 0)
  ) return boolean is
  begin
    return (
      is_v_valley_centered_at(i, v, thr) or
      is_flat_bottom_valley_at(i, v, thr) or
      is_ripple_valley_at(i, v, thr) or 
      is_saturation_pattern_at(i, v, maxdata)
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

   --  latch3         latch2     (these come from latches)
   samples_full(0) <= samples(0);  -- latch3_datain_org0  OLDEST (t=11)
   samples_full(1) <= samples(1);  -- latch3_datain_org1
   samples_full(2) <= samples(2);  -- latch3_datain_org2
   samples_full(3) <= samples(3);  -- latch3_datain_org3  ~old (t=8)

   --  latch2         latch1     (these come from latches)
   samples_full(4) <= samples(4);  -- latch2_datain_org0  mid-old (t=7)
   samples_full(5) <= samples(5);  -- latch2_datain_org1
   samples_full(6) <= samples(6);  -- latch2_datain_org2
   samples_full(7) <= samples(7);  -- latch2_datain_org3  mid-new (t=4)

   --  latch1         latch0      (these should all be instant wires)
   samples_full(8) <= inputs(0);  -- latch_datain_org0  ~new (t=3)
   samples_full(9) <= inputs(1);  -- latch_datain_org1
   samples_full(10) <= inputs(2); -- latch_datain_org2
   samples_full(11) <= inputs(3); -- latch_datain_org3  NEWEST (t=0)

   

 process ( clk_a )
 begin
   if ( clk_a'event and clk_a = '1' ) then
        datainsum <= std_logic_vector(signed(datasum0) + signed(datasum1) + signed(datasum2) + signed(datasum3));
        latch_datainsum <= datainsum;
        latch2_datainsum <= latch_datainsum;
        latch3_datainsum <= latch2_datainsum;

   end if;

 end process;

 process ( clk_a )
   variable peak_number : integer range 0 to 3;
  begin
    if ( clk_a'event and clk_a = '1' ) then
        last_inwr <= inwr;
        last_ibusy <= ibusy;

         samples(0) <= samples(4);  -- oldest (t=12)
         samples(1) <= samples(5);
         samples(2) <= samples(6);
         samples(3) <= samples(7);  -- slightly newer (t=9)

         samples(4) <= inputs(0);  -- slightly older (latched version of datain_0)
         samples(5) <= inputs(1);
         samples(6) <= inputs(2);
         samples(7) <= inputs(3);  -- newest (t=0), latched of what was the last to be appended

      if ( rst = '1' ) then
          event_number <= (others => '0');
          sum <= ( others => '0' );
          sum0 <= ( others => '0' );
          sum_pulse <= ( others => '0' );
          counter <= 0;
          counter_64bit <=0;
          sumstate <= Idle;
          thr <= ithr(31) & ithr(14 downto 0);
      else

        case sumstate is

          when Idle =>
             sum <= sum;
             event_number <= event_number;
             counter <= 0;
             counter_64bit <= 0;
             owr_peak_height <= '0';
             owr_peak_sum <= '0';
             thr <= ithr(31) & ithr(14 downto 0);
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
                if( samples_full(4) > signed(thr)
                    and samples_full(5) > signed(thr)
                    and samples_full(6) > signed(thr)
                    and samples_full(7) > signed(thr)
                   ) then
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

                -- peak at samples_full(4) (1)
                --  \   /
                --   \/
                if is_v_valley_centered_at(4, samples_full, signed(thr)) then
                    owr_peak_height <= '1';
                    --peak_data_64bit <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(4)(15 downto 0) ));
                    dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(4)(15 downto 0) ));
                    --peak_data0_64bit <=  x"0000" & std_logic_vector(signed(samples_full(4)(15 downto 0) ));
                    minpeak <= std_logic_vector(samples_full(4));
			        sum0_stop <= '1';

                -- \   /  (2)
                --  \_/            
                elsif ( samples_full(1) > samples_full(2)
                        and samples_full(2) > samples_full(3)
                        and samples_full(3) = samples_full(4)
                        and samples_full(5) > samples_full(4)                        
                        and samples_full(6) > samples_full(5)                        
                        and samples_full(4) < signed(thr) 
                        --and samples_full(1) < signed(thr)
                        --and samples_full(8) > signed(maxdata)
                        ) then
                           owr_peak_height <= '1';
                           --peak_data_64bit <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(4)(15 downto 0) ));
                           dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(4)(15 downto 0) ));
                           --peak_data0_64bit <=  x"0000" & std_logic_vector(signed(samples_full(4)(15 downto 0) ));
                           minpeak <= std_logic_vector(samples_full(4));
			   sum0_stop <= '1';

                elsif ( samples_full(2) > samples_full(3)
                        and samples_full(3) > samples_full(4)
                        and samples_full(4) = samples_full(5)
                        and samples_full(6) > samples_full(5)                        
                        and samples_full(7) > samples_full(6)                        
                        and samples_full(4) < signed(thr) 
                        --and samples_full(2) < signed(thr)
                        --and samples_full(8) > signed(maxdata)
                        ) then
                           owr_peak_height <= '1';
                           --peak_data_64bit <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(4)(15 downto 0) ));
                           dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(4)(15 downto 0) ));
                           --peak_data0_64bit <=  x"0000" & std_logic_vector(signed(samples_full(4)(15 downto 0) ));
                           minpeak <= std_logic_vector(samples_full(4));
			   sum0_stop <= '1';


                -- \     /   (4)
                --  \/\/
                --
                elsif ( samples_full(2) > samples_full(3)
                        and samples_full(3) > samples_full(4)
                        and samples_full(5) > samples_full(4)
                        and samples_full(6) < samples_full(5)
                        and samples_full(7) > samples_full(6)
                        and samples_full(8) > samples_full(7)                        
                        and samples_full(4) < signed(thr)
                        --and signed(datain_org0) > samples_full(11)
                        --and samples_full(8) < signed(thr)                         
                        --and samples_full(8) > signed(maxdata)
                        ) then
                           owr_peak_height <= '1';
                           --peak_data_64bit <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(4)(15 downto 0) ));
                           dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(4)(15 downto 0) ));
                           --peak_data0_64bit <=  x"0000" & std_logic_vector(signed(samples_full(4)(15 downto 0) ));
                           minpeak <= std_logic_vector(samples_full(4));
			   sum0_stop <= '1';

                -- peak at samples_full(5)
                -- \  /
                --  \/                           
                elsif ( samples_full(3) > samples_full(4)
                        and samples_full(4) > samples_full(5)
                        and samples_full(6) > samples_full(5)
                        and samples_full(7) > samples_full(6)
                        and samples_full(5) < signed(thr)
                        --and samples_full(3) < signed(thr)) 
                        --and samples_full(9) > signed(maxdata)
                        ) then
                           owr_peak_height <= '1';
                           --peak_data_64bit <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(5)(15 downto 0) ));
                           dout_height <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(5)(15 downto 0) ));
                           --peak_data0_64bit <=  x"0000" & std_logic_vector(signed(samples_full(5)(15 downto 0) ));
                           minpeak <= std_logic_vector(samples_full(5));
			   sum0_stop <= '1';
           
                -- \   /
                --  \_/
                elsif ( samples_full(3) > samples_full(4)
                        and samples_full(4) > samples_full(5)
                        and samples_full(6) = samples_full(5)
                        and samples_full(7) > samples_full(5)
                        and samples_full(8) > samples_full(7)
                        and samples_full(5) < signed(thr) 
                        --and samples_full(3) < signed(thr))
                        --and samples_full(9) > signed(maxdata)
                        ) then
                           owr_peak_height <= '1';
                           --peak_data_64bit <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(5)(15 downto 0) ));
                           dout_height <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(5)(15 downto 0) ));
                           --peak_data0_64bit <=  x"0000" & std_logic_vector(signed(samples_full(5)(15 downto 0) ));
                           minpeak <= std_logic_vector(samples_full(5));
			   sum0_stop <= '1';
           
           
                -- \     /
                --  \/\/
                elsif ( samples_full(3) > samples_full(4)
                        and samples_full(4) > samples_full(5)
                        and samples_full(6) > samples_full(5)
                        and samples_full(7) < samples_full(6)
                        and samples_full(8) > samples_full(7)
                        and samples_full(9) > samples_full(8)
                        and samples_full(5) < signed(thr) 
                        
                        -- and signed(datain_org1) > signed(datain_org0)
                        --and samples_full(9) < signed(thr) 
                        --and samples_full(7) < signed(thr) 
                        --and samples_full(9) > signed(maxdata)
                        ) then
                           owr_peak_height <= '1';
                           --peak_data_64bit <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(5)(15 downto 0) ));
                           dout_height <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(5)(15 downto 0) ));
                           --peak_data0_64bit <=  x"0000" & std_logic_vector(signed(samples_full(5)(15 downto 0) ));
                           minpeak <= std_logic_vector(samples_full(5));
			   sum0_stop <= '1';
             
                -- peak at samples_full(6)
                -- \  /
                --  \/                           
                elsif ( samples_full(4) > samples_full(5)
                        and samples_full(5) > samples_full(6)
                        and samples_full(7) > samples_full(6)
                        and samples_full(8) > samples_full(7)
                        and samples_full(6) < signed(thr)
                        --and samples_full(4) < signed(thr) 
                        --and samples_full(10) > signed(maxdata) 
                        ) then
                           owr_peak_height <= '1';
                           --peak_data_64bit <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(6)(15 downto 0) ));     
                           dout_height <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(6)(15 downto 0) ));     
                           --peak_data0_64bit <=  x"0000" & std_logic_vector(signed(samples_full(6)(15 downto 0) ));
                           minpeak <= std_logic_vector(samples_full(6));
			   sum0_stop <= '1';
                      
                -- \   /
                --  \_/
                elsif ( samples_full(4) > samples_full(5)
                        and samples_full(5) > samples_full(6)
                        and samples_full(7) = samples_full(6)
                        and samples_full(8) > samples_full(6)
                        and samples_full(9) > samples_full(8)
                        and samples_full(6) < signed(thr)
                        --and samples_full(4) < signed(thr) 
                        --and samples_full(10) > signed(maxdata)
                        ) then
                           owr_peak_height <= '1';
                           --peak_data_64bit <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(6)(15 downto 0) ));
                           dout_height <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(6)(15 downto 0) ));
                           --peak_data0_64bit <=  x"0000" & std_logic_vector(signed(samples_full(6)(15 downto 0) ));
                           minpeak <= std_logic_vector(samples_full(6));
			   sum0_stop <= '1';
                      
                --\    /
                -- \/\/
                elsif ( samples_full(4) > samples_full(5)
                        and samples_full(5) > samples_full(6)
                        and samples_full(7) > samples_full(6)
                        and samples_full(8) < samples_full(7)
                        and samples_full(9) > samples_full(8)
                        and samples_full(10) > samples_full(9)
                        and samples_full(6) < signed(thr)
                        --and signed(datain_org2) > signed(datain_org1)
                        --and samples_full(10) < signed(thr) 
                        --and samples_full(8) < signed(thr)
                        --and samples_full(10) > signed(maxdata)
                        ) then
                           owr_peak_height <= '1';
                           --peak_data_64bit <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(6)(15 downto 0) ));
                           dout_height <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(6)(15 downto 0) ));
                           --peak_data0_64bit <=  x"0000" & std_logic_vector(signed(samples_full(6)(15 downto 0) ));
                           minpeak <= std_logic_vector(samples_full(6));
			   sum0_stop <= '1';
              
                -- peak at samples_full(7)
                -- \  /
                --  \/                           
                elsif ( samples_full(5) > samples_full(6)
                        and samples_full(6) > samples_full(7)
                        and samples_full(8) > samples_full(7)
                        and samples_full(9) > samples_full(8)
                        and samples_full(7) < signed(thr)
                        --and samples_full(5) < signed(thr) 
                        --and samples_full(11) > signed(maxdata)
                        ) then
                           owr_peak_height <= '1';
                           --peak_data_64bit <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(7)(15 downto 0) ));
                           dout_height <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(7)(15 downto 0) ));
                           --peak_data0_64bit <=  x"0000" & std_logic_vector(signed(samples_full(7)(15 downto 0) ));
                           minpeak <= std_logic_vector(samples_full(7));
			   sum0_stop <= '1';
                                  
                 -- \   /
                 --  \_/
                 elsif ( samples_full(5) > samples_full(6)
                         and samples_full(6) > samples_full(7)
                         and samples_full(8) = samples_full(7)
                         and samples_full(9) > samples_full(7)
                         and samples_full(10) > samples_full(9)
                         and samples_full(7) < signed(thr)
                         --and samples_full(5) < signed(thr) 
                         --and samples_full(11) > signed(maxdata)
                         ) then
                            owr_peak_height <= '1';
                            --peak_data_64bit <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(7)(15 downto 0) ));
                            dout_height <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(7)(15 downto 0) ));
                            --peak_data0_64bit <=  x"0000" & std_logic_vector(signed(samples_full(7)(15 downto 0) ));
                            minpeak <= std_logic_vector(samples_full(7));
			    sum0_stop <= '1';
                                  
                                                   
                 --\    /
                 -- \/\/
                 elsif ( samples_full(5) > samples_full(6)
                         and samples_full(6) > samples_full(7)
                         and samples_full(8) > samples_full(7)
                         and samples_full(9) < samples_full(8)
                         and samples_full(10) > samples_full(9)  
                         and samples_full(11) > samples_full(10)                        
                         and samples_full(7) < signed(thr) 
                         --and samples_full(5) < signed(thr)
                         --and signed(datain_org3) > signed(datain_org2)
                         --and samples_full(11) > signed(maxdata)
                         ) then
                            owr_peak_height <= '1';
                            --peak_data_64bit <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(7)(15 downto 0) ));
                            dout_height <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(7)(15 downto 0) ));
                            --peak_data0_64bit <=  x"0000" & std_logic_vector(signed(samples_full(7)(15 downto 0) ));
                            minpeak <= std_logic_vector(samples_full(7));
			    sum0_stop <= '1';
                                  
                -- saturation at samples_full(4)         
                elsif ( signed(samples_full(4) and x"fff0") = signed(maxdata)
                        and signed(samples_full(5) and x"fff0") = signed(maxdata)                          
                        and signed(samples_full(6) and x"fff0") = signed(maxdata)
                        and signed(samples_full(7) and x"fff0") = signed(maxdata)
                        ) then
                           owr_peak_height <= '1';
                           --peak_data_64bit <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(4)(15 downto 0) )); 
                           dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(4)(15 downto 0) )); 
                           --peak_data0_64bit <=  x"0000" & std_logic_vector(signed(samples_full(4)(15 downto 0) ));
                           minpeak <= std_logic_vector(samples_full(4));
			   sum0_stop <= '1';
                                                                                     
                elsif ( signed(samples_full(4) and x"fff0") = signed(maxdata)
                        and signed(samples_full(5) and x"fff0") = signed(maxdata)                          
                        and signed(samples_full(6) and x"fff0") = signed(maxdata)
                        and signed(samples_full(7) and x"fff0") > signed(maxdata)
                        ) then
                           owr_peak_height <= '1';
                           --peak_data_64bit <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(4)(15 downto 0) ));         
                           dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(4)(15 downto 0) ));         
                           --peak_data0_64bit <=  x"0000" & std_logic_vector(signed(samples_full(4)(15 downto 0) ));
                           minpeak <= std_logic_vector(samples_full(4));
			   sum0_stop <= '1';
                                  
                -- saturation at samples_full(5)         
                elsif ( signed(samples_full(4) and x"fff0") > signed(maxdata)
                        and signed(samples_full(5) and x"fff0") = signed(maxdata)                          
                        and signed(samples_full(6) and x"fff0") = signed(maxdata)
                        and signed(samples_full(7) and x"fff0") = signed(maxdata)
                        ) then
                           owr_peak_height <= '1';
                           --peak_data_64bit <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(5)(15 downto 0) ));
                           dout_height <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(5)(15 downto 0) ));
                           --peak_data0_64bit <=  x"0000" & std_logic_vector(signed(samples_full(5)(15 downto 0) ));
                           minpeak <= std_logic_vector(samples_full(5));
			   sum0_stop <= '1';
                                                  
                 -- saturation at samples_full(6)                                 
                 elsif ( signed(samples_full(4) and x"fff0") > signed(maxdata)
                         and signed(samples_full(5) and x"fff0") > signed(maxdata)                          
                         and signed(samples_full(6) and x"fff0") = signed(maxdata)
                         and signed(samples_full(7) and x"fff0") = signed(maxdata)
                         ) then
                            owr_peak_height <= '1';
                            --peak_data_64bit <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(6)(15 downto 0) ));
                            dout_height <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(6)(15 downto 0) ));
                            --peak_data0_64bit <=  x"0000" & std_logic_vector(signed(samples_full(6)(15 downto 0) ));
                            minpeak <= std_logic_vector(samples_full(6));
			    sum0_stop <= '1';
                                  
                  -- saturation at samples_full(7)                                 
                  elsif ( signed(samples_full(4) and x"fff0") > signed(maxdata)
                          and signed(samples_full(5) and x"fff0") > signed(maxdata)                          
                          and signed(samples_full(6) and x"fff0") > signed(maxdata)
                          and signed(samples_full(7) and x"fff0") = signed(maxdata)
                          ) then
                             owr_peak_height <= '1';
                             --peak_data_64bit <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(7)(15 downto 0) ));
                             dout_height <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(signed(samples_full(7)(15 downto 0) ));
                             --peak_data0_64bit <=  x"0000" & std_logic_vector(signed(samples_full(7)(15 downto 0) ));
                             minpeak <= std_logic_vector(samples_full(7));
			     sum0_stop <= '1';
                  
                  else
                            owr_peak_height <= '0';
			    --sum0_stop <= '0';
                            
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
                if( samples_full(4) > signed(thr)
                    and samples_full(5) > signed(thr)
                    and samples_full(6) > signed(thr)
                    and samples_full(7) > signed(thr)
                   ) then
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

                -- peak at samples_full(4)
                --  \   /
                --   \/
                if (    samples_full(2) > samples_full(3)
                        and samples_full(3) > samples_full(4)
                        and samples_full(5) > samples_full(4)
                        and samples_full(6) > samples_full(5)
                        and samples_full(4) < signed(thr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(samples_full(4));
                           peak_data0_tmp <= std_logic_vector(samples_full(4));
                           minpeak_stop <='1';

                -- \   /
                --  \_/
                elsif ( samples_full(1) > samples_full(2)
                        and samples_full(2) > samples_full(3)
                        and samples_full(3) = samples_full(4)
                        and samples_full(5) > samples_full(4)
                        and samples_full(6) > samples_full(5)
                        and samples_full(4) < signed(thr)
                        ) then
                           owr_peak_height <= '1';
                          dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(samples_full(4));
                          peak_data0_tmp <= std_logic_vector(samples_full(4));
                           minpeak_stop <='1';

                elsif ( samples_full(2) > samples_full(3)
                        and samples_full(3) > samples_full(4)
                        and samples_full(5) = samples_full(4)
                        and samples_full(6) > samples_full(5)
                        and samples_full(7) > samples_full(6)
                        and samples_full(4) < signed(thr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(samples_full(4));
                           peak_data0_tmp <= std_logic_vector(samples_full(4));
                           minpeak_stop <='1';


                -- \     /
                --  \/\/
                --
                elsif ( samples_full(2) > samples_full(3)
                        and samples_full(3) > samples_full(4)
                        and samples_full(5) > samples_full(4)
                        and samples_full(6) < samples_full(5)
                        and samples_full(7) > samples_full(6)
                        and samples_full(8) > samples_full(7)
                        and samples_full(4) < signed(thr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(samples_full(4));
                           peak_data0_tmp <= std_logic_vector(samples_full(4));
                           minpeak_stop <='1';

                -- peak at samples_full(5)
                -- \  /
                --  \/
                elsif ( samples_full(3) > samples_full(4)
                        and samples_full(4) > samples_full(5)
                        and samples_full(6) > samples_full(5)
                        and samples_full(7) > samples_full(6)
                        and samples_full(5) < signed(thr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(samples_full(5));
                           peak_data0_tmp <= std_logic_vector(samples_full(5));
                           minpeak_stop <='1';

                -- \   /
                --  \_/
                elsif ( samples_full(3) > samples_full(4)
                        and samples_full(4) > samples_full(5)
                        and samples_full(6) = samples_full(5)
                        and samples_full(7) > samples_full(5)
                        and samples_full(8) > samples_full(7)
                        and samples_full(5) < signed(thr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(samples_full(5));
                           peak_data0_tmp <= std_logic_vector(samples_full(5));
                           minpeak_stop <='1';


                -- \     /
                --  \/\/
                elsif ( samples_full(3) > samples_full(4)
                        and samples_full(4) > samples_full(5)
                        and samples_full(6) > samples_full(5)
                        and samples_full(7) < samples_full(6)
                        and samples_full(8) > samples_full(7)
                        and samples_full(9) > samples_full(8)
                        and samples_full(5) < signed(thr)

                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(samples_full(5));
                           peak_data0_tmp <= std_logic_vector(samples_full(5));
                           minpeak_stop <='1';

                -- peak at samples_full(6)
                -- \  /
                --  \/
                elsif ( samples_full(4) > samples_full(5)
                        and samples_full(5) > samples_full(6)
                        and samples_full(7) > samples_full(6)
                        and samples_full(8) > samples_full(7)
                        and samples_full(6) < signed(thr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(samples_full(6));
                           peak_data0_tmp <= std_logic_vector(samples_full(6));
                           minpeak_stop <='1';

                -- \   /
                --  \_/
                elsif ( samples_full(4) > samples_full(5)
                        and samples_full(5) > samples_full(6)
                        and samples_full(7) = samples_full(6)
                        and samples_full(8) > samples_full(6)
                        and samples_full(9) > samples_full(8)
                        and samples_full(6) < signed(thr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(samples_full(6));
                           peak_data0_tmp <= std_logic_vector(samples_full(6));
                           minpeak_stop <='1';

                --\    /
                -- \/\/
                elsif ( samples_full(4) > samples_full(5)
                        and samples_full(5) > samples_full(6)
                        and samples_full(7) > samples_full(6)
                        and samples_full(8) < samples_full(7)
                        and samples_full(9) > samples_full(8)
                        and samples_full(10) > samples_full(9)
                        and samples_full(6) < signed(thr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(samples_full(6));
                           peak_data0_tmp <= std_logic_vector(samples_full(6));
                           minpeak_stop <='1';

                -- peak at samples_full(7)
                -- \  /
                --  \/
                elsif ( samples_full(5) > samples_full(6)
                        and samples_full(6) > samples_full(7)
                        and samples_full(8) > samples_full(7)
                        and samples_full(9) > samples_full(8)
                        and samples_full(7) < signed(thr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(samples_full(7));
                           peak_data0_tmp <= std_logic_vector(samples_full(7));
                           minpeak_stop <='1';

                 -- \   /
                 --  \_/
                 elsif ( samples_full(5) > samples_full(6)
                         and samples_full(6) > samples_full(7)
                         and samples_full(8) = samples_full(7)
                         and samples_full(9) > samples_full(7)
                         and samples_full(10) > samples_full(9)
                         and samples_full(7) < signed(thr)
                         ) then
                            owr_peak_height <= '1';
                            dout_height <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(samples_full(7));
                           peak_data0_tmp <= std_logic_vector(samples_full(7));
                           minpeak_stop <='1';


                 --\    /
                 -- \/\/
                 elsif ( samples_full(5) > samples_full(6)
                         and samples_full(6) > samples_full(7)
                         and samples_full(8) > samples_full(7)
                         and samples_full(9) < samples_full(8)
                         and samples_full(10) > samples_full(9)
                         and samples_full(11) > samples_full(10)
                         and samples_full(7) < signed(thr)
                         ) then
                            owr_peak_height <= '1';
                            dout_height <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(samples_full(7));
                           peak_data0_tmp <= std_logic_vector(samples_full(7));
                           minpeak_stop <='1';

                -- saturation at samples_full(4)
                elsif ( (samples_full(4) and x"fff0") = signed(maxdata)
                        and (samples_full(5) and x"fff0") = signed(maxdata)
                        and (samples_full(6) and x"fff0") = signed(maxdata)
                        and (samples_full(7) and x"fff0") = signed(maxdata)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(samples_full(4));
                           peak_data0_tmp <= std_logic_vector(samples_full(4));
                           minpeak_stop <='1';

                elsif ( (samples_full(4) and x"fff0") = signed(maxdata)
                        and (samples_full(5) and x"fff0") = signed(maxdata)
                        and (samples_full(6) and x"fff0") = signed(maxdata)
                        and (samples_full(7) and x"fff0") > signed(maxdata)
                        ) then
                           owr_peak_height <= '1';
                          dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(samples_full(4));
                           peak_data0_tmp <= std_logic_vector(samples_full(4));
                           minpeak_stop <='1';

                -- saturation at samples_full(5)
                elsif ( (samples_full(4) and x"fff0") > signed(maxdata)
                        and (samples_full(5) and x"fff0") = signed(maxdata)
                        and (samples_full(6) and x"fff0") = signed(maxdata)
                        and (samples_full(7) and x"fff0") = signed(maxdata)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(samples_full(5));
                           peak_data0_tmp <= std_logic_vector(samples_full(5));
                           minpeak_stop <='1';

                 -- saturation at samples_full(6)
                 elsif ( (samples_full(4) and x"fff0") > signed(maxdata)
                         and (samples_full(5) and x"fff0") > signed(maxdata)
                         and (samples_full(6) and x"fff0") = signed(maxdata)
                         and (samples_full(7) and x"fff0") = signed(maxdata)
                         ) then
                            owr_peak_height <= '1';
                            dout_height <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(samples_full(6));
                           peak_data0_tmp <= std_logic_vector(samples_full(6));
                           minpeak_stop <='1';

                  -- saturation at samples_full(7)
                  elsif ( (samples_full(4) and x"fff0") > signed(maxdata)
                          and (samples_full(5) and x"fff0") > signed(maxdata)
                          and (samples_full(6) and x"fff0") > signed(maxdata)
                          and (samples_full(7) and x"fff0") = signed(maxdata)
                          ) then
                             owr_peak_height <= '1';
                             dout_height <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(samples_full(7));
                           peak_data0_tmp <= std_logic_vector(samples_full(7));
                           minpeak_stop <='1';

                  else
                            owr_peak_height <= '0';
                            minpeak_stop <='0';

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

    end if;

   end if;

  end process;





end Behavioral;
