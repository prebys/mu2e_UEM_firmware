#ifndef __HMC835_H_
#define __HMC835_H_

const reg_with_name_t hmc835_regs[] =
{
	{ 0x00, 1,	0xC7701A,	0xC7701A,	"Chip ID = 0xC7701A" },
	{ 0x00, 2,	0x000020,	0xC7701A,	"soft reset: program reg 0 with RESET (reg0[5]) = 1" },
	{ 0x00, 0x80,	      10,	0xC7701A,	"delay 10us" },
	{ 0x00, 2,	0x000000,	0xC7701A,	"program reg 0 with RESET (reg0[5]) = 0" },
	{ 0x01, 3,	0x000003,	0x000003,	"Chip Enable" },
	{ 0x02, 3,	0x00000A,	0x000001,	"REFDIV" },			// PFD = 10MHz (Max = 100MHz)
	{ 0x03, 3,	0x000190,	0x000019,	"Frequency Integer" },		// 0x190 = 400. output frequency = 4GHz
	{ 0x04, 3,	0x000000,	0x000000,	"Frequency Fractional" },
	{ 0x06, 3,	0x03078A,	0x030F0A,	"Delta Sigma Modulator" },	// integer mode [11] = 0; [7] = 1
	{ 0x07, 3,	0x200844,	0x200844,	"Lock Detect" },		// [20] lock detect training 0->1
	{ 0x08, 3,	0x41BFFF,	0x01BFFF,	"Analog EN" },			// [22] = 1: SDO = DVDD3V Logic
	{ 0x09, 3,	0x146850,	0x547264,	"Charge Pump" },		// Charge pump = 1.6mA: 000 1010001 1010000 1010000
	{ 0x0A, 3,	0x002046,	0x002046,	"VCO AutoCal Configuration" },
	{ 0x0B, 3,	0x07C061,	0x07C021,	"PD/CP" },			// default = 0x7c061?
	{ 0x0C, 3,	0x000000,	0x000000,	"Exact Frequency" },
	{ 0x0F, 3,	0x000001,	0x000001,	"GPO" },			
	{ 0x10, 1,	0x000080,	0x000080,	"Tuning" },
	{ 0x11, 1,	0x07FFFF,	0x07FFFF,	"SAR" },
	{ 0x12, 1,	0x00001C,	0x00001C,	"GPO/LD" },
	{ 0x13, 1,	0x001259,	0x001259,	"BIST = 0x1259" },
	{ 0x14, 3,	0x000630,	0x000220,	"Auxiliary SPI" },		// Data sheet confusing[3:0] [4] = 1; [11:10] =1
	{ 0x15, 3,	0x0F48A0,	0x0F48A0,	"Manual VCO Config" },
	{ 0x16, 3,	0x000684,	0x0006C1,	"Gain Divider" },		// try LO gain = max - 3dB [5:0] divide
	{ 0x17, 3,	0x0000BB,	0x0001AB,	"Modes" },			// LO1 and LO2 enables diff 
	{ 0x18, 3,	0x0054C1,	0x0054C1,	"Bias" },
	{ 0x19, 3,	0x000AB2,	0x000AAA,	"Cals" },
	{ 0x1A, 3,	0xB29D0B,	0xB29D0B,	"Seed" },
	{ 0x07, 2,	0x300844,	0x200844,	"Lock Detect" },		// [20] lock detect training 0->1
	{ 0x07, 2,	0x200844,	0x200844,	"Lock Detect" },		// [20] lock detect training 0->1
	{ 0, 0, 0, 0, NULL}
};

#endif /* __HMC835_H_ */
