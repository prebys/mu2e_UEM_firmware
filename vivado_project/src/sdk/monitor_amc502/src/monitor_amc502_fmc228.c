/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "mb_interface.h"

#include "kernel.h"

typedef struct {
  unsigned int addr;
  char access_type; // bit[0]=1: read; bit[1]=1: write; bit[7]=1: data is delay time in 1us.
  unsigned int data;
  unsigned int por_default;
  const char* name;
} reg_with_name_t;

#include "lmk04824.h"
#include "hmc835.h"
#include "ad9234.h"

#define TIMEOUT 1024
#define UART_SR (*(volatile unsigned char *)(0x80000008))

#define AMC502_CSR             (*(volatile unsigned int *)(0xc0000000))
#define AMC502_I2C             (*(volatile unsigned int *)(0xc0000004))
#define AMC502_TRIGCMD         (*(volatile unsigned int *)(0xc0000008))
#define AMC502_SLAVE_PLL       (*(volatile unsigned int *)(0xc000000c))
#define AMC502_COUNT_LOW       (*(volatile unsigned int *)(0xc0000010))
#define AMC502_COUNT_HIGH      (*(volatile unsigned int *)(0xc0000014))
#define AMC502_TIMER_LOW       (*(volatile unsigned int *)(0xc0000018))
#define AMC502_TIMER_HIGH      (*(volatile unsigned int *)(0xc000001c))
#define AMC502_CLOCK_TIME      (*(volatile unsigned int *)(0xc0000020))
#define AMC502_BCO_COUNTER_LO  (*(volatile unsigned int *)(0xc0000030))
#define AMC502_BCO_COUNTER_HI  (*(volatile unsigned int *)(0xc0000034))

#define AMC502_I2C_WBUF        ((volatile unsigned int *)(0xc0000100))
#define AMC502_I2C_RBUF        ((volatile unsigned int *)(0xc0000200))
#define AMC502_FREQ            ((volatile unsigned int *)(0xc0000080))
#define AMC502_FREQ_FPCLKE     (*(volatile unsigned int *)(0xc000008c))

#define IOBUS_GBE_BUFFER_STATUS      (*(volatile unsigned int *)(0xc1007f00))
#define IOBUS_GBE_BUFFER             ((volatile unsigned int *)(0xc1008000))

#define IOBUS_GBE_CSR                (*(volatile unsigned int *)(0xc1000000))
#define IOBUS_GBE_MAC_ADDR_LOW       (*(volatile unsigned int *)(0xc1000018))
#define IOBUS_GBE_MAC_ADDR_HIGH      (*(volatile unsigned int *)(0xc100001c))
#define IOBUS_GBE_IP_ADDR            (*(volatile unsigned int *)(0xc1000020))
#define IOBUS_GBE_NETMASK            (*(volatile unsigned int *)(0xc1000024))
#define IOBUS_GBE_GATEWAY            (*(volatile unsigned int *)(0xc1000028))

#define IOBUS_GBE_ARP_CSR            (*(volatile unsigned int *)(0xc1000044))
#define IOBUS_GBE_ARP_TARGET_IP      (*(volatile unsigned int *)(0xc1000048))
#define IOBUS_GBE_ARP_TABLE_IP       (*(volatile unsigned int *)(0xc100004c))
#define IOBUS_GBE_ARP_TABLE_HA_LOW   (*(volatile unsigned int *)(0xc1000050))
#define IOBUS_GBE_ARP_TABLE_HA_HIGH  (*(volatile unsigned int *)(0xc1000054))
#define IOBUS_GBE_ARP_TABLE_REFCOUNT (*(volatile unsigned int *)(0xc1000058))

#define IOBUS_GBE_UDP_BUFFER         ((volatile unsigned int *)(0xc1008000))
#define IOBUS_GBE_UDP_SADDR          (*(volatile unsigned int *)(0xc10087f0))
#define IOBUS_GBE_UDP_DADDR          (*(volatile unsigned int *)(0xc10087f4))
#define IOBUS_GBE_UDP_PORTS          (*(volatile unsigned int *)(0xc10087f8))
#define IOBUS_GBE_UDP_LENGTH         (*(volatile unsigned int *)(0xc10087fc))
#define IOBUS_GBE_TXUDP_DADDR        (*(volatile unsigned int *)(0xc1000064))
#define IOBUS_GBE_TXUDP_PORTS        (*(volatile unsigned int *)(0xc1000068))
#define IOBUS_GBE_TXUDP_CSR          (*(volatile unsigned int *)(0xc1007c00))
#define IOBUS_GBE_TXUDP_BUFFER       ((volatile unsigned int *)(0xc100c000))
#define IOBUS_GBE_STREAMPKT_CSR      (*(volatile unsigned int *)(0xc1000070))
#define IOBUS_GBE_STREAMPKT_DADDR    (*(volatile unsigned int *)(0xc1000074))
#define IOBUS_GBE_STREAMPKT_PORTS    (*(volatile unsigned int *)(0xc1000078))
#define IOBUS_GBE_STREAMPKT_FIFO     (*(volatile unsigned int *)(0xc100007c))

#define IOBUS_XGBE_CSR                (*(volatile unsigned int *)(0xc3000000))
#define IOBUS_XGBE_MAC_ADDR_LOW       (*(volatile unsigned int *)(0xc3000018))
#define IOBUS_XGBE_MAC_ADDR_HIGH      (*(volatile unsigned int *)(0xc300001c))
#define IOBUS_XGBE_IP_ADDR            (*(volatile unsigned int *)(0xc3000020))
#define IOBUS_XGBE_NETMASK            (*(volatile unsigned int *)(0xc3000024))
#define IOBUS_XGBE_GATEWAY            (*(volatile unsigned int *)(0xc3000028))
#define IOBUS_XGBE_ARP_CSR            (*(volatile unsigned int *)(0xc3000044))
#define IOBUS_XGBE_ARP_TARGET_IP      (*(volatile unsigned int *)(0xc3000048))
#define IOBUS_XGBE_ARP_TABLE_IP       (*(volatile unsigned int *)(0xc300004c))
#define IOBUS_XGBE_ARP_TABLE_HA_LOW   (*(volatile unsigned int *)(0xc3000050))
#define IOBUS_XGBE_ARP_TABLE_HA_HIGH  (*(volatile unsigned int *)(0xc3000054))
#define IOBUS_XGBE_ARP_TABLE_REFCOUNT (*(volatile unsigned int *)(0xc3000058))
#define IOBUS_XGBE_RXUDP_CSR          (*(volatile unsigned int *)(0xc3000060))
#define IOBUS_XGBE_TXUDP_DADDR        (*(volatile unsigned int *)(0xc3000064))
#define IOBUS_XGBE_TXUDP_PORTS        (*(volatile unsigned int *)(0xc3000068))
#define IOBUS_XGBE_ICMPREQ_CSR        (*(volatile unsigned int *)(0xc3000070))
#define IOBUS_XGBE_ICMPREQ_SEQUENCE   (*(volatile unsigned int *)(0xc3000074))
#define IOBUS_XGBE_ICMPREQ_IP_ADDR    (*(volatile unsigned int *)(0xc3000078))
#define IOBUS_XGBE_ICMPREQ_TIMER      (*(volatile unsigned int *)(0xc300007c))
#define IOBUS_XGBE_TXUDP_CSR          (*(volatile unsigned int *)(0xc3000080))
#define IOBUS_XGBE_NRX                (*(volatile unsigned int *)(0xc3000200))
#define IOBUS_XGBE_NARP               (*(volatile unsigned int *)(0xc3000204))
#define IOBUS_XGBE_NICMP              (*(volatile unsigned int *)(0xc3000208))
#define IOBUS_XGBE_NUDP               (*(volatile unsigned int *)(0xc300020c))
#define IOBUS_XGBE_TXUDP_BUFFER       ((volatile unsigned int *)(0xc300c000))
#define IOBUS_XGBE_RXUDP_BUFFER(i)    ((volatile unsigned int *)(0xc3008000+0x0800*(i)))

#define FMC228_CSR             (*(volatile unsigned int *)(0xcf000000))
#define FMC228_LMKSPI          (*(volatile unsigned int *)(0xcf000010))
#define FMC228_HMCSPI          (*(volatile unsigned int *)(0xcf000014))
#define FMC228_ADC0SPI          (*(volatile unsigned int *)(0xcf000018))
#define FMC228_ADC1SPI          (*(volatile unsigned int *)(0xcf00001c))

#define FMC228_ADC0_SCSR         (*(volatile unsigned int *)(0xcf000020))
#define FMC228_ADC1_SCSR         (*(volatile unsigned int *)(0xcf000024))
#define FMC228_ADC0_SYNC         (*(volatile unsigned int *)(0xcf000028))
#define FMC228_ADC1_SYNC         (*(volatile unsigned int *)(0xcf00002c))

#define FMC228_BUFFER_CH0       (*(volatile unsigned int *)(0xcf000080))
#define FMC228_BUFFER_CH1       (*(volatile unsigned int *)(0xcf000084))
#define FMC228_BUFFER_CH2       (*(volatile unsigned int *)(0xcf000088))
#define FMC228_BUFFER_CH3       (*(volatile unsigned int *)(0xcf00008c))

//
#define MAXARG 16
#define NCMD (sizeof(cmds)/sizeof(struct s_cmd))

extern unsigned int nint[];
extern const char *cint[];

static int tz = -5;

const int bit_mux0 = 1;
const int bit_mux1 = 2;
const int bit_lmk = 4;
const int bit_hmc = 8;
const int bit_adc0 = 16;
const int bit_adc1 = 32;

struct s_cmd {
  const char *cmd;
  const char *help;
  int (*func)(int,const char **);
};

struct s_ad9517 {
  int a;
  int b;
  int r;
  int p;
  int pv;
  int dv;
  int rd;
  float freq;
};

void print_time(unsigned int j) {
  unsigned int t = j;
  int h = (t/3600+tz*3600)%24;
  int m = (t/60)%60;
  int s = t%60;
  _putch('0'+h/10);
  _putch('0'+(h%10));
  _putch(':');
  _putch('0'+m/10);
  _putch('0'+(m%10));
  _putch(':');
  _putch('0'+s/10);
  _putch('0'+(s%10));
}

int cmd_time(int argc,const char **argv) {
  print_time(AMC502_CLOCK_TIME);
  _printf("\n\r");
  return 0;
}

void print_date(unsigned int time) {
  unsigned int leap, day, year, mon, mday;
  static const char *months[] = { "Jan", "Feb", "Mar", "Apr",
                                  "May", "Jun", "Jul", "Aug",
                                  "Sep", "Oct", "Nov", "Dec" };

  day = time/(24UL*60*60);
  year = ((day*4)+2)/1461;
  leap = !(year&3);
  day -= ((year*1461)+1)/4;
  day += (day>58+leap)?(leap?1:2):0;
  mon = ((day*12)+6)/367;
  mday = day + 1 - ((mon*367)+5)/12;
  _printf( "%d-%s-%d", mday, months[mon], (year+70)%100 );
}

int cmd_date(int argc,const char **argv) {
  print_date(AMC502_CLOCK_TIME);
  _printf("\n\r");
  return 0;
}

int cmd_nint(int argc,const char **argv) {
  int i;
  for ( i=0; i<4; i++ ) {
    _printf( "%s = %d\n\r", cint[i], nint[i] );
  }
  return 0;
}

int cmd_peek(int argc,const char **argv) {
  unsigned int addr, data;
  if ( argc != 2 ) return 1;
  addr = _atoh(argv[1]);
  _print_hex_long(addr);
  _puts(" = ");
  data = *((volatile unsigned int *)addr);
  _print_hex_long(data);
  _puts("\n\r");
  return 0;
}

int cmd_poke(int argc,const char **argv) {
  unsigned int addr, data;
  if ( argc != 3 ) return 1;
  addr = _atoh(argv[1]);
  _print_hex_long(addr);
  _puts(" = ");
  data = *((volatile unsigned int *)addr);
  _print_hex_long(data);
  _puts(" <-- ");
  data = _atoh(argv[2]);
  _print_hex_long(data);
  *((volatile unsigned int *)addr) = data;
  _puts("\n\r");
  return 0;
}

int cmd_dump(int argc,const char **argv) {
  static unsigned int addr = 0;
  unsigned int last, word;
  int byte, twobytes;
  int n = 16;
  int i, j;
  int w = 4;

  if ( argc > 1 ) {
    addr = _atoh(argv[1]);
  }
  if ( argc > 2 ) {
    n = _atoi(argv[2]);
  }
  if ( argc > 3 ) {
    if ( *argv[3] == 'b' ) {
      w = 1;
    }
    else if ( *argv[3] == 'w' ) {
      w = 2;
    }
    else if ( *argv[3] == 'l' ) {
      w = 4;
    }
    else {
      return 1;
    }
  }
  last = addr + n;
  while ( addr < last ) {
    _printf( "%x :", addr );
    for ( i=0; i<4; i++ ) {
      word = ((unsigned int *)addr)[i];
      if ( w == 1 ) {
        for ( j=0; j<4; j++ ) {
          byte = (word>>(24-8*j))&0xff;
          _putch(' ');
          _print_hex_byte(byte);
        }
      }
      else if ( w == 2 ) {
        for ( j=0; j<2; j++ ) {
          twobytes = (word>>(16*j))&0xffff;
          _printf(" %04x", twobytes );
        }
      }
      else if ( w == 4 ) {
        _printf( " %08x", word );
      }
    }
    if ( w == 1 ) {
      _printf( "  " );
      for ( i=0; i<4; i++ ) {
        word = ((unsigned int *)addr)[i];
        for ( j=0; j<4; j++ ) {
          byte = (word>>(24-8*j))&0xff;
          if ( _isprint(byte) ) {
            _putch(byte);
          }
          else {
            _putch('.');
          }
        }
      }
    }
    _printf( "\n\r" );
    addr += 16;
  }
  return 0;
}

int cmd_freq(int argc,const char **argv) {
  static char *clkname[] = { "   bcoclk", "   sysclk", "  bcoclk*", "  sysclk*",
                             "   fpclkb", "clk100mhz", "  gmiiclk",
                             " dclkout0", " dclkout2", "dclkout10", "dclkout12",
                             " sysref11", " sysref13", NULL };
  int i;

  for ( i=0; clkname[i] != NULL; i++ ) {
    _printf( "%s : %d.%d MHz\n\r",
             clkname[i],
             AMC502_FREQ[i]/1000000,
             AMC502_FREQ[i]%1000000
           );
  }
  return 0;
}

int setup_everything(int mask) {
  unsigned char *p;
  unsigned int word, word1;
  int i, j, lock, nlock;

  if ( mask&bit_mux0 ) {
    _puts("\r\nSet up 8V54816A clock MUX...");
    while ( (AMC502_I2C&0x80000000) );

//
//  output port 0 (TCLKA) <-- port 8 (FPCLKE)
//  input port 1 (TCLKB)
//  input port 2 (TCLKC)
//  input port 3 (TCLKD)
//  input port 4 (unused - FPCLKA)
//  input port 5 (unused - FPCLKB)
//  input port 6 (unused - FPCLKC)
//  input port 7 (unused - FPCLKD)
//  input port 8 (FPCLKE - 10 MHz clock)
//  output port 9 (FPCLKF) <-- port 8 (FPCLKE)
//  output port 10 (FPCLKG) <-- port 1 (TCLKB)
//  input port 11 (FPCLKH) <-- clk/trig
//  output port 12 (FMCEXPA) <-- port 8 (FPCLKE)
//  input port 13 (FMCEXPB)
//  input port 14 (FMCEXPC)
//  input port 15 (FMCEXPD)
//
    AMC502_I2C_WBUF[0] = 0x0000408b;
    AMC502_I2C_WBUF[1] = 0x00000000;
    AMC502_I2C_WBUF[2] = 0x40818840;
    AMC502_I2C_WBUF[3] = 0x40404088;
  
    AMC502_I2C = 0x10b0;
    for ( j=0; j<20; j++ );
  }
  if ( mask&bit_mux1 ) {
    while ( (AMC502_I2C&0x80000000) );

    AMC502_I2C_WBUF[0] = 0x8d8c0040; // Port 0 is input (FMCEXPA)
                                           // Port 12 --> Port 2 (FMCEXPC)
                                           // Port 13 --> Port 3 (FMCEXPD)
    AMC502_I2C_WBUF[1] = 0;
    AMC502_I2C_WBUF[2] = 0;
    AMC502_I2C_WBUF[3] = 0x00804040; // Port 12 is input (FMC1_CLK0_M2C)
                                           // Port 13 is input (FMC1_CLK1_M2C)
                                           // Port 14 is output (FMC1_CLK2_BIDIR) mapped to input port 0
                                           // Port 15 is input (FMC1_CLK3_BIDIR) (unused)

    AMC502_I2C = 0x10b2;
    for ( j=0; j<20; j++ );
  }

  if ( mask&bit_mux0 ) {
    while ( (AMC502_I2C&0x80000000) );

    AMC502_I2C = 0x10b1;
    for ( j=0; j<20; j++ );
    while ( (AMC502_I2C&0x80000000) );
    _puts("\r\nMUX0 =");
    p = (unsigned char *)AMC502_I2C_RBUF;
    for ( i=0; i<16; i++ ) {
      _putch(' ');
      _print_hex_byte(p[i]);
    }
  }
  if ( mask&bit_mux1 ) {
    while ( (AMC502_I2C&0x80000000) );
    AMC502_I2C = 0x10b3;
    for ( j=0; j<20; j++ );
    while ( (AMC502_I2C&0x80000000) );
    _puts("\r\nMUX1 =");
    p = (unsigned char *)AMC502_I2C_RBUF;
    for ( i=0; i<16; i++ ) {
      _putch(' ');
      _print_hex_byte(p[i]);
    }
  }

  FMC228_CSR |= 0x120;   //  Turn on the HMC835 PLL device

  if ( mask&bit_lmk ) {
    _puts("Set up LMK04828...");
    FMC228_LMKSPI = 0x00008000;
    for ( j=0; (FMC228_LMKSPI&0x80000000); j++ );
    for ( j=0; j<10; j++ );
    FMC228_LMKSPI = 0;
    for ( j=0; (FMC228_LMKSPI&0x80000000); j++ );
    for ( j=0; j<10; j++ );

    for ( i=0; lmk04828_regs[i].name; i++ ) {
      for ( j=0; (FMC228_LMKSPI&0x80000000); j++ );
      if ( (lmk04828_regs[i].access_type&2) ) {
        word = (lmk04828_regs[i].addr<<16)|(lmk04828_regs[i].data<<8);
        FMC228_LMKSPI = word;
      }
      else if ( (lmk04828_regs[i].access_type&1) ) {
        word = 0x80000000 | (lmk04828_regs[i].addr<<16);
        FMC228_LMKSPI = word;
        j = 0;
        do {
          word1 = FMC228_LMKSPI;
          j += 1;
        }
        while ( word1&0x80000000 );
      }
      else if ( (lmk04828_regs[i].access_type&0x80) ) {
        for ( j=0; j<100*lmk04828_regs[i].data; j++ );
      }
    }
    _puts(" check PLL lock: ");

    nlock = 0;
    lock = 0;
    do {
      FMC228_LMKSPI = 0x81820000;
      j = 0;
      do {
        word1 = FMC228_LMKSPI;
        j += 1;
      }
      while ( word1&0x80000000 );
  
      lock |= (word1&2)>>1;
  
      FMC228_LMKSPI = 0x81830000;
      j = 0;
      do {
        word1 = FMC228_LMKSPI;
        j += 1;
      }
      while ( word1&0x80000000 );
      lock |= (word1&2);
    }
    while ( lock != 0x03 && nlock++ < 1000 );

    _putch((lock&1)?'1':'0');
    _putch('/');
    _putch((lock&2)?'1':'0');
    _puts(" (");
    _print_int(nlock);
    _puts(")\n\r");
  }

  if ( mask&bit_hmc ) {
    _puts("Set up HMC835 PLL...");
    for ( i=0; hmc835_regs[i].name; i++ ) {
      while ( (FMC228_HMCSPI&0x80000000) );
      if ( (hmc835_regs[i].access_type&2) ) {
        word = (hmc835_regs[i].addr<<24)|hmc835_regs[i].data;
        FMC228_HMCSPI = word;
      }
      else if ( (hmc835_regs[i].access_type&1) ) {
        FMC228_HMCSPI = hmc835_regs[i].addr;
        for ( j=0; j<10; j++ );
        while ( (FMC228_HMCSPI&0x80000000) );
        FMC228_HMCSPI = hmc835_regs[i].addr;
        for ( j=0; j<10; j++ );
        while ( (FMC228_HMCSPI&0x80000000) );
        word = FMC228_HMCSPI;
      }
      else if ( (hmc835_regs[i].access_type&0x80) ) {
        for ( j=0; j<100*hmc835_regs[i].data; j++ );
      }
    }
    for ( j=0; j<10000; j++ );
    lock = 0;
    _puts(" check PLL lock: ");
    FMC228_HMCSPI = 0x12;
    for ( j=0; j<10; j++ );
    while ( (FMC228_HMCSPI&0x80000000) );
    FMC228_HMCSPI = 0x12;
    for ( j=0; j<10; j++ );
    while ( (FMC228_HMCSPI&0x80000000) );
    lock |= ((FMC228_HMCSPI&2)<<1);
    if ( ! (lock&4) ) {
      _puts("not ");
    }
    _puts("locked.\n\r");
  }
  if ( mask&bit_adc0 ) {
    _puts("Set up AD9234 Ch. 0...\n\r");
    for ( i=0; ad9234_regs[i].name; i++ ) {
      for ( j=0; (FMC228_ADC0SPI&0x80000000); j++ );
      if ( (ad9234_regs[i].access_type&2) ) {
        word = (ad9234_regs[i].addr<<16)|(ad9234_regs[i].data<<8);
        FMC228_ADC0SPI = word;
      }
      else if ( (ad9234_regs[i].access_type&1) ) {
        word = 0x80000000 | (ad9234_regs[i].addr<<16);
        FMC228_ADC0SPI = word;
        j = 0;
        do {
          word1 = FMC228_ADC0SPI;
          j += 1;
        }
        while ( word1&0x80000000 );
      }
      else if ( (ad9234_regs[i].access_type&0x80) ) {
        for ( j=0; j<100*ad9234_regs[i].data; j++ );
      }
    }
  }
  if ( mask&bit_adc1 ) {
    _puts("Set up AD9234 Ch. 1...\n\r");
    for ( i=0; ad9234_regs[i].name; i++ ) {
      for ( j=0; (FMC228_ADC1SPI&0x80000000); j++ );
      if ( (ad9234_regs[i].access_type&2) ) {
        word = (ad9234_regs[i].addr<<16)|(ad9234_regs[i].data<<8);
        FMC228_ADC1SPI = word;
      }
      else if ( (ad9234_regs[i].access_type&1) ) {
        word = 0x80000000 | (ad9234_regs[i].addr<<16);
        FMC228_ADC1SPI = word;
        j = 0;
        do {
          word1 = FMC228_ADC1SPI;
          j += 1;
        }
        while ( word1&0x80000000 );
      }
      else if ( (ad9234_regs[i].access_type&0x80) ) {
        for ( j=0; j<100*ad9234_regs[i].data; j++ );
      }
    }
  }

  if ( mask&bit_adc0 ) {
    _puts("Check clock input at AD9234 Ch. 0: ");
    FMC228_ADC0SPI = 0x80000000 | (0x11c<<16);
    j = 0;
    do {
      word1 = FMC228_ADC0SPI;
      j += 1;
    }
    while ( word1&0x80000000 );
    _puts(" 0x");
    _print_hex_byte(word1&0xff);
    _puts("  (");
    _print_int(j);
    _puts(")\n\r");

    if ( (word1&1) ) {
      _puts("Lane sync: ");
      FMC228_ADC0_SCSR |= 0x00000003;
      j = 0;
      do {
        word1 = FMC228_ADC0_SCSR;
        j += 1;
      }
      while ( (word1&1) && j < 100000 );
    }
    _putch('[');
    _print_int(j);
    _putch(']');
    word1 = FMC228_ADC0_SYNC;
    for ( j=0; j<4; j++ ) {
      _putch(' ');
      _print_int((word1>>2)&0x3f);
      _putch('.');
      _print_int((word1&0x03));
      word1 >>= 8;
    }
    _puts("\n\r");
  }
  if ( mask&bit_adc1 ) {
    _puts("Check clock input at AD9234 Ch. 1: ");
    FMC228_ADC1SPI = 0x80000000 | (0x11c<<16);
    j = 0;
    do {
      word1 = FMC228_ADC1SPI;
      j += 1;
    }
    while ( word1&0x80000000 );
    _puts(" 0x");
    _print_hex_byte(word1&0xff);
    _puts("  (");
    _print_int(j);
    _puts(")\n\r");
    if ( (word1&1) ) {
      _puts("Lane sync: ");
      FMC228_ADC1_SCSR |= 0x00000003;
      j = 0;
      do {
        word1 = FMC228_ADC1_SCSR;
        j += 1;
      }
      while ( (word1&1) && j < 100000 );
    }
    _putch('[');
    _print_int(j);
    _putch(']');
    word1 = FMC228_ADC1_SYNC;
    for ( j=0; j<4; j++ ) {
      _putch(' ');
      _print_int((word1>>2)&0x3f);
      _putch('.');
      _print_int((word1&0x03));
      word1 >>= 8;
    }
    _puts("\n\r");
  }  
  return 0;
}

int cmd_setup(int argc,const char **argv) {
  int bit_mask = 0;

  if ( argc < 2 ) {
    return 1;
  }
  
  if ( _strcmp(argv[1],"mux0") == 0 ) {
    bit_mask |= bit_mux0;
  }
  if ( _strcmp(argv[1],"mux1") == 0 ) {
    bit_mask |= bit_mux1;
  }
  if ( _strcmp(argv[1],"lmk") == 0 ) {
    bit_mask |= bit_lmk;
  }
  if ( _strcmp(argv[1],"hmc") == 0 ) {
    bit_mask |= bit_hmc;
  }
  if ( _strcmp(argv[1],"adc0") == 0 ) {
    bit_mask |= bit_adc0;
  }
  if ( _strcmp(argv[1],"adc1") == 0 ) {
    bit_mask |= bit_adc1;
  }
  if ( _strcmp(argv[1],"all") == 0 ) {
    bit_mask = bit_mux0|bit_mux1|bit_lmk|bit_hmc|bit_adc0|bit_adc1;
  }
  return setup_everything(bit_mask);
}

int cmd_ip(int argc,const char **argv) {
  unsigned int ip, nm, gw;

  if ( argc == 1 ) {
    _puts("MAC address ");
    _print_mac_addr(IOBUS_GBE_MAC_ADDR_HIGH,IOBUS_GBE_MAC_ADDR_LOW);
    _puts("\r\nip addr ");
    _print_ip_addr(IOBUS_GBE_IP_ADDR);
    _puts(" netmask ");
    _print_ip_addr(IOBUS_GBE_NETMASK);
    _puts(" gw ");
    _print_ip_addr(IOBUS_GBE_GATEWAY);
    _puts("\n\r");
  }
  else if ( argc == 4 ) {
    if ( ( ip = _parse_ip(argv[1]) ) == 0 ) return 1;
    if ( ( nm = _parse_ip(argv[2]) ) == 0 ) return 1;
    if ( ( gw = _parse_ip(argv[3]) ) == 0 ) return 1;
    IOBUS_GBE_IP_ADDR = ip;
    IOBUS_GBE_NETMASK = nm;
    IOBUS_GBE_GATEWAY = gw;
  }
  else {
    return 1;
  }
  return 0;
}

int cmd_arp(int argc,const char **argv) {
  unsigned int ip;
  unsigned int csr;
  int i;
  if ( argc == 2 ) {
    ip = _parse_ip(argv[1]);
    if ( ip == 0 ) return 1;
    IOBUS_GBE_ARP_TARGET_IP = ip;
    IOBUS_GBE_ARP_CSR |= 0x80000000;
    IOBUS_GBE_ARP_CSR &= ~0x80000000;
  }
  else {
    _puts("arp csr = ");
    csr = IOBUS_GBE_ARP_CSR;
    _print_hex_long(csr);
    _puts("\n\r");
    for ( i=0; i<((csr>>8)&0xff); i++ ) {
      IOBUS_GBE_ARP_CSR = i;
      _print_int(i);
      _puts("   ");
      _print_ip_addr(IOBUS_GBE_ARP_TABLE_IP);
      _puts("   ");
      _print_mac_addr(IOBUS_GBE_ARP_TABLE_HA_HIGH,IOBUS_GBE_ARP_TABLE_HA_LOW);
      _puts("   ");
      _print_int(IOBUS_GBE_ARP_TABLE_REFCOUNT);
      _puts("\n\r");
    }
  }
  return 0;
}

void send_ntp(unsigned int daddr) {
  unsigned short sport;
  const unsigned short dport = 123;
  int i;

  struct s_ntpreq {
    unsigned char stuff;
    unsigned char pad[47];
  } *preq;

  sport = _nextport();
  IOBUS_GBE_TXUDP_DADDR = daddr;
  IOBUS_GBE_TXUDP_PORTS = (sport<<16) | dport;
  for ( i=0; i<sizeof(struct s_ntpreq)/4; i++ ) IOBUS_GBE_TXUDP_BUFFER[i] = 0;
  IOBUS_GBE_TXUDP_CSR = 0x80000000;    //  Clear checksum
  preq = (struct s_ntpreq *)IOBUS_GBE_TXUDP_BUFFER;
  preq->stuff = 8;
  IOBUS_GBE_TXUDP_CSR |= 0x40300000;   //  Send the packet.
}

int cmd_ntp(int argc,const char **argv) {
  if ( argc < 2 ) return 1;
  unsigned int daddr = _parse_ip(argv[1]);
  if ( daddr == 0 ) return 1;
  send_ntp(daddr);
  return 0;
}

int cmd_send(int argc,const char **argv) {
  unsigned int daddr;
  unsigned short dport;
  unsigned short sport;
  unsigned short crc;
  unsigned short x;
  unsigned char *p, y;
  const int len = 64;
  static int j = 0;
  int i;

  if ( argc < 3 ) {
    return 1;
  }
  daddr = _parse_ip(argv[1]);
  if ( daddr == 0 ) return 1;
  dport = _atoi(argv[2]);
  if ( dport == 0 ) return 1;

  sport = _nextport();
  IOBUS_GBE_TXUDP_DADDR = daddr;
  IOBUS_GBE_TXUDP_PORTS = (sport<<16) | dport;
  for ( i=0; i<len/4; i++ ) IOBUS_GBE_TXUDP_BUFFER[i] = 0;
  IOBUS_GBE_TXUDP_CSR = 0x80000000;    //  Clear checksum
  p = (unsigned char *)IOBUS_GBE_TXUDP_BUFFER;
  crc = 0xffff;
  for ( i=0; i<len; i++ ) {
    y = 'A' + (j++%26);
    *p++ = y;
    x = ((crc>>8)^y)&0xff;
    x ^= x>>4;
    crc = (crc<<8)^(x<<12)^(x<<5)^x;
  }
  IOBUS_GBE_TXUDP_CSR = (len<<16);
  IOBUS_GBE_TXUDP_CSR |= 0x40000000;
  _printf("  CRC = 0x%04x\n\r", crc );
  return 0;
}

int cmd_stream(int argc,const char **argv) {
  int iarg;
  unsigned int mask = 0xffffffff;
  unsigned short dport = 0;
  unsigned short sport = 0;
  unsigned int daddr = 0;
  if ( argc == 1 ) {
    _print_ip_addr(IOBUS_GBE_STREAMPKT_DADDR);
    sport = IOBUS_GBE_STREAMPKT_PORTS>>16;
    dport = IOBUS_GBE_STREAMPKT_PORTS&0xffff;
    _printf(" %d-->%d %s\n\r", sport, dport, (IOBUS_GBE_STREAMPKT_CSR&0x10000)?"on":"off" );
    return 0;
  }
  for ( iarg=1; iarg<argc; iarg++ ) {
    if ( argc > 1 ) {
      if ( _strcmp(argv[iarg],"on") == 0 ) {
        mask = 0x00010000;
      }
      else if ( _strcmp(argv[iarg],"off") == 0 ) {
        mask = 0;
      }
      else {
        daddr = _parse_ip(argv[iarg]);
        if ( daddr == 0 ) return 1;
        iarg += 1;
        if ( iarg < argc ) {
          dport = _atoi(argv[iarg]);
          if ( dport == 0 ) return 1;
          sport = _nextport();
        }
      }
    }
  }
  if ( daddr != 0 ) {
    IOBUS_GBE_STREAMPKT_DADDR = daddr;
  }
  if ( dport != 0 ) {
    IOBUS_GBE_STREAMPKT_PORTS = (sport<<16)|dport;
  }
  if ( mask != 0xffffffff ) {
    IOBUS_GBE_STREAMPKT_CSR = mask;
  }
  return 0;
}

int cmd_rspi(int argc,const char**argv) {
  unsigned int word, word1;
  unsigned int addr;
  int i;

  if ( _strcmp(argv[1],"lmk") == 0 ) {
    if ( argc > 2 ) {
      addr = _atoh(argv[2]);
      while ( (FMC228_LMKSPI&0x80000000) );
      FMC228_LMKSPI = 0x80000000 | (addr<<16);
      i = 0;
      while ( (FMC228_LMKSPI&0x80000000) ) i++;
      word = FMC228_LMKSPI;
      _puts("\r\nLMK04828 0x");
      _print_hex_short(addr);
      _puts(" = 0x");
      _print_hex_byte(word&0xff);
      _puts("  (");
      _print_int(i);
      _puts(")");
    }
  }
  else if ( _strcmp(argv[1],"hmc") == 0 ) {
    if ( argc > 2 ) {
      addr = _atoh(argv[2]);
      FMC228_HMCSPI = addr;
      for ( i=0; i<10; i++ );
      while ( (FMC228_HMCSPI&0x80000000) );
      FMC228_HMCSPI = addr;
      for ( i=0; i<10; i++ );
      i = 0;
      while ( (FMC228_HMCSPI&0x80000000) ) i++;
      word = FMC228_HMCSPI;
      _puts("\r\nHMC835 0x");
      _print_hex_byte(addr);
      _puts(" = 0x");
      _print_hex_long(word&0xffffff);
      _puts("  (");
      _print_int(i);
      _puts(")");
    }
  }
  else if ( _strcmp(argv[1],"adc0") == 0 ) {
    if ( argc > 2 ) {
      addr = _atoh(argv[2]);
      for ( i=0; (FMC228_ADC0SPI&0x80000000); i++ );
      word = 0x80000000 | (addr<<16);
      FMC228_ADC0SPI = word;
      i = 0;
      do {
        word1 = FMC228_ADC0SPI;
        i += 1;
      }
      while ( word1&0x80000000 );
      _puts("\r\nADC0 0x");
      _print_hex_short(addr);
      _puts(" = 0x");
      _print_hex_byte(word1&0xff);
      _puts("  (");
      _print_int(i);
      _puts(")");

    }
  }
  else if ( _strcmp(argv[1],"adc1") == 0 ) {
    if ( argc > 2 ) {
      addr = _atoh(argv[2]);
      for ( i=0; (FMC228_ADC1SPI&0x80000000); i++ );
      word = 0x80000000 | (addr<<16);
      FMC228_ADC1SPI = word;
      i = 0;
      do {
        word1 = FMC228_ADC1SPI;
        i += 1;
      }
      while ( word1&0x80000000 );
      _puts("\r\nADC0 0x");
      _print_hex_short(addr);
      _puts(" = 0x");
      _print_hex_byte(word1&0xff);
      _puts("  (");
      _print_int(i);
      _puts(")");
    }
  }

  return 0;
}

int cmd_wspi(int argc,const char **argv) {
  unsigned int word;
  unsigned int addr;
  unsigned int data;
  int i;

  if ( _strcmp(argv[1],"lmk") == 0 ) {
    if ( argc > 3 ) {
      addr = _atoh(argv[2])&0x7fff;
      data = _atoh(argv[3])&0xff;
      while ( (FMC228_LMKSPI&0x80000000) );
      FMC228_LMKSPI = 0x80000000 | (addr<<16);
      while ( (FMC228_LMKSPI&0x80000000) );
      word = FMC228_LMKSPI;
      _puts("\r\nLMK04828 0x");
      _print_hex_short(addr);
      _puts(" = 0x");
      _print_hex_byte(word&0xff);
      _puts(" <-- 0x");
      _print_hex_byte(data);
      FMC228_LMKSPI = (addr<<16)|(data<<8);
      i = 0;
      while ( (FMC228_LMKSPI&0x80000000) ) i++;
      _puts("  (");
      _print_int(i);
      _puts(")");
    }
  }
  else if ( _strcmp(argv[1],"adc0") == 0 ) {
    if ( argc > 3 ) {
      addr = _atoh(argv[2])&0xfff;
      data = _atoh(argv[3])&0xff;
      for ( i=0; (FMC228_ADC0SPI&0x80000000); i++ );
      word = addr<<16|(data<<8);
      FMC228_ADC0SPI = word;
      for ( i=0; (FMC228_ADC0SPI&0x80000000); i++ );
      _puts("\r\nADC0 0x");
      _print_hex_short(addr);
      _puts(" <-- 0x");
      _print_hex_byte(data);
      _puts("  (");
      _print_int(i);
      _puts(")");
    }
  }
  else if ( _strcmp(argv[1],"adc1") == 0 ) {
    if ( argc > 3 ) {
      addr = _atoh(argv[2])&0xfff;
      data = _atoh(argv[3])&0xff;
      for ( i=0; (FMC228_ADC1SPI&0x80000000); i++ );
      word = addr<<16|(data<<8);
      FMC228_ADC1SPI = word;
      for ( i=0; (FMC228_ADC1SPI&0x80000000); i++ );
      _puts("\r\nADC1 0x");
      _print_hex_short(addr);
      _puts(" <-- 0x");
      _print_hex_byte(data);
      _puts("  (");
      _print_int(i);
      _puts(")");
    }
  }
  return 0;
}

int cmd_count(int argc,const char **argv) {
  int i=0;
  int k=16;
  int j;
  unsigned int word0, word1;
  unsigned long long word;
  static const char *cntnam[] = { "  -  ", " trig", "  -  ", " idle",
                                  "  -  ", " sync", "evil0", "latch",
                                  "  run", "evil1", "start", " stop",
                                  "evil2", " halt", "count", "  -  " };
  char letter[2] = "\0\0";

  if ( argc > 1 ) {
    if ( _strcmp(argv[1],"reset") == 0 ) {
      AMC502_COUNT_LOW = 0;
      return 0;
    }
    j = _atoi(argv[1]);
    i = j;
    k = j+1;
  }
  for ( int j=i; j<k; j++ ) {
    word0 = AMC502_CSR;
    word0 &= 0xfffff0ff;
    word0 |= (j<<8);
    AMC502_CSR = word0;
    word0 = AMC502_COUNT_LOW;
    word1 = AMC502_COUNT_HIGH;
    word = word1;
    word <<= 32;
    word |= word0;
    *letter = j<10?'0'+j:'a'+j-10;
    _printf("%s [ %s ] : %l\n\r", cntnam[j], letter, word );
  }
  word0 = AMC502_TIMER_LOW;
  word1 = AMC502_TIMER_HIGH;
  word = word1;
  word <<= 32;
  word |= word0;
  _printf(" sync timer : %l\n\r", word );
  return 0;
}

int cmd_pll(int argc,const char **argv) {
  int i;
  struct s_pll_addr {
    unsigned char addr;
    const char *name;
  };
  static struct s_pll_addr regs[] = {
    { 0x08, "CLKOUT0 Reg 1 " },
    { 0x09, "CLKOUT0 Reg 2 " },
    { 0x0a, "CLKOUT1 Reg 1 " },
    { 0x0b, "CLKOUT1 Reg 2 " },
    { 0x14, "CLKFBOUT Reg 1" },
    { 0x15, "CLKFBOUT Reg 2" },
    { 0x16, "DIVCLK        " },
    { 0x18, "LockReg1      " },
    { 0x19, "LockReg2      " },
    { 0x1a, "LockReg3      " },
    { 0x28, "Power         " },
    { 0x4e, "FiltReg1      " },
    { 0x4f, "FiltReg2      " },
    { 0x00, NULL }
  };
  struct s_pll_addr *reg;
  unsigned int word;

  if ( argc > 1 && _strcmp(argv[1],"reset") == 0 ) {
    AMC502_CSR |= 0x02000000;
    while ( (AMC502_CSR&0x08000000) );
    AMC502_CSR &= ~0x02000000;
    i = 0;
    while ( ! (AMC502_CSR&0x08000000) ) i += 1;
    _printf("PLL locked after %d loops.\n\r", i );
    return 0;
  }

  _printf( "PLL is%s locked.\n\r", (AMC502_CSR&0x08000000)?"":" not" );
  _printf( "Addr  Name            Data\n\r");
  _printf( "----  --------------  ----\n\r");
  for ( reg=regs; reg->addr != 0x00; reg++ ) {
    AMC502_SLAVE_PLL = (reg->addr<<16);
    i = 0;
    do {
      word = AMC502_SLAVE_PLL;
    }
    while ( ! (word&0x80000000) && i++ < 100000 );
    _printf( " %02x   %13s  %04x\n\r", reg->addr, reg->name, word&0xffff );
  }
  return 0;
}

int cmd_bco(int argc,const char **argv) {
  if ( argc == 1 ) {
    _printf( "%04x%08x\n\r", AMC502_BCO_COUNTER_HI, AMC502_BCO_COUNTER_LO );
  }
  return 0;
}

int cmd_xarp(int argc,const char **argv) {
  unsigned int ip;
  unsigned int csr;
  int i;
  if ( argc == 2 ) {
    ip = _parse_ip(argv[1]);
    if ( ip == 0 ) return 1;
    IOBUS_XGBE_ARP_TARGET_IP = ip;
    IOBUS_XGBE_ARP_CSR = 0x80000000;
  }
  else {
    csr = IOBUS_XGBE_ARP_CSR;
    _puts("arp csr = ");
    _print_hex_long(csr);
    _puts("\n\r");
    for ( i=0; i<((csr>>8)&0xff); i++ ) {
      IOBUS_XGBE_ARP_CSR = i;
      
      _print_int(i);
      _puts("   ");
      _print_ip_addr(IOBUS_XGBE_ARP_TABLE_IP);
      _puts("   ");
      _print_mac_addr(IOBUS_XGBE_ARP_TABLE_HA_HIGH,IOBUS_XGBE_ARP_TABLE_HA_LOW);
      _puts("   ");
      _print_int(IOBUS_XGBE_ARP_TABLE_REFCOUNT);
      _puts("\n\r");
    }
  }
  return 0;
}

int cmd_xsend(int argc,const char **argv) {
  unsigned int daddr;
  unsigned short dport;
  unsigned short sport;
  unsigned short crc;
  unsigned short x;
  unsigned char *p, y;
  int len = 64;
  static int j = 0;
  int i, delay = 0;

  daddr = _parse_ip(argv[1]);
  if ( daddr == 0 ) return 1;
  dport = _atoi(argv[2]);
  if ( dport == 0 ) return 1;
  if ( argc > 3 ) {
    if ( _strcmp(argv[3],"wait") == 0 ) {
      delay = 1;
    }
    else {
      len = _atoi(argv[3]);
      if ( len <= 0 ) return 1;
      if ( argc > 4 ) {
        if ( _strcmp(argv[4],"wait") == 0 ) {
          delay = 1;
        }
        else {
          return 1;
        }
      }
    }
  }

  sport = _nextport();
  IOBUS_XGBE_TXUDP_DADDR = daddr;
  IOBUS_XGBE_TXUDP_PORTS = (sport<<16) | dport;
  for ( i=0; i<len/4; i++ ) IOBUS_XGBE_TXUDP_BUFFER[i] = 0;
  IOBUS_XGBE_TXUDP_CSR = 0x80000000;    //  Clear checksum
  p = (unsigned char *)IOBUS_XGBE_TXUDP_BUFFER;
  crc = 0xffff;
  for ( i=0; i<len; i++ ) {
    y = 'A' + (j++%26);
    *p++ = y;
    x = ((crc>>8)^y)&0xff;
    x ^= x>>4;
    crc = (crc<<8)^(x<<12)^(x<<5)^x;
  }
  if ( ! delay ) {
    IOBUS_XGBE_TXUDP_CSR = 0x40000000 | (len<<16);
  }
  else {
    IOBUS_XGBE_TXUDP_CSR = 0x20000000 | (len<<16);
  }
  _puts("  CRC = 0x");
  _print_hex_short(crc);
  _puts("\n\r");
  return 0;
}

int cmd_xbuf(int argc,const char **argv) {
  int i, ibuf, jbuf, kbuf;
  unsigned int word, ports, addr, last, n;
  const char *p;
  jbuf = 0;
  kbuf = 3;
  if ( argc > 1 ) {
    if ( _strcmp(argv[1],"free") == 0 ) {
      if ( argc > 2 ) {
        jbuf = _atoi(argv[2]);
        if ( jbuf < 0 || jbuf > 3 ) return 1;
        IOBUS_XGBE_RXUDP_CSR = (1<<jbuf);
        return 0;
      }
    }
    else {
      jbuf = kbuf = _atoi(argv[1]);
      if ( jbuf < 0 || jbuf > 3 ) return 1;
    }
  }
  for ( ibuf=jbuf; ibuf<=kbuf; ibuf++ ) {
    word = IOBUS_XGBE_RXUDP_CSR;
    _printf( "buffer %d: (%s)\n\r", ibuf, (word&(1<<ibuf))?"busy":"free" );
    _printf( "  src: ");
    _print_ip_addr(IOBUS_XGBE_RXUDP_BUFFER(ibuf)[508]);
    _printf( "\n\r  dst: ");
    _print_ip_addr(IOBUS_XGBE_RXUDP_BUFFER(ibuf)[509]);
    ports = IOBUS_XGBE_RXUDP_BUFFER(ibuf)[510];
    _printf( "\n\r  ports: %d --> %d\n\r", (ports>>16)&0xffff, ports&0xffff );
    n = IOBUS_XGBE_RXUDP_BUFFER(ibuf)[511]>>16;
    _printf( "  length: %d\n\r", n );
    addr = (unsigned int)IOBUS_XGBE_RXUDP_BUFFER(ibuf);
    last = n>64?addr+64:addr+n;
    while ( addr < last ) {
      _printf( "%x :", addr );
      for ( i=0; i<4; i++ ) {
        word = ((unsigned int *)addr)[i];
        _printf( " %08x", word );
      }
      _printf( "    ");
      p = (const char *)addr;
      for ( i=0; i<16; i++ ) {
        _putch(_isprint(*p)?*p++:'.');
      }
      _printf( "\n\r" );
      addr += 16;
    }
    if ( n > 64 ) {
      _printf( "  ...\n\r" );
    }
  }
  return 0;
}

int cmd_xip(int argc,const char **argv) {
  unsigned int ip, nm, gw;

  if ( argc == 1 ) {
    _puts("MAC address ");
    _print_mac_addr(IOBUS_XGBE_MAC_ADDR_HIGH,IOBUS_XGBE_MAC_ADDR_LOW);
    _puts("\n\rip addr ");
    _print_ip_addr(IOBUS_XGBE_IP_ADDR);
    _puts(" netmask ");
    _print_ip_addr(IOBUS_XGBE_NETMASK);
    _puts(" gw ");
    _print_ip_addr(IOBUS_XGBE_GATEWAY);
    _puts("\n\rRX packets: ");
    _print_int(IOBUS_XGBE_NRX);
    _puts("  ARP: ");
    _print_int(IOBUS_XGBE_NARP);
    _puts("  ICMP: ");
    _print_int(IOBUS_XGBE_NICMP);
    _puts("  UDP: ");
    _print_int(IOBUS_XGBE_NUDP);
    _puts("\n\r");
  }
  else if ( argc == 4 ) {
    if ( ( ip = _parse_ip(argv[1]) ) == 0 ) return 1;
    if ( ( nm = _parse_ip(argv[2]) ) == 0 ) return 1;
    if ( ( gw = _parse_ip(argv[3]) ) == 0 ) return 1;
    IOBUS_XGBE_IP_ADDR = ip;
    IOBUS_XGBE_NETMASK = nm;
    IOBUS_XGBE_GATEWAY = gw;
  }
  else {
    return 1;
  }
  return 0;
}

int cmd_xping(int argc,const char **argv) {
  unsigned int ip, timeout, count;
  int length;

  if ( ( ip = _parse_ip(argv[1]) ) == 0 ) return 1;
  length = 0x38;
  if ( argc > 2 ) {
    if ( ( length = _atoi(argv[2]) ) == 0 ) return 1;
  }
  IOBUS_XGBE_ICMPREQ_IP_ADDR = ip;
  IOBUS_XGBE_ICMPREQ_SEQUENCE = (_nextport()<<16) | 0x0001;
  IOBUS_XGBE_ICMPREQ_CSR = 0x80000000|length;
  timeout = 1000000;
  do {
    timeout -= 1;
    count = IOBUS_XGBE_ICMPREQ_TIMER;
  }
  while ( timeout > 0 && count == 0 );
  if ( timeout == 0 ) {
    _puts("timeout\n\r");
  }
  else {
    _printf("time = %d * 6.4 ns\n\r", count );
  }
  return 0;
}

void print_version() {
  __puts("\n\rPurdue debug monitor 1.00 - AMC502+XAUI+FMC228(1) version.\n\r");
  __puts("Built " __DATE__ " " __TIME__"\n\r\n\r");
}

int cmd_ver(int argc,const char **argv) {
  print_version();
  return 0;
}

int cmd_help(int,const char **);

struct s_cmd cmds[] = {
  { "time", "", cmd_time },
  { "date", "", cmd_date },
  { "poke", "<addr> <data>", cmd_poke },
  { "peek", "<addr>", cmd_peek },
  { "dump", "[<addr> [n]]", cmd_dump },
  { "nint", "", cmd_nint },
  { "freq", "", cmd_freq },
  { "ip", " [<addr> <netmask> <gateway>]", cmd_ip },
  { "arp", " [<addr>]", cmd_arp },
  { "ntp", " <addr>", cmd_ntp },
  { "send", " <addr> <port>", cmd_send },
  { "stream", " <addr> <port> [on|off]", cmd_stream },
  { "setup", "{mux0|mux1|lmk|hmc|adc0|adc1|all}", cmd_setup },
  { "count", "[<chan>]", cmd_count },
  { "pll", "", cmd_pll },
  { "rspi", "{lmk|hmc|adc0|adc1} <addr>", cmd_rspi },
  { "wspi", "{lmk|adc0|adc1} <addr> <data>", cmd_wspi },
  { "bco", "[reset|<value>]", cmd_bco },
  { "xarp", "", cmd_xarp },
  { "xip", "", cmd_xip },
  { "xping", "<addr>", cmd_xping },
  { "xsend", "<addr> <port>", cmd_xsend },
  { "xbuf", "[free] <n>", cmd_xbuf },
  { "ver", "", cmd_ver },
  { "help", "", cmd_help }
};

int cmd_help(int argc,const char **argv) {
  int i;
  for ( i=0; i<NCMD; i++ ) {
    _printf( "%s %s\n\r", cmds[i].cmd, cmds[i].help );
  }
  return 0;
}

int main() {
  int i, ierr;
  char *p, line[80];
  const char *args[MAXARG];
  int narg;

  init_platform();
  _init_kernel();

  microblaze_enable_interrupts();

  print_version();

  _puts("Ready...\n\r");

  do {
    _interrupt = 0;
    _puts("$ ");
    p = _gets(line,sizeof(line));
    _puts("\n\r");
    if ( p == NULL ) continue;
    if ( _interrupt ) continue;
    p = _token(line);
    narg = 0;
    while ( narg < MAXARG && p != NULL && p[0] != '-' && p[1] != '-' ) {
      args[narg++] = p;
      p = _token(NULL);
    }
    if ( narg == 0 ) continue;
    ierr = -1;
    for ( i=0; i<NCMD; i++ ) {
      if ( _strcmp(cmds[i].cmd,args[0]) == 0 ) {
        ierr = cmds[i].func(narg,args);
        break;
      }
    }
    if ( ierr != 0 ) {
      _printf("???\n\r");
    }
  }
  while ( 1 );

  cleanup_platform();
  return 0;
}
