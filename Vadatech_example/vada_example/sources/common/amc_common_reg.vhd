----------------------------------------------------------------------------------
-- Company:		VadaTech Incorporated
-- Engineer:		Maxwell
-- Copyright:		Copyright 2015 VadaTech Incorporated. All Rights Reserved.
--
-- Create Date:		01/05/2015
-- Design Name:
-- Module Name:		amc_common_reg - Behavioral
-- Project Name:	
-- Target Devices:	
-- Tool Versions:
-- Description:		This module implements AMCxxx reference design common registers
--
-- Dependencies:	None
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity amc_common_reg is
generic (
	MAJOR_VERSION			: integer range 0 to 255	:= 1;
	MINOR_VERSION			: integer range 0 to 255	:= 0;
	PATCH_VERSION			: integer range 0 to 255	:= 0;
	REV_VERSION			: integer range 0 to 255	:= 0;
	SIGNATURE			: std_logic_vector(15 downto 0) := x"0000";
	IMAGE_ID 			: std_logic_vector(15 downto 0) := x"0000";
	-- Do not change
	C_S_AXI_ADDR_WIDTH		: integer			:= 12
);
port (
	-- Ports of AXI4-Lite interface
	s_axi_aclk			: in std_logic;
	s_axi_aresetn			: in std_logic;
	s_axi_awaddr			: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
	s_axi_awvalid			: in std_logic;
	s_axi_awready			: out std_logic;
	s_axi_wdata			: in std_logic_vector(31 downto 0);
	s_axi_wstrb			: in std_logic_vector(3 downto 0);
	s_axi_wvalid			: in std_logic;
	s_axi_wready			: out std_logic;
	s_axi_bresp			: out std_logic_vector (1 downto 0);
	s_axi_bvalid			: out std_logic;
	s_axi_bready			: in std_logic;
	s_axi_araddr			: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
	s_axi_arvalid			: in std_logic;
	s_axi_arready			: out std_logic;
	s_axi_rdata			: out std_logic_vector (31 downto 0);
	s_axi_rresp			: out std_logic_vector (1 downto 0);
	s_axi_rvalid			: out std_logic;
	s_axi_rready			: in std_logic
);
end amc_common_reg;

architecture Behavioral of amc_common_reg is

	constant BIT0_ADDR			: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 2) := x"00" & "00";
	constant BIT2_ADDR			: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 2) := x"00" & "01";
	constant BIT4_ADDR			: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 2) := x"00" & "10";
	constant BIT6_ADDR			: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 2) := x"00" & "11";
	constant BIT8_ADDR			: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 2) := x"01" & "00";
	constant BIT10_ADDR			: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 2) := x"01" & "01";
	constant BIT12_ADDR			: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 2) := x"01" & "10";
	constant BIT14_ADDR			: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 2) := x"01" & "11";
	constant SCRATCH_ADDR			: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 2) := x"10" & "00";
	constant VER_ADDR			: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 2) := x"3F" & "10";
	constant SIG_ADDR			: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 2) := x"3F" & "11";
	
	-- AXI4LITE signals
	signal axi_awaddr			: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
	signal axi_araddr			: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);

	signal axi_awready			: std_logic;
	signal axi_wready			: std_logic;
	signal axi_bresp			: std_logic_vector(1 downto 0);
	signal axi_bvalid			: std_logic;
	signal axi_arready			: std_logic;
	signal axi_rdata			: std_logic_vector(31 downto 0);
	signal axi_rresp			: std_logic_vector(1 downto 0);
	signal axi_rvalid			: std_logic;

	-- AXI4LITE help signals
	signal slv_reg_wren			: std_logic;
	signal slv_reg_rden			: std_logic;
	signal reg_data_out			: std_logic_vector(31 downto 0);
	signal araddr				: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 2);
	signal awaddr				: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 2);	
	
	-- register fields	
	signal reg_scratch			: std_logic_vector(31 downto 0);
	signal version				: std_logic_vector(15 downto 0);
	signal patch				: std_logic_vector(15 downto 0);
	
begin

	-- I/O Connections assignments
	s_axi_awready				<= axi_awready;
	s_axi_wready				<= axi_wready;
	s_axi_bresp				<= axi_bresp;
	s_axi_bvalid				<= axi_bvalid;
	s_axi_arready				<= axi_arready;
	s_axi_rdata				<= axi_rdata;
	s_axi_rresp				<= axi_rresp;
	s_axi_rvalid				<= axi_rvalid;

	process (s_axi_aclk)
	begin
		if rising_edge(s_axi_aclk) then
			if s_axi_aresetn = '0' then
				axi_awready		<= '0';
			else
				if (axi_awready = '0' and s_axi_awvalid = '1') then
					axi_awready	<= '1';
				else
					axi_awready	<= '0';
				end if;
			end if;
		end if;
	end process;

	process (s_axi_aclk)
	begin
		if rising_edge(s_axi_aclk) then
			if s_axi_aresetn = '0' then
				axi_awaddr		<= (others => '0');
			else
				if (axi_awready = '0' and s_axi_awvalid = '1') then
					axi_awaddr	<= s_axi_awaddr;
				end if;
			end if;
		end if;
	end process;

	process (s_axi_aclk)
	begin
		if rising_edge(s_axi_aclk) then
			if s_axi_aresetn = '0' then
				axi_wready		<= '0';
			else
				if (axi_wready = '0' and s_axi_wvalid = '1') then
					axi_wready	<= '1';
				else
					axi_wready	<= '0';
				end if;
			end if;
		end if;
	end process;

	slv_reg_wren		<= axi_wready and s_axi_wvalid;
	awaddr			<= axi_awaddr(C_S_AXI_ADDR_WIDTH-1 downto 2);
	
	-- Write registers
	process(s_axi_aresetn, s_axi_aclk)
	begin
		if(rising_edge(s_axi_aclk)) then
			if( s_axi_aresetn='0' ) then
				reg_scratch				<= (others => '0');
			elsif(slv_reg_wren = '1') then
				if(awaddr = SCRATCH_ADDR and s_axi_wstrb(0) = '1') then
					reg_scratch(7 downto 0)		<= s_axi_wdata(7 downto 0);
				end if;

				if(awaddr = SCRATCH_ADDR and s_axi_wstrb(1) = '1') then
					reg_scratch(15 downto 8)	<= s_axi_wdata(15 downto 8);
				end if;

				if(awaddr = SCRATCH_ADDR and s_axi_wstrb(2) = '1') then
					reg_scratch(23 downto 16)	<= s_axi_wdata(23 downto 16);
				end if;

				if(awaddr = SCRATCH_ADDR and s_axi_wstrb(3) = '1') then
					reg_scratch(31 downto 24)	<= s_axi_wdata(31 downto 24);
				end if;				
			end if;
		end if;
	end process;

	process (s_axi_aclk)
	begin
		if rising_edge(s_axi_aclk) then
			if s_axi_aresetn = '0' then
				axi_bvalid		<= '0';
				axi_bresp		<= "00";
			else
				if (axi_wready = '1' and s_axi_wvalid = '1' and axi_bvalid = '0'  ) then
					axi_bvalid	<= '1';
					axi_bresp	<= "00";
				elsif (s_axi_bready = '1' and axi_bvalid = '1') then
					axi_bvalid	<= '0';
				end if;
			end if;
		end if;
	end process;

	process (s_axi_aclk)
	begin
		if rising_edge(s_axi_aclk) then
			if s_axi_aresetn = '0' then
				axi_arready <= '0';
				axi_araddr		<= (others => '1');
			else
				if (axi_arready = '0' and s_axi_arvalid = '1') then
					axi_arready	<= '1';
					axi_araddr	<= s_axi_araddr;
				else
					axi_arready	<= '0';
				end if;
			end if;
		end if;
	end process;

	 process (s_axi_aclk)
	begin
		if rising_edge(s_axi_aclk) then
			if s_axi_aresetn = '0' then
				axi_rvalid		<= '0';
				axi_rresp		<= "00";
			else
				if (slv_reg_rden = '1' and axi_rvalid = '0') then
					axi_rvalid	<= '1';
					axi_rresp	<= "00";
				elsif (axi_rvalid = '1' and s_axi_rready = '1') then
					-- Read data is accepted by the master
					axi_rvalid	<= '0';
				end if;
			end if;
		end if;
	end process;

	slv_reg_rden		<= axi_arready and s_axi_arvalid and (not axi_rvalid) ;

	version			<=	std_logic_vector(to_unsigned(MAJOR_VERSION, 8)) &
					std_logic_vector(to_unsigned(MINOR_VERSION, 8));

	patch			<=	std_logic_vector(to_unsigned(PATCH_VERSION, 8)) &
					std_logic_vector(to_unsigned(REV_VERSION, 8));					

	araddr			<= axi_araddr(C_S_AXI_ADDR_WIDTH-1 downto 2);
	with araddr select
		reg_data_out	<=	x"00020001"						when BIT0_ADDR,
					x"00080004"						when BIT2_ADDR,
					x"00200010"						when BIT4_ADDR,
					x"00800040"						when BIT6_ADDR,
					x"02000100"						when BIT8_ADDR,
					x"08000400"						when BIT10_ADDR,
					x"20001000"						when BIT12_ADDR,
					x"80004000"						when BIT14_ADDR,
					reg_scratch						when SCRATCH_ADDR,
					version & IMAGE_ID					when VER_ADDR,
					SIGNATURE & patch					when SIG_ADDR,
					(others => '0')						when others;

	process(s_axi_aclk ) is
	begin
		if (rising_edge (s_axi_aclk)) then
			if ( S_AXI_ARESETN = '0' ) then
				axi_rdata		<= (others => '0');
			else
				if (slv_reg_rden = '1') then
					axi_rdata	<= reg_data_out;	   -- register read data
				end if;
			end if;
		end if;
	end process;
	
end Behavioral;
