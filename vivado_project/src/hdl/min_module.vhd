----------------------------------------------------------------------------------
-- Company:  UC Davis
-- Engineer: Nguyen Minh Truong
-- 
-- Create Date: 05/22/2019 08:43:39 PM
-- Design Name: 
-- Module Name: min_module - Behavioral
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


entity min_module is
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
end min_module;

architecture Behavioral of min_module is



  signal even_clock : std_logic;
  signal data0 : std_logic_vector(15 downto 0);
  signal data1 : std_logic_vector(15 downto 0);
  signal data2 : std_logic_vector(15 downto 0);
  signal data3 : std_logic_vector(15 downto 0);

  type data_array_t is array(3 downto 0) of std_logic_vector(15 downto 0);
  signal data : data_array_t;

  signal datainteger0 : signed(23 downto 0);
  signal datainteger1 : signed(23 downto 0);
  signal datainteger2 : signed(23 downto 0);
  signal datainteger3 : signed(23 downto 0);
  
  signal datasum0 : std_logic_vector(31 downto 0);
  signal datasum1 : std_logic_vector(31 downto 0);
  signal datasum2 : std_logic_vector(31 downto 0);
  signal datasum3 : std_logic_vector(31 downto 0);  
  signal min : std_logic_vector(15 downto 0) := x"F380"; --thr = -200

begin
        data0 <= datain1(63 downto 48);
        data1 <= datain1(47 downto 32);
        data2 <= datain1(31 downto 16);
        data3 <= datain1(15 downto 0);

        --dout0 <= datain1(63 downto 48);
        --dout1 <= datain1(47 downto 32);
        --dout2 <= datain1(31 downto 16);
        --dout3 <= datain1(15 downto 0);
        
        data(0) <= datain1(63 downto 48);
        data(1) <= datain1(47 downto 32);
        data(2) <= datain1(31 downto 16);
        data(3) <= datain1(15 downto 0);

        
        datasum0 <= std_logic_vector(resize(signed(datain1(63 downto 48)), datasum0'length)); 
        datasum1 <= std_logic_vector(resize(signed(datain1(47 downto 32)), datasum1'length)); 
        datasum2 <= std_logic_vector(resize(signed(datain1(31 downto 16)), datasum2'length)); 
        datasum3 <= std_logic_vector(resize(signed(datain1(15 downto 0)), datasum3'length));  
                               
  process ( rst, clk_a )

  begin
    if ( clk_a'event and clk_a = '1' ) then
        
      if ( rst = '1' ) then
        doutsum <= x"afafafaf";
        doutmin <= x"F380";
      else
        doutsum <= std_logic_vector(signed(datasum0) + signed(datasum1) + signed(datasum2) + signed(datasum3));
        
        -- min data is data0
        if( signed(data0) < signed(data1) and signed(data0) < signed(data2) and signed(data0) < signed(data3) ) then
           doutmin <= std_logic_vector(signed(data0));
           mintime <= "00";
        elsif( signed(data0) = signed(data1) and signed(data0) < signed(data2) and signed(data0) < signed(data3) ) then
           doutmin <= std_logic_vector(signed(data0));
           mintime <= "00";
        elsif( signed(data0) = signed(data1) and signed(data0) = signed(data2) and signed(data0) < signed(data3) ) then
           doutmin <= std_logic_vector(signed(data0));
           mintime <= "00";           
        elsif( signed(data0) = signed(data1) and signed(data0) = signed(data2) and signed(data0) = signed(data3) ) then
           doutmin <= std_logic_vector(signed(data0));
           mintime <= "00";
                      
        -- min data is data1    
        elsif( signed(data1) < signed(data0) and signed(data1) < signed(data2) and signed(data1) < signed(data3) ) then
           doutmin <= std_logic_vector(signed(data1));
           mintime <= "01";                       
        elsif( signed(data1) < signed(data0) and signed(data1) = signed(data2) and signed(data1) < signed(data3) ) then
           doutmin <= std_logic_vector(signed(data1));
           mintime <= "01";                     
        elsif( signed(data1) < signed(data0) and signed(data1) = signed(data2) and signed(data1) = signed(data3) ) then
           doutmin <= std_logic_vector(signed(data1));
           mintime <= "01";  
                              
        -- min data is data2
        elsif( signed(data2) < signed(data0) and signed(data2) < signed(data1) and signed(data2) < signed(data3) ) then
           doutmin <= std_logic_vector(signed(data2));
           mintime <= "10";                     
        elsif( signed(data2) < signed(data0) and signed(data2) < signed(data1) and signed(data2) = signed(data3) ) then
           doutmin <= std_logic_vector(signed(data2));
           mintime <= "10";

        -- min data is data3 
        else --if( signed(data3) < signed(data0) and signed(data3) < signed(data1) and signed(data3) < signed(data2) ) then
           doutmin <= std_logic_vector(signed(data3));
           mintime <= "11";
        end if;        
        

      end if;
      
    end if;
    
  end process;



  -- max data
  process ( rst, clk_a )

  begin
    if ( clk_a'event and clk_a = '1' ) then
        
      if ( rst = '1' ) then
        doutmax <= x"F380";        
      else
        
        -- max data is data0
        if( signed(data0) > signed(data1) and signed(data0) > signed(data2) and signed(data0) > signed(data3) ) then
           doutmax <= std_logic_vector(signed(data0));
           
        elsif( signed(data0) = signed(data1) and signed(data0) > signed(data2) and signed(data0) > signed(data3) ) then
           doutmax <= std_logic_vector(signed(data0));
           
        elsif( signed(data0) = signed(data1) and signed(data0) = signed(data2) and signed(data0) > signed(data3) ) then
           doutmax <= std_logic_vector(signed(data0));
                      
        elsif( signed(data0) = signed(data1) and signed(data0) = signed(data2) and signed(data0) = signed(data3) ) then
           doutmax <= std_logic_vector(signed(data0));
           
                      
        -- max data is data1    
        elsif( signed(data1) > signed(data0) and signed(data1) > signed(data2) and signed(data1) > signed(data3) ) then
           doutmax <= std_logic_vector(signed(data1));
                                  
        elsif( signed(data1) > signed(data0) and signed(data1) = signed(data2) and signed(data1) > signed(data3) ) then
           doutmax <= std_logic_vector(signed(data1));
                               
        elsif( signed(data1) > signed(data0) and signed(data1) = signed(data2) and signed(data1) = signed(data3) ) then
           doutmax <= std_logic_vector(signed(data1));
             
                              
        -- max data is data2
        elsif( signed(data2) > signed(data0) and signed(data2) > signed(data1) and signed(data2) > signed(data3) ) then
           doutmax <= std_logic_vector(signed(data2));
                                
        elsif( signed(data2) > signed(data0) and signed(data2) > signed(data1) and signed(data2) = signed(data3) ) then
           doutmax <= std_logic_vector(signed(data2));
           

        -- max data is data3 
        else --if( signed(data3) < signed(data0) and signed(data3) < signed(data1) and signed(data3) < signed(data2) ) then
           doutmax <= std_logic_vector(signed(data3));
           
        end if;        
        

      end if;
      
    end if;
    
  end process;

     
end Behavioral;