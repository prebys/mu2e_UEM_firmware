----------------------------------------------------------------------------------
-- Company:		VadaTech Incorporated
-- Engineer:		Maxwell
-- Copyright:		Copyright 2014 VadaTech Incorporated.  All rights reserved.
--
-- Create Date:		13:17:25 05/27/2014
-- Design Name:		
-- Module Name:		fsl_elbc_axi4lite_bridge - Behavioral
-- Project Name:	AMC516
-- Target Devices:	
-- Tool versions:	
-- Description:		This module implements a simple Freescale mpc85xx eLBC bus to AXI4-lite 
--			bridge with 32-bit addresses. This is not a generic implementation.
--
--			Timing limitations: 
--			This module is created to interface with the existing AMC516 u-boot configurations. 
--			Port size = 16-bit
--			Data error checking disabled
--			R/W; Maximum bank size = 64M bytes
--			GPCM machine only: The GPCM mode doesn't have wait states input from memory
--				and thus is not compatible with AXI4 protocol intrinsically, but 
--				this module simply assumes that all AXI4-lite slaves can send back
--				read data / write data in time with the following local bus OR settings.
--			EAD = 1 (extra address latch delay)
--			EHTR = 1 and TRLX = 1 (8 idle clock cycles inserted to hold time on read accesses
--			SCY = 0111 (7 bus clock cycle wait states)
--				(LBC maximum clock frequency = 75MHz)
--			XACS = 0 (Address to LCSn setup is determinted by ACS)
--			ACS = 00 (LCSn is output at the same time as the address lines)
--			CSNT = 1 (LCSn and LWEn are negated one quarter of a bus clock cycle earlier)
-- 			The resulting timing (clock cycles):
--				read			write
--				tARCS = 0		tAWCS = 0
--				tCSRP = 16		tCSWP = 17
--				tAOE = 1		tAWE = 1
--				tOEN = 8		tWEN = 1 + (1/4)
--				tRC = 24		tWC = 17
--
--			Data width translation:
--				AXI4-lite always uses 32-bit data. 
--
--			Address width:
-- Revision History:
-- 04/18/2016		Added generic WRITE32_ONCE and READ32_ONCE
-- 04/15/2016		Renamed output port axi_addr_odd to axi_ruser_strb_n to indicate the byte lanes when read
-- 04/13/2015		Added output port axi_addr_odd to indicate the higher 2-byte read
-- 05/27/2014		Initial
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fsl_elbc_axi4lite_bridge is
generic (
	WRITE32_ONCE			: boolean			:= false;	-- true: only write 32-bit axi value once when LB HW(31:16) is written. The axi_wdata[15:0] is latched from previous LB LW(15:0) write.
											--	used for modules that do not support axi_wstrb such as Xilinx AXI IIC
											-- false: use axi_wstrb
	READ32_ONCE			: boolean			:= false;	-- true: read and latch the 32-bit axi data on LB LW(15:0) read. return latched data when LB HW(31:16) read 
											--	used for modules with RSC (read self clear) register bits
											-- false: read the same 32-bit address twice, return HW(31:16) or LW(15:0) based on the LB address
											
	-- Map to axi4 addresses
	M_AXI_ADDR_WIDTH		: integer			:= 32;
	BARAXI				: std_logic_vector(31 downto 0)	:= x"00000000";
	BARSIZE				: integer			:= 24
);
port ( 
	-- Freescale enhanced local bus signals in GPCM mode. The input signals 
	-- are clocked by eLBC clock with maximum frequency of 75MHz which is not 
	-- used by this module. This module uses axi_aclk only. It has to be preferably 
	-- great than or equal to two times the maximum frequency of the eLBC clock to 
	-- finish the eLBC translation in time in case of multiple AXI4 interconnect modules
	-- present.
	
	-- eLBC bus uses multiplexed address and data, but on our board the address lines are latched.
	-- From FPGA point of view, the address lines and data lines are separated.
	cs_n				: in  std_logic;
	addr				: in  std_logic_vector(31 downto 0);	-- Freescale backward bit order (16-bit words)
	data				: inout std_logic_vector(15 downto 0);	-- Freescale backward bit order
	oe_n				: in  std_logic;
	we_n				: in  std_logic_vector(1 downto 0);
	data_out			: out std_logic_vector(15 downto 0);

	-- axis4-lite master signals
	axi_aclk			: in  std_logic;
	axi_aresetn			: in  std_logic;
	m_axi_awaddr			: out std_logic_vector ( 31 downto 0 );
	m_axi_awprot			: out std_logic_vector ( 2 downto 0 );
	m_axi_awvalid			: out std_logic;
	m_axi_awready			: in  std_logic;
	m_axi_wdata			: out std_logic_vector ( 31 downto 0 );
	m_axi_wstrb			: out std_logic_vector ( 3 downto 0 );
	m_axi_wvalid			: out std_logic;
	m_axi_wready			: in  std_logic;
	m_axi_bresp			: in  std_logic_vector ( 1 downto 0 );
	m_axi_bvalid			: in  std_logic;
	m_axi_bready			: out std_logic;
	m_axi_araddr			: out std_logic_vector ( 31 downto 0 );
	m_axi_arprot			: out std_logic_vector ( 2 downto 0 );
	m_axi_arvalid			: out std_logic;
	m_axi_arready			: in  std_logic;
	m_axi_rdata			: in  std_logic_vector ( 31 downto 0 );
	m_axi_rresp			: in  std_logic_vector ( 1 downto 0 );
	m_axi_rvalid			: in  std_logic;
	m_axi_rready			: out std_logic;
	
	axi_ruser_strb_n		: out std_logic_vector(3 downto 0);
	
	-- debug
	state_out			: out std_logic_vector(2 downto 0);
	status_out			: out std_logic_vector(9 downto 0)
);
end fsl_elbc_axi4lite_bridge;

architecture Behavioral of fsl_elbc_axi4lite_bridge is

	function bit_reverse
	(
		din			: std_logic_vector
	)
	return	std_logic_vector is
		variable dout		: std_logic_vector(din'range);
		alias din_reverse	: std_logic_vector(din'reverse_range) is din;
	begin
		for i in din'range loop
			dout(i)		:= din_reverse(i);
		end loop;
		return dout;
	end bit_reverse;
	
	signal addr_i			: std_logic_vector(31 downto 0); -- normal bit order
	signal data_i			: std_logic_vector(15 downto 0); -- normal bit order
	signal cs_n_d1			: std_logic;
	signal oe_n_d1			: std_logic;
	signal oe_n_d2			: std_logic;
	signal we_n_d1			: std_logic_vector(1 downto 0);
	signal we_n_d2			: std_logic_vector(1 downto 0);
	signal we_n_d3			: std_logic_vector(1 downto 0);
	signal addr_odd			: std_logic;
	signal dout			: std_logic_vector(15 downto 0);
	
	signal wdata_lw			: std_logic_vector(15 downto 0);	
	signal rdata_hw			: std_logic_vector(15 downto 0);
		
	type lab_sm_type is
	(
		LAB_IDLE,
		LAB_WRITE_WAIT_ADDR,
		LAB_WRITE_WAIT_DATA,
		LAB_WRITE_WAIT_RESP,
		LAB_READ_WAIT_ADDR,
		LAB_READ_WAIT_DATA
	);
	
	signal lab_sm			: lab_sm_type;
begin

	
	status_out	<= oe_n_d1 & oe_n_d2 & we_n_d1 & we_n_d2 & we_n_d3 & cs_n_d1 & addr_odd;
	process(axi_aclk)
	begin
		if(rising_edge(axi_aclk)) then
			case lab_sm is
			when LAB_IDLE => 
				state_out	<= "000";
			when LAB_WRITE_WAIT_ADDR =>
				state_out	<= "001";			
			when LAB_WRITE_WAIT_DATA => 
				state_out	<= "010";			
			when LAB_WRITE_WAIT_RESP =>
				state_out	<= "011";			
			when LAB_READ_WAIT_ADDR =>
				state_out	<= "100";			
			when LAB_READ_WAIT_DATA =>
				state_out	<= "101";
			end case;
		end if;
	end process;
	
	-- Unused AXI4 signals
	m_axi_awprot		<= "000";
	m_axi_arprot		<= "000";
	m_axi_bready		<= '1';
	
	data_out		<= dout;
	-- bit reverse
	data			<= bit_reverse(dout) when cs_n_d1 = '0' and oe_n = '0' else
					(others => 'Z');
	addr_i			<= bit_reverse(addr);
	data_i			<= bit_reverse(data);
	
	
	-- Follow Xilinx's recommendation to use synchronous reset
	process(axi_aclk, axi_aresetn)
	begin
		if(rising_edge(axi_aclk)) then
			if(axi_aresetn = '0') then
				lab_sm					<= LAB_IDLE;
				oe_n_d1					<= '0';
				oe_n_d2					<= '0';
				we_n_d1					<= "00";
				we_n_d2					<= "00";
				we_n_d3					<= "00";
				cs_n_d1					<= '0';
				m_axi_awaddr				<= (others => '0');
				m_axi_awvalid                           <= '0';
				m_axi_wdata			        <= (others => '0');
				m_axi_wstrb			        <= (others => '0');
				m_axi_wvalid				<= '0';
				
				m_axi_araddr				<= (others => '0');
				m_axi_arvalid				<= '0';
				m_axi_rready				<= '0';
				addr_odd				<= '0';
				axi_ruser_strb_n			<= x"0";
				dout					<= (others => '0');
				
			else
				oe_n_d1					<= oe_n;
				oe_n_d2					<= oe_n_d1;
				we_n_d1					<= we_n;
				we_n_d2					<= we_n_d1;
				we_n_d3					<= we_n_d2;
				cs_n_d1					<= cs_n;
				case lab_sm is
				when LAB_IDLE =>
					if(cs_n_d1 = '0' and ((we_n_d2(0) = '0' and we_n_d3(0) = '1') or (we_n_d2(1) = '0' and we_n_d3(1) = '1'))) then
						-- delay one more axi_aclk to check we_n in case the two we_n lines are not latched simultaneously
						if not WRITE32_ONCE then
							lab_sm			<= LAB_WRITE_WAIT_ADDR;
							m_axi_awaddr		<= BARAXI(M_AXI_ADDR_WIDTH-1 downto BARSIZE) & addr_i(BARSIZE-1 downto 2) & "00";
							m_axi_awvalid		<= '1';
							m_axi_wvalid		<= '1';
							m_axi_wdata		<= data_i & data_i;
							if(addr_i(1) = '0') then
								m_axi_wstrb	<= "00" & not(we_n_d1(0)) & not(we_n_d1(1)); 
							else
								m_axi_wstrb	<= not(we_n_d1(0)) & not(we_n_d1(1)) & "00"; 
							end if;
						else		
							m_axi_wstrb		<= x"F";
							
							if(addr_i(1) = '0') then
								wdata_lw	<= data_i;								
							else
								lab_sm		<= LAB_WRITE_WAIT_ADDR;
								m_axi_awaddr	<= BARAXI(M_AXI_ADDR_WIDTH-1 downto BARSIZE) & addr_i(BARSIZE-1 downto 2) & "00";
								m_axi_awvalid	<= '1';
								m_axi_wvalid	<= '1';
								m_axi_wdata	<= data_i & wdata_lw;
							end if;							
						end if;
						
					elsif(cs_n_d1 = '0' and oe_n_d1 = '0' and oe_n_d2 = '1') then
						if READ32_ONCE then
							axi_ruser_strb_n	<= "0000";
							if(addr_i(1) = '1') then
								dout		<= rdata_hw;
							else
								lab_sm		<= LAB_READ_WAIT_ADDR;
								m_axi_araddr	<= BARAXI(M_AXI_ADDR_WIDTH-1 downto BARSIZE) & addr_i(BARSIZE-1 downto 2) & "00";
								m_axi_arvalid	<= '1';
								m_axi_rready	<= '1';								
								addr_odd	<= addr_i(1);
							end if;							
						else
							lab_sm			<= LAB_READ_WAIT_ADDR;
							m_axi_araddr		<= BARAXI(M_AXI_ADDR_WIDTH-1 downto BARSIZE) & addr_i(BARSIZE-1 downto 2) & "00";
							m_axi_arvalid		<= '1';
							m_axi_rready		<= '1';
							if(addr_i(1) = '0') then
								axi_ruser_strb_n	<= "1100";
							else
								axi_ruser_strb_n	<= "0011";
							end if;
							addr_odd		<= addr_i(1);
						end if;
					end if;

				when LAB_WRITE_WAIT_ADDR =>
					if(m_axi_awready = '1' and m_axi_wready = '1') then
						lab_sm			<= LAB_WRITE_WAIT_RESP;
						m_axi_awvalid		<= '0';
						m_axi_wvalid		<= '0';
					elsif(m_axi_awready = '1') then
						lab_sm			<= LAB_WRITE_WAIT_DATA;
						m_axi_awvalid		<= '0';					
					end if;					
				
				when LAB_WRITE_WAIT_DATA =>
					if(m_axi_wready = '1') then
						lab_sm			<= LAB_WRITE_WAIT_RESP;
						m_axi_wvalid		<= '0';
					end if;
				
				when LAB_WRITE_WAIT_RESP =>
					if(m_axi_bvalid = '1') then
						lab_sm			<= LAB_IDLE;
					end if;
				
				when LAB_READ_WAIT_ADDR =>
					if(m_axi_arready = '1' and m_axi_rvalid = '1') then
						lab_sm			<= LAB_IDLE;
						m_axi_arvalid		<= '0';
						m_axi_rready		<= '0';
						axi_ruser_strb_n	<= "0000";
						if(addr_odd = '1') then
							dout		<= m_axi_rdata(31 downto 16);
						else
							dout		<= m_axi_rdata(15 downto 0);
						end if;
						rdata_hw		<= m_axi_rdata(31 downto 16);
					elsif(m_axi_arready = '1') then
						lab_sm			<= LAB_READ_WAIT_DATA;
						m_axi_arvalid		<= '0';					
					end if;					
	
				when LAB_READ_WAIT_DATA =>
					if(m_axi_rvalid = '1') then
						lab_sm			<= LAB_IDLE;
						m_axi_rready		<= '0';
						axi_ruser_strb_n	<= "0000";
						if(addr_odd = '1') then
							dout		<= m_axi_rdata(31 downto 16);
						else
							dout		<= m_axi_rdata(15 downto 0);
						end if;
						rdata_hw		<= m_axi_rdata(31 downto 16);
					end if;
				
				when others => 
					lab_sm				<= LAB_IDLE;
					
				end case;
			end if;
		end if;
	end process;

end Behavioral;
