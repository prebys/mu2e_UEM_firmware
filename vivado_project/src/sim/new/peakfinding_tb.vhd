library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sumarea_module_tb is
end sumarea_module_tb;

architecture behavior of sumarea_module_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component sumarea_module
        Port (
            clk         : in  std_logic;
            rst         : in  std_logic;
            trig_in     : in  std_logic;
            adc_data    : in  std_logic_vector(11 downto 0);
            sum_valid   : out std_logic;
            sum_out     : out std_logic_vector(15 downto 0)
        );
    end component;

    -- Inputs
    signal clk         : std_logic := '0';
    signal rst         : std_logic := '1';
    signal trig_in     : std_logic := '0';
    signal adc_data    : std_logic_vector(11 downto 0) := (others => '0');

    -- Outputs
    signal sum_valid   : std_logic;
    signal sum_out     : std_logic_vector(15 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: sumarea_module
        port map (
            clk => clk,
            rst => rst,
            trig_in => trig_in,
            adc_data => adc_data,
            sum_valid => sum_valid,
            sum_out => sum_out
        );

    -- Clock process
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- hold reset state for a few cycles
        wait for 20 ns;
        rst <= '0';

        wait for 20 ns;
        trig_in <= '1';
        adc_data <= std_logic_vector(to_unsigned(100, 12));
        wait for clk_period;

        adc_data <= std_logic_vector(to_unsigned(200, 12));
        wait for clk_period;

        adc_data <= std_logic_vector(to_unsigned(300, 12));
        wait for clk_period;

        trig_in <= '0';
        adc_data <= std_logic_vector(to_unsigned(0, 12));
        wait for 5*clk_period;

        wait;
    end process;

end behavior;
