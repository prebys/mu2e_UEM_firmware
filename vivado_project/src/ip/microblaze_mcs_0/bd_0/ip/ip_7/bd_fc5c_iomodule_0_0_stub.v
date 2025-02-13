// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
// Date        : Fri Mar 22 16:55:09 2024
// Host        : mu2euem.dhcp.fnal.gov running 64-bit Scientific Linux release 7.9 (Nitrogen)
// Command     : write_verilog -force -mode synth_stub
//               /root/Documents/mu2e/mu2e_UEM_firmware/mu2e_UEM_firmware.srcs/sources_1/ip/microblaze_mcs_0/bd_0/ip/ip_7/bd_fc5c_iomodule_0_0_stub.v
// Design      : bd_fc5c_iomodule_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k420tffg1156-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "iomodule,Vivado 2016.2" *)
module bd_fc5c_iomodule_0_0(Clk, Rst, IO_Addr_Strobe, IO_Read_Strobe, IO_Write_Strobe, IO_Address, IO_Byte_Enable, IO_Write_Data, IO_Read_Data, IO_Ready, UART_Rx, UART_Tx, UART_Interrupt, FIT1_Toggle, INTC_Interrupt, INTC_IRQ, INTC_Processor_Ack, INTC_Interrupt_Address, INTC_IRQ_OUT, LMB_ABus, LMB_WriteDBus, LMB_AddrStrobe, LMB_ReadStrobe, LMB_WriteStrobe, LMB_BE, Sl_DBus, Sl_Ready, Sl_Wait, Sl_UE, Sl_CE)
/* synthesis syn_black_box black_box_pad_pin="Clk,Rst,IO_Addr_Strobe,IO_Read_Strobe,IO_Write_Strobe,IO_Address[31:0],IO_Byte_Enable[3:0],IO_Write_Data[31:0],IO_Read_Data[31:0],IO_Ready,UART_Rx,UART_Tx,UART_Interrupt,FIT1_Toggle,INTC_Interrupt[0:0],INTC_IRQ,INTC_Processor_Ack[1:0],INTC_Interrupt_Address[31:0],INTC_IRQ_OUT,LMB_ABus[0:31],LMB_WriteDBus[0:31],LMB_AddrStrobe,LMB_ReadStrobe,LMB_WriteStrobe,LMB_BE[0:3],Sl_DBus[0:31],Sl_Ready,Sl_Wait,Sl_UE,Sl_CE" */;
  input Clk;
  input Rst;
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
  output FIT1_Toggle;
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
endmodule
