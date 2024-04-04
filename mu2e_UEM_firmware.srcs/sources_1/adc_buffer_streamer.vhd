----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/23/2016 08:43:39 PM
-- Design Name: 
-- Module Name: adc_buffer_streamer - Behavioral
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

entity adc_buffer_streamer is
  port (
    rst : in std_logic;
    clk : in std_logic;
    valid : in std_logic_vector(3 downto 0);
    done : in std_logic_vector(3 downto 0);
    rden : out std_logic_vector(3 downto 0);
    bco : in std_logic_vector(47 downto 0);
    din0 : in std_logic_vector(31 downto 0);
    din1 : in std_logic_vector(31 downto 0);
    din2 : in std_logic_vector(31 downto 0);
    din3 : in std_logic_vector(31 downto 0);
    infifo_empty0 : in std_logic;
    infifo_empty1 : in std_logic;    
    infifo_empty2 : in std_logic;
    infifo_empty3 : in std_logic;
    
    infifo_valid0 : in std_logic;
    infifo_valid1 : in std_logic;
    infifo_valid2 : in std_logic;
    infifo_valid3 : in std_logic;
    
    status0 : in std_logic_vector(31 downto 0);
    status1 : in std_logic_vector(31 downto 0);
    status2 : in std_logic_vector(31 downto 0);
    status3 : in std_logic_vector(31 downto 0);
    trig0 : in std_logic_vector(15 downto 0);
    trig1 : in std_logic_vector(15 downto 0);
    trig2 : in std_logic_vector(15 downto 0);
    trig3 : in std_logic_vector(15 downto 0);
    testmode : in std_logic_vector(3 downto 0);

    data_adc_length : in std_logic_vector(31 downto 0);

    wren : out std_logic;
    dout : out std_logic_vector(31 downto 0);
    inreq1 : in std_logic;
    inbusy1 : in std_logic;
    strobe : out std_logic
  );
end adc_buffer_streamer;

architecture Behavioral of adc_buffer_streamer is

  function nbits( n : integer ) return natural is
    variable i : natural;
  begin
    i := 0;
    while ( 2**i < n ) loop
      i := i + 1;
    end loop;
    return i;
  end function;

  component lfsr_n
  generic (
    width : integer := 4
  );
  port (
    rst : in std_logic;
    clk : in std_logic;
    en : in std_logic;
    dout : out std_logic_vector(width-1 downto 0);
    prev : out std_logic_vector(width-1 downto 0)
  );
  end component;

  --constant word_count : integer := 100; --128; --256;
  constant word_count : integer := to_integer(unsigned(data_adc_length)); --128; --256;
  constant number_channel : integer := 5;

  constant word_rest : integer := 2048;
  signal count_rest : integer range 0 to word_rest-1;
  
  --signal nchannel : integer range 0 to number_channel-1;
  signal channels : std_logic_vector(1 downto 0) := "11";

  signal nchannel : unsigned(1 downto 0);  
    
  --signal count : integer range 0 to word_count-1;
  signal count : unsigned(31 downto 0);
  
  signal read_data : std_logic_vector(31 downto 0);
  signal fragment : unsigned(7 downto 0);
  signal waveform : unsigned(15 downto 0) := ( others => '0' );
  signal lfsr15 : std_logic_vector(14 downto 0);
  signal lfsr31 : std_logic_vector(30 downto 0);
  signal read_enable : std_logic := '0';
  signal even_clock : std_logic;
  signal checker_board : std_logic_vector(31 downto 0);
  signal lfsr_rst : std_logic;
  signal tm_r : std_logic_vector(3 downto 0);
  type data_array_t is array(3 downto 0) of std_logic_vector(31 downto 0);
  signal din : data_array_t;
  signal status : data_array_t;
  signal status_word : std_logic_vector(31 downto 0);
  type trigbits_t is array(3 downto 0) of std_logic_vector(15 downto 0);
  signal trig_mask_bits : trigbits_t;
  signal channel_number : unsigned(1 downto 0) := "11"; --00";
  signal read_early : std_logic;
  signal event_number : unsigned(31 downto 0) := (others => '0');
  signal last_req1 : std_logic := '0';

  
  type state_t is ( Idle,
                    SendEventHeader,
                    SendByteOrder,
                    SendEventNumber,
                    SendChannelHeader,

                    SendHeader, SendHeader0, SendHeader1, SendHeader2,
                    SendBcoLow, SendBcoHigh, SendData,
                                        
                    SendChannelEnd,
                    SendChannelCheck,
                    SendEventEnd,
                    SendEmpty,
                    
                     SendStrobe );
  signal state : state_t;

begin

  lfsr15_imp : lfsr_n
  generic map (
    width => 15
  )
  port map (
    rst => lfsr_rst,
    clk => clk,
    en => read_enable,
    dout => lfsr15,
    prev => open
  );

  lfsr31_imp : lfsr_n
  generic map (
    width => 31
  )
  port map (
    rst => lfsr_rst,
    clk => clk,
    en => read_enable,
    dout => lfsr31,
    prev => open
  );

--
--  When in the Idle state, the valid status of each buffer is cycled
--  through.  When a buffer is found that is valid, it gets dumped until
--  there is no more data.  Then the next valid buffer gets completely
--  emptied.  This is not ideal because one buffer could potentially hog
--  all the bandwidth if it is filled faster than it can be emptied.
--
--  The buffer status word is written as the 4th 32-bit word in each packet.
--  It has the following format, partly determined by the adc_buffer_pool
--  component:
--
--  Bits 3..0 - channel number/max channels
--  Bits 7..4 - read buffer number (max of 16 waveform buffers per channel)
--  Bits 15..8 - buffer busy flags
--  Bits 31..16 - hmm... not sure.

  process ( rst, clk )
    variable stat : std_logic_vector(31 downto 0);
  begin
    if ( clk'event and clk = '1' ) then
        last_req1 <= inreq1;
      if ( rst = '1' ) then
      else
        tm_r <= testmode;
        case state is
        when Idle =>
          --count <= 0;
          count <= unsigned(data_adc_length);
          count_rest <= word_rest-1;
          fragment <= ( others => '0' );
          strobe <= '0';
          read_enable <= '0';
          read_early <= '1';

          channel_number <= ( others => '0' );
          wren <= '0';
          --if ( valid(0) = '1' ) then
          if ( last_req1 = '0' and inreq1 = '1' ) then          
            state <= SendEventHeader; --SendHeader;
          else
            state <= Idle;
          end if;

        when SendEventHeader =>
          --write_buf <= '0';
          nchannel <= unsigned(channels);
          channel_number <= "11";
          strobe <='0';
          read_enable <= '0';
          event_number <= event_number + 1;
          wren <= '1';
          dout <= x"fdfdfdfd";
          state <= SendByteOrder;
  
         
       when SendByteOrder =>
          nchannel <= unsigned(channels);
          strobe <='0';
          read_enable <= '0';
          wren <= '1';
          dout <= x"f1f2f3f4";
          state <= SendEventNumber;

      when SendEventNumber =>
          nchannel <= unsigned(channels);
          strobe <='0';
          read_enable <= '0';
          wren <= '1';
          dout <= std_logic_vector(event_number); --inevn; --
          state <= SendChannelHeader;
          
                   
       when SendChannelHeader =>
          strobe <='0';
          read_enable <= '0';
          wren <= '1';
          dout <= x"fa" &"000000" & std_logic_vector(nchannel) & x"fafa";
          state <= SendHeader;
          
      when SendHeader =>
          strobe <= '0';
          read_enable <= '0';
          wren <= '1';
          dout <= std_logic_vector(waveform) & x"ffff";
          waveform <= waveform + 1;         
          state <= SendHeader0;
          
          
        when SendHeader0 =>
          strobe <= '0';
          read_enable <= read_early;
--          read_data <= din(to_integer(channel_number));
             wren <= '1';
             dout <= std_logic_vector(fragment) & x"00" & trig_mask_bits(to_integer(channel_number));
             fragment <= fragment + 1;
             state <= SendHeader1;
           
        when SendHeader1 =>
          strobe <= '0';
          read_enable <= read_early;
          read_early <= '0';
--          read_data <= din(to_integer(channel_number));
              wren <= '1';
              stat := status(to_integer(channel_number));  -- this line is immediately overwritten?
              stat(channel_number'left downto 0) := std_logic_vector(channel_number);
              dout <= stat;
              state <= SendHeader2;
                    
        when SendHeader2 =>
          strobe <= '0';
              wren <= '1';
              dout <= status_word;
              state <= SendBcoLow;
              read_enable <= '0';
              count <= unsigned(data_adc_length); -- word_count-1;
                    
        when SendBcoLow =>
          strobe <= '0';
            wren <= '1';
            dout <= bco(31 downto 0);
            state <= SendBcoHigh;
            read_enable <= '0';
            count <= unsigned(data_adc_length); --word_count-1;
          
        when SendBcoHigh =>
          strobe <= '0';
            wren <= '1';
            dout <= x"0000" & bco(47 downto 32);
            state <= SendData;
            read_enable <= '1';
            even_clock <= '1';
            count <= unsigned(data_adc_length); --word_count-1;
          
        when SendData =>
          if(nchannel = "00") then 
           rden(0) <='1';
          else
           rden(0) <='0';
          end if;
          
         if (nchannel = "01") then 
           rden(1) <='1';
         else
           rden(1) <='0';
         end if;

         if (nchannel = "10") then 
           rden(2) <='1';
         else
           rden(2) <='0';
         end if;

         if (nchannel = "11") then 
           rden(3) <='1';
         else
           rden(3) <='0';
         end if;

          case tm_r is  -- set by testmode[3..0] input of this entity module
          when "0000" =>
            --dout <= din(to_integer(channel_number));
            dout <= din(to_integer(nchannel));
          when "0001" =>
            dout <= checker_board;
          when "0010" =>
            dout <= x"ffff0000";
          when "0011" =>
            dout <= "0" & lfsr31;
          when "0101" =>
            dout <= "00000000000000000" & lfsr15;
          when "1001" =>
            --dout <= x"0000" & std_logic_vector(to_unsigned(count,16));
            dout <= std_logic_vector(count);
          when others =>
            dout <= x"f8f8f8f8";
          end case;
          even_clock <= not even_clock;
          --wren <= '1';
          strobe <= '0';
          --if ( count = 0 ) then
          --  state <= SendStrobe;
          --  read_enable <= '0';
          --elsif ( done(to_integer(channel_number)) = '1' ) then
          --  channel_number <= channel_number + 1;
          --  fragment <= ( others => '0' );
          --  read_early <= '1';
          --  read_enable <= '0';
          --  state <= SendStrobe;
          --else
          --  count <= count - 1;
          --  read_enable <= '1';
          --  state <= SendData;
          --end if;
          if( infifo_valid0 = '1' and nchannel = "00") then 
               wren <= '1';
          elsif( infifo_valid1 = '1' and nchannel = "01") then 
               wren <= '1';
          elsif( infifo_valid2 = '1' and nchannel = "10") then 
               wren <= '1';
          elsif( infifo_valid3 = '1' and nchannel = "11") then 
               wren <= '1';
          else 
               wren <= '0';
          end if;

          if ( count = 0 ) then
            --channel_number <= channel_number - 1; --+ 1;
            --nchannel <= nchannel - 1;
            fragment <= ( others => '0' );
            read_early <= '1';
            read_enable <= '0';
            state <= SendChannelEnd;
          else --if(inbusy1='0') then
            count <= count - 1;
            read_enable <= '1';
            state <= SendData;
          end if;


      when SendChannelEnd =>
         rden(0) <='0';
         rden(1) <='0';
         rden(2) <='0';
         rden(3) <='0';
         strobe <= '0';
         dout <= x"fbfbfbfb";
         wren <= '1';         
         state <= SendChannelCheck;
             
      when SendChannelCheck =>
         dout <= x"f8f8f8f8";
         wren <= '0';
         strobe <= '0';
         if(nchannel = "00") then
         --if(nchannel = 2) then
         --if(nchannel = 1) then
             state <= SendEventEnd;
         else 
             state <= SendChannelHeader;
             nchannel <= nchannel - 1;
             channel_number <= channel_number - 1;
         end if;
                       
      when SendEventEnd =>
         strobe <= '0';
         dout <= x"fefefefe";
         wren <= '1';
         state <= SendEmpty; --SendStrobe;
                      

      when SendEmpty =>
         dout <= x"f8f8f8f8";
         wren <= '0';
         strobe <= '0';
         state <= SendStrobe;
         --if( count_rest = 0) then        
         --  state <= SendStrobe;
         --  rden(0) <='0';
         --  rden(1) <='0';
         --  rden(2) <='0';
         --  rden(3) <='0';
         --else
         --  rden(0) <='1';
         --  rden(1) <='1';
         --  rden(2) <='1';
         --  rden(3) <='1';
         --  count_rest <= count_rest-1;
         --  state <= SendEmpty;                        
         --end if;



        --when SendStrobe =>
        --  dout <= x"f8f8f8f8";   -- Should never appear in data stream
        --  wren <= '0';
        --  strobe <= '1';
        --  read_enable <= '0';
        --  if ( valid(to_integer(channel_number)) = '1' ) then
        --    state <= SendHeader;
        --  else
        --    state <= Idle;
        --  end if;

       when SendStrobe =>
          dout <= x"f8f8f8f8";   -- Should never appear in data stream
          wren <= '0';
          strobe <= '1';
          read_enable <= '0';
          --outdone <= '1';
          state <= Idle;


        end case;
      end if;
    end if;
  end process;

  din(0) <= din0;
  din(1) <= din1;
  din(2) <= din2;
  din(3) <= din3;
  status(0) <= status0;
  status(1) <= status1;
  status(2) <= status2;
  status(3) <= status3;
  trig_mask_bits(0) <= trig0;
  trig_mask_bits(1) <= trig1;
  trig_mask_bits(2) <= trig2;
  trig_mask_bits(3) <= trig3;
  --rden(0) <= read_enable when channel_number = "00" else '0';
  --rden(1) <= read_enable when channel_number = "01" else '0';
  --rden(2) <= read_enable when channel_number = "10" else '0';
  --rden(3) <= read_enable when channel_number = "11" else '0';

 


  checker_board <= x"aaaa5555" when even_clock = '1' else x"5555aaaa";
  lfsr_rst <= '1' when state = SendHeader2 else '0';
  status_word <= x"0000" &
                 status(to_integer(channel_number))(15 downto 4) &
                 "11" & std_logic_vector(channel_number);

end Behavioral;
