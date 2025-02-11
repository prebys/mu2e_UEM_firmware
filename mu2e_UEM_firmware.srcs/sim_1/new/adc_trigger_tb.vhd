library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;

library hep337dev;
use hep337dev.adc_trigger;

entity adc_trigger_tb is
end adc_trigger_tb;

architecture testbench of adc_trigger_tb is
    
    component adc_trigger
        port (
            clk : in std_logic;
            adc_fd : in std_logic_vector(3 downto 0);
            ext_trig : in std_logic;
            inhibit : in std_logic;  -- trigger_inhibit <= '1' when all_buffers_full /= "0000" else '0';
            mask : in std_logic_vector(7 downto 0);  -- 7f is standard
            pres : in std_logic_vector(15 downto 0);  -- 00000000
            delay : in std_logic_vector(31 downto 0);  -- 07fcad80
            trig : out std_logic;
            wrdata : out std_logic;
            wrdata_raw : out std_logic;
            outrst : out std_logic;
            ibusy : in std_logic;  -- maybe always 0?
            outevn_number : out std_logic_vector(31 downto 0);
            algorithm : out std_logic_vector(7 downto 0)
        );
    end component;
    
    -- Clock and reset signals
    signal clk : std_logic := '0';
    signal adc_fd : std_logic_vector(3 downto 0) := "0000";
    signal ext_trig : std_logic := '0';
    signal inhibit : std_logic := '0';
    signal mask : std_logic_vector(7 downto 0) := (others => '0');
    signal pres : std_logic_vector(15 downto 0) := (others => '0');
    signal delay : std_logic_vector(31 downto 0) := (others => '0');
    signal ibusy : std_logic := '0';
    
    -- outputs
    signal trig : std_logic;
    signal wrdata : std_logic;
    signal wrdata_raw : std_logic;
    signal outrst : std_logic;
    signal outevn_number : std_logic_vector(31 downto 0);
    signal algorithm : std_logic_vector(7 downto 0);
    
    constant clk_period : time := 10 ns;
    
    constant sim_time : time := 50 us;
    
begin
    
    -- Instantiate the DUT (Device Under Test)
    uut: adc_trigger
        port map (
            clk => clk,
            adc_fd => adc_fd,
            ext_trig => ext_trig,
            inhibit => inhibit,
            mask => mask,
            pres => pres,
            delay => delay,
            trig => trig,
            wrdata => wrdata,
            wrdata_raw => wrdata_raw,
            outrst => outrst,
            ibusy => ibusy,
            outevn_number => outevn_number,
            algorithm => algorithm
        );
    
    -- Clock generation
    clk_process : process
    begin
        while now < sim_time loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;
    
    -- Stimulus process
    stimulus: process
    begin
        -- Initial reset conditions
        adc_fd <= "0000";
        ext_trig <= '0';
        inhibit <= '0';
        mask <= "01111111";
        pres <= x"0000";
        delay <= x"00000418"; -- Small delay, 1048 (0x418) clock cycles
        ibusy <= '0';
        
        wait for 20 ns;
        
        -- Apply test stimulus
        adc_fd <= "0011"; -- Should trigger an event
        wait for 20 ns;
        
        adc_fd <= "0000"; -- Should reset the trigger
        wait for 50 ns;
        
        -- Test with external trigger
        ext_trig <= '1';
        wait for 20 ns;
        ext_trig <= '0';
        
        wait for 80 ns;
        
        ext_trig <= '1';
        wait for 200 ns;
        ext_trig <= '0';
        
        -- Introduce inhibit signal
        inhibit <= '1';
        wait for 30 ns;
        inhibit <= '0';
        
        -- Change ADC input and test masking
        mask <= "00000011"; -- Masking lower two bits
        adc_fd <= "0011";  -- Should not trigger
        wait for 20 ns;
        
        adc_fd <= "0100";  -- Should trigger
        wait for 20 ns;
        
        wait for 11 us;
        ext_trig <= '1';
        wait for 200 ns;
        ext_trig <= '0';
        
        
        -- End simulation
        while now < sim_time loop
            wait for 20 ns;
        end loop;
        
        report "Simulation completed" severity note;
        wait;
    end process;
    
end testbench;
