----------------------------------------------------------------------------------
-- Company:		VadaTech Incorporated
-- Engineer:		Maxwell
-- Copyright:		Copyright 2015 VadaTech Incorporated.  All rights reserved.
--
-- Create Date:		03/31/2015
-- Design Name:
-- Module Name:		axi_lite_rd_fifo - Behavioral
-- Project Name:	
-- Target Devices:	
-- Tool versions:	
-- Description:		This module implements axi-lite interface to read fifo output
--
-- Dependencies:
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity axi_lite_rd_fifo is
generic (
	FIFO_DWIDTH			: integer	:= 32;	-- support 32 only now
	C_S_AXI_ADDR_WIDTH		: integer	:= 12;
	LITTLE_ENDIAN16			: boolean	:= true
);
port (
	-- Ports of AXI-Lite interface
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
	s_axi_rready			: in std_logic;

	fifo_rd_en			: out std_logic;
	fifo_dout			: in std_logic_vector(31 downto 0)
);
end axi_lite_rd_fifo;

architecture Behavioral of axi_lite_rd_fifo is
	-- AXI4LITE signals
	signal axi_awaddr		: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
	signal axi_araddr		: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);

	signal axi_awready		: std_logic;
	signal axi_wready		: std_logic;
	signal axi_bresp		: std_logic_vector(1 downto 0);
	signal axi_bvalid		: std_logic;
	signal axi_arready		: std_logic;
	signal axi_rdata		: std_logic_vector(31 downto 0);
	signal dout_re_order		: std_logic_vector(31 downto 0);
	signal axi_rvalid		: std_logic;
	signal slv_reg_rden		: std_logic;

begin

	s_axi_awready			<= axi_awready;
	s_axi_wready			<= axi_wready;
	s_axi_bresp			<= axi_bresp;
	s_axi_bvalid			<= axi_bvalid;
	s_axi_arready			<= axi_arready;
	s_axi_rdata			<= axi_rdata;
	s_axi_rvalid			<= axi_rvalid;
	
	axi_awready			<= '1';
	axi_wready			<= '1';
	
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
				elsif (s_axi_bready = '1' and axi_bvalid = '1') then   --check if bready is asserted while bvalid is high)
					axi_bvalid	<= '0';								   -- (there is a possibility that bready is always asserted high)
				end if;
			end if;
		end if;
	end process;

	process (s_axi_aclk)
	begin
		if rising_edge(s_axi_aclk) then
			if s_axi_aresetn = '0' then
				axi_arready 		<= '0';
				axi_araddr		<= (others => '1');
			else
				if (axi_arready = '0' and s_axi_arvalid = '1') then
					-- indicates that the slave has accepted the valid read address
					axi_arready	<= '1';
					-- Read Address latching
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
				s_axi_rresp		<= "00";
			else
				if (slv_reg_rden = '1' and axi_rvalid = '0') then
					axi_rvalid	<= '1';
					s_axi_rresp	<= "00"; -- 'OKAY' response
				elsif (axi_rvalid = '1' and s_axi_rready = '1') then
					-- Read data is accepted by the master
					axi_rvalid	<= '0';
				end if;
			end if;
		end if;
	end process;

	slv_reg_rden <= axi_arready and s_axi_arvalid and (not axi_rvalid) ;

	-- Generating FIFO read enable signal
	fifo_rd_en	<= slv_reg_rden;
	
	process(s_axi_aclk ) is
	begin
		if (rising_edge (s_axi_aclk)) then
			if ( s_axi_aresetn = '0' ) then
				axi_rdata		<= (others => '0');
			else
				if (slv_reg_rden = '1') then
					axi_rdata	<= dout_re_order;
				end if;
			end if;
		end if;
	end process;
	
	generate_dout_re_order: if LITTLE_ENDIAN16 generate
		dout_re_order				<= fifo_dout(15 downto 0) & fifo_dout(31 downto 16);
	end generate;
	
	generate_dout_wo_order: if not LITTLE_ENDIAN16 generate
		dout_re_order				<= fifo_dout;
	end generate;
	
end Behavioral;
