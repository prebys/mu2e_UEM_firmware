-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
-- Date        : Fri Mar 22 17:01:36 2024
-- Host        : mu2euem.dhcp.fnal.gov running 64-bit Scientific Linux release 7.9 (Nitrogen)
-- Command     : write_vhdl -force -mode funcsim
--               /root/Documents/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/microblaze_mcs_0/bd_0/ip/ip_3/bd_fc5c_dlmb_0_sim_netlist.vhdl
-- Design      : bd_fc5c_dlmb_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k420tffg1156-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_fc5c_dlmb_0_lmb_v10 is
  port (
    LMB_Clk : in STD_LOGIC;
    SYS_Rst : in STD_LOGIC;
    LMB_Rst : out STD_LOGIC;
    M_ABus : in STD_LOGIC_VECTOR ( 0 to 31 );
    M_ReadStrobe : in STD_LOGIC;
    M_WriteStrobe : in STD_LOGIC;
    M_AddrStrobe : in STD_LOGIC;
    M_DBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    M_BE : in STD_LOGIC_VECTOR ( 0 to 3 );
    Sl_DBus : in STD_LOGIC_VECTOR ( 0 to 63 );
    Sl_Ready : in STD_LOGIC_VECTOR ( 0 to 1 );
    Sl_Wait : in STD_LOGIC_VECTOR ( 0 to 1 );
    Sl_UE : in STD_LOGIC_VECTOR ( 0 to 1 );
    Sl_CE : in STD_LOGIC_VECTOR ( 0 to 1 );
    LMB_ABus : out STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_ReadStrobe : out STD_LOGIC;
    LMB_WriteStrobe : out STD_LOGIC;
    LMB_AddrStrobe : out STD_LOGIC;
    LMB_ReadDBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_WriteDBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_Ready : out STD_LOGIC;
    LMB_Wait : out STD_LOGIC;
    LMB_UE : out STD_LOGIC;
    LMB_CE : out STD_LOGIC;
    LMB_BE : out STD_LOGIC_VECTOR ( 0 to 3 )
  );
  attribute C_EXT_RESET_HIGH : integer;
  attribute C_EXT_RESET_HIGH of bd_fc5c_dlmb_0_lmb_v10 : entity is 1;
  attribute C_LMB_AWIDTH : integer;
  attribute C_LMB_AWIDTH of bd_fc5c_dlmb_0_lmb_v10 : entity is 32;
  attribute C_LMB_DWIDTH : integer;
  attribute C_LMB_DWIDTH of bd_fc5c_dlmb_0_lmb_v10 : entity is 32;
  attribute C_LMB_NUM_SLAVES : integer;
  attribute C_LMB_NUM_SLAVES of bd_fc5c_dlmb_0_lmb_v10 : entity is 2;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of bd_fc5c_dlmb_0_lmb_v10 : entity is "lmb_v10";
end bd_fc5c_dlmb_0_lmb_v10;

architecture STRUCTURE of bd_fc5c_dlmb_0_lmb_v10 is
  signal \^m_abus\ : STD_LOGIC_VECTOR ( 0 to 31 );
  signal \^m_addrstrobe\ : STD_LOGIC;
  signal \^m_be\ : STD_LOGIC_VECTOR ( 0 to 3 );
  signal \^m_dbus\ : STD_LOGIC_VECTOR ( 0 to 31 );
  signal \^m_readstrobe\ : STD_LOGIC;
  signal \^m_writestrobe\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \LMB_ReadDBus[16]_INST_0\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of LMB_Ready_INST_0 : label is "soft_lutpair0";
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of POR_FF_I : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of POR_FF_I : label is "FDS";
begin
  LMB_ABus(0 to 31) <= \^m_abus\(0 to 31);
  LMB_AddrStrobe <= \^m_addrstrobe\;
  LMB_BE(0 to 3) <= \^m_be\(0 to 3);
  LMB_ReadStrobe <= \^m_readstrobe\;
  LMB_WriteDBus(0 to 31) <= \^m_dbus\(0 to 31);
  LMB_WriteStrobe <= \^m_writestrobe\;
  \^m_abus\(0 to 31) <= M_ABus(0 to 31);
  \^m_addrstrobe\ <= M_AddrStrobe;
  \^m_be\(0 to 3) <= M_BE(0 to 3);
  \^m_dbus\(0 to 31) <= M_DBus(0 to 31);
  \^m_readstrobe\ <= M_ReadStrobe;
  \^m_writestrobe\ <= M_WriteStrobe;
LMB_CE_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => Sl_CE(1),
      I1 => Sl_CE(0),
      O => LMB_CE
    );
\LMB_ReadDBus[0]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(0),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(32),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(0)
    );
\LMB_ReadDBus[10]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(10),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(42),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(10)
    );
\LMB_ReadDBus[11]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(11),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(43),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(11)
    );
\LMB_ReadDBus[12]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(12),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(44),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(12)
    );
\LMB_ReadDBus[13]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(13),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(45),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(13)
    );
\LMB_ReadDBus[14]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(14),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(46),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(14)
    );
\LMB_ReadDBus[15]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(15),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(47),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(15)
    );
\LMB_ReadDBus[16]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(16),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(48),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(16)
    );
\LMB_ReadDBus[17]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(17),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(49),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(17)
    );
\LMB_ReadDBus[18]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(18),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(50),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(18)
    );
\LMB_ReadDBus[19]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(19),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(51),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(19)
    );
\LMB_ReadDBus[1]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(1),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(33),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(1)
    );
\LMB_ReadDBus[20]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(20),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(52),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(20)
    );
\LMB_ReadDBus[21]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(21),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(53),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(21)
    );
\LMB_ReadDBus[22]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(22),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(54),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(22)
    );
\LMB_ReadDBus[23]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(23),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(55),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(23)
    );
\LMB_ReadDBus[24]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(24),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(56),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(24)
    );
\LMB_ReadDBus[25]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(25),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(57),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(25)
    );
\LMB_ReadDBus[26]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(26),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(58),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(26)
    );
\LMB_ReadDBus[27]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(27),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(59),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(27)
    );
\LMB_ReadDBus[28]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(28),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(60),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(28)
    );
\LMB_ReadDBus[29]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(29),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(61),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(29)
    );
\LMB_ReadDBus[2]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(2),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(34),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(2)
    );
\LMB_ReadDBus[30]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(30),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(62),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(30)
    );
\LMB_ReadDBus[31]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(31),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(63),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(31)
    );
\LMB_ReadDBus[3]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(3),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(35),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(3)
    );
\LMB_ReadDBus[4]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(4),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(36),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(4)
    );
\LMB_ReadDBus[5]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(5),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(37),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(5)
    );
\LMB_ReadDBus[6]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(6),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(38),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(6)
    );
\LMB_ReadDBus[7]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(7),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(39),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(7)
    );
\LMB_ReadDBus[8]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(8),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(40),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(8)
    );
\LMB_ReadDBus[9]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => Sl_DBus(9),
      I1 => Sl_Ready(0),
      I2 => Sl_DBus(41),
      I3 => Sl_Ready(1),
      O => LMB_ReadDBus(9)
    );
LMB_Ready_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => Sl_Ready(0),
      I1 => Sl_Ready(1),
      O => LMB_Ready
    );
LMB_UE_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => Sl_UE(1),
      I1 => Sl_UE(0),
      O => LMB_UE
    );
LMB_Wait_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => Sl_Wait(1),
      I1 => Sl_Wait(0),
      O => LMB_Wait
    );
POR_FF_I: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => LMB_Clk,
      CE => '1',
      D => '0',
      Q => LMB_Rst,
      S => SYS_Rst
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_fc5c_dlmb_0 is
  port (
    LMB_Clk : in STD_LOGIC;
    SYS_Rst : in STD_LOGIC;
    LMB_Rst : out STD_LOGIC;
    M_ABus : in STD_LOGIC_VECTOR ( 0 to 31 );
    M_ReadStrobe : in STD_LOGIC;
    M_WriteStrobe : in STD_LOGIC;
    M_AddrStrobe : in STD_LOGIC;
    M_DBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    M_BE : in STD_LOGIC_VECTOR ( 0 to 3 );
    Sl_DBus : in STD_LOGIC_VECTOR ( 0 to 63 );
    Sl_Ready : in STD_LOGIC_VECTOR ( 0 to 1 );
    Sl_Wait : in STD_LOGIC_VECTOR ( 0 to 1 );
    Sl_UE : in STD_LOGIC_VECTOR ( 0 to 1 );
    Sl_CE : in STD_LOGIC_VECTOR ( 0 to 1 );
    LMB_ABus : out STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_ReadStrobe : out STD_LOGIC;
    LMB_WriteStrobe : out STD_LOGIC;
    LMB_AddrStrobe : out STD_LOGIC;
    LMB_ReadDBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_WriteDBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_Ready : out STD_LOGIC;
    LMB_Wait : out STD_LOGIC;
    LMB_UE : out STD_LOGIC;
    LMB_CE : out STD_LOGIC;
    LMB_BE : out STD_LOGIC_VECTOR ( 0 to 3 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of bd_fc5c_dlmb_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of bd_fc5c_dlmb_0 : entity is "bd_fc5c_dlmb_0,lmb_v10,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of bd_fc5c_dlmb_0 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of bd_fc5c_dlmb_0 : entity is "lmb_v10,Vivado 2016.2";
end bd_fc5c_dlmb_0;

architecture STRUCTURE of bd_fc5c_dlmb_0 is
  attribute C_EXT_RESET_HIGH : integer;
  attribute C_EXT_RESET_HIGH of U0 : label is 1;
  attribute C_LMB_AWIDTH : integer;
  attribute C_LMB_AWIDTH of U0 : label is 32;
  attribute C_LMB_DWIDTH : integer;
  attribute C_LMB_DWIDTH of U0 : label is 32;
  attribute C_LMB_NUM_SLAVES : integer;
  attribute C_LMB_NUM_SLAVES of U0 : label is 2;
begin
U0: entity work.bd_fc5c_dlmb_0_lmb_v10
     port map (
      LMB_ABus(0 to 31) => LMB_ABus(0 to 31),
      LMB_AddrStrobe => LMB_AddrStrobe,
      LMB_BE(0 to 3) => LMB_BE(0 to 3),
      LMB_CE => LMB_CE,
      LMB_Clk => LMB_Clk,
      LMB_ReadDBus(0 to 31) => LMB_ReadDBus(0 to 31),
      LMB_ReadStrobe => LMB_ReadStrobe,
      LMB_Ready => LMB_Ready,
      LMB_Rst => LMB_Rst,
      LMB_UE => LMB_UE,
      LMB_Wait => LMB_Wait,
      LMB_WriteDBus(0 to 31) => LMB_WriteDBus(0 to 31),
      LMB_WriteStrobe => LMB_WriteStrobe,
      M_ABus(0 to 31) => M_ABus(0 to 31),
      M_AddrStrobe => M_AddrStrobe,
      M_BE(0 to 3) => M_BE(0 to 3),
      M_DBus(0 to 31) => M_DBus(0 to 31),
      M_ReadStrobe => M_ReadStrobe,
      M_WriteStrobe => M_WriteStrobe,
      SYS_Rst => SYS_Rst,
      Sl_CE(0 to 1) => Sl_CE(0 to 1),
      Sl_DBus(0 to 63) => Sl_DBus(0 to 63),
      Sl_Ready(0 to 1) => Sl_Ready(0 to 1),
      Sl_UE(0 to 1) => Sl_UE(0 to 1),
      Sl_Wait(0 to 1) => Sl_Wait(0 to 1)
    );
end STRUCTURE;
