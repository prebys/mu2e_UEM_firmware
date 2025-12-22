#ifndef __LMK04828_H_
#define __LMK04828_H_

/* Settings with On-board sampling clock. 
 * DCLKOUT0:	250MHz FPGA SERDES reference clock
 * SDCLKOUT5:	31.25MHz ADC1 SYSREF
 * SDCLKOUT7:	31.25MHz ADC0 SYSREF
 * SDCLKOUT11:	31.25MHz FPGA JESD2040 SYSREF
 * SDCLKOUT13:	31.25MHz FPGA JESD2041 SYSREF
 * PLL2: 	2.5GHz
 */ 

const reg_with_name_t lmk04828_regs[] =
{
	{ 0x000, 3, 0x80,	0,	"[7] Reset; [4] SPI_3WIRE_DIS" },
        { 0x000, 0x80, 10,  0, "delay 10 us" },
	{ 0x002, 3, 0,		0,	"[0] POWERDOWN" },
	{ 0x003, 1, 0,		6,	"ID_DEVICE_TYPE = 6" },
	{ 0x004, 1, 0,		208,	"ID_PROD[15:8] = 208 (0xD0)" },
	{ 0x005, 1, 0,		91,	"ID_PROD[7:0] = 91" },
	{ 0x006, 1, 0,		32,	"ID_MASKREV = 32" },
	{ 0x00C, 1, 0,		81,	"ID_VNDR[15:8] = 81" },
	{ 0x00D, 1, 0,		4,	"ID_VNDR[7:0] = 4" },

	// ---------- Device Clock and SYSREF Clock Output Controls (0x100 - 0x137) --------------
	{ 0x100, 3, 0x2A,	0x2,	"[6] CLKout0_1_ODL; [5] CLKout0_1_IDL; [4:0] DCLKout0_DIV" },
	{ 0x101, 3, 0x55,	0x55,	"[7:4] DCLKout0_DDLY_CNTH; [3:0] DCLKout0_DDLY_CNTL" },
	{ 0x103, 3, 0x0,	0,	"[7:3] DCLKout0_ALDY; [2] DCLKout0_ADLY_MUX; [1:0] DCLKout0_MUX" },
	{ 0x104, 3, 0x20,	0,	"[6] DCLKout0_HS; [5] SDCLKout1_MUX; [4:1] SDCLKout1_DDLY; [0] SDCLKout1_HS" },
	{ 0x105, 3, 0x0,	0,	"[4] SDCLKout1_ADLY_EN; [3:0] SDCLKout1_ADLY" },
	{ 0x106, 3, 0xF7,	0x79,	"[7] DCLKout0_DDLY_PD; [6] DCLKout0_HSg_PD; [5] DCLKout0_ADLYg_PD; [4] DCLKout0_ADLY_PD; [3] CLKout0_1_PD; [2:1] SDCLKout_DIS_MODE [0] SDCLKout1_PD" },
	{ 0x107, 3, 0x05,	0x0,	"[7] SDCLKout1_POL; [6:4] SDCLKout1_FMT; [3] DCLKout0_POL; [2:0] DCLKout0_FMT" },

	{ 0x108, 3, 0x2A,	0x4,	"[6] CLKout2_3_ODL; [5] CLKout2_3_IDL; [4:0] DCLKout2_DIV" },
	{ 0x109, 3, 0x55,	0x55,	"[7:4] DCLKout2_DDLY_CNTH; [3:0] DCLKout2_DDLY_CNTL" },
	{ 0x10B, 3, 0x0 ,	0,	"[7:3] DCLKout2_ALDY; [2] DCLKout2_ADLY_MUX; [1:0] DCLKout2_MUX" },
	{ 0x10C, 3, 0x20,	0,	"[6] DCLKout2_HS; [5] SDCLKout3_MUX; [4:1] SDCLKout3_DDLY; [0] SDCLKout3_HS" },
	{ 0x10D, 3, 0x0 ,	0,	"[4] SDCLKout3_ADLY_EN; [3:0] SDCLKout3_ADLY" },
	{ 0x10E, 3, 0xF7,	0x79,	"[7] DCLKout2_DDLY_PD; [6] DCLKout2_HSg_PD; [5] DCLKout2_ADLYg_PD; [4] DCLKout2_ADLY_PD; [3] CLKout2_3_PD; [2:1] SDCLKout_DIS_MODE [0] SDCLKout3_PD" },
	{ 0x10F, 3, 0x05,	0x0,	"[7] SDCLKout3_POL; [6:4] SDCLKout3_FMT; [3] DCLKout2_POL; [2:0] DCLKout2_FMT" },

	{ 0x110, 3, 0x38,	0x8,	"[6] CLKout4_5_ODL; [5] CLKout4_5_IDL; [4:0] DCLKout4_DIV" },
	{ 0x111, 3, 0x55,	0x55,	"[7:4] DCLKout4_DDLY_CNTH; [3:0] DCLKout4_DDLY_CNTL" },
	{ 0x113, 3, 0x0 ,	0,	"[7:3] DCLKout4_ALDY; [2] DCLKout4_ADLY_MUX; [1:0] DCLKout4_MUX" },
	{ 0x114, 3, 0x20,	0,	"[6] DCLKout4_HS; [5] SDCLKout5_MUX; [4:1] SDCLKout5_DDLY; [0] SDCLKout5_HS" },
	{ 0x115, 3, 0x0 ,	0,	"[4] SDCLKout5_ADLY_EN; [3:0] SDCLKout5_ADLY" },
	{ 0x116, 3, 0xF2,	0x71,	"[7] DCLKout4_DDLY_PD; [6] DCLKout4_HSg_PD; [5] DCLKout4_ADLYg_PD; [4] DCLKout4_ADLY_PD; [3] CLKout4_5_PD; [2:1] SDCLKout_DIS_MODE [0] SDCLKout5_PD" },
	{ 0x117, 3, 0x10,	0x1,	"[7] SDCLKout5_POL; [6:4] SDCLKout5_FMT; [3] DCLKout4_POL; [2:0] DCLKout4_FMT" },

	{ 0x118, 3, 0x38,	0x8,	"[6] CLKout6_7_ODL; [5] CLKout6_7_IDL; [4:0] DCLKout6_DIV" },
	{ 0x119, 3, 0x55,	0x55,	"[7:4] DCLKout6_DDLY_CNTH; [3:0] DCLKout6_DDLY_CNTL" },
	{ 0x11B, 3, 0x0 ,	0,	"[7:3] DCLKout6_ALDY; [2] DCLKout6_ADLY_MUX; [1:0] DCLKout6_MUX" },
	{ 0x11C, 3, 0x20,	0,	"[6] DCLKout6_HS; [5] SDCLKout7_MUX; [4:1] SDCLKout7_DDLY; [0] SDCLKout7_HS" },
	{ 0x11D, 3, 0x0 ,	0,	"[4] SDCLKout7_ADLY_EN; [3:0] SDCLKout7_ADLY" },
	{ 0x11E, 3, 0xF2,	0x71,	"[7] DCLKout6_DDLY_PD; [6] DCLKout6_HSg_PD; [5] DCLKout6_ADLYg_PD; [4] DCLKout6_ADLY_PD; [3] CLKout6_7_PD; [2:1] SDCLKout_DIS_MODE [0] SDCLKout7_PD" },
	{ 0x11F, 3, 0x10,	0x1,	"[7] SDCLKout7_POL; [6:4] SDCLKout7_FMT; [3] DCLKout6_POL; [2:0] DCLKout6_FMT" },

	{ 0x120, 3, 0x8,	0x8,	"[6] CLKout8_9_ODL; [5] CLKout8_9_IDL; [4:0] DCLKout8_DIV" },
	{ 0x121, 3, 0x55,	0x55,	"[7:4] DCLKout8_DDLY_CNTH; [3:0] DCLKout8_DDLY_CNTL" },
	{ 0x123, 3, 0x0 ,	0,	"[7:3] DCLKout8_ALDY; [2] DCLKout8_ADLY_MUX; [1:0] DCLKout8_MUX" },
	{ 0x124, 3, 0x0 ,	0,	"[6] DCLKout8_HS; [5] SDCLKout9_MUX; [4:1] SDCLKout9_DDLY; [0] SDCLKout9_HS" },
	{ 0x125, 3, 0x0 ,	0,	"[4] SDCLKout9_ADLY_EN; [3:0] SDCLKout9_ADLY" },
	{ 0x126, 3, 0xFB,	0x71,	"[7] DCLKout8_DDLY_PD; [6] DCLKout8_HSg_PD; [5] DCLKout8_ADLYg_PD; [4] DCLKout8_ADLY_PD; [3] CLKout8_9_PD; [2:1] SDCLKout_DIS_MODE [0] SDCLKout9_PD" },
	{ 0x127, 3, 0x0,	0x1,	"[7] SDCLKout9_POL; [6:4] SDCLKout9_FMT; [3] DCLKout8_POL; [2:0] DCLKout8_FMT" },

	{ 0x128, 3, 0x2A ,	0x8,	"[6] CLKout10_11_ODL; [5] CLKout10_11_IDL; [4:0] DCLKout10_DIV" },
	{ 0x129, 3, 0x55,	0x55,	"[7:4] DCLKout10_DDLY_CNTH; [3:0] DCLKout10_DDLY_CNTL" },
	{ 0x12B, 3, 0x0 ,	0,	"[7:3] DCLKout10_ALDY; [2] DCLKout10_ADLY_MUX; [1:0] DCLKout10_MUX" },
	{ 0x12C, 3, 0x20,	0,	"[6] DCLKout10_HS; [5] SDCLKout11_MUX; [4:1] SDCLKout11_DDLY; [0] SDCLKout11_HS" },
	{ 0x12D, 3, 0x0 ,	0,	"[4] SDCLKout11_ADLY_EN; [3:0] SDCLKout11_ADLY" },
	{ 0x12E, 3, 0xF2,	0x71,	"[7] DCLKout10_DDLY_PD; [6] DCLKout10_HSg_PD; [5] DCLKout10_ADLYg_PD; [4] DCLKout10_ADLY_PD; [3] CLKout10_11_PD; [2:1] SDCLKout_DIS_MODE [0] SDCLKout11_PD" },
	{ 0x12F, 3, 0x10,	0x1,	"[7] SDCLKout11_POL; [6:4] SDCLKout11_FMT; [3] DCLKout10_POL; [2:0] DCLKout10_FMT" },

	{ 0x130, 3, 0x2A,	0x2,	"[6] CLKout12_13_ODL; [5] CLKout12_13_IDL; [4:0] DCLKout12_DIV" },
	{ 0x131, 3, 0x55,	0x55,	"[7:4] DCLKout12_DDLY_CNTH; [3:0] DCLKout12_DDLY_CNTL" },
	{ 0x133, 3, 0x0 ,	0,	"[7:3] DCLKout12_ALDY; [2] DCLKout12_ADLY_MUX; [1:0] DCLKout12_MUX" },
	{ 0x134, 3, 0x20,	0,	"[6] DCLKout12_HS; [5] SDCLKout13_MUX; [4:1] SDCLKout13_DDLY; [0] SDCLKout13_HS" },
	{ 0x135, 3, 0x0 ,	0,	"[4] SDCLKout13_ADLY_EN; [3:0] SDCLKout13_ADLY" },
	{ 0x136, 3, 0xF2,	0x79,	"[7] DCLKout12_DDLY_PD; [6] DCLKout12_HSg_PD; [5] DCLKout12_ADLYg_PD; [4] DCLKout12_ADLY_PD; [3] CLKout12_13_PD; [2:1] SDCLKout_DIS_MODE [0] SDCLKout13_PD" },
	{ 0x137, 3, 0x10,	0,	"[7] SDCLKout13_POL; [6:4] SDCLKout13_FMT; [3] DCLKout12_POL; [2:0] DCLKout12_FMT" },

	// --------------- SYSREF, SYNC and Device Config --------------
	{ 0x138, 3, 0x06,	0x04,	"[6:5] VCO_MUX; [4] OSCout_MUX; [3:0] OSCout_FMT" },
	{ 0x139, 3, 0x0,	0x0,	"[2] SYSREF_CLKin0_MUX [1:0] SYSREF_MUX" },
	{ 0x13A, 3, 0x0,	12,	"[4:0] SYSREF_DIV[12:8]" },
	{ 0x13B, 3, 0x50,	0,	"[7:0] SYSREF_DIV[7:0]" }, 	// 0x50 for 1GSPS; 0x64 for 800MSPS
	{ 0x13C, 3, 0x0,	0,	"[4:0] SYSREF_DDLY[12:8]" },
	{ 0x13D, 3, 0x8,	8,	"[7:0] SYSREF_DDLY[7:0]" },
	{ 0x13E, 3, 0x3,	3,	"[1:0] SYSREF_PULSE_CNT" },
	{ 0x13F, 3, 0x0,	0,	"[4] PLL2_NCLK_MUX; [3] PLL1_NCLK_MUX; [2:1] FB_MUX; [0] FB_MUX_EN" },
	{ 0x140, 3, 0x1,	7,	"[7] PLL1_PD; [6] VCO_LDO_PD; [5] VCO_PD; [4] OSCin_PD; [3] SYSREF_GBL_PD; [2] SYSREF_PD; [1] SYSREF_DDLY_PD; [0] SYSREF_PLSR_PD" },
	{ 0x141, 3, 0x0,	0,	"[7] DDLYd_SYSREF_EN; [6] DDLYd12_EN; [6] DDLYd10_EN; [6] DDLYd8_EN; [6] DDLYd6_EN; [6] DDLYd4_EN; [6] DDLYd2_EN; [6] DDLYd0_EN" },
	{ 0x142, 3, 0x0,	0,	"[3:0] DDLYd_STEP_CNT" },
	{ 0x143, 3, 0x11,	0x91,	"[7] SYSREF_CLR; [6] SYNC_1SHOT_EN; [5] SYNC_POL; [4] SYNC_EN; [3] SYNC_PLL2_DLD; [2] SYNC_PLL1_DLD; [1:0] SYNC_MODE" },
	{ 0x144, 3, 0x0,	0,	"[7] SYNC_DISSYSREF; [6] SYNC_DIS12; [5] SYNC_DIS10; [4] SYNC_DIS8; [3] SYNC_DIS6; [2] SYNC_DIS4; [1] SYNC_DIS2; [0] SYNC_DIS0" },
	{ 0x145, 3, 0x7F,	0,	"Fixed value = 0x7f" },

	// --------------- CLKin Control (0x146 - 0x149) ----------
	{ 0x146, 3, 0x18,	0x18,	"[5] CLKin2_EN; [4] CLKin1_EN; [3] CLKin0_EN; [2] CLKin2_TYPE; [1] CLKin1_TYPE; [0] CLKin0_TYPE" },
	{ 0x147, 3, 0x0A,	0x3A,	"[7] CLKin_SEL_POL; [6:4] CLKin_SEL_MODE; [3:2] CLKin1_OUT_MUX; [1:0] CLKin0_OUT_MUX" },
	{ 0x148, 3, 0x0B,	0x02,	"[5:3] CLKin_SEL0_MUX; [2:0] CLKin_SEL0_TYPE" },
	{ 0x149, 3, 0x0B,	0x42,	"[6] SDIO_RDBK_TYPE; [5:3] CLKin_SEL1_MUX; [2:0] CLKin_SEL1_TYPE" },

	// ----------- Reset_Mux and Reset_type --------------
	{ 0x14A, 3, 0x02,	0x02,	 "[5:3] RESET_MUX; [2:0] RESET_TYPE" },

	// -------- 0x14B - 0x152 Holdover	-----------------
	{ 0x14B, 3, 0x32,	0x16,	"[7:6] LOS_TIMEOUT; [5] LOS_EN; [4] TRACK_EN; [3] HOLDOVER_FORCE; [2] MAN_DAC_EN; [1:0] MAN_DAC[9:8]" },
	{ 0x14C, 3, 0x00,	0x00,	"[7:0] MAN_DAC[7:0]" },
	{ 0x14D, 3, 0x00,	0x00,	"[5:0] DAC_TRIP_LOW" },
	{ 0x14E, 3, 0x00,	0x00,	"[7:6] DAC_CLK_MULT; [5:0] DAC_TRIP_HIGH" },
	{ 0x14F, 3, 0x7F,	0x7F,	"[7:0] DAC_CLK_CNTR" },
	{ 0x150, 3, 0x03,	0x03,	"[4] HOLDOVER_PLL1_DET; [3] HOLDOVER_LOS_DET; [2] HOLDOVER_VTUNE_DET; [1] HOLDOVER_HITLESS_SWITCH; [0] HOLDOVER_EN" },
	{ 0x151, 3, 0x02,	0x02,	"[5:0] HOLDOVER_DLD_CNT[13:8]" },
	{ 0x152, 3, 0x00,	0x00,	"[7:0] HOLDOVER_DLD_CNT[7:0]" },

	// -------------- PLL1 Configuration (0x153 - 0x15F) ------------
	{ 0x153, 3, 0x00,	0x00,	"[5:0] CLKin0_R[13:8]" },
	{ 0x154, 3, 0x01,	120,	"[7:0] CLKin0_R[7:0]" },
	{ 0x155, 3, 0x00,	0x00,	"[5:0] CLKin1_R[13:8]" },
	{ 0x156, 3, 0x01,	150,	"[7:0] CLKin1_R[7:0]" },
	{ 0x157, 3, 0x00,	0x00,	"[5:0] CLKin2_R[13:8]" },
	{ 0x158, 3, 0x01,	150,	"[7:0] CLKin2_R[7:0]" },
	{ 0x159, 3, 0x00,	0x00,	"[5:0] PLL1_N[13:8]" },
	{ 0x15A, 3, 0x0A,	120,	"[5:0] PLL1_N[7:0]" },
	{ 0x15B, 3, 0xD4,	0xD4,	"[7:6] PLL1_WND_SIZE; [5] PLL1_CP_TRI; [4] PLL1_CP_POL; [3:0] PLL1_CP_GAIN" },
	{ 0x15C, 3, 0x20,	0x20,	"[5:0] PLL1_DLD_CNT[13:8]" },
	{ 0x15D, 3, 0x00,	0x00,	"[7:0] PLL1_DLD_CNT[7:0]" },
	{ 0x15E, 3, 0x00,	0x00,	"[5:3] PLL1_R_DLY; [2:0] PLL1_N_DLY" },
	{ 0x15F, 3, 0x0B,	0x0D,	"[7:3] PLL1_LD_MUX; [2:0] PLL1_LD_TYPE" },

	// ------------- PLL2 Configuration (0x160 - 0x16E) ------------
	{ 0x160, 3, 0x00,	0x00,	"[3:0] PLL2_R[11:8]" },
	{ 0x161, 3, 0x02,	0x02,	"[7:0] PLL2_R[7:0]" },
	{ 0x162, 3, 0x44,	0x5D,	"[7:5] PLL2_P; [4:2] OSCin_FREQ; [1] PLL2_XTAL_EN; [0] PLl2_REF_2X_EN" },
	{ 0x163, 3, 0x00,	0x00,	"[1:0] PLL2_N_CAL[17:16]" },
	{ 0x164, 3, 0x00,	0x00,	"[7:0] PLL2_N_CAL[15:8]" },
	{ 0x165, 3, 0x19,	15,	"[7:0] PLL2_N_CAL[7:0]" },

	// Fixed values
	{ 0x171, 3, 0xAA,	0xAA,	"Fixed value = 0xAA" },
	{ 0x172, 3, 0x02,	0x02,	"Fixed value = 0x02" },
	
	// Programming registers 0x17C and 0x17D
	{ 0x17C, 3, 0x15,	0x00,	"OPT_REG_1. 24 for LMK04826; 21 for LMK04828" },
	{ 0x17D, 3, 0x33,	0x00,	"OPT_REG_2. 119 for LMK04826; 51 for LMK04828" },

	{ 0x166, 3, 0x00,	0x00,	"[2] PLL2_FCAL_DIS; [1:0] PLL2_N[17:16]" },
	{ 0x167, 3, 0x00,	0x00,	"PLL2_N[15:8]" },
	{ 0x168, 3, 0x19,	15,	"PLL2_N[7:0]" },
	{ 0x169, 3, 0x59,	0x59,	"[6:5] PLL2_WND_SIZE; [4:3] PLL2_CP_GAIN; [2] PLL2_CP_POL; [1] PLL2_CP_TRI; [0] Fixed value 1 (must be set to 1)" },
	{ 0x16A, 3, 0x20,	0x20,	"[6] SYSREF_REQ_EN; [5:0] PLL2_DLD_CNT[13:8]" },
	{ 0x16B, 3, 0x00,	0x00,	"[7:0] PLL2_DLD_CNT[7:0]" },
	{ 0x16C, 3, 0x00,	0x00,	"[5:3] PLL2_LF_R4; [2:0] PLL2_LF_R3" },
	{ 0x16D, 3, 0x00,	0x00,	"[7:4] PLL2_LF_C4; [3:0] PLL2_LF_C3" },
	{ 0x16E, 3, 0x13,	0x16,	"[7:3] PLL2_LD_MUX; [2:0] PLL2_LD_TYPE" },

	// ---------- Misc registers ----------------
	{ 0x173, 3, 0x00,	0x01,	"[6] PLL2_PRE_PD; [5] PLL2_PD" },	// datasheet doesn't give default value
	{ 0x182, 3, 0x00,	0x00,	"[2] RB_PLL1_LD_LOST; [1] RB_PLL1_LD; [0] CLR_PLL1_LD_LOST" },
	{ 0x183, 3, 0x00,	0x00,	"[2] RB_PLL2_LD_LOST; [1] RB_PLL2_LD; [0] CLR_PLL2_LD_LOST" },

	// ---------- read back only ----------------
	{ 0x184, 1, 0,		0,	"[7:6] RB_DAC_VALUE[9:8]; [5] RB_CLKin2_SEL; [4] RB_CLKin1_SEL; [3] RB_CLKin0_SEL; [1] RB_CLKin1_LOS; [0] RB_CLKin0_LOS" },
	{ 0x185, 1, 0,		0,	"[7:0] RB_DAC_VALUE[7:0]" },
	{ 0x188, 1, 0,		0,	"[4] RB_HOLDOVER" },
	{ 0, 0, 0, 0, NULL}

	// NO READ BACK
	//0x1FFD 0x0  // Prevent SPI registers from being written to, except for 0x1FFD, 0x1FFE and 0x1FFF. These registers must be written to sequentially and in order
	// SPI_LOCK[23:16] 0 = Register unlocked; 1~255 = Registers locked
	//0x1FFE 0x0
	// SPI_LOCK[15:8] 0 = Register unlocked; 1~255 = Registers locked
	//0x1FFF 0x53
	// SPI_LOCK[7:0] 83 = Register unlocked; others = Registers locked
};

#endif
