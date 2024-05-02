--------------------------------------------------------------------------------
-- Create Date:     3/26/2008
-- File Name:       vt_reset_sync.vhd
-- Designer:        Mike McDermott (mikem@vadatech.com)
-- Module Name:     vt_reset_sync - behavioral
-- Target Device:   Any
-- Description:     Asynchronous Reset synchronizer w/ minimum 2 clock power-on reset assertion
--                  (asserts asynchronously, de-asserts synchronously without meta-stability)
-- Dependencies:    none
-- Copyright:       2008 VadaTech Incorporated, All Rights Reserved
--------------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity vt_reset_sync is
port (
	clk_i :  in std_logic;  -- Clock of the domain into which the reset will be driven
	en_i  :  in std_logic;  -- Tie enable to '1' or to PLL lock, etc
	rst_i :  in std_logic;  -- Asynchronous active high reset input
	rst_o : out std_logic   -- Synchronous active high reset output w/ minimum 2 clock power-on reset assertion
);
end vt_reset_sync;

architecture behavioural of vt_reset_sync is
	signal dff		: std_logic_vector(1 downto 0) := "11";
begin
	-- First flip-flop is meta-stable, second flip-flop won't be for diminishing values of "won't"
	process(clk_i, rst_i, en_i)
	begin
		if( rst_i='1' ) then
			dff   <= "11";
		elsif( rising_edge(clk_i) and en_i='1' ) then
			dff    <= dff(0) & '0';
		end if;
    	end process;

	rst_o <= dff(1);
end behavioural;

