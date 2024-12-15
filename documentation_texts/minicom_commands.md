# AMC502+XAUI+FMC228 Debug Monitor Help

This document provides an overview of the available commands in the debug monitor. Commands are executed in the CLI environment, with parameters as specified.

## General Commands

- **`help`**  
  Displays a list of all available commands with their descriptions.

- **`ver`**  
  Prints the current version and build date/time of the firmware.

## Time and Date

- **`time`**  
  Prints the current system time.

- **`date`**  
  Prints the current system date.



## Memory Access Commands

- **`poke <addr> <data>`**  
  Writes the specified `<data>` to the memory address `<addr>`.

- **`peek <addr>`**  
  Reads and displays the data at the specified memory address `<addr>`.

- **`dump [<addr> [n]]`**  
  Dumps `n` bytes (default is 16) of memory starting from the address `<addr>`. If no parameters are provided, dumps from the last address.



## Network Configuration and Tools

- **`arp [<addr>]`**  
  - Without parameters: Displays the ARP table.  
  - With `<addr>`: Sends an ARP request for the specified address.

- **`ip [<addr> <netmask> <gateway>]`**  
  - Without parameters: Displays the current IP configuration.  
  - With parameters: Sets the IP address, netmask, and gateway.

- **`ntp <addr>`**  
  Sends an NTP request to the specified `<addr>`.

- **`send <addr> <port>`**  
  Sends a single UDP packet to the specified `<addr>` on the given `<port>`.

- **`stream <addr> <port> [on|off]`**  
  Configures a streaming UDP connection to the specified `<addr>` and `<port>`.  
  - Typing just `stream` will display the current stream status.
  - Use `on` to enable and `off` to disable the stream.
  - Typing just `stream on` or `stream off` will default to `stream 192.168.40.2 48879 [on|off]`

- **`xarp`**  
  Displays extended ARP table information for the 10GbE interface. Note, this currently returns a most uninitialized table filled with `248.248.248.248   f8:f8:f8:f8:f8:f8   4177066232` entries.

- **`xip [<addr> <netmask> <gateway>]`**  
  - Without parameters: Displays the 10GbE IP configuration and packet statistics.  
  - With parameters: Sets the 10GbE IP address, netmask, and gateway.
    ```
    MAC address f8:f8:f8:f8:f8:f8
    ip addr 248.248.248.248 netmask 248.248.248.248 gw 248.248.248.248
    RX packets: 4177066232  ARP: 4177066232  ICMP: 4177066232  UDP: 4177066232
    ```

- **`xsend <addr> <port>`**  
  Sends a UDP packet to the specified `<addr>` on port `<port>` using the 10GbE interface.

- **`xbuf [free] <n>`**  
  Displays or manages the state of UDP receive buffers for the 10GbE interface.  
  - `free <n>`: Frees buffer `<n>`.

- **`xping <addr>`**  
  Sends a ping request to the specified `<addr>` using the 10GbE interface.



## Clock and Frequency Commands

- **`freq`**  
  Displays the frequencies of various system clocks.
  ```
     bcoclk : 39.999995 MHz
     sysclk : 79.999990 MHz
    bcoclk* : 40.1533 MHz
    sysclk* : 80.3066 MHz
     fpclkb : 39.999995 MHz
  clk100mhz : 100.1 MHz
    gmiiclk : 125.1 MHz
   dclkout0 : 250.2737 MHz
   dclkout2 : 250.2737 MHz
  dclkout10 : 0.0 MHz
  dclkout12 : 0.0 MHz
   sysref11 : 0.0 MHz
   sysref13 : 0.0 MHz
  ```
- **`pll`**  
  Displays the status of the PLL and its registers.  Use `pll reset` to reset and re-lock the PLL.
    ```
    PLL is locked.
    Addr  Name            Data
    ----  --------------  ----
     08   CLKOUT0 Reg 1   1514
     09   CLKOUT0 Reg 2   0000
     0a   CLKOUT1 Reg 1   128a
     0b   CLKOUT1 Reg 2   0000
     14   CLKFBOUT Reg 1  1514
     15   CLKFBOUT Reg 2  0000
     16   DIVCLK          1041
     18   LockReg1        00fa
     19   LockReg2        7c01
     1a   LockReg3        ffe9
     28   Power           0000
     4e   FiltReg1        0908
     4f   FiltReg2        1000
     ```



## Device Setup and Control

- **`setup {mux0|mux1|lmk|hmc|adc0|adc1|all}`**  
  Configures the specified device or all devices:  
  - `mux0`/`mux1`: Configures clock multiplexers.  
  - `lmk`: Configures the LMK clock generator.  
  - `hmc`: Configures the HMC PLL.  
  - `adc0`/`adc1`: Configures ADC channels 0 and 1.  
  - `all`: Configures all devices.

- **`count [<chan>]`**  
  Displays counter values.  
  - Without parameters: Shows all counters.  
  - With `<chan>`: Displays the value of the specified channel counter.
  - `count reset` to reset all counts.
  - Example output:
    ```
      -   [ 0 ] : 4592
     trig [ 1 ] : 125
      -   [ 2 ] : 166
     idle [ 3 ] : 7828
      -   [ 4 ] : 1930
     sync [ 5 ] : 0
    evil0 [ 6 ] : 6343
    latch [ 7 ] : 0
      run [ 8 ] : 143
    evil1 [ 9 ] : 7937
    start [ a ] : 0
     stop [ b ] : 1799
    evil2 [ c ] : 2084
     halt [ d ] : 12191455883
    count [ e ] : 0
      -   [ f ] : 4725
     sync timer : 0
    ```



## SPI Commands

- **`rspi {lmk|hmc|adc0|adc1} <addr>`**  
  Reads the value at SPI register `<addr>` for the specified device.

- **`wspi {lmk|adc0|adc1} <addr> <data>`**  
  Writes `<data>` to SPI register `<addr>` for the specified device.



## Other Commands

- **`nint`**  
  Displays interrupt counts.

- **`bco [reset|<value>]`**  
  Displays or sets the BCO (bunch crossing counter).  
  - `reset`: Resets the counter.  
  - `<value>`: Sets the counter to `<value>`.



## Command Differences (Standard vs. Extended)

- **Standard (`arp`, `ip`, `send`)**:
  - Operates on the **standard Ethernet interface**.

- **Extended (`xarp`, `xip`, `xping`, `xsend`, `xbuf`)**:
  - Operates on the **10GbE (XAUI)** interface, providing functionality tailored for high-speed networks.



## Notes

- `<addr>`: Memory or register address (in hexadecimal format).  
- `<data>`: Value to write (in hexadecimal format).  
- `<n>`: Number of bytes or items to display/process.  
- Commands return `???` for invalid syntax or parameters.
