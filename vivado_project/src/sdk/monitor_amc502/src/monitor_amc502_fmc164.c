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

#define AMC502_I2C_WBUF        ((volatile unsigned int *)(0xc0000100))
#define AMC502_I2C_RBUF        ((volatile unsigned int *)(0xc0000200))
#define AMC502_FPCLKE_FREQ     (*(volatile unsigned int *)(0xc000008c))
#define AMC502_FREQ            ((volatile unsigned int *)(0xc0000080))

#define FMC164_CHA_PLL         (*(volatile unsigned int *)(0xce000008))
#define FMC164_CHAB_DATA       (*(volatile unsigned int *)(0xce000010))

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
                             "   fpclkb", "clk100mhz", "  gmiiclk", " chac_clk",
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

int cmd_fmc164(int argc,const char **argv) {
  int i, j;
  unsigned char *rbuf, *wbuf;
  unsigned int word, mv, reg[4];
  int t;
  int ga = 0;
  const char *label[] = { "1.8V digital",
                          "1.8V analog",
                          "3.3V analog",
                          "VADJ",
                          "3.3V digital clock",
                          "3.3V analog clock",
                          "V_CP",
                          "1.8V analog clock" };

  if ( argc > 1 ) ga = _atoi(argv[1]);
  wbuf = (unsigned char *)AMC502_I2C_WBUF;
  rbuf = (unsigned char *)AMC502_I2C_RBUF;
  while ( (AMC502_I2C&0x80000000) );

  for ( i=0; i<4; i++ ) {
    wbuf[0] = i;
    AMC502_I2C = 0x0178|(ga<<1);   // Address CPLD register 3
    while ( (AMC502_I2C&0x80000000) );
    AMC502_I2C = 0x0179|(ga<<1);   // Read CPLD register 3
    while ( (AMC502_I2C&0x80000000) );
    reg[i] = rbuf[0];
  }
  _printf( "FMC164 CPLD = %02x %02x %02x %02x\n\r", 
           reg[0], reg[1], reg[2], reg[3] );

  for ( i=0; i<8; i++ ) {
    *AMC502_I2C_WBUF = 0x00200000|(1<<(i+8));
    AMC502_I2C = 0x35e;
    while ( (AMC502_I2C&0x80000000) );
 
    *AMC502_I2C_WBUF = 0x00000001;
    AMC502_I2C = 0x15e;
    while ( (AMC502_I2C&0x80000000) );

    AMC502_I2C = 0x025f;
    while ( (AMC502_I2C&0x80000000) );

    AMC502_I2C = 0x025f;
    while ( (AMC502_I2C&0x80000000) );

    word = rbuf[0];
    word <<= 8;
    word |= rbuf[1];
    j = (word>>12)&0x0f;
    mv = (word&0xfff)*2500;
    if ( j>=2 && j<=5 ) mv *= 2;
    if ( j == 6 ) {
      mv *= 391;
      mv /= 125;     //  *= 3.128
    }
    mv /= 4096;
    _printf( "  [%d] %s = %d.%d V (%x)\n\r", j, label[j], mv/1000, mv%1000, word );
  }
  *AMC502_I2C_WBUF = 0x00a00000;
  AMC502_I2C = 0x35e;
  while ( (AMC502_I2C&0x80000000) );

  *AMC502_I2C_WBUF = 0x00000002;
  AMC502_I2C = 0x15e;
  while ( (AMC502_I2C&0x80000000) );

  AMC502_I2C = 0x025f;
  while ( (AMC502_I2C&0x80000000) );

  AMC502_I2C = 0x025f;
  while ( (AMC502_I2C&0x80000000) );

  word = (*AMC502_I2C_RBUF&0xff)<<8|((*AMC502_I2C_RBUF&0xff00)>>8);
  j = (word>>12)&0x0f;
  t = word&0xfff;
  if ( (t&0x800) ) {
    t = -((4096-(t&0x7ff)))*25;
  }
  else {
    t *= 25;
  }
  _printf( "  [%d] Temperature = %d.%d deg C (%x)\n\r", j, t/100, t%100, word );
  return 0;
}

void write_ad9517(int addr,int data) {
  while ( (AMC502_I2C&0x80000000) );
  *AMC502_I2C_WBUF = 0x00000004|(data<<8);    //  Bits 7..0
  AMC502_I2C = 0x278;

  while ( (AMC502_I2C&0x80000000) );
  *AMC502_I2C_WBUF = 0x00000005|((addr&0xff)<<8);    //  Bits 15..8
  AMC502_I2C = 0x278;

  while ( (AMC502_I2C&0x80000000) );
  *AMC502_I2C_WBUF = 0x00000006|(((addr>>8)&0xff)<<8);    //  Bits 23..16
  AMC502_I2C = 0x278;

  while ( (AMC502_I2C&0x80000000) );
  *AMC502_I2C_WBUF = 0x00000107;    //  SPI cycle on ad9517
  AMC502_I2C = 0x278;

}

int read_ad9517(int addr) {
  while ( (AMC502_I2C&0x80000000) );
  *AMC502_I2C_WBUF = 0x00000004;
  AMC502_I2C = 0x278;

  while ( (AMC502_I2C&0x80000000) );
  *AMC502_I2C_WBUF = 0x00000005|((addr&0xff)<<8);    //  Bits 15..8
  AMC502_I2C = 0x278;

  while ( (AMC502_I2C&0x80000000) );
  *AMC502_I2C_WBUF = 0x00008006|(((addr>>8)&0xff)<<8);    //  Bits 23..16
  AMC502_I2C = 0x278;

  while ( (AMC502_I2C&0x80000000) );
  *AMC502_I2C_WBUF = 0x00000107;    //  SPI cycle on ad9517
  AMC502_I2C = 0x278;

  while ( (AMC502_I2C&0x80000000) );
  *AMC502_I2C_WBUF = 0x0000000f;
  AMC502_I2C = 0x178;
  while ( (AMC502_I2C&0x80000000) );

  AMC502_I2C = 0x179;
  while ( (AMC502_I2C&0x80000000) );

  return (*AMC502_I2C_RBUF)&0xff;

}

int read_ads42lb69(int mask,int addr) {
  while ( (AMC502_I2C&0x80000000) );
  *AMC502_I2C_WBUF = 0x00000004;
  AMC502_I2C = 0x278;

  while ( (AMC502_I2C&0x80000000) );
  *AMC502_I2C_WBUF = 0x00008005|((addr&0x3f)<<8);  //  Bits 15..8
  AMC502_I2C = 0x278;

  while ( (AMC502_I2C&0x80000000) );
  *AMC502_I2C_WBUF = 0x00000006;              //  Bits 23..16
  AMC502_I2C = 0x278;

  while ( (AMC502_I2C&0x80000000) );
  *AMC502_I2C_WBUF = 0x00000007|(mask<<8);    //  SPI cycle on ads42lb69
  AMC502_I2C = 0x278;

  while ( (AMC502_I2C&0x80000000) );
  *AMC502_I2C_WBUF = 0x0000000f;
  AMC502_I2C = 0x178;
  while ( (AMC502_I2C&0x80000000) );

  AMC502_I2C = 0x179;
  while ( (AMC502_I2C&0x80000000) );

  return (*AMC502_I2C_RBUF)&0xff;

}

void write_ads42lb69(int mask,int addr,int data) {
  while ( (AMC502_I2C&0x80000000) );
  *AMC502_I2C_WBUF = 0x00000004|(data<<8);    //  Bits 7..0
  AMC502_I2C = 0x278;

  while ( (AMC502_I2C&0x80000000) );
  *AMC502_I2C_WBUF = 0x00000005|((addr&0x3f)<<8);    //  Bits 15..8
  AMC502_I2C = 0x278;

  while ( (AMC502_I2C&0x80000000) );
  *AMC502_I2C_WBUF = 0x00000006;    //  Bits 23..16
  AMC502_I2C = 0x278;

  while ( (AMC502_I2C&0x80000000) );
  *AMC502_I2C_WBUF = 0x00000007|(mask<<8);    //  SPI cycle on ads42lb69
  AMC502_I2C = 0x278;

}

int cmd_wspi(int argc,const char **argv) {
  int a, d;
  if ( argc < 4 ) return 1;
  a = _atoh(argv[2]);
  d = _atoh(argv[3])&0xff;
  if ( _strcmp(argv[1],"ad9517") == 0 ) {
    write_ad9517(a,d);
    _printf("ad9517(%03x) <-- %02x\n\r", a, d );
    return 0;
  }
  else if ( _strcmp(argv[1],"adc0") == 0 ) {
    write_ads42lb69(0x04,a,d);
    _printf("ads42lb69_0(%03x) <-- %02x\n\r", a, d );
    return 0;
  }
  else if ( _strcmp(argv[1],"adc1") == 0 ) {
    write_ads42lb69(0x10,a,d);
    _printf("ads42lb69_1(%03x) <-- %02x\n\r", a, d );
    return 0;
  }
  else if ( _strcmp(argv[1],"adc") == 0 ) {
    write_ads42lb69(0x14,a,d);
    _printf("ads42lb69(%03x) <-- %02x\n\r", a, d );
    return 0;
  }
  return 1;
}

int cmd_rspi(int argc,const char **argv) {
  int a, d;
  if ( argc < 3 ) return 1;
  if ( _strcmp(argv[1],"ad9517") == 0 ) {
    a = _atoh(argv[2]);
    d = read_ad9517(a);
    _printf("ad9517(%03x) = %02x\n\r", a, d );
    return 0;
  }
  else if ( _strcmp(argv[1],"adc0") == 0 ) {
    a = _atoh(argv[2]);
    d = read_ads42lb69(0x04,a);
    _printf("ads42lb69_0(%03x) = %02x\n\r", a, d );
  }
  else if ( _strcmp(argv[1],"adc1") == 0 ) {
    a = _atoh(argv[2]);
    d = read_ads42lb69(0x10,a);
    _printf("ads42lb69_1(%03x) = %02x\n\r", a, d );
  }
  return 1;
}

int get_ad9517_pll(float f,struct s_ad9517 *p) {
  const float ref_freq = 100.0;
  const float vco_max = 1270.0;
  const float vco_min = 1180.0;
  float fpd, ft, t, mvf;
  int rem, n;
  
  p->r = (int)(ref_freq/10.0);
  if ( (p->r&0xffffc000) ) return 1;
  fpd = ref_freq/p->r;
  for ( p->rd=1; p->rd<32; p->rd++ ) {
    ft = f*p->rd;
    n = ft/fpd;
    ft = n*fpd;
    if ( ft <= vco_max && ft >= vco_min ) {
      for ( p->p=2; p->p<32; p->p<<=1 ) {
        if ( ft/p->p > 300.0 ) continue;
        t = (float)n/(float)p->p;
        p->b = (int)t;
        if ( p->b < 2 || (p->b&0xffffe000) ) continue;
        p->a = n - (p->p*p->b);
        if ( p->a > p->b || (p->a&0xffffffc0) || p->a<0 ) continue;
        t = ft;
        switch ( p->p ) {
          case 2 :
            mvf = 200.0;
            p->pv = 2;
            break;
          case 4 :
            mvf = 1000.0;
            p->pv = 3;
            break;
          case 8 :
            mvf = 2400.0;
            p->pv = 4;
            break;
          case 16 :
            mvf = 3000.0;
            p->pv = 5;
            break;
          case 32 :
            mvf = 3000.0;
            p->pv = 6;
            break;
          default :
            return 1;
        }
        if ( t < mvf ) {
          p->dv = 0;
          if ( p->rd  > 1 ) {
            p->dv = (p->rd>>1)-1;
            rem = (p->rd-(p->rd>>1))-1;
            p->dv |= (rem<<4);
          }
          return 0;
        }
      }
    }
  }
  return 1;
}

int cmd_setup(int argc,const char **argv) {
  int i, ierr;
  float f;
  unsigned char *p;
  struct s_ad9517 pll;
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
    AMC502_I2C_WBUF[2] = 0x8f8c8840;
    AMC502_I2C_WBUF[3] = 0x40884040;
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
  else if ( _strcmp(argv[1],"mux1") == 0 ) {
    _printf("Setting up M-LVDS Crossbar-1\n\r" );
    while ( (AMC502_I2C&0x80000000) );
// output port 0 <-- port 8 (FMCEXPA)
// output port 1 <-- port 9 (FMCEXPB)
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
    AMC502_I2C_WBUF[0] = 0x82408988;
    AMC502_I2C_WBUF[1] = 0x00000000;
    AMC502_I2C_WBUF[2] = 0x00000000;
    AMC502_I2C_WBUF[3] = 0x00000000;
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
  else if ( _strcmp(argv[1],"ad9517") == 0 ) {
    f = 250.0;
    if ( argc > 2 ) {
      f = 1.0*_atoi(argv[2]);
    }
    ierr = get_ad9517_pll(f,&pll);
    if ( ierr == 0 ) {
      _printf( "  A=%d, B=%d, R=%d, P=%d, PV=%d, RD=%d\n\r",
               pll.a, pll.b, pll.r, pll.p, pll.pv, pll.rd );
      write_ad9517(0x010,0x7c);
      write_ad9517(0x011,pll.r&0xff);
      write_ad9517(0x012,pll.r>>8);
      write_ad9517(0x013,pll.a);
      write_ad9517(0x014,pll.b&0xff);
      write_ad9517(0x015,pll.b>>8);
      write_ad9517(0x016,pll.pv);
      write_ad9517(0x017,0xb4);
      write_ad9517(0x019,0x00);
      write_ad9517(0x01a,0x00);
      write_ad9517(0x01b,0x00);
      write_ad9517(0x01c,0x87);
      write_ad9517(0x01d,0x00);
      write_ad9517(0x0f0,0x0c);
      write_ad9517(0x0f1,0x0e);
      write_ad9517(0x0f4,0x0e);
      write_ad9517(0x0f5,0x0e);
      write_ad9517(0x140,0x03);
      write_ad9517(0x141,0x0b);
      write_ad9517(0x142,0x02);
      write_ad9517(0x143,0x4a);
      write_ad9517(0x190,pll.dv);
      write_ad9517(0x191,0x00);
      write_ad9517(0x192,0x00);
      write_ad9517(0x196,pll.dv);
      write_ad9517(0x197,0x00);
      write_ad9517(0x198,0x00);
      write_ad9517(0x199,pll.dv);
      write_ad9517(0x19a,0x00);
      write_ad9517(0x19b,0x00);
      write_ad9517(0x19c,0x20);
      write_ad9517(0x19d,0x00);
      write_ad9517(0x19e,pll.dv);
      write_ad9517(0x19f,0x00);
      write_ad9517(0x1a0,0x00);
      write_ad9517(0x1a1,0x20);
      write_ad9517(0x1a2,0x00);
      write_ad9517(0x1e0,0x00);
      write_ad9517(0x1e1,0x01);
      write_ad9517(0x230,0x00);
      write_ad9517(0x232,0x01);
    }
    else {
      return 1;
    }
  }
  else if ( _strcmp(argv[1],"adc") == 0 ) {
    write_ads42lb69(0x14,0x15,0x01);  // DDR mode
    _printf( "ADC readout in DDR mode.\n\r" );
    write_ads42lb69(0x14,0x08,0x08);  // Enable DDR phase adjustment
    write_ads42lb69(0x14,0x16,0x18);  // DDR phase
    write_ads42lb69(0x14,0x10,0x00);  // Test pattern
    write_ads42lb69(0x14,0x11,0xa5);  // Test pattern
    write_ads42lb69(0x14,0x0f,0x00);  // Turn off test patterns
  }
  else {
    return 1;
  }
  return 0;
}

void print_version() {
  __puts("\n\rPurdue debug monitor 1.00 - AMC502+FMC164.\n\r");
  __puts("Built " __DATE__ " " __TIME__);
  __puts("\n\r\n\r");
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
  { "fmc164", "", cmd_fmc164 },
  { "rspi", "{ad9517|adc<n>} <addr>", cmd_rspi },
  { "wspi", "{ad9517|adc[n]} <addr> <data>", cmd_wspi },
  { "setup", "{mux0|mux1|ad9517|adc}", cmd_setup },
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
