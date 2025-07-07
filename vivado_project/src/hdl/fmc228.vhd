----------------------------------------------------------------------------------
-- Company:
-- Engineer:       Matthew Jones - Purdue University
-- 
-- Create Date:    10:52:39 06/14/2016 
-- Design Name:    amc502
-- Package Name:   fmc228
-- Project Name:   AMC502 firmware
-- Target Devices: xc7k420tffv1156-1
-- Tool versions:  Vivado 2016.1
-- Description:    Interface for VadaTech FMC228 daughter board slave
--
-- Dependencies:
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

library hep337dev;
use hep337dev.iobus.all;

package fmc228 is

  component fmc228_interface is
    port (
      u : out std_logic_vector(2 downto 0);
      trig_in : in std_logic;
      trig_out : out std_logic;

      clk20mhz : in std_logic;
      bco : in std_logic_vector(47 downto 0);

      lmk_cs : out std_logic;
      lmk_sclk : out std_logic;
      lmk_sdi : out std_logic;
      lmk_sdo : in std_logic;
      lmk_sdio_dir : out std_logic;
      lmk_reset : out std_logic;
      lmk_sync : out std_logic;
      lmk_sysref_req : in std_logic;
      lmk_sync_dir : out std_logic;
      lmk_clkoe : out std_logic;
      lmk_status_ld : in std_logic_vector(1 downto 0);

      hmc_chip_en : out std_logic;
      hmc_ldo : in std_logic;
      hmc_sck : out std_logic;
      hmc_sdi : out std_logic;
      hmc_sdo : in std_logic;
      hmc_sen : out std_logic;

      adc_cs : out std_logic_vector(1 downto 0);
      adc_sck : out std_logic_vector(1 downto 0);
      adc_sdi : out std_logic_vector(1 downto 0);
      adc_sdo : in std_logic_vector(1 downto 0);
      adc_spi_dir : out std_logic_vector(1 downto 0);
      adc_pdwn : out std_logic_vector(1 downto 0);
      adc_sync : out std_logic_vector(1 downto 0);
      adc_fd : in std_logic_vector(3 downto 0);

      gte_refclk : in std_logic;
      sysref : in std_logic_vector(1 downto 0);
      rx_p : in std_logic_vector(7 downto 0);
      rx_n : in std_logic_vector(7 downto 0);

      gbe_stream_clk : in std_logic;
      gbe_stream_wren : out std_logic;
      gbe_stream_strobe : out std_logic;
      gbe_stream_dout : out std_logic_vector(31 downto 0);

      adc_clk : out std_logic;
      adc_valid : out std_logic_vector(3 downto 0);
      adc_data0 : out std_logic_vector(63 downto 0);
      adc_data1 : out std_logic_vector(63 downto 0);
      adc_data2 : out std_logic_vector(63 downto 0);
      adc_data3 : out std_logic_vector(63 downto 0);

      busclk : in std_logic;
      iobus : in iobus_t;
      write_data : out std_logic_vector(31 downto 0);
      iobus_ready : out std_logic
    ); 
  end component;

end package fmc228;
