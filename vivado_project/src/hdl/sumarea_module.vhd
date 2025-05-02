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
--use ieee.std_logic_unsigned.all;


entity sumarea_module is
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

    owr_peak_height: out std_logic;
    --rden_height : in std_logic;
    --outvalid_height : out std_logic;
    --outempty_height : out std_logic;
    dout_height : out std_logic_vector(63 downto 0)


  );
end sumarea_module;

architecture Behavioral of sumarea_module is


-- component sumarea_fifo
--  port(
--   rst : in std_logic;
--   wr_clk: in std_logic;
--   full : out std_logic;
--   din : in std_logic_vector(31 downto 0);
--   wr_en : in std_logic;
--   rd_clk : in std_logic;
--   valid : out std_logic;
--   empty : out std_logic;
--   dout : out std_logic_vector(31 downto 0);
--   rd_en : in std_logic
--  );
--  end component;
--
-- component peakhigh_fifo
--  port(
--   rst : in std_logic;
--   wr_clk: in std_logic;
--   full : out std_logic;
--   --din : in std_logic_vector(31 downto 0);
--   din : in std_logic_vector(63 downto 0);
--   wr_en : in std_logic;
--   rd_clk : in std_logic;
--   empty : out std_logic;
--   valid : out std_logic;
--   dout : out std_logic_vector(31 downto 0);
--   rd_en : in std_logic
--  );
--  end component;

--signal thr : std_logic_vector(15 downto 0) := x"F380"; --thr = -200
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

--constant data_count_64bit : integer := 5000000; --8192;
constant data_count_64bit : integer := 200000000; --8192;

signal counter_64bit : integer range 0 to data_count_64bit - 1;
signal latch_counter0_64bit : integer range 0 to data_count_64bit - 1;
signal latch_counter1_64bit : integer range 0 to data_count_64bit - 1;
signal latch_counter2_64bit : integer range 0 to data_count_64bit - 1;

signal latch_datain_org0 : signed(15 downto 0);
signal latch_datain_org1 : signed(15 downto 0);
signal latch_datain_org2 : signed(15 downto 0);
signal latch_datain_org3 : signed(15 downto 0);

signal latch2_datain_org0 : signed(15 downto 0);
signal latch2_datain_org1 : signed(15 downto 0);
signal latch2_datain_org2 : signed(15 downto 0);
signal latch2_datain_org3 : signed(15 downto 0);

signal latch3_datain_org0 : signed(15 downto 0);
signal latch3_datain_org1 : signed(15 downto 0);
signal latch3_datain_org2 : signed(15 downto 0);
signal latch3_datain_org3 : signed(15 downto 0);

signal fifo_rst : std_logic;

signal last_inwr : std_logic;
signal event_number : unsigned(31 downto 0):=( others => '0');
signal last_ibusy : std_logic;
signal ibusy : std_logic;

signal peak_data0_64bit : std_logic_vector (31 downto 0);
signal peak_data0_tmp : std_logic_vector (15 downto 0);
signal minpeak : std_logic_vector (15 downto 0);
signal maxdata : std_logic_vector(15 downto 0) := x"8000";


--signal datasum : std_logic_vector(31 downto 0);

  type sumstate_t is ( Idle,
                    WaitCount,
                    SendSum1,
                    SendSum2,
                    SendSum3,
                    --SendWait,
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

begin

  ibusy <= inbusy;

  datasum0 <= std_logic_vector(resize(latch_datain_org0, datasum0'length));
  datasum1 <= std_logic_vector(resize(latch_datain_org1, datasum1'length));
  datasum2 <= std_logic_vector(resize(latch_datain_org2, datasum2'length));
  datasum3 <= std_logic_vector(resize(latch_datain_org3, datasum3'length));

  orst <= fifo_rst;

 process ( rst, clk_a )
 begin
   if ( clk_a'event and clk_a = '1' ) then
        datainsum <= std_logic_vector(signed(datasum0) + signed(datasum1) + signed(datasum2) + signed(datasum3));
        latch_datainsum <= datainsum;
        latch2_datainsum <= latch_datainsum;
        latch3_datainsum <= latch2_datainsum;

   end if;

 end process;

 process ( rst, clk_a )

  begin
    if ( clk_a'event and clk_a = '1' ) then
        last_inwr <= inwr;
        last_ibusy <= ibusy;

        latch_datain_org0 <= signed(datain_org0);
        latch_datain_org1 <= signed(datain_org1);
        latch_datain_org2 <= signed(datain_org2);
        latch_datain_org3 <= signed(datain_org3);

        latch2_datain_org0 <= latch_datain_org0;
        latch2_datain_org1 <= latch_datain_org1;
        latch2_datain_org2 <= latch_datain_org2;
        latch2_datain_org3 <= latch_datain_org3;

        latch3_datain_org0 <= latch2_datain_org0;
        latch3_datain_org1 <= latch2_datain_org1;
        latch3_datain_org2 <= latch2_datain_org2;
        latch3_datain_org3 <= latch2_datain_org3;


      if ( rst = '1' ) then
          event_number <= (others => '0');
          sum <= ( others => '0' );
          sum0 <= ( others => '0' );
          sum_pulse <= ( others => '0' );
          counter <= 0;
          counter_64bit <=0;
          sumstate <= Idle;
      else

        case sumstate is

          when Idle =>
             sum <= sum;
             event_number <= event_number;
             counter <= 0;
             counter_64bit <= 0;
             owr_peak_height <= '0';
             owr_peak_sum <= '0';
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
               if(    (latch2_datain_org0 < signed(ithr) )                   
               and (latch2_datain_org1 < signed(ithr) )                   
               and (latch2_datain_org2 < signed(ithr) )                   
               and (latch2_datain_org3 < signed(ithr) )
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
                if( latch2_datain_org0 > signed(ithr)
                    and latch2_datain_org1 > signed(ithr)
                    and latch2_datain_org2 > signed(ithr)
                    and latch2_datain_org3 > signed(ithr)
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


                --=============================================================
                -- peak high with data one by one
                --==============================================================

                -- peak at latch2_datain_org0
                --  \   /
                --   \/
                if (    latch3_datain_org2 > latch3_datain_org3
                        and latch3_datain_org3 > latch2_datain_org0
                        and latch2_datain_org1 > latch2_datain_org0
                        and latch2_datain_org2 > latch2_datain_org1
                        and latch2_datain_org0 < signed(ithr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org0);
                           minpeak <= std_logic_vector(latch2_datain_org0);
			   sum0_stop <= '1';

                -- \   /
                --  \_/
                elsif ( latch3_datain_org1 > latch3_datain_org2
                        and latch3_datain_org2 > latch3_datain_org3
                        and latch3_datain_org3 = latch2_datain_org0
                        and latch2_datain_org1 > latch2_datain_org0
                        and latch2_datain_org2 > latch2_datain_org1
                        and latch2_datain_org0 < signed(ithr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org0);
                           minpeak <= std_logic_vector(latch2_datain_org0);
			   sum0_stop <= '1';

                elsif ( latch3_datain_org2 > latch3_datain_org3
                        and latch3_datain_org3 > latch2_datain_org0
                        and latch2_datain_org1 = latch2_datain_org0
                        and latch2_datain_org2 > latch2_datain_org1
                        and latch2_datain_org3 > latch2_datain_org2
                        and latch2_datain_org0 < signed(ithr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org0);
                           minpeak <= std_logic_vector(latch2_datain_org0);
			   sum0_stop <= '1';


                -- \     /
                --  \/\/
                --
                elsif ( latch3_datain_org2 > latch3_datain_org3
                        and latch3_datain_org3 > latch2_datain_org0
                        and latch2_datain_org1 > latch2_datain_org0
                        and latch2_datain_org2 < latch2_datain_org1
                        and latch2_datain_org3 > latch2_datain_org2
                        and latch_datain_org0 > latch2_datain_org3
                        and latch2_datain_org0 < signed(ithr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org0);
                           minpeak <= std_logic_vector(latch2_datain_org0);
			   sum0_stop <= '1';

                -- peak at latch2_datain_org1
                -- \  /
                --  \/
                elsif ( latch3_datain_org3 > latch2_datain_org0
                        and latch2_datain_org0 > latch2_datain_org1
                        and latch2_datain_org2 > latch2_datain_org1
                        and latch2_datain_org3 > latch2_datain_org2
                        and latch2_datain_org1 < signed(ithr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org1);
                           minpeak <= std_logic_vector(latch2_datain_org1);
			   sum0_stop <= '1';

                -- \   /
                --  \_/
                elsif ( latch3_datain_org3 > latch2_datain_org0
                        and latch2_datain_org0 > latch2_datain_org1
                        and latch2_datain_org2 = latch2_datain_org1
                        and latch2_datain_org3 > latch2_datain_org1
                        and latch_datain_org0 > latch2_datain_org3
                        and latch2_datain_org1 < signed(ithr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org1);
                           minpeak <= std_logic_vector(latch2_datain_org1);
			   sum0_stop <= '1';


                -- \     /
                --  \/\/
                elsif ( latch3_datain_org3 > latch2_datain_org0
                        and latch2_datain_org0 > latch2_datain_org1
                        and latch2_datain_org2 > latch2_datain_org1
                        and latch2_datain_org3 < latch2_datain_org2
                        and latch_datain_org0 > latch2_datain_org3
                        and latch_datain_org1 > latch_datain_org0
                        and latch2_datain_org1 < signed(ithr)

                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org1);
                           minpeak <= std_logic_vector(latch2_datain_org1);
			   sum0_stop <= '1';

                -- peak at latch2_datain_org2
                -- \  /
                --  \/
                elsif ( latch2_datain_org0 > latch2_datain_org1
                        and latch2_datain_org1 > latch2_datain_org2
                        and latch2_datain_org3 > latch2_datain_org2
                        and latch_datain_org0 > latch2_datain_org3
                        and latch2_datain_org2 < signed(ithr)

                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org2);
                           minpeak <= std_logic_vector(latch2_datain_org2);
			   sum0_stop <= '1';

                -- \   /
                --  \_/
                elsif ( latch2_datain_org0 > latch2_datain_org1
                        and latch2_datain_org1 > latch2_datain_org2
                        and latch2_datain_org3 = latch2_datain_org2
                        and latch_datain_org0 > latch2_datain_org2
                        and latch_datain_org1 > latch_datain_org0
                        and latch2_datain_org2 < signed(ithr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org2);
                           minpeak <= std_logic_vector(latch2_datain_org2);
			   sum0_stop <= '1';

                --\    /
                -- \/\/
                elsif ( latch2_datain_org0 > latch2_datain_org1
                        and latch2_datain_org1 > latch2_datain_org2
                        and latch2_datain_org3 > latch2_datain_org2
                        and latch_datain_org0 < latch2_datain_org3
                        and latch_datain_org1 > latch_datain_org0
                        and latch_datain_org2 > latch_datain_org1
                        and latch2_datain_org2 < signed(ithr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org2);
                           minpeak <= std_logic_vector(latch2_datain_org2);
			   sum0_stop <= '1';

                -- peak at latch2_datain_org3
                -- \  /
                --  \/
                elsif ( latch2_datain_org1 > latch2_datain_org2
                        and latch2_datain_org2 > latch2_datain_org3
                        and latch_datain_org0 > latch2_datain_org3
                        and latch_datain_org1 > latch_datain_org0
                        and latch2_datain_org3 < signed(ithr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org3);
                           minpeak <= std_logic_vector(latch2_datain_org3);
			   sum0_stop <= '1';

                 -- \   /
                 --  \_/
                 elsif ( latch2_datain_org1 > latch2_datain_org2
                         and latch2_datain_org2 > latch2_datain_org3
                         and latch_datain_org0 = latch2_datain_org3
                         and latch_datain_org1 > latch2_datain_org3
                         and latch_datain_org2 > latch_datain_org1
                         and latch2_datain_org3 < signed(ithr)
                         ) then
                            owr_peak_height <= '1';
                            dout_height <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org3);
                            minpeak <= std_logic_vector(latch2_datain_org3);
			    sum0_stop <= '1';


                 --\    /
                 -- \/\/
                 elsif ( latch2_datain_org1 > latch2_datain_org2
                         and latch2_datain_org2 > latch2_datain_org3
                         and latch_datain_org0 > latch2_datain_org3
                         and latch_datain_org1 < latch_datain_org0
                         and latch_datain_org2 > latch_datain_org1
                         and latch_datain_org3 > latch_datain_org2
                         and latch2_datain_org3 < signed(ithr)
                         ) then
                            owr_peak_height <= '1';
                            dout_height <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org3);
                            minpeak <= std_logic_vector(latch2_datain_org3);
			    sum0_stop <= '1';

                -- saturation at latch2_datain_org0
                elsif ( (latch2_datain_org0 and x"fff0") = signed(maxdata)
                        and (latch2_datain_org1 and x"fff0") = signed(maxdata)
                        and (latch2_datain_org2 and x"fff0") = signed(maxdata)
                        and (latch2_datain_org3 and x"fff0") = signed(maxdata)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org0);
                           minpeak <= std_logic_vector(latch2_datain_org0);
			   sum0_stop <= '1';

                elsif ( (latch2_datain_org0 and x"fff0") = signed(maxdata)
                        and (latch2_datain_org1 and x"fff0") = signed(maxdata)
                        and (latch2_datain_org2 and x"fff0") = signed(maxdata)
                        and (latch2_datain_org3 and x"fff0") > signed(maxdata)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org0);
                           minpeak <= std_logic_vector(latch2_datain_org0);
			   sum0_stop <= '1';

                -- saturation at latch2_datain_org1
                elsif ( (latch2_datain_org0 and x"fff0") > signed(maxdata)
                        and (latch2_datain_org1 and x"fff0") = signed(maxdata)
                        and (latch2_datain_org2 and x"fff0") = signed(maxdata)
                        and (latch2_datain_org3 and x"fff0") = signed(maxdata)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org1);
                           minpeak <= std_logic_vector(latch2_datain_org1);
			   sum0_stop <= '1';

                 -- saturation at latch2_datain_org2
                 elsif ( (latch2_datain_org0 and x"fff0") > signed(maxdata)
                         and (latch2_datain_org1 and x"fff0") > signed(maxdata)
                         and (latch2_datain_org2 and x"fff0") = signed(maxdata)
                         and (latch2_datain_org3 and x"fff0") = signed(maxdata)
                         ) then
                            owr_peak_height <= '1';
                            dout_height <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org2);
                            minpeak <= std_logic_vector(latch2_datain_org2);
			    sum0_stop <= '1';

                  -- saturation at latch2_datain_org3
                  elsif ( (latch2_datain_org0 and x"fff0") > signed(maxdata)
                          and (latch2_datain_org1 and x"fff0") > signed(maxdata)
                          and (latch2_datain_org2 and x"fff0") > signed(maxdata)
                          and (latch2_datain_org3 and x"fff0") = signed(maxdata)
                          ) then
                             owr_peak_height <= '1';
                             dout_height <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org3);
                             minpeak <= std_logic_vector(latch2_datain_org3);
			     sum0_stop <= '1';

                  else
                            owr_peak_height <= '0';

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
                if( latch2_datain_org0 > signed(ithr)
                    and latch2_datain_org1 > signed(ithr)
                    and latch2_datain_org2 > signed(ithr)
                    and latch2_datain_org3 > signed(ithr)
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

                -- peak at latch2_datain_org0
                --  \   /
                --   \/
                if (    latch3_datain_org2 > latch3_datain_org3
                        and latch3_datain_org3 > latch2_datain_org0
                        and latch2_datain_org1 > latch2_datain_org0
                        and latch2_datain_org2 > latch2_datain_org1
                        and latch2_datain_org0 < signed(ithr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org0);
                           peak_data0_tmp <= std_logic_vector(latch2_datain_org0);
                           minpeak_stop <='1';

                -- \   /
                --  \_/
                elsif ( latch3_datain_org1 > latch3_datain_org2
                        and latch3_datain_org2 > latch3_datain_org3
                        and latch3_datain_org3 = latch2_datain_org0
                        and latch2_datain_org1 > latch2_datain_org0
                        and latch2_datain_org2 > latch2_datain_org1
                        and latch2_datain_org0 < signed(ithr)
                        ) then
                           owr_peak_height <= '1';
                          dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org0);
                          peak_data0_tmp <= std_logic_vector(latch2_datain_org0);
                           minpeak_stop <='1';

                elsif ( latch3_datain_org2 > latch3_datain_org3
                        and latch3_datain_org3 > latch2_datain_org0
                        and latch2_datain_org1 = latch2_datain_org0
                        and latch2_datain_org2 > latch2_datain_org1
                        and latch2_datain_org3 > latch2_datain_org2
                        and latch2_datain_org0 < signed(ithr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org0);
                           peak_data0_tmp <= std_logic_vector(latch2_datain_org0);
                           minpeak_stop <='1';


                -- \     /
                --  \/\/
                --
                elsif ( latch3_datain_org2 > latch3_datain_org3
                        and latch3_datain_org3 > latch2_datain_org0
                        and latch2_datain_org1 > latch2_datain_org0
                        and latch2_datain_org2 < latch2_datain_org1
                        and latch2_datain_org3 > latch2_datain_org2
                        and latch_datain_org0 > latch2_datain_org3
                        and latch2_datain_org0 < signed(ithr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org0);
                           peak_data0_tmp <= std_logic_vector(latch2_datain_org0);
                           minpeak_stop <='1';

                -- peak at latch2_datain_org1
                -- \  /
                --  \/
                elsif ( latch3_datain_org3 > latch2_datain_org0
                        and latch2_datain_org0 > latch2_datain_org1
                        and latch2_datain_org2 > latch2_datain_org1
                        and latch2_datain_org3 > latch2_datain_org2
                        and latch2_datain_org1 < signed(ithr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org1);
                           peak_data0_tmp <= std_logic_vector(latch2_datain_org1);
                           minpeak_stop <='1';

                -- \   /
                --  \_/
                elsif ( latch3_datain_org3 > latch2_datain_org0
                        and latch2_datain_org0 > latch2_datain_org1
                        and latch2_datain_org2 = latch2_datain_org1
                        and latch2_datain_org3 > latch2_datain_org1
                        and latch_datain_org0 > latch2_datain_org3
                        and latch2_datain_org1 < signed(ithr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org1);
                           peak_data0_tmp <= std_logic_vector(latch2_datain_org1);
                           minpeak_stop <='1';


                -- \     /
                --  \/\/
                elsif ( latch3_datain_org3 > latch2_datain_org0
                        and latch2_datain_org0 > latch2_datain_org1
                        and latch2_datain_org2 > latch2_datain_org1
                        and latch2_datain_org3 < latch2_datain_org2
                        and latch_datain_org0 > latch2_datain_org3
                        and latch_datain_org1 > latch_datain_org0
                        and latch2_datain_org1 < signed(ithr)

                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org1);
                           peak_data0_tmp <= std_logic_vector(latch2_datain_org1);
                           minpeak_stop <='1';

                -- peak at latch2_datain_org2
                -- \  /
                --  \/
                elsif ( latch2_datain_org0 > latch2_datain_org1
                        and latch2_datain_org1 > latch2_datain_org2
                        and latch2_datain_org3 > latch2_datain_org2
                        and latch_datain_org0 > latch2_datain_org3
                        and latch2_datain_org2 < signed(ithr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org2);
                           peak_data0_tmp <= std_logic_vector(latch2_datain_org2);
                           minpeak_stop <='1';

                -- \   /
                --  \_/
                elsif ( latch2_datain_org0 > latch2_datain_org1
                        and latch2_datain_org1 > latch2_datain_org2
                        and latch2_datain_org3 = latch2_datain_org2
                        and latch_datain_org0 > latch2_datain_org2
                        and latch_datain_org1 > latch_datain_org0
                        and latch2_datain_org2 < signed(ithr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org2);
                           peak_data0_tmp <= std_logic_vector(latch2_datain_org2);
                           minpeak_stop <='1';

                --\    /
                -- \/\/
                elsif ( latch2_datain_org0 > latch2_datain_org1
                        and latch2_datain_org1 > latch2_datain_org2
                        and latch2_datain_org3 > latch2_datain_org2
                        and latch_datain_org0 < latch2_datain_org3
                        and latch_datain_org1 > latch_datain_org0
                        and latch_datain_org2 > latch_datain_org1
                        and latch2_datain_org2 < signed(ithr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org2);
                           peak_data0_tmp <= std_logic_vector(latch2_datain_org2);
                           minpeak_stop <='1';

                -- peak at latch2_datain_org3
                -- \  /
                --  \/
                elsif ( latch2_datain_org1 > latch2_datain_org2
                        and latch2_datain_org2 > latch2_datain_org3
                        and latch_datain_org0 > latch2_datain_org3
                        and latch_datain_org1 > latch_datain_org0
                        and latch2_datain_org3 < signed(ithr)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org3);
                           peak_data0_tmp <= std_logic_vector(latch2_datain_org3);
                           minpeak_stop <='1';

                 -- \   /
                 --  \_/
                 elsif ( latch2_datain_org1 > latch2_datain_org2
                         and latch2_datain_org2 > latch2_datain_org3
                         and latch_datain_org0 = latch2_datain_org3
                         and latch_datain_org1 > latch2_datain_org3
                         and latch_datain_org2 > latch_datain_org1
                         and latch2_datain_org3 < signed(ithr)
                         ) then
                            owr_peak_height <= '1';
                            dout_height <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org3);
                           peak_data0_tmp <= std_logic_vector(latch2_datain_org3);
                           minpeak_stop <='1';


                 --\    /
                 -- \/\/
                 elsif ( latch2_datain_org1 > latch2_datain_org2
                         and latch2_datain_org2 > latch2_datain_org3
                         and latch_datain_org0 > latch2_datain_org3
                         and latch_datain_org1 < latch_datain_org0
                         and latch_datain_org2 > latch_datain_org1
                         and latch_datain_org3 > latch_datain_org2
                         and latch2_datain_org3 < signed(ithr)
                         ) then
                            owr_peak_height <= '1';
                            dout_height <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org3);
                           peak_data0_tmp <= std_logic_vector(latch2_datain_org3);
                           minpeak_stop <='1';

                -- saturation at latch2_datain_org0
                elsif ( (latch2_datain_org0 and x"fff0") = signed(maxdata)
                        and (latch2_datain_org1 and x"fff0") = signed(maxdata)
                        and (latch2_datain_org2 and x"fff0") = signed(maxdata)
                        and (latch2_datain_org3 and x"fff0") = signed(maxdata)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org0);
                           peak_data0_tmp <= std_logic_vector(latch2_datain_org0);
                           minpeak_stop <='1';

                elsif ( (latch2_datain_org0 and x"fff0") = signed(maxdata)
                        and (latch2_datain_org1 and x"fff0") = signed(maxdata)
                        and (latch2_datain_org2 and x"fff0") = signed(maxdata)
                        and (latch2_datain_org3 and x"fff0") > signed(maxdata)
                        ) then
                           owr_peak_height <= '1';
                          dout_height <=  "01" & "00" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org0);
                           peak_data0_tmp <= std_logic_vector(latch2_datain_org0);
                           minpeak_stop <='1';

                -- saturation at latch2_datain_org1
                elsif ( (latch2_datain_org0 and x"fff0") > signed(maxdata)
                        and (latch2_datain_org1 and x"fff0") = signed(maxdata)
                        and (latch2_datain_org2 and x"fff0") = signed(maxdata)
                        and (latch2_datain_org3 and x"fff0") = signed(maxdata)
                        ) then
                           owr_peak_height <= '1';
                           dout_height <=  "01" & "01" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org1);
                           peak_data0_tmp <= std_logic_vector(latch2_datain_org1);
                           minpeak_stop <='1';

                 -- saturation at latch2_datain_org2
                 elsif ( (latch2_datain_org0 and x"fff0") > signed(maxdata)
                         and (latch2_datain_org1 and x"fff0") > signed(maxdata)
                         and (latch2_datain_org2 and x"fff0") = signed(maxdata)
                         and (latch2_datain_org3 and x"fff0") = signed(maxdata)
                         ) then
                            owr_peak_height <= '1';
                            dout_height <=  "01" & "10" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org2);
                           peak_data0_tmp <= std_logic_vector(latch2_datain_org2);
                           minpeak_stop <='1';

                  -- saturation at latch2_datain_org3
                  elsif ( (latch2_datain_org0 and x"fff0") > signed(maxdata)
                          and (latch2_datain_org1 and x"fff0") > signed(maxdata)
                          and (latch2_datain_org2 and x"fff0") > signed(maxdata)
                          and (latch2_datain_org3 and x"fff0") = signed(maxdata)
                          ) then
                             owr_peak_height <= '1';
                             dout_height <=  "01" & "11" & std_logic_vector(to_unsigned((counter_64bit+1),28)) & x"0000" & std_logic_vector(latch2_datain_org3);
                           peak_data0_tmp <= std_logic_vector(latch2_datain_org3);
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
