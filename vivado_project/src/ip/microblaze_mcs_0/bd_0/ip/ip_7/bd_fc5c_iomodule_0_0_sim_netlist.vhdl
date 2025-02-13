-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
-- Date        : Fri Mar 22 16:55:09 2024
-- Host        : mu2euem.dhcp.fnal.gov running 64-bit Scientific Linux release 7.9 (Nitrogen)
-- Command     : write_vhdl -force -mode funcsim
--               /root/Documents/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/microblaze_mcs_0/bd_0/ip/ip_7/bd_fc5c_iomodule_0_0_sim_netlist.vhdl
-- Design      : bd_fc5c_iomodule_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k420tffg1156-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_fc5c_iomodule_0_0_Uart_Control_Status is
  port (
    D : out STD_LOGIC_VECTOR ( 1 downto 0 );
    UART_Status_Read : out STD_LOGIC;
    UART_Interrupt : out STD_LOGIC;
    Sl_DBus : out STD_LOGIC_VECTOR ( 3 downto 0 );
    Rst : in STD_LOGIC;
    rx_data_exists_i_reg : in STD_LOGIC;
    Clk : in STD_LOGIC;
    frame_error_reg_0 : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 4 downto 0 );
    lmb_reg_read : in STD_LOGIC;
    \out\ : in STD_LOGIC;
    UART_Tx_Interrupt : in STD_LOGIC;
    io_bus_read_data : in STD_LOGIC_VECTOR ( 3 downto 0 );
    \RX_Data_reg[6]\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    tx_buffer_empty_i_reg : in STD_LOGIC_VECTOR ( 1 downto 0 );
    rx_2_reg : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of bd_fc5c_iomodule_0_0_Uart_Control_Status : entity is "Uart_Control_Status";
end bd_fc5c_iomodule_0_0_Uart_Control_Status;

architecture STRUCTURE of bd_fc5c_iomodule_0_0_Uart_Control_Status is
  signal \^d\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal UART_Error_Interrupt : STD_LOGIC;
  signal UART_Status : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal \UART_Status[6]_i_1_n_0\ : STD_LOGIC;
  signal error_interrupt_i_1_n_0 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of UART_Interrupt_INST_0 : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of error_interrupt_i_1 : label is "soft_lutpair1";
begin
  D(1 downto 0) <= \^d\(1 downto 0);
\Sl_DBus[25]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => io_bus_read_data(3),
      I1 => UART_Status(6),
      I2 => \RX_Data_reg[6]\(3),
      O => Sl_DBus(3)
    );
\Sl_DBus[26]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => io_bus_read_data(2),
      I1 => UART_Status(5),
      I2 => \RX_Data_reg[6]\(2),
      O => Sl_DBus(2)
    );
\Sl_DBus[28]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => io_bus_read_data(1),
      I1 => UART_Status(3),
      I2 => \RX_Data_reg[6]\(1),
      O => Sl_DBus(1)
    );
\Sl_DBus[31]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => io_bus_read_data(0),
      I1 => UART_Status(0),
      I2 => \RX_Data_reg[6]\(0),
      O => Sl_DBus(0)
    );
UART_Interrupt_INST_0: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => UART_Error_Interrupt,
      I1 => \out\,
      I2 => UART_Tx_Interrupt,
      O => UART_Interrupt
    );
\UART_Status[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFBFFFFFFFF"
    )
        port map (
      I0 => Q(4),
      I1 => Q(1),
      I2 => Q(0),
      I3 => Q(2),
      I4 => Q(3),
      I5 => lmb_reg_read,
      O => \UART_Status[6]_i_1_n_0\
    );
\UART_Status_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => tx_buffer_empty_i_reg(0),
      Q => UART_Status(0),
      R => \UART_Status[6]_i_1_n_0\
    );
\UART_Status_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => tx_buffer_empty_i_reg(1),
      Q => UART_Status(3),
      R => \UART_Status[6]_i_1_n_0\
    );
\UART_Status_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \^d\(0),
      Q => UART_Status(5),
      R => \UART_Status[6]_i_1_n_0\
    );
\UART_Status_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \^d\(1),
      Q => UART_Status(6),
      R => \UART_Status[6]_i_1_n_0\
    );
error_interrupt_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EA"
    )
        port map (
      I0 => rx_2_reg,
      I1 => tx_buffer_empty_i_reg(0),
      I2 => \out\,
      O => error_interrupt_i_1_n_0
    );
error_interrupt_reg: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => error_interrupt_i_1_n_0,
      Q => UART_Error_Interrupt,
      R => Rst
    );
frame_error_reg: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => frame_error_reg_0,
      Q => \^d\(1),
      R => Rst
    );
overrun_error_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000020000"
    )
        port map (
      I0 => lmb_reg_read,
      I1 => Q(3),
      I2 => Q(2),
      I3 => Q(0),
      I4 => Q(1),
      I5 => Q(4),
      O => UART_Status_Read
    );
overrun_error_reg: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => rx_data_exists_i_reg,
      Q => \^d\(0),
      R => Rst
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_fc5c_iomodule_0_0_XIL_SRL16E is
  port (
    div16 : out STD_LOGIC;
    en_16x_baud : in STD_LOGIC;
    Clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of bd_fc5c_iomodule_0_0_XIL_SRL16E : entity is "XIL_SRL16E";
end bd_fc5c_iomodule_0_0_XIL_SRL16E;

architecture STRUCTURE of bd_fc5c_iomodule_0_0_XIL_SRL16E is
  signal \^div16\ : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \Use_unisim.XIL_SRL16E_I1\ : label is "PRIMITIVE";
  attribute srl_name : string;
  attribute srl_name of \Use_unisim.XIL_SRL16E_I1\ : label is "U0/\IOModule_Core_I1/Using_UART_TX.UART_TX_I1/DIV16_SRL16E/Use_unisim.XIL_SRL16E_I1 ";
begin
  div16 <= \^div16\;
\Use_unisim.XIL_SRL16E_I1\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0001",
      IS_CLK_INVERTED => '0'
    )
        port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => en_16x_baud,
      CLK => Clk,
      D => \^div16\,
      Q => \^div16\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_fc5c_iomodule_0_0_XIL_SRL16E_0 is
  port (
    loop_Bit : out STD_LOGIC;
    Clk_En_I_1 : in STD_LOGIC;
    Clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of bd_fc5c_iomodule_0_0_XIL_SRL16E_0 : entity is "XIL_SRL16E";
end bd_fc5c_iomodule_0_0_XIL_SRL16E_0;

architecture STRUCTURE of bd_fc5c_iomodule_0_0_XIL_SRL16E_0 is
  signal \^loop_bit\ : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \Use_unisim.XIL_SRL16E_I1\ : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \Use_unisim.XIL_SRL16E_I1\ : label is "U0/\IOModule_Core_I1/Using_UART.No_Dynamic_BaudRate.UART_FIT_I/Implement_FIT.Using_SRL16s.SRL16s ";
  attribute srl_name : string;
  attribute srl_name of \Use_unisim.XIL_SRL16E_I1\ : label is "U0/\IOModule_Core_I1/Using_UART.No_Dynamic_BaudRate.UART_FIT_I/Implement_FIT.Using_SRL16s.SRL16s[2].Divide_I/One_SRL16.SRL16E_I/Use_unisim.XIL_SRL16E_I1 ";
begin
  loop_Bit <= \^loop_bit\;
\Use_unisim.XIL_SRL16E_I1\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0001",
      IS_CLK_INVERTED => '0'
    )
        port map (
      A0 => '1',
      A1 => '0',
      A2 => '1',
      A3 => '0',
      CE => Clk_En_I_1,
      CLK => Clk,
      D => \^loop_bit\,
      Q => \^loop_bit\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_fc5c_iomodule_0_0_XIL_SRL16E_1 is
  port (
    Clk_En_I_1 : out STD_LOGIC;
    Clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of bd_fc5c_iomodule_0_0_XIL_SRL16E_1 : entity is "XIL_SRL16E";
end bd_fc5c_iomodule_0_0_XIL_SRL16E_1;

architecture STRUCTURE of bd_fc5c_iomodule_0_0_XIL_SRL16E_1 is
  signal \^clk_en_i_1\ : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \Use_unisim.XIL_SRL16E_I1\ : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \Use_unisim.XIL_SRL16E_I1\ : label is "U0/\IOModule_Core_I1/Using_UART.No_Dynamic_BaudRate.UART_FIT_I/Implement_FIT.Using_SRL16s.SRL16s ";
  attribute srl_name : string;
  attribute srl_name of \Use_unisim.XIL_SRL16E_I1\ : label is "U0/\IOModule_Core_I1/Using_UART.No_Dynamic_BaudRate.UART_FIT_I/Implement_FIT.Using_SRL16s.SRL16s[1].Divide_I/One_SRL16.SRL16E_I/Use_unisim.XIL_SRL16E_I1 ";
begin
  Clk_En_I_1 <= \^clk_en_i_1\;
\Use_unisim.XIL_SRL16E_I1\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0001",
      IS_CLK_INVERTED => '0'
    )
        port map (
      A0 => '0',
      A1 => '0',
      A2 => '0',
      A3 => '1',
      CE => '1',
      CLK => Clk,
      D => \^clk_en_i_1\,
      Q => \^clk_en_i_1\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_fc5c_iomodule_0_0_XIL_SRL16E_2 is
  port (
    loop_Bit : out STD_LOGIC;
    Clk_En_I_2 : in STD_LOGIC;
    Clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of bd_fc5c_iomodule_0_0_XIL_SRL16E_2 : entity is "XIL_SRL16E";
end bd_fc5c_iomodule_0_0_XIL_SRL16E_2;

architecture STRUCTURE of bd_fc5c_iomodule_0_0_XIL_SRL16E_2 is
  signal \^loop_bit\ : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \Use_unisim.XIL_SRL16E_I1\ : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \Use_unisim.XIL_SRL16E_I1\ : label is "U0/\IOModule_Core_I1/FIT_I1/Implement_FIT.Using_SRL16s.SRL16s ";
  attribute srl_name : string;
  attribute srl_name of \Use_unisim.XIL_SRL16E_I1\ : label is "U0/\IOModule_Core_I1/FIT_I1/Implement_FIT.Using_SRL16s.SRL16s[2].Divide_I/One_SRL16.SRL16E_I/Use_unisim.XIL_SRL16E_I1 ";
begin
  loop_Bit <= \^loop_bit\;
\Use_unisim.XIL_SRL16E_I1\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0001",
      IS_CLK_INVERTED => '0'
    )
        port map (
      A0 => '1',
      A1 => '1',
      A2 => '0',
      A3 => '1',
      CE => Clk_En_I_2,
      CLK => Clk,
      D => \^loop_bit\,
      Q => \^loop_bit\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_fc5c_iomodule_0_0_XIL_SRL16E_3 is
  port (
    Clk_En_I_2 : out STD_LOGIC;
    Clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of bd_fc5c_iomodule_0_0_XIL_SRL16E_3 : entity is "XIL_SRL16E";
end bd_fc5c_iomodule_0_0_XIL_SRL16E_3;

architecture STRUCTURE of bd_fc5c_iomodule_0_0_XIL_SRL16E_3 is
  signal \^clk_en_i_2\ : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \Use_unisim.XIL_SRL16E_I1\ : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \Use_unisim.XIL_SRL16E_I1\ : label is "U0/\IOModule_Core_I1/FIT_I1/Implement_FIT.Using_SRL16s.SRL16s ";
  attribute srl_name : string;
  attribute srl_name of \Use_unisim.XIL_SRL16E_I1\ : label is "U0/\IOModule_Core_I1/FIT_I1/Implement_FIT.Using_SRL16s.SRL16s[1].Divide_I/One_SRL16.SRL16E_I/Use_unisim.XIL_SRL16E_I1 ";
begin
  Clk_En_I_2 <= \^clk_en_i_2\;
\Use_unisim.XIL_SRL16E_I1\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0001",
      IS_CLK_INVERTED => '0'
    )
        port map (
      A0 => '1',
      A1 => '0',
      A2 => '1',
      A3 => '1',
      CE => '1',
      CLK => Clk,
      D => \^clk_en_i_2\,
      Q => \^clk_en_i_2\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \bd_fc5c_iomodule_0_0_XIL_SRL16E__parameterized1\ is
  port (
    mid_Start_Bit : out STD_LOGIC;
    en_16x_baud : in STD_LOGIC;
    start_Edge_Detected_reg : in STD_LOGIC;
    Clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \bd_fc5c_iomodule_0_0_XIL_SRL16E__parameterized1\ : entity is "XIL_SRL16E";
end \bd_fc5c_iomodule_0_0_XIL_SRL16E__parameterized1\;

architecture STRUCTURE of \bd_fc5c_iomodule_0_0_XIL_SRL16E__parameterized1\ is
  attribute box_type : string;
  attribute box_type of \Use_unisim.XIL_SRL16E_I1\ : label is "PRIMITIVE";
  attribute srl_name : string;
  attribute srl_name of \Use_unisim.XIL_SRL16E_I1\ : label is "U0/\IOModule_Core_I1/Using_UART_RX.UART_RX_I1/Mid_Start_Bit_SRL16/Use_unisim.XIL_SRL16E_I1 ";
begin
\Use_unisim.XIL_SRL16E_I1\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000",
      IS_CLK_INVERTED => '0'
    )
        port map (
      A0 => '0',
      A1 => '1',
      A2 => '1',
      A3 => '0',
      CE => en_16x_baud,
      CLK => Clk,
      D => start_Edge_Detected_reg,
      Q => mid_Start_Bit
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \bd_fc5c_iomodule_0_0_XIL_SRL16E__parameterized3\ is
  port (
    sample_Point : out STD_LOGIC;
    stop_Bit_Position_reg : out STD_LOGIC;
    running_reg : out STD_LOGIC;
    \Convert_Serial_To_Parallel[8].serial_to_parallel_reg\ : out STD_LOGIC;
    \Convert_Serial_To_Parallel[7].serial_to_parallel_reg\ : out STD_LOGIC;
    \Convert_Serial_To_Parallel[6].serial_to_parallel_reg\ : out STD_LOGIC;
    \Convert_Serial_To_Parallel[5].serial_to_parallel_reg\ : out STD_LOGIC;
    \Convert_Serial_To_Parallel[4].serial_to_parallel_reg\ : out STD_LOGIC;
    \Convert_Serial_To_Parallel[3].serial_to_parallel_reg\ : out STD_LOGIC;
    \Convert_Serial_To_Parallel[2].serial_to_parallel_reg\ : out STD_LOGIC;
    D_0 : out STD_LOGIC;
    en_16x_baud : in STD_LOGIC;
    Clk : in STD_LOGIC;
    \out\ : in STD_LOGIC_VECTOR ( 8 downto 0 );
    stop_Bit_Position_reg_0 : in STD_LOGIC;
    start_Edge_Detected_reg : in STD_LOGIC;
    running_reg_0 : in STD_LOGIC;
    mid_Start_Bit : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \bd_fc5c_iomodule_0_0_XIL_SRL16E__parameterized3\ : entity is "XIL_SRL16E";
end \bd_fc5c_iomodule_0_0_XIL_SRL16E__parameterized3\;

architecture STRUCTURE of \bd_fc5c_iomodule_0_0_XIL_SRL16E__parameterized3\ is
  signal \Use_unisim.XIL_SRL16E_I1_i_1_n_0\ : STD_LOGIC;
  signal \^sample_point\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \Convert_Serial_To_Parallel[1].First_Bit.First_Bit_I_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \Convert_Serial_To_Parallel[2].Rest_Bits.Others_I_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \Convert_Serial_To_Parallel[3].Rest_Bits.Others_I_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \Convert_Serial_To_Parallel[4].Rest_Bits.Others_I_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \Convert_Serial_To_Parallel[5].Rest_Bits.Others_I_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \Convert_Serial_To_Parallel[6].Rest_Bits.Others_I_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \Convert_Serial_To_Parallel[7].Rest_Bits.Others_I_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \Convert_Serial_To_Parallel[8].Rest_Bits.Others_I_i_1\ : label is "soft_lutpair2";
  attribute box_type : string;
  attribute box_type of \Use_unisim.XIL_SRL16E_I1\ : label is "PRIMITIVE";
  attribute srl_name : string;
  attribute srl_name of \Use_unisim.XIL_SRL16E_I1\ : label is "U0/\IOModule_Core_I1/Using_UART_RX.UART_RX_I1/Delay_16/Use_unisim.XIL_SRL16E_I1 ";
  attribute SOFT_HLUTNM of \Use_unisim.XIL_SRL16E_I1_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of stop_Bit_Position_i_1 : label is "soft_lutpair2";
begin
  sample_Point <= \^sample_point\;
\Convert_Serial_To_Parallel[1].First_Bit.First_Bit_I_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \out\(7),
      I1 => stop_Bit_Position_reg_0,
      I2 => \^sample_point\,
      I3 => \out\(8),
      O => D_0
    );
\Convert_Serial_To_Parallel[2].Rest_Bits.Others_I_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \out\(6),
      I1 => stop_Bit_Position_reg_0,
      I2 => \^sample_point\,
      I3 => \out\(7),
      O => \Convert_Serial_To_Parallel[2].serial_to_parallel_reg\
    );
\Convert_Serial_To_Parallel[3].Rest_Bits.Others_I_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \out\(5),
      I1 => stop_Bit_Position_reg_0,
      I2 => \^sample_point\,
      I3 => \out\(6),
      O => \Convert_Serial_To_Parallel[3].serial_to_parallel_reg\
    );
\Convert_Serial_To_Parallel[4].Rest_Bits.Others_I_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \out\(4),
      I1 => stop_Bit_Position_reg_0,
      I2 => \^sample_point\,
      I3 => \out\(5),
      O => \Convert_Serial_To_Parallel[4].serial_to_parallel_reg\
    );
\Convert_Serial_To_Parallel[5].Rest_Bits.Others_I_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \out\(3),
      I1 => stop_Bit_Position_reg_0,
      I2 => \^sample_point\,
      I3 => \out\(4),
      O => \Convert_Serial_To_Parallel[5].serial_to_parallel_reg\
    );
\Convert_Serial_To_Parallel[6].Rest_Bits.Others_I_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \out\(2),
      I1 => stop_Bit_Position_reg_0,
      I2 => \^sample_point\,
      I3 => \out\(3),
      O => \Convert_Serial_To_Parallel[6].serial_to_parallel_reg\
    );
\Convert_Serial_To_Parallel[7].Rest_Bits.Others_I_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \out\(1),
      I1 => stop_Bit_Position_reg_0,
      I2 => \^sample_point\,
      I3 => \out\(2),
      O => \Convert_Serial_To_Parallel[7].serial_to_parallel_reg\
    );
\Convert_Serial_To_Parallel[8].Rest_Bits.Others_I_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"BA8A"
    )
        port map (
      I0 => \out\(0),
      I1 => stop_Bit_Position_reg_0,
      I2 => \^sample_point\,
      I3 => \out\(1),
      O => \Convert_Serial_To_Parallel[8].serial_to_parallel_reg\
    );
\Use_unisim.XIL_SRL16E_I1\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000",
      IS_CLK_INVERTED => '0'
    )
        port map (
      A0 => '1',
      A1 => '1',
      A2 => '1',
      A3 => '1',
      CE => en_16x_baud,
      CLK => Clk,
      D => \Use_unisim.XIL_SRL16E_I1_i_1_n_0\,
      Q => \^sample_point\
    );
\Use_unisim.XIL_SRL16E_I1_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => \^sample_point\,
      I1 => mid_Start_Bit,
      I2 => stop_Bit_Position_reg_0,
      O => \Use_unisim.XIL_SRL16E_I1_i_1_n_0\
    );
running_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F7FFF000"
    )
        port map (
      I0 => \^sample_point\,
      I1 => stop_Bit_Position_reg_0,
      I2 => start_Edge_Detected_reg,
      I3 => en_16x_baud,
      I4 => running_reg_0,
      O => running_reg
    );
stop_Bit_Position_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2CCC"
    )
        port map (
      I0 => \out\(0),
      I1 => stop_Bit_Position_reg_0,
      I2 => \^sample_point\,
      I3 => en_16x_baud,
      O => stop_Bit_Position_reg
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \bd_fc5c_iomodule_0_0_XIL_SRL16E__parameterized9\ is
  port (
    loop_Bit : out STD_LOGIC;
    Clk_En_I_1 : in STD_LOGIC;
    shifts_0 : in STD_LOGIC;
    Clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \bd_fc5c_iomodule_0_0_XIL_SRL16E__parameterized9\ : entity is "XIL_SRL16E";
end \bd_fc5c_iomodule_0_0_XIL_SRL16E__parameterized9\;

architecture STRUCTURE of \bd_fc5c_iomodule_0_0_XIL_SRL16E__parameterized9\ is
  attribute box_type : string;
  attribute box_type of \Use_unisim.XIL_SRL16E_I1\ : label is "PRIMITIVE";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \Use_unisim.XIL_SRL16E_I1\ : label is "U0/\IOModule_Core_I1/FIT_I1/Implement_FIT.Using_SRL16s.SRL16s ";
  attribute srl_name : string;
  attribute srl_name of \Use_unisim.XIL_SRL16E_I1\ : label is "U0/\IOModule_Core_I1/FIT_I1/Implement_FIT.Using_SRL16s.SRL16s[3].Divide_I/More_Than_Two.SRL16E_n/Use_unisim.XIL_SRL16E_I1 ";
begin
\Use_unisim.XIL_SRL16E_I1\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000",
      IS_CLK_INVERTED => '0'
    )
        port map (
      A0 => '0',
      A1 => '0',
      A2 => '1',
      A3 => '0',
      CE => Clk_En_I_1,
      CLK => Clk,
      D => shifts_0,
      Q => loop_Bit
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_fc5c_iomodule_0_0_XIL_SRLC16E is
  port (
    shifts_1 : out STD_LOGIC;
    Clk_En_I_1 : in STD_LOGIC;
    loop_Bit : in STD_LOGIC;
    Clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of bd_fc5c_iomodule_0_0_XIL_SRLC16E : entity is "XIL_SRLC16E";
end bd_fc5c_iomodule_0_0_XIL_SRLC16E;

architecture STRUCTURE of bd_fc5c_iomodule_0_0_XIL_SRLC16E is
begin
  shifts_1 <= 'Z';
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \bd_fc5c_iomodule_0_0_XIL_SRLC16E__parameterized1\ is
  port (
    shifts_0 : out STD_LOGIC;
    Clk_En_I_1 : in STD_LOGIC;
    shifts_1 : in STD_LOGIC;
    Clk : in STD_LOGIC;
    lopt : in STD_LOGIC;
    lopt_1 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \bd_fc5c_iomodule_0_0_XIL_SRLC16E__parameterized1\ : entity is "XIL_SRLC16E";
end \bd_fc5c_iomodule_0_0_XIL_SRLC16E__parameterized1\;

architecture STRUCTURE of \bd_fc5c_iomodule_0_0_XIL_SRLC16E__parameterized1\ is
  signal \Use_unisim.XIL_SRL16CE_I1_n_0\ : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \Use_unisim.XIL_SRL16CE_I1Use_unisim.XIL_SRL16CE_I1\ : label is "PRIMITIVE";
begin
\Use_unisim.XIL_SRL16CE_I1Use_unisim.XIL_SRL16CE_I1\: unisim.vcomponents.SRLC32E
    generic map(
      INIT => X"00000001",
      IS_CLK_INVERTED => '0'
    )
        port map (
      A(4) => lopt_1,
      A(3 downto 0) => B"1111",
      CE => Clk_En_I_1,
      CLK => Clk,
      D => lopt,
      Q => \Use_unisim.XIL_SRL16CE_I1_n_0\,
      Q31 => shifts_0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_fc5c_iomodule_0_0_intr_ctrl is
  port (
    INTC_IRQ : out STD_LOGIC;
    Sl_DBus : out STD_LOGIC_VECTOR ( 2 downto 0 );
    INTC_Interrupt_Address : out STD_LOGIC_VECTOR ( 14 downto 0 );
    Clk : in STD_LOGIC;
    Rst : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 5 downto 0 );
    lmb_reg_write : in STD_LOGIC;
    lmb_reg_read : in STD_LOGIC;
    \out\ : in STD_LOGIC_VECTOR ( 15 downto 0 );
    new_rx_data_write_reg : in STD_LOGIC;
    data_is_sent_reg : in STD_LOGIC;
    INTC_Processor_Ack : in STD_LOGIC_VECTOR ( 1 downto 0 );
    io_bus_read_data : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \RX_Data_reg[2]\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    INTC_Interrupt : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of bd_fc5c_iomodule_0_0_intr_ctrl : entity is "intr_ctrl";
end bd_fc5c_iomodule_0_0_intr_ctrl;

architecture STRUCTURE of bd_fc5c_iomodule_0_0_intr_ctrl is
  signal \All_INTR_Bits[16].Using_CIMR.cimr[16]_i_1_n_0\ : STD_LOGIC;
  signal \All_INTR_Bits[16].Using_Intr.cier[16]_i_1_n_0\ : STD_LOGIC;
  signal \All_INTR_Bits[16].Using_Intr.cisr[16]_i_2_n_0\ : STD_LOGIC;
  signal \All_INTR_Bits[16].Using_Intr.cisr[16]_i_3_n_0\ : STD_LOGIC;
  signal \All_INTR_Bits[1].Using_CIMR.cimr[1]_i_1_n_0\ : STD_LOGIC;
  signal \All_INTR_Bits[1].Using_CIMR.cimr[1]_i_2_n_0\ : STD_LOGIC;
  signal \All_INTR_Bits[1].Using_Intr.cier[1]_i_1_n_0\ : STD_LOGIC;
  signal \All_INTR_Bits[1].Using_Intr.cisr[1]_i_1_n_0\ : STD_LOGIC;
  signal \All_INTR_Bits[1].Using_Intr.cisr[1]_i_2_n_0\ : STD_LOGIC;
  signal \All_INTR_Bits[1].Using_Intr.cisr[1]_i_3_n_0\ : STD_LOGIC;
  signal \All_INTR_Bits[1].Using_Intr.cisr[1]_i_4_n_0\ : STD_LOGIC;
  signal \All_INTR_Bits[2].Using_CIMR.cimr[2]_i_1_n_0\ : STD_LOGIC;
  signal \All_INTR_Bits[2].Using_Intr.cier[2]_i_1_n_0\ : STD_LOGIC;
  signal \All_INTR_Bits[2].Using_Intr.cisr[2]_i_2_n_0\ : STD_LOGIC;
  signal D : STD_LOGIC;
  signal D25_out : STD_LOGIC;
  signal D35_out : STD_LOGIC;
  signal INTC_CIPR : STD_LOGIC_VECTOR ( 16 downto 1 );
  signal INTC_CISR : STD_LOGIC_VECTOR ( 16 downto 1 );
  signal \INTC_CISR[16]_i_1_n_0\ : STD_LOGIC;
  signal \INTC_CISR[16]_i_2_n_0\ : STD_LOGIC;
  signal \INTC_CISR[1]_i_1_n_0\ : STD_LOGIC;
  signal \INTC_CISR[2]_i_1_n_0\ : STD_LOGIC;
  signal R : STD_LOGIC;
  signal \Using_Fast.INTC_IRQ_i_1_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.civar[0][14]_i_2_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.civar[19][14]_i_2_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.civar[3][14]_i_2_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.civar_reg[0]\ : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal \Using_Fast.Using_LUTRAM.civar_reg[16]\ : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal \Using_Fast.Using_LUTRAM.civar_reg[17]\ : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal \Using_Fast.Using_LUTRAM.civar_reg[18]\ : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal \Using_Fast.Using_LUTRAM.civar_reg[19]\ : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal \Using_Fast.Using_LUTRAM.civar_reg[1]\ : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal \Using_Fast.Using_LUTRAM.civar_reg[2]\ : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal \Using_Fast.Using_LUTRAM.civar_reg[3]\ : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[0]_i_2_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[0]_i_3_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[10]_i_2_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[10]_i_3_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[11]_i_2_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[11]_i_3_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[12]_i_2_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[12]_i_3_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[13]_i_2_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[13]_i_3_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[14]_i_2_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[14]_i_3_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[1]_i_2_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[1]_i_3_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[2]_i_2_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[2]_i_3_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[3]_i_2_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[3]_i_3_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[4]_i_2_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[4]_i_3_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[5]_i_2_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[5]_i_3_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[6]_i_2_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[6]_i_3_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[7]_i_2_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[7]_i_3_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[8]_i_2_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[8]_i_3_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[9]_i_2_n_0\ : STD_LOGIC;
  signal \Using_Fast.Using_LUTRAM.intr_addr_i[9]_i_3_n_0\ : STD_LOGIC;
  signal \Using_Fast.civr[0]_i_1_n_0\ : STD_LOGIC;
  signal \Using_Fast.civr[1]_i_1_n_0\ : STD_LOGIC;
  signal \Using_Fast.civr[4]_i_1_n_0\ : STD_LOGIC;
  signal \Using_Fast.civr_reg_n_0_[0]\ : STD_LOGIC;
  signal \Using_Fast.civr_reg_n_0_[1]\ : STD_LOGIC;
  signal \Using_Fast.civr_reg_n_0_[4]\ : STD_LOGIC;
  signal \Using_Fast.do_fast_ack_i_1_n_0\ : STD_LOGIC;
  signal \Using_Fast.fast_state[0]_i_1_n_0\ : STD_LOGIC;
  signal \Using_Fast.fast_state[1]_i_1_n_0\ : STD_LOGIC;
  signal \Using_Fast.fast_state_reg_n_0_[0]\ : STD_LOGIC;
  signal \Using_Fast.fast_state_reg_n_0_[1]\ : STD_LOGIC;
  signal \byte_zeros__1\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal cier : STD_LOGIC_VECTOR ( 16 downto 1 );
  signal cimr : STD_LOGIC_VECTOR ( 16 downto 1 );
  signal cisr : STD_LOGIC_VECTOR ( 16 downto 1 );
  signal \civar[0]_3\ : STD_LOGIC;
  signal \civar[16]_4\ : STD_LOGIC;
  signal \civar[17]_5\ : STD_LOGIC;
  signal \civar[18]_6\ : STD_LOGIC;
  signal \civar[19]_7\ : STD_LOGIC;
  signal \civar[1]_1\ : STD_LOGIC;
  signal \civar[2]_2\ : STD_LOGIC;
  signal \civar[31]_8\ : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal \civar[3]_0\ : STD_LOGIC;
  signal do_fast_ack : STD_LOGIC;
  signal \has_fast__5\ : STD_LOGIC;
  signal intr_ff : STD_LOGIC_VECTOR ( 0 to 1 );
  attribute async_reg : string;
  attribute async_reg of intr_ff : signal is "true";
  signal p_11_out : STD_LOGIC;
  signal p_5_out : STD_LOGIC_VECTOR ( 16 to 16 );
  signal p_6_out7_out : STD_LOGIC;
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of \All_INTR_Bits[16].Using_Intr.Ext_Intr.Async_Gen.intr_ff_reg[0]\ : label is std.standard.true;
  attribute KEEP : string;
  attribute KEEP of \All_INTR_Bits[16].Using_Intr.Ext_Intr.Async_Gen.intr_ff_reg[0]\ : label is "yes";
  attribute ASYNC_REG_boolean of \All_INTR_Bits[16].Using_Intr.Ext_Intr.Async_Gen.intr_ff_reg[1]\ : label is std.standard.true;
  attribute KEEP of \All_INTR_Bits[16].Using_Intr.Ext_Intr.Async_Gen.intr_ff_reg[1]\ : label is "yes";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \All_INTR_Bits[16].Using_Intr.cisr[16]_i_2\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \All_INTR_Bits[1].Using_CIMR.cimr[1]_i_2\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \All_INTR_Bits[1].Using_Intr.cisr[1]_i_2\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \All_INTR_Bits[1].Using_Intr.cisr[1]_i_3\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \All_INTR_Bits[2].Using_Intr.cisr[2]_i_2\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \INTC_CISR[16]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \INTC_CISR[2]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \Using_Fast.INTC_IRQ_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \Using_Fast.Using_LUTRAM.civar[0][14]_i_2\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \Using_Fast.Using_LUTRAM.civar[19][14]_i_2\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \Using_Fast.Using_LUTRAM.civar[3][14]_i_2\ : label is "soft_lutpair13";
  attribute RAM_STYLE : string;
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[0][0]\ : label is "distributed";
  attribute ram_extract : string;
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[0][0]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[0][10]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[0][10]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[0][11]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[0][11]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[0][12]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[0][12]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[0][13]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[0][13]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[0][14]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[0][14]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[0][1]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[0][1]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[0][2]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[0][2]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[0][3]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[0][3]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[0][4]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[0][4]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[0][5]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[0][5]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[0][6]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[0][6]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[0][7]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[0][7]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[0][8]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[0][8]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[0][9]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[0][9]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[16][0]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[16][0]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[16][10]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[16][10]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[16][11]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[16][11]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[16][12]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[16][12]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[16][13]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[16][13]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[16][14]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[16][14]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[16][1]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[16][1]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[16][2]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[16][2]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[16][3]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[16][3]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[16][4]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[16][4]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[16][5]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[16][5]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[16][6]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[16][6]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[16][7]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[16][7]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[16][8]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[16][8]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[16][9]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[16][9]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[17][0]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[17][0]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[17][10]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[17][10]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[17][11]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[17][11]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[17][12]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[17][12]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[17][13]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[17][13]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[17][14]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[17][14]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[17][1]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[17][1]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[17][2]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[17][2]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[17][3]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[17][3]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[17][4]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[17][4]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[17][5]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[17][5]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[17][6]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[17][6]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[17][7]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[17][7]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[17][8]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[17][8]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[17][9]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[17][9]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[18][0]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[18][0]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[18][10]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[18][10]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[18][11]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[18][11]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[18][12]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[18][12]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[18][13]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[18][13]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[18][14]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[18][14]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[18][1]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[18][1]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[18][2]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[18][2]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[18][3]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[18][3]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[18][4]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[18][4]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[18][5]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[18][5]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[18][6]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[18][6]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[18][7]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[18][7]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[18][8]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[18][8]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[18][9]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[18][9]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[19][0]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[19][0]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[19][10]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[19][10]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[19][11]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[19][11]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[19][12]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[19][12]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[19][13]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[19][13]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[19][14]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[19][14]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[19][1]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[19][1]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[19][2]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[19][2]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[19][3]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[19][3]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[19][4]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[19][4]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[19][5]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[19][5]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[19][6]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[19][6]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[19][7]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[19][7]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[19][8]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[19][8]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[19][9]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[19][9]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[1][0]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[1][0]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[1][10]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[1][10]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[1][11]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[1][11]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[1][12]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[1][12]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[1][13]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[1][13]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[1][14]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[1][14]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[1][1]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[1][1]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[1][2]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[1][2]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[1][3]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[1][3]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[1][4]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[1][4]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[1][5]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[1][5]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[1][6]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[1][6]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[1][7]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[1][7]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[1][8]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[1][8]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[1][9]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[1][9]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[2][0]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[2][0]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[2][10]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[2][10]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[2][11]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[2][11]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[2][12]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[2][12]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[2][13]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[2][13]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[2][14]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[2][14]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[2][1]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[2][1]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[2][2]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[2][2]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[2][3]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[2][3]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[2][4]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[2][4]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[2][5]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[2][5]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[2][6]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[2][6]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[2][7]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[2][7]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[2][8]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[2][8]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[2][9]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[2][9]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[3][0]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[3][0]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[3][10]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[3][10]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[3][11]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[3][11]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[3][12]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[3][12]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[3][13]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[3][13]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[3][14]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[3][14]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[3][1]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[3][1]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[3][2]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[3][2]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[3][3]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[3][3]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[3][4]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[3][4]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[3][5]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[3][5]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[3][6]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[3][6]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[3][7]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[3][7]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[3][8]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[3][8]\ : label is "yes";
  attribute RAM_STYLE of \Using_Fast.Using_LUTRAM.civar_reg[3][9]\ : label is "distributed";
  attribute ram_extract of \Using_Fast.Using_LUTRAM.civar_reg[3][9]\ : label is "yes";
  attribute SOFT_HLUTNM of \Using_Fast.fast_state[0]_i_2\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \Using_Fast.fast_state[1]_i_1\ : label is "soft_lutpair15";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of \cipr_rd_dff_all[16].fdr_i\ : label is "FDR";
  attribute box_type : string;
  attribute box_type of \cipr_rd_dff_all[16].fdr_i\ : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of \cipr_rd_dff_all[1].fdr_i\ : label is "FDR";
  attribute box_type of \cipr_rd_dff_all[1].fdr_i\ : label is "PRIMITIVE";
  attribute SOFT_HLUTNM of \cipr_rd_dff_all[1].fdr_i_i_2\ : label is "soft_lutpair14";
  attribute XILINX_LEGACY_PRIM of \cipr_rd_dff_all[2].fdr_i\ : label is "FDR";
  attribute box_type of \cipr_rd_dff_all[2].fdr_i\ : label is "PRIMITIVE";
begin
\All_INTR_Bits[16].Using_CIMR.cimr[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFBFFF00008000"
    )
        port map (
      I0 => \out\(15),
      I1 => \All_INTR_Bits[1].Using_CIMR.cimr[1]_i_2_n_0\,
      I2 => Q(0),
      I3 => Q(1),
      I4 => Q(4),
      I5 => cimr(16),
      O => \All_INTR_Bits[16].Using_CIMR.cimr[16]_i_1_n_0\
    );
\All_INTR_Bits[16].Using_CIMR.cimr_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \All_INTR_Bits[16].Using_CIMR.cimr[16]_i_1_n_0\,
      Q => cimr(16),
      R => Rst
    );
\All_INTR_Bits[16].Using_Intr.Ext_Intr.Async_Gen.intr_ff_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => '1',
      D => INTC_Interrupt(0),
      Q => intr_ff(0),
      R => '0'
    );
\All_INTR_Bits[16].Using_Intr.Ext_Intr.Async_Gen.intr_ff_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => '1',
      D => intr_ff(0),
      Q => intr_ff(1),
      R => '0'
    );
\All_INTR_Bits[16].Using_Intr.Ext_Intr.interrupt_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => intr_ff(1),
      Q => p_5_out(16),
      R => Rst
    );
\All_INTR_Bits[16].Using_Intr.cier[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFBFF00000800"
    )
        port map (
      I0 => \out\(15),
      I1 => \All_INTR_Bits[1].Using_Intr.cisr[1]_i_2_n_0\,
      I2 => Q(0),
      I3 => Q(1),
      I4 => Q(4),
      I5 => cier(16),
      O => \All_INTR_Bits[16].Using_Intr.cier[16]_i_1_n_0\
    );
\All_INTR_Bits[16].Using_Intr.cier_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \All_INTR_Bits[16].Using_Intr.cier[16]_i_1_n_0\,
      Q => cier(16),
      R => Rst
    );
\All_INTR_Bits[16].Using_Intr.cisr[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF7F000000"
    )
        port map (
      I0 => \out\(15),
      I1 => \All_INTR_Bits[1].Using_Intr.cisr[1]_i_2_n_0\,
      I2 => \All_INTR_Bits[1].Using_Intr.cisr[1]_i_3_n_0\,
      I3 => cisr(16),
      I4 => \All_INTR_Bits[16].Using_Intr.cisr[16]_i_2_n_0\,
      I5 => \All_INTR_Bits[16].Using_Intr.cisr[16]_i_3_n_0\,
      O => p_11_out
    );
\All_INTR_Bits[16].Using_Intr.cisr[16]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000EFFF"
    )
        port map (
      I0 => \Using_Fast.civr_reg_n_0_[0]\,
      I1 => \Using_Fast.civr_reg_n_0_[1]\,
      I2 => do_fast_ack,
      I3 => \Using_Fast.civr_reg_n_0_[4]\,
      I4 => Rst,
      O => \All_INTR_Bits[16].Using_Intr.cisr[16]_i_2_n_0\
    );
\All_INTR_Bits[16].Using_Intr.cisr[16]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => p_5_out(16),
      I1 => Rst,
      O => \All_INTR_Bits[16].Using_Intr.cisr[16]_i_3_n_0\
    );
\All_INTR_Bits[16].Using_Intr.cisr_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => p_11_out,
      Q => cisr(16),
      R => '0'
    );
\All_INTR_Bits[1].Using_CIMR.cimr[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFBFFF00008000"
    )
        port map (
      I0 => \out\(0),
      I1 => \All_INTR_Bits[1].Using_CIMR.cimr[1]_i_2_n_0\,
      I2 => Q(0),
      I3 => Q(1),
      I4 => Q(4),
      I5 => cimr(1),
      O => \All_INTR_Bits[1].Using_CIMR.cimr[1]_i_1_n_0\
    );
\All_INTR_Bits[1].Using_CIMR.cimr[1]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
        port map (
      I0 => Q(5),
      I1 => lmb_reg_write,
      I2 => Q(2),
      I3 => Q(3),
      O => \All_INTR_Bits[1].Using_CIMR.cimr[1]_i_2_n_0\
    );
\All_INTR_Bits[1].Using_CIMR.cimr_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \All_INTR_Bits[1].Using_CIMR.cimr[1]_i_1_n_0\,
      Q => cimr(1),
      R => Rst
    );
\All_INTR_Bits[1].Using_Intr.cier[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFBFF00000800"
    )
        port map (
      I0 => \out\(0),
      I1 => \All_INTR_Bits[1].Using_Intr.cisr[1]_i_2_n_0\,
      I2 => Q(0),
      I3 => Q(1),
      I4 => Q(4),
      I5 => cier(1),
      O => \All_INTR_Bits[1].Using_Intr.cier[1]_i_1_n_0\
    );
\All_INTR_Bits[1].Using_Intr.cier_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \All_INTR_Bits[1].Using_Intr.cier[1]_i_1_n_0\,
      Q => cier(1),
      R => Rst
    );
\All_INTR_Bits[1].Using_Intr.cisr[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF7F000000"
    )
        port map (
      I0 => \out\(0),
      I1 => \All_INTR_Bits[1].Using_Intr.cisr[1]_i_2_n_0\,
      I2 => \All_INTR_Bits[1].Using_Intr.cisr[1]_i_3_n_0\,
      I3 => cisr(1),
      I4 => \All_INTR_Bits[1].Using_Intr.cisr[1]_i_4_n_0\,
      I5 => data_is_sent_reg,
      O => \All_INTR_Bits[1].Using_Intr.cisr[1]_i_1_n_0\
    );
\All_INTR_Bits[1].Using_Intr.cisr[1]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => Q(5),
      I1 => lmb_reg_write,
      I2 => Q(2),
      I3 => Q(3),
      O => \All_INTR_Bits[1].Using_Intr.cisr[1]_i_2_n_0\
    );
\All_INTR_Bits[1].Using_Intr.cisr[1]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => Q(4),
      I1 => Q(1),
      I2 => Q(0),
      O => \All_INTR_Bits[1].Using_Intr.cisr[1]_i_3_n_0\
    );
\All_INTR_Bits[1].Using_Intr.cisr[1]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000FFDF"
    )
        port map (
      I0 => \Using_Fast.civr_reg_n_0_[0]\,
      I1 => \Using_Fast.civr_reg_n_0_[1]\,
      I2 => do_fast_ack,
      I3 => \Using_Fast.civr_reg_n_0_[4]\,
      I4 => Rst,
      O => \All_INTR_Bits[1].Using_Intr.cisr[1]_i_4_n_0\
    );
\All_INTR_Bits[1].Using_Intr.cisr_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \All_INTR_Bits[1].Using_Intr.cisr[1]_i_1_n_0\,
      Q => cisr(1),
      R => '0'
    );
\All_INTR_Bits[2].Using_CIMR.cimr[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFBFFF00008000"
    )
        port map (
      I0 => \out\(1),
      I1 => \All_INTR_Bits[1].Using_CIMR.cimr[1]_i_2_n_0\,
      I2 => Q(0),
      I3 => Q(1),
      I4 => Q(4),
      I5 => cimr(2),
      O => \All_INTR_Bits[2].Using_CIMR.cimr[2]_i_1_n_0\
    );
\All_INTR_Bits[2].Using_CIMR.cimr_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \All_INTR_Bits[2].Using_CIMR.cimr[2]_i_1_n_0\,
      Q => cimr(2),
      R => Rst
    );
\All_INTR_Bits[2].Using_Intr.cier[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFBFF00000800"
    )
        port map (
      I0 => \out\(1),
      I1 => \All_INTR_Bits[1].Using_Intr.cisr[1]_i_2_n_0\,
      I2 => Q(0),
      I3 => Q(1),
      I4 => Q(4),
      I5 => cier(2),
      O => \All_INTR_Bits[2].Using_Intr.cier[2]_i_1_n_0\
    );
\All_INTR_Bits[2].Using_Intr.cier_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \All_INTR_Bits[2].Using_Intr.cier[2]_i_1_n_0\,
      Q => cier(2),
      R => Rst
    );
\All_INTR_Bits[2].Using_Intr.cisr[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF7F000000"
    )
        port map (
      I0 => \out\(1),
      I1 => \All_INTR_Bits[1].Using_Intr.cisr[1]_i_2_n_0\,
      I2 => \All_INTR_Bits[1].Using_Intr.cisr[1]_i_3_n_0\,
      I3 => cisr(2),
      I4 => \All_INTR_Bits[2].Using_Intr.cisr[2]_i_2_n_0\,
      I5 => new_rx_data_write_reg,
      O => p_6_out7_out
    );
\All_INTR_Bits[2].Using_Intr.cisr[2]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000FFDF"
    )
        port map (
      I0 => \Using_Fast.civr_reg_n_0_[1]\,
      I1 => \Using_Fast.civr_reg_n_0_[0]\,
      I2 => do_fast_ack,
      I3 => \Using_Fast.civr_reg_n_0_[4]\,
      I4 => Rst,
      O => \All_INTR_Bits[2].Using_Intr.cisr[2]_i_2_n_0\
    );
\All_INTR_Bits[2].Using_Intr.cisr_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => p_6_out7_out,
      Q => cisr(2),
      R => '0'
    );
\INTC_CISR[16]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => cisr(16),
      I1 => \INTC_CISR[16]_i_2_n_0\,
      O => \INTC_CISR[16]_i_1_n_0\
    );
\INTC_CISR[16]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFFFFFFFFFFFFFF"
    )
        port map (
      I0 => Q(4),
      I1 => Q(1),
      I2 => Q(0),
      I3 => Q(3),
      I4 => Q(2),
      I5 => lmb_reg_read,
      O => \INTC_CISR[16]_i_2_n_0\
    );
\INTC_CISR[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => cisr(1),
      I1 => \INTC_CISR[16]_i_2_n_0\,
      O => \INTC_CISR[1]_i_1_n_0\
    );
\INTC_CISR[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => cisr(2),
      I1 => \INTC_CISR[16]_i_2_n_0\,
      O => \INTC_CISR[2]_i_1_n_0\
    );
\INTC_CISR_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \INTC_CISR[16]_i_1_n_0\,
      Q => INTC_CISR(16),
      R => '0'
    );
\INTC_CISR_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \INTC_CISR[1]_i_1_n_0\,
      Q => INTC_CISR(1),
      R => '0'
    );
\INTC_CISR_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \INTC_CISR[2]_i_1_n_0\,
      Q => INTC_CISR(2),
      R => '0'
    );
\Sl_DBus[15]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => io_bus_read_data(2),
      I1 => INTC_CIPR(16),
      I2 => INTC_CISR(16),
      O => Sl_DBus(2)
    );
\Sl_DBus[29]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => io_bus_read_data(1),
      I1 => \RX_Data_reg[2]\(1),
      I2 => INTC_CIPR(2),
      I3 => INTC_CISR(2),
      O => Sl_DBus(1)
    );
\Sl_DBus[30]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => io_bus_read_data(0),
      I1 => \RX_Data_reg[2]\(0),
      I2 => INTC_CIPR(1),
      I3 => INTC_CISR(1),
      O => Sl_DBus(0)
    );
\Using_Fast.INTC_IRQ_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4404"
    )
        port map (
      I0 => \Using_Fast.fast_state_reg_n_0_[1]\,
      I1 => \Using_Fast.fast_state_reg_n_0_[0]\,
      I2 => INTC_Processor_Ack(0),
      I3 => INTC_Processor_Ack(1),
      O => \Using_Fast.INTC_IRQ_i_1_n_0\
    );
\Using_Fast.INTC_IRQ_reg\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \Using_Fast.INTC_IRQ_i_1_n_0\,
      Q => INTC_IRQ,
      R => Rst
    );
\Using_Fast.Using_LUTRAM.civar[0][14]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000080"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar[0][14]_i_2_n_0\,
      I1 => Q(5),
      I2 => lmb_reg_write,
      I3 => Q(3),
      I4 => Q(2),
      O => \civar[0]_3\
    );
\Using_Fast.Using_LUTRAM.civar[0][14]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => Q(4),
      I1 => Q(1),
      I2 => Q(0),
      O => \Using_Fast.Using_LUTRAM.civar[0][14]_i_2_n_0\
    );
\Using_Fast.Using_LUTRAM.civar[16][14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"10"
    )
        port map (
      I0 => Q(1),
      I1 => Q(0),
      I2 => \Using_Fast.Using_LUTRAM.civar[19][14]_i_2_n_0\,
      O => \civar[16]_4\
    );
\Using_Fast.Using_LUTRAM.civar[17][14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => Q(1),
      I1 => Q(0),
      I2 => \Using_Fast.Using_LUTRAM.civar[19][14]_i_2_n_0\,
      O => \civar[17]_5\
    );
\Using_Fast.Using_LUTRAM.civar[18][14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => Q(0),
      I1 => Q(1),
      I2 => \Using_Fast.Using_LUTRAM.civar[19][14]_i_2_n_0\,
      O => \civar[18]_6\
    );
\Using_Fast.Using_LUTRAM.civar[19][14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => Q(1),
      I1 => Q(0),
      I2 => \Using_Fast.Using_LUTRAM.civar[19][14]_i_2_n_0\,
      O => \civar[19]_7\
    );
\Using_Fast.Using_LUTRAM.civar[19][14]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00080000"
    )
        port map (
      I0 => Q(5),
      I1 => lmb_reg_write,
      I2 => Q(3),
      I3 => Q(2),
      I4 => Q(4),
      O => \Using_Fast.Using_LUTRAM.civar[19][14]_i_2_n_0\
    );
\Using_Fast.Using_LUTRAM.civar[1][14]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0008"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar[3][14]_i_2_n_0\,
      I1 => Q(0),
      I2 => Q(1),
      I3 => Q(2),
      O => \civar[1]_1\
    );
\Using_Fast.Using_LUTRAM.civar[2][14]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0020"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar[3][14]_i_2_n_0\,
      I1 => Q(0),
      I2 => Q(1),
      I3 => Q(2),
      O => \civar[2]_2\
    );
\Using_Fast.Using_LUTRAM.civar[3][14]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar[3][14]_i_2_n_0\,
      I1 => Q(0),
      I2 => Q(1),
      I3 => Q(2),
      O => \civar[3]_0\
    );
\Using_Fast.Using_LUTRAM.civar[3][14]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0008"
    )
        port map (
      I0 => lmb_reg_write,
      I1 => Q(5),
      I2 => Q(4),
      I3 => Q(3),
      O => \Using_Fast.Using_LUTRAM.civar[3][14]_i_2_n_0\
    );
\Using_Fast.Using_LUTRAM.civar_reg[0][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[0]_3\,
      D => \out\(1),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[0]\(0),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[0][10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[0]_3\,
      D => \out\(11),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[0]\(10),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[0][11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[0]_3\,
      D => \out\(12),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[0]\(11),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[0][12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[0]_3\,
      D => \out\(13),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[0]\(12),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[0][13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[0]_3\,
      D => \out\(14),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[0]\(13),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[0][14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[0]_3\,
      D => \out\(15),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[0]\(14),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[0][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[0]_3\,
      D => \out\(2),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[0]\(1),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[0][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => Clk,
      CE => \civar[0]_3\,
      D => \out\(3),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[0]\(2),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[0][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[0]_3\,
      D => \out\(4),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[0]\(3),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[0][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[0]_3\,
      D => \out\(5),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[0]\(4),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[0][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[0]_3\,
      D => \out\(6),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[0]\(5),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[0][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[0]_3\,
      D => \out\(7),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[0]\(6),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[0][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[0]_3\,
      D => \out\(8),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[0]\(7),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[0][8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[0]_3\,
      D => \out\(9),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[0]\(8),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[0][9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[0]_3\,
      D => \out\(10),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[0]\(9),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[16][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[16]_4\,
      D => \out\(1),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[16]\(0),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[16][10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[16]_4\,
      D => \out\(11),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[16]\(10),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[16][11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[16]_4\,
      D => \out\(12),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[16]\(11),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[16][12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[16]_4\,
      D => \out\(13),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[16]\(12),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[16][13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[16]_4\,
      D => \out\(14),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[16]\(13),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[16][14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[16]_4\,
      D => \out\(15),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[16]\(14),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[16][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[16]_4\,
      D => \out\(2),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[16]\(1),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[16][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => Clk,
      CE => \civar[16]_4\,
      D => \out\(3),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[16]\(2),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[16][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[16]_4\,
      D => \out\(4),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[16]\(3),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[16][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[16]_4\,
      D => \out\(5),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[16]\(4),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[16][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[16]_4\,
      D => \out\(6),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[16]\(5),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[16][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[16]_4\,
      D => \out\(7),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[16]\(6),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[16][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[16]_4\,
      D => \out\(8),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[16]\(7),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[16][8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[16]_4\,
      D => \out\(9),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[16]\(8),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[16][9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[16]_4\,
      D => \out\(10),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[16]\(9),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[17][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[17]_5\,
      D => \out\(1),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[17]\(0),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[17][10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[17]_5\,
      D => \out\(11),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[17]\(10),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[17][11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[17]_5\,
      D => \out\(12),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[17]\(11),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[17][12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[17]_5\,
      D => \out\(13),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[17]\(12),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[17][13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[17]_5\,
      D => \out\(14),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[17]\(13),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[17][14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[17]_5\,
      D => \out\(15),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[17]\(14),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[17][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[17]_5\,
      D => \out\(2),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[17]\(1),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[17][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => Clk,
      CE => \civar[17]_5\,
      D => \out\(3),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[17]\(2),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[17][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[17]_5\,
      D => \out\(4),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[17]\(3),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[17][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[17]_5\,
      D => \out\(5),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[17]\(4),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[17][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[17]_5\,
      D => \out\(6),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[17]\(5),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[17][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[17]_5\,
      D => \out\(7),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[17]\(6),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[17][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[17]_5\,
      D => \out\(8),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[17]\(7),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[17][8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[17]_5\,
      D => \out\(9),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[17]\(8),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[17][9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[17]_5\,
      D => \out\(10),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[17]\(9),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[18][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[18]_6\,
      D => \out\(1),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[18]\(0),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[18][10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[18]_6\,
      D => \out\(11),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[18]\(10),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[18][11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[18]_6\,
      D => \out\(12),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[18]\(11),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[18][12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[18]_6\,
      D => \out\(13),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[18]\(12),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[18][13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[18]_6\,
      D => \out\(14),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[18]\(13),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[18][14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[18]_6\,
      D => \out\(15),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[18]\(14),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[18][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[18]_6\,
      D => \out\(2),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[18]\(1),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[18][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => Clk,
      CE => \civar[18]_6\,
      D => \out\(3),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[18]\(2),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[18][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[18]_6\,
      D => \out\(4),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[18]\(3),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[18][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[18]_6\,
      D => \out\(5),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[18]\(4),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[18][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[18]_6\,
      D => \out\(6),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[18]\(5),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[18][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[18]_6\,
      D => \out\(7),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[18]\(6),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[18][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[18]_6\,
      D => \out\(8),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[18]\(7),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[18][8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[18]_6\,
      D => \out\(9),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[18]\(8),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[18][9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[18]_6\,
      D => \out\(10),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[18]\(9),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[19][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[19]_7\,
      D => \out\(1),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[19]\(0),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[19][10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[19]_7\,
      D => \out\(11),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[19]\(10),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[19][11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[19]_7\,
      D => \out\(12),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[19]\(11),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[19][12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[19]_7\,
      D => \out\(13),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[19]\(12),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[19][13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[19]_7\,
      D => \out\(14),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[19]\(13),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[19][14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[19]_7\,
      D => \out\(15),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[19]\(14),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[19][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[19]_7\,
      D => \out\(2),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[19]\(1),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[19][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => Clk,
      CE => \civar[19]_7\,
      D => \out\(3),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[19]\(2),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[19][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[19]_7\,
      D => \out\(4),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[19]\(3),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[19][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[19]_7\,
      D => \out\(5),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[19]\(4),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[19][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[19]_7\,
      D => \out\(6),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[19]\(5),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[19][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[19]_7\,
      D => \out\(7),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[19]\(6),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[19][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[19]_7\,
      D => \out\(8),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[19]\(7),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[19][8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[19]_7\,
      D => \out\(9),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[19]\(8),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[19][9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[19]_7\,
      D => \out\(10),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[19]\(9),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[1][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[1]_1\,
      D => \out\(1),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[1]\(0),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[1][10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[1]_1\,
      D => \out\(11),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[1]\(10),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[1][11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[1]_1\,
      D => \out\(12),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[1]\(11),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[1][12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[1]_1\,
      D => \out\(13),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[1]\(12),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[1][13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[1]_1\,
      D => \out\(14),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[1]\(13),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[1][14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[1]_1\,
      D => \out\(15),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[1]\(14),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[1][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[1]_1\,
      D => \out\(2),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[1]\(1),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[1][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => Clk,
      CE => \civar[1]_1\,
      D => \out\(3),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[1]\(2),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[1][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[1]_1\,
      D => \out\(4),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[1]\(3),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[1][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[1]_1\,
      D => \out\(5),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[1]\(4),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[1][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[1]_1\,
      D => \out\(6),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[1]\(5),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[1][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[1]_1\,
      D => \out\(7),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[1]\(6),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[1][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[1]_1\,
      D => \out\(8),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[1]\(7),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[1][8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[1]_1\,
      D => \out\(9),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[1]\(8),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[1][9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[1]_1\,
      D => \out\(10),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[1]\(9),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[2][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[2]_2\,
      D => \out\(1),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[2]\(0),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[2][10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[2]_2\,
      D => \out\(11),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[2]\(10),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[2][11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[2]_2\,
      D => \out\(12),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[2]\(11),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[2][12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[2]_2\,
      D => \out\(13),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[2]\(12),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[2][13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[2]_2\,
      D => \out\(14),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[2]\(13),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[2][14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[2]_2\,
      D => \out\(15),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[2]\(14),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[2][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[2]_2\,
      D => \out\(2),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[2]\(1),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[2][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => Clk,
      CE => \civar[2]_2\,
      D => \out\(3),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[2]\(2),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[2][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[2]_2\,
      D => \out\(4),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[2]\(3),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[2][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[2]_2\,
      D => \out\(5),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[2]\(4),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[2][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[2]_2\,
      D => \out\(6),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[2]\(5),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[2][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[2]_2\,
      D => \out\(7),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[2]\(6),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[2][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[2]_2\,
      D => \out\(8),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[2]\(7),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[2][8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[2]_2\,
      D => \out\(9),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[2]\(8),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[2][9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[2]_2\,
      D => \out\(10),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[2]\(9),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[3][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[3]_0\,
      D => \out\(1),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[3]\(0),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[3][10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[3]_0\,
      D => \out\(11),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[3]\(10),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[3][11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[3]_0\,
      D => \out\(12),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[3]\(11),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[3][12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[3]_0\,
      D => \out\(13),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[3]\(12),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[3][13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[3]_0\,
      D => \out\(14),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[3]\(13),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[3][14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[3]_0\,
      D => \out\(15),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[3]\(14),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[3][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[3]_0\,
      D => \out\(2),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[3]\(1),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[3][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => Clk,
      CE => \civar[3]_0\,
      D => \out\(3),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[3]\(2),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[3][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[3]_0\,
      D => \out\(4),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[3]\(3),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[3][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[3]_0\,
      D => \out\(5),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[3]\(4),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[3][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[3]_0\,
      D => \out\(6),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[3]\(5),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[3][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[3]_0\,
      D => \out\(7),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[3]\(6),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[3][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[3]_0\,
      D => \out\(8),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[3]\(7),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[3][8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[3]_0\,
      D => \out\(9),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[3]\(8),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.civar_reg[3][9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \civar[3]_0\,
      D => \out\(10),
      Q => \Using_Fast.Using_LUTRAM.civar_reg[3]\(9),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[1]\(0),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[3]\(0),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[0]\(0),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[2]\(0),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[0]_i_2_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[17]\(0),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[19]\(0),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[16]\(0),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[18]\(0),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[0]_i_3_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[10]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[1]\(10),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[3]\(10),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[0]\(10),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[2]\(10),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[10]_i_2_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[10]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[17]\(10),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[19]\(10),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[16]\(10),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[18]\(10),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[10]_i_3_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[11]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[1]\(11),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[3]\(11),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[0]\(11),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[2]\(11),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[11]_i_2_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[11]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[17]\(11),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[19]\(11),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[16]\(11),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[18]\(11),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[11]_i_3_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[12]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[1]\(12),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[3]\(12),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[0]\(12),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[2]\(12),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[12]_i_2_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[12]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[17]\(12),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[19]\(12),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[16]\(12),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[18]\(12),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[12]_i_3_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[13]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[1]\(13),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[3]\(13),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[0]\(13),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[2]\(13),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[13]_i_2_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[13]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[17]\(13),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[19]\(13),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[16]\(13),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[18]\(13),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[13]_i_3_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[14]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[1]\(14),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[3]\(14),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[0]\(14),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[2]\(14),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[14]_i_2_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[14]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[17]\(14),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[19]\(14),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[16]\(14),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[18]\(14),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[14]_i_3_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[1]\(1),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[3]\(1),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[0]\(1),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[2]\(1),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[1]_i_2_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[17]\(1),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[19]\(1),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[16]\(1),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[18]\(1),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[1]_i_3_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[1]\(2),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[3]\(2),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[0]\(2),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[2]\(2),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[2]_i_2_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[17]\(2),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[19]\(2),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[16]\(2),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[18]\(2),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[2]_i_3_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[1]\(3),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[3]\(3),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[0]\(3),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[2]\(3),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[3]_i_2_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[3]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[17]\(3),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[19]\(3),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[16]\(3),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[18]\(3),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[3]_i_3_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[1]\(4),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[3]\(4),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[0]\(4),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[2]\(4),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[4]_i_2_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[4]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[17]\(4),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[19]\(4),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[16]\(4),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[18]\(4),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[4]_i_3_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[1]\(5),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[3]\(5),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[0]\(5),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[2]\(5),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[5]_i_2_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[5]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[17]\(5),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[19]\(5),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[16]\(5),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[18]\(5),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[5]_i_3_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[6]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[1]\(6),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[3]\(6),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[0]\(6),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[2]\(6),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[6]_i_2_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[6]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[17]\(6),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[19]\(6),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[16]\(6),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[18]\(6),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[6]_i_3_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[1]\(7),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[3]\(7),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[0]\(7),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[2]\(7),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[7]_i_2_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[7]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[17]\(7),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[19]\(7),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[16]\(7),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[18]\(7),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[7]_i_3_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[8]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[1]\(8),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[3]\(8),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[0]\(8),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[2]\(8),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[8]_i_2_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[8]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[17]\(8),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[19]\(8),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[16]\(8),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[18]\(8),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[8]_i_3_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[9]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[1]\(9),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[3]\(9),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[0]\(9),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[2]\(9),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[9]_i_2_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i[9]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CAFFCAF0CA0FCA00"
    )
        port map (
      I0 => \Using_Fast.Using_LUTRAM.civar_reg[17]\(9),
      I1 => \Using_Fast.Using_LUTRAM.civar_reg[19]\(9),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => \Using_Fast.Using_LUTRAM.civar_reg[16]\(9),
      I5 => \Using_Fast.Using_LUTRAM.civar_reg[18]\(9),
      O => \Using_Fast.Using_LUTRAM.intr_addr_i[9]_i_3_n_0\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \civar[31]_8\(0),
      Q => INTC_Interrupt_Address(0),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[0]_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \Using_Fast.Using_LUTRAM.intr_addr_i[0]_i_2_n_0\,
      I1 => \Using_Fast.Using_LUTRAM.intr_addr_i[0]_i_3_n_0\,
      O => \civar[31]_8\(0),
      S => \Using_Fast.civr_reg_n_0_[4]\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \civar[31]_8\(10),
      Q => INTC_Interrupt_Address(10),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[10]_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \Using_Fast.Using_LUTRAM.intr_addr_i[10]_i_2_n_0\,
      I1 => \Using_Fast.Using_LUTRAM.intr_addr_i[10]_i_3_n_0\,
      O => \civar[31]_8\(10),
      S => \Using_Fast.civr_reg_n_0_[4]\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \civar[31]_8\(11),
      Q => INTC_Interrupt_Address(11),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[11]_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \Using_Fast.Using_LUTRAM.intr_addr_i[11]_i_2_n_0\,
      I1 => \Using_Fast.Using_LUTRAM.intr_addr_i[11]_i_3_n_0\,
      O => \civar[31]_8\(11),
      S => \Using_Fast.civr_reg_n_0_[4]\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \civar[31]_8\(12),
      Q => INTC_Interrupt_Address(12),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[12]_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \Using_Fast.Using_LUTRAM.intr_addr_i[12]_i_2_n_0\,
      I1 => \Using_Fast.Using_LUTRAM.intr_addr_i[12]_i_3_n_0\,
      O => \civar[31]_8\(12),
      S => \Using_Fast.civr_reg_n_0_[4]\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \civar[31]_8\(13),
      Q => INTC_Interrupt_Address(13),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[13]_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \Using_Fast.Using_LUTRAM.intr_addr_i[13]_i_2_n_0\,
      I1 => \Using_Fast.Using_LUTRAM.intr_addr_i[13]_i_3_n_0\,
      O => \civar[31]_8\(13),
      S => \Using_Fast.civr_reg_n_0_[4]\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \civar[31]_8\(14),
      Q => INTC_Interrupt_Address(14),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[14]_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \Using_Fast.Using_LUTRAM.intr_addr_i[14]_i_2_n_0\,
      I1 => \Using_Fast.Using_LUTRAM.intr_addr_i[14]_i_3_n_0\,
      O => \civar[31]_8\(14),
      S => \Using_Fast.civr_reg_n_0_[4]\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \civar[31]_8\(1),
      Q => INTC_Interrupt_Address(1),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[1]_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \Using_Fast.Using_LUTRAM.intr_addr_i[1]_i_2_n_0\,
      I1 => \Using_Fast.Using_LUTRAM.intr_addr_i[1]_i_3_n_0\,
      O => \civar[31]_8\(1),
      S => \Using_Fast.civr_reg_n_0_[4]\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \civar[31]_8\(2),
      Q => INTC_Interrupt_Address(2),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[2]_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \Using_Fast.Using_LUTRAM.intr_addr_i[2]_i_2_n_0\,
      I1 => \Using_Fast.Using_LUTRAM.intr_addr_i[2]_i_3_n_0\,
      O => \civar[31]_8\(2),
      S => \Using_Fast.civr_reg_n_0_[4]\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \civar[31]_8\(3),
      Q => INTC_Interrupt_Address(3),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[3]_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \Using_Fast.Using_LUTRAM.intr_addr_i[3]_i_2_n_0\,
      I1 => \Using_Fast.Using_LUTRAM.intr_addr_i[3]_i_3_n_0\,
      O => \civar[31]_8\(3),
      S => \Using_Fast.civr_reg_n_0_[4]\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \civar[31]_8\(4),
      Q => INTC_Interrupt_Address(4),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[4]_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \Using_Fast.Using_LUTRAM.intr_addr_i[4]_i_2_n_0\,
      I1 => \Using_Fast.Using_LUTRAM.intr_addr_i[4]_i_3_n_0\,
      O => \civar[31]_8\(4),
      S => \Using_Fast.civr_reg_n_0_[4]\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \civar[31]_8\(5),
      Q => INTC_Interrupt_Address(5),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[5]_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \Using_Fast.Using_LUTRAM.intr_addr_i[5]_i_2_n_0\,
      I1 => \Using_Fast.Using_LUTRAM.intr_addr_i[5]_i_3_n_0\,
      O => \civar[31]_8\(5),
      S => \Using_Fast.civr_reg_n_0_[4]\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \civar[31]_8\(6),
      Q => INTC_Interrupt_Address(6),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[6]_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \Using_Fast.Using_LUTRAM.intr_addr_i[6]_i_2_n_0\,
      I1 => \Using_Fast.Using_LUTRAM.intr_addr_i[6]_i_3_n_0\,
      O => \civar[31]_8\(6),
      S => \Using_Fast.civr_reg_n_0_[4]\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \civar[31]_8\(7),
      Q => INTC_Interrupt_Address(7),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[7]_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \Using_Fast.Using_LUTRAM.intr_addr_i[7]_i_2_n_0\,
      I1 => \Using_Fast.Using_LUTRAM.intr_addr_i[7]_i_3_n_0\,
      O => \civar[31]_8\(7),
      S => \Using_Fast.civr_reg_n_0_[4]\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \civar[31]_8\(8),
      Q => INTC_Interrupt_Address(8),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[8]_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \Using_Fast.Using_LUTRAM.intr_addr_i[8]_i_2_n_0\,
      I1 => \Using_Fast.Using_LUTRAM.intr_addr_i[8]_i_3_n_0\,
      O => \civar[31]_8\(8),
      S => \Using_Fast.civr_reg_n_0_[4]\
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \civar[31]_8\(9),
      Q => INTC_Interrupt_Address(9),
      R => '0'
    );
\Using_Fast.Using_LUTRAM.intr_addr_i_reg[9]_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \Using_Fast.Using_LUTRAM.intr_addr_i[9]_i_2_n_0\,
      I1 => \Using_Fast.Using_LUTRAM.intr_addr_i[9]_i_3_n_0\,
      O => \civar[31]_8\(9),
      S => \Using_Fast.civr_reg_n_0_[4]\
    );
\Using_Fast.civr[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FEEE1000"
    )
        port map (
      I0 => \Using_Fast.fast_state_reg_n_0_[0]\,
      I1 => \Using_Fast.fast_state_reg_n_0_[1]\,
      I2 => cier(1),
      I3 => cisr(1),
      I4 => \Using_Fast.civr_reg_n_0_[0]\,
      O => \Using_Fast.civr[0]_i_1_n_0\
    );
\Using_Fast.civr[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFF0700000007"
    )
        port map (
      I0 => cier(1),
      I1 => cisr(1),
      I2 => \byte_zeros__1\(0),
      I3 => \Using_Fast.fast_state_reg_n_0_[0]\,
      I4 => \Using_Fast.fast_state_reg_n_0_[1]\,
      I5 => \Using_Fast.civr_reg_n_0_[1]\,
      O => \Using_Fast.civr[1]_i_1_n_0\
    );
\Using_Fast.civr[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFF8000000080"
    )
        port map (
      I0 => cier(16),
      I1 => cisr(16),
      I2 => \byte_zeros__1\(0),
      I3 => \Using_Fast.fast_state_reg_n_0_[0]\,
      I4 => \Using_Fast.fast_state_reg_n_0_[1]\,
      I5 => \Using_Fast.civr_reg_n_0_[4]\,
      O => \Using_Fast.civr[4]_i_1_n_0\
    );
\Using_Fast.civr_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \Using_Fast.civr[0]_i_1_n_0\,
      Q => \Using_Fast.civr_reg_n_0_[0]\,
      R => Rst
    );
\Using_Fast.civr_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \Using_Fast.civr[1]_i_1_n_0\,
      Q => \Using_Fast.civr_reg_n_0_[1]\,
      R => Rst
    );
\Using_Fast.civr_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \Using_Fast.civr[4]_i_1_n_0\,
      Q => \Using_Fast.civr_reg_n_0_[4]\,
      R => Rst
    );
\Using_Fast.do_fast_ack_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2020040000000000"
    )
        port map (
      I0 => INTC_Processor_Ack(1),
      I1 => \Using_Fast.fast_state_reg_n_0_[0]\,
      I2 => \Using_Fast.fast_state_reg_n_0_[1]\,
      I3 => INTC_Processor_Ack(0),
      I4 => \Using_Fast.civr_reg_n_0_[4]\,
      I5 => \has_fast__5\,
      O => \Using_Fast.do_fast_ack_i_1_n_0\
    );
\Using_Fast.do_fast_ack_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000A000A0CF00C00"
    )
        port map (
      I0 => cimr(16),
      I1 => cimr(1),
      I2 => \Using_Fast.civr_reg_n_0_[1]\,
      I3 => \Using_Fast.civr_reg_n_0_[0]\,
      I4 => cimr(2),
      I5 => \Using_Fast.civr_reg_n_0_[4]\,
      O => \has_fast__5\
    );
\Using_Fast.do_fast_ack_reg\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \Using_Fast.do_fast_ack_i_1_n_0\,
      Q => do_fast_ack,
      R => Rst
    );
\Using_Fast.fast_state[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F0FFDFD00000DFD"
    )
        port map (
      I0 => \byte_zeros__1\(0),
      I1 => D35_out,
      I2 => \Using_Fast.fast_state_reg_n_0_[0]\,
      I3 => INTC_Processor_Ack(0),
      I4 => \Using_Fast.fast_state_reg_n_0_[1]\,
      I5 => INTC_Processor_Ack(1),
      O => \Using_Fast.fast_state[0]_i_1_n_0\
    );
\Using_Fast.fast_state[0]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0777"
    )
        port map (
      I0 => cier(1),
      I1 => cisr(1),
      I2 => cier(2),
      I3 => cisr(2),
      O => \byte_zeros__1\(0)
    );
\Using_Fast.fast_state[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5058"
    )
        port map (
      I0 => \Using_Fast.fast_state_reg_n_0_[0]\,
      I1 => INTC_Processor_Ack(0),
      I2 => \Using_Fast.fast_state_reg_n_0_[1]\,
      I3 => INTC_Processor_Ack(1),
      O => \Using_Fast.fast_state[1]_i_1_n_0\
    );
\Using_Fast.fast_state_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \Using_Fast.fast_state[0]_i_1_n_0\,
      Q => \Using_Fast.fast_state_reg_n_0_[0]\,
      R => Rst
    );
\Using_Fast.fast_state_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \Using_Fast.fast_state[1]_i_1_n_0\,
      Q => \Using_Fast.fast_state_reg_n_0_[1]\,
      R => Rst
    );
\cipr_rd_dff_all[16].fdr_i\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => '1',
      D => D35_out,
      Q => INTC_CIPR(16),
      R => R
    );
\cipr_rd_dff_all[16].fdr_i_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => cisr(16),
      I1 => cier(16),
      O => D35_out
    );
\cipr_rd_dff_all[1].fdr_i\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => '1',
      D => D,
      Q => INTC_CIPR(1),
      R => R
    );
\cipr_rd_dff_all[1].fdr_i_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFFFFFFFFFFFFFFF"
    )
        port map (
      I0 => Q(4),
      I1 => Q(1),
      I2 => Q(0),
      I3 => Q(3),
      I4 => Q(2),
      I5 => lmb_reg_read,
      O => R
    );
\cipr_rd_dff_all[1].fdr_i_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => cisr(1),
      I1 => cier(1),
      O => D
    );
\cipr_rd_dff_all[2].fdr_i\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => '1',
      D => D25_out,
      Q => INTC_CIPR(2),
      R => R
    );
\cipr_rd_dff_all[2].fdr_i_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => cisr(2),
      I1 => cier(2),
      O => D25_out
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_fc5c_iomodule_0_0_Divide_part is
  port (
    Clk_En_I_1 : out STD_LOGIC;
    Clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of bd_fc5c_iomodule_0_0_Divide_part : entity is "Divide_part";
end bd_fc5c_iomodule_0_0_Divide_part;

architecture STRUCTURE of bd_fc5c_iomodule_0_0_Divide_part is
begin
\One_SRL16.SRL16E_I\: entity work.bd_fc5c_iomodule_0_0_XIL_SRL16E_1
     port map (
      Clk => Clk,
      Clk_En_I_1 => Clk_En_I_1
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \bd_fc5c_iomodule_0_0_Divide_part__parameterized0\ is
  port (
    en_16x_baud : out STD_LOGIC;
    Clk_En_I_1 : in STD_LOGIC;
    Clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \bd_fc5c_iomodule_0_0_Divide_part__parameterized0\ : entity is "Divide_part";
end \bd_fc5c_iomodule_0_0_Divide_part__parameterized0\;

architecture STRUCTURE of \bd_fc5c_iomodule_0_0_Divide_part__parameterized0\ is
  signal loop_Bit : STD_LOGIC;
  signal \not_First.Out1_reg_n_0\ : STD_LOGIC;
begin
\One_SRL16.SRL16E_I\: entity work.bd_fc5c_iomodule_0_0_XIL_SRL16E_0
     port map (
      Clk => Clk,
      Clk_En_I_1 => Clk_En_I_1,
      loop_Bit => loop_Bit
    );
\not_First.Clk_En_Out_i_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => \not_First.Out1_reg_n_0\,
      D => Clk_En_I_1,
      Q => en_16x_baud,
      R => '0'
    );
\not_First.Out1_reg\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => loop_Bit,
      Q => \not_First.Out1_reg_n_0\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \bd_fc5c_iomodule_0_0_Divide_part__parameterized1\ is
  port (
    Clk_En_I_2 : out STD_LOGIC;
    Clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \bd_fc5c_iomodule_0_0_Divide_part__parameterized1\ : entity is "Divide_part";
end \bd_fc5c_iomodule_0_0_Divide_part__parameterized1\;

architecture STRUCTURE of \bd_fc5c_iomodule_0_0_Divide_part__parameterized1\ is
begin
\One_SRL16.SRL16E_I\: entity work.bd_fc5c_iomodule_0_0_XIL_SRL16E_3
     port map (
      Clk => Clk,
      Clk_En_I_2 => Clk_En_I_2
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \bd_fc5c_iomodule_0_0_Divide_part__parameterized2\ is
  port (
    Clk_En_I_1 : out STD_LOGIC;
    Clk_En_I_2 : in STD_LOGIC;
    Clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \bd_fc5c_iomodule_0_0_Divide_part__parameterized2\ : entity is "Divide_part";
end \bd_fc5c_iomodule_0_0_Divide_part__parameterized2\;

architecture STRUCTURE of \bd_fc5c_iomodule_0_0_Divide_part__parameterized2\ is
  signal Out1 : STD_LOGIC;
  signal loop_Bit : STD_LOGIC;
begin
\One_SRL16.SRL16E_I\: entity work.bd_fc5c_iomodule_0_0_XIL_SRL16E_2
     port map (
      Clk => Clk,
      Clk_En_I_2 => Clk_En_I_2,
      loop_Bit => loop_Bit
    );
\not_First.Clk_En_Out_i_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => Out1,
      D => Clk_En_I_2,
      Q => Clk_En_I_1,
      R => '0'
    );
\not_First.Out1_reg\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => loop_Bit,
      Q => Out1,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \bd_fc5c_iomodule_0_0_Divide_part__parameterized3\ is
  port (
    FIT1_Interrupt : out STD_LOGIC;
    \Implement_FIT.toggle_i_reg\ : out STD_LOGIC;
    Clk_En_I_1 : in STD_LOGIC;
    Clk : in STD_LOGIC;
    FIT1_Toggle : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \bd_fc5c_iomodule_0_0_Divide_part__parameterized3\ : entity is "Divide_part";
end \bd_fc5c_iomodule_0_0_Divide_part__parameterized3\;

architecture STRUCTURE of \bd_fc5c_iomodule_0_0_Divide_part__parameterized3\ is
  signal \^fit1_interrupt\ : STD_LOGIC;
  signal loop_Bit : STD_LOGIC;
  signal \not_First.Clk_En_Out_i_i_1_n_0\ : STD_LOGIC;
  signal \not_First.Out1_reg_n_0\ : STD_LOGIC;
  signal shifts_0 : STD_LOGIC;
  signal shifts_1 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \Implement_FIT.toggle_i_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \not_First.Clk_En_Out_i_i_1\ : label is "soft_lutpair0";
begin
  FIT1_Interrupt <= \^fit1_interrupt\;
\Implement_FIT.toggle_i_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^fit1_interrupt\,
      I1 => FIT1_Toggle,
      O => \Implement_FIT.toggle_i_reg\
    );
\More_Than_Two.SRL16E_n\: entity work.\bd_fc5c_iomodule_0_0_XIL_SRL16E__parameterized9\
     port map (
      Clk => Clk,
      Clk_En_I_1 => Clk_En_I_1,
      loop_Bit => loop_Bit,
      shifts_0 => shifts_0
    );
\More_Than_Two.SRLC16E_1\: entity work.bd_fc5c_iomodule_0_0_XIL_SRLC16E
     port map (
      Clk => Clk,
      Clk_En_I_1 => Clk_En_I_1,
      loop_Bit => loop_Bit,
      shifts_1 => shifts_1
    );
\More_Than_Two.The_Rest[1].SRLC16E_I\: entity work.\bd_fc5c_iomodule_0_0_XIL_SRLC16E__parameterized1\
     port map (
      Clk => Clk,
      Clk_En_I_1 => Clk_En_I_1,
      lopt => loop_Bit,
      lopt_1 => '1',
      shifts_0 => shifts_0,
      shifts_1 => shifts_1
    );
\not_First.Clk_En_Out_i_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => Clk_En_I_1,
      I1 => \not_First.Out1_reg_n_0\,
      I2 => \^fit1_interrupt\,
      O => \not_First.Clk_En_Out_i_i_1_n_0\
    );
\not_First.Clk_En_Out_i_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => Clk,
      CE => '1',
      D => \not_First.Clk_En_Out_i_i_1_n_0\,
      Q => \^fit1_interrupt\,
      R => '0'
    );
\not_First.Out1_reg\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => loop_Bit,
      Q => \not_First.Out1_reg_n_0\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_fc5c_iomodule_0_0_UART_Receive is
  port (
    \out\ : out STD_LOGIC;
    frame_error_reg : out STD_LOGIC;
    \UART_Status_reg[0]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    \All_INTR_Bits[2].Using_Intr.cisr_reg[2]\ : out STD_LOGIC;
    overrun_error_reg : out STD_LOGIC;
    frame_error_reg_0 : out STD_LOGIC;
    Sl_DBus : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \Sl_DBus[25]\ : out STD_LOGIC_VECTOR ( 5 downto 0 );
    en_16x_baud : in STD_LOGIC;
    Clk : in STD_LOGIC;
    Rst : in STD_LOGIC;
    UART_Rx : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 4 downto 0 );
    lmb_reg_read : in STD_LOGIC;
    UART_Status_Read : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 1 downto 0 );
    io_bus_read_data : in STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of bd_fc5c_iomodule_0_0_UART_Receive : entity is "UART_Receive";
end bd_fc5c_iomodule_0_0_UART_Receive;

architecture STRUCTURE of bd_fc5c_iomodule_0_0_UART_Receive is
  signal \Convert_Serial_To_Parallel[2].serial_to_parallel_reg\ : STD_LOGIC;
  signal \Convert_Serial_To_Parallel[3].serial_to_parallel_reg\ : STD_LOGIC;
  signal \Convert_Serial_To_Parallel[4].serial_to_parallel_reg\ : STD_LOGIC;
  signal \Convert_Serial_To_Parallel[5].serial_to_parallel_reg\ : STD_LOGIC;
  signal \Convert_Serial_To_Parallel[6].serial_to_parallel_reg\ : STD_LOGIC;
  signal \Convert_Serial_To_Parallel[7].serial_to_parallel_reg\ : STD_LOGIC;
  signal \Convert_Serial_To_Parallel[8].serial_to_parallel_reg\ : STD_LOGIC;
  signal D_0 : STD_LOGIC;
  signal Delay_16_n_1 : STD_LOGIC;
  signal Delay_16_n_2 : STD_LOGIC;
  signal RX_Data : STD_LOGIC_VECTOR ( 7 downto 4 );
  signal \RX_Data[7]_i_1_n_0\ : STD_LOGIC;
  signal UART_Rx_Read : STD_LOGIC;
  signal \^uart_status_reg[0]\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^frame_error_reg\ : STD_LOGIC;
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of frame_error_reg : signal is "soft";
  signal mid_Start_Bit : STD_LOGIC;
  signal new_rx_data : STD_LOGIC_VECTOR ( 0 to 8 );
  attribute RTL_KEEP of new_rx_data : signal is "soft";
  signal new_rx_data_write : STD_LOGIC;
  attribute RTL_KEEP of new_rx_data_write : signal is "soft";
  signal \new_rx_data_write_reg0__0\ : STD_LOGIC;
  signal previous_RX : STD_LOGIC;
  signal previous_RX_i_1_n_0 : STD_LOGIC;
  signal running_reg_n_0 : STD_LOGIC;
  signal rx_1 : STD_LOGIC;
  signal rx_data_exists_i_i_1_n_0 : STD_LOGIC;
  signal rx_data_i : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal rx_parity_error : STD_LOGIC;
  attribute RTL_KEEP of rx_parity_error : signal is "soft";
  signal sample_Point : STD_LOGIC;
  signal start_Edge_Detected_i_1_n_0 : STD_LOGIC;
  signal start_Edge_Detected_reg_n_0 : STD_LOGIC;
  signal stop_Bit_Position_reg_n_0 : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of \Convert_Serial_To_Parallel[1].First_Bit.First_Bit_I\ : label is "PRIMITIVE";
  attribute box_type of \Convert_Serial_To_Parallel[2].Rest_Bits.Others_I\ : label is "PRIMITIVE";
  attribute box_type of \Convert_Serial_To_Parallel[3].Rest_Bits.Others_I\ : label is "PRIMITIVE";
  attribute box_type of \Convert_Serial_To_Parallel[4].Rest_Bits.Others_I\ : label is "PRIMITIVE";
  attribute box_type of \Convert_Serial_To_Parallel[5].Rest_Bits.Others_I\ : label is "PRIMITIVE";
  attribute box_type of \Convert_Serial_To_Parallel[6].Rest_Bits.Others_I\ : label is "PRIMITIVE";
  attribute box_type of \Convert_Serial_To_Parallel[7].Rest_Bits.Others_I\ : label is "PRIMITIVE";
  attribute box_type of \Convert_Serial_To_Parallel[8].Rest_Bits.Others_I\ : label is "PRIMITIVE";
  attribute KEEP : string;
  attribute KEEP of new_rx_data_write_reg : label is "yes";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of previous_RX_i_1 : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of start_Edge_Detected_i_1 : label is "soft_lutpair7";
begin
  \UART_Status_reg[0]\(0) <= \^uart_status_reg[0]\(0);
  frame_error_reg <= \^frame_error_reg\;
  \out\ <= new_rx_data_write;
\All_INTR_Bits[2].Using_Intr.cisr[2]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => new_rx_data_write,
      I1 => Rst,
      O => \All_INTR_Bits[2].Using_Intr.cisr_reg[2]\
    );
\Convert_Serial_To_Parallel[1].First_Bit.First_Bit_I\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_S_INVERTED => '0'
    )
        port map (
      C => Clk,
      CE => en_16x_baud,
      D => D_0,
      Q => new_rx_data(1),
      S => mid_Start_Bit
    );
\Convert_Serial_To_Parallel[2].Rest_Bits.Others_I\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => Clk,
      CE => en_16x_baud,
      D => \Convert_Serial_To_Parallel[2].serial_to_parallel_reg\,
      Q => new_rx_data(2),
      R => mid_Start_Bit
    );
\Convert_Serial_To_Parallel[3].Rest_Bits.Others_I\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => Clk,
      CE => en_16x_baud,
      D => \Convert_Serial_To_Parallel[3].serial_to_parallel_reg\,
      Q => new_rx_data(3),
      R => mid_Start_Bit
    );
\Convert_Serial_To_Parallel[4].Rest_Bits.Others_I\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => Clk,
      CE => en_16x_baud,
      D => \Convert_Serial_To_Parallel[4].serial_to_parallel_reg\,
      Q => new_rx_data(4),
      R => mid_Start_Bit
    );
\Convert_Serial_To_Parallel[5].Rest_Bits.Others_I\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => Clk,
      CE => en_16x_baud,
      D => \Convert_Serial_To_Parallel[5].serial_to_parallel_reg\,
      Q => new_rx_data(5),
      R => mid_Start_Bit
    );
\Convert_Serial_To_Parallel[6].Rest_Bits.Others_I\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => Clk,
      CE => en_16x_baud,
      D => \Convert_Serial_To_Parallel[6].serial_to_parallel_reg\,
      Q => new_rx_data(6),
      R => mid_Start_Bit
    );
\Convert_Serial_To_Parallel[7].Rest_Bits.Others_I\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => Clk,
      CE => en_16x_baud,
      D => \Convert_Serial_To_Parallel[7].serial_to_parallel_reg\,
      Q => new_rx_data(7),
      R => mid_Start_Bit
    );
\Convert_Serial_To_Parallel[8].Rest_Bits.Others_I\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => Clk,
      CE => en_16x_baud,
      D => \Convert_Serial_To_Parallel[8].serial_to_parallel_reg\,
      Q => new_rx_data(8),
      R => mid_Start_Bit
    );
Delay_16: entity work.\bd_fc5c_iomodule_0_0_XIL_SRL16E__parameterized3\
     port map (
      Clk => Clk,
      \Convert_Serial_To_Parallel[2].serial_to_parallel_reg\ => \Convert_Serial_To_Parallel[2].serial_to_parallel_reg\,
      \Convert_Serial_To_Parallel[3].serial_to_parallel_reg\ => \Convert_Serial_To_Parallel[3].serial_to_parallel_reg\,
      \Convert_Serial_To_Parallel[4].serial_to_parallel_reg\ => \Convert_Serial_To_Parallel[4].serial_to_parallel_reg\,
      \Convert_Serial_To_Parallel[5].serial_to_parallel_reg\ => \Convert_Serial_To_Parallel[5].serial_to_parallel_reg\,
      \Convert_Serial_To_Parallel[6].serial_to_parallel_reg\ => \Convert_Serial_To_Parallel[6].serial_to_parallel_reg\,
      \Convert_Serial_To_Parallel[7].serial_to_parallel_reg\ => \Convert_Serial_To_Parallel[7].serial_to_parallel_reg\,
      \Convert_Serial_To_Parallel[8].serial_to_parallel_reg\ => \Convert_Serial_To_Parallel[8].serial_to_parallel_reg\,
      D_0 => D_0,
      en_16x_baud => en_16x_baud,
      mid_Start_Bit => mid_Start_Bit,
      \out\(8) => new_rx_data(0),
      \out\(7) => new_rx_data(1),
      \out\(6) => new_rx_data(2),
      \out\(5) => new_rx_data(3),
      \out\(4) => new_rx_data(4),
      \out\(3) => new_rx_data(5),
      \out\(2) => new_rx_data(6),
      \out\(1) => new_rx_data(7),
      \out\(0) => new_rx_data(8),
      running_reg => Delay_16_n_2,
      running_reg_0 => running_reg_n_0,
      sample_Point => sample_Point,
      start_Edge_Detected_reg => start_Edge_Detected_reg_n_0,
      stop_Bit_Position_reg => Delay_16_n_1,
      stop_Bit_Position_reg_0 => stop_Bit_Position_reg_n_0
    );
Mid_Start_Bit_SRL16: entity work.\bd_fc5c_iomodule_0_0_XIL_SRL16E__parameterized1\
     port map (
      Clk => Clk,
      en_16x_baud => en_16x_baud,
      mid_Start_Bit => mid_Start_Bit,
      start_Edge_Detected_reg => start_Edge_Detected_reg_n_0
    );
\RX_Data[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFEFFFFFFFF"
    )
        port map (
      I0 => Q(4),
      I1 => Q(1),
      I2 => Q(0),
      I3 => Q(2),
      I4 => Q(3),
      I5 => lmb_reg_read,
      O => \RX_Data[7]_i_1_n_0\
    );
\RX_Data_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => rx_data_i(0),
      Q => \Sl_DBus[25]\(0),
      R => \RX_Data[7]_i_1_n_0\
    );
\RX_Data_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => rx_data_i(1),
      Q => \Sl_DBus[25]\(1),
      R => \RX_Data[7]_i_1_n_0\
    );
\RX_Data_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => rx_data_i(2),
      Q => \Sl_DBus[25]\(2),
      R => \RX_Data[7]_i_1_n_0\
    );
\RX_Data_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => rx_data_i(3),
      Q => \Sl_DBus[25]\(3),
      R => \RX_Data[7]_i_1_n_0\
    );
\RX_Data_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => rx_data_i(4),
      Q => RX_Data(4),
      R => \RX_Data[7]_i_1_n_0\
    );
\RX_Data_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => rx_data_i(5),
      Q => \Sl_DBus[25]\(4),
      R => \RX_Data[7]_i_1_n_0\
    );
\RX_Data_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => rx_data_i(6),
      Q => \Sl_DBus[25]\(5),
      R => \RX_Data[7]_i_1_n_0\
    );
\RX_Data_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => rx_data_i(7),
      Q => RX_Data(7),
      R => \RX_Data[7]_i_1_n_0\
    );
\Sl_DBus[24]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => io_bus_read_data(1),
      I1 => RX_Data(7),
      O => Sl_DBus(1)
    );
\Sl_DBus[27]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => io_bus_read_data(0),
      I1 => RX_Data(4),
      O => Sl_DBus(0)
    );
frame_error_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
        port map (
      I0 => \^frame_error_reg\,
      I1 => UART_Status_Read,
      I2 => D(1),
      O => frame_error_reg_0
    );
i_0: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => '0',
      O => rx_parity_error
    );
in00: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => new_rx_data(0),
      I1 => en_16x_baud,
      I2 => sample_Point,
      I3 => stop_Bit_Position_reg_n_0,
      O => \^frame_error_reg\
    );
new_rx_data_write_reg: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \new_rx_data_write_reg0__0\,
      Q => new_rx_data_write,
      R => Rst
    );
new_rx_data_write_reg0: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => en_16x_baud,
      I1 => sample_Point,
      I2 => stop_Bit_Position_reg_n_0,
      I3 => new_rx_data(0),
      O => \new_rx_data_write_reg0__0\
    );
overrun_error_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8F88"
    )
        port map (
      I0 => \^uart_status_reg[0]\(0),
      I1 => new_rx_data_write,
      I2 => UART_Status_Read,
      I3 => D(0),
      O => overrun_error_reg
    );
previous_RX_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => new_rx_data(0),
      I1 => en_16x_baud,
      I2 => previous_RX,
      O => previous_RX_i_1_n_0
    );
previous_RX_reg: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => previous_RX_i_1_n_0,
      Q => previous_RX,
      R => Rst
    );
running_reg: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => Delay_16_n_2,
      Q => running_reg_n_0,
      R => Rst
    );
rx_1_reg: unisim.vcomponents.FDSE
     port map (
      C => Clk,
      CE => '1',
      D => UART_Rx,
      Q => rx_1,
      S => Rst
    );
rx_2_reg: unisim.vcomponents.FDSE
     port map (
      C => Clk,
      CE => '1',
      D => rx_1,
      Q => new_rx_data(0),
      S => Rst
    );
rx_data_exists_i_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"000E"
    )
        port map (
      I0 => \^uart_status_reg[0]\(0),
      I1 => new_rx_data_write,
      I2 => UART_Rx_Read,
      I3 => Rst,
      O => rx_data_exists_i_i_1_n_0
    );
rx_data_exists_i_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000002"
    )
        port map (
      I0 => lmb_reg_read,
      I1 => Q(3),
      I2 => Q(2),
      I3 => Q(0),
      I4 => Q(1),
      I5 => Q(4),
      O => UART_Rx_Read
    );
rx_data_exists_i_reg: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => rx_data_exists_i_i_1_n_0,
      Q => \^uart_status_reg[0]\(0),
      R => '0'
    );
\rx_data_i_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => new_rx_data_write,
      D => new_rx_data(8),
      Q => rx_data_i(0),
      R => Rst
    );
\rx_data_i_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => new_rx_data_write,
      D => new_rx_data(7),
      Q => rx_data_i(1),
      R => Rst
    );
\rx_data_i_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => new_rx_data_write,
      D => new_rx_data(6),
      Q => rx_data_i(2),
      R => Rst
    );
\rx_data_i_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => new_rx_data_write,
      D => new_rx_data(5),
      Q => rx_data_i(3),
      R => Rst
    );
\rx_data_i_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => new_rx_data_write,
      D => new_rx_data(4),
      Q => rx_data_i(4),
      R => Rst
    );
\rx_data_i_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => new_rx_data_write,
      D => new_rx_data(3),
      Q => rx_data_i(5),
      R => Rst
    );
\rx_data_i_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => new_rx_data_write,
      D => new_rx_data(2),
      Q => rx_data_i(6),
      R => Rst
    );
\rx_data_i_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => new_rx_data_write,
      D => new_rx_data(1),
      Q => rx_data_i(7),
      R => Rst
    );
start_Edge_Detected_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"02FF0200"
    )
        port map (
      I0 => previous_RX,
      I1 => new_rx_data(0),
      I2 => running_reg_n_0,
      I3 => en_16x_baud,
      I4 => start_Edge_Detected_reg_n_0,
      O => start_Edge_Detected_i_1_n_0
    );
start_Edge_Detected_reg: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => start_Edge_Detected_i_1_n_0,
      Q => start_Edge_Detected_reg_n_0,
      R => Rst
    );
stop_Bit_Position_reg: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => Delay_16_n_1,
      Q => stop_Bit_Position_reg_n_0,
      R => Rst
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_fc5c_iomodule_0_0_UART_Transmit is
  port (
    UART_Tx : out STD_LOGIC;
    UART_Tx_Interrupt : out STD_LOGIC;
    \UART_Status_reg[3]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    \All_INTR_Bits[1].Using_Intr.cisr_reg[1]\ : out STD_LOGIC;
    en_16x_baud : in STD_LOGIC;
    Clk : in STD_LOGIC;
    Rst : in STD_LOGIC;
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    \out\ : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of bd_fc5c_iomodule_0_0_UART_Transmit : entity is "UART_Transmit";
end bd_fc5c_iomodule_0_0_UART_Transmit;

architecture STRUCTURE of bd_fc5c_iomodule_0_0_UART_Transmit is
  signal CI : STD_LOGIC;
  signal \Counter[0].h_Cnt_reg\ : STD_LOGIC;
  signal \Counter[1].Used_MuxCY.MUXCY_L_I_n_0\ : STD_LOGIC;
  signal \Counter[1].h_Cnt_reg\ : STD_LOGIC;
  signal \Counter[2].Used_MuxCY.MUXCY_L_I_n_0\ : STD_LOGIC;
  signal DI : STD_LOGIC;
  signal I0 : STD_LOGIC;
  signal I1 : STD_LOGIC;
  signal LI : STD_LOGIC;
  signal MUX_F5_1_i_1_n_0 : STD_LOGIC;
  signal MUX_F5_2_i_1_n_0 : STD_LOGIC;
  signal MUX_F5_2_i_2_n_0 : STD_LOGIC;
  signal MUX_F5_2_n_0 : STD_LOGIC;
  signal S : STD_LOGIC;
  signal TX_reg0 : STD_LOGIC;
  signal \^uart_tx_interrupt\ : STD_LOGIC;
  signal data_is_sent0 : STD_LOGIC;
  signal div16 : STD_LOGIC;
  signal \fifo_DOut_reg_n_0_[0]\ : STD_LOGIC;
  signal \fifo_DOut_reg_n_0_[1]\ : STD_LOGIC;
  signal \fifo_DOut_reg_n_0_[2]\ : STD_LOGIC;
  signal \fifo_DOut_reg_n_0_[3]\ : STD_LOGIC;
  signal \fifo_DOut_reg_n_0_[5]\ : STD_LOGIC;
  signal \fifo_DOut_reg_n_0_[6]\ : STD_LOGIC;
  signal \fifo_DOut_reg_n_0_[7]\ : STD_LOGIC;
  signal mux_Out : STD_LOGIC;
  signal \mux_sel_reg_n_0_[0]\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
  signal serial_Data : STD_LOGIC;
  signal sum_cnt : STD_LOGIC_VECTOR ( 0 to 2 );
  signal tx_DataBits : STD_LOGIC;
  signal tx_DataBits0 : STD_LOGIC;
  signal tx_Data_Enable : STD_LOGIC;
  signal tx_Start : STD_LOGIC;
  signal tx_Start0 : STD_LOGIC;
  signal tx_buffer_empty_i : STD_LOGIC;
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of tx_buffer_empty_i : signal is "soft";
  signal tx_buffer_empty_i_i_1_n_0 : STD_LOGIC;
  signal \NLW_Counter[2].Used_MuxCY.MUXCY_L_I_CARRY4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_Counter[2].Used_MuxCY.MUXCY_L_I_CARRY4_DI_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_Counter[2].Used_MuxCY.MUXCY_L_I_CARRY4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_Counter[2].Used_MuxCY.MUXCY_L_I_CARRY4_S_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \All_INTR_Bits[1].Using_Intr.cisr[1]_i_5\ : label is "soft_lutpair8";
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of \Counter[2].Used_MuxCY.MUXCY_L_I_CARRY4\ : label is "(MUXCY,XORCY)";
  attribute XILINX_TRANSFORM_PINMAP : string;
  attribute XILINX_TRANSFORM_PINMAP of \Counter[2].Used_MuxCY.MUXCY_L_I_CARRY4\ : label is "LO:O";
  attribute box_type : string;
  attribute box_type of \Counter[2].Used_MuxCY.MUXCY_L_I_CARRY4\ : label is "PRIMITIVE";
  attribute box_type of FDRE_I : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of MUXF6_I : label is "MUXF6";
  attribute XILINX_TRANSFORM_PINMAP of MUXF6_I : label is "S:I2";
  attribute box_type of MUXF6_I : label is "PRIMITIVE";
  attribute XILINX_LEGACY_PRIM of MUX_F5_1 : label is "MUXF5";
  attribute XILINX_TRANSFORM_PINMAP of MUX_F5_1 : label is "S:I2";
  attribute box_type of MUX_F5_1 : label is "PRIMITIVE";
  attribute SOFT_HLUTNM of MUX_F5_1_i_1 : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of MUX_F5_1_i_2 : label is "soft_lutpair10";
  attribute XILINX_LEGACY_PRIM of MUX_F5_2 : label is "MUXF5";
  attribute XILINX_TRANSFORM_PINMAP of MUX_F5_2 : label is "S:I2";
  attribute box_type of MUX_F5_2 : label is "PRIMITIVE";
  attribute SOFT_HLUTNM of MUX_F5_2_i_1 : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of MUX_F5_2_i_2 : label is "soft_lutpair9";
  attribute KEEP : string;
  attribute KEEP of TX_reg : label is "yes";
  attribute SOFT_HLUTNM of tx_DataBits_i_1 : label is "soft_lutpair8";
  attribute KEEP of tx_buffer_empty_i_reg : label is "yes";
begin
  UART_Tx_Interrupt <= \^uart_tx_interrupt\;
\All_INTR_Bits[1].Using_Intr.cisr[1]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^uart_tx_interrupt\,
      I1 => Rst,
      O => \All_INTR_Bits[1].Using_Intr.cisr_reg[1]\
    );
\Counter[0].XORCY_I_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \mux_sel_reg_n_0_[0]\,
      O => \Counter[0].h_Cnt_reg\
    );
\Counter[1].XORCY_I_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => S,
      O => \Counter[1].h_Cnt_reg\
    );
\Counter[2].Used_MuxCY.MUXCY_L_I_CARRY4\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3 downto 2) => \NLW_Counter[2].Used_MuxCY.MUXCY_L_I_CARRY4_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \Counter[1].Used_MuxCY.MUXCY_L_I_n_0\,
      CO(0) => \Counter[2].Used_MuxCY.MUXCY_L_I_n_0\,
      CYINIT => CI,
      DI(3 downto 2) => \NLW_Counter[2].Used_MuxCY.MUXCY_L_I_CARRY4_DI_UNCONNECTED\(3 downto 2),
      DI(1) => S,
      DI(0) => DI,
      O(3) => \NLW_Counter[2].Used_MuxCY.MUXCY_L_I_CARRY4_O_UNCONNECTED\(3),
      O(2) => sum_cnt(0),
      O(1) => sum_cnt(1),
      O(0) => sum_cnt(2),
      S(3) => \NLW_Counter[2].Used_MuxCY.MUXCY_L_I_CARRY4_S_UNCONNECTED\(3),
      S(2) => \Counter[0].h_Cnt_reg\,
      S(1) => \Counter[1].h_Cnt_reg\,
      S(0) => LI
    );
\Counter[2].XORCY_I_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => DI,
      O => LI
    );
\Counter[2].XORCY_I_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tx_DataBits,
      O => CI
    );
DIV16_SRL16E: entity work.bd_fc5c_iomodule_0_0_XIL_SRL16E
     port map (
      Clk => Clk,
      div16 => div16,
      en_16x_baud => en_16x_baud
    );
FDRE_I: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => Clk,
      CE => en_16x_baud,
      D => div16,
      Q => tx_Data_Enable,
      R => tx_Data_Enable
    );
MUXF6_I: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => I0,
      I1 => MUX_F5_2_n_0,
      I2 => \mux_sel_reg_n_0_[0]\,
      O => mux_Out
    );
MUX_F5_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => MUX_F5_1_i_1_n_0,
      I1 => I1,
      I2 => S,
      O => I0
    );
MUX_F5_1_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \fifo_DOut_reg_n_0_[1]\,
      I1 => DI,
      I2 => \fifo_DOut_reg_n_0_[0]\,
      O => MUX_F5_1_i_1_n_0
    );
MUX_F5_1_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \fifo_DOut_reg_n_0_[3]\,
      I1 => DI,
      I2 => \fifo_DOut_reg_n_0_[2]\,
      O => I1
    );
MUX_F5_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"CA"
    )
        port map (
      I0 => MUX_F5_2_i_1_n_0,
      I1 => MUX_F5_2_i_2_n_0,
      I2 => S,
      O => MUX_F5_2_n_0
    );
MUX_F5_2_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \fifo_DOut_reg_n_0_[5]\,
      I1 => DI,
      I2 => p_0_in,
      O => MUX_F5_2_i_1_n_0
    );
MUX_F5_2_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \fifo_DOut_reg_n_0_[7]\,
      I1 => DI,
      I2 => \fifo_DOut_reg_n_0_[6]\,
      O => MUX_F5_2_i_2_n_0
    );
TX_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0B"
    )
        port map (
      I0 => serial_Data,
      I1 => tx_DataBits,
      I2 => tx_Start,
      O => TX_reg0
    );
TX_reg: unisim.vcomponents.FDSE
     port map (
      C => Clk,
      CE => '1',
      D => TX_reg0,
      Q => UART_Tx,
      S => Rst
    );
\UART_Status[3]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tx_buffer_empty_i,
      O => \UART_Status_reg[3]\(0)
    );
data_is_sent_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0002"
    )
        port map (
      I0 => tx_Data_Enable,
      I1 => DI,
      I2 => S,
      I3 => \mux_sel_reg_n_0_[0]\,
      O => data_is_sent0
    );
data_is_sent_reg: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => data_is_sent0,
      Q => \^uart_tx_interrupt\,
      R => Rst
    );
\fifo_DOut_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => E(0),
      D => \out\(7),
      Q => \fifo_DOut_reg_n_0_[0]\,
      R => Rst
    );
\fifo_DOut_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => E(0),
      D => \out\(6),
      Q => \fifo_DOut_reg_n_0_[1]\,
      R => Rst
    );
\fifo_DOut_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => E(0),
      D => \out\(5),
      Q => \fifo_DOut_reg_n_0_[2]\,
      R => Rst
    );
\fifo_DOut_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => E(0),
      D => \out\(4),
      Q => \fifo_DOut_reg_n_0_[3]\,
      R => Rst
    );
\fifo_DOut_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => E(0),
      D => \out\(3),
      Q => p_0_in,
      R => Rst
    );
\fifo_DOut_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => E(0),
      D => \out\(2),
      Q => \fifo_DOut_reg_n_0_[5]\,
      R => Rst
    );
\fifo_DOut_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => E(0),
      D => \out\(1),
      Q => \fifo_DOut_reg_n_0_[6]\,
      R => Rst
    );
\fifo_DOut_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => E(0),
      D => \out\(0),
      Q => \fifo_DOut_reg_n_0_[7]\,
      R => Rst
    );
\mux_sel_reg[0]\: unisim.vcomponents.FDSE
     port map (
      C => Clk,
      CE => tx_Data_Enable,
      D => sum_cnt(0),
      Q => \mux_sel_reg_n_0_[0]\,
      S => Rst
    );
\mux_sel_reg[1]\: unisim.vcomponents.FDSE
     port map (
      C => Clk,
      CE => tx_Data_Enable,
      D => sum_cnt(1),
      Q => S,
      S => Rst
    );
\mux_sel_reg[2]\: unisim.vcomponents.FDSE
     port map (
      C => Clk,
      CE => tx_Data_Enable,
      D => sum_cnt(2),
      Q => DI,
      S => Rst
    );
serial_Data_reg: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => mux_Out,
      Q => serial_Data,
      R => Rst
    );
tx_DataBits_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0F08"
    )
        port map (
      I0 => tx_Start,
      I1 => tx_Data_Enable,
      I2 => \^uart_tx_interrupt\,
      I3 => tx_DataBits,
      O => tx_DataBits0
    );
tx_DataBits_reg: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => tx_DataBits0,
      Q => tx_DataBits,
      R => Rst
    );
tx_Start_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0F02"
    )
        port map (
      I0 => tx_Data_Enable,
      I1 => tx_buffer_empty_i,
      I2 => tx_DataBits,
      I3 => tx_Start,
      O => tx_Start0
    );
tx_Start_reg: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => tx_Start0,
      Q => tx_Start,
      R => Rst
    );
tx_buffer_empty_i_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFF4"
    )
        port map (
      I0 => E(0),
      I1 => tx_buffer_empty_i,
      I2 => \^uart_tx_interrupt\,
      I3 => Rst,
      O => tx_buffer_empty_i_i_1_n_0
    );
tx_buffer_empty_i_reg: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => tx_buffer_empty_i_i_1_n_0,
      Q => tx_buffer_empty_i,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_fc5c_iomodule_0_0_FIT_Module is
  port (
    en_16x_baud : out STD_LOGIC;
    Clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of bd_fc5c_iomodule_0_0_FIT_Module : entity is "FIT_Module";
end bd_fc5c_iomodule_0_0_FIT_Module;

architecture STRUCTURE of bd_fc5c_iomodule_0_0_FIT_Module is
  signal Clk_En_I_1 : STD_LOGIC;
begin
\Implement_FIT.Using_SRL16s.SRL16s[1].Divide_I\: entity work.bd_fc5c_iomodule_0_0_Divide_part
     port map (
      Clk => Clk,
      Clk_En_I_1 => Clk_En_I_1
    );
\Implement_FIT.Using_SRL16s.SRL16s[2].Divide_I\: entity work.\bd_fc5c_iomodule_0_0_Divide_part__parameterized0\
     port map (
      Clk => Clk,
      Clk_En_I_1 => Clk_En_I_1,
      en_16x_baud => en_16x_baud
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \bd_fc5c_iomodule_0_0_FIT_Module__parameterized1\ is
  port (
    FIT1_Interrupt : out STD_LOGIC;
    FIT1_Toggle : out STD_LOGIC;
    Clk : in STD_LOGIC;
    Rst : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \bd_fc5c_iomodule_0_0_FIT_Module__parameterized1\ : entity is "FIT_Module";
end \bd_fc5c_iomodule_0_0_FIT_Module__parameterized1\;

architecture STRUCTURE of \bd_fc5c_iomodule_0_0_FIT_Module__parameterized1\ is
  signal Clk_En_I_1 : STD_LOGIC;
  signal Clk_En_I_2 : STD_LOGIC;
  signal \^fit1_toggle\ : STD_LOGIC;
  signal \Implement_FIT.Using_SRL16s.SRL16s[3].Divide_I_n_1\ : STD_LOGIC;
begin
  FIT1_Toggle <= \^fit1_toggle\;
\Implement_FIT.Using_SRL16s.SRL16s[1].Divide_I\: entity work.\bd_fc5c_iomodule_0_0_Divide_part__parameterized1\
     port map (
      Clk => Clk,
      Clk_En_I_2 => Clk_En_I_2
    );
\Implement_FIT.Using_SRL16s.SRL16s[2].Divide_I\: entity work.\bd_fc5c_iomodule_0_0_Divide_part__parameterized2\
     port map (
      Clk => Clk,
      Clk_En_I_1 => Clk_En_I_1,
      Clk_En_I_2 => Clk_En_I_2
    );
\Implement_FIT.Using_SRL16s.SRL16s[3].Divide_I\: entity work.\bd_fc5c_iomodule_0_0_Divide_part__parameterized3\
     port map (
      Clk => Clk,
      Clk_En_I_1 => Clk_En_I_1,
      FIT1_Interrupt => FIT1_Interrupt,
      FIT1_Toggle => \^fit1_toggle\,
      \Implement_FIT.toggle_i_reg\ => \Implement_FIT.Using_SRL16s.SRL16s[3].Divide_I_n_1\
    );
\Implement_FIT.toggle_i_reg\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \Implement_FIT.Using_SRL16s.SRL16s[3].Divide_I_n_1\,
      Q => \^fit1_toggle\,
      R => Rst
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_fc5c_iomodule_0_0_Iomodule_core is
  port (
    UART_Tx : out STD_LOGIC;
    INTC_IRQ : out STD_LOGIC;
    FIT1_Interrupt : out STD_LOGIC;
    FIT1_Toggle : out STD_LOGIC;
    UART_Interrupt : out STD_LOGIC;
    INTC_Interrupt_Address : out STD_LOGIC_VECTOR ( 14 downto 0 );
    Sl_DBus : out STD_LOGIC_VECTOR ( 8 downto 0 );
    Clk : in STD_LOGIC;
    Rst : in STD_LOGIC;
    UART_Rx : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 5 downto 0 );
    lmb_reg_write : in STD_LOGIC;
    lmb_reg_read : in STD_LOGIC;
    \out\ : in STD_LOGIC_VECTOR ( 16 downto 0 );
    INTC_Processor_Ack : in STD_LOGIC_VECTOR ( 1 downto 0 );
    INTC_Interrupt : in STD_LOGIC_VECTOR ( 0 to 0 );
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    io_bus_read_data : in STD_LOGIC_VECTOR ( 8 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of bd_fc5c_iomodule_0_0_Iomodule_core : entity is "Iomodule_core";
end bd_fc5c_iomodule_0_0_Iomodule_core;

architecture STRUCTURE of bd_fc5c_iomodule_0_0_Iomodule_core is
  signal RX_Data : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal UART_Rx_Interrupt : STD_LOGIC;
  signal UART_Status_Read : STD_LOGIC;
  signal UART_Tx_Interrupt : STD_LOGIC;
  signal \Using_UART_RX.UART_RX_I1_n_3\ : STD_LOGIC;
  signal \Using_UART_RX.UART_RX_I1_n_4\ : STD_LOGIC;
  signal \Using_UART_RX.UART_RX_I1_n_5\ : STD_LOGIC;
  signal \Using_UART_TX.UART_TX_I1_n_3\ : STD_LOGIC;
  signal en_16x_baud : STD_LOGIC;
  signal frame_error : STD_LOGIC;
  signal overrun_error : STD_LOGIC;
  signal p_0_out : STD_LOGIC_VECTOR ( 3 to 3 );
  signal rx_data_exists : STD_LOGIC;
  signal rx_frame_error : STD_LOGIC;
begin
FIT_I1: entity work.\bd_fc5c_iomodule_0_0_FIT_Module__parameterized1\
     port map (
      Clk => Clk,
      FIT1_Interrupt => FIT1_Interrupt,
      FIT1_Toggle => FIT1_Toggle,
      Rst => Rst
    );
\Using_UART.No_Dynamic_BaudRate.UART_FIT_I\: entity work.bd_fc5c_iomodule_0_0_FIT_Module
     port map (
      Clk => Clk,
      en_16x_baud => en_16x_baud
    );
\Using_UART.Uart_Control_Status_I1\: entity work.bd_fc5c_iomodule_0_0_Uart_Control_Status
     port map (
      Clk => Clk,
      D(1) => frame_error,
      D(0) => overrun_error,
      Q(4 downto 0) => Q(4 downto 0),
      \RX_Data_reg[6]\(3 downto 2) => RX_Data(6 downto 5),
      \RX_Data_reg[6]\(1) => RX_Data(3),
      \RX_Data_reg[6]\(0) => RX_Data(0),
      Rst => Rst,
      Sl_DBus(3 downto 2) => Sl_DBus(6 downto 5),
      Sl_DBus(1) => Sl_DBus(3),
      Sl_DBus(0) => Sl_DBus(0),
      UART_Interrupt => UART_Interrupt,
      UART_Status_Read => UART_Status_Read,
      UART_Tx_Interrupt => UART_Tx_Interrupt,
      frame_error_reg_0 => \Using_UART_RX.UART_RX_I1_n_5\,
      io_bus_read_data(3 downto 2) => io_bus_read_data(6 downto 5),
      io_bus_read_data(1) => io_bus_read_data(3),
      io_bus_read_data(0) => io_bus_read_data(0),
      lmb_reg_read => lmb_reg_read,
      \out\ => UART_Rx_Interrupt,
      rx_2_reg => rx_frame_error,
      rx_data_exists_i_reg => \Using_UART_RX.UART_RX_I1_n_4\,
      tx_buffer_empty_i_reg(1) => p_0_out(3),
      tx_buffer_empty_i_reg(0) => rx_data_exists
    );
\Using_UART_RX.UART_RX_I1\: entity work.bd_fc5c_iomodule_0_0_UART_Receive
     port map (
      \All_INTR_Bits[2].Using_Intr.cisr_reg[2]\ => \Using_UART_RX.UART_RX_I1_n_3\,
      Clk => Clk,
      D(1) => frame_error,
      D(0) => overrun_error,
      Q(4 downto 0) => Q(4 downto 0),
      Rst => Rst,
      Sl_DBus(1) => Sl_DBus(7),
      Sl_DBus(0) => Sl_DBus(4),
      \Sl_DBus[25]\(5 downto 4) => RX_Data(6 downto 5),
      \Sl_DBus[25]\(3 downto 0) => RX_Data(3 downto 0),
      UART_Rx => UART_Rx,
      UART_Status_Read => UART_Status_Read,
      \UART_Status_reg[0]\(0) => rx_data_exists,
      en_16x_baud => en_16x_baud,
      frame_error_reg => rx_frame_error,
      frame_error_reg_0 => \Using_UART_RX.UART_RX_I1_n_5\,
      io_bus_read_data(1) => io_bus_read_data(7),
      io_bus_read_data(0) => io_bus_read_data(4),
      lmb_reg_read => lmb_reg_read,
      \out\ => UART_Rx_Interrupt,
      overrun_error_reg => \Using_UART_RX.UART_RX_I1_n_4\
    );
\Using_UART_TX.UART_TX_I1\: entity work.bd_fc5c_iomodule_0_0_UART_Transmit
     port map (
      \All_INTR_Bits[1].Using_Intr.cisr_reg[1]\ => \Using_UART_TX.UART_TX_I1_n_3\,
      Clk => Clk,
      E(0) => E(0),
      Rst => Rst,
      \UART_Status_reg[3]\(0) => p_0_out(3),
      UART_Tx => UART_Tx,
      UART_Tx_Interrupt => UART_Tx_Interrupt,
      en_16x_baud => en_16x_baud,
      \out\(7 downto 0) => \out\(7 downto 0)
    );
intr_ctrl_I1: entity work.bd_fc5c_iomodule_0_0_intr_ctrl
     port map (
      Clk => Clk,
      INTC_IRQ => INTC_IRQ,
      INTC_Interrupt(0) => INTC_Interrupt(0),
      INTC_Interrupt_Address(14 downto 0) => INTC_Interrupt_Address(14 downto 0),
      INTC_Processor_Ack(1 downto 0) => INTC_Processor_Ack(1 downto 0),
      Q(5 downto 0) => Q(5 downto 0),
      \RX_Data_reg[2]\(1 downto 0) => RX_Data(2 downto 1),
      Rst => Rst,
      Sl_DBus(2) => Sl_DBus(8),
      Sl_DBus(1 downto 0) => Sl_DBus(2 downto 1),
      data_is_sent_reg => \Using_UART_TX.UART_TX_I1_n_3\,
      io_bus_read_data(2) => io_bus_read_data(8),
      io_bus_read_data(1 downto 0) => io_bus_read_data(2 downto 1),
      lmb_reg_read => lmb_reg_read,
      lmb_reg_write => lmb_reg_write,
      new_rx_data_write_reg => \Using_UART_RX.UART_RX_I1_n_3\,
      \out\(15 downto 0) => \out\(16 downto 1)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_fc5c_iomodule_0_0_iomodule is
  port (
    Clk : in STD_LOGIC;
    Rst : in STD_LOGIC;
    Config_Reset : in STD_LOGIC;
    IO_Addr_Strobe : out STD_LOGIC;
    IO_Read_Strobe : out STD_LOGIC;
    IO_Write_Strobe : out STD_LOGIC;
    IO_Address : out STD_LOGIC_VECTOR ( 31 downto 0 );
    IO_Byte_Enable : out STD_LOGIC_VECTOR ( 3 downto 0 );
    IO_Write_Data : out STD_LOGIC_VECTOR ( 31 downto 0 );
    IO_Read_Data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    IO_Ready : in STD_LOGIC;
    UART_Rx : in STD_LOGIC;
    UART_Tx : out STD_LOGIC;
    UART_Interrupt : out STD_LOGIC;
    FIT1_Interrupt : out STD_LOGIC;
    FIT1_Toggle : out STD_LOGIC;
    FIT2_Interrupt : out STD_LOGIC;
    FIT2_Toggle : out STD_LOGIC;
    FIT3_Interrupt : out STD_LOGIC;
    FIT3_Toggle : out STD_LOGIC;
    FIT4_Interrupt : out STD_LOGIC;
    FIT4_Toggle : out STD_LOGIC;
    PIT1_Enable : in STD_LOGIC;
    PIT1_Interrupt : out STD_LOGIC;
    PIT1_Toggle : out STD_LOGIC;
    PIT2_Enable : in STD_LOGIC;
    PIT2_Interrupt : out STD_LOGIC;
    PIT2_Toggle : out STD_LOGIC;
    PIT3_Enable : in STD_LOGIC;
    PIT3_Interrupt : out STD_LOGIC;
    PIT3_Toggle : out STD_LOGIC;
    PIT4_Enable : in STD_LOGIC;
    PIT4_Interrupt : out STD_LOGIC;
    PIT4_Toggle : out STD_LOGIC;
    GPO1 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    GPO2 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    GPO3 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    GPO4 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    GPI1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    GPI1_Interrupt : out STD_LOGIC;
    GPI2 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    GPI2_Interrupt : out STD_LOGIC;
    GPI3 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    GPI3_Interrupt : out STD_LOGIC;
    GPI4 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    GPI4_Interrupt : out STD_LOGIC;
    INTC_Interrupt : in STD_LOGIC_VECTOR ( 0 to 0 );
    INTC_IRQ : out STD_LOGIC;
    INTC_Processor_Ack : in STD_LOGIC_VECTOR ( 1 downto 0 );
    INTC_Interrupt_Address : out STD_LOGIC_VECTOR ( 31 downto 0 );
    INTC_IRQ_OUT : out STD_LOGIC;
    LMB_ABus : in STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_WriteDBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_AddrStrobe : in STD_LOGIC;
    LMB_ReadStrobe : in STD_LOGIC;
    LMB_WriteStrobe : in STD_LOGIC;
    LMB_BE : in STD_LOGIC_VECTOR ( 0 to 3 );
    Sl_DBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    Sl_Ready : out STD_LOGIC;
    Sl_Wait : out STD_LOGIC;
    Sl_UE : out STD_LOGIC;
    Sl_CE : out STD_LOGIC
  );
  attribute C_AVOID_PRIMITIVES : integer;
  attribute C_AVOID_PRIMITIVES of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_BASEADDR : string;
  attribute C_BASEADDR of bd_fc5c_iomodule_0_0_iomodule : entity is "64'b0000000000000000000000000000000010000000000000000000000000000000";
  attribute C_FAMILY : string;
  attribute C_FAMILY of bd_fc5c_iomodule_0_0_iomodule : entity is "kintex7";
  attribute C_FIT1_INTERRUPT : integer;
  attribute C_FIT1_INTERRUPT of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_FIT1_No_CLOCKS : integer;
  attribute C_FIT1_No_CLOCKS of bd_fc5c_iomodule_0_0_iomodule : entity is 6216;
  attribute C_FIT2_INTERRUPT : integer;
  attribute C_FIT2_INTERRUPT of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_FIT2_No_CLOCKS : integer;
  attribute C_FIT2_No_CLOCKS of bd_fc5c_iomodule_0_0_iomodule : entity is 6216;
  attribute C_FIT3_INTERRUPT : integer;
  attribute C_FIT3_INTERRUPT of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_FIT3_No_CLOCKS : integer;
  attribute C_FIT3_No_CLOCKS of bd_fc5c_iomodule_0_0_iomodule : entity is 6216;
  attribute C_FIT4_INTERRUPT : integer;
  attribute C_FIT4_INTERRUPT of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_FIT4_No_CLOCKS : integer;
  attribute C_FIT4_No_CLOCKS of bd_fc5c_iomodule_0_0_iomodule : entity is 6216;
  attribute C_FREQ : integer;
  attribute C_FREQ of bd_fc5c_iomodule_0_0_iomodule : entity is 100000000;
  attribute C_GPI1_INTERRUPT : integer;
  attribute C_GPI1_INTERRUPT of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_GPI1_SIZE : integer;
  attribute C_GPI1_SIZE of bd_fc5c_iomodule_0_0_iomodule : entity is 32;
  attribute C_GPI2_INTERRUPT : integer;
  attribute C_GPI2_INTERRUPT of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_GPI2_SIZE : integer;
  attribute C_GPI2_SIZE of bd_fc5c_iomodule_0_0_iomodule : entity is 32;
  attribute C_GPI3_INTERRUPT : integer;
  attribute C_GPI3_INTERRUPT of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_GPI3_SIZE : integer;
  attribute C_GPI3_SIZE of bd_fc5c_iomodule_0_0_iomodule : entity is 32;
  attribute C_GPI4_INTERRUPT : integer;
  attribute C_GPI4_INTERRUPT of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_GPI4_SIZE : integer;
  attribute C_GPI4_SIZE of bd_fc5c_iomodule_0_0_iomodule : entity is 32;
  attribute C_GPO1_INIT : integer;
  attribute C_GPO1_INIT of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_GPO1_SIZE : integer;
  attribute C_GPO1_SIZE of bd_fc5c_iomodule_0_0_iomodule : entity is 32;
  attribute C_GPO2_INIT : integer;
  attribute C_GPO2_INIT of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_GPO2_SIZE : integer;
  attribute C_GPO2_SIZE of bd_fc5c_iomodule_0_0_iomodule : entity is 32;
  attribute C_GPO3_INIT : integer;
  attribute C_GPO3_INIT of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_GPO3_SIZE : integer;
  attribute C_GPO3_SIZE of bd_fc5c_iomodule_0_0_iomodule : entity is 32;
  attribute C_GPO4_INIT : integer;
  attribute C_GPO4_INIT of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_GPO4_SIZE : integer;
  attribute C_GPO4_SIZE of bd_fc5c_iomodule_0_0_iomodule : entity is 32;
  attribute C_HIGHADDR : string;
  attribute C_HIGHADDR of bd_fc5c_iomodule_0_0_iomodule : entity is "64'b0000000000000000000000000000000010000000000000001111111111111111";
  attribute C_INSTANCE : string;
  attribute C_INSTANCE of bd_fc5c_iomodule_0_0_iomodule : entity is "iomodule";
  attribute C_INTC_ADDR_WIDTH : integer;
  attribute C_INTC_ADDR_WIDTH of bd_fc5c_iomodule_0_0_iomodule : entity is 17;
  attribute C_INTC_ASYNC_INTR : string;
  attribute C_INTC_ASYNC_INTR of bd_fc5c_iomodule_0_0_iomodule : entity is "16'b1111111111111111";
  attribute C_INTC_BASE_VECTORS : integer;
  attribute C_INTC_BASE_VECTORS of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_INTC_HAS_FAST : integer;
  attribute C_INTC_HAS_FAST of bd_fc5c_iomodule_0_0_iomodule : entity is 1;
  attribute C_INTC_INTR_SIZE : integer;
  attribute C_INTC_INTR_SIZE of bd_fc5c_iomodule_0_0_iomodule : entity is 1;
  attribute C_INTC_LEVEL_EDGE : string;
  attribute C_INTC_LEVEL_EDGE of bd_fc5c_iomodule_0_0_iomodule : entity is "16'b0000000000000000";
  attribute C_INTC_NUM_SYNC_FF : integer;
  attribute C_INTC_NUM_SYNC_FF of bd_fc5c_iomodule_0_0_iomodule : entity is 2;
  attribute C_INTC_POSITIVE : string;
  attribute C_INTC_POSITIVE of bd_fc5c_iomodule_0_0_iomodule : entity is "16'b1111111111111111";
  attribute C_INTC_USE_EXT_INTR : integer;
  attribute C_INTC_USE_EXT_INTR of bd_fc5c_iomodule_0_0_iomodule : entity is 1;
  attribute C_IO_BASEADDR : string;
  attribute C_IO_BASEADDR of bd_fc5c_iomodule_0_0_iomodule : entity is "64'b0000000000000000000000000000000011000000000000000000000000000000";
  attribute C_IO_HIGHADDR : string;
  attribute C_IO_HIGHADDR of bd_fc5c_iomodule_0_0_iomodule : entity is "64'b0000000000000000000000000000000011111111111111111111111111111111";
  attribute C_IO_MASK : string;
  attribute C_IO_MASK of bd_fc5c_iomodule_0_0_iomodule : entity is "64'b0000000000000000000000000000000011000000000000000000000000000000";
  attribute C_LMB_AWIDTH : integer;
  attribute C_LMB_AWIDTH of bd_fc5c_iomodule_0_0_iomodule : entity is 32;
  attribute C_LMB_DWIDTH : integer;
  attribute C_LMB_DWIDTH of bd_fc5c_iomodule_0_0_iomodule : entity is 32;
  attribute C_MASK : string;
  attribute C_MASK of bd_fc5c_iomodule_0_0_iomodule : entity is "64'b0000000000000000000000000000000011000000000000000000000000000000";
  attribute C_PIT1_INTERRUPT : integer;
  attribute C_PIT1_INTERRUPT of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_PIT1_PRESCALER : integer;
  attribute C_PIT1_PRESCALER of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_PIT1_READABLE : integer;
  attribute C_PIT1_READABLE of bd_fc5c_iomodule_0_0_iomodule : entity is 1;
  attribute C_PIT1_SIZE : integer;
  attribute C_PIT1_SIZE of bd_fc5c_iomodule_0_0_iomodule : entity is 32;
  attribute C_PIT2_INTERRUPT : integer;
  attribute C_PIT2_INTERRUPT of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_PIT2_PRESCALER : integer;
  attribute C_PIT2_PRESCALER of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_PIT2_READABLE : integer;
  attribute C_PIT2_READABLE of bd_fc5c_iomodule_0_0_iomodule : entity is 1;
  attribute C_PIT2_SIZE : integer;
  attribute C_PIT2_SIZE of bd_fc5c_iomodule_0_0_iomodule : entity is 32;
  attribute C_PIT3_INTERRUPT : integer;
  attribute C_PIT3_INTERRUPT of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_PIT3_PRESCALER : integer;
  attribute C_PIT3_PRESCALER of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_PIT3_READABLE : integer;
  attribute C_PIT3_READABLE of bd_fc5c_iomodule_0_0_iomodule : entity is 1;
  attribute C_PIT3_SIZE : integer;
  attribute C_PIT3_SIZE of bd_fc5c_iomodule_0_0_iomodule : entity is 32;
  attribute C_PIT4_INTERRUPT : integer;
  attribute C_PIT4_INTERRUPT of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_PIT4_PRESCALER : integer;
  attribute C_PIT4_PRESCALER of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_PIT4_READABLE : integer;
  attribute C_PIT4_READABLE of bd_fc5c_iomodule_0_0_iomodule : entity is 1;
  attribute C_PIT4_SIZE : integer;
  attribute C_PIT4_SIZE of bd_fc5c_iomodule_0_0_iomodule : entity is 32;
  attribute C_UART_BAUDRATE : integer;
  attribute C_UART_BAUDRATE of bd_fc5c_iomodule_0_0_iomodule : entity is 115200;
  attribute C_UART_DATA_BITS : integer;
  attribute C_UART_DATA_BITS of bd_fc5c_iomodule_0_0_iomodule : entity is 8;
  attribute C_UART_ERROR_INTERRUPT : integer;
  attribute C_UART_ERROR_INTERRUPT of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_UART_ODD_PARITY : integer;
  attribute C_UART_ODD_PARITY of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_UART_PROG_BAUDRATE : integer;
  attribute C_UART_PROG_BAUDRATE of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_UART_RX_INTERRUPT : integer;
  attribute C_UART_RX_INTERRUPT of bd_fc5c_iomodule_0_0_iomodule : entity is 1;
  attribute C_UART_TX_INTERRUPT : integer;
  attribute C_UART_TX_INTERRUPT of bd_fc5c_iomodule_0_0_iomodule : entity is 1;
  attribute C_UART_USE_PARITY : integer;
  attribute C_UART_USE_PARITY of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_USE_CONFIG_RESET : integer;
  attribute C_USE_CONFIG_RESET of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_USE_FIT1 : integer;
  attribute C_USE_FIT1 of bd_fc5c_iomodule_0_0_iomodule : entity is 1;
  attribute C_USE_FIT2 : integer;
  attribute C_USE_FIT2 of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_USE_FIT3 : integer;
  attribute C_USE_FIT3 of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_USE_FIT4 : integer;
  attribute C_USE_FIT4 of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_USE_GPI1 : integer;
  attribute C_USE_GPI1 of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_USE_GPI2 : integer;
  attribute C_USE_GPI2 of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_USE_GPI3 : integer;
  attribute C_USE_GPI3 of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_USE_GPI4 : integer;
  attribute C_USE_GPI4 of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_USE_GPO1 : integer;
  attribute C_USE_GPO1 of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_USE_GPO2 : integer;
  attribute C_USE_GPO2 of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_USE_GPO3 : integer;
  attribute C_USE_GPO3 of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_USE_GPO4 : integer;
  attribute C_USE_GPO4 of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_USE_IO_BUS : integer;
  attribute C_USE_IO_BUS of bd_fc5c_iomodule_0_0_iomodule : entity is 1;
  attribute C_USE_PIT1 : integer;
  attribute C_USE_PIT1 of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_USE_PIT2 : integer;
  attribute C_USE_PIT2 of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_USE_PIT3 : integer;
  attribute C_USE_PIT3 of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_USE_PIT4 : integer;
  attribute C_USE_PIT4 of bd_fc5c_iomodule_0_0_iomodule : entity is 0;
  attribute C_USE_UART_RX : integer;
  attribute C_USE_UART_RX of bd_fc5c_iomodule_0_0_iomodule : entity is 1;
  attribute C_USE_UART_TX : integer;
  attribute C_USE_UART_TX of bd_fc5c_iomodule_0_0_iomodule : entity is 1;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of bd_fc5c_iomodule_0_0_iomodule : entity is "iomodule";
end bd_fc5c_iomodule_0_0_iomodule;

architecture STRUCTURE of bd_fc5c_iomodule_0_0_iomodule is
  signal \<const0>\ : STD_LOGIC;
  signal \^intc_irq\ : STD_LOGIC;
  signal \^intc_interrupt_address\ : STD_LOGIC_VECTOR ( 16 downto 2 );
  signal \IO_Read_Strobe__0\ : STD_LOGIC;
  signal \IO_Write_Strobe__0\ : STD_LOGIC;
  signal \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\ : STD_LOGIC;
  signal \Using_IO_Bus.io_read_keep_i_1_n_0\ : STD_LOGIC;
  signal \Using_IO_Bus.io_read_keep_reg_n_0\ : STD_LOGIC;
  signal \Using_IO_Bus.lmb_io_select_keep_i_1_n_0\ : STD_LOGIC;
  signal io_bus_read_data : STD_LOGIC_VECTOR ( 16 downto 0 );
  signal io_ready_Q : STD_LOGIC;
  signal \lmb_abus_Q_reg_n_0_[1]\ : STD_LOGIC;
  signal \lmb_abus_Q_reg_n_0_[2]\ : STD_LOGIC;
  signal \lmb_abus_Q_reg_n_0_[3]\ : STD_LOGIC;
  signal \lmb_abus_Q_reg_n_0_[4]\ : STD_LOGIC;
  signal \lmb_abus_Q_reg_n_0_[5]\ : STD_LOGIC;
  signal lmb_io_select_keep : STD_LOGIC;
  signal lmb_reg_read : STD_LOGIC;
  signal lmb_reg_read0 : STD_LOGIC;
  signal lmb_reg_read_Q : STD_LOGIC;
  signal lmb_reg_write : STD_LOGIC;
  signal lmb_reg_write0 : STD_LOGIC;
  signal p_0_in18_in : STD_LOGIC;
  signal p_20_out : STD_LOGIC;
  signal p_21_out : STD_LOGIC;
  signal uart_tx_write : STD_LOGIC;
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of uart_tx_write : signal is "soft";
  signal uart_tx_write_inferred_i_2_n_0 : STD_LOGIC;
  signal write_data : STD_LOGIC_VECTOR ( 31 downto 0 );
  attribute RTL_KEEP of write_data : signal is "soft";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of Sl_Wait_INST_0 : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \Using_IO_Bus.IO_Read_Strobe_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \Using_IO_Bus.IO_Write_Strobe_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \Using_IO_Bus.io_ready_Q_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of lmb_reg_read_i_1 : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of lmb_reg_write_i_1 : label is "soft_lutpair19";
  attribute KEEP : string;
  attribute KEEP of \write_data_reg[0]\ : label is "yes";
  attribute KEEP of \write_data_reg[10]\ : label is "yes";
  attribute KEEP of \write_data_reg[11]\ : label is "yes";
  attribute KEEP of \write_data_reg[12]\ : label is "yes";
  attribute KEEP of \write_data_reg[13]\ : label is "yes";
  attribute KEEP of \write_data_reg[14]\ : label is "yes";
  attribute KEEP of \write_data_reg[15]\ : label is "yes";
  attribute KEEP of \write_data_reg[16]\ : label is "yes";
  attribute KEEP of \write_data_reg[17]\ : label is "yes";
  attribute KEEP of \write_data_reg[18]\ : label is "yes";
  attribute KEEP of \write_data_reg[19]\ : label is "yes";
  attribute KEEP of \write_data_reg[1]\ : label is "yes";
  attribute KEEP of \write_data_reg[20]\ : label is "yes";
  attribute KEEP of \write_data_reg[21]\ : label is "yes";
  attribute KEEP of \write_data_reg[22]\ : label is "yes";
  attribute KEEP of \write_data_reg[23]\ : label is "yes";
  attribute KEEP of \write_data_reg[24]\ : label is "yes";
  attribute KEEP of \write_data_reg[25]\ : label is "yes";
  attribute KEEP of \write_data_reg[26]\ : label is "yes";
  attribute KEEP of \write_data_reg[27]\ : label is "yes";
  attribute KEEP of \write_data_reg[28]\ : label is "yes";
  attribute KEEP of \write_data_reg[29]\ : label is "yes";
  attribute KEEP of \write_data_reg[2]\ : label is "yes";
  attribute KEEP of \write_data_reg[30]\ : label is "yes";
  attribute KEEP of \write_data_reg[31]\ : label is "yes";
  attribute KEEP of \write_data_reg[3]\ : label is "yes";
  attribute KEEP of \write_data_reg[4]\ : label is "yes";
  attribute KEEP of \write_data_reg[5]\ : label is "yes";
  attribute KEEP of \write_data_reg[6]\ : label is "yes";
  attribute KEEP of \write_data_reg[7]\ : label is "yes";
  attribute KEEP of \write_data_reg[8]\ : label is "yes";
  attribute KEEP of \write_data_reg[9]\ : label is "yes";
begin
  FIT2_Interrupt <= \<const0>\;
  FIT2_Toggle <= \<const0>\;
  FIT3_Interrupt <= \<const0>\;
  FIT3_Toggle <= \<const0>\;
  FIT4_Interrupt <= \<const0>\;
  FIT4_Toggle <= \<const0>\;
  GPI1_Interrupt <= \<const0>\;
  GPI2_Interrupt <= \<const0>\;
  GPI3_Interrupt <= \<const0>\;
  GPI4_Interrupt <= \<const0>\;
  GPO1(31) <= \<const0>\;
  GPO1(30) <= \<const0>\;
  GPO1(29) <= \<const0>\;
  GPO1(28) <= \<const0>\;
  GPO1(27) <= \<const0>\;
  GPO1(26) <= \<const0>\;
  GPO1(25) <= \<const0>\;
  GPO1(24) <= \<const0>\;
  GPO1(23) <= \<const0>\;
  GPO1(22) <= \<const0>\;
  GPO1(21) <= \<const0>\;
  GPO1(20) <= \<const0>\;
  GPO1(19) <= \<const0>\;
  GPO1(18) <= \<const0>\;
  GPO1(17) <= \<const0>\;
  GPO1(16) <= \<const0>\;
  GPO1(15) <= \<const0>\;
  GPO1(14) <= \<const0>\;
  GPO1(13) <= \<const0>\;
  GPO1(12) <= \<const0>\;
  GPO1(11) <= \<const0>\;
  GPO1(10) <= \<const0>\;
  GPO1(9) <= \<const0>\;
  GPO1(8) <= \<const0>\;
  GPO1(7) <= \<const0>\;
  GPO1(6) <= \<const0>\;
  GPO1(5) <= \<const0>\;
  GPO1(4) <= \<const0>\;
  GPO1(3) <= \<const0>\;
  GPO1(2) <= \<const0>\;
  GPO1(1) <= \<const0>\;
  GPO1(0) <= \<const0>\;
  GPO2(31) <= \<const0>\;
  GPO2(30) <= \<const0>\;
  GPO2(29) <= \<const0>\;
  GPO2(28) <= \<const0>\;
  GPO2(27) <= \<const0>\;
  GPO2(26) <= \<const0>\;
  GPO2(25) <= \<const0>\;
  GPO2(24) <= \<const0>\;
  GPO2(23) <= \<const0>\;
  GPO2(22) <= \<const0>\;
  GPO2(21) <= \<const0>\;
  GPO2(20) <= \<const0>\;
  GPO2(19) <= \<const0>\;
  GPO2(18) <= \<const0>\;
  GPO2(17) <= \<const0>\;
  GPO2(16) <= \<const0>\;
  GPO2(15) <= \<const0>\;
  GPO2(14) <= \<const0>\;
  GPO2(13) <= \<const0>\;
  GPO2(12) <= \<const0>\;
  GPO2(11) <= \<const0>\;
  GPO2(10) <= \<const0>\;
  GPO2(9) <= \<const0>\;
  GPO2(8) <= \<const0>\;
  GPO2(7) <= \<const0>\;
  GPO2(6) <= \<const0>\;
  GPO2(5) <= \<const0>\;
  GPO2(4) <= \<const0>\;
  GPO2(3) <= \<const0>\;
  GPO2(2) <= \<const0>\;
  GPO2(1) <= \<const0>\;
  GPO2(0) <= \<const0>\;
  GPO3(31) <= \<const0>\;
  GPO3(30) <= \<const0>\;
  GPO3(29) <= \<const0>\;
  GPO3(28) <= \<const0>\;
  GPO3(27) <= \<const0>\;
  GPO3(26) <= \<const0>\;
  GPO3(25) <= \<const0>\;
  GPO3(24) <= \<const0>\;
  GPO3(23) <= \<const0>\;
  GPO3(22) <= \<const0>\;
  GPO3(21) <= \<const0>\;
  GPO3(20) <= \<const0>\;
  GPO3(19) <= \<const0>\;
  GPO3(18) <= \<const0>\;
  GPO3(17) <= \<const0>\;
  GPO3(16) <= \<const0>\;
  GPO3(15) <= \<const0>\;
  GPO3(14) <= \<const0>\;
  GPO3(13) <= \<const0>\;
  GPO3(12) <= \<const0>\;
  GPO3(11) <= \<const0>\;
  GPO3(10) <= \<const0>\;
  GPO3(9) <= \<const0>\;
  GPO3(8) <= \<const0>\;
  GPO3(7) <= \<const0>\;
  GPO3(6) <= \<const0>\;
  GPO3(5) <= \<const0>\;
  GPO3(4) <= \<const0>\;
  GPO3(3) <= \<const0>\;
  GPO3(2) <= \<const0>\;
  GPO3(1) <= \<const0>\;
  GPO3(0) <= \<const0>\;
  GPO4(31) <= \<const0>\;
  GPO4(30) <= \<const0>\;
  GPO4(29) <= \<const0>\;
  GPO4(28) <= \<const0>\;
  GPO4(27) <= \<const0>\;
  GPO4(26) <= \<const0>\;
  GPO4(25) <= \<const0>\;
  GPO4(24) <= \<const0>\;
  GPO4(23) <= \<const0>\;
  GPO4(22) <= \<const0>\;
  GPO4(21) <= \<const0>\;
  GPO4(20) <= \<const0>\;
  GPO4(19) <= \<const0>\;
  GPO4(18) <= \<const0>\;
  GPO4(17) <= \<const0>\;
  GPO4(16) <= \<const0>\;
  GPO4(15) <= \<const0>\;
  GPO4(14) <= \<const0>\;
  GPO4(13) <= \<const0>\;
  GPO4(12) <= \<const0>\;
  GPO4(11) <= \<const0>\;
  GPO4(10) <= \<const0>\;
  GPO4(9) <= \<const0>\;
  GPO4(8) <= \<const0>\;
  GPO4(7) <= \<const0>\;
  GPO4(6) <= \<const0>\;
  GPO4(5) <= \<const0>\;
  GPO4(4) <= \<const0>\;
  GPO4(3) <= \<const0>\;
  GPO4(2) <= \<const0>\;
  GPO4(1) <= \<const0>\;
  GPO4(0) <= \<const0>\;
  INTC_IRQ <= \^intc_irq\;
  INTC_IRQ_OUT <= \^intc_irq\;
  INTC_Interrupt_Address(31) <= \<const0>\;
  INTC_Interrupt_Address(30) <= \<const0>\;
  INTC_Interrupt_Address(29) <= \<const0>\;
  INTC_Interrupt_Address(28) <= \<const0>\;
  INTC_Interrupt_Address(27) <= \<const0>\;
  INTC_Interrupt_Address(26) <= \<const0>\;
  INTC_Interrupt_Address(25) <= \<const0>\;
  INTC_Interrupt_Address(24) <= \<const0>\;
  INTC_Interrupt_Address(23) <= \<const0>\;
  INTC_Interrupt_Address(22) <= \<const0>\;
  INTC_Interrupt_Address(21) <= \<const0>\;
  INTC_Interrupt_Address(20) <= \<const0>\;
  INTC_Interrupt_Address(19) <= \<const0>\;
  INTC_Interrupt_Address(18) <= \<const0>\;
  INTC_Interrupt_Address(17) <= \<const0>\;
  INTC_Interrupt_Address(16 downto 2) <= \^intc_interrupt_address\(16 downto 2);
  INTC_Interrupt_Address(1) <= \<const0>\;
  INTC_Interrupt_Address(0) <= \<const0>\;
  PIT1_Interrupt <= \<const0>\;
  PIT1_Toggle <= \<const0>\;
  PIT2_Interrupt <= \<const0>\;
  PIT2_Toggle <= \<const0>\;
  PIT3_Interrupt <= \<const0>\;
  PIT3_Toggle <= \<const0>\;
  PIT4_Interrupt <= \<const0>\;
  PIT4_Toggle <= \<const0>\;
  Sl_CE <= \<const0>\;
  Sl_UE <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
IOModule_Core_I1: entity work.bd_fc5c_iomodule_0_0_Iomodule_core
     port map (
      Clk => Clk,
      E(0) => uart_tx_write,
      FIT1_Interrupt => FIT1_Interrupt,
      FIT1_Toggle => FIT1_Toggle,
      INTC_IRQ => \^intc_irq\,
      INTC_Interrupt(0) => INTC_Interrupt(0),
      INTC_Interrupt_Address(14 downto 0) => \^intc_interrupt_address\(16 downto 2),
      INTC_Processor_Ack(1 downto 0) => INTC_Processor_Ack(1 downto 0),
      Q(5) => p_0_in18_in,
      Q(4) => \lmb_abus_Q_reg_n_0_[1]\,
      Q(3) => \lmb_abus_Q_reg_n_0_[2]\,
      Q(2) => \lmb_abus_Q_reg_n_0_[3]\,
      Q(1) => \lmb_abus_Q_reg_n_0_[4]\,
      Q(0) => \lmb_abus_Q_reg_n_0_[5]\,
      Rst => Rst,
      Sl_DBus(8) => Sl_DBus(15),
      Sl_DBus(7) => Sl_DBus(24),
      Sl_DBus(6) => Sl_DBus(25),
      Sl_DBus(5) => Sl_DBus(26),
      Sl_DBus(4) => Sl_DBus(27),
      Sl_DBus(3) => Sl_DBus(28),
      Sl_DBus(2) => Sl_DBus(29),
      Sl_DBus(1) => Sl_DBus(30),
      Sl_DBus(0) => Sl_DBus(31),
      UART_Interrupt => UART_Interrupt,
      UART_Rx => UART_Rx,
      UART_Tx => UART_Tx,
      io_bus_read_data(8) => io_bus_read_data(16),
      io_bus_read_data(7 downto 0) => io_bus_read_data(7 downto 0),
      lmb_reg_read => lmb_reg_read,
      lmb_reg_write => lmb_reg_write,
      \out\(16 downto 0) => write_data(16 downto 0)
    );
Sl_Ready_INST_0: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => lmb_reg_read_Q,
      I1 => lmb_reg_write,
      I2 => io_ready_Q,
      O => Sl_Ready
    );
Sl_Wait_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => lmb_io_select_keep,
      I1 => lmb_reg_read,
      O => Sl_Wait
    );
\Using_IO_Bus.IO_Addr_Strobe_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => LMB_AddrStrobe,
      I1 => LMB_ABus(0),
      I2 => LMB_ABus(1),
      O => p_21_out
    );
\Using_IO_Bus.IO_Addr_Strobe_reg\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => p_21_out,
      Q => IO_Addr_Strobe,
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(31),
      Q => IO_Address(0),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(21),
      Q => IO_Address(10),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(20),
      Q => IO_Address(11),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(19),
      Q => IO_Address(12),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(18),
      Q => IO_Address(13),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(17),
      Q => IO_Address(14),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(16),
      Q => IO_Address(15),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(15),
      Q => IO_Address(16),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(14),
      Q => IO_Address(17),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(13),
      Q => IO_Address(18),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(12),
      Q => IO_Address(19),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(30),
      Q => IO_Address(1),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(11),
      Q => IO_Address(20),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(10),
      Q => IO_Address(21),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(9),
      Q => IO_Address(22),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(8),
      Q => IO_Address(23),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(7),
      Q => IO_Address(24),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(6),
      Q => IO_Address(25),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(5),
      Q => IO_Address(26),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(4),
      Q => IO_Address(27),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(3),
      Q => IO_Address(28),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(2),
      Q => IO_Address(29),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(29),
      Q => IO_Address(2),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(1),
      Q => IO_Address(30),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(0),
      Q => IO_Address(31),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(28),
      Q => IO_Address(3),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(27),
      Q => IO_Address(4),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(26),
      Q => IO_Address(5),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(25),
      Q => IO_Address(6),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(24),
      Q => IO_Address(7),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(23),
      Q => IO_Address(8),
      R => Rst
    );
\Using_IO_Bus.IO_Address_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_ABus(22),
      Q => IO_Address(9),
      R => Rst
    );
\Using_IO_Bus.IO_Byte_Enable_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_BE(3),
      Q => IO_Byte_Enable(0),
      R => Rst
    );
\Using_IO_Bus.IO_Byte_Enable_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_BE(2),
      Q => IO_Byte_Enable(1),
      R => Rst
    );
\Using_IO_Bus.IO_Byte_Enable_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_BE(1),
      Q => IO_Byte_Enable(2),
      R => Rst
    );
\Using_IO_Bus.IO_Byte_Enable_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_BE(0),
      Q => IO_Byte_Enable(3),
      R => Rst
    );
\Using_IO_Bus.IO_Read_Strobe_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => LMB_ReadStrobe,
      I1 => LMB_ABus(1),
      I2 => LMB_ABus(0),
      I3 => LMB_AddrStrobe,
      O => \IO_Read_Strobe__0\
    );
\Using_IO_Bus.IO_Read_Strobe_reg\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \IO_Read_Strobe__0\,
      Q => IO_Read_Strobe,
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(31),
      Q => IO_Write_Data(0),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(21),
      Q => IO_Write_Data(10),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(20),
      Q => IO_Write_Data(11),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(19),
      Q => IO_Write_Data(12),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(18),
      Q => IO_Write_Data(13),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(17),
      Q => IO_Write_Data(14),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(16),
      Q => IO_Write_Data(15),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(15),
      Q => IO_Write_Data(16),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(14),
      Q => IO_Write_Data(17),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(13),
      Q => IO_Write_Data(18),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(12),
      Q => IO_Write_Data(19),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(30),
      Q => IO_Write_Data(1),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(11),
      Q => IO_Write_Data(20),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(10),
      Q => IO_Write_Data(21),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(9),
      Q => IO_Write_Data(22),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(8),
      Q => IO_Write_Data(23),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(7),
      Q => IO_Write_Data(24),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(6),
      Q => IO_Write_Data(25),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(5),
      Q => IO_Write_Data(26),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(4),
      Q => IO_Write_Data(27),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(3),
      Q => IO_Write_Data(28),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(2),
      Q => IO_Write_Data(29),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(29),
      Q => IO_Write_Data(2),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(1),
      Q => IO_Write_Data(30),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(0),
      Q => IO_Write_Data(31),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(28),
      Q => IO_Write_Data(3),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(27),
      Q => IO_Write_Data(4),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(26),
      Q => IO_Write_Data(5),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(25),
      Q => IO_Write_Data(6),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(24),
      Q => IO_Write_Data(7),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(23),
      Q => IO_Write_Data(8),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Data_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => p_21_out,
      D => LMB_WriteDBus(22),
      Q => IO_Write_Data(9),
      R => Rst
    );
\Using_IO_Bus.IO_Write_Strobe_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => LMB_WriteStrobe,
      I1 => LMB_ABus(1),
      I2 => LMB_ABus(0),
      I3 => LMB_AddrStrobe,
      O => \IO_Write_Strobe__0\
    );
\Using_IO_Bus.IO_Write_Strobe_reg\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \IO_Write_Strobe__0\,
      Q => IO_Write_Strobe,
      R => Rst
    );
\Using_IO_Bus.io_bus_read_data[31]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => IO_Ready,
      I1 => \Using_IO_Bus.io_read_keep_reg_n_0\,
      O => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(0),
      Q => io_bus_read_data(0),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(10),
      Q => Sl_DBus(21),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(11),
      Q => Sl_DBus(20),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(12),
      Q => Sl_DBus(19),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(13),
      Q => Sl_DBus(18),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(14),
      Q => Sl_DBus(17),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(15),
      Q => Sl_DBus(16),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(16),
      Q => io_bus_read_data(16),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(17),
      Q => Sl_DBus(14),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(18),
      Q => Sl_DBus(13),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(19),
      Q => Sl_DBus(12),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(1),
      Q => io_bus_read_data(1),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(20),
      Q => Sl_DBus(11),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(21),
      Q => Sl_DBus(10),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(22),
      Q => Sl_DBus(9),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(23),
      Q => Sl_DBus(8),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(24),
      Q => Sl_DBus(7),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(25),
      Q => Sl_DBus(6),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(26),
      Q => Sl_DBus(5),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(27),
      Q => Sl_DBus(4),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(28),
      Q => Sl_DBus(3),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(29),
      Q => Sl_DBus(2),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(2),
      Q => io_bus_read_data(2),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(30),
      Q => Sl_DBus(1),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(31),
      Q => Sl_DBus(0),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(3),
      Q => io_bus_read_data(3),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(4),
      Q => io_bus_read_data(4),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(5),
      Q => io_bus_read_data(5),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(6),
      Q => io_bus_read_data(6),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(7),
      Q => io_bus_read_data(7),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(8),
      Q => Sl_DBus(23),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_bus_read_data_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => IO_Read_Data(9),
      Q => Sl_DBus(22),
      R => \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0\
    );
\Using_IO_Bus.io_read_keep_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A3333333A0000000"
    )
        port map (
      I0 => LMB_ReadStrobe,
      I1 => IO_Ready,
      I2 => LMB_ABus(1),
      I3 => LMB_ABus(0),
      I4 => LMB_AddrStrobe,
      I5 => \Using_IO_Bus.io_read_keep_reg_n_0\,
      O => \Using_IO_Bus.io_read_keep_i_1_n_0\
    );
\Using_IO_Bus.io_read_keep_reg\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \Using_IO_Bus.io_read_keep_i_1_n_0\,
      Q => \Using_IO_Bus.io_read_keep_reg_n_0\,
      R => Rst
    );
\Using_IO_Bus.io_ready_Q_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => IO_Ready,
      I1 => lmb_io_select_keep,
      O => p_20_out
    );
\Using_IO_Bus.io_ready_Q_reg\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => p_20_out,
      Q => io_ready_Q,
      R => '0'
    );
\Using_IO_Bus.lmb_io_select_keep_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"D555C000"
    )
        port map (
      I0 => IO_Ready,
      I1 => LMB_ABus(1),
      I2 => LMB_ABus(0),
      I3 => LMB_AddrStrobe,
      I4 => lmb_io_select_keep,
      O => \Using_IO_Bus.lmb_io_select_keep_i_1_n_0\
    );
\Using_IO_Bus.lmb_io_select_keep_reg\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => \Using_IO_Bus.lmb_io_select_keep_i_1_n_0\,
      Q => lmb_io_select_keep,
      R => Rst
    );
\lmb_abus_Q_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_ABus(24),
      Q => p_0_in18_in,
      R => '0'
    );
\lmb_abus_Q_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_ABus(25),
      Q => \lmb_abus_Q_reg_n_0_[1]\,
      R => '0'
    );
\lmb_abus_Q_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_ABus(26),
      Q => \lmb_abus_Q_reg_n_0_[2]\,
      R => '0'
    );
\lmb_abus_Q_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_ABus(27),
      Q => \lmb_abus_Q_reg_n_0_[3]\,
      R => '0'
    );
\lmb_abus_Q_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_ABus(28),
      Q => \lmb_abus_Q_reg_n_0_[4]\,
      R => '0'
    );
\lmb_abus_Q_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_ABus(29),
      Q => \lmb_abus_Q_reg_n_0_[5]\,
      R => '0'
    );
lmb_reg_read_Q_reg: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => lmb_reg_read,
      Q => lmb_reg_read_Q,
      R => '0'
    );
lmb_reg_read_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => LMB_ABus(1),
      I1 => LMB_ABus(0),
      I2 => LMB_AddrStrobe,
      I3 => LMB_ReadStrobe,
      O => lmb_reg_read0
    );
lmb_reg_read_reg: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => lmb_reg_read0,
      Q => lmb_reg_read,
      R => '0'
    );
lmb_reg_write_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => LMB_ABus(1),
      I1 => LMB_ABus(0),
      I2 => LMB_AddrStrobe,
      I3 => LMB_WriteStrobe,
      O => lmb_reg_write0
    );
lmb_reg_write_reg: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => lmb_reg_write0,
      Q => lmb_reg_write,
      R => '0'
    );
uart_tx_write_inferred_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000800"
    )
        port map (
      I0 => uart_tx_write_inferred_i_2_n_0,
      I1 => lmb_reg_write,
      I2 => p_0_in18_in,
      I3 => \lmb_abus_Q_reg_n_0_[5]\,
      I4 => \lmb_abus_Q_reg_n_0_[4]\,
      I5 => \lmb_abus_Q_reg_n_0_[1]\,
      O => uart_tx_write
    );
uart_tx_write_inferred_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \lmb_abus_Q_reg_n_0_[2]\,
      I1 => \lmb_abus_Q_reg_n_0_[3]\,
      O => uart_tx_write_inferred_i_2_n_0
    );
\write_data_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(31),
      Q => write_data(0),
      R => '0'
    );
\write_data_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(21),
      Q => write_data(10),
      R => '0'
    );
\write_data_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(20),
      Q => write_data(11),
      R => '0'
    );
\write_data_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(19),
      Q => write_data(12),
      R => '0'
    );
\write_data_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(18),
      Q => write_data(13),
      R => '0'
    );
\write_data_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(17),
      Q => write_data(14),
      R => '0'
    );
\write_data_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(16),
      Q => write_data(15),
      R => '0'
    );
\write_data_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(15),
      Q => write_data(16),
      R => '0'
    );
\write_data_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(14),
      Q => write_data(17),
      R => '0'
    );
\write_data_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(13),
      Q => write_data(18),
      R => '0'
    );
\write_data_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(12),
      Q => write_data(19),
      R => '0'
    );
\write_data_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(30),
      Q => write_data(1),
      R => '0'
    );
\write_data_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(11),
      Q => write_data(20),
      R => '0'
    );
\write_data_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(10),
      Q => write_data(21),
      R => '0'
    );
\write_data_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(9),
      Q => write_data(22),
      R => '0'
    );
\write_data_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(8),
      Q => write_data(23),
      R => '0'
    );
\write_data_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(7),
      Q => write_data(24),
      R => '0'
    );
\write_data_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(6),
      Q => write_data(25),
      R => '0'
    );
\write_data_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(5),
      Q => write_data(26),
      R => '0'
    );
\write_data_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(4),
      Q => write_data(27),
      R => '0'
    );
\write_data_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(3),
      Q => write_data(28),
      R => '0'
    );
\write_data_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(2),
      Q => write_data(29),
      R => '0'
    );
\write_data_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(29),
      Q => write_data(2),
      R => '0'
    );
\write_data_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(1),
      Q => write_data(30),
      R => '0'
    );
\write_data_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(0),
      Q => write_data(31),
      R => '0'
    );
\write_data_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(28),
      Q => write_data(3),
      R => '0'
    );
\write_data_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(27),
      Q => write_data(4),
      R => '0'
    );
\write_data_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(26),
      Q => write_data(5),
      R => '0'
    );
\write_data_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(25),
      Q => write_data(6),
      R => '0'
    );
\write_data_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(24),
      Q => write_data(7),
      R => '0'
    );
\write_data_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(23),
      Q => write_data(8),
      R => '0'
    );
\write_data_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => Clk,
      CE => '1',
      D => LMB_WriteDBus(22),
      Q => write_data(9),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_fc5c_iomodule_0_0 is
  port (
    Clk : in STD_LOGIC;
    Rst : in STD_LOGIC;
    IO_Addr_Strobe : out STD_LOGIC;
    IO_Read_Strobe : out STD_LOGIC;
    IO_Write_Strobe : out STD_LOGIC;
    IO_Address : out STD_LOGIC_VECTOR ( 31 downto 0 );
    IO_Byte_Enable : out STD_LOGIC_VECTOR ( 3 downto 0 );
    IO_Write_Data : out STD_LOGIC_VECTOR ( 31 downto 0 );
    IO_Read_Data : in STD_LOGIC_VECTOR ( 31 downto 0 );
    IO_Ready : in STD_LOGIC;
    UART_Rx : in STD_LOGIC;
    UART_Tx : out STD_LOGIC;
    UART_Interrupt : out STD_LOGIC;
    FIT1_Toggle : out STD_LOGIC;
    INTC_Interrupt : in STD_LOGIC_VECTOR ( 0 to 0 );
    INTC_IRQ : out STD_LOGIC;
    INTC_Processor_Ack : in STD_LOGIC_VECTOR ( 1 downto 0 );
    INTC_Interrupt_Address : out STD_LOGIC_VECTOR ( 31 downto 0 );
    INTC_IRQ_OUT : out STD_LOGIC;
    LMB_ABus : in STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_WriteDBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_AddrStrobe : in STD_LOGIC;
    LMB_ReadStrobe : in STD_LOGIC;
    LMB_WriteStrobe : in STD_LOGIC;
    LMB_BE : in STD_LOGIC_VECTOR ( 0 to 3 );
    Sl_DBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    Sl_Ready : out STD_LOGIC;
    Sl_Wait : out STD_LOGIC;
    Sl_UE : out STD_LOGIC;
    Sl_CE : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of bd_fc5c_iomodule_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of bd_fc5c_iomodule_0_0 : entity is "bd_fc5c_iomodule_0_0,iomodule,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of bd_fc5c_iomodule_0_0 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of bd_fc5c_iomodule_0_0 : entity is "iomodule,Vivado 2016.2";
end bd_fc5c_iomodule_0_0;

architecture STRUCTURE of bd_fc5c_iomodule_0_0 is
  signal NLW_U0_FIT1_Interrupt_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_FIT2_Interrupt_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_FIT2_Toggle_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_FIT3_Interrupt_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_FIT3_Toggle_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_FIT4_Interrupt_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_FIT4_Toggle_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_GPI1_Interrupt_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_GPI2_Interrupt_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_GPI3_Interrupt_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_GPI4_Interrupt_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_PIT1_Interrupt_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_PIT1_Toggle_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_PIT2_Interrupt_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_PIT2_Toggle_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_PIT3_Interrupt_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_PIT3_Toggle_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_PIT4_Interrupt_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_PIT4_Toggle_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_GPO1_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_U0_GPO2_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_U0_GPO3_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal NLW_U0_GPO4_UNCONNECTED : STD_LOGIC_VECTOR ( 31 downto 0 );
  attribute C_AVOID_PRIMITIVES : integer;
  attribute C_AVOID_PRIMITIVES of U0 : label is 0;
  attribute C_BASEADDR : string;
  attribute C_BASEADDR of U0 : label is "64'b0000000000000000000000000000000010000000000000000000000000000000";
  attribute C_FAMILY : string;
  attribute C_FAMILY of U0 : label is "kintex7";
  attribute C_FIT1_INTERRUPT : integer;
  attribute C_FIT1_INTERRUPT of U0 : label is 0;
  attribute C_FIT1_No_CLOCKS : integer;
  attribute C_FIT1_No_CLOCKS of U0 : label is 6216;
  attribute C_FIT2_INTERRUPT : integer;
  attribute C_FIT2_INTERRUPT of U0 : label is 0;
  attribute C_FIT2_No_CLOCKS : integer;
  attribute C_FIT2_No_CLOCKS of U0 : label is 6216;
  attribute C_FIT3_INTERRUPT : integer;
  attribute C_FIT3_INTERRUPT of U0 : label is 0;
  attribute C_FIT3_No_CLOCKS : integer;
  attribute C_FIT3_No_CLOCKS of U0 : label is 6216;
  attribute C_FIT4_INTERRUPT : integer;
  attribute C_FIT4_INTERRUPT of U0 : label is 0;
  attribute C_FIT4_No_CLOCKS : integer;
  attribute C_FIT4_No_CLOCKS of U0 : label is 6216;
  attribute C_FREQ : integer;
  attribute C_FREQ of U0 : label is 100000000;
  attribute C_GPI1_INTERRUPT : integer;
  attribute C_GPI1_INTERRUPT of U0 : label is 0;
  attribute C_GPI1_SIZE : integer;
  attribute C_GPI1_SIZE of U0 : label is 32;
  attribute C_GPI2_INTERRUPT : integer;
  attribute C_GPI2_INTERRUPT of U0 : label is 0;
  attribute C_GPI2_SIZE : integer;
  attribute C_GPI2_SIZE of U0 : label is 32;
  attribute C_GPI3_INTERRUPT : integer;
  attribute C_GPI3_INTERRUPT of U0 : label is 0;
  attribute C_GPI3_SIZE : integer;
  attribute C_GPI3_SIZE of U0 : label is 32;
  attribute C_GPI4_INTERRUPT : integer;
  attribute C_GPI4_INTERRUPT of U0 : label is 0;
  attribute C_GPI4_SIZE : integer;
  attribute C_GPI4_SIZE of U0 : label is 32;
  attribute C_GPO1_INIT : integer;
  attribute C_GPO1_INIT of U0 : label is 0;
  attribute C_GPO1_SIZE : integer;
  attribute C_GPO1_SIZE of U0 : label is 32;
  attribute C_GPO2_INIT : integer;
  attribute C_GPO2_INIT of U0 : label is 0;
  attribute C_GPO2_SIZE : integer;
  attribute C_GPO2_SIZE of U0 : label is 32;
  attribute C_GPO3_INIT : integer;
  attribute C_GPO3_INIT of U0 : label is 0;
  attribute C_GPO3_SIZE : integer;
  attribute C_GPO3_SIZE of U0 : label is 32;
  attribute C_GPO4_INIT : integer;
  attribute C_GPO4_INIT of U0 : label is 0;
  attribute C_GPO4_SIZE : integer;
  attribute C_GPO4_SIZE of U0 : label is 32;
  attribute C_HIGHADDR : string;
  attribute C_HIGHADDR of U0 : label is "64'b0000000000000000000000000000000010000000000000001111111111111111";
  attribute C_INSTANCE : string;
  attribute C_INSTANCE of U0 : label is "iomodule";
  attribute C_INTC_ADDR_WIDTH : integer;
  attribute C_INTC_ADDR_WIDTH of U0 : label is 17;
  attribute C_INTC_ASYNC_INTR : string;
  attribute C_INTC_ASYNC_INTR of U0 : label is "16'b1111111111111111";
  attribute C_INTC_BASE_VECTORS : integer;
  attribute C_INTC_BASE_VECTORS of U0 : label is 0;
  attribute C_INTC_HAS_FAST : integer;
  attribute C_INTC_HAS_FAST of U0 : label is 1;
  attribute C_INTC_INTR_SIZE : integer;
  attribute C_INTC_INTR_SIZE of U0 : label is 1;
  attribute C_INTC_LEVEL_EDGE : string;
  attribute C_INTC_LEVEL_EDGE of U0 : label is "16'b0000000000000000";
  attribute C_INTC_NUM_SYNC_FF : integer;
  attribute C_INTC_NUM_SYNC_FF of U0 : label is 2;
  attribute C_INTC_POSITIVE : string;
  attribute C_INTC_POSITIVE of U0 : label is "16'b1111111111111111";
  attribute C_INTC_USE_EXT_INTR : integer;
  attribute C_INTC_USE_EXT_INTR of U0 : label is 1;
  attribute C_IO_BASEADDR : string;
  attribute C_IO_BASEADDR of U0 : label is "64'b0000000000000000000000000000000011000000000000000000000000000000";
  attribute C_IO_HIGHADDR : string;
  attribute C_IO_HIGHADDR of U0 : label is "64'b0000000000000000000000000000000011111111111111111111111111111111";
  attribute C_IO_MASK : string;
  attribute C_IO_MASK of U0 : label is "64'b0000000000000000000000000000000011000000000000000000000000000000";
  attribute C_LMB_AWIDTH : integer;
  attribute C_LMB_AWIDTH of U0 : label is 32;
  attribute C_LMB_DWIDTH : integer;
  attribute C_LMB_DWIDTH of U0 : label is 32;
  attribute C_MASK : string;
  attribute C_MASK of U0 : label is "64'b0000000000000000000000000000000011000000000000000000000000000000";
  attribute C_PIT1_INTERRUPT : integer;
  attribute C_PIT1_INTERRUPT of U0 : label is 0;
  attribute C_PIT1_PRESCALER : integer;
  attribute C_PIT1_PRESCALER of U0 : label is 0;
  attribute C_PIT1_READABLE : integer;
  attribute C_PIT1_READABLE of U0 : label is 1;
  attribute C_PIT1_SIZE : integer;
  attribute C_PIT1_SIZE of U0 : label is 32;
  attribute C_PIT2_INTERRUPT : integer;
  attribute C_PIT2_INTERRUPT of U0 : label is 0;
  attribute C_PIT2_PRESCALER : integer;
  attribute C_PIT2_PRESCALER of U0 : label is 0;
  attribute C_PIT2_READABLE : integer;
  attribute C_PIT2_READABLE of U0 : label is 1;
  attribute C_PIT2_SIZE : integer;
  attribute C_PIT2_SIZE of U0 : label is 32;
  attribute C_PIT3_INTERRUPT : integer;
  attribute C_PIT3_INTERRUPT of U0 : label is 0;
  attribute C_PIT3_PRESCALER : integer;
  attribute C_PIT3_PRESCALER of U0 : label is 0;
  attribute C_PIT3_READABLE : integer;
  attribute C_PIT3_READABLE of U0 : label is 1;
  attribute C_PIT3_SIZE : integer;
  attribute C_PIT3_SIZE of U0 : label is 32;
  attribute C_PIT4_INTERRUPT : integer;
  attribute C_PIT4_INTERRUPT of U0 : label is 0;
  attribute C_PIT4_PRESCALER : integer;
  attribute C_PIT4_PRESCALER of U0 : label is 0;
  attribute C_PIT4_READABLE : integer;
  attribute C_PIT4_READABLE of U0 : label is 1;
  attribute C_PIT4_SIZE : integer;
  attribute C_PIT4_SIZE of U0 : label is 32;
  attribute C_UART_BAUDRATE : integer;
  attribute C_UART_BAUDRATE of U0 : label is 115200;
  attribute C_UART_DATA_BITS : integer;
  attribute C_UART_DATA_BITS of U0 : label is 8;
  attribute C_UART_ERROR_INTERRUPT : integer;
  attribute C_UART_ERROR_INTERRUPT of U0 : label is 0;
  attribute C_UART_ODD_PARITY : integer;
  attribute C_UART_ODD_PARITY of U0 : label is 0;
  attribute C_UART_PROG_BAUDRATE : integer;
  attribute C_UART_PROG_BAUDRATE of U0 : label is 0;
  attribute C_UART_RX_INTERRUPT : integer;
  attribute C_UART_RX_INTERRUPT of U0 : label is 1;
  attribute C_UART_TX_INTERRUPT : integer;
  attribute C_UART_TX_INTERRUPT of U0 : label is 1;
  attribute C_UART_USE_PARITY : integer;
  attribute C_UART_USE_PARITY of U0 : label is 0;
  attribute C_USE_CONFIG_RESET : integer;
  attribute C_USE_CONFIG_RESET of U0 : label is 0;
  attribute C_USE_FIT1 : integer;
  attribute C_USE_FIT1 of U0 : label is 1;
  attribute C_USE_FIT2 : integer;
  attribute C_USE_FIT2 of U0 : label is 0;
  attribute C_USE_FIT3 : integer;
  attribute C_USE_FIT3 of U0 : label is 0;
  attribute C_USE_FIT4 : integer;
  attribute C_USE_FIT4 of U0 : label is 0;
  attribute C_USE_GPI1 : integer;
  attribute C_USE_GPI1 of U0 : label is 0;
  attribute C_USE_GPI2 : integer;
  attribute C_USE_GPI2 of U0 : label is 0;
  attribute C_USE_GPI3 : integer;
  attribute C_USE_GPI3 of U0 : label is 0;
  attribute C_USE_GPI4 : integer;
  attribute C_USE_GPI4 of U0 : label is 0;
  attribute C_USE_GPO1 : integer;
  attribute C_USE_GPO1 of U0 : label is 0;
  attribute C_USE_GPO2 : integer;
  attribute C_USE_GPO2 of U0 : label is 0;
  attribute C_USE_GPO3 : integer;
  attribute C_USE_GPO3 of U0 : label is 0;
  attribute C_USE_GPO4 : integer;
  attribute C_USE_GPO4 of U0 : label is 0;
  attribute C_USE_IO_BUS : integer;
  attribute C_USE_IO_BUS of U0 : label is 1;
  attribute C_USE_PIT1 : integer;
  attribute C_USE_PIT1 of U0 : label is 0;
  attribute C_USE_PIT2 : integer;
  attribute C_USE_PIT2 of U0 : label is 0;
  attribute C_USE_PIT3 : integer;
  attribute C_USE_PIT3 of U0 : label is 0;
  attribute C_USE_PIT4 : integer;
  attribute C_USE_PIT4 of U0 : label is 0;
  attribute C_USE_UART_RX : integer;
  attribute C_USE_UART_RX of U0 : label is 1;
  attribute C_USE_UART_TX : integer;
  attribute C_USE_UART_TX of U0 : label is 1;
begin
U0: entity work.bd_fc5c_iomodule_0_0_iomodule
     port map (
      Clk => Clk,
      Config_Reset => '0',
      FIT1_Interrupt => NLW_U0_FIT1_Interrupt_UNCONNECTED,
      FIT1_Toggle => FIT1_Toggle,
      FIT2_Interrupt => NLW_U0_FIT2_Interrupt_UNCONNECTED,
      FIT2_Toggle => NLW_U0_FIT2_Toggle_UNCONNECTED,
      FIT3_Interrupt => NLW_U0_FIT3_Interrupt_UNCONNECTED,
      FIT3_Toggle => NLW_U0_FIT3_Toggle_UNCONNECTED,
      FIT4_Interrupt => NLW_U0_FIT4_Interrupt_UNCONNECTED,
      FIT4_Toggle => NLW_U0_FIT4_Toggle_UNCONNECTED,
      GPI1(31 downto 0) => B"00000000000000000000000000000000",
      GPI1_Interrupt => NLW_U0_GPI1_Interrupt_UNCONNECTED,
      GPI2(31 downto 0) => B"00000000000000000000000000000000",
      GPI2_Interrupt => NLW_U0_GPI2_Interrupt_UNCONNECTED,
      GPI3(31 downto 0) => B"00000000000000000000000000000000",
      GPI3_Interrupt => NLW_U0_GPI3_Interrupt_UNCONNECTED,
      GPI4(31 downto 0) => B"00000000000000000000000000000000",
      GPI4_Interrupt => NLW_U0_GPI4_Interrupt_UNCONNECTED,
      GPO1(31 downto 0) => NLW_U0_GPO1_UNCONNECTED(31 downto 0),
      GPO2(31 downto 0) => NLW_U0_GPO2_UNCONNECTED(31 downto 0),
      GPO3(31 downto 0) => NLW_U0_GPO3_UNCONNECTED(31 downto 0),
      GPO4(31 downto 0) => NLW_U0_GPO4_UNCONNECTED(31 downto 0),
      INTC_IRQ => INTC_IRQ,
      INTC_IRQ_OUT => INTC_IRQ_OUT,
      INTC_Interrupt(0) => INTC_Interrupt(0),
      INTC_Interrupt_Address(31 downto 0) => INTC_Interrupt_Address(31 downto 0),
      INTC_Processor_Ack(1 downto 0) => INTC_Processor_Ack(1 downto 0),
      IO_Addr_Strobe => IO_Addr_Strobe,
      IO_Address(31 downto 0) => IO_Address(31 downto 0),
      IO_Byte_Enable(3 downto 0) => IO_Byte_Enable(3 downto 0),
      IO_Read_Data(31 downto 0) => IO_Read_Data(31 downto 0),
      IO_Read_Strobe => IO_Read_Strobe,
      IO_Ready => IO_Ready,
      IO_Write_Data(31 downto 0) => IO_Write_Data(31 downto 0),
      IO_Write_Strobe => IO_Write_Strobe,
      LMB_ABus(0 to 31) => LMB_ABus(0 to 31),
      LMB_AddrStrobe => LMB_AddrStrobe,
      LMB_BE(0 to 3) => LMB_BE(0 to 3),
      LMB_ReadStrobe => LMB_ReadStrobe,
      LMB_WriteDBus(0 to 31) => LMB_WriteDBus(0 to 31),
      LMB_WriteStrobe => LMB_WriteStrobe,
      PIT1_Enable => '0',
      PIT1_Interrupt => NLW_U0_PIT1_Interrupt_UNCONNECTED,
      PIT1_Toggle => NLW_U0_PIT1_Toggle_UNCONNECTED,
      PIT2_Enable => '0',
      PIT2_Interrupt => NLW_U0_PIT2_Interrupt_UNCONNECTED,
      PIT2_Toggle => NLW_U0_PIT2_Toggle_UNCONNECTED,
      PIT3_Enable => '0',
      PIT3_Interrupt => NLW_U0_PIT3_Interrupt_UNCONNECTED,
      PIT3_Toggle => NLW_U0_PIT3_Toggle_UNCONNECTED,
      PIT4_Enable => '0',
      PIT4_Interrupt => NLW_U0_PIT4_Interrupt_UNCONNECTED,
      PIT4_Toggle => NLW_U0_PIT4_Toggle_UNCONNECTED,
      Rst => Rst,
      Sl_CE => Sl_CE,
      Sl_DBus(0 to 31) => Sl_DBus(0 to 31),
      Sl_Ready => Sl_Ready,
      Sl_UE => Sl_UE,
      Sl_Wait => Sl_Wait,
      UART_Interrupt => UART_Interrupt,
      UART_Rx => UART_Rx,
      UART_Tx => UART_Tx
    );
end STRUCTURE;
