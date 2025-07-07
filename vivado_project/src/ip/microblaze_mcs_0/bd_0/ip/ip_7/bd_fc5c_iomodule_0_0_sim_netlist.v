// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
// Date        : Fri Mar 22 16:55:09 2024
// Host        : mu2euem.dhcp.fnal.gov running 64-bit Scientific Linux release 7.9 (Nitrogen)
// Command     : write_verilog -force -mode funcsim
//               /root/Documents/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/microblaze_mcs_0/bd_0/ip/ip_7/bd_fc5c_iomodule_0_0_sim_netlist.v
// Design      : bd_fc5c_iomodule_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k420tffg1156-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "bd_fc5c_iomodule_0_0,iomodule,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "iomodule,Vivado 2016.2" *) 
(* NotValidForBitStream *)
module bd_fc5c_iomodule_0_0
   (Clk,
    Rst,
    IO_Addr_Strobe,
    IO_Read_Strobe,
    IO_Write_Strobe,
    IO_Address,
    IO_Byte_Enable,
    IO_Write_Data,
    IO_Read_Data,
    IO_Ready,
    UART_Rx,
    UART_Tx,
    UART_Interrupt,
    FIT1_Toggle,
    INTC_Interrupt,
    INTC_IRQ,
    INTC_Processor_Ack,
    INTC_Interrupt_Address,
    INTC_IRQ_OUT,
    LMB_ABus,
    LMB_WriteDBus,
    LMB_AddrStrobe,
    LMB_ReadStrobe,
    LMB_WriteStrobe,
    LMB_BE,
    Sl_DBus,
    Sl_Ready,
    Sl_Wait,
    Sl_UE,
    Sl_CE);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 CLK.CLK CLK" *) input Clk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 RST.Rst RST" *) input Rst;
  (* x_interface_info = "xilinx.com:interface:mcsio_bus:1.0 IO_BUS ADDR_STROBE" *) output IO_Addr_Strobe;
  (* x_interface_info = "xilinx.com:interface:mcsio_bus:1.0 IO_BUS READ_STROBE" *) output IO_Read_Strobe;
  (* x_interface_info = "xilinx.com:interface:mcsio_bus:1.0 IO_BUS WRITE_STROBE" *) output IO_Write_Strobe;
  (* x_interface_info = "xilinx.com:interface:mcsio_bus:1.0 IO_BUS ADDRESS" *) output [31:0]IO_Address;
  (* x_interface_info = "xilinx.com:interface:mcsio_bus:1.0 IO_BUS BYTE_ENABLE" *) output [3:0]IO_Byte_Enable;
  (* x_interface_info = "xilinx.com:interface:mcsio_bus:1.0 IO_BUS WRITE_DATA" *) output [31:0]IO_Write_Data;
  (* x_interface_info = "xilinx.com:interface:mcsio_bus:1.0 IO_BUS READ_DATA" *) input [31:0]IO_Read_Data;
  (* x_interface_info = "xilinx.com:interface:mcsio_bus:1.0 IO_BUS READY" *) input IO_Ready;
  (* x_interface_info = "xilinx.com:interface:uart:1.0 UART RxD" *) input UART_Rx;
  (* x_interface_info = "xilinx.com:interface:uart:1.0 UART TxD" *) output UART_Tx;
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 INTERRUPT.UART_Interrupt INTERRUPT" *) output UART_Interrupt;
  output FIT1_Toggle;
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 INTC_Interrupt INTERRUPT" *) input [0:0]INTC_Interrupt;
  (* x_interface_info = "xilinx.com:interface:mbinterrupt:1.0 INTC_Irq INTERRUPT" *) output INTC_IRQ;
  (* x_interface_info = "xilinx.com:interface:mbinterrupt:1.0 INTC_Irq ACK" *) input [1:0]INTC_Processor_Ack;
  (* x_interface_info = "xilinx.com:interface:mbinterrupt:1.0 INTC_Irq ADDRESS" *) output [31:0]INTC_Interrupt_Address;
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 INTERRUPT.INTC_Irq_Out INTERRUPT" *) output INTC_IRQ_OUT;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 SLMB ABUS" *) input [0:31]LMB_ABus;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 SLMB WRITEDBUS" *) input [0:31]LMB_WriteDBus;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 SLMB ADDRSTROBE" *) input LMB_AddrStrobe;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 SLMB READSTROBE" *) input LMB_ReadStrobe;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 SLMB WRITESTROBE" *) input LMB_WriteStrobe;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 SLMB BE" *) input [0:3]LMB_BE;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 SLMB READDBUS" *) output [0:31]Sl_DBus;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 SLMB READY" *) output Sl_Ready;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 SLMB WAIT" *) output Sl_Wait;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 SLMB UE" *) output Sl_UE;
  (* x_interface_info = "xilinx.com:interface:lmb:1.0 SLMB CE" *) output Sl_CE;

  wire Clk;
  wire FIT1_Toggle;
  wire INTC_IRQ;
  wire INTC_IRQ_OUT;
  wire [0:0]INTC_Interrupt;
  wire [31:0]INTC_Interrupt_Address;
  wire [1:0]INTC_Processor_Ack;
  wire IO_Addr_Strobe;
  wire [31:0]IO_Address;
  wire [3:0]IO_Byte_Enable;
  wire [31:0]IO_Read_Data;
  wire IO_Read_Strobe;
  wire IO_Ready;
  wire [31:0]IO_Write_Data;
  wire IO_Write_Strobe;
  wire [0:31]LMB_ABus;
  wire LMB_AddrStrobe;
  wire [0:3]LMB_BE;
  wire LMB_ReadStrobe;
  wire [0:31]LMB_WriteDBus;
  wire LMB_WriteStrobe;
  wire Rst;
  wire Sl_CE;
  wire [0:31]Sl_DBus;
  wire Sl_Ready;
  wire Sl_UE;
  wire Sl_Wait;
  wire UART_Interrupt;
  wire UART_Rx;
  wire UART_Tx;
  wire NLW_U0_FIT1_Interrupt_UNCONNECTED;
  wire NLW_U0_FIT2_Interrupt_UNCONNECTED;
  wire NLW_U0_FIT2_Toggle_UNCONNECTED;
  wire NLW_U0_FIT3_Interrupt_UNCONNECTED;
  wire NLW_U0_FIT3_Toggle_UNCONNECTED;
  wire NLW_U0_FIT4_Interrupt_UNCONNECTED;
  wire NLW_U0_FIT4_Toggle_UNCONNECTED;
  wire NLW_U0_GPI1_Interrupt_UNCONNECTED;
  wire NLW_U0_GPI2_Interrupt_UNCONNECTED;
  wire NLW_U0_GPI3_Interrupt_UNCONNECTED;
  wire NLW_U0_GPI4_Interrupt_UNCONNECTED;
  wire NLW_U0_PIT1_Interrupt_UNCONNECTED;
  wire NLW_U0_PIT1_Toggle_UNCONNECTED;
  wire NLW_U0_PIT2_Interrupt_UNCONNECTED;
  wire NLW_U0_PIT2_Toggle_UNCONNECTED;
  wire NLW_U0_PIT3_Interrupt_UNCONNECTED;
  wire NLW_U0_PIT3_Toggle_UNCONNECTED;
  wire NLW_U0_PIT4_Interrupt_UNCONNECTED;
  wire NLW_U0_PIT4_Toggle_UNCONNECTED;
  wire [31:0]NLW_U0_GPO1_UNCONNECTED;
  wire [31:0]NLW_U0_GPO2_UNCONNECTED;
  wire [31:0]NLW_U0_GPO3_UNCONNECTED;
  wire [31:0]NLW_U0_GPO4_UNCONNECTED;

  (* C_AVOID_PRIMITIVES = "0" *) 
  (* C_BASEADDR = "64'b0000000000000000000000000000000010000000000000000000000000000000" *) 
  (* C_FAMILY = "kintex7" *) 
  (* C_FIT1_INTERRUPT = "0" *) 
  (* C_FIT1_No_CLOCKS = "6216" *) 
  (* C_FIT2_INTERRUPT = "0" *) 
  (* C_FIT2_No_CLOCKS = "6216" *) 
  (* C_FIT3_INTERRUPT = "0" *) 
  (* C_FIT3_No_CLOCKS = "6216" *) 
  (* C_FIT4_INTERRUPT = "0" *) 
  (* C_FIT4_No_CLOCKS = "6216" *) 
  (* C_FREQ = "100000000" *) 
  (* C_GPI1_INTERRUPT = "0" *) 
  (* C_GPI1_SIZE = "32" *) 
  (* C_GPI2_INTERRUPT = "0" *) 
  (* C_GPI2_SIZE = "32" *) 
  (* C_GPI3_INTERRUPT = "0" *) 
  (* C_GPI3_SIZE = "32" *) 
  (* C_GPI4_INTERRUPT = "0" *) 
  (* C_GPI4_SIZE = "32" *) 
  (* C_GPO1_INIT = "0" *) 
  (* C_GPO1_SIZE = "32" *) 
  (* C_GPO2_INIT = "0" *) 
  (* C_GPO2_SIZE = "32" *) 
  (* C_GPO3_INIT = "0" *) 
  (* C_GPO3_SIZE = "32" *) 
  (* C_GPO4_INIT = "0" *) 
  (* C_GPO4_SIZE = "32" *) 
  (* C_HIGHADDR = "64'b0000000000000000000000000000000010000000000000001111111111111111" *) 
  (* C_INSTANCE = "iomodule" *) 
  (* C_INTC_ADDR_WIDTH = "17" *) 
  (* C_INTC_ASYNC_INTR = "16'b1111111111111111" *) 
  (* C_INTC_BASE_VECTORS = "0" *) 
  (* C_INTC_HAS_FAST = "1" *) 
  (* C_INTC_INTR_SIZE = "1" *) 
  (* C_INTC_LEVEL_EDGE = "16'b0000000000000000" *) 
  (* C_INTC_NUM_SYNC_FF = "2" *) 
  (* C_INTC_POSITIVE = "16'b1111111111111111" *) 
  (* C_INTC_USE_EXT_INTR = "1" *) 
  (* C_IO_BASEADDR = "64'b0000000000000000000000000000000011000000000000000000000000000000" *) 
  (* C_IO_HIGHADDR = "64'b0000000000000000000000000000000011111111111111111111111111111111" *) 
  (* C_IO_MASK = "64'b0000000000000000000000000000000011000000000000000000000000000000" *) 
  (* C_LMB_AWIDTH = "32" *) 
  (* C_LMB_DWIDTH = "32" *) 
  (* C_MASK = "64'b0000000000000000000000000000000011000000000000000000000000000000" *) 
  (* C_PIT1_INTERRUPT = "0" *) 
  (* C_PIT1_PRESCALER = "0" *) 
  (* C_PIT1_READABLE = "1" *) 
  (* C_PIT1_SIZE = "32" *) 
  (* C_PIT2_INTERRUPT = "0" *) 
  (* C_PIT2_PRESCALER = "0" *) 
  (* C_PIT2_READABLE = "1" *) 
  (* C_PIT2_SIZE = "32" *) 
  (* C_PIT3_INTERRUPT = "0" *) 
  (* C_PIT3_PRESCALER = "0" *) 
  (* C_PIT3_READABLE = "1" *) 
  (* C_PIT3_SIZE = "32" *) 
  (* C_PIT4_INTERRUPT = "0" *) 
  (* C_PIT4_PRESCALER = "0" *) 
  (* C_PIT4_READABLE = "1" *) 
  (* C_PIT4_SIZE = "32" *) 
  (* C_UART_BAUDRATE = "115200" *) 
  (* C_UART_DATA_BITS = "8" *) 
  (* C_UART_ERROR_INTERRUPT = "0" *) 
  (* C_UART_ODD_PARITY = "0" *) 
  (* C_UART_PROG_BAUDRATE = "0" *) 
  (* C_UART_RX_INTERRUPT = "1" *) 
  (* C_UART_TX_INTERRUPT = "1" *) 
  (* C_UART_USE_PARITY = "0" *) 
  (* C_USE_CONFIG_RESET = "0" *) 
  (* C_USE_FIT1 = "1" *) 
  (* C_USE_FIT2 = "0" *) 
  (* C_USE_FIT3 = "0" *) 
  (* C_USE_FIT4 = "0" *) 
  (* C_USE_GPI1 = "0" *) 
  (* C_USE_GPI2 = "0" *) 
  (* C_USE_GPI3 = "0" *) 
  (* C_USE_GPI4 = "0" *) 
  (* C_USE_GPO1 = "0" *) 
  (* C_USE_GPO2 = "0" *) 
  (* C_USE_GPO3 = "0" *) 
  (* C_USE_GPO4 = "0" *) 
  (* C_USE_IO_BUS = "1" *) 
  (* C_USE_PIT1 = "0" *) 
  (* C_USE_PIT2 = "0" *) 
  (* C_USE_PIT3 = "0" *) 
  (* C_USE_PIT4 = "0" *) 
  (* C_USE_UART_RX = "1" *) 
  (* C_USE_UART_TX = "1" *) 
  bd_fc5c_iomodule_0_0_iomodule U0
       (.Clk(Clk),
        .Config_Reset(1'b0),
        .FIT1_Interrupt(NLW_U0_FIT1_Interrupt_UNCONNECTED),
        .FIT1_Toggle(FIT1_Toggle),
        .FIT2_Interrupt(NLW_U0_FIT2_Interrupt_UNCONNECTED),
        .FIT2_Toggle(NLW_U0_FIT2_Toggle_UNCONNECTED),
        .FIT3_Interrupt(NLW_U0_FIT3_Interrupt_UNCONNECTED),
        .FIT3_Toggle(NLW_U0_FIT3_Toggle_UNCONNECTED),
        .FIT4_Interrupt(NLW_U0_FIT4_Interrupt_UNCONNECTED),
        .FIT4_Toggle(NLW_U0_FIT4_Toggle_UNCONNECTED),
        .GPI1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .GPI1_Interrupt(NLW_U0_GPI1_Interrupt_UNCONNECTED),
        .GPI2({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .GPI2_Interrupt(NLW_U0_GPI2_Interrupt_UNCONNECTED),
        .GPI3({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .GPI3_Interrupt(NLW_U0_GPI3_Interrupt_UNCONNECTED),
        .GPI4({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .GPI4_Interrupt(NLW_U0_GPI4_Interrupt_UNCONNECTED),
        .GPO1(NLW_U0_GPO1_UNCONNECTED[31:0]),
        .GPO2(NLW_U0_GPO2_UNCONNECTED[31:0]),
        .GPO3(NLW_U0_GPO3_UNCONNECTED[31:0]),
        .GPO4(NLW_U0_GPO4_UNCONNECTED[31:0]),
        .INTC_IRQ(INTC_IRQ),
        .INTC_IRQ_OUT(INTC_IRQ_OUT),
        .INTC_Interrupt(INTC_Interrupt),
        .INTC_Interrupt_Address(INTC_Interrupt_Address),
        .INTC_Processor_Ack(INTC_Processor_Ack),
        .IO_Addr_Strobe(IO_Addr_Strobe),
        .IO_Address(IO_Address),
        .IO_Byte_Enable(IO_Byte_Enable),
        .IO_Read_Data(IO_Read_Data),
        .IO_Read_Strobe(IO_Read_Strobe),
        .IO_Ready(IO_Ready),
        .IO_Write_Data(IO_Write_Data),
        .IO_Write_Strobe(IO_Write_Strobe),
        .LMB_ABus(LMB_ABus),
        .LMB_AddrStrobe(LMB_AddrStrobe),
        .LMB_BE(LMB_BE),
        .LMB_ReadStrobe(LMB_ReadStrobe),
        .LMB_WriteDBus(LMB_WriteDBus),
        .LMB_WriteStrobe(LMB_WriteStrobe),
        .PIT1_Enable(1'b0),
        .PIT1_Interrupt(NLW_U0_PIT1_Interrupt_UNCONNECTED),
        .PIT1_Toggle(NLW_U0_PIT1_Toggle_UNCONNECTED),
        .PIT2_Enable(1'b0),
        .PIT2_Interrupt(NLW_U0_PIT2_Interrupt_UNCONNECTED),
        .PIT2_Toggle(NLW_U0_PIT2_Toggle_UNCONNECTED),
        .PIT3_Enable(1'b0),
        .PIT3_Interrupt(NLW_U0_PIT3_Interrupt_UNCONNECTED),
        .PIT3_Toggle(NLW_U0_PIT3_Toggle_UNCONNECTED),
        .PIT4_Enable(1'b0),
        .PIT4_Interrupt(NLW_U0_PIT4_Interrupt_UNCONNECTED),
        .PIT4_Toggle(NLW_U0_PIT4_Toggle_UNCONNECTED),
        .Rst(Rst),
        .Sl_CE(Sl_CE),
        .Sl_DBus(Sl_DBus),
        .Sl_Ready(Sl_Ready),
        .Sl_UE(Sl_UE),
        .Sl_Wait(Sl_Wait),
        .UART_Interrupt(UART_Interrupt),
        .UART_Rx(UART_Rx),
        .UART_Tx(UART_Tx));
endmodule

(* ORIG_REF_NAME = "Divide_part" *) 
module bd_fc5c_iomodule_0_0_Divide_part
   (Clk_En_I_1,
    Clk);
  output Clk_En_I_1;
  input Clk;

  wire Clk;
  wire Clk_En_I_1;

  bd_fc5c_iomodule_0_0_XIL_SRL16E_1 \One_SRL16.SRL16E_I 
       (.Clk(Clk),
        .Clk_En_I_1(Clk_En_I_1));
endmodule

(* ORIG_REF_NAME = "Divide_part" *) 
module bd_fc5c_iomodule_0_0_Divide_part__parameterized0
   (en_16x_baud,
    Clk_En_I_1,
    Clk);
  output en_16x_baud;
  input Clk_En_I_1;
  input Clk;

  wire Clk;
  wire Clk_En_I_1;
  wire en_16x_baud;
  wire loop_Bit;
  wire \not_First.Out1_reg_n_0 ;

  bd_fc5c_iomodule_0_0_XIL_SRL16E_0 \One_SRL16.SRL16E_I 
       (.Clk(Clk),
        .Clk_En_I_1(Clk_En_I_1),
        .loop_Bit(loop_Bit));
  FDRE #(
    .INIT(1'b0)) 
    \not_First.Clk_En_Out_i_reg 
       (.C(Clk),
        .CE(\not_First.Out1_reg_n_0 ),
        .D(Clk_En_I_1),
        .Q(en_16x_baud),
        .R(1'b0));
  FDRE \not_First.Out1_reg 
       (.C(Clk),
        .CE(1'b1),
        .D(loop_Bit),
        .Q(\not_First.Out1_reg_n_0 ),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "Divide_part" *) 
module bd_fc5c_iomodule_0_0_Divide_part__parameterized1
   (Clk_En_I_2,
    Clk);
  output Clk_En_I_2;
  input Clk;

  wire Clk;
  wire Clk_En_I_2;

  bd_fc5c_iomodule_0_0_XIL_SRL16E_3 \One_SRL16.SRL16E_I 
       (.Clk(Clk),
        .Clk_En_I_2(Clk_En_I_2));
endmodule

(* ORIG_REF_NAME = "Divide_part" *) 
module bd_fc5c_iomodule_0_0_Divide_part__parameterized2
   (Clk_En_I_1,
    Clk_En_I_2,
    Clk);
  output Clk_En_I_1;
  input Clk_En_I_2;
  input Clk;

  wire Clk;
  wire Clk_En_I_1;
  wire Clk_En_I_2;
  wire Out1;
  wire loop_Bit;

  bd_fc5c_iomodule_0_0_XIL_SRL16E_2 \One_SRL16.SRL16E_I 
       (.Clk(Clk),
        .Clk_En_I_2(Clk_En_I_2),
        .loop_Bit(loop_Bit));
  FDRE #(
    .INIT(1'b0)) 
    \not_First.Clk_En_Out_i_reg 
       (.C(Clk),
        .CE(Out1),
        .D(Clk_En_I_2),
        .Q(Clk_En_I_1),
        .R(1'b0));
  FDRE \not_First.Out1_reg 
       (.C(Clk),
        .CE(1'b1),
        .D(loop_Bit),
        .Q(Out1),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "Divide_part" *) 
module bd_fc5c_iomodule_0_0_Divide_part__parameterized3
   (FIT1_Interrupt,
    \Implement_FIT.toggle_i_reg ,
    Clk_En_I_1,
    Clk,
    FIT1_Toggle);
  output FIT1_Interrupt;
  output \Implement_FIT.toggle_i_reg ;
  input Clk_En_I_1;
  input Clk;
  input FIT1_Toggle;

  wire Clk;
  wire Clk_En_I_1;
  wire FIT1_Interrupt;
  wire FIT1_Toggle;
  wire \Implement_FIT.toggle_i_reg ;
  wire loop_Bit;
  wire \not_First.Clk_En_Out_i_i_1_n_0 ;
  wire \not_First.Out1_reg_n_0 ;
  wire shifts_0;
  wire shifts_1;

  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \Implement_FIT.toggle_i_i_1 
       (.I0(FIT1_Interrupt),
        .I1(FIT1_Toggle),
        .O(\Implement_FIT.toggle_i_reg ));
  bd_fc5c_iomodule_0_0_XIL_SRL16E__parameterized9 \More_Than_Two.SRL16E_n 
       (.Clk(Clk),
        .Clk_En_I_1(Clk_En_I_1),
        .loop_Bit(loop_Bit),
        .shifts_0(shifts_0));
  bd_fc5c_iomodule_0_0_XIL_SRLC16E \More_Than_Two.SRLC16E_1 
       (.Clk(Clk),
        .Clk_En_I_1(Clk_En_I_1),
        .loop_Bit(loop_Bit),
        .shifts_1(shifts_1));
  bd_fc5c_iomodule_0_0_XIL_SRLC16E__parameterized1 \More_Than_Two.The_Rest[1].SRLC16E_I 
       (.Clk(Clk),
        .Clk_En_I_1(Clk_En_I_1),
        .lopt(loop_Bit),
        .lopt_1(1'b1),
        .shifts_0(shifts_0),
        .shifts_1(shifts_1));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \not_First.Clk_En_Out_i_i_1 
       (.I0(Clk_En_I_1),
        .I1(\not_First.Out1_reg_n_0 ),
        .I2(FIT1_Interrupt),
        .O(\not_First.Clk_En_Out_i_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \not_First.Clk_En_Out_i_reg 
       (.C(Clk),
        .CE(1'b1),
        .D(\not_First.Clk_En_Out_i_i_1_n_0 ),
        .Q(FIT1_Interrupt),
        .R(1'b0));
  FDRE \not_First.Out1_reg 
       (.C(Clk),
        .CE(1'b1),
        .D(loop_Bit),
        .Q(\not_First.Out1_reg_n_0 ),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "FIT_Module" *) 
module bd_fc5c_iomodule_0_0_FIT_Module
   (en_16x_baud,
    Clk);
  output en_16x_baud;
  input Clk;

  wire Clk;
  wire Clk_En_I_1;
  wire en_16x_baud;

  bd_fc5c_iomodule_0_0_Divide_part \Implement_FIT.Using_SRL16s.SRL16s[1].Divide_I 
       (.Clk(Clk),
        .Clk_En_I_1(Clk_En_I_1));
  bd_fc5c_iomodule_0_0_Divide_part__parameterized0 \Implement_FIT.Using_SRL16s.SRL16s[2].Divide_I 
       (.Clk(Clk),
        .Clk_En_I_1(Clk_En_I_1),
        .en_16x_baud(en_16x_baud));
endmodule

(* ORIG_REF_NAME = "FIT_Module" *) 
module bd_fc5c_iomodule_0_0_FIT_Module__parameterized1
   (FIT1_Interrupt,
    FIT1_Toggle,
    Clk,
    Rst);
  output FIT1_Interrupt;
  output FIT1_Toggle;
  input Clk;
  input Rst;

  wire Clk;
  wire Clk_En_I_1;
  wire Clk_En_I_2;
  wire FIT1_Interrupt;
  wire FIT1_Toggle;
  wire \Implement_FIT.Using_SRL16s.SRL16s[3].Divide_I_n_1 ;
  wire Rst;

  bd_fc5c_iomodule_0_0_Divide_part__parameterized1 \Implement_FIT.Using_SRL16s.SRL16s[1].Divide_I 
       (.Clk(Clk),
        .Clk_En_I_2(Clk_En_I_2));
  bd_fc5c_iomodule_0_0_Divide_part__parameterized2 \Implement_FIT.Using_SRL16s.SRL16s[2].Divide_I 
       (.Clk(Clk),
        .Clk_En_I_1(Clk_En_I_1),
        .Clk_En_I_2(Clk_En_I_2));
  bd_fc5c_iomodule_0_0_Divide_part__parameterized3 \Implement_FIT.Using_SRL16s.SRL16s[3].Divide_I 
       (.Clk(Clk),
        .Clk_En_I_1(Clk_En_I_1),
        .FIT1_Interrupt(FIT1_Interrupt),
        .FIT1_Toggle(FIT1_Toggle),
        .\Implement_FIT.toggle_i_reg (\Implement_FIT.Using_SRL16s.SRL16s[3].Divide_I_n_1 ));
  FDRE \Implement_FIT.toggle_i_reg 
       (.C(Clk),
        .CE(1'b1),
        .D(\Implement_FIT.Using_SRL16s.SRL16s[3].Divide_I_n_1 ),
        .Q(FIT1_Toggle),
        .R(Rst));
endmodule

(* ORIG_REF_NAME = "Iomodule_core" *) 
module bd_fc5c_iomodule_0_0_Iomodule_core
   (UART_Tx,
    INTC_IRQ,
    FIT1_Interrupt,
    FIT1_Toggle,
    UART_Interrupt,
    INTC_Interrupt_Address,
    Sl_DBus,
    Clk,
    Rst,
    UART_Rx,
    Q,
    lmb_reg_write,
    lmb_reg_read,
    out,
    INTC_Processor_Ack,
    INTC_Interrupt,
    E,
    io_bus_read_data);
  output UART_Tx;
  output INTC_IRQ;
  output FIT1_Interrupt;
  output FIT1_Toggle;
  output UART_Interrupt;
  output [14:0]INTC_Interrupt_Address;
  output [8:0]Sl_DBus;
  input Clk;
  input Rst;
  input UART_Rx;
  input [5:0]Q;
  input lmb_reg_write;
  input lmb_reg_read;
  input [16:0]out;
  input [1:0]INTC_Processor_Ack;
  input [0:0]INTC_Interrupt;
  input [0:0]E;
  input [8:0]io_bus_read_data;

  wire Clk;
  wire [0:0]E;
  wire FIT1_Interrupt;
  wire FIT1_Toggle;
  wire INTC_IRQ;
  wire [0:0]INTC_Interrupt;
  wire [14:0]INTC_Interrupt_Address;
  wire [1:0]INTC_Processor_Ack;
  wire [5:0]Q;
  wire [6:0]RX_Data;
  wire Rst;
  wire [8:0]Sl_DBus;
  wire UART_Interrupt;
  wire UART_Rx;
  wire UART_Rx_Interrupt;
  wire UART_Status_Read;
  wire UART_Tx;
  wire UART_Tx_Interrupt;
  wire \Using_UART_RX.UART_RX_I1_n_3 ;
  wire \Using_UART_RX.UART_RX_I1_n_4 ;
  wire \Using_UART_RX.UART_RX_I1_n_5 ;
  wire \Using_UART_TX.UART_TX_I1_n_3 ;
  wire en_16x_baud;
  wire frame_error;
  wire [8:0]io_bus_read_data;
  wire lmb_reg_read;
  wire lmb_reg_write;
  wire [16:0]out;
  wire overrun_error;
  wire [3:3]p_0_out;
  wire rx_data_exists;
  wire rx_frame_error;

  bd_fc5c_iomodule_0_0_FIT_Module__parameterized1 FIT_I1
       (.Clk(Clk),
        .FIT1_Interrupt(FIT1_Interrupt),
        .FIT1_Toggle(FIT1_Toggle),
        .Rst(Rst));
  bd_fc5c_iomodule_0_0_FIT_Module \Using_UART.No_Dynamic_BaudRate.UART_FIT_I 
       (.Clk(Clk),
        .en_16x_baud(en_16x_baud));
  bd_fc5c_iomodule_0_0_Uart_Control_Status \Using_UART.Uart_Control_Status_I1 
       (.Clk(Clk),
        .D({frame_error,overrun_error}),
        .Q(Q[4:0]),
        .\RX_Data_reg[6] ({RX_Data[6:5],RX_Data[3],RX_Data[0]}),
        .Rst(Rst),
        .Sl_DBus({Sl_DBus[6:5],Sl_DBus[3],Sl_DBus[0]}),
        .UART_Interrupt(UART_Interrupt),
        .UART_Status_Read(UART_Status_Read),
        .UART_Tx_Interrupt(UART_Tx_Interrupt),
        .frame_error_reg_0(\Using_UART_RX.UART_RX_I1_n_5 ),
        .io_bus_read_data({io_bus_read_data[6:5],io_bus_read_data[3],io_bus_read_data[0]}),
        .lmb_reg_read(lmb_reg_read),
        .out(UART_Rx_Interrupt),
        .rx_2_reg(rx_frame_error),
        .rx_data_exists_i_reg(\Using_UART_RX.UART_RX_I1_n_4 ),
        .tx_buffer_empty_i_reg({p_0_out,rx_data_exists}));
  bd_fc5c_iomodule_0_0_UART_Receive \Using_UART_RX.UART_RX_I1 
       (.\All_INTR_Bits[2].Using_Intr.cisr_reg[2] (\Using_UART_RX.UART_RX_I1_n_3 ),
        .Clk(Clk),
        .D({frame_error,overrun_error}),
        .Q(Q[4:0]),
        .Rst(Rst),
        .Sl_DBus({Sl_DBus[7],Sl_DBus[4]}),
        .\Sl_DBus[25] ({RX_Data[6:5],RX_Data[3:0]}),
        .UART_Rx(UART_Rx),
        .UART_Status_Read(UART_Status_Read),
        .\UART_Status_reg[0] (rx_data_exists),
        .en_16x_baud(en_16x_baud),
        .frame_error_reg(rx_frame_error),
        .frame_error_reg_0(\Using_UART_RX.UART_RX_I1_n_5 ),
        .io_bus_read_data({io_bus_read_data[7],io_bus_read_data[4]}),
        .lmb_reg_read(lmb_reg_read),
        .out(UART_Rx_Interrupt),
        .overrun_error_reg(\Using_UART_RX.UART_RX_I1_n_4 ));
  bd_fc5c_iomodule_0_0_UART_Transmit \Using_UART_TX.UART_TX_I1 
       (.\All_INTR_Bits[1].Using_Intr.cisr_reg[1] (\Using_UART_TX.UART_TX_I1_n_3 ),
        .Clk(Clk),
        .E(E),
        .Rst(Rst),
        .\UART_Status_reg[3] (p_0_out),
        .UART_Tx(UART_Tx),
        .UART_Tx_Interrupt(UART_Tx_Interrupt),
        .en_16x_baud(en_16x_baud),
        .out(out[7:0]));
  bd_fc5c_iomodule_0_0_intr_ctrl intr_ctrl_I1
       (.Clk(Clk),
        .INTC_IRQ(INTC_IRQ),
        .INTC_Interrupt(INTC_Interrupt),
        .INTC_Interrupt_Address(INTC_Interrupt_Address),
        .INTC_Processor_Ack(INTC_Processor_Ack),
        .Q(Q),
        .\RX_Data_reg[2] (RX_Data[2:1]),
        .Rst(Rst),
        .Sl_DBus({Sl_DBus[8],Sl_DBus[2:1]}),
        .data_is_sent_reg(\Using_UART_TX.UART_TX_I1_n_3 ),
        .io_bus_read_data({io_bus_read_data[8],io_bus_read_data[2:1]}),
        .lmb_reg_read(lmb_reg_read),
        .lmb_reg_write(lmb_reg_write),
        .new_rx_data_write_reg(\Using_UART_RX.UART_RX_I1_n_3 ),
        .out(out[16:1]));
endmodule

(* ORIG_REF_NAME = "UART_Receive" *) 
module bd_fc5c_iomodule_0_0_UART_Receive
   (out,
    frame_error_reg,
    \UART_Status_reg[0] ,
    \All_INTR_Bits[2].Using_Intr.cisr_reg[2] ,
    overrun_error_reg,
    frame_error_reg_0,
    Sl_DBus,
    \Sl_DBus[25] ,
    en_16x_baud,
    Clk,
    Rst,
    UART_Rx,
    Q,
    lmb_reg_read,
    UART_Status_Read,
    D,
    io_bus_read_data);
  output out;
  output frame_error_reg;
  output [0:0]\UART_Status_reg[0] ;
  output \All_INTR_Bits[2].Using_Intr.cisr_reg[2] ;
  output overrun_error_reg;
  output frame_error_reg_0;
  output [1:0]Sl_DBus;
  output [5:0]\Sl_DBus[25] ;
  input en_16x_baud;
  input Clk;
  input Rst;
  input UART_Rx;
  input [4:0]Q;
  input lmb_reg_read;
  input UART_Status_Read;
  input [1:0]D;
  input [1:0]io_bus_read_data;

  wire \All_INTR_Bits[2].Using_Intr.cisr_reg[2] ;
  wire Clk;
  wire \Convert_Serial_To_Parallel[2].serial_to_parallel_reg ;
  wire \Convert_Serial_To_Parallel[3].serial_to_parallel_reg ;
  wire \Convert_Serial_To_Parallel[4].serial_to_parallel_reg ;
  wire \Convert_Serial_To_Parallel[5].serial_to_parallel_reg ;
  wire \Convert_Serial_To_Parallel[6].serial_to_parallel_reg ;
  wire \Convert_Serial_To_Parallel[7].serial_to_parallel_reg ;
  wire \Convert_Serial_To_Parallel[8].serial_to_parallel_reg ;
  wire [1:0]D;
  wire D_0;
  wire Delay_16_n_1;
  wire Delay_16_n_2;
  wire [4:0]Q;
  wire [7:4]RX_Data;
  wire \RX_Data[7]_i_1_n_0 ;
  wire Rst;
  wire [1:0]Sl_DBus;
  wire [5:0]\Sl_DBus[25] ;
  wire UART_Rx;
  wire UART_Rx_Read;
  wire UART_Status_Read;
  wire [0:0]\UART_Status_reg[0] ;
  wire en_16x_baud;
  (* RTL_KEEP = "soft" *) wire frame_error_reg;
  wire frame_error_reg_0;
  wire [1:0]io_bus_read_data;
  wire lmb_reg_read;
  wire mid_Start_Bit;
  (* RTL_KEEP = "soft" *) wire [0:8]new_rx_data;
  (* RTL_KEEP = "soft" *) wire new_rx_data_write;
  wire new_rx_data_write_reg0__0;
  wire overrun_error_reg;
  wire previous_RX;
  wire previous_RX_i_1_n_0;
  wire running_reg_n_0;
  wire rx_1;
  wire rx_data_exists_i_i_1_n_0;
  wire [7:0]rx_data_i;
  (* RTL_KEEP = "soft" *) wire rx_parity_error;
  wire sample_Point;
  wire start_Edge_Detected_i_1_n_0;
  wire start_Edge_Detected_reg_n_0;
  wire stop_Bit_Position_reg_n_0;

  assign out = new_rx_data_write;
  LUT2 #(
    .INIT(4'h2)) 
    \All_INTR_Bits[2].Using_Intr.cisr[2]_i_3 
       (.I0(new_rx_data_write),
        .I1(Rst),
        .O(\All_INTR_Bits[2].Using_Intr.cisr_reg[2] ));
  (* box_type = "PRIMITIVE" *) 
  FDSE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_S_INVERTED(1'b0)) 
    \Convert_Serial_To_Parallel[1].First_Bit.First_Bit_I 
       (.C(Clk),
        .CE(en_16x_baud),
        .D(D_0),
        .Q(new_rx_data[1]),
        .S(mid_Start_Bit));
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \Convert_Serial_To_Parallel[2].Rest_Bits.Others_I 
       (.C(Clk),
        .CE(en_16x_baud),
        .D(\Convert_Serial_To_Parallel[2].serial_to_parallel_reg ),
        .Q(new_rx_data[2]),
        .R(mid_Start_Bit));
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \Convert_Serial_To_Parallel[3].Rest_Bits.Others_I 
       (.C(Clk),
        .CE(en_16x_baud),
        .D(\Convert_Serial_To_Parallel[3].serial_to_parallel_reg ),
        .Q(new_rx_data[3]),
        .R(mid_Start_Bit));
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \Convert_Serial_To_Parallel[4].Rest_Bits.Others_I 
       (.C(Clk),
        .CE(en_16x_baud),
        .D(\Convert_Serial_To_Parallel[4].serial_to_parallel_reg ),
        .Q(new_rx_data[4]),
        .R(mid_Start_Bit));
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \Convert_Serial_To_Parallel[5].Rest_Bits.Others_I 
       (.C(Clk),
        .CE(en_16x_baud),
        .D(\Convert_Serial_To_Parallel[5].serial_to_parallel_reg ),
        .Q(new_rx_data[5]),
        .R(mid_Start_Bit));
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \Convert_Serial_To_Parallel[6].Rest_Bits.Others_I 
       (.C(Clk),
        .CE(en_16x_baud),
        .D(\Convert_Serial_To_Parallel[6].serial_to_parallel_reg ),
        .Q(new_rx_data[6]),
        .R(mid_Start_Bit));
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \Convert_Serial_To_Parallel[7].Rest_Bits.Others_I 
       (.C(Clk),
        .CE(en_16x_baud),
        .D(\Convert_Serial_To_Parallel[7].serial_to_parallel_reg ),
        .Q(new_rx_data[7]),
        .R(mid_Start_Bit));
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \Convert_Serial_To_Parallel[8].Rest_Bits.Others_I 
       (.C(Clk),
        .CE(en_16x_baud),
        .D(\Convert_Serial_To_Parallel[8].serial_to_parallel_reg ),
        .Q(new_rx_data[8]),
        .R(mid_Start_Bit));
  bd_fc5c_iomodule_0_0_XIL_SRL16E__parameterized3 Delay_16
       (.Clk(Clk),
        .\Convert_Serial_To_Parallel[2].serial_to_parallel_reg (\Convert_Serial_To_Parallel[2].serial_to_parallel_reg ),
        .\Convert_Serial_To_Parallel[3].serial_to_parallel_reg (\Convert_Serial_To_Parallel[3].serial_to_parallel_reg ),
        .\Convert_Serial_To_Parallel[4].serial_to_parallel_reg (\Convert_Serial_To_Parallel[4].serial_to_parallel_reg ),
        .\Convert_Serial_To_Parallel[5].serial_to_parallel_reg (\Convert_Serial_To_Parallel[5].serial_to_parallel_reg ),
        .\Convert_Serial_To_Parallel[6].serial_to_parallel_reg (\Convert_Serial_To_Parallel[6].serial_to_parallel_reg ),
        .\Convert_Serial_To_Parallel[7].serial_to_parallel_reg (\Convert_Serial_To_Parallel[7].serial_to_parallel_reg ),
        .\Convert_Serial_To_Parallel[8].serial_to_parallel_reg (\Convert_Serial_To_Parallel[8].serial_to_parallel_reg ),
        .D_0(D_0),
        .en_16x_baud(en_16x_baud),
        .mid_Start_Bit(mid_Start_Bit),
        .out({new_rx_data[0],new_rx_data[1],new_rx_data[2],new_rx_data[3],new_rx_data[4],new_rx_data[5],new_rx_data[6],new_rx_data[7],new_rx_data[8]}),
        .running_reg(Delay_16_n_2),
        .running_reg_0(running_reg_n_0),
        .sample_Point(sample_Point),
        .start_Edge_Detected_reg(start_Edge_Detected_reg_n_0),
        .stop_Bit_Position_reg(Delay_16_n_1),
        .stop_Bit_Position_reg_0(stop_Bit_Position_reg_n_0));
  bd_fc5c_iomodule_0_0_XIL_SRL16E__parameterized1 Mid_Start_Bit_SRL16
       (.Clk(Clk),
        .en_16x_baud(en_16x_baud),
        .mid_Start_Bit(mid_Start_Bit),
        .start_Edge_Detected_reg(start_Edge_Detected_reg_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFEFFFFFFFF)) 
    \RX_Data[7]_i_1 
       (.I0(Q[4]),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(Q[2]),
        .I4(Q[3]),
        .I5(lmb_reg_read),
        .O(\RX_Data[7]_i_1_n_0 ));
  FDRE \RX_Data_reg[0] 
       (.C(Clk),
        .CE(1'b1),
        .D(rx_data_i[0]),
        .Q(\Sl_DBus[25] [0]),
        .R(\RX_Data[7]_i_1_n_0 ));
  FDRE \RX_Data_reg[1] 
       (.C(Clk),
        .CE(1'b1),
        .D(rx_data_i[1]),
        .Q(\Sl_DBus[25] [1]),
        .R(\RX_Data[7]_i_1_n_0 ));
  FDRE \RX_Data_reg[2] 
       (.C(Clk),
        .CE(1'b1),
        .D(rx_data_i[2]),
        .Q(\Sl_DBus[25] [2]),
        .R(\RX_Data[7]_i_1_n_0 ));
  FDRE \RX_Data_reg[3] 
       (.C(Clk),
        .CE(1'b1),
        .D(rx_data_i[3]),
        .Q(\Sl_DBus[25] [3]),
        .R(\RX_Data[7]_i_1_n_0 ));
  FDRE \RX_Data_reg[4] 
       (.C(Clk),
        .CE(1'b1),
        .D(rx_data_i[4]),
        .Q(RX_Data[4]),
        .R(\RX_Data[7]_i_1_n_0 ));
  FDRE \RX_Data_reg[5] 
       (.C(Clk),
        .CE(1'b1),
        .D(rx_data_i[5]),
        .Q(\Sl_DBus[25] [4]),
        .R(\RX_Data[7]_i_1_n_0 ));
  FDRE \RX_Data_reg[6] 
       (.C(Clk),
        .CE(1'b1),
        .D(rx_data_i[6]),
        .Q(\Sl_DBus[25] [5]),
        .R(\RX_Data[7]_i_1_n_0 ));
  FDRE \RX_Data_reg[7] 
       (.C(Clk),
        .CE(1'b1),
        .D(rx_data_i[7]),
        .Q(RX_Data[7]),
        .R(\RX_Data[7]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \Sl_DBus[24]_INST_0 
       (.I0(io_bus_read_data[1]),
        .I1(RX_Data[7]),
        .O(Sl_DBus[1]));
  LUT2 #(
    .INIT(4'hE)) 
    \Sl_DBus[27]_INST_0 
       (.I0(io_bus_read_data[0]),
        .I1(RX_Data[4]),
        .O(Sl_DBus[0]));
  LUT3 #(
    .INIT(8'hBA)) 
    frame_error_i_1
       (.I0(frame_error_reg),
        .I1(UART_Status_Read),
        .I2(D[1]),
        .O(frame_error_reg_0));
  LUT1 #(
    .INIT(2'h2)) 
    i_0
       (.I0(1'b0),
        .O(rx_parity_error));
  LUT4 #(
    .INIT(16'h4000)) 
    in00
       (.I0(new_rx_data[0]),
        .I1(en_16x_baud),
        .I2(sample_Point),
        .I3(stop_Bit_Position_reg_n_0),
        .O(frame_error_reg));
  (* KEEP = "yes" *) 
  FDRE new_rx_data_write_reg
       (.C(Clk),
        .CE(1'b1),
        .D(new_rx_data_write_reg0__0),
        .Q(new_rx_data_write),
        .R(Rst));
  LUT4 #(
    .INIT(16'h8000)) 
    new_rx_data_write_reg0
       (.I0(en_16x_baud),
        .I1(sample_Point),
        .I2(stop_Bit_Position_reg_n_0),
        .I3(new_rx_data[0]),
        .O(new_rx_data_write_reg0__0));
  LUT4 #(
    .INIT(16'h8F88)) 
    overrun_error_i_1
       (.I0(\UART_Status_reg[0] ),
        .I1(new_rx_data_write),
        .I2(UART_Status_Read),
        .I3(D[0]),
        .O(overrun_error_reg));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    previous_RX_i_1
       (.I0(new_rx_data[0]),
        .I1(en_16x_baud),
        .I2(previous_RX),
        .O(previous_RX_i_1_n_0));
  FDRE previous_RX_reg
       (.C(Clk),
        .CE(1'b1),
        .D(previous_RX_i_1_n_0),
        .Q(previous_RX),
        .R(Rst));
  FDRE running_reg
       (.C(Clk),
        .CE(1'b1),
        .D(Delay_16_n_2),
        .Q(running_reg_n_0),
        .R(Rst));
  FDSE rx_1_reg
       (.C(Clk),
        .CE(1'b1),
        .D(UART_Rx),
        .Q(rx_1),
        .S(Rst));
  FDSE rx_2_reg
       (.C(Clk),
        .CE(1'b1),
        .D(rx_1),
        .Q(new_rx_data[0]),
        .S(Rst));
  LUT4 #(
    .INIT(16'h000E)) 
    rx_data_exists_i_i_1
       (.I0(\UART_Status_reg[0] ),
        .I1(new_rx_data_write),
        .I2(UART_Rx_Read),
        .I3(Rst),
        .O(rx_data_exists_i_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000000000000002)) 
    rx_data_exists_i_i_2
       (.I0(lmb_reg_read),
        .I1(Q[3]),
        .I2(Q[2]),
        .I3(Q[0]),
        .I4(Q[1]),
        .I5(Q[4]),
        .O(UART_Rx_Read));
  FDRE rx_data_exists_i_reg
       (.C(Clk),
        .CE(1'b1),
        .D(rx_data_exists_i_i_1_n_0),
        .Q(\UART_Status_reg[0] ),
        .R(1'b0));
  FDRE \rx_data_i_reg[0] 
       (.C(Clk),
        .CE(new_rx_data_write),
        .D(new_rx_data[8]),
        .Q(rx_data_i[0]),
        .R(Rst));
  FDRE \rx_data_i_reg[1] 
       (.C(Clk),
        .CE(new_rx_data_write),
        .D(new_rx_data[7]),
        .Q(rx_data_i[1]),
        .R(Rst));
  FDRE \rx_data_i_reg[2] 
       (.C(Clk),
        .CE(new_rx_data_write),
        .D(new_rx_data[6]),
        .Q(rx_data_i[2]),
        .R(Rst));
  FDRE \rx_data_i_reg[3] 
       (.C(Clk),
        .CE(new_rx_data_write),
        .D(new_rx_data[5]),
        .Q(rx_data_i[3]),
        .R(Rst));
  FDRE \rx_data_i_reg[4] 
       (.C(Clk),
        .CE(new_rx_data_write),
        .D(new_rx_data[4]),
        .Q(rx_data_i[4]),
        .R(Rst));
  FDRE \rx_data_i_reg[5] 
       (.C(Clk),
        .CE(new_rx_data_write),
        .D(new_rx_data[3]),
        .Q(rx_data_i[5]),
        .R(Rst));
  FDRE \rx_data_i_reg[6] 
       (.C(Clk),
        .CE(new_rx_data_write),
        .D(new_rx_data[2]),
        .Q(rx_data_i[6]),
        .R(Rst));
  FDRE \rx_data_i_reg[7] 
       (.C(Clk),
        .CE(new_rx_data_write),
        .D(new_rx_data[1]),
        .Q(rx_data_i[7]),
        .R(Rst));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT5 #(
    .INIT(32'h02FF0200)) 
    start_Edge_Detected_i_1
       (.I0(previous_RX),
        .I1(new_rx_data[0]),
        .I2(running_reg_n_0),
        .I3(en_16x_baud),
        .I4(start_Edge_Detected_reg_n_0),
        .O(start_Edge_Detected_i_1_n_0));
  FDRE start_Edge_Detected_reg
       (.C(Clk),
        .CE(1'b1),
        .D(start_Edge_Detected_i_1_n_0),
        .Q(start_Edge_Detected_reg_n_0),
        .R(Rst));
  FDRE stop_Bit_Position_reg
       (.C(Clk),
        .CE(1'b1),
        .D(Delay_16_n_1),
        .Q(stop_Bit_Position_reg_n_0),
        .R(Rst));
endmodule

(* ORIG_REF_NAME = "UART_Transmit" *) 
module bd_fc5c_iomodule_0_0_UART_Transmit
   (UART_Tx,
    UART_Tx_Interrupt,
    \UART_Status_reg[3] ,
    \All_INTR_Bits[1].Using_Intr.cisr_reg[1] ,
    en_16x_baud,
    Clk,
    Rst,
    E,
    out);
  output UART_Tx;
  output UART_Tx_Interrupt;
  output [0:0]\UART_Status_reg[3] ;
  output \All_INTR_Bits[1].Using_Intr.cisr_reg[1] ;
  input en_16x_baud;
  input Clk;
  input Rst;
  input [0:0]E;
  input [7:0]out;

  wire \All_INTR_Bits[1].Using_Intr.cisr_reg[1] ;
  wire CI;
  wire Clk;
  wire \Counter[0].h_Cnt_reg ;
  wire \Counter[1].Used_MuxCY.MUXCY_L_I_n_0 ;
  wire \Counter[1].h_Cnt_reg ;
  wire \Counter[2].Used_MuxCY.MUXCY_L_I_n_0 ;
  wire DI;
  wire [0:0]E;
  wire I0;
  wire I1;
  wire LI;
  wire MUX_F5_1_i_1_n_0;
  wire MUX_F5_2_i_1_n_0;
  wire MUX_F5_2_i_2_n_0;
  wire MUX_F5_2_n_0;
  wire Rst;
  wire S;
  wire TX_reg0;
  wire [0:0]\UART_Status_reg[3] ;
  (* RTL_KEEP = "soft" *) wire UART_Tx;
  wire UART_Tx_Interrupt;
  wire data_is_sent0;
  wire div16;
  wire en_16x_baud;
  wire \fifo_DOut_reg_n_0_[0] ;
  wire \fifo_DOut_reg_n_0_[1] ;
  wire \fifo_DOut_reg_n_0_[2] ;
  wire \fifo_DOut_reg_n_0_[3] ;
  wire \fifo_DOut_reg_n_0_[5] ;
  wire \fifo_DOut_reg_n_0_[6] ;
  wire \fifo_DOut_reg_n_0_[7] ;
  wire mux_Out;
  wire \mux_sel_reg_n_0_[0] ;
  wire [7:0]out;
  wire p_0_in;
  wire serial_Data;
  wire [0:2]sum_cnt;
  wire tx_DataBits;
  wire tx_DataBits0;
  wire tx_Data_Enable;
  wire tx_Start;
  wire tx_Start0;
  (* RTL_KEEP = "soft" *) wire tx_buffer_empty_i;
  wire tx_buffer_empty_i_i_1_n_0;
  wire [3:2]\NLW_Counter[2].Used_MuxCY.MUXCY_L_I_CARRY4_CO_UNCONNECTED ;
  wire [3:2]\NLW_Counter[2].Used_MuxCY.MUXCY_L_I_CARRY4_DI_UNCONNECTED ;
  wire [3:3]\NLW_Counter[2].Used_MuxCY.MUXCY_L_I_CARRY4_O_UNCONNECTED ;
  wire [3:3]\NLW_Counter[2].Used_MuxCY.MUXCY_L_I_CARRY4_S_UNCONNECTED ;

  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \All_INTR_Bits[1].Using_Intr.cisr[1]_i_5 
       (.I0(UART_Tx_Interrupt),
        .I1(Rst),
        .O(\All_INTR_Bits[1].Using_Intr.cisr_reg[1] ));
  LUT1 #(
    .INIT(2'h1)) 
    \Counter[0].XORCY_I_i_1 
       (.I0(\mux_sel_reg_n_0_[0] ),
        .O(\Counter[0].h_Cnt_reg ));
  LUT1 #(
    .INIT(2'h1)) 
    \Counter[1].XORCY_I_i_1 
       (.I0(S),
        .O(\Counter[1].h_Cnt_reg ));
  (* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
  (* XILINX_TRANSFORM_PINMAP = "LO:O" *) 
  (* box_type = "PRIMITIVE" *) 
  CARRY4 \Counter[2].Used_MuxCY.MUXCY_L_I_CARRY4 
       (.CI(1'b0),
        .CO({\NLW_Counter[2].Used_MuxCY.MUXCY_L_I_CARRY4_CO_UNCONNECTED [3:2],\Counter[1].Used_MuxCY.MUXCY_L_I_n_0 ,\Counter[2].Used_MuxCY.MUXCY_L_I_n_0 }),
        .CYINIT(CI),
        .DI({\NLW_Counter[2].Used_MuxCY.MUXCY_L_I_CARRY4_DI_UNCONNECTED [3:2],S,DI}),
        .O({\NLW_Counter[2].Used_MuxCY.MUXCY_L_I_CARRY4_O_UNCONNECTED [3],sum_cnt[0],sum_cnt[1],sum_cnt[2]}),
        .S({\NLW_Counter[2].Used_MuxCY.MUXCY_L_I_CARRY4_S_UNCONNECTED [3],\Counter[0].h_Cnt_reg ,\Counter[1].h_Cnt_reg ,LI}));
  LUT1 #(
    .INIT(2'h1)) 
    \Counter[2].XORCY_I_i_1 
       (.I0(DI),
        .O(LI));
  LUT1 #(
    .INIT(2'h1)) 
    \Counter[2].XORCY_I_i_2 
       (.I0(tx_DataBits),
        .O(CI));
  bd_fc5c_iomodule_0_0_XIL_SRL16E DIV16_SRL16E
       (.Clk(Clk),
        .div16(div16),
        .en_16x_baud(en_16x_baud));
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    FDRE_I
       (.C(Clk),
        .CE(en_16x_baud),
        .D(div16),
        .Q(tx_Data_Enable),
        .R(tx_Data_Enable));
  (* XILINX_LEGACY_PRIM = "MUXF6" *) 
  (* XILINX_TRANSFORM_PINMAP = "S:I2" *) 
  (* box_type = "PRIMITIVE" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    MUXF6_I
       (.I0(I0),
        .I1(MUX_F5_2_n_0),
        .I2(\mux_sel_reg_n_0_[0] ),
        .O(mux_Out));
  (* XILINX_LEGACY_PRIM = "MUXF5" *) 
  (* XILINX_TRANSFORM_PINMAP = "S:I2" *) 
  (* box_type = "PRIMITIVE" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    MUX_F5_1
       (.I0(MUX_F5_1_i_1_n_0),
        .I1(I1),
        .I2(S),
        .O(I0));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    MUX_F5_1_i_1
       (.I0(\fifo_DOut_reg_n_0_[1] ),
        .I1(DI),
        .I2(\fifo_DOut_reg_n_0_[0] ),
        .O(MUX_F5_1_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    MUX_F5_1_i_2
       (.I0(\fifo_DOut_reg_n_0_[3] ),
        .I1(DI),
        .I2(\fifo_DOut_reg_n_0_[2] ),
        .O(I1));
  (* XILINX_LEGACY_PRIM = "MUXF5" *) 
  (* XILINX_TRANSFORM_PINMAP = "S:I2" *) 
  (* box_type = "PRIMITIVE" *) 
  LUT3 #(
    .INIT(8'hCA)) 
    MUX_F5_2
       (.I0(MUX_F5_2_i_1_n_0),
        .I1(MUX_F5_2_i_2_n_0),
        .I2(S),
        .O(MUX_F5_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    MUX_F5_2_i_1
       (.I0(\fifo_DOut_reg_n_0_[5] ),
        .I1(DI),
        .I2(p_0_in),
        .O(MUX_F5_2_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    MUX_F5_2_i_2
       (.I0(\fifo_DOut_reg_n_0_[7] ),
        .I1(DI),
        .I2(\fifo_DOut_reg_n_0_[6] ),
        .O(MUX_F5_2_i_2_n_0));
  LUT3 #(
    .INIT(8'h0B)) 
    TX_i_1
       (.I0(serial_Data),
        .I1(tx_DataBits),
        .I2(tx_Start),
        .O(TX_reg0));
  (* KEEP = "yes" *) 
  FDSE TX_reg
       (.C(Clk),
        .CE(1'b1),
        .D(TX_reg0),
        .Q(UART_Tx),
        .S(Rst));
  LUT1 #(
    .INIT(2'h1)) 
    \UART_Status[3]_i_1 
       (.I0(tx_buffer_empty_i),
        .O(\UART_Status_reg[3] ));
  LUT4 #(
    .INIT(16'h0002)) 
    data_is_sent_i_1
       (.I0(tx_Data_Enable),
        .I1(DI),
        .I2(S),
        .I3(\mux_sel_reg_n_0_[0] ),
        .O(data_is_sent0));
  FDRE data_is_sent_reg
       (.C(Clk),
        .CE(1'b1),
        .D(data_is_sent0),
        .Q(UART_Tx_Interrupt),
        .R(Rst));
  FDRE \fifo_DOut_reg[0] 
       (.C(Clk),
        .CE(E),
        .D(out[7]),
        .Q(\fifo_DOut_reg_n_0_[0] ),
        .R(Rst));
  FDRE \fifo_DOut_reg[1] 
       (.C(Clk),
        .CE(E),
        .D(out[6]),
        .Q(\fifo_DOut_reg_n_0_[1] ),
        .R(Rst));
  FDRE \fifo_DOut_reg[2] 
       (.C(Clk),
        .CE(E),
        .D(out[5]),
        .Q(\fifo_DOut_reg_n_0_[2] ),
        .R(Rst));
  FDRE \fifo_DOut_reg[3] 
       (.C(Clk),
        .CE(E),
        .D(out[4]),
        .Q(\fifo_DOut_reg_n_0_[3] ),
        .R(Rst));
  FDRE \fifo_DOut_reg[4] 
       (.C(Clk),
        .CE(E),
        .D(out[3]),
        .Q(p_0_in),
        .R(Rst));
  FDRE \fifo_DOut_reg[5] 
       (.C(Clk),
        .CE(E),
        .D(out[2]),
        .Q(\fifo_DOut_reg_n_0_[5] ),
        .R(Rst));
  FDRE \fifo_DOut_reg[6] 
       (.C(Clk),
        .CE(E),
        .D(out[1]),
        .Q(\fifo_DOut_reg_n_0_[6] ),
        .R(Rst));
  FDRE \fifo_DOut_reg[7] 
       (.C(Clk),
        .CE(E),
        .D(out[0]),
        .Q(\fifo_DOut_reg_n_0_[7] ),
        .R(Rst));
  FDSE \mux_sel_reg[0] 
       (.C(Clk),
        .CE(tx_Data_Enable),
        .D(sum_cnt[0]),
        .Q(\mux_sel_reg_n_0_[0] ),
        .S(Rst));
  FDSE \mux_sel_reg[1] 
       (.C(Clk),
        .CE(tx_Data_Enable),
        .D(sum_cnt[1]),
        .Q(S),
        .S(Rst));
  FDSE \mux_sel_reg[2] 
       (.C(Clk),
        .CE(tx_Data_Enable),
        .D(sum_cnt[2]),
        .Q(DI),
        .S(Rst));
  FDRE serial_Data_reg
       (.C(Clk),
        .CE(1'b1),
        .D(mux_Out),
        .Q(serial_Data),
        .R(Rst));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'h0F08)) 
    tx_DataBits_i_1
       (.I0(tx_Start),
        .I1(tx_Data_Enable),
        .I2(UART_Tx_Interrupt),
        .I3(tx_DataBits),
        .O(tx_DataBits0));
  FDRE tx_DataBits_reg
       (.C(Clk),
        .CE(1'b1),
        .D(tx_DataBits0),
        .Q(tx_DataBits),
        .R(Rst));
  LUT4 #(
    .INIT(16'h0F02)) 
    tx_Start_i_1
       (.I0(tx_Data_Enable),
        .I1(tx_buffer_empty_i),
        .I2(tx_DataBits),
        .I3(tx_Start),
        .O(tx_Start0));
  FDRE tx_Start_reg
       (.C(Clk),
        .CE(1'b1),
        .D(tx_Start0),
        .Q(tx_Start),
        .R(Rst));
  LUT4 #(
    .INIT(16'hFFF4)) 
    tx_buffer_empty_i_i_1
       (.I0(E),
        .I1(tx_buffer_empty_i),
        .I2(UART_Tx_Interrupt),
        .I3(Rst),
        .O(tx_buffer_empty_i_i_1_n_0));
  (* KEEP = "yes" *) 
  FDRE tx_buffer_empty_i_reg
       (.C(Clk),
        .CE(1'b1),
        .D(tx_buffer_empty_i_i_1_n_0),
        .Q(tx_buffer_empty_i),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "Uart_Control_Status" *) 
module bd_fc5c_iomodule_0_0_Uart_Control_Status
   (D,
    UART_Status_Read,
    UART_Interrupt,
    Sl_DBus,
    Rst,
    rx_data_exists_i_reg,
    Clk,
    frame_error_reg_0,
    Q,
    lmb_reg_read,
    out,
    UART_Tx_Interrupt,
    io_bus_read_data,
    \RX_Data_reg[6] ,
    tx_buffer_empty_i_reg,
    rx_2_reg);
  output [1:0]D;
  output UART_Status_Read;
  output UART_Interrupt;
  output [3:0]Sl_DBus;
  input Rst;
  input rx_data_exists_i_reg;
  input Clk;
  input frame_error_reg_0;
  input [4:0]Q;
  input lmb_reg_read;
  input out;
  input UART_Tx_Interrupt;
  input [3:0]io_bus_read_data;
  input [3:0]\RX_Data_reg[6] ;
  input [1:0]tx_buffer_empty_i_reg;
  input rx_2_reg;

  wire Clk;
  wire [1:0]D;
  wire [4:0]Q;
  wire [3:0]\RX_Data_reg[6] ;
  wire Rst;
  wire [3:0]Sl_DBus;
  wire UART_Error_Interrupt;
  wire UART_Interrupt;
  wire [6:0]UART_Status;
  wire \UART_Status[6]_i_1_n_0 ;
  wire UART_Status_Read;
  wire UART_Tx_Interrupt;
  wire error_interrupt_i_1_n_0;
  wire frame_error_reg_0;
  wire [3:0]io_bus_read_data;
  wire lmb_reg_read;
  wire out;
  wire rx_2_reg;
  wire rx_data_exists_i_reg;
  wire [1:0]tx_buffer_empty_i_reg;

  LUT3 #(
    .INIT(8'hFE)) 
    \Sl_DBus[25]_INST_0 
       (.I0(io_bus_read_data[3]),
        .I1(UART_Status[6]),
        .I2(\RX_Data_reg[6] [3]),
        .O(Sl_DBus[3]));
  LUT3 #(
    .INIT(8'hFE)) 
    \Sl_DBus[26]_INST_0 
       (.I0(io_bus_read_data[2]),
        .I1(UART_Status[5]),
        .I2(\RX_Data_reg[6] [2]),
        .O(Sl_DBus[2]));
  LUT3 #(
    .INIT(8'hFE)) 
    \Sl_DBus[28]_INST_0 
       (.I0(io_bus_read_data[1]),
        .I1(UART_Status[3]),
        .I2(\RX_Data_reg[6] [1]),
        .O(Sl_DBus[1]));
  LUT3 #(
    .INIT(8'hFE)) 
    \Sl_DBus[31]_INST_0 
       (.I0(io_bus_read_data[0]),
        .I1(UART_Status[0]),
        .I2(\RX_Data_reg[6] [0]),
        .O(Sl_DBus[0]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    UART_Interrupt_INST_0
       (.I0(UART_Error_Interrupt),
        .I1(out),
        .I2(UART_Tx_Interrupt),
        .O(UART_Interrupt));
  LUT6 #(
    .INIT(64'hFFFFFFFBFFFFFFFF)) 
    \UART_Status[6]_i_1 
       (.I0(Q[4]),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(Q[2]),
        .I4(Q[3]),
        .I5(lmb_reg_read),
        .O(\UART_Status[6]_i_1_n_0 ));
  FDRE \UART_Status_reg[0] 
       (.C(Clk),
        .CE(1'b1),
        .D(tx_buffer_empty_i_reg[0]),
        .Q(UART_Status[0]),
        .R(\UART_Status[6]_i_1_n_0 ));
  FDRE \UART_Status_reg[3] 
       (.C(Clk),
        .CE(1'b1),
        .D(tx_buffer_empty_i_reg[1]),
        .Q(UART_Status[3]),
        .R(\UART_Status[6]_i_1_n_0 ));
  FDRE \UART_Status_reg[5] 
       (.C(Clk),
        .CE(1'b1),
        .D(D[0]),
        .Q(UART_Status[5]),
        .R(\UART_Status[6]_i_1_n_0 ));
  FDRE \UART_Status_reg[6] 
       (.C(Clk),
        .CE(1'b1),
        .D(D[1]),
        .Q(UART_Status[6]),
        .R(\UART_Status[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hEA)) 
    error_interrupt_i_1
       (.I0(rx_2_reg),
        .I1(tx_buffer_empty_i_reg[0]),
        .I2(out),
        .O(error_interrupt_i_1_n_0));
  FDRE error_interrupt_reg
       (.C(Clk),
        .CE(1'b1),
        .D(error_interrupt_i_1_n_0),
        .Q(UART_Error_Interrupt),
        .R(Rst));
  FDRE frame_error_reg
       (.C(Clk),
        .CE(1'b1),
        .D(frame_error_reg_0),
        .Q(D[1]),
        .R(Rst));
  LUT6 #(
    .INIT(64'h0000000000020000)) 
    overrun_error_i_2
       (.I0(lmb_reg_read),
        .I1(Q[3]),
        .I2(Q[2]),
        .I3(Q[0]),
        .I4(Q[1]),
        .I5(Q[4]),
        .O(UART_Status_Read));
  FDRE overrun_error_reg
       (.C(Clk),
        .CE(1'b1),
        .D(rx_data_exists_i_reg),
        .Q(D[0]),
        .R(Rst));
endmodule

(* ORIG_REF_NAME = "XIL_SRL16E" *) 
module bd_fc5c_iomodule_0_0_XIL_SRL16E
   (div16,
    en_16x_baud,
    Clk);
  output div16;
  input en_16x_baud;
  input Clk;

  wire Clk;
  wire div16;
  wire en_16x_baud;

  (* box_type = "PRIMITIVE" *) 
  (* srl_name = "U0/\IOModule_Core_I1/Using_UART_TX.UART_TX_I1/DIV16_SRL16E/Use_unisim.XIL_SRL16E_I1 " *) 
  SRL16E #(
    .INIT(16'h0001),
    .IS_CLK_INVERTED(1'b0)) 
    \Use_unisim.XIL_SRL16E_I1 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(en_16x_baud),
        .CLK(Clk),
        .D(div16),
        .Q(div16));
endmodule

(* ORIG_REF_NAME = "XIL_SRL16E" *) 
module bd_fc5c_iomodule_0_0_XIL_SRL16E_0
   (loop_Bit,
    Clk_En_I_1,
    Clk);
  output loop_Bit;
  input Clk_En_I_1;
  input Clk;

  wire Clk;
  wire Clk_En_I_1;
  wire loop_Bit;

  (* box_type = "PRIMITIVE" *) 
  (* srl_bus_name = "U0/\IOModule_Core_I1/Using_UART.No_Dynamic_BaudRate.UART_FIT_I/Implement_FIT.Using_SRL16s.SRL16s " *) 
  (* srl_name = "U0/\IOModule_Core_I1/Using_UART.No_Dynamic_BaudRate.UART_FIT_I/Implement_FIT.Using_SRL16s.SRL16s[2].Divide_I/One_SRL16.SRL16E_I/Use_unisim.XIL_SRL16E_I1 " *) 
  SRL16E #(
    .INIT(16'h0001),
    .IS_CLK_INVERTED(1'b0)) 
    \Use_unisim.XIL_SRL16E_I1 
       (.A0(1'b1),
        .A1(1'b0),
        .A2(1'b1),
        .A3(1'b0),
        .CE(Clk_En_I_1),
        .CLK(Clk),
        .D(loop_Bit),
        .Q(loop_Bit));
endmodule

(* ORIG_REF_NAME = "XIL_SRL16E" *) 
module bd_fc5c_iomodule_0_0_XIL_SRL16E_1
   (Clk_En_I_1,
    Clk);
  output Clk_En_I_1;
  input Clk;

  wire Clk;
  wire Clk_En_I_1;

  (* box_type = "PRIMITIVE" *) 
  (* srl_bus_name = "U0/\IOModule_Core_I1/Using_UART.No_Dynamic_BaudRate.UART_FIT_I/Implement_FIT.Using_SRL16s.SRL16s " *) 
  (* srl_name = "U0/\IOModule_Core_I1/Using_UART.No_Dynamic_BaudRate.UART_FIT_I/Implement_FIT.Using_SRL16s.SRL16s[1].Divide_I/One_SRL16.SRL16E_I/Use_unisim.XIL_SRL16E_I1 " *) 
  SRL16E #(
    .INIT(16'h0001),
    .IS_CLK_INVERTED(1'b0)) 
    \Use_unisim.XIL_SRL16E_I1 
       (.A0(1'b0),
        .A1(1'b0),
        .A2(1'b0),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(Clk),
        .D(Clk_En_I_1),
        .Q(Clk_En_I_1));
endmodule

(* ORIG_REF_NAME = "XIL_SRL16E" *) 
module bd_fc5c_iomodule_0_0_XIL_SRL16E_2
   (loop_Bit,
    Clk_En_I_2,
    Clk);
  output loop_Bit;
  input Clk_En_I_2;
  input Clk;

  wire Clk;
  wire Clk_En_I_2;
  wire loop_Bit;

  (* box_type = "PRIMITIVE" *) 
  (* srl_bus_name = "U0/\IOModule_Core_I1/FIT_I1/Implement_FIT.Using_SRL16s.SRL16s " *) 
  (* srl_name = "U0/\IOModule_Core_I1/FIT_I1/Implement_FIT.Using_SRL16s.SRL16s[2].Divide_I/One_SRL16.SRL16E_I/Use_unisim.XIL_SRL16E_I1 " *) 
  SRL16E #(
    .INIT(16'h0001),
    .IS_CLK_INVERTED(1'b0)) 
    \Use_unisim.XIL_SRL16E_I1 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b0),
        .A3(1'b1),
        .CE(Clk_En_I_2),
        .CLK(Clk),
        .D(loop_Bit),
        .Q(loop_Bit));
endmodule

(* ORIG_REF_NAME = "XIL_SRL16E" *) 
module bd_fc5c_iomodule_0_0_XIL_SRL16E_3
   (Clk_En_I_2,
    Clk);
  output Clk_En_I_2;
  input Clk;

  wire Clk;
  wire Clk_En_I_2;

  (* box_type = "PRIMITIVE" *) 
  (* srl_bus_name = "U0/\IOModule_Core_I1/FIT_I1/Implement_FIT.Using_SRL16s.SRL16s " *) 
  (* srl_name = "U0/\IOModule_Core_I1/FIT_I1/Implement_FIT.Using_SRL16s.SRL16s[1].Divide_I/One_SRL16.SRL16E_I/Use_unisim.XIL_SRL16E_I1 " *) 
  SRL16E #(
    .INIT(16'h0001),
    .IS_CLK_INVERTED(1'b0)) 
    \Use_unisim.XIL_SRL16E_I1 
       (.A0(1'b1),
        .A1(1'b0),
        .A2(1'b1),
        .A3(1'b1),
        .CE(1'b1),
        .CLK(Clk),
        .D(Clk_En_I_2),
        .Q(Clk_En_I_2));
endmodule

(* ORIG_REF_NAME = "XIL_SRL16E" *) 
module bd_fc5c_iomodule_0_0_XIL_SRL16E__parameterized1
   (mid_Start_Bit,
    en_16x_baud,
    start_Edge_Detected_reg,
    Clk);
  output mid_Start_Bit;
  input en_16x_baud;
  input start_Edge_Detected_reg;
  input Clk;

  wire Clk;
  wire en_16x_baud;
  wire mid_Start_Bit;
  wire start_Edge_Detected_reg;

  (* box_type = "PRIMITIVE" *) 
  (* srl_name = "U0/\IOModule_Core_I1/Using_UART_RX.UART_RX_I1/Mid_Start_Bit_SRL16/Use_unisim.XIL_SRL16E_I1 " *) 
  SRL16E #(
    .INIT(16'h0000),
    .IS_CLK_INVERTED(1'b0)) 
    \Use_unisim.XIL_SRL16E_I1 
       (.A0(1'b0),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b0),
        .CE(en_16x_baud),
        .CLK(Clk),
        .D(start_Edge_Detected_reg),
        .Q(mid_Start_Bit));
endmodule

(* ORIG_REF_NAME = "XIL_SRL16E" *) 
module bd_fc5c_iomodule_0_0_XIL_SRL16E__parameterized3
   (sample_Point,
    stop_Bit_Position_reg,
    running_reg,
    \Convert_Serial_To_Parallel[8].serial_to_parallel_reg ,
    \Convert_Serial_To_Parallel[7].serial_to_parallel_reg ,
    \Convert_Serial_To_Parallel[6].serial_to_parallel_reg ,
    \Convert_Serial_To_Parallel[5].serial_to_parallel_reg ,
    \Convert_Serial_To_Parallel[4].serial_to_parallel_reg ,
    \Convert_Serial_To_Parallel[3].serial_to_parallel_reg ,
    \Convert_Serial_To_Parallel[2].serial_to_parallel_reg ,
    D_0,
    en_16x_baud,
    Clk,
    out,
    stop_Bit_Position_reg_0,
    start_Edge_Detected_reg,
    running_reg_0,
    mid_Start_Bit);
  output sample_Point;
  output stop_Bit_Position_reg;
  output running_reg;
  output \Convert_Serial_To_Parallel[8].serial_to_parallel_reg ;
  output \Convert_Serial_To_Parallel[7].serial_to_parallel_reg ;
  output \Convert_Serial_To_Parallel[6].serial_to_parallel_reg ;
  output \Convert_Serial_To_Parallel[5].serial_to_parallel_reg ;
  output \Convert_Serial_To_Parallel[4].serial_to_parallel_reg ;
  output \Convert_Serial_To_Parallel[3].serial_to_parallel_reg ;
  output \Convert_Serial_To_Parallel[2].serial_to_parallel_reg ;
  output D_0;
  input en_16x_baud;
  input Clk;
  input [8:0]out;
  input stop_Bit_Position_reg_0;
  input start_Edge_Detected_reg;
  input running_reg_0;
  input mid_Start_Bit;

  wire Clk;
  wire \Convert_Serial_To_Parallel[2].serial_to_parallel_reg ;
  wire \Convert_Serial_To_Parallel[3].serial_to_parallel_reg ;
  wire \Convert_Serial_To_Parallel[4].serial_to_parallel_reg ;
  wire \Convert_Serial_To_Parallel[5].serial_to_parallel_reg ;
  wire \Convert_Serial_To_Parallel[6].serial_to_parallel_reg ;
  wire \Convert_Serial_To_Parallel[7].serial_to_parallel_reg ;
  wire \Convert_Serial_To_Parallel[8].serial_to_parallel_reg ;
  wire D_0;
  wire \Use_unisim.XIL_SRL16E_I1_i_1_n_0 ;
  wire en_16x_baud;
  wire mid_Start_Bit;
  wire [8:0]out;
  wire running_reg;
  wire running_reg_0;
  wire sample_Point;
  wire start_Edge_Detected_reg;
  wire stop_Bit_Position_reg;
  wire stop_Bit_Position_reg_0;

  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'hBA8A)) 
    \Convert_Serial_To_Parallel[1].First_Bit.First_Bit_I_i_1 
       (.I0(out[7]),
        .I1(stop_Bit_Position_reg_0),
        .I2(sample_Point),
        .I3(out[8]),
        .O(D_0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'hBA8A)) 
    \Convert_Serial_To_Parallel[2].Rest_Bits.Others_I_i_1 
       (.I0(out[6]),
        .I1(stop_Bit_Position_reg_0),
        .I2(sample_Point),
        .I3(out[7]),
        .O(\Convert_Serial_To_Parallel[2].serial_to_parallel_reg ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'hBA8A)) 
    \Convert_Serial_To_Parallel[3].Rest_Bits.Others_I_i_1 
       (.I0(out[5]),
        .I1(stop_Bit_Position_reg_0),
        .I2(sample_Point),
        .I3(out[6]),
        .O(\Convert_Serial_To_Parallel[3].serial_to_parallel_reg ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'hBA8A)) 
    \Convert_Serial_To_Parallel[4].Rest_Bits.Others_I_i_1 
       (.I0(out[4]),
        .I1(stop_Bit_Position_reg_0),
        .I2(sample_Point),
        .I3(out[5]),
        .O(\Convert_Serial_To_Parallel[4].serial_to_parallel_reg ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'hBA8A)) 
    \Convert_Serial_To_Parallel[5].Rest_Bits.Others_I_i_1 
       (.I0(out[3]),
        .I1(stop_Bit_Position_reg_0),
        .I2(sample_Point),
        .I3(out[4]),
        .O(\Convert_Serial_To_Parallel[5].serial_to_parallel_reg ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'hBA8A)) 
    \Convert_Serial_To_Parallel[6].Rest_Bits.Others_I_i_1 
       (.I0(out[2]),
        .I1(stop_Bit_Position_reg_0),
        .I2(sample_Point),
        .I3(out[3]),
        .O(\Convert_Serial_To_Parallel[6].serial_to_parallel_reg ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'hBA8A)) 
    \Convert_Serial_To_Parallel[7].Rest_Bits.Others_I_i_1 
       (.I0(out[1]),
        .I1(stop_Bit_Position_reg_0),
        .I2(sample_Point),
        .I3(out[2]),
        .O(\Convert_Serial_To_Parallel[7].serial_to_parallel_reg ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'hBA8A)) 
    \Convert_Serial_To_Parallel[8].Rest_Bits.Others_I_i_1 
       (.I0(out[0]),
        .I1(stop_Bit_Position_reg_0),
        .I2(sample_Point),
        .I3(out[1]),
        .O(\Convert_Serial_To_Parallel[8].serial_to_parallel_reg ));
  (* box_type = "PRIMITIVE" *) 
  (* srl_name = "U0/\IOModule_Core_I1/Using_UART_RX.UART_RX_I1/Delay_16/Use_unisim.XIL_SRL16E_I1 " *) 
  SRL16E #(
    .INIT(16'h0000),
    .IS_CLK_INVERTED(1'b0)) 
    \Use_unisim.XIL_SRL16E_I1 
       (.A0(1'b1),
        .A1(1'b1),
        .A2(1'b1),
        .A3(1'b1),
        .CE(en_16x_baud),
        .CLK(Clk),
        .D(\Use_unisim.XIL_SRL16E_I1_i_1_n_0 ),
        .Q(sample_Point));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \Use_unisim.XIL_SRL16E_I1_i_1 
       (.I0(sample_Point),
        .I1(mid_Start_Bit),
        .I2(stop_Bit_Position_reg_0),
        .O(\Use_unisim.XIL_SRL16E_I1_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hF7FFF000)) 
    running_i_1
       (.I0(sample_Point),
        .I1(stop_Bit_Position_reg_0),
        .I2(start_Edge_Detected_reg),
        .I3(en_16x_baud),
        .I4(running_reg_0),
        .O(running_reg));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h2CCC)) 
    stop_Bit_Position_i_1
       (.I0(out[0]),
        .I1(stop_Bit_Position_reg_0),
        .I2(sample_Point),
        .I3(en_16x_baud),
        .O(stop_Bit_Position_reg));
endmodule

(* ORIG_REF_NAME = "XIL_SRL16E" *) 
module bd_fc5c_iomodule_0_0_XIL_SRL16E__parameterized9
   (loop_Bit,
    Clk_En_I_1,
    shifts_0,
    Clk);
  output loop_Bit;
  input Clk_En_I_1;
  input shifts_0;
  input Clk;

  wire Clk;
  wire Clk_En_I_1;
  wire loop_Bit;
  wire shifts_0;

  (* box_type = "PRIMITIVE" *) 
  (* srl_bus_name = "U0/\IOModule_Core_I1/FIT_I1/Implement_FIT.Using_SRL16s.SRL16s " *) 
  (* srl_name = "U0/\IOModule_Core_I1/FIT_I1/Implement_FIT.Using_SRL16s.SRL16s[3].Divide_I/More_Than_Two.SRL16E_n/Use_unisim.XIL_SRL16E_I1 " *) 
  SRL16E #(
    .INIT(16'h0000),
    .IS_CLK_INVERTED(1'b0)) 
    \Use_unisim.XIL_SRL16E_I1 
       (.A0(1'b0),
        .A1(1'b0),
        .A2(1'b1),
        .A3(1'b0),
        .CE(Clk_En_I_1),
        .CLK(Clk),
        .D(shifts_0),
        .Q(loop_Bit));
endmodule

(* ORIG_REF_NAME = "XIL_SRLC16E" *) 
module bd_fc5c_iomodule_0_0_XIL_SRLC16E
   (shifts_1,
    Clk_En_I_1,
    loop_Bit,
    Clk);
  output shifts_1;
  input Clk_En_I_1;
  input loop_Bit;
  input Clk;

  wire Clk;
  wire Clk_En_I_1;
  wire loop_Bit;
  wire shifts_1;

endmodule

(* ORIG_REF_NAME = "XIL_SRLC16E" *) 
module bd_fc5c_iomodule_0_0_XIL_SRLC16E__parameterized1
   (shifts_0,
    Clk_En_I_1,
    shifts_1,
    Clk,
    lopt,
    lopt_1);
  output shifts_0;
  input Clk_En_I_1;
  input shifts_1;
  input Clk;
  input lopt;
  input lopt_1;

  wire Clk;
  wire Clk_En_I_1;
  wire \Use_unisim.XIL_SRL16CE_I1_n_0 ;
  wire lopt;
  wire lopt_1;
  wire shifts_0;
  wire shifts_1;

  (* box_type = "PRIMITIVE" *) 
  SRLC32E #(
    .INIT(32'h00000001),
    .IS_CLK_INVERTED(1'b0)) 
    \Use_unisim.XIL_SRL16CE_I1Use_unisim.XIL_SRL16CE_I1 
       (.A({lopt_1,1'b1,1'b1,1'b1,1'b1}),
        .CE(Clk_En_I_1),
        .CLK(Clk),
        .D(lopt),
        .Q(\Use_unisim.XIL_SRL16CE_I1_n_0 ),
        .Q31(shifts_0));
endmodule

(* ORIG_REF_NAME = "intr_ctrl" *) 
module bd_fc5c_iomodule_0_0_intr_ctrl
   (INTC_IRQ,
    Sl_DBus,
    INTC_Interrupt_Address,
    Clk,
    Rst,
    Q,
    lmb_reg_write,
    lmb_reg_read,
    out,
    new_rx_data_write_reg,
    data_is_sent_reg,
    INTC_Processor_Ack,
    io_bus_read_data,
    \RX_Data_reg[2] ,
    INTC_Interrupt);
  output INTC_IRQ;
  output [2:0]Sl_DBus;
  output [14:0]INTC_Interrupt_Address;
  input Clk;
  input Rst;
  input [5:0]Q;
  input lmb_reg_write;
  input lmb_reg_read;
  input [15:0]out;
  input new_rx_data_write_reg;
  input data_is_sent_reg;
  input [1:0]INTC_Processor_Ack;
  input [2:0]io_bus_read_data;
  input [1:0]\RX_Data_reg[2] ;
  input [0:0]INTC_Interrupt;

  wire \All_INTR_Bits[16].Using_CIMR.cimr[16]_i_1_n_0 ;
  wire \All_INTR_Bits[16].Using_Intr.cier[16]_i_1_n_0 ;
  wire \All_INTR_Bits[16].Using_Intr.cisr[16]_i_2_n_0 ;
  wire \All_INTR_Bits[16].Using_Intr.cisr[16]_i_3_n_0 ;
  wire \All_INTR_Bits[1].Using_CIMR.cimr[1]_i_1_n_0 ;
  wire \All_INTR_Bits[1].Using_CIMR.cimr[1]_i_2_n_0 ;
  wire \All_INTR_Bits[1].Using_Intr.cier[1]_i_1_n_0 ;
  wire \All_INTR_Bits[1].Using_Intr.cisr[1]_i_1_n_0 ;
  wire \All_INTR_Bits[1].Using_Intr.cisr[1]_i_2_n_0 ;
  wire \All_INTR_Bits[1].Using_Intr.cisr[1]_i_3_n_0 ;
  wire \All_INTR_Bits[1].Using_Intr.cisr[1]_i_4_n_0 ;
  wire \All_INTR_Bits[2].Using_CIMR.cimr[2]_i_1_n_0 ;
  wire \All_INTR_Bits[2].Using_Intr.cier[2]_i_1_n_0 ;
  wire \All_INTR_Bits[2].Using_Intr.cisr[2]_i_2_n_0 ;
  wire Clk;
  wire D;
  wire D25_out;
  wire D35_out;
  wire [16:1]INTC_CIPR;
  wire [16:1]INTC_CISR;
  wire \INTC_CISR[16]_i_1_n_0 ;
  wire \INTC_CISR[16]_i_2_n_0 ;
  wire \INTC_CISR[1]_i_1_n_0 ;
  wire \INTC_CISR[2]_i_1_n_0 ;
  wire INTC_IRQ;
  wire [0:0]INTC_Interrupt;
  wire [14:0]INTC_Interrupt_Address;
  wire [1:0]INTC_Processor_Ack;
  wire [5:0]Q;
  wire R;
  wire [1:0]\RX_Data_reg[2] ;
  wire Rst;
  wire [2:0]Sl_DBus;
  wire \Using_Fast.INTC_IRQ_i_1_n_0 ;
  wire \Using_Fast.Using_LUTRAM.civar[0][14]_i_2_n_0 ;
  wire \Using_Fast.Using_LUTRAM.civar[19][14]_i_2_n_0 ;
  wire \Using_Fast.Using_LUTRAM.civar[3][14]_i_2_n_0 ;
  wire [14:0]\Using_Fast.Using_LUTRAM.civar_reg[0] ;
  wire [14:0]\Using_Fast.Using_LUTRAM.civar_reg[16] ;
  wire [14:0]\Using_Fast.Using_LUTRAM.civar_reg[17] ;
  wire [14:0]\Using_Fast.Using_LUTRAM.civar_reg[18] ;
  wire [14:0]\Using_Fast.Using_LUTRAM.civar_reg[19] ;
  wire [14:0]\Using_Fast.Using_LUTRAM.civar_reg[1] ;
  wire [14:0]\Using_Fast.Using_LUTRAM.civar_reg[2] ;
  wire [14:0]\Using_Fast.Using_LUTRAM.civar_reg[3] ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[0]_i_2_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[0]_i_3_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[10]_i_2_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[10]_i_3_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[11]_i_2_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[11]_i_3_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[12]_i_2_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[12]_i_3_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[13]_i_2_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[13]_i_3_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[14]_i_2_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[14]_i_3_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[1]_i_2_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[1]_i_3_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[2]_i_2_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[2]_i_3_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[3]_i_2_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[3]_i_3_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[4]_i_2_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[4]_i_3_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[5]_i_2_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[5]_i_3_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[6]_i_2_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[6]_i_3_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[7]_i_2_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[7]_i_3_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[8]_i_2_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[8]_i_3_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[9]_i_2_n_0 ;
  wire \Using_Fast.Using_LUTRAM.intr_addr_i[9]_i_3_n_0 ;
  wire \Using_Fast.civr[0]_i_1_n_0 ;
  wire \Using_Fast.civr[1]_i_1_n_0 ;
  wire \Using_Fast.civr[4]_i_1_n_0 ;
  wire \Using_Fast.civr_reg_n_0_[0] ;
  wire \Using_Fast.civr_reg_n_0_[1] ;
  wire \Using_Fast.civr_reg_n_0_[4] ;
  wire \Using_Fast.do_fast_ack_i_1_n_0 ;
  wire \Using_Fast.fast_state[0]_i_1_n_0 ;
  wire \Using_Fast.fast_state[1]_i_1_n_0 ;
  wire \Using_Fast.fast_state_reg_n_0_[0] ;
  wire \Using_Fast.fast_state_reg_n_0_[1] ;
  wire [0:0]byte_zeros__1;
  wire [16:1]cier;
  wire [16:1]cimr;
  wire [16:1]cisr;
  wire \civar[0]_3 ;
  wire \civar[16]_4 ;
  wire \civar[17]_5 ;
  wire \civar[18]_6 ;
  wire \civar[19]_7 ;
  wire \civar[1]_1 ;
  wire \civar[2]_2 ;
  wire [14:0]\civar[31]_8 ;
  wire \civar[3]_0 ;
  wire data_is_sent_reg;
  wire do_fast_ack;
  wire has_fast__5;
  (* async_reg = "true" *) wire [0:1]intr_ff;
  wire [2:0]io_bus_read_data;
  wire lmb_reg_read;
  wire lmb_reg_write;
  wire new_rx_data_write_reg;
  wire [15:0]out;
  wire p_11_out;
  wire [16:16]p_5_out;
  wire p_6_out7_out;

  LUT6 #(
    .INIT(64'hFFFFBFFF00008000)) 
    \All_INTR_Bits[16].Using_CIMR.cimr[16]_i_1 
       (.I0(out[15]),
        .I1(\All_INTR_Bits[1].Using_CIMR.cimr[1]_i_2_n_0 ),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(Q[4]),
        .I5(cimr[16]),
        .O(\All_INTR_Bits[16].Using_CIMR.cimr[16]_i_1_n_0 ));
  FDRE \All_INTR_Bits[16].Using_CIMR.cimr_reg[16] 
       (.C(Clk),
        .CE(1'b1),
        .D(\All_INTR_Bits[16].Using_CIMR.cimr[16]_i_1_n_0 ),
        .Q(cimr[16]),
        .R(Rst));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \All_INTR_Bits[16].Using_Intr.Ext_Intr.Async_Gen.intr_ff_reg[0] 
       (.C(Clk),
        .CE(1'b1),
        .D(INTC_Interrupt),
        .Q(intr_ff[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* KEEP = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \All_INTR_Bits[16].Using_Intr.Ext_Intr.Async_Gen.intr_ff_reg[1] 
       (.C(Clk),
        .CE(1'b1),
        .D(intr_ff[0]),
        .Q(intr_ff[1]),
        .R(1'b0));
  FDRE \All_INTR_Bits[16].Using_Intr.Ext_Intr.interrupt_reg[16] 
       (.C(Clk),
        .CE(1'b1),
        .D(intr_ff[1]),
        .Q(p_5_out),
        .R(Rst));
  LUT6 #(
    .INIT(64'hFFFFFBFF00000800)) 
    \All_INTR_Bits[16].Using_Intr.cier[16]_i_1 
       (.I0(out[15]),
        .I1(\All_INTR_Bits[1].Using_Intr.cisr[1]_i_2_n_0 ),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(Q[4]),
        .I5(cier[16]),
        .O(\All_INTR_Bits[16].Using_Intr.cier[16]_i_1_n_0 ));
  FDRE \All_INTR_Bits[16].Using_Intr.cier_reg[16] 
       (.C(Clk),
        .CE(1'b1),
        .D(\All_INTR_Bits[16].Using_Intr.cier[16]_i_1_n_0 ),
        .Q(cier[16]),
        .R(Rst));
  LUT6 #(
    .INIT(64'hFFFFFFFF7F000000)) 
    \All_INTR_Bits[16].Using_Intr.cisr[16]_i_1 
       (.I0(out[15]),
        .I1(\All_INTR_Bits[1].Using_Intr.cisr[1]_i_2_n_0 ),
        .I2(\All_INTR_Bits[1].Using_Intr.cisr[1]_i_3_n_0 ),
        .I3(cisr[16]),
        .I4(\All_INTR_Bits[16].Using_Intr.cisr[16]_i_2_n_0 ),
        .I5(\All_INTR_Bits[16].Using_Intr.cisr[16]_i_3_n_0 ),
        .O(p_11_out));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'h0000EFFF)) 
    \All_INTR_Bits[16].Using_Intr.cisr[16]_i_2 
       (.I0(\Using_Fast.civr_reg_n_0_[0] ),
        .I1(\Using_Fast.civr_reg_n_0_[1] ),
        .I2(do_fast_ack),
        .I3(\Using_Fast.civr_reg_n_0_[4] ),
        .I4(Rst),
        .O(\All_INTR_Bits[16].Using_Intr.cisr[16]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \All_INTR_Bits[16].Using_Intr.cisr[16]_i_3 
       (.I0(p_5_out),
        .I1(Rst),
        .O(\All_INTR_Bits[16].Using_Intr.cisr[16]_i_3_n_0 ));
  FDRE \All_INTR_Bits[16].Using_Intr.cisr_reg[16] 
       (.C(Clk),
        .CE(1'b1),
        .D(p_11_out),
        .Q(cisr[16]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFFBFFF00008000)) 
    \All_INTR_Bits[1].Using_CIMR.cimr[1]_i_1 
       (.I0(out[0]),
        .I1(\All_INTR_Bits[1].Using_CIMR.cimr[1]_i_2_n_0 ),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(Q[4]),
        .I5(cimr[1]),
        .O(\All_INTR_Bits[1].Using_CIMR.cimr[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'h0004)) 
    \All_INTR_Bits[1].Using_CIMR.cimr[1]_i_2 
       (.I0(Q[5]),
        .I1(lmb_reg_write),
        .I2(Q[2]),
        .I3(Q[3]),
        .O(\All_INTR_Bits[1].Using_CIMR.cimr[1]_i_2_n_0 ));
  FDRE \All_INTR_Bits[1].Using_CIMR.cimr_reg[1] 
       (.C(Clk),
        .CE(1'b1),
        .D(\All_INTR_Bits[1].Using_CIMR.cimr[1]_i_1_n_0 ),
        .Q(cimr[1]),
        .R(Rst));
  LUT6 #(
    .INIT(64'hFFFFFBFF00000800)) 
    \All_INTR_Bits[1].Using_Intr.cier[1]_i_1 
       (.I0(out[0]),
        .I1(\All_INTR_Bits[1].Using_Intr.cisr[1]_i_2_n_0 ),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(Q[4]),
        .I5(cier[1]),
        .O(\All_INTR_Bits[1].Using_Intr.cier[1]_i_1_n_0 ));
  FDRE \All_INTR_Bits[1].Using_Intr.cier_reg[1] 
       (.C(Clk),
        .CE(1'b1),
        .D(\All_INTR_Bits[1].Using_Intr.cier[1]_i_1_n_0 ),
        .Q(cier[1]),
        .R(Rst));
  LUT6 #(
    .INIT(64'hFFFFFFFF7F000000)) 
    \All_INTR_Bits[1].Using_Intr.cisr[1]_i_1 
       (.I0(out[0]),
        .I1(\All_INTR_Bits[1].Using_Intr.cisr[1]_i_2_n_0 ),
        .I2(\All_INTR_Bits[1].Using_Intr.cisr[1]_i_3_n_0 ),
        .I3(cisr[1]),
        .I4(\All_INTR_Bits[1].Using_Intr.cisr[1]_i_4_n_0 ),
        .I5(data_is_sent_reg),
        .O(\All_INTR_Bits[1].Using_Intr.cisr[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    \All_INTR_Bits[1].Using_Intr.cisr[1]_i_2 
       (.I0(Q[5]),
        .I1(lmb_reg_write),
        .I2(Q[2]),
        .I3(Q[3]),
        .O(\All_INTR_Bits[1].Using_Intr.cisr[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \All_INTR_Bits[1].Using_Intr.cisr[1]_i_3 
       (.I0(Q[4]),
        .I1(Q[1]),
        .I2(Q[0]),
        .O(\All_INTR_Bits[1].Using_Intr.cisr[1]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h0000FFDF)) 
    \All_INTR_Bits[1].Using_Intr.cisr[1]_i_4 
       (.I0(\Using_Fast.civr_reg_n_0_[0] ),
        .I1(\Using_Fast.civr_reg_n_0_[1] ),
        .I2(do_fast_ack),
        .I3(\Using_Fast.civr_reg_n_0_[4] ),
        .I4(Rst),
        .O(\All_INTR_Bits[1].Using_Intr.cisr[1]_i_4_n_0 ));
  FDRE \All_INTR_Bits[1].Using_Intr.cisr_reg[1] 
       (.C(Clk),
        .CE(1'b1),
        .D(\All_INTR_Bits[1].Using_Intr.cisr[1]_i_1_n_0 ),
        .Q(cisr[1]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFFBFFF00008000)) 
    \All_INTR_Bits[2].Using_CIMR.cimr[2]_i_1 
       (.I0(out[1]),
        .I1(\All_INTR_Bits[1].Using_CIMR.cimr[1]_i_2_n_0 ),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(Q[4]),
        .I5(cimr[2]),
        .O(\All_INTR_Bits[2].Using_CIMR.cimr[2]_i_1_n_0 ));
  FDRE \All_INTR_Bits[2].Using_CIMR.cimr_reg[2] 
       (.C(Clk),
        .CE(1'b1),
        .D(\All_INTR_Bits[2].Using_CIMR.cimr[2]_i_1_n_0 ),
        .Q(cimr[2]),
        .R(Rst));
  LUT6 #(
    .INIT(64'hFFFFFBFF00000800)) 
    \All_INTR_Bits[2].Using_Intr.cier[2]_i_1 
       (.I0(out[1]),
        .I1(\All_INTR_Bits[1].Using_Intr.cisr[1]_i_2_n_0 ),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(Q[4]),
        .I5(cier[2]),
        .O(\All_INTR_Bits[2].Using_Intr.cier[2]_i_1_n_0 ));
  FDRE \All_INTR_Bits[2].Using_Intr.cier_reg[2] 
       (.C(Clk),
        .CE(1'b1),
        .D(\All_INTR_Bits[2].Using_Intr.cier[2]_i_1_n_0 ),
        .Q(cier[2]),
        .R(Rst));
  LUT6 #(
    .INIT(64'hFFFFFFFF7F000000)) 
    \All_INTR_Bits[2].Using_Intr.cisr[2]_i_1 
       (.I0(out[1]),
        .I1(\All_INTR_Bits[1].Using_Intr.cisr[1]_i_2_n_0 ),
        .I2(\All_INTR_Bits[1].Using_Intr.cisr[1]_i_3_n_0 ),
        .I3(cisr[2]),
        .I4(\All_INTR_Bits[2].Using_Intr.cisr[2]_i_2_n_0 ),
        .I5(new_rx_data_write_reg),
        .O(p_6_out7_out));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'h0000FFDF)) 
    \All_INTR_Bits[2].Using_Intr.cisr[2]_i_2 
       (.I0(\Using_Fast.civr_reg_n_0_[1] ),
        .I1(\Using_Fast.civr_reg_n_0_[0] ),
        .I2(do_fast_ack),
        .I3(\Using_Fast.civr_reg_n_0_[4] ),
        .I4(Rst),
        .O(\All_INTR_Bits[2].Using_Intr.cisr[2]_i_2_n_0 ));
  FDRE \All_INTR_Bits[2].Using_Intr.cisr_reg[2] 
       (.C(Clk),
        .CE(1'b1),
        .D(p_6_out7_out),
        .Q(cisr[2]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \INTC_CISR[16]_i_1 
       (.I0(cisr[16]),
        .I1(\INTC_CISR[16]_i_2_n_0 ),
        .O(\INTC_CISR[16]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFEFFFFFFFFFFFFFF)) 
    \INTC_CISR[16]_i_2 
       (.I0(Q[4]),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(Q[3]),
        .I4(Q[2]),
        .I5(lmb_reg_read),
        .O(\INTC_CISR[16]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \INTC_CISR[1]_i_1 
       (.I0(cisr[1]),
        .I1(\INTC_CISR[16]_i_2_n_0 ),
        .O(\INTC_CISR[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \INTC_CISR[2]_i_1 
       (.I0(cisr[2]),
        .I1(\INTC_CISR[16]_i_2_n_0 ),
        .O(\INTC_CISR[2]_i_1_n_0 ));
  FDRE \INTC_CISR_reg[16] 
       (.C(Clk),
        .CE(1'b1),
        .D(\INTC_CISR[16]_i_1_n_0 ),
        .Q(INTC_CISR[16]),
        .R(1'b0));
  FDRE \INTC_CISR_reg[1] 
       (.C(Clk),
        .CE(1'b1),
        .D(\INTC_CISR[1]_i_1_n_0 ),
        .Q(INTC_CISR[1]),
        .R(1'b0));
  FDRE \INTC_CISR_reg[2] 
       (.C(Clk),
        .CE(1'b1),
        .D(\INTC_CISR[2]_i_1_n_0 ),
        .Q(INTC_CISR[2]),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hFE)) 
    \Sl_DBus[15]_INST_0 
       (.I0(io_bus_read_data[2]),
        .I1(INTC_CIPR[16]),
        .I2(INTC_CISR[16]),
        .O(Sl_DBus[2]));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \Sl_DBus[29]_INST_0 
       (.I0(io_bus_read_data[1]),
        .I1(\RX_Data_reg[2] [1]),
        .I2(INTC_CIPR[2]),
        .I3(INTC_CISR[2]),
        .O(Sl_DBus[1]));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \Sl_DBus[30]_INST_0 
       (.I0(io_bus_read_data[0]),
        .I1(\RX_Data_reg[2] [0]),
        .I2(INTC_CIPR[1]),
        .I3(INTC_CISR[1]),
        .O(Sl_DBus[0]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'h4404)) 
    \Using_Fast.INTC_IRQ_i_1 
       (.I0(\Using_Fast.fast_state_reg_n_0_[1] ),
        .I1(\Using_Fast.fast_state_reg_n_0_[0] ),
        .I2(INTC_Processor_Ack[0]),
        .I3(INTC_Processor_Ack[1]),
        .O(\Using_Fast.INTC_IRQ_i_1_n_0 ));
  FDRE \Using_Fast.INTC_IRQ_reg 
       (.C(Clk),
        .CE(1'b1),
        .D(\Using_Fast.INTC_IRQ_i_1_n_0 ),
        .Q(INTC_IRQ),
        .R(Rst));
  LUT5 #(
    .INIT(32'h00000080)) 
    \Using_Fast.Using_LUTRAM.civar[0][14]_i_1 
       (.I0(\Using_Fast.Using_LUTRAM.civar[0][14]_i_2_n_0 ),
        .I1(Q[5]),
        .I2(lmb_reg_write),
        .I3(Q[3]),
        .I4(Q[2]),
        .O(\civar[0]_3 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \Using_Fast.Using_LUTRAM.civar[0][14]_i_2 
       (.I0(Q[4]),
        .I1(Q[1]),
        .I2(Q[0]),
        .O(\Using_Fast.Using_LUTRAM.civar[0][14]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h10)) 
    \Using_Fast.Using_LUTRAM.civar[16][14]_i_1 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(\Using_Fast.Using_LUTRAM.civar[19][14]_i_2_n_0 ),
        .O(\civar[16]_4 ));
  LUT3 #(
    .INIT(8'h40)) 
    \Using_Fast.Using_LUTRAM.civar[17][14]_i_1 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(\Using_Fast.Using_LUTRAM.civar[19][14]_i_2_n_0 ),
        .O(\civar[17]_5 ));
  LUT3 #(
    .INIT(8'h40)) 
    \Using_Fast.Using_LUTRAM.civar[18][14]_i_1 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(\Using_Fast.Using_LUTRAM.civar[19][14]_i_2_n_0 ),
        .O(\civar[18]_6 ));
  LUT3 #(
    .INIT(8'h80)) 
    \Using_Fast.Using_LUTRAM.civar[19][14]_i_1 
       (.I0(Q[1]),
        .I1(Q[0]),
        .I2(\Using_Fast.Using_LUTRAM.civar[19][14]_i_2_n_0 ),
        .O(\civar[19]_7 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'h00080000)) 
    \Using_Fast.Using_LUTRAM.civar[19][14]_i_2 
       (.I0(Q[5]),
        .I1(lmb_reg_write),
        .I2(Q[3]),
        .I3(Q[2]),
        .I4(Q[4]),
        .O(\Using_Fast.Using_LUTRAM.civar[19][14]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h0008)) 
    \Using_Fast.Using_LUTRAM.civar[1][14]_i_1 
       (.I0(\Using_Fast.Using_LUTRAM.civar[3][14]_i_2_n_0 ),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(Q[2]),
        .O(\civar[1]_1 ));
  LUT4 #(
    .INIT(16'h0020)) 
    \Using_Fast.Using_LUTRAM.civar[2][14]_i_1 
       (.I0(\Using_Fast.Using_LUTRAM.civar[3][14]_i_2_n_0 ),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(Q[2]),
        .O(\civar[2]_2 ));
  LUT4 #(
    .INIT(16'h0080)) 
    \Using_Fast.Using_LUTRAM.civar[3][14]_i_1 
       (.I0(\Using_Fast.Using_LUTRAM.civar[3][14]_i_2_n_0 ),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(Q[2]),
        .O(\civar[3]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'h0008)) 
    \Using_Fast.Using_LUTRAM.civar[3][14]_i_2 
       (.I0(lmb_reg_write),
        .I1(Q[5]),
        .I2(Q[4]),
        .I3(Q[3]),
        .O(\Using_Fast.Using_LUTRAM.civar[3][14]_i_2_n_0 ));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[0][0] 
       (.C(Clk),
        .CE(\civar[0]_3 ),
        .D(out[1]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[0] [0]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[0][10] 
       (.C(Clk),
        .CE(\civar[0]_3 ),
        .D(out[11]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[0] [10]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[0][11] 
       (.C(Clk),
        .CE(\civar[0]_3 ),
        .D(out[12]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[0] [11]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[0][12] 
       (.C(Clk),
        .CE(\civar[0]_3 ),
        .D(out[13]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[0] [12]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[0][13] 
       (.C(Clk),
        .CE(\civar[0]_3 ),
        .D(out[14]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[0] [13]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[0][14] 
       (.C(Clk),
        .CE(\civar[0]_3 ),
        .D(out[15]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[0] [14]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[0][1] 
       (.C(Clk),
        .CE(\civar[0]_3 ),
        .D(out[2]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[0] [1]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b1)) 
    \Using_Fast.Using_LUTRAM.civar_reg[0][2] 
       (.C(Clk),
        .CE(\civar[0]_3 ),
        .D(out[3]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[0] [2]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[0][3] 
       (.C(Clk),
        .CE(\civar[0]_3 ),
        .D(out[4]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[0] [3]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[0][4] 
       (.C(Clk),
        .CE(\civar[0]_3 ),
        .D(out[5]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[0] [4]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[0][5] 
       (.C(Clk),
        .CE(\civar[0]_3 ),
        .D(out[6]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[0] [5]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[0][6] 
       (.C(Clk),
        .CE(\civar[0]_3 ),
        .D(out[7]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[0] [6]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[0][7] 
       (.C(Clk),
        .CE(\civar[0]_3 ),
        .D(out[8]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[0] [7]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[0][8] 
       (.C(Clk),
        .CE(\civar[0]_3 ),
        .D(out[9]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[0] [8]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[0][9] 
       (.C(Clk),
        .CE(\civar[0]_3 ),
        .D(out[10]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[0] [9]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[16][0] 
       (.C(Clk),
        .CE(\civar[16]_4 ),
        .D(out[1]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[16] [0]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[16][10] 
       (.C(Clk),
        .CE(\civar[16]_4 ),
        .D(out[11]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[16] [10]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[16][11] 
       (.C(Clk),
        .CE(\civar[16]_4 ),
        .D(out[12]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[16] [11]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[16][12] 
       (.C(Clk),
        .CE(\civar[16]_4 ),
        .D(out[13]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[16] [12]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[16][13] 
       (.C(Clk),
        .CE(\civar[16]_4 ),
        .D(out[14]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[16] [13]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[16][14] 
       (.C(Clk),
        .CE(\civar[16]_4 ),
        .D(out[15]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[16] [14]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[16][1] 
       (.C(Clk),
        .CE(\civar[16]_4 ),
        .D(out[2]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[16] [1]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b1)) 
    \Using_Fast.Using_LUTRAM.civar_reg[16][2] 
       (.C(Clk),
        .CE(\civar[16]_4 ),
        .D(out[3]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[16] [2]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[16][3] 
       (.C(Clk),
        .CE(\civar[16]_4 ),
        .D(out[4]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[16] [3]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[16][4] 
       (.C(Clk),
        .CE(\civar[16]_4 ),
        .D(out[5]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[16] [4]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[16][5] 
       (.C(Clk),
        .CE(\civar[16]_4 ),
        .D(out[6]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[16] [5]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[16][6] 
       (.C(Clk),
        .CE(\civar[16]_4 ),
        .D(out[7]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[16] [6]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[16][7] 
       (.C(Clk),
        .CE(\civar[16]_4 ),
        .D(out[8]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[16] [7]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[16][8] 
       (.C(Clk),
        .CE(\civar[16]_4 ),
        .D(out[9]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[16] [8]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[16][9] 
       (.C(Clk),
        .CE(\civar[16]_4 ),
        .D(out[10]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[16] [9]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[17][0] 
       (.C(Clk),
        .CE(\civar[17]_5 ),
        .D(out[1]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[17] [0]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[17][10] 
       (.C(Clk),
        .CE(\civar[17]_5 ),
        .D(out[11]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[17] [10]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[17][11] 
       (.C(Clk),
        .CE(\civar[17]_5 ),
        .D(out[12]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[17] [11]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[17][12] 
       (.C(Clk),
        .CE(\civar[17]_5 ),
        .D(out[13]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[17] [12]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[17][13] 
       (.C(Clk),
        .CE(\civar[17]_5 ),
        .D(out[14]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[17] [13]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[17][14] 
       (.C(Clk),
        .CE(\civar[17]_5 ),
        .D(out[15]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[17] [14]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[17][1] 
       (.C(Clk),
        .CE(\civar[17]_5 ),
        .D(out[2]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[17] [1]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b1)) 
    \Using_Fast.Using_LUTRAM.civar_reg[17][2] 
       (.C(Clk),
        .CE(\civar[17]_5 ),
        .D(out[3]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[17] [2]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[17][3] 
       (.C(Clk),
        .CE(\civar[17]_5 ),
        .D(out[4]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[17] [3]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[17][4] 
       (.C(Clk),
        .CE(\civar[17]_5 ),
        .D(out[5]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[17] [4]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[17][5] 
       (.C(Clk),
        .CE(\civar[17]_5 ),
        .D(out[6]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[17] [5]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[17][6] 
       (.C(Clk),
        .CE(\civar[17]_5 ),
        .D(out[7]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[17] [6]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[17][7] 
       (.C(Clk),
        .CE(\civar[17]_5 ),
        .D(out[8]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[17] [7]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[17][8] 
       (.C(Clk),
        .CE(\civar[17]_5 ),
        .D(out[9]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[17] [8]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[17][9] 
       (.C(Clk),
        .CE(\civar[17]_5 ),
        .D(out[10]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[17] [9]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[18][0] 
       (.C(Clk),
        .CE(\civar[18]_6 ),
        .D(out[1]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[18] [0]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[18][10] 
       (.C(Clk),
        .CE(\civar[18]_6 ),
        .D(out[11]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[18] [10]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[18][11] 
       (.C(Clk),
        .CE(\civar[18]_6 ),
        .D(out[12]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[18] [11]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[18][12] 
       (.C(Clk),
        .CE(\civar[18]_6 ),
        .D(out[13]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[18] [12]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[18][13] 
       (.C(Clk),
        .CE(\civar[18]_6 ),
        .D(out[14]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[18] [13]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[18][14] 
       (.C(Clk),
        .CE(\civar[18]_6 ),
        .D(out[15]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[18] [14]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[18][1] 
       (.C(Clk),
        .CE(\civar[18]_6 ),
        .D(out[2]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[18] [1]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b1)) 
    \Using_Fast.Using_LUTRAM.civar_reg[18][2] 
       (.C(Clk),
        .CE(\civar[18]_6 ),
        .D(out[3]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[18] [2]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[18][3] 
       (.C(Clk),
        .CE(\civar[18]_6 ),
        .D(out[4]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[18] [3]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[18][4] 
       (.C(Clk),
        .CE(\civar[18]_6 ),
        .D(out[5]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[18] [4]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[18][5] 
       (.C(Clk),
        .CE(\civar[18]_6 ),
        .D(out[6]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[18] [5]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[18][6] 
       (.C(Clk),
        .CE(\civar[18]_6 ),
        .D(out[7]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[18] [6]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[18][7] 
       (.C(Clk),
        .CE(\civar[18]_6 ),
        .D(out[8]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[18] [7]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[18][8] 
       (.C(Clk),
        .CE(\civar[18]_6 ),
        .D(out[9]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[18] [8]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[18][9] 
       (.C(Clk),
        .CE(\civar[18]_6 ),
        .D(out[10]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[18] [9]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[19][0] 
       (.C(Clk),
        .CE(\civar[19]_7 ),
        .D(out[1]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[19] [0]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[19][10] 
       (.C(Clk),
        .CE(\civar[19]_7 ),
        .D(out[11]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[19] [10]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[19][11] 
       (.C(Clk),
        .CE(\civar[19]_7 ),
        .D(out[12]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[19] [11]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[19][12] 
       (.C(Clk),
        .CE(\civar[19]_7 ),
        .D(out[13]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[19] [12]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[19][13] 
       (.C(Clk),
        .CE(\civar[19]_7 ),
        .D(out[14]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[19] [13]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[19][14] 
       (.C(Clk),
        .CE(\civar[19]_7 ),
        .D(out[15]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[19] [14]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[19][1] 
       (.C(Clk),
        .CE(\civar[19]_7 ),
        .D(out[2]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[19] [1]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b1)) 
    \Using_Fast.Using_LUTRAM.civar_reg[19][2] 
       (.C(Clk),
        .CE(\civar[19]_7 ),
        .D(out[3]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[19] [2]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[19][3] 
       (.C(Clk),
        .CE(\civar[19]_7 ),
        .D(out[4]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[19] [3]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[19][4] 
       (.C(Clk),
        .CE(\civar[19]_7 ),
        .D(out[5]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[19] [4]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[19][5] 
       (.C(Clk),
        .CE(\civar[19]_7 ),
        .D(out[6]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[19] [5]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[19][6] 
       (.C(Clk),
        .CE(\civar[19]_7 ),
        .D(out[7]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[19] [6]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[19][7] 
       (.C(Clk),
        .CE(\civar[19]_7 ),
        .D(out[8]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[19] [7]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[19][8] 
       (.C(Clk),
        .CE(\civar[19]_7 ),
        .D(out[9]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[19] [8]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[19][9] 
       (.C(Clk),
        .CE(\civar[19]_7 ),
        .D(out[10]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[19] [9]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[1][0] 
       (.C(Clk),
        .CE(\civar[1]_1 ),
        .D(out[1]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[1] [0]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[1][10] 
       (.C(Clk),
        .CE(\civar[1]_1 ),
        .D(out[11]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[1] [10]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[1][11] 
       (.C(Clk),
        .CE(\civar[1]_1 ),
        .D(out[12]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[1] [11]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[1][12] 
       (.C(Clk),
        .CE(\civar[1]_1 ),
        .D(out[13]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[1] [12]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[1][13] 
       (.C(Clk),
        .CE(\civar[1]_1 ),
        .D(out[14]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[1] [13]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[1][14] 
       (.C(Clk),
        .CE(\civar[1]_1 ),
        .D(out[15]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[1] [14]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[1][1] 
       (.C(Clk),
        .CE(\civar[1]_1 ),
        .D(out[2]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[1] [1]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b1)) 
    \Using_Fast.Using_LUTRAM.civar_reg[1][2] 
       (.C(Clk),
        .CE(\civar[1]_1 ),
        .D(out[3]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[1] [2]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[1][3] 
       (.C(Clk),
        .CE(\civar[1]_1 ),
        .D(out[4]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[1] [3]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[1][4] 
       (.C(Clk),
        .CE(\civar[1]_1 ),
        .D(out[5]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[1] [4]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[1][5] 
       (.C(Clk),
        .CE(\civar[1]_1 ),
        .D(out[6]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[1] [5]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[1][6] 
       (.C(Clk),
        .CE(\civar[1]_1 ),
        .D(out[7]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[1] [6]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[1][7] 
       (.C(Clk),
        .CE(\civar[1]_1 ),
        .D(out[8]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[1] [7]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[1][8] 
       (.C(Clk),
        .CE(\civar[1]_1 ),
        .D(out[9]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[1] [8]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[1][9] 
       (.C(Clk),
        .CE(\civar[1]_1 ),
        .D(out[10]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[1] [9]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[2][0] 
       (.C(Clk),
        .CE(\civar[2]_2 ),
        .D(out[1]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[2] [0]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[2][10] 
       (.C(Clk),
        .CE(\civar[2]_2 ),
        .D(out[11]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[2] [10]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[2][11] 
       (.C(Clk),
        .CE(\civar[2]_2 ),
        .D(out[12]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[2] [11]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[2][12] 
       (.C(Clk),
        .CE(\civar[2]_2 ),
        .D(out[13]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[2] [12]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[2][13] 
       (.C(Clk),
        .CE(\civar[2]_2 ),
        .D(out[14]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[2] [13]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[2][14] 
       (.C(Clk),
        .CE(\civar[2]_2 ),
        .D(out[15]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[2] [14]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[2][1] 
       (.C(Clk),
        .CE(\civar[2]_2 ),
        .D(out[2]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[2] [1]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b1)) 
    \Using_Fast.Using_LUTRAM.civar_reg[2][2] 
       (.C(Clk),
        .CE(\civar[2]_2 ),
        .D(out[3]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[2] [2]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[2][3] 
       (.C(Clk),
        .CE(\civar[2]_2 ),
        .D(out[4]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[2] [3]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[2][4] 
       (.C(Clk),
        .CE(\civar[2]_2 ),
        .D(out[5]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[2] [4]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[2][5] 
       (.C(Clk),
        .CE(\civar[2]_2 ),
        .D(out[6]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[2] [5]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[2][6] 
       (.C(Clk),
        .CE(\civar[2]_2 ),
        .D(out[7]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[2] [6]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[2][7] 
       (.C(Clk),
        .CE(\civar[2]_2 ),
        .D(out[8]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[2] [7]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[2][8] 
       (.C(Clk),
        .CE(\civar[2]_2 ),
        .D(out[9]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[2] [8]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[2][9] 
       (.C(Clk),
        .CE(\civar[2]_2 ),
        .D(out[10]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[2] [9]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[3][0] 
       (.C(Clk),
        .CE(\civar[3]_0 ),
        .D(out[1]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[3] [0]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[3][10] 
       (.C(Clk),
        .CE(\civar[3]_0 ),
        .D(out[11]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[3] [10]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[3][11] 
       (.C(Clk),
        .CE(\civar[3]_0 ),
        .D(out[12]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[3] [11]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[3][12] 
       (.C(Clk),
        .CE(\civar[3]_0 ),
        .D(out[13]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[3] [12]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[3][13] 
       (.C(Clk),
        .CE(\civar[3]_0 ),
        .D(out[14]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[3] [13]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[3][14] 
       (.C(Clk),
        .CE(\civar[3]_0 ),
        .D(out[15]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[3] [14]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[3][1] 
       (.C(Clk),
        .CE(\civar[3]_0 ),
        .D(out[2]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[3] [1]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b1)) 
    \Using_Fast.Using_LUTRAM.civar_reg[3][2] 
       (.C(Clk),
        .CE(\civar[3]_0 ),
        .D(out[3]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[3] [2]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[3][3] 
       (.C(Clk),
        .CE(\civar[3]_0 ),
        .D(out[4]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[3] [3]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[3][4] 
       (.C(Clk),
        .CE(\civar[3]_0 ),
        .D(out[5]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[3] [4]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[3][5] 
       (.C(Clk),
        .CE(\civar[3]_0 ),
        .D(out[6]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[3] [5]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[3][6] 
       (.C(Clk),
        .CE(\civar[3]_0 ),
        .D(out[7]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[3] [6]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[3][7] 
       (.C(Clk),
        .CE(\civar[3]_0 ),
        .D(out[8]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[3] [7]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[3][8] 
       (.C(Clk),
        .CE(\civar[3]_0 ),
        .D(out[9]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[3] [8]),
        .R(1'b0));
  (* RAM_STYLE = "distributed" *) 
  (* ram_extract = "yes" *) 
  FDRE #(
    .INIT(1'b0)) 
    \Using_Fast.Using_LUTRAM.civar_reg[3][9] 
       (.C(Clk),
        .CE(\civar[3]_0 ),
        .D(out[10]),
        .Q(\Using_Fast.Using_LUTRAM.civar_reg[3] [9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[0]_i_2 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[1] [0]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[3] [0]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[0] [0]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[2] [0]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[0]_i_3 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[17] [0]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[19] [0]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[16] [0]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[18] [0]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[10]_i_2 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[1] [10]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[3] [10]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[0] [10]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[2] [10]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[10]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[10]_i_3 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[17] [10]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[19] [10]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[16] [10]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[18] [10]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[10]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[11]_i_2 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[1] [11]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[3] [11]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[0] [11]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[2] [11]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[11]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[11]_i_3 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[17] [11]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[19] [11]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[16] [11]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[18] [11]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[11]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[12]_i_2 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[1] [12]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[3] [12]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[0] [12]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[2] [12]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[12]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[12]_i_3 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[17] [12]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[19] [12]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[16] [12]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[18] [12]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[12]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[13]_i_2 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[1] [13]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[3] [13]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[0] [13]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[2] [13]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[13]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[13]_i_3 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[17] [13]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[19] [13]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[16] [13]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[18] [13]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[13]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[14]_i_2 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[1] [14]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[3] [14]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[0] [14]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[2] [14]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[14]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[14]_i_3 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[17] [14]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[19] [14]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[16] [14]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[18] [14]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[14]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[1]_i_2 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[1] [1]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[3] [1]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[0] [1]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[2] [1]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[1]_i_3 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[17] [1]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[19] [1]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[16] [1]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[18] [1]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[2]_i_2 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[1] [2]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[3] [2]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[0] [2]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[2] [2]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[2]_i_3 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[17] [2]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[19] [2]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[16] [2]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[18] [2]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[3]_i_2 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[1] [3]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[3] [3]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[0] [3]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[2] [3]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[3]_i_3 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[17] [3]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[19] [3]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[16] [3]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[18] [3]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[4]_i_2 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[1] [4]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[3] [4]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[0] [4]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[2] [4]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[4]_i_3 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[17] [4]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[19] [4]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[16] [4]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[18] [4]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[5]_i_2 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[1] [5]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[3] [5]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[0] [5]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[2] [5]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[5]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[5]_i_3 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[17] [5]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[19] [5]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[16] [5]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[18] [5]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[6]_i_2 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[1] [6]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[3] [6]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[0] [6]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[2] [6]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[6]_i_3 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[17] [6]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[19] [6]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[16] [6]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[18] [6]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[7]_i_2 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[1] [7]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[3] [7]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[0] [7]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[2] [7]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[7]_i_3 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[17] [7]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[19] [7]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[16] [7]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[18] [7]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[8]_i_2 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[1] [8]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[3] [8]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[0] [8]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[2] [8]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[8]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[8]_i_3 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[17] [8]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[19] [8]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[16] [8]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[18] [8]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[8]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[9]_i_2 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[1] [9]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[3] [9]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[0] [9]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[2] [9]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[9]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hCAFFCAF0CA0FCA00)) 
    \Using_Fast.Using_LUTRAM.intr_addr_i[9]_i_3 
       (.I0(\Using_Fast.Using_LUTRAM.civar_reg[17] [9]),
        .I1(\Using_Fast.Using_LUTRAM.civar_reg[19] [9]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(\Using_Fast.Using_LUTRAM.civar_reg[16] [9]),
        .I5(\Using_Fast.Using_LUTRAM.civar_reg[18] [9]),
        .O(\Using_Fast.Using_LUTRAM.intr_addr_i[9]_i_3_n_0 ));
  FDRE \Using_Fast.Using_LUTRAM.intr_addr_i_reg[0] 
       (.C(Clk),
        .CE(1'b1),
        .D(\civar[31]_8 [0]),
        .Q(INTC_Interrupt_Address[0]),
        .R(1'b0));
  MUXF7 \Using_Fast.Using_LUTRAM.intr_addr_i_reg[0]_i_1 
       (.I0(\Using_Fast.Using_LUTRAM.intr_addr_i[0]_i_2_n_0 ),
        .I1(\Using_Fast.Using_LUTRAM.intr_addr_i[0]_i_3_n_0 ),
        .O(\civar[31]_8 [0]),
        .S(\Using_Fast.civr_reg_n_0_[4] ));
  FDRE \Using_Fast.Using_LUTRAM.intr_addr_i_reg[10] 
       (.C(Clk),
        .CE(1'b1),
        .D(\civar[31]_8 [10]),
        .Q(INTC_Interrupt_Address[10]),
        .R(1'b0));
  MUXF7 \Using_Fast.Using_LUTRAM.intr_addr_i_reg[10]_i_1 
       (.I0(\Using_Fast.Using_LUTRAM.intr_addr_i[10]_i_2_n_0 ),
        .I1(\Using_Fast.Using_LUTRAM.intr_addr_i[10]_i_3_n_0 ),
        .O(\civar[31]_8 [10]),
        .S(\Using_Fast.civr_reg_n_0_[4] ));
  FDRE \Using_Fast.Using_LUTRAM.intr_addr_i_reg[11] 
       (.C(Clk),
        .CE(1'b1),
        .D(\civar[31]_8 [11]),
        .Q(INTC_Interrupt_Address[11]),
        .R(1'b0));
  MUXF7 \Using_Fast.Using_LUTRAM.intr_addr_i_reg[11]_i_1 
       (.I0(\Using_Fast.Using_LUTRAM.intr_addr_i[11]_i_2_n_0 ),
        .I1(\Using_Fast.Using_LUTRAM.intr_addr_i[11]_i_3_n_0 ),
        .O(\civar[31]_8 [11]),
        .S(\Using_Fast.civr_reg_n_0_[4] ));
  FDRE \Using_Fast.Using_LUTRAM.intr_addr_i_reg[12] 
       (.C(Clk),
        .CE(1'b1),
        .D(\civar[31]_8 [12]),
        .Q(INTC_Interrupt_Address[12]),
        .R(1'b0));
  MUXF7 \Using_Fast.Using_LUTRAM.intr_addr_i_reg[12]_i_1 
       (.I0(\Using_Fast.Using_LUTRAM.intr_addr_i[12]_i_2_n_0 ),
        .I1(\Using_Fast.Using_LUTRAM.intr_addr_i[12]_i_3_n_0 ),
        .O(\civar[31]_8 [12]),
        .S(\Using_Fast.civr_reg_n_0_[4] ));
  FDRE \Using_Fast.Using_LUTRAM.intr_addr_i_reg[13] 
       (.C(Clk),
        .CE(1'b1),
        .D(\civar[31]_8 [13]),
        .Q(INTC_Interrupt_Address[13]),
        .R(1'b0));
  MUXF7 \Using_Fast.Using_LUTRAM.intr_addr_i_reg[13]_i_1 
       (.I0(\Using_Fast.Using_LUTRAM.intr_addr_i[13]_i_2_n_0 ),
        .I1(\Using_Fast.Using_LUTRAM.intr_addr_i[13]_i_3_n_0 ),
        .O(\civar[31]_8 [13]),
        .S(\Using_Fast.civr_reg_n_0_[4] ));
  FDRE \Using_Fast.Using_LUTRAM.intr_addr_i_reg[14] 
       (.C(Clk),
        .CE(1'b1),
        .D(\civar[31]_8 [14]),
        .Q(INTC_Interrupt_Address[14]),
        .R(1'b0));
  MUXF7 \Using_Fast.Using_LUTRAM.intr_addr_i_reg[14]_i_1 
       (.I0(\Using_Fast.Using_LUTRAM.intr_addr_i[14]_i_2_n_0 ),
        .I1(\Using_Fast.Using_LUTRAM.intr_addr_i[14]_i_3_n_0 ),
        .O(\civar[31]_8 [14]),
        .S(\Using_Fast.civr_reg_n_0_[4] ));
  FDRE \Using_Fast.Using_LUTRAM.intr_addr_i_reg[1] 
       (.C(Clk),
        .CE(1'b1),
        .D(\civar[31]_8 [1]),
        .Q(INTC_Interrupt_Address[1]),
        .R(1'b0));
  MUXF7 \Using_Fast.Using_LUTRAM.intr_addr_i_reg[1]_i_1 
       (.I0(\Using_Fast.Using_LUTRAM.intr_addr_i[1]_i_2_n_0 ),
        .I1(\Using_Fast.Using_LUTRAM.intr_addr_i[1]_i_3_n_0 ),
        .O(\civar[31]_8 [1]),
        .S(\Using_Fast.civr_reg_n_0_[4] ));
  FDRE \Using_Fast.Using_LUTRAM.intr_addr_i_reg[2] 
       (.C(Clk),
        .CE(1'b1),
        .D(\civar[31]_8 [2]),
        .Q(INTC_Interrupt_Address[2]),
        .R(1'b0));
  MUXF7 \Using_Fast.Using_LUTRAM.intr_addr_i_reg[2]_i_1 
       (.I0(\Using_Fast.Using_LUTRAM.intr_addr_i[2]_i_2_n_0 ),
        .I1(\Using_Fast.Using_LUTRAM.intr_addr_i[2]_i_3_n_0 ),
        .O(\civar[31]_8 [2]),
        .S(\Using_Fast.civr_reg_n_0_[4] ));
  FDRE \Using_Fast.Using_LUTRAM.intr_addr_i_reg[3] 
       (.C(Clk),
        .CE(1'b1),
        .D(\civar[31]_8 [3]),
        .Q(INTC_Interrupt_Address[3]),
        .R(1'b0));
  MUXF7 \Using_Fast.Using_LUTRAM.intr_addr_i_reg[3]_i_1 
       (.I0(\Using_Fast.Using_LUTRAM.intr_addr_i[3]_i_2_n_0 ),
        .I1(\Using_Fast.Using_LUTRAM.intr_addr_i[3]_i_3_n_0 ),
        .O(\civar[31]_8 [3]),
        .S(\Using_Fast.civr_reg_n_0_[4] ));
  FDRE \Using_Fast.Using_LUTRAM.intr_addr_i_reg[4] 
       (.C(Clk),
        .CE(1'b1),
        .D(\civar[31]_8 [4]),
        .Q(INTC_Interrupt_Address[4]),
        .R(1'b0));
  MUXF7 \Using_Fast.Using_LUTRAM.intr_addr_i_reg[4]_i_1 
       (.I0(\Using_Fast.Using_LUTRAM.intr_addr_i[4]_i_2_n_0 ),
        .I1(\Using_Fast.Using_LUTRAM.intr_addr_i[4]_i_3_n_0 ),
        .O(\civar[31]_8 [4]),
        .S(\Using_Fast.civr_reg_n_0_[4] ));
  FDRE \Using_Fast.Using_LUTRAM.intr_addr_i_reg[5] 
       (.C(Clk),
        .CE(1'b1),
        .D(\civar[31]_8 [5]),
        .Q(INTC_Interrupt_Address[5]),
        .R(1'b0));
  MUXF7 \Using_Fast.Using_LUTRAM.intr_addr_i_reg[5]_i_1 
       (.I0(\Using_Fast.Using_LUTRAM.intr_addr_i[5]_i_2_n_0 ),
        .I1(\Using_Fast.Using_LUTRAM.intr_addr_i[5]_i_3_n_0 ),
        .O(\civar[31]_8 [5]),
        .S(\Using_Fast.civr_reg_n_0_[4] ));
  FDRE \Using_Fast.Using_LUTRAM.intr_addr_i_reg[6] 
       (.C(Clk),
        .CE(1'b1),
        .D(\civar[31]_8 [6]),
        .Q(INTC_Interrupt_Address[6]),
        .R(1'b0));
  MUXF7 \Using_Fast.Using_LUTRAM.intr_addr_i_reg[6]_i_1 
       (.I0(\Using_Fast.Using_LUTRAM.intr_addr_i[6]_i_2_n_0 ),
        .I1(\Using_Fast.Using_LUTRAM.intr_addr_i[6]_i_3_n_0 ),
        .O(\civar[31]_8 [6]),
        .S(\Using_Fast.civr_reg_n_0_[4] ));
  FDRE \Using_Fast.Using_LUTRAM.intr_addr_i_reg[7] 
       (.C(Clk),
        .CE(1'b1),
        .D(\civar[31]_8 [7]),
        .Q(INTC_Interrupt_Address[7]),
        .R(1'b0));
  MUXF7 \Using_Fast.Using_LUTRAM.intr_addr_i_reg[7]_i_1 
       (.I0(\Using_Fast.Using_LUTRAM.intr_addr_i[7]_i_2_n_0 ),
        .I1(\Using_Fast.Using_LUTRAM.intr_addr_i[7]_i_3_n_0 ),
        .O(\civar[31]_8 [7]),
        .S(\Using_Fast.civr_reg_n_0_[4] ));
  FDRE \Using_Fast.Using_LUTRAM.intr_addr_i_reg[8] 
       (.C(Clk),
        .CE(1'b1),
        .D(\civar[31]_8 [8]),
        .Q(INTC_Interrupt_Address[8]),
        .R(1'b0));
  MUXF7 \Using_Fast.Using_LUTRAM.intr_addr_i_reg[8]_i_1 
       (.I0(\Using_Fast.Using_LUTRAM.intr_addr_i[8]_i_2_n_0 ),
        .I1(\Using_Fast.Using_LUTRAM.intr_addr_i[8]_i_3_n_0 ),
        .O(\civar[31]_8 [8]),
        .S(\Using_Fast.civr_reg_n_0_[4] ));
  FDRE \Using_Fast.Using_LUTRAM.intr_addr_i_reg[9] 
       (.C(Clk),
        .CE(1'b1),
        .D(\civar[31]_8 [9]),
        .Q(INTC_Interrupt_Address[9]),
        .R(1'b0));
  MUXF7 \Using_Fast.Using_LUTRAM.intr_addr_i_reg[9]_i_1 
       (.I0(\Using_Fast.Using_LUTRAM.intr_addr_i[9]_i_2_n_0 ),
        .I1(\Using_Fast.Using_LUTRAM.intr_addr_i[9]_i_3_n_0 ),
        .O(\civar[31]_8 [9]),
        .S(\Using_Fast.civr_reg_n_0_[4] ));
  LUT5 #(
    .INIT(32'hFEEE1000)) 
    \Using_Fast.civr[0]_i_1 
       (.I0(\Using_Fast.fast_state_reg_n_0_[0] ),
        .I1(\Using_Fast.fast_state_reg_n_0_[1] ),
        .I2(cier[1]),
        .I3(cisr[1]),
        .I4(\Using_Fast.civr_reg_n_0_[0] ),
        .O(\Using_Fast.civr[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFF0700000007)) 
    \Using_Fast.civr[1]_i_1 
       (.I0(cier[1]),
        .I1(cisr[1]),
        .I2(byte_zeros__1),
        .I3(\Using_Fast.fast_state_reg_n_0_[0] ),
        .I4(\Using_Fast.fast_state_reg_n_0_[1] ),
        .I5(\Using_Fast.civr_reg_n_0_[1] ),
        .O(\Using_Fast.civr[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFF8000000080)) 
    \Using_Fast.civr[4]_i_1 
       (.I0(cier[16]),
        .I1(cisr[16]),
        .I2(byte_zeros__1),
        .I3(\Using_Fast.fast_state_reg_n_0_[0] ),
        .I4(\Using_Fast.fast_state_reg_n_0_[1] ),
        .I5(\Using_Fast.civr_reg_n_0_[4] ),
        .O(\Using_Fast.civr[4]_i_1_n_0 ));
  FDRE \Using_Fast.civr_reg[0] 
       (.C(Clk),
        .CE(1'b1),
        .D(\Using_Fast.civr[0]_i_1_n_0 ),
        .Q(\Using_Fast.civr_reg_n_0_[0] ),
        .R(Rst));
  FDRE \Using_Fast.civr_reg[1] 
       (.C(Clk),
        .CE(1'b1),
        .D(\Using_Fast.civr[1]_i_1_n_0 ),
        .Q(\Using_Fast.civr_reg_n_0_[1] ),
        .R(Rst));
  FDRE \Using_Fast.civr_reg[4] 
       (.C(Clk),
        .CE(1'b1),
        .D(\Using_Fast.civr[4]_i_1_n_0 ),
        .Q(\Using_Fast.civr_reg_n_0_[4] ),
        .R(Rst));
  LUT6 #(
    .INIT(64'h2020040000000000)) 
    \Using_Fast.do_fast_ack_i_1 
       (.I0(INTC_Processor_Ack[1]),
        .I1(\Using_Fast.fast_state_reg_n_0_[0] ),
        .I2(\Using_Fast.fast_state_reg_n_0_[1] ),
        .I3(INTC_Processor_Ack[0]),
        .I4(\Using_Fast.civr_reg_n_0_[4] ),
        .I5(has_fast__5),
        .O(\Using_Fast.do_fast_ack_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h000A000A0CF00C00)) 
    \Using_Fast.do_fast_ack_i_2 
       (.I0(cimr[16]),
        .I1(cimr[1]),
        .I2(\Using_Fast.civr_reg_n_0_[1] ),
        .I3(\Using_Fast.civr_reg_n_0_[0] ),
        .I4(cimr[2]),
        .I5(\Using_Fast.civr_reg_n_0_[4] ),
        .O(has_fast__5));
  FDRE \Using_Fast.do_fast_ack_reg 
       (.C(Clk),
        .CE(1'b1),
        .D(\Using_Fast.do_fast_ack_i_1_n_0 ),
        .Q(do_fast_ack),
        .R(Rst));
  LUT6 #(
    .INIT(64'h0F0FFDFD00000DFD)) 
    \Using_Fast.fast_state[0]_i_1 
       (.I0(byte_zeros__1),
        .I1(D35_out),
        .I2(\Using_Fast.fast_state_reg_n_0_[0] ),
        .I3(INTC_Processor_Ack[0]),
        .I4(\Using_Fast.fast_state_reg_n_0_[1] ),
        .I5(INTC_Processor_Ack[1]),
        .O(\Using_Fast.fast_state[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'h0777)) 
    \Using_Fast.fast_state[0]_i_2 
       (.I0(cier[1]),
        .I1(cisr[1]),
        .I2(cier[2]),
        .I3(cisr[2]),
        .O(byte_zeros__1));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'h5058)) 
    \Using_Fast.fast_state[1]_i_1 
       (.I0(\Using_Fast.fast_state_reg_n_0_[0] ),
        .I1(INTC_Processor_Ack[0]),
        .I2(\Using_Fast.fast_state_reg_n_0_[1] ),
        .I3(INTC_Processor_Ack[1]),
        .O(\Using_Fast.fast_state[1]_i_1_n_0 ));
  FDRE \Using_Fast.fast_state_reg[0] 
       (.C(Clk),
        .CE(1'b1),
        .D(\Using_Fast.fast_state[0]_i_1_n_0 ),
        .Q(\Using_Fast.fast_state_reg_n_0_[0] ),
        .R(Rst));
  FDRE \Using_Fast.fast_state_reg[1] 
       (.C(Clk),
        .CE(1'b1),
        .D(\Using_Fast.fast_state[1]_i_1_n_0 ),
        .Q(\Using_Fast.fast_state_reg_n_0_[1] ),
        .R(Rst));
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \cipr_rd_dff_all[16].fdr_i 
       (.C(Clk),
        .CE(1'b1),
        .D(D35_out),
        .Q(INTC_CIPR[16]),
        .R(R));
  LUT2 #(
    .INIT(4'h8)) 
    \cipr_rd_dff_all[16].fdr_i_i_1 
       (.I0(cisr[16]),
        .I1(cier[16]),
        .O(D35_out));
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \cipr_rd_dff_all[1].fdr_i 
       (.C(Clk),
        .CE(1'b1),
        .D(D),
        .Q(INTC_CIPR[1]),
        .R(R));
  LUT6 #(
    .INIT(64'hEFFFFFFFFFFFFFFF)) 
    \cipr_rd_dff_all[1].fdr_i_i_1 
       (.I0(Q[4]),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(Q[3]),
        .I4(Q[2]),
        .I5(lmb_reg_read),
        .O(R));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \cipr_rd_dff_all[1].fdr_i_i_2 
       (.I0(cisr[1]),
        .I1(cier[1]),
        .O(D));
  (* XILINX_LEGACY_PRIM = "FDR" *) 
  (* box_type = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0)) 
    \cipr_rd_dff_all[2].fdr_i 
       (.C(Clk),
        .CE(1'b1),
        .D(D25_out),
        .Q(INTC_CIPR[2]),
        .R(R));
  LUT2 #(
    .INIT(4'h8)) 
    \cipr_rd_dff_all[2].fdr_i_i_1 
       (.I0(cisr[2]),
        .I1(cier[2]),
        .O(D25_out));
endmodule

(* C_AVOID_PRIMITIVES = "0" *) (* C_BASEADDR = "64'b0000000000000000000000000000000010000000000000000000000000000000" *) (* C_FAMILY = "kintex7" *) 
(* C_FIT1_INTERRUPT = "0" *) (* C_FIT1_No_CLOCKS = "6216" *) (* C_FIT2_INTERRUPT = "0" *) 
(* C_FIT2_No_CLOCKS = "6216" *) (* C_FIT3_INTERRUPT = "0" *) (* C_FIT3_No_CLOCKS = "6216" *) 
(* C_FIT4_INTERRUPT = "0" *) (* C_FIT4_No_CLOCKS = "6216" *) (* C_FREQ = "100000000" *) 
(* C_GPI1_INTERRUPT = "0" *) (* C_GPI1_SIZE = "32" *) (* C_GPI2_INTERRUPT = "0" *) 
(* C_GPI2_SIZE = "32" *) (* C_GPI3_INTERRUPT = "0" *) (* C_GPI3_SIZE = "32" *) 
(* C_GPI4_INTERRUPT = "0" *) (* C_GPI4_SIZE = "32" *) (* C_GPO1_INIT = "0" *) 
(* C_GPO1_SIZE = "32" *) (* C_GPO2_INIT = "0" *) (* C_GPO2_SIZE = "32" *) 
(* C_GPO3_INIT = "0" *) (* C_GPO3_SIZE = "32" *) (* C_GPO4_INIT = "0" *) 
(* C_GPO4_SIZE = "32" *) (* C_HIGHADDR = "64'b0000000000000000000000000000000010000000000000001111111111111111" *) (* C_INSTANCE = "iomodule" *) 
(* C_INTC_ADDR_WIDTH = "17" *) (* C_INTC_ASYNC_INTR = "16'b1111111111111111" *) (* C_INTC_BASE_VECTORS = "0" *) 
(* C_INTC_HAS_FAST = "1" *) (* C_INTC_INTR_SIZE = "1" *) (* C_INTC_LEVEL_EDGE = "16'b0000000000000000" *) 
(* C_INTC_NUM_SYNC_FF = "2" *) (* C_INTC_POSITIVE = "16'b1111111111111111" *) (* C_INTC_USE_EXT_INTR = "1" *) 
(* C_IO_BASEADDR = "64'b0000000000000000000000000000000011000000000000000000000000000000" *) (* C_IO_HIGHADDR = "64'b0000000000000000000000000000000011111111111111111111111111111111" *) (* C_IO_MASK = "64'b0000000000000000000000000000000011000000000000000000000000000000" *) 
(* C_LMB_AWIDTH = "32" *) (* C_LMB_DWIDTH = "32" *) (* C_MASK = "64'b0000000000000000000000000000000011000000000000000000000000000000" *) 
(* C_PIT1_INTERRUPT = "0" *) (* C_PIT1_PRESCALER = "0" *) (* C_PIT1_READABLE = "1" *) 
(* C_PIT1_SIZE = "32" *) (* C_PIT2_INTERRUPT = "0" *) (* C_PIT2_PRESCALER = "0" *) 
(* C_PIT2_READABLE = "1" *) (* C_PIT2_SIZE = "32" *) (* C_PIT3_INTERRUPT = "0" *) 
(* C_PIT3_PRESCALER = "0" *) (* C_PIT3_READABLE = "1" *) (* C_PIT3_SIZE = "32" *) 
(* C_PIT4_INTERRUPT = "0" *) (* C_PIT4_PRESCALER = "0" *) (* C_PIT4_READABLE = "1" *) 
(* C_PIT4_SIZE = "32" *) (* C_UART_BAUDRATE = "115200" *) (* C_UART_DATA_BITS = "8" *) 
(* C_UART_ERROR_INTERRUPT = "0" *) (* C_UART_ODD_PARITY = "0" *) (* C_UART_PROG_BAUDRATE = "0" *) 
(* C_UART_RX_INTERRUPT = "1" *) (* C_UART_TX_INTERRUPT = "1" *) (* C_UART_USE_PARITY = "0" *) 
(* C_USE_CONFIG_RESET = "0" *) (* C_USE_FIT1 = "1" *) (* C_USE_FIT2 = "0" *) 
(* C_USE_FIT3 = "0" *) (* C_USE_FIT4 = "0" *) (* C_USE_GPI1 = "0" *) 
(* C_USE_GPI2 = "0" *) (* C_USE_GPI3 = "0" *) (* C_USE_GPI4 = "0" *) 
(* C_USE_GPO1 = "0" *) (* C_USE_GPO2 = "0" *) (* C_USE_GPO3 = "0" *) 
(* C_USE_GPO4 = "0" *) (* C_USE_IO_BUS = "1" *) (* C_USE_PIT1 = "0" *) 
(* C_USE_PIT2 = "0" *) (* C_USE_PIT3 = "0" *) (* C_USE_PIT4 = "0" *) 
(* C_USE_UART_RX = "1" *) (* C_USE_UART_TX = "1" *) (* ORIG_REF_NAME = "iomodule" *) 
module bd_fc5c_iomodule_0_0_iomodule
   (Clk,
    Rst,
    Config_Reset,
    IO_Addr_Strobe,
    IO_Read_Strobe,
    IO_Write_Strobe,
    IO_Address,
    IO_Byte_Enable,
    IO_Write_Data,
    IO_Read_Data,
    IO_Ready,
    UART_Rx,
    UART_Tx,
    UART_Interrupt,
    FIT1_Interrupt,
    FIT1_Toggle,
    FIT2_Interrupt,
    FIT2_Toggle,
    FIT3_Interrupt,
    FIT3_Toggle,
    FIT4_Interrupt,
    FIT4_Toggle,
    PIT1_Enable,
    PIT1_Interrupt,
    PIT1_Toggle,
    PIT2_Enable,
    PIT2_Interrupt,
    PIT2_Toggle,
    PIT3_Enable,
    PIT3_Interrupt,
    PIT3_Toggle,
    PIT4_Enable,
    PIT4_Interrupt,
    PIT4_Toggle,
    GPO1,
    GPO2,
    GPO3,
    GPO4,
    GPI1,
    GPI1_Interrupt,
    GPI2,
    GPI2_Interrupt,
    GPI3,
    GPI3_Interrupt,
    GPI4,
    GPI4_Interrupt,
    INTC_Interrupt,
    INTC_IRQ,
    INTC_Processor_Ack,
    INTC_Interrupt_Address,
    INTC_IRQ_OUT,
    LMB_ABus,
    LMB_WriteDBus,
    LMB_AddrStrobe,
    LMB_ReadStrobe,
    LMB_WriteStrobe,
    LMB_BE,
    Sl_DBus,
    Sl_Ready,
    Sl_Wait,
    Sl_UE,
    Sl_CE);
  input Clk;
  input Rst;
  input Config_Reset;
  output IO_Addr_Strobe;
  output IO_Read_Strobe;
  output IO_Write_Strobe;
  output [31:0]IO_Address;
  output [3:0]IO_Byte_Enable;
  output [31:0]IO_Write_Data;
  input [31:0]IO_Read_Data;
  input IO_Ready;
  input UART_Rx;
  output UART_Tx;
  output UART_Interrupt;
  output FIT1_Interrupt;
  output FIT1_Toggle;
  output FIT2_Interrupt;
  output FIT2_Toggle;
  output FIT3_Interrupt;
  output FIT3_Toggle;
  output FIT4_Interrupt;
  output FIT4_Toggle;
  input PIT1_Enable;
  output PIT1_Interrupt;
  output PIT1_Toggle;
  input PIT2_Enable;
  output PIT2_Interrupt;
  output PIT2_Toggle;
  input PIT3_Enable;
  output PIT3_Interrupt;
  output PIT3_Toggle;
  input PIT4_Enable;
  output PIT4_Interrupt;
  output PIT4_Toggle;
  output [31:0]GPO1;
  output [31:0]GPO2;
  output [31:0]GPO3;
  output [31:0]GPO4;
  input [31:0]GPI1;
  output GPI1_Interrupt;
  input [31:0]GPI2;
  output GPI2_Interrupt;
  input [31:0]GPI3;
  output GPI3_Interrupt;
  input [31:0]GPI4;
  output GPI4_Interrupt;
  input [0:0]INTC_Interrupt;
  output INTC_IRQ;
  input [1:0]INTC_Processor_Ack;
  output [31:0]INTC_Interrupt_Address;
  output INTC_IRQ_OUT;
  input [0:31]LMB_ABus;
  input [0:31]LMB_WriteDBus;
  input LMB_AddrStrobe;
  input LMB_ReadStrobe;
  input LMB_WriteStrobe;
  input [0:3]LMB_BE;
  output [0:31]Sl_DBus;
  output Sl_Ready;
  output Sl_Wait;
  output Sl_UE;
  output Sl_CE;

  wire \<const0> ;
  wire Clk;
  wire FIT1_Interrupt;
  wire FIT1_Toggle;
  wire INTC_IRQ;
  wire [0:0]INTC_Interrupt;
  wire [16:2]\^INTC_Interrupt_Address ;
  wire [1:0]INTC_Processor_Ack;
  wire IO_Addr_Strobe;
  wire [31:0]IO_Address;
  wire [3:0]IO_Byte_Enable;
  wire [31:0]IO_Read_Data;
  wire IO_Read_Strobe;
  wire IO_Read_Strobe__0;
  wire IO_Ready;
  wire [31:0]IO_Write_Data;
  wire IO_Write_Strobe;
  wire IO_Write_Strobe__0;
  wire [0:31]LMB_ABus;
  wire LMB_AddrStrobe;
  wire [0:3]LMB_BE;
  wire LMB_ReadStrobe;
  wire [0:31]LMB_WriteDBus;
  wire LMB_WriteStrobe;
  wire Rst;
  wire [0:31]Sl_DBus;
  wire Sl_Ready;
  wire Sl_Wait;
  wire UART_Interrupt;
  wire UART_Rx;
  wire UART_Tx;
  wire \Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ;
  wire \Using_IO_Bus.io_read_keep_i_1_n_0 ;
  wire \Using_IO_Bus.io_read_keep_reg_n_0 ;
  wire \Using_IO_Bus.lmb_io_select_keep_i_1_n_0 ;
  wire [16:0]io_bus_read_data;
  wire io_ready_Q;
  wire \lmb_abus_Q_reg_n_0_[1] ;
  wire \lmb_abus_Q_reg_n_0_[2] ;
  wire \lmb_abus_Q_reg_n_0_[3] ;
  wire \lmb_abus_Q_reg_n_0_[4] ;
  wire \lmb_abus_Q_reg_n_0_[5] ;
  wire lmb_io_select_keep;
  wire lmb_reg_read;
  wire lmb_reg_read0;
  wire lmb_reg_read_Q;
  wire lmb_reg_write;
  wire lmb_reg_write0;
  wire p_0_in18_in;
  wire p_20_out;
  wire p_21_out;
  (* RTL_KEEP = "soft" *) wire uart_tx_write;
  wire uart_tx_write_inferred_i_2_n_0;
  (* RTL_KEEP = "soft" *) wire [31:0]write_data;

  assign FIT2_Interrupt = \<const0> ;
  assign FIT2_Toggle = \<const0> ;
  assign FIT3_Interrupt = \<const0> ;
  assign FIT3_Toggle = \<const0> ;
  assign FIT4_Interrupt = \<const0> ;
  assign FIT4_Toggle = \<const0> ;
  assign GPI1_Interrupt = \<const0> ;
  assign GPI2_Interrupt = \<const0> ;
  assign GPI3_Interrupt = \<const0> ;
  assign GPI4_Interrupt = \<const0> ;
  assign GPO1[31] = \<const0> ;
  assign GPO1[30] = \<const0> ;
  assign GPO1[29] = \<const0> ;
  assign GPO1[28] = \<const0> ;
  assign GPO1[27] = \<const0> ;
  assign GPO1[26] = \<const0> ;
  assign GPO1[25] = \<const0> ;
  assign GPO1[24] = \<const0> ;
  assign GPO1[23] = \<const0> ;
  assign GPO1[22] = \<const0> ;
  assign GPO1[21] = \<const0> ;
  assign GPO1[20] = \<const0> ;
  assign GPO1[19] = \<const0> ;
  assign GPO1[18] = \<const0> ;
  assign GPO1[17] = \<const0> ;
  assign GPO1[16] = \<const0> ;
  assign GPO1[15] = \<const0> ;
  assign GPO1[14] = \<const0> ;
  assign GPO1[13] = \<const0> ;
  assign GPO1[12] = \<const0> ;
  assign GPO1[11] = \<const0> ;
  assign GPO1[10] = \<const0> ;
  assign GPO1[9] = \<const0> ;
  assign GPO1[8] = \<const0> ;
  assign GPO1[7] = \<const0> ;
  assign GPO1[6] = \<const0> ;
  assign GPO1[5] = \<const0> ;
  assign GPO1[4] = \<const0> ;
  assign GPO1[3] = \<const0> ;
  assign GPO1[2] = \<const0> ;
  assign GPO1[1] = \<const0> ;
  assign GPO1[0] = \<const0> ;
  assign GPO2[31] = \<const0> ;
  assign GPO2[30] = \<const0> ;
  assign GPO2[29] = \<const0> ;
  assign GPO2[28] = \<const0> ;
  assign GPO2[27] = \<const0> ;
  assign GPO2[26] = \<const0> ;
  assign GPO2[25] = \<const0> ;
  assign GPO2[24] = \<const0> ;
  assign GPO2[23] = \<const0> ;
  assign GPO2[22] = \<const0> ;
  assign GPO2[21] = \<const0> ;
  assign GPO2[20] = \<const0> ;
  assign GPO2[19] = \<const0> ;
  assign GPO2[18] = \<const0> ;
  assign GPO2[17] = \<const0> ;
  assign GPO2[16] = \<const0> ;
  assign GPO2[15] = \<const0> ;
  assign GPO2[14] = \<const0> ;
  assign GPO2[13] = \<const0> ;
  assign GPO2[12] = \<const0> ;
  assign GPO2[11] = \<const0> ;
  assign GPO2[10] = \<const0> ;
  assign GPO2[9] = \<const0> ;
  assign GPO2[8] = \<const0> ;
  assign GPO2[7] = \<const0> ;
  assign GPO2[6] = \<const0> ;
  assign GPO2[5] = \<const0> ;
  assign GPO2[4] = \<const0> ;
  assign GPO2[3] = \<const0> ;
  assign GPO2[2] = \<const0> ;
  assign GPO2[1] = \<const0> ;
  assign GPO2[0] = \<const0> ;
  assign GPO3[31] = \<const0> ;
  assign GPO3[30] = \<const0> ;
  assign GPO3[29] = \<const0> ;
  assign GPO3[28] = \<const0> ;
  assign GPO3[27] = \<const0> ;
  assign GPO3[26] = \<const0> ;
  assign GPO3[25] = \<const0> ;
  assign GPO3[24] = \<const0> ;
  assign GPO3[23] = \<const0> ;
  assign GPO3[22] = \<const0> ;
  assign GPO3[21] = \<const0> ;
  assign GPO3[20] = \<const0> ;
  assign GPO3[19] = \<const0> ;
  assign GPO3[18] = \<const0> ;
  assign GPO3[17] = \<const0> ;
  assign GPO3[16] = \<const0> ;
  assign GPO3[15] = \<const0> ;
  assign GPO3[14] = \<const0> ;
  assign GPO3[13] = \<const0> ;
  assign GPO3[12] = \<const0> ;
  assign GPO3[11] = \<const0> ;
  assign GPO3[10] = \<const0> ;
  assign GPO3[9] = \<const0> ;
  assign GPO3[8] = \<const0> ;
  assign GPO3[7] = \<const0> ;
  assign GPO3[6] = \<const0> ;
  assign GPO3[5] = \<const0> ;
  assign GPO3[4] = \<const0> ;
  assign GPO3[3] = \<const0> ;
  assign GPO3[2] = \<const0> ;
  assign GPO3[1] = \<const0> ;
  assign GPO3[0] = \<const0> ;
  assign GPO4[31] = \<const0> ;
  assign GPO4[30] = \<const0> ;
  assign GPO4[29] = \<const0> ;
  assign GPO4[28] = \<const0> ;
  assign GPO4[27] = \<const0> ;
  assign GPO4[26] = \<const0> ;
  assign GPO4[25] = \<const0> ;
  assign GPO4[24] = \<const0> ;
  assign GPO4[23] = \<const0> ;
  assign GPO4[22] = \<const0> ;
  assign GPO4[21] = \<const0> ;
  assign GPO4[20] = \<const0> ;
  assign GPO4[19] = \<const0> ;
  assign GPO4[18] = \<const0> ;
  assign GPO4[17] = \<const0> ;
  assign GPO4[16] = \<const0> ;
  assign GPO4[15] = \<const0> ;
  assign GPO4[14] = \<const0> ;
  assign GPO4[13] = \<const0> ;
  assign GPO4[12] = \<const0> ;
  assign GPO4[11] = \<const0> ;
  assign GPO4[10] = \<const0> ;
  assign GPO4[9] = \<const0> ;
  assign GPO4[8] = \<const0> ;
  assign GPO4[7] = \<const0> ;
  assign GPO4[6] = \<const0> ;
  assign GPO4[5] = \<const0> ;
  assign GPO4[4] = \<const0> ;
  assign GPO4[3] = \<const0> ;
  assign GPO4[2] = \<const0> ;
  assign GPO4[1] = \<const0> ;
  assign GPO4[0] = \<const0> ;
  assign INTC_IRQ_OUT = INTC_IRQ;
  assign INTC_Interrupt_Address[31] = \<const0> ;
  assign INTC_Interrupt_Address[30] = \<const0> ;
  assign INTC_Interrupt_Address[29] = \<const0> ;
  assign INTC_Interrupt_Address[28] = \<const0> ;
  assign INTC_Interrupt_Address[27] = \<const0> ;
  assign INTC_Interrupt_Address[26] = \<const0> ;
  assign INTC_Interrupt_Address[25] = \<const0> ;
  assign INTC_Interrupt_Address[24] = \<const0> ;
  assign INTC_Interrupt_Address[23] = \<const0> ;
  assign INTC_Interrupt_Address[22] = \<const0> ;
  assign INTC_Interrupt_Address[21] = \<const0> ;
  assign INTC_Interrupt_Address[20] = \<const0> ;
  assign INTC_Interrupt_Address[19] = \<const0> ;
  assign INTC_Interrupt_Address[18] = \<const0> ;
  assign INTC_Interrupt_Address[17] = \<const0> ;
  assign INTC_Interrupt_Address[16:2] = \^INTC_Interrupt_Address [16:2];
  assign INTC_Interrupt_Address[1] = \<const0> ;
  assign INTC_Interrupt_Address[0] = \<const0> ;
  assign PIT1_Interrupt = \<const0> ;
  assign PIT1_Toggle = \<const0> ;
  assign PIT2_Interrupt = \<const0> ;
  assign PIT2_Toggle = \<const0> ;
  assign PIT3_Interrupt = \<const0> ;
  assign PIT3_Toggle = \<const0> ;
  assign PIT4_Interrupt = \<const0> ;
  assign PIT4_Toggle = \<const0> ;
  assign Sl_CE = \<const0> ;
  assign Sl_UE = \<const0> ;
  GND GND
       (.G(\<const0> ));
  bd_fc5c_iomodule_0_0_Iomodule_core IOModule_Core_I1
       (.Clk(Clk),
        .E(uart_tx_write),
        .FIT1_Interrupt(FIT1_Interrupt),
        .FIT1_Toggle(FIT1_Toggle),
        .INTC_IRQ(INTC_IRQ),
        .INTC_Interrupt(INTC_Interrupt),
        .INTC_Interrupt_Address(\^INTC_Interrupt_Address ),
        .INTC_Processor_Ack(INTC_Processor_Ack),
        .Q({p_0_in18_in,\lmb_abus_Q_reg_n_0_[1] ,\lmb_abus_Q_reg_n_0_[2] ,\lmb_abus_Q_reg_n_0_[3] ,\lmb_abus_Q_reg_n_0_[4] ,\lmb_abus_Q_reg_n_0_[5] }),
        .Rst(Rst),
        .Sl_DBus({Sl_DBus[15],Sl_DBus[24],Sl_DBus[25],Sl_DBus[26],Sl_DBus[27],Sl_DBus[28],Sl_DBus[29],Sl_DBus[30],Sl_DBus[31]}),
        .UART_Interrupt(UART_Interrupt),
        .UART_Rx(UART_Rx),
        .UART_Tx(UART_Tx),
        .io_bus_read_data({io_bus_read_data[16],io_bus_read_data[7:0]}),
        .lmb_reg_read(lmb_reg_read),
        .lmb_reg_write(lmb_reg_write),
        .out(write_data[16:0]));
  LUT3 #(
    .INIT(8'hFE)) 
    Sl_Ready_INST_0
       (.I0(lmb_reg_read_Q),
        .I1(lmb_reg_write),
        .I2(io_ready_Q),
        .O(Sl_Ready));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'hE)) 
    Sl_Wait_INST_0
       (.I0(lmb_io_select_keep),
        .I1(lmb_reg_read),
        .O(Sl_Wait));
  LUT3 #(
    .INIT(8'h80)) 
    \Using_IO_Bus.IO_Addr_Strobe_i_1 
       (.I0(LMB_AddrStrobe),
        .I1(LMB_ABus[0]),
        .I2(LMB_ABus[1]),
        .O(p_21_out));
  FDRE \Using_IO_Bus.IO_Addr_Strobe_reg 
       (.C(Clk),
        .CE(1'b1),
        .D(p_21_out),
        .Q(IO_Addr_Strobe),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[0] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[31]),
        .Q(IO_Address[0]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[10] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[21]),
        .Q(IO_Address[10]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[11] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[20]),
        .Q(IO_Address[11]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[12] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[19]),
        .Q(IO_Address[12]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[13] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[18]),
        .Q(IO_Address[13]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[14] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[17]),
        .Q(IO_Address[14]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[15] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[16]),
        .Q(IO_Address[15]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[16] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[15]),
        .Q(IO_Address[16]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[17] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[14]),
        .Q(IO_Address[17]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[18] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[13]),
        .Q(IO_Address[18]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[19] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[12]),
        .Q(IO_Address[19]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[1] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[30]),
        .Q(IO_Address[1]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[20] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[11]),
        .Q(IO_Address[20]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[21] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[10]),
        .Q(IO_Address[21]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[22] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[9]),
        .Q(IO_Address[22]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[23] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[8]),
        .Q(IO_Address[23]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[24] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[7]),
        .Q(IO_Address[24]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[25] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[6]),
        .Q(IO_Address[25]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[26] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[5]),
        .Q(IO_Address[26]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[27] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[4]),
        .Q(IO_Address[27]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[28] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[3]),
        .Q(IO_Address[28]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[29] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[2]),
        .Q(IO_Address[29]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[2] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[29]),
        .Q(IO_Address[2]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[30] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[1]),
        .Q(IO_Address[30]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[31] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[0]),
        .Q(IO_Address[31]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[3] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[28]),
        .Q(IO_Address[3]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[4] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[27]),
        .Q(IO_Address[4]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[5] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[26]),
        .Q(IO_Address[5]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[6] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[25]),
        .Q(IO_Address[6]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[7] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[24]),
        .Q(IO_Address[7]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[8] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[23]),
        .Q(IO_Address[8]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Address_reg[9] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_ABus[22]),
        .Q(IO_Address[9]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Byte_Enable_reg[0] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_BE[3]),
        .Q(IO_Byte_Enable[0]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Byte_Enable_reg[1] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_BE[2]),
        .Q(IO_Byte_Enable[1]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Byte_Enable_reg[2] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_BE[1]),
        .Q(IO_Byte_Enable[2]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Byte_Enable_reg[3] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_BE[0]),
        .Q(IO_Byte_Enable[3]),
        .R(Rst));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \Using_IO_Bus.IO_Read_Strobe_i_1 
       (.I0(LMB_ReadStrobe),
        .I1(LMB_ABus[1]),
        .I2(LMB_ABus[0]),
        .I3(LMB_AddrStrobe),
        .O(IO_Read_Strobe__0));
  FDRE \Using_IO_Bus.IO_Read_Strobe_reg 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Strobe__0),
        .Q(IO_Read_Strobe),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[0] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[31]),
        .Q(IO_Write_Data[0]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[10] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[21]),
        .Q(IO_Write_Data[10]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[11] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[20]),
        .Q(IO_Write_Data[11]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[12] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[19]),
        .Q(IO_Write_Data[12]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[13] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[18]),
        .Q(IO_Write_Data[13]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[14] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[17]),
        .Q(IO_Write_Data[14]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[15] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[16]),
        .Q(IO_Write_Data[15]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[16] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[15]),
        .Q(IO_Write_Data[16]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[17] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[14]),
        .Q(IO_Write_Data[17]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[18] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[13]),
        .Q(IO_Write_Data[18]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[19] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[12]),
        .Q(IO_Write_Data[19]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[1] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[30]),
        .Q(IO_Write_Data[1]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[20] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[11]),
        .Q(IO_Write_Data[20]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[21] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[10]),
        .Q(IO_Write_Data[21]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[22] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[9]),
        .Q(IO_Write_Data[22]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[23] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[8]),
        .Q(IO_Write_Data[23]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[24] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[7]),
        .Q(IO_Write_Data[24]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[25] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[6]),
        .Q(IO_Write_Data[25]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[26] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[5]),
        .Q(IO_Write_Data[26]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[27] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[4]),
        .Q(IO_Write_Data[27]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[28] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[3]),
        .Q(IO_Write_Data[28]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[29] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[2]),
        .Q(IO_Write_Data[29]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[2] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[29]),
        .Q(IO_Write_Data[2]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[30] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[1]),
        .Q(IO_Write_Data[30]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[31] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[0]),
        .Q(IO_Write_Data[31]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[3] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[28]),
        .Q(IO_Write_Data[3]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[4] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[27]),
        .Q(IO_Write_Data[4]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[5] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[26]),
        .Q(IO_Write_Data[5]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[6] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[25]),
        .Q(IO_Write_Data[6]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[7] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[24]),
        .Q(IO_Write_Data[7]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[8] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[23]),
        .Q(IO_Write_Data[8]),
        .R(Rst));
  FDRE \Using_IO_Bus.IO_Write_Data_reg[9] 
       (.C(Clk),
        .CE(p_21_out),
        .D(LMB_WriteDBus[22]),
        .Q(IO_Write_Data[9]),
        .R(Rst));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \Using_IO_Bus.IO_Write_Strobe_i_1 
       (.I0(LMB_WriteStrobe),
        .I1(LMB_ABus[1]),
        .I2(LMB_ABus[0]),
        .I3(LMB_AddrStrobe),
        .O(IO_Write_Strobe__0));
  FDRE \Using_IO_Bus.IO_Write_Strobe_reg 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Write_Strobe__0),
        .Q(IO_Write_Strobe),
        .R(Rst));
  LUT2 #(
    .INIT(4'h7)) 
    \Using_IO_Bus.io_bus_read_data[31]_i_1 
       (.I0(IO_Ready),
        .I1(\Using_IO_Bus.io_read_keep_reg_n_0 ),
        .O(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[0] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[0]),
        .Q(io_bus_read_data[0]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[10] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[10]),
        .Q(Sl_DBus[21]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[11] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[11]),
        .Q(Sl_DBus[20]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[12] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[12]),
        .Q(Sl_DBus[19]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[13] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[13]),
        .Q(Sl_DBus[18]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[14] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[14]),
        .Q(Sl_DBus[17]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[15] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[15]),
        .Q(Sl_DBus[16]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[16] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[16]),
        .Q(io_bus_read_data[16]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[17] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[17]),
        .Q(Sl_DBus[14]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[18] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[18]),
        .Q(Sl_DBus[13]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[19] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[19]),
        .Q(Sl_DBus[12]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[1] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[1]),
        .Q(io_bus_read_data[1]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[20] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[20]),
        .Q(Sl_DBus[11]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[21] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[21]),
        .Q(Sl_DBus[10]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[22] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[22]),
        .Q(Sl_DBus[9]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[23] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[23]),
        .Q(Sl_DBus[8]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[24] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[24]),
        .Q(Sl_DBus[7]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[25] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[25]),
        .Q(Sl_DBus[6]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[26] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[26]),
        .Q(Sl_DBus[5]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[27] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[27]),
        .Q(Sl_DBus[4]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[28] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[28]),
        .Q(Sl_DBus[3]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[29] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[29]),
        .Q(Sl_DBus[2]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[2] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[2]),
        .Q(io_bus_read_data[2]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[30] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[30]),
        .Q(Sl_DBus[1]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[31] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[31]),
        .Q(Sl_DBus[0]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[3] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[3]),
        .Q(io_bus_read_data[3]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[4] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[4]),
        .Q(io_bus_read_data[4]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[5] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[5]),
        .Q(io_bus_read_data[5]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[6] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[6]),
        .Q(io_bus_read_data[6]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[7] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[7]),
        .Q(io_bus_read_data[7]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[8] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[8]),
        .Q(Sl_DBus[23]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_bus_read_data_reg[9] 
       (.C(Clk),
        .CE(1'b1),
        .D(IO_Read_Data[9]),
        .Q(Sl_DBus[22]),
        .R(\Using_IO_Bus.io_bus_read_data[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hA3333333A0000000)) 
    \Using_IO_Bus.io_read_keep_i_1 
       (.I0(LMB_ReadStrobe),
        .I1(IO_Ready),
        .I2(LMB_ABus[1]),
        .I3(LMB_ABus[0]),
        .I4(LMB_AddrStrobe),
        .I5(\Using_IO_Bus.io_read_keep_reg_n_0 ),
        .O(\Using_IO_Bus.io_read_keep_i_1_n_0 ));
  FDRE \Using_IO_Bus.io_read_keep_reg 
       (.C(Clk),
        .CE(1'b1),
        .D(\Using_IO_Bus.io_read_keep_i_1_n_0 ),
        .Q(\Using_IO_Bus.io_read_keep_reg_n_0 ),
        .R(Rst));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \Using_IO_Bus.io_ready_Q_i_1 
       (.I0(IO_Ready),
        .I1(lmb_io_select_keep),
        .O(p_20_out));
  FDRE \Using_IO_Bus.io_ready_Q_reg 
       (.C(Clk),
        .CE(1'b1),
        .D(p_20_out),
        .Q(io_ready_Q),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hD555C000)) 
    \Using_IO_Bus.lmb_io_select_keep_i_1 
       (.I0(IO_Ready),
        .I1(LMB_ABus[1]),
        .I2(LMB_ABus[0]),
        .I3(LMB_AddrStrobe),
        .I4(lmb_io_select_keep),
        .O(\Using_IO_Bus.lmb_io_select_keep_i_1_n_0 ));
  FDRE \Using_IO_Bus.lmb_io_select_keep_reg 
       (.C(Clk),
        .CE(1'b1),
        .D(\Using_IO_Bus.lmb_io_select_keep_i_1_n_0 ),
        .Q(lmb_io_select_keep),
        .R(Rst));
  FDRE \lmb_abus_Q_reg[0] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_ABus[24]),
        .Q(p_0_in18_in),
        .R(1'b0));
  FDRE \lmb_abus_Q_reg[1] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_ABus[25]),
        .Q(\lmb_abus_Q_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \lmb_abus_Q_reg[2] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_ABus[26]),
        .Q(\lmb_abus_Q_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \lmb_abus_Q_reg[3] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_ABus[27]),
        .Q(\lmb_abus_Q_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \lmb_abus_Q_reg[4] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_ABus[28]),
        .Q(\lmb_abus_Q_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \lmb_abus_Q_reg[5] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_ABus[29]),
        .Q(\lmb_abus_Q_reg_n_0_[5] ),
        .R(1'b0));
  FDRE lmb_reg_read_Q_reg
       (.C(Clk),
        .CE(1'b1),
        .D(lmb_reg_read),
        .Q(lmb_reg_read_Q),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    lmb_reg_read_i_1
       (.I0(LMB_ABus[1]),
        .I1(LMB_ABus[0]),
        .I2(LMB_AddrStrobe),
        .I3(LMB_ReadStrobe),
        .O(lmb_reg_read0));
  FDRE lmb_reg_read_reg
       (.C(Clk),
        .CE(1'b1),
        .D(lmb_reg_read0),
        .Q(lmb_reg_read),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT4 #(
    .INIT(16'h4000)) 
    lmb_reg_write_i_1
       (.I0(LMB_ABus[1]),
        .I1(LMB_ABus[0]),
        .I2(LMB_AddrStrobe),
        .I3(LMB_WriteStrobe),
        .O(lmb_reg_write0));
  FDRE lmb_reg_write_reg
       (.C(Clk),
        .CE(1'b1),
        .D(lmb_reg_write0),
        .Q(lmb_reg_write),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0000000000000800)) 
    uart_tx_write_inferred_i_1
       (.I0(uart_tx_write_inferred_i_2_n_0),
        .I1(lmb_reg_write),
        .I2(p_0_in18_in),
        .I3(\lmb_abus_Q_reg_n_0_[5] ),
        .I4(\lmb_abus_Q_reg_n_0_[4] ),
        .I5(\lmb_abus_Q_reg_n_0_[1] ),
        .O(uart_tx_write));
  LUT2 #(
    .INIT(4'h1)) 
    uart_tx_write_inferred_i_2
       (.I0(\lmb_abus_Q_reg_n_0_[2] ),
        .I1(\lmb_abus_Q_reg_n_0_[3] ),
        .O(uart_tx_write_inferred_i_2_n_0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[0] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[31]),
        .Q(write_data[0]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[10] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[21]),
        .Q(write_data[10]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[11] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[20]),
        .Q(write_data[11]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[12] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[19]),
        .Q(write_data[12]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[13] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[18]),
        .Q(write_data[13]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[14] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[17]),
        .Q(write_data[14]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[15] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[16]),
        .Q(write_data[15]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[16] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[15]),
        .Q(write_data[16]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[17] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[14]),
        .Q(write_data[17]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[18] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[13]),
        .Q(write_data[18]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[19] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[12]),
        .Q(write_data[19]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[1] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[30]),
        .Q(write_data[1]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[20] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[11]),
        .Q(write_data[20]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[21] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[10]),
        .Q(write_data[21]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[22] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[9]),
        .Q(write_data[22]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[23] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[8]),
        .Q(write_data[23]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[24] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[7]),
        .Q(write_data[24]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[25] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[6]),
        .Q(write_data[25]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[26] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[5]),
        .Q(write_data[26]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[27] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[4]),
        .Q(write_data[27]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[28] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[3]),
        .Q(write_data[28]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[29] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[2]),
        .Q(write_data[29]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[2] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[29]),
        .Q(write_data[2]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[30] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[1]),
        .Q(write_data[30]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[31] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[0]),
        .Q(write_data[31]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[3] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[28]),
        .Q(write_data[3]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[4] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[27]),
        .Q(write_data[4]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[5] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[26]),
        .Q(write_data[5]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[6] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[25]),
        .Q(write_data[6]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[7] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[24]),
        .Q(write_data[7]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[8] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[23]),
        .Q(write_data[8]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  FDRE \write_data_reg[9] 
       (.C(Clk),
        .CE(1'b1),
        .D(LMB_WriteDBus[22]),
        .Q(write_data[9]),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
