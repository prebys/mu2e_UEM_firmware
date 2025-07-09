# Standard Bitfiles

## Mux Configuration

The first step of [setup](https://github.com/prebys/mu2e_UEM_firmware/blob/main/code/setup_fmc228.sh) is to run `./amc502_mux 192.168.40.245 < mux_master.txt` which loads [mux_master.txt](https://github.com/prebys/mu2e_UEM_firmware/blob/main/code/mux_master.txt) values using the [mux_master.cc](https://github.com/prebys/mu2e_UEM_firmware/blob/main/code/amc502_mux.cc) program.

On all bitfiles, the first time this runs, this fails for some reason, but that is fine. The failure looks like this.

```
Source port = 47000
_msg = 0x172d620
ReadCrossbarSwitch(0)...
receive() - Resource temporarily unavailable
ReadCrossbarSwitch() - receive() - timeout.
MUX0 =  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  Port 00 (TCLKA) :  output <-- 15 (FMCEXPD)
  Port 01 (TCLKB) :  output <-- 15 (FMCEXPD)
  Port 02 (TCLKC) :  output <-- 15 (FMCEXPD)
  Port 03 (TCLKD) :  output <-- 15 (FMCEXPD)
  Port 04 (PLLCLKA_in) :  output <-- 15 (FMCEXPD)
  Port 05 (PLLCLKB_in) :  output <-- 15 (FMCEXPD)
  Port 06 (PLLCLKC_in) :  output <-- 15 (FMCEXPD)
  Port 07 (PLLCLKD_in) :  output <-- 15 (FMCEXPD)
  Port 08 (FPCLKE) :  output <-- 15 (FMCEXPD)
  Port 09 (FPCLKF) :  output <-- 15 (FMCEXPD)
  Port 10 (FPCLKG) :  output <-- 15 (FMCEXPD)
  Port 11 (FPCLKH) :  output <-- 15 (FMCEXPD)
  Port 12 (FMCEXPA) :  output <-- 15 (FMCEXPD)
  Port 13 (FMCEXPB) :  output <-- 15 (FMCEXPD)
  Port 14 (FMCEXPC) :  output <-- 15 (FMCEXPD)
  Port 15 (FMCEXPD) :  output <-- 15 (FMCEXPD)
ReadCrossbarSwitch(1)...
receive() - Resource temporarily unavailable
ReadCrossbarSwitch() - receive() - timeout.
MUX1 =  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  Port 00 (FMCEXPA) :  output <-- 15 (FMC1_CLK3_BIDIR)
  Port 01 (FMCEXPB) :  output <-- 15 (FMC1_CLK3_BIDIR)
  Port 02 (FMCEXPC) :  output <-- 15 (FMC1_CLK3_BIDIR)
  Port 03 (FMCEXPD) :  output <-- 15 (FMC1_CLK3_BIDIR)
  Port 04 (PLLCLKA_out) :  output <-- 15 (FMC1_CLK3_BIDIR)
  Port 05 (PLLCLKB_out) :  output <-- 15 (FMC1_CLK3_BIDIR)
  Port 06 (PLLCLKC_out) :  output <-- 15 (FMC1_CLK3_BIDIR)
  Port 07 (PLLCLKD_out) :  output <-- 15 (FMC1_CLK3_BIDIR)
  Port 08 (FMC0_CLK0_M2C) :  output <-- 15 (FMC1_CLK3_BIDIR)
  Port 09 (FMC0_CLK1_M2C) :  output <-- 15 (FMC1_CLK3_BIDIR)
  Port 10 (FMC0_CLK2_BIDIR) :  output <-- 15 (FMC1_CLK3_BIDIR)
  Port 11 (FMC0_CLK3_BIDIR) :  output <-- 15 (FMC1_CLK3_BIDIR)
  Port 12 (FMC1_CLK0_M2C) :  output <-- 15 (FMC1_CLK3_BIDIR)
  Port 13 (FMC1_CLK1_M2C) :  output <-- 15 (FMC1_CLK3_BIDIR)
  Port 14 (FMC1_CLK2_BIDIR) :  output <-- 15 (FMC1_CLK3_BIDIR)
  Port 15 (FMC1_CLK3_BIDIR) :  output <-- 15 (FMC1_CLK3_BIDIR)
MUX0 :  00 8b 00 00 80 88 80 00 40 80 80 00 88 40 00 00
MUX1 :  40 84 00 00 40 00 00 00 00 00 84 00 00 00 84 00
receive() - Resource temporarily unavailable
WriteCrossbarSwitch() - receive() - timeout.
```

However, running that same command again immediately a second time usually always works, so the fact that it is failed the first time is ignored.

```
Source port = 47000
_msg = 0x1982620
ReadCrossbarSwitch(0)...
  1.  (4) waitclr ack    loop=1
  2.  (0) write ack
  3.  (4) waitclr ack    loop=6150
  4.  (8) read ack  0xc0000200 = 0x8b00
  5.  (8) read ack  0xc0000204 = 0x808880
  6.  (8) read ack  0xc0000208 = 0x808040
  7.  (8) read ack  0xc000020c = 0x4088
MUX0 =  00 8b 00 00 80 88 80 00 40 80 80 00 88 40 00 00
  Port 00 (TCLKA) :  input
  Port 01 (TCLKB) :  output <-- 11 (FPCLKH)
  Port 02 (TCLKC) :  input
  Port 03 (TCLKD) :  input
  Port 04 (PLLCLKA_in) :  output <-- 0 (TCLKA)
  Port 05 (PLLCLKB_in) :  output <-- 8 (FPCLKE)
  Port 06 (PLLCLKC_in) :  output <-- 0 (TCLKA)
  Port 07 (PLLCLKD_in) :  input
  Port 08 (FPCLKE) :  input Z=100 Ohm
  Port 09 (FPCLKF) :  output <-- 0 (TCLKA)
  Port 10 (FPCLKG) :  output <-- 0 (TCLKA)
  Port 11 (FPCLKH) :  input
  Port 12 (FMCEXPA) :  output <-- 8 (FPCLKE)
  Port 13 (FMCEXPB) :  input Z=100 Ohm
  Port 14 (FMCEXPC) :  input
  Port 15 (FMCEXPD) :  input
ReadCrossbarSwitch(1)...
  1.  (4) waitclr ack    loop=1
  2.  (0) write ack
  3.  (4) waitclr ack    loop=6143
  4.  (8) read ack  0xc0000200 = 0x8440
  5.  (8) read ack  0xc0000204 = 0x40
  6.  (8) read ack  0xc0000208 = 0x840000
  7.  (8) read ack  0xc000020c = 0x840000
MUX1 =  40 84 00 00 40 00 00 00 00 00 84 00 00 00 84 00
  Port 00 (FMCEXPA) :  input Z=100 Ohm
  Port 01 (FMCEXPB) :  output <-- 4 (PLLCLKA_out)
  Port 02 (FMCEXPC) :  input
  Port 03 (FMCEXPD) :  input
  Port 04 (PLLCLKA_out) :  input Z=100 Ohm
  Port 05 (PLLCLKB_out) :  input
  Port 06 (PLLCLKC_out) :  input
  Port 07 (PLLCLKD_out) :  input
  Port 08 (FMC0_CLK0_M2C) :  input
  Port 09 (FMC0_CLK1_M2C) :  input
  Port 10 (FMC0_CLK2_BIDIR) :  output <-- 4 (PLLCLKA_out)
  Port 11 (FMC0_CLK3_BIDIR) :  input
  Port 12 (FMC1_CLK0_M2C) :  input
  Port 13 (FMC1_CLK1_M2C) :  input
  Port 14 (FMC1_CLK2_BIDIR) :  output <-- 4 (PLLCLKA_out)
  Port 15 (FMC1_CLK3_BIDIR) :  input
MUX0 :  00 8b 00 00 80 88 80 00 40 80 80 00 88 40 00 00
MUX1 :  40 84 00 00 40 00 00 00 00 00 84 00 00 00 84 00
```

## PLL Configuration

Then we load PLL data using [amc502_pll.cc](https://github.com/prebys/mu2e_UEM_firmware/blob/main/code/amc502_pll.cc) and [pll_config.txt](https://github.com/prebys/mu2e_UEM_firmware/blob/main/code/pll_config.txt). For very many lines, this looks like

```
Source port = 47000
_msg = 0xa73620
Register 0 <-- 1f
Register 1 <-- a2
Register 2 <-- 5
Register 3 <-- 0
Register 4 <-- 0
Register 5 <-- 5
Register 6 <-- 54
Register 7 <-- ff
Register 8 <-- ff
Register 9 <-- ff
Register a <-- ff
Register b <-- 0
Register c <-- 0
Register d <-- 0
Register e <-- 0
Register f <-- 0
Register 10 <-- 0
Register 11 <-- 0
Register 12 <-- 0
Register 13 <-- 0
Register 14 <-- 0
Register 15 <-- 0
Register 16 <-- 0
Register 17 <-- 0
Register 18 <-- 1
Register 19 <-- 80
Register 1a <-- 3
Register 1b <-- 0
Register 1c <-- 0
[ ... ]
```

# Rare Case: Bad Bitfile

Every once in a while, (has only happened twice), I manage to create a bitfile that fully compiles, looks good in simulation, gets programmed to the FPGA, but when I try to run the above two steps with it, the mux and PLL configuration fail. 

The mux config result looks like:

```
Source port = 47000
_msg = 0x1a1e620
ReadCrossbarSwitch(0)...
receive() - Resource temporarily unavailable
ReadCrossbarSwitch() - receive() - timeout.
MUX0 =  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  Port 00 (TCLKA) :  output <-- 15 (FMCEXPD)
  Port 01 (TCLKB) :  output <-- 15 (FMCEXPD)
  Port 02 (TCLKC) :  output <-- 15 (FMCEXPD)
  Port 03 (TCLKD) :  output <-- 15 (FMCEXPD)
  Port 04 (PLLCLKA_in) :  output <-- 15 (FMCEXPD)
  Port 05 (PLLCLKB_in) :  output <-- 15 (FMCEXPD)
  Port 06 (PLLCLKC_in) :  output <-- 15 (FMCEXPD)
  Port 07 (PLLCLKD_in) :  output <-- 15 (FMCEXPD)
  Port 08 (FPCLKE) :  output <-- 15 (FMCEXPD)
  Port 09 (FPCLKF) :  output <-- 15 (FMCEXPD)
  Port 10 (FPCLKG) :  output <-- 15 (FMCEXPD)
  Port 11 (FPCLKH) :  output <-- 15 (FMCEXPD)
  Port 12 (FMCEXPA) :  output <-- 15 (FMCEXPD)
  Port 13 (FMCEXPB) :  output <-- 15 (FMCEXPD)
  Port 14 (FMCEXPC) :  output <-- 15 (FMCEXPD)
  Port 15 (FMCEXPD) :  output <-- 15 (FMCEXPD)
ReadCrossbarSwitch(1)...
  1.  (4) waitclr ack    loop=1
  2.  (0) write ack
  3.  (4) waitclr ack    loop=6138
  4.  (8) read ack  0xc0000200 = 0x8440
  5.  (8) read ack  0xc0000204 = 0x40
  6.  (8) read ack  0xc0000208 = 0x840000
  7.  (8) read ack  0xc000020c = 0x840000
MUX1 =  40 84 00 00 40 00 00 00 00 00 84 00 00 00 84 00
  Port 00 (FMCEXPA) :  input Z=100 Ohm
  Port 01 (FMCEXPB) :  output <-- 4 (PLLCLKA_out)
  Port 02 (FMCEXPC) :  input
  Port 03 (FMCEXPD) :  input
  Port 04 (PLLCLKA_out) :  input Z=100 Ohm
  Port 05 (PLLCLKB_out) :  input
  Port 06 (PLLCLKC_out) :  input
  Port 07 (PLLCLKD_out) :  input
  Port 08 (FMC0_CLK0_M2C) :  input
  Port 09 (FMC0_CLK1_M2C) :  input
  Port 10 (FMC0_CLK2_BIDIR) :  output <-- 4 (PLLCLKA_out)
  Port 11 (FMC0_CLK3_BIDIR) :  input
  Port 12 (FMC1_CLK0_M2C) :  input
  Port 13 (FMC1_CLK1_M2C) :  input
  Port 14 (FMC1_CLK2_BIDIR) :  output <-- 4 (PLLCLKA_out)
  Port 15 (FMC1_CLK3_BIDIR) :  input
MUX0 :  00 8b 00 00 80 88 80 00 40 80 80 00 88 40 00 00
MUX1 :  40 84 00 00 40 00 00 00 00 00 84 00 00 00 84 00
receive() - Resource temporarily unavailable
WriteCrossbarSwitch() - receive() - timeout.
```

It can be seen above that half hte lines work, but half still fail, and both sections end with "Resource temporary unavailable". 

For the pll configuation, it also half works:

```
[ ... ]
Register 17 <-- 0
Register 18 <-- 1
Register 19 <-- 80
Register 1a <-- 3
Register 1b <-- 0
receive() - Resource temporarily unavailable
ReadMatchCounters() - receive() - timeout.
Register 1c <-- 0
receive() - Resource temporarily unavailable
ReadMatchCounters() - receive() - timeout.
Register 1d <-- 0
Register 1e <-- 0
Register 1f <-- 0
Register 20 <-- 0
Register 21 <-- 0
receive() - Resource temporarily unavailable
ReadMatchCounters() - receive() - timeout.
Register 22 <-- 0
Register 23 <-- 0
Register 24 <-- 0
Register 25 <-- 0
Register 26 <-- 0
[ ... ]
```

Not sure how to fix this or what causes this problem. The only thing I can think of is to keep undoing changes to the bitfile that I made and then re-write it and hope whatever I make doesn't cause the problem anymore.
