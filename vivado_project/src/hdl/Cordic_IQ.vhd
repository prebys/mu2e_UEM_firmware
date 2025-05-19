-- Phase to IQ CORDIC
-- Fermilab Proton Source LLRF
-- Ed Cullerton
-- 4/1/2020

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- use work.echolib.all;

-- 18 bit depth
-- Vectoring mode algorithm
-- The algorithm rotates an IQ vector to the input angle with range of 0 to 360 degrees
-- Output has a gain of 1.646760258105090 (N=18) CORDIC gain
-- Reference: 
-- R. Andraka, "A Survey of CORDIC Algorithms for FPGA Based Computers"

entity Cordic_IQ is
  port (
    clk : in std_logic;       -- Clock input
    resetn : in std_logic;      -- Reset
    enable : in std_logic;       -- Enable output
    x_in : in signed(21 downto 0);
    y_in : in signed(21 downto 0);
    theta_in : in unsigned(30 downto 0);  -- Angle input: 0-360 degrees (31 bit unsigned)
    cos_theta_out : out signed(21 downto 0);  -- Cosine output (2.20 bit signed)
    sin_theta_out : out signed(21 downto 0) -- Sine output (2.20 bit signed)
  );
end Cordic_IQ;

architecture logic of Cordic_IQ is
  type array_type is ARRAY (18 downto 0) of signed(21 downto 0);  
  signal I_tot : array_type;     -- Pipelined I rotation vector
  signal Q_tot : array_type;     -- Pipelined Q rotation vector

  type ang_array is ARRAY (18 downto 0) of signed(31 downto 0); 
  signal angle_tot : ang_array;  -- Pipelined angle accumulator
  signal angle : ang_array;      -- Look up table for atan(2^-M)
  signal angle_ref : ang_array;  -- Pipelined input angle   

  -- Pipelined quandrant registers
  type quad_array is ARRAY(18 downto 0) of unsigned(1 downto 0);
  signal quadrant : quad_array; 

begin
  process(clk,resetn)
  begin
    -- angle look-up table
    -- (signed 32 bit) (01111111111111111111111111111111 = 360)
    -- rounded ints are wrong below, they assume 30 bit unsigned magnitude, should be 31 bit
    angle(0) <= "00010000000000000000000000000000"; -- atan(2^-0) rounded int = 268435456, 45 deg
    angle(1) <= "00001001011100100000001010001110"; -- atan(2^-1) rounded int = 79233351, 26.5650511771 
    angle(2) <= "00000100111111011001110000101110"; -- atan(2^-2) rounded int = 41864727, 14.036243468
    angle(3) <= "00000010100010001000100011101010"; -- atan(2^-3) rounded int = 21251189, 7.1250163489  
    angle(4) <= "00000001010001011000011010100010"; -- atan(2^-4) rounded int = 10666833, 3.576334375 
    angle(5) <= "00000000101000101110101111110000"; -- atan(2^-5) rounded int = 5338616, 1.78991060825
    angle(6) <= "00000000010100010111101100010000"; -- atan(2^-6) rounded int = 2669960, 0.89517371021
    angle(7) <= "00000000001010001011111000101010"; -- atan(2^-7) rounded int = 1335061, 0.44761417086
    angle(8) <= "00000000000101000101111100101010"; -- atan(2^-8) rounded int = 667541, 0.22381050037
    angle(9) <= "00000000000010100010111110011000"; -- atan(2^-9) rounded int = 333772, 0.11190567707
    angle(10) <= "00000000000001010001011111001100"; -- atan(2^-10) rounded int = 166886, 0.05595289189
    angle(11) <= "00000000000000101000101111100110"; -- atan(2^-11) rounded int = 83443, 0.02797645262
    angle(12) <= "00000000000000010100010111110100"; -- atan(2^-12) rounded int = 41722, 0.01398822714
    angle(13) <= "00000000000000001010001011111010"; -- atan(2^-13) rounded int = 20861, 0.00699411368
    angle(14) <= "00000000000000000101000101111100"; -- atan(2^-14) rounded int = 10430, 0.0034970568
    angle(15) <= "00000000000000000010100010111110"; -- atan(2^-15) rounded int = 5215, 0.00174852842
    angle(16) <= "00000000000000000001010001100000"; -- atan(2^-16) rounded int = 2608, 0.00087426421
    angle(17) <= "00000000000000000000101000110000"; -- atan(2^-17) rounded int = 1304, 0.00043713211
    angle(18) <= "00000000000000000000010100011000"; -- atan(2^-18)
            
    if (resetn = '0') then

      for j in 0 to 18 loop
        angle_tot(j) <= (others =>'0');
        I_tot(j) <= (others =>'0');
        Q_tot(j) <= (others =>'0');
        angle_ref(j) <= (others =>'0');
        quadrant(j) <= (others => '0');
      end loop;
      
      cos_theta_out <= (others => '0');
      sin_theta_out <= (others => '0');
      
    else
      if(clk'event and clk = '1') then
  
        -- N = 18 clock pipeline
        for i in 0 to (18 + 1) loop
          if (i = 0) then
            -- Move the input angle to the first quadrant for a simplified algorithm
            -- The algorithim rotates the first iteration in the positive
            -- direction by 45 degrees
--            I_tot(i) <= x_in;
--            Q_tot(i) <= y_in;
            I_tot(i) <= x_in - y_in;
            Q_tot(i) <= y_in + x_in;
            angle_tot(i) <= angle(i);    
            -- Register the quadrant of the input angle and move the reference angle into the first quadrant
            if (theta_in >= "1100000000000000000000000000000" ) then
              angle_ref(i) <= signed('0' & theta_in) - "01100000000000000000000000000000";
              quadrant(i) <= "11"; -- angle is in quadrant 4
            elsif (theta_in >= "1000000000000000000000000000000" ) then
              angle_ref(i) <= signed('0' & theta_in) - "01000000000000000000000000000000";
              quadrant(i) <= "10"; -- angle is in quadrant 3
            elsif (theta_in >= "0100000000000000000000000000000" ) then
              angle_ref(i) <= signed('0' & theta_in) - "00100000000000000000000000000000";
              quadrant(i) <= "01"; -- angle is in quadrant 2
            else
              angle_ref(i) <= signed('0' & theta_in);
              quadrant(i) <= "00"; -- angle is in quadrant 1 
            end if;

        elsif (i <= 18) then
            -- Pipeline the input angle and quadrant   
            angle_ref(i) <= angle_ref(i-1);
            quadrant(i) <= quadrant(i-1);
            -- Check for overshoot
            if (angle_tot(i-1) <= angle_ref(i-1)) then
              -- Use the look up table to rotate the angle in positive direction
              angle_tot(i) <= angle_tot(i-1) + angle(i);
              -- Shift I and Q by + atan(2^(-M)) for next iteration
              I_tot(i) <= I_tot(i-1) - shift_right(Q_tot(i-1), (i));
              Q_tot(i) <= Q_tot(i-1) + shift_right(I_tot(i-1), (i));
            else
              -- Use the look up table to rotate the angle in negative direction
              angle_tot(i) <= angle_tot(i-1) - angle(i);
              -- Shift I and Q by -atan(2^(-M)) for next iteration
              I_tot(i) <= I_tot(i-1) + shift_right(Q_tot(i-1), (i));
              Q_tot(i) <= Q_tot(i-1) - shift_right(I_tot(i-1), (i));
            end if;
        
        elsif ( (i=(18+1)) and (enable = '1') ) then
        
            -- Put the total I and Q on the output depending on the input angle quadrant
            if (quadrant(18) = "00") then
              cos_theta_out <= I_tot(18);
              sin_theta_out <= Q_tot(18);
            elsif (quadrant(18) = "01") then
              cos_theta_out <= -Q_tot(18);
              sin_theta_out <= I_tot(18);
            elsif (quadrant(18) = "10") then
              cos_theta_out <= -I_tot(18);
              sin_theta_out <= -Q_tot(18);
            elsif (quadrant(18) = "11") then
              cos_theta_out <= Q_tot(18);
              sin_theta_out <= -I_tot(18);
            end if;
        end if;
            
            if (enable = '0') then
                cos_theta_out <= "0000000000000000000000";
                sin_theta_out <= "0000000000000000000000";
            end if;
            
        end loop;
      end if;  
    end if;
  end process;
end logic;

