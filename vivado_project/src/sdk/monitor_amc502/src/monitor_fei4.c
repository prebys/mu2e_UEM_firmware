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
#include "fei4.h"

typedef struct {
  unsigned int addr;
  char access_type; // bit[0]=1: read; bit[1]=1: write; bit[7]=1: data is delay time in 1us.
  unsigned int data;
  unsigned int por_default;
  const char* name;
} reg_with_name_t;

static int nchan = 0;

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
#define AMC502_FPCLKE_FREQ     (*(volatile unsigned int *)(0xc000008c))
#define AMC502_FREQ            ((volatile unsigned int *)(0xc0000080))

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

//
#define MAXARG 16
#define NCMD (sizeof(cmds)/sizeof(struct s_cmd))

extern unsigned int nint[];
extern const char *cint[];

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
  int h = (t/3600)%24;
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

  day = time/(24*60*60);
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
                             "   fpclkb", "clk100mhz", "  gmiiclk", "156.25mhz",
                             "   fpclke", "   fpclkg",
                             NULL };
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

int setup_everything() {
  unsigned char *p;
  int i, j;
  _puts("\r\nSet up 8V54816A clock MUX...");
  while ( (AMC502_I2C&0x80000000) );

  AMC502_I2C_WBUF[0] = 0;
  AMC502_I2C_WBUF[1] = 0;
  AMC502_I2C_WBUF[2] = 0x8f8e8840; // Port 8 is input (FPCLKE)
                                         // Port 9 is output (FPCLKF) <-- Port 8
                                         // Port 10 is output (FPCLKG) <-- Port 14 (FMCEXPC)
                                         // Port 11 is output (FPCLKH) <-- Port 15 (FMCEXPD)
  AMC502_I2C_WBUF[3] = 0x40404088; // Port 12 is output (FMCEXPA) mapped to port 8 (FPCLKE)
                                         // Port 13 is input (FMCEXPB)
                                         // Port 14 input (FMCEXPC)
                                         // Port 15 input (FMCEXPD)

  AMC502_I2C = 0x10b0;
  for ( j=0; j<20; j++ );
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

  return 0;
}

int cmd_setup(int argc,const char **argv) {
  int i, bit_mask = 0;
  unsigned char *p;
  const int bit_mux0 = 1;
  const int bit_mux1 = 2;

  const char *mux0_ports[] = {
    "TCLKA", "TCLKB", "TCLKC", "TCLKD",
    "PLLCLKA", "PLLCLKB", "PLLCLKC", "PLLCLKD",
    "FPCLKE", "FPCLKF", "FPCLKG", "FPCLKH",
    "FMCEXPA", "FMCEXPB", "FMCEXPC", "FMCEXPD"
   };
  const char *mux1_ports[] = {
    "FMCEXPA", "FMCEXPB", "FMCEXPC", "FMCEXPD",
    "PLLCLKA_OUT", "PLLCLKB_OUT", "PLLCLKC_OUT", "PLLCLKD_OUT",
    "FMC0_CLK0_M2C", "FMC0_CLK1_M2C", "FMC0_CLK2_BIDIR", "FMC0_CLK3_BIDIR",
    "FMC1_CLK0_M2C", "FMC1_CLK1_M2C", "FMC1_CLK2_BIDIR", "FMC1_CLK3_BIDIR"
  };

//
//  Mux0 port 8 (FPCLKE)
//    --> Mux0 port 9 (FPCLKF)
//    --> Mux0 port 14 (FMCEXPC)
//      --> Mux1 port 2
//        --> Mux1 port 1 (FMCEXPB)
//        --> Mux0 port 12 (FMCEXPD)
//          --> Mux0 port 11 (FPCLKH) 
//
  if ( argc < 2 ) {
    return 1;
  }
  
  if ( _strcmp(argv[1],"mux0") == 0 ) {
    bit_mask |= bit_mux0;
  }
  if ( _strcmp(argv[1],"mux1") == 0 ) {
    bit_mask |= bit_mux1;
  }
  if ( _strcmp(argv[1],"all") == 0 ) {
    return setup_everything();
  }

  if ( bit_mask&bit_mux0 ) {
    _printf("Setting up M-LVDS Crossbar-0\n\r" );
    while ( (AMC502_I2C&0x80000000) );
//  input port 0 (TCLKA)
//  input port 1 (TCLKB)
//  input port 2 (TCLKC)
//  input port 3 (TCLKD)
//  input port 4 (unused)
//  input port 5 (unused)
//  input port 6 (unused)
//  input port 7 (unused)
//  input port 8 (FPCLKE)
//  output port 9 <-- port 8 (FPCLKF)
//  output port 10 <-- port 12 (FMCEXPA)
//  output port 11 <-- port 15 (FMCEXPB)
//  input port 12 (FMCEXPA)
//  input port 13 (FMCEXPB)
//  output port 14 <-- port 8 (FMCEXPC)
//  input port 15 (FMCEXPD)
    AMC502_I2C_WBUF[0] = 0x00000000;
    AMC502_I2C_WBUF[1] = 0x00000000;
    AMC502_I2C_WBUF[2] = 0x8f8e8840;
    AMC502_I2C_WBUF[3] = 0x40404088;
    AMC502_I2C = 0x10b0;
    while ( (AMC502_I2C&0x80000000) );
    AMC502_I2C = 0x10b1;
    while ( (AMC502_I2C&0x80000000) );
    p = (unsigned char *)AMC502_I2C_RBUF;
    for ( i=0; i<16; i++ ) {
      _printf( " %02x", p[i] );
    }
    _printf("\n\r");
    for ( i=0; i<16; i++ ) {
      if ( (p[i]&0x80) ) {
        _printf( "    port %d (%s) <-- port %d (%s)\n\r",
                 i, mux0_ports[i], p[i]&0x0f, mux0_ports[p[i]&0x0f] );
      }
    }
  }
  if ( bit_mask&bit_mux1 ) {
    _printf("Setting up M-LVDS Crossbar-1\n\r" );
    while ( (AMC502_I2C&0x80000000) );
// output port 0 <-- port 12 (FMCEXPA)
// output port 1 <-- port 13 (FMCEXPB)
// input port 2 (FMCEXPC)
// output port 3 <-- port 2 (FMCEXPD)
// input port 4 (PLLCLKA_OUT from Quad PLL)
// input port 5 (PLLCLKB_OUT from Quad PLL)
// input port 6 (PLLCLKC_OUT from Quad PLL)
// input port 7 (PLLCLKD_OUT from Quad PLL)
// input port 8 (FMC0_CLK0_M2C from FMC 0)
// input port 9 (FMC0_CLK1_M2C from FMC 0)
// input port 10 (FMC0_CLK2_BIDIR from FMC 0)
// input port 11 (FMC0_CLK3_BIDIR from FMC 0)
// input port 12 (FMC1_CLK0_M2C from FMC 1)
// input port 13 (FMC1_CLK1_M2C from FMC 1)
// input port 14 (FMC1_CLK2_BIDIR from FMC 1)
// input port 15 (FMC1_CLK3_BIDIR from FMC 1)
    AMC502_I2C_WBUF[0] = 0x8d8c0040;
    AMC502_I2C_WBUF[1] = 0x00000000;
    AMC502_I2C_WBUF[2] = 0x00000000;
    AMC502_I2C_WBUF[3] = 0x00804040;
    AMC502_I2C = 0x10b2;
    while ( (AMC502_I2C&0x80000000) );
    AMC502_I2C = 0x10b3;
    while ( (AMC502_I2C&0x80000000) );
    p = (unsigned char *)AMC502_I2C_RBUF;
    for ( i=0; i<16; i++ ) {
      _printf( " %02x", p[i] );
    }
    _printf("\n\r");
    for ( i=0; i<16; i++ ) {
      if ( (p[i]&0x80) ) {
        _printf( "    port %d (%s) <-- port %d (%s)\n\r",
                 i, mux1_ports[i], p[i]&0x0f, mux1_ports[p[i]&0x0f] );
      }
    }
  }

  return 0;
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

int cmd_xarp(int argc,const char **argv) {
  unsigned int ip;
  unsigned int csr;
  int i;
  if ( argc == 2 ) {
    ip = _parse_ip(argv[1]);
    if ( ip == 0 ) return 1;
    IOBUS_XGBE_ARP_TARGET_IP = ip;
    IOBUS_XGBE_ARP_CSR = 0x80000000;
//    IOBUS_XGBE_ARP_CSR &= ~0x80000000;
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

int cmd_wreg(int argc,const char **argv) {
  if ( argc < 4 ) return 1;
  int chipid = 0x08;
  int chan = _atoi(argv[1]);
  if ( *(argv[1]+_strlen(argv[1])-1) == '.' ) {
    chipid = (chan%2)+1;
  }
  int addr = _atoi(argv[2]);
  int data = _atoh(argv[3]);
  if ( data > 0xffff || data < 0 ) return 1;
  if ( addr > 0x3ff || addr < 0 ) return 1;
  if ( chan < 0 || chan >= nchan ) return 1;
//  1000 10cc ccaa aaaa dddd dddd dddd dddd
  unsigned int word = 0x88000000 | (chipid<<22) | ((addr&0x3f)<<16) | (data&0xffff);
  while ( (FEI4_CMD(chan)&0x80000000) );

  _printf("  0x%08x <-- %08x\n\r", (unsigned int)(&FEI4_CMD(chan)), word );
  FEI4_CMD(chan) = word;
  while ( (FEI4_CMD(chan)&0x80000000) );
  return 0;
}

int cmd_sync(int argc,const char **argv) {
  int i, j;
  unsigned int word, last;
  if ( argc < 2 ) return 1;
  int chan = _atoi(argv[1]);
  unsigned int bits[2] = { 0, 0 };
  for ( i=0; i<4*64; i++ ) {
    last = FEI4_IDELAY;
    FEI4_CSR |= 0x8000;
    FEI4_IDELAY = 0x90000000 | chan;
    while ( (FEI4_IDELAY&0x80000000) );
    FEI4_CSR &= ~0x8000;
    for ( j=0; j<10000; j++ );
    word = FEI4_IDELAY;
    if ( ((last+0x10000)&0x001f0000) != (word&0x001f0000) ) {
      _printf("Skipped: %08x --> %08x\n\r", last, word );
    }
    if ( ((word>>4)&0xfff) != 0 || (FEI4_LINKSYNC&(1<<chan)) == 0 ) {
      bits[(word>>21)&0x01] |= (1<<(word>>16)&0x1f);
    }
  }
  for ( i=0; i<64; i++ ) {
    if ( bits[i/32]&(1<<(i%32)) ) {
      _putch('X');
    }
    else {
      _putch('_');
    }
  }
  _printf("\n\r");
  return 0;
}

int cmd_link(int argc,const char **argv) {
  int chan;
  if ( argc < 2 ) {
    _printf( "Ch.  %10s %10s %10s %10s %10s\n\r",
             "alignment", "decoder", "SOF", "EOF", "bad frame" );
    for ( chan=0; chan<nchan; chan++ ) {
      _printf( "%3d  %9d  %9d  %9d  %9d  %9d\n\r", chan,
               FEI4_DECODER_EACNT(chan),
               FEI4_DECODER_EDCNT(chan),
               FEI4_DECODER_SFCNT(chan),
               FEI4_DECODER_EFCNT(chan),
               FEI4_DECODER_BFCNT(chan) );
    }
    return 0;
  }
  if ( _strcmp(argv[1],"clr") == 0 ) {
    for ( chan=0; chan<nchan; chan++ ) {
      FEI4_CHAN_CSR(chan) |= 0x20000000;
    }
    return 0;
  }
  chan = _atoi(argv[1]);
  if ( chan < 0 || chan >= nchan ) return 1;
  if ( argc > 2 ) {
    if ( _strcmp(argv[2],"clr") == 0 ) {
      FEI4_CHAN_CSR(chan) |= 0x20000000;
    }
  }
  _printf("Channel %d\n\r", chan );
  _printf("  alignment : %d\n\r", FEI4_DECODER_EACNT(chan) );
  _printf("    decoder : %d\n\r", FEI4_DECODER_EDCNT(chan) );
  _printf("        SOF : %d\n\r", FEI4_DECODER_SFCNT(chan) );
  _printf("        EOF : %d\n\r", FEI4_DECODER_EFCNT(chan) );
  _printf("  bad frame : %d\n\r", FEI4_DECODER_BFCNT(chan) );
  return 0;
}

int cmd_rdreg(int argc,const char **argv) {
  int i;
  unsigned int word;
  int chipid = 0x08;
  int chan = _atoi(argv[1]);
  if ( *(argv[1]+_strlen(argv[1])-1) == '.' ) {
    chipid = (chan%2)+1;
  }
  int addr = _atoi(argv[2]);
  if ( addr > 0x3ff || addr < 0 ) return 1;
  if ( chan < 0 || chan >= nchan ) return 1;

  FEI4_CHAN_CSR(chan) |= 0x80000000;

//  1000 01cc ccaa aaaa 0000 0000 0000 0000
  word = 0x84000000 | (chipid<<22) | ((addr&0x3f)<<16);
  while ( (FEI4_CMD(chan)&0x80000000) );
  _printf("  0x%08x <-- %08x\n\r", (unsigned int)(&FEI4_CMD(chan)), word );
  FEI4_CMD(chan) = word;
  while ( (FEI4_CMD(chan)&0x80000000) );
  i = 0;
  do {
    word = FEI4_RDREG(chan);
    i += 1;
  }
  while ( (word&0xc0000000) && i < TIMEOUT );
  if ( (word&0x30000000) ) {
    _printf("no data\n\r");
    return 0;
  }
  _printf("Reg %d = %04x  loop %d\n\r", word>>16, word&0xffff, i );

  return 0;
}

int cmd_conf(int argc,const char **argv) {
  if ( argc < 2 ) return 1;
  int chan = _atoi(argv[1]);
//  1010 1010 0000 0111 0000 0000 0000 0000
  unsigned int word = 0xaa070000;
  while ( (FEI4_CMD(chan)&0x80000000) ) {
    if ( _interrupt ) return 0;
  }

  _printf("  0x%08x <-- %08x\n\r", (unsigned int)(&FEI4_CMD(chan)), word );
  FEI4_CMD(chan) = word;

  while ( (FEI4_CMD(chan)&0x80000000) ) {
    if ( _interrupt ) return 0;
  }
  return 0;
}

int cmd_run(int argc,const char **argv) {
  if ( argc < 2 ) return 1;
  int chan = _atoi(argv[1]);
//  1010 1010 0011 1000 0000 0000 0000 0000
  unsigned int word = 0xaa380000;
  while ( (FEI4_CMD(chan)&0x80000000) );

  _printf("  0x%08x <-- %08x\n\r", (unsigned int)(&FEI4_CMD(chan)), word );
  FEI4_CMD(chan) = word;

  while ( (FEI4_CMD(chan)&0x80000000) );
  return 0;
}

int cmd_trig(int argc,const char **argv) {
  if ( argc < 2 ) return 1;
  int chan = _atoi(argv[1]);
  if ( chan < 0 || chan >= nchan ) return 1;
//  1111 xxxx xxxx xxxx xxxx xxxx xxxx xxxx
  unsigned int word = 0xbc000000;
  while ( (FEI4_CMD(chan)&0x80000000) );

  _printf("  0x%08x <-- %08x\n\r", (unsigned int)(&FEI4_CMD(chan)), word );
  FEI4_CMD(chan) = word;
  while ( (FEI4_CMD(chan)&0x80000000) );
  return 0;
}

int cmd_ecr(int argc,const char **argv) {
  if ( argc < 2 ) return 1;
  int chan = _atoi(argv[1]);
  if ( chan < 0 || chan >= nchan ) return 1;
//  1101 xxxx xxxx xxxx xxxx xxxx xxxx xxxx
  unsigned int word = 0xb4000000;
  while ( (FEI4_CMD(chan)&0x80000000) );

  _printf("  0x%08x <-- %08x\n\r", (unsigned int)(&FEI4_CMD(chan)), word );
  FEI4_CMD(chan) = word;
  while ( (FEI4_CMD(chan)&0x80000000) );
  return 0;
}

int cmd_bcr(int argc,const char **argv) {
  if ( argc < 2 ) return 1;
  int chan = _atoi(argv[1]);
  if ( chan < 0 || chan >= nchan ) return 1;
//  1100 xxxx xxxx xxxx xxxx xxxx xxxx xxxx
  unsigned int word = 0xb0000000;
  if ( argc > 2 ) {
    word |= 0x10000;
    word |= _atoi(argv[2]);
  }
  while ( (FEI4_CMD(chan)&0x80000000) );

  _printf("  0x%08x <-- %08x\n\r", (unsigned int)(&FEI4_CMD(chan)), word );
  FEI4_CMD(chan) = word;
  while ( (FEI4_CMD(chan)&0x80000000) );
  return 0;
}

int cmd_cal(int argc,const char **argv) {
  if ( argc < 2 ) return 1;
  int chan = _atoi(argv[1]);
  if ( chan < 0 || chan >= nchan ) return 1;
//  1110 xxxx xxxx xxxx xxxx xxxx xxxx xxxx
  unsigned int word = 0xb8000000;
  while ( (FEI4_CMD(chan)&0x80000000) );

  _printf("  0x%08x <-- %08x\n\r", (unsigned int)(&FEI4_CMD(chan)), word );
  FEI4_CMD(chan) = word;
  while ( (FEI4_CMD(chan)&0x80000000) );
  return 0;
}

int cmd_wfe(int argc,const char **argv) {
  if ( argc < 2 ) return 1;
  int chan = _atoi(argv[1]);
  if ( chan < 0 || chan >= nchan ) return 1;
//  0100 1000 0000 00xx xxxx xxxx xxxx xxxx
  unsigned int word = 0xd2000000;
  while ( (FEI4_CMD(chan)&0x80000000) );

  _printf("  0x%08x <-- %08x\n\r", (unsigned int)(&FEI4_CMD(chan)), word );
  FEI4_CMD(chan) = word;
  while ( (FEI4_CMD(chan)&0x80000000) );
  return 0;
}

int cmd_gr(int argc,const char **argv) {
  if ( argc < 2 ) return 1;
  int chan = _atoi(argv[1]);
  if ( chan < 0 || chan >= nchan ) return 1;
//  1010 0010 0000 0000 0000 0000 0000 0000
  unsigned int word = 0xa2000000;
  while ( (FEI4_CMD(chan)&0x80000000) );
  _printf("  0x%08x <-- %08x\n\r", (unsigned int)(&FEI4_CMD(chan)), word );
  FEI4_CMD(chan) = word;

  while ( (FEI4_CMD(chan)&0x80000000) );
  return 0;
}

int cmd_gp(int argc,const char **argv) {
  if ( argc < 2 ) return 1;
  int chan = _atoi(argv[1]);
  int width = 1;
  if ( argc > 2 ) width = _atoi(argv[2]);
  if ( chan < 0 || chan >= nchan ) return 1;
//  1010 0110 0000 0000 0000 0000 0000 0000
  unsigned int word = 0xa6000000 | ((width&0x3f)<<16);
  while ( (FEI4_CMD(chan)&0x80000000) );
  _printf("  0x%08x <-- %08x\n\r", (unsigned int)(&FEI4_CMD(chan)), word );
  FEI4_CMD(chan) = word;

  while ( (FEI4_CMD(chan)&0x80000000) );
  return 0;
}

int cmd_spy(int argc,const char **argv) {
  enum frame_state { idle, frame, srec, drec, vrec, arec };
  unsigned int word;
  unsigned short code;
  unsigned int rec;
  enum frame_state state = idle;
  enum frame_state last_state = idle;
  int count = 0;
  if ( argc == 1 ) {
    _printf("spy fifo: ");
    if ( (FEI4_SPY_FIFO_CSR&0x10000000) ) {
      _printf("empty\n\r");
    }
    if ( (FEI4_SPY_FIFO_CSR&0x20000000) ) {
      _printf("full\n\r");
    }
    if ( (FEI4_SPY_FIFO_CSR&0x40000000) ) {
      _printf("valid\n\r");
    }
  }
  else if ( _strcmp(argv[1],"reset") == 0 ) {
    FEI4_SPY_FIFO_CSR |= 0x80000000;
    FEI4_SPY_FIFO_CSR &= ~0x80000000;
  }
  else if ( _strcmp(argv[1],"fifo") == 0 ) {
    _printf("spy fifo:\n\r");
    while ( (FEI4_SPY_FIFO_CSR&0x40000000) && ! _interrupt ) {
      code = FEI4_SPY_FIFO_DATA&0x3ff;
      _printf("  %04x", code );
      switch ( code ) {
        case 0x1fc :
          state = frame;
          _printf(" : SOF");
          break;
        case 0x1bc :
          state = idle;
          _printf(" : EOF");
          break;
        default :
          if ( state == frame ) {
          switch ( code ) {
            case 0xef :
              _printf(" : SR");
              last_state = state;
              state = srec;
              count = 0;
              break;
            case 0xec :
              state = vrec;
              _printf(" : VR");
              count = 0;
              break;
            case 0xea :
              state = arec;
              _printf(" : AR");
              count = 0;
              break;
            case 0xe9 :
              state = drec;
              _printf(" : DH");
              count = 0;
              break;
            default :
              state = idle;
              break;
          }
        }
        else if ( state == srec ) {
          count += 1;
          if ( count == 1 ) {
            rec = (code&0xff) << 8;
          }
          else if ( count == 2 ) {
            rec |= (code&0xff);
            _printf(" : srec(%d) = %d", (rec>>10)&0x3f, rec&0x3ff );
            state = last_state;
          }
        }
        else if ( state == arec ) {
          count += 1;
          if ( count == 1 ) {
            rec = (code&0xff) << 8;
          }
          else if ( count == 2 ) {
            rec |= (code&0xff);
            if ( (rec&0x8000) ) {
              _printf(" : SR addr = %d", rec&0x7fff );
            }
            else {
              _printf(" : GR addr = %d", rec&0x7fff );
            }
            state = frame;
          }
        }
        else if ( state == vrec ) {
          count += 1;
          if ( count == 1 ) {
            rec = (code&0xff) << 8;
          }
          else if ( count == 2 ) {
            rec |= (code&0xff);
            _printf(" : value = 0x%04x", rec );
            state = frame;
          }
        }
        else if ( state == drec ) {
          count += 1;
          if ( count == 1 ) {
            rec = (code&0xff) << 8;
          }
          else if ( count == 2 ) {
            rec |= (code&0xff);
            _puts(" : ");
            if ( (rec&0x8000) ) {
              _putch('E');
            }
            else {
              _putch(' ');
            }
            _puts(" lv1ID = ");
            _print_int((rec>>10)&0x1f);
            _puts(" bcID = ");
            _print_int(rec&0x3ff);
          }
          else if ( (count%3) == 0 ) {
            if ( code == 0xef ) {
              _puts(" : SR");
              last_state = state;
              state = srec;
              count = 0;
            }
            else {
              rec = (code&0xff)<<16;
            }
          }
          else if ( (count%3) == 1 ) {
            rec |= (code&0xff)<<8;
          }
          else if ( (count%3) == 2 ) {
            rec |= (code&0xff);
            _puts(" : column = ");
            _print_int((rec>>17)&0x7f);
            _puts(", row = ");
            _print_int((rec>>8)&0x1ff);
            _puts(", Tot1 = ");
            _print_int((rec>>4)&0xf);
            _puts(", Tot2 = ");
            _print_int(rec&0xf);
          }
        }
      }
      _printf("\n\r");
    }
  }
  else {
    word = FEI4_SPY_FIFO_CSR;
    word &= 0xfffffff0;
    word |= _atoi(argv[1]);
    FEI4_SPY_FIFO_CSR = word;
  }
  return 0;
}

const char *srec_code[] = { "BCID counter error",                        // 0
                            "Hamming code error in word 0",
                            "Hamming code error in word 1",
                            "Hamming code error in word 2",
                            "L1_in counter error",                       // 4
                            "L1 request counter error",
                            "L1 register error",
                            "L1 trigger ID error",
                            "readout processor error",                   // 8
                            "Fifo_Full flag pulsed",
                            "HitOr bus pulsed",
                            "",
                            "",
                            "",
                            "BC(2..0) & L1A(6..0)",                     // 14
                            "Skipped trigger counter",
                            "Truncated event flag/counter",             // 16
                            "",
                            "",
                            "",
                            "",
                            "Reset* RA2b pulsed",                       // 21
                            "PLL clock phase faster than reference",
                            "Reference clock phase faster than PLL",
                            "Triple redundant mismatch",
                            "Write register data error",
                            "Address error",
                            "Other command decoder error",              // 27
                            "Bit flip detected in command decoder input",
                            "SEU detected in command decoder",
                            "Data bus address error",
                            "Triple redundant mismatch" };              // 31

int cmd_srec(int argc,const char **argv) {
  int chan, i;
  if ( argc < 2 ) return 1;
  chan = _atoi(argv[1]);
  for ( i=0; i<16; i++ ) {
    if ( *srec_code[2*i] != '\0' ) {
      _printf("%s : ",srec_code[2*i]);
      if ( (FEI4_SREC(chan,i)&0x8000) ) {
        _printf("--");
      }
      else {
        _printf("%d",FEI4_SREC(chan,i)&0xffff);
      }
    }
    if ( *srec_code[2*i+1] != '\0' ) {
      _printf("\n\r");
      _printf("%s : ",srec_code[2*i+1]);
      if ( (FEI4_SREC(chan,i)&0x80000000) ) {
        _printf("--");
      }
      else {
        _printf("%d",FEI4_SREC(chan,i)>>16);
      }
    }
    _printf("\n\r");
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

void print_version() {
  __puts("\n\rPurdue debug monitor 1.00 - AMC502+XAUI+FE-I4b(0) version.\n\r");
  __puts("Built " __DATE__ " " __TIME__);
  _printf("\n\rConfigured with %d channels.\n\r\n\r", nchan );
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
  { "count", "[<chan>|reset]", cmd_count },
  { "pll", "[reset]", cmd_pll },
  { "ip", " [<addr> <netmask> <gateway>]", cmd_ip },
  { "arp", " [<addr>]", cmd_arp },
  { "ntp", " <addr>", cmd_ntp },
  { "send", " <addr> <port>", cmd_send },
  { "stream", " <addr> <port> [on|off]", cmd_stream },
  { "setup", "{mux0|mux1|all}", cmd_setup },
  { "xarp", "", cmd_xarp },
  { "xip", "", cmd_xip },
  { "xping", "<addr>", cmd_xping },
  { "xsend", "<addr> <port>", cmd_xsend },
  { "xbuf", "[free] <n>", cmd_xbuf },
  { "wreg", "<chan>[.] <addr> <data>", cmd_wreg },
  { "rdreg", "<chan>[.] <addr>", cmd_rdreg },
  { "sync", "<chan>", cmd_sync },
  { "link", "[<chan>] [clr]", cmd_link },
  { "spy", "[reset|fifo|<chan>]", cmd_spy },
  { "conf", "<chan>", cmd_conf },
  { "run", "<chan>", cmd_run },
  { "trig", "<chan>", cmd_trig },
  { "count", "[<chan>]", cmd_count },
  { "ecr", "<chan>", cmd_ecr },
  { "bcr", "<chan> [???]", cmd_bcr },
  { "cal", "<chan>", cmd_cal },
  { "wfe", "<chan>", cmd_wfe },
  { "gr", "<chan>", cmd_gr },
  { "gp", "<chan> [<width>]", cmd_gp },
  { "srec", "<chan>", cmd_srec },
  { "bco", "", cmd_bco },
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

  nchan = (FEI4_CSR&0x07)*2;

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
