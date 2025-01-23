There are settings for the trigger, which controls when the system should respond to incoming signals and starting taking data (for example, only when it sees beam pulses, or only when it receives a pulse from the accelerator trigger telling it beam is coming soon). Set the trigger with the `cf00003c` register. Here is an explanation from Matthew on how the adc_trigger.vhd file works:

- The `adc_fd[3..0]` inputs are supposed to be the fast-detect signals from the ADC chips.  This is a really nice way to get triggers out of them because you can program the threshold and hysteresis parameters directly in the ADC, and they are asserted many clock cycles before the data appears on the serial link.  They should be set up so that if they are '1' then there is a pulse in that channel.
- `ext_trig` is an external trigger source which can come from anywhere.
- `inhibit` is not being used anymore.   The logic that used to use it is commented out.
- `mask` is the trigger mask which defines which trigger algorithm is to be ignored.
- `pres` is not used anymore, but it used to provide a way to prescale high-rate triggers.

```vhd
constant trigger_lookup : trigger_lookup_t := (
--     trigger     adc_fd
    "00000000",   -- 0000
    "00000001",   -- 0001
    "00000001",   -- 0010
    "00000011",   -- 0011
    "00000001",   -- 0100
    "00000011",   -- 0101
    "00000011",   -- 0110
    "01010111",   -- 0111
    "00000001",   -- 1000
    "00100011",   -- 1001
    "00000011",   -- 1010
    "00100111",   -- 1011
    "00000011",   -- 1100
    "00100111",   -- 1101
    "10000111",   -- 1110
    "00001111"    -- 1111
  );
```

In the stack of 4 scintillators with each going to one ADC channel:
- The low 4 bits of the algorithm count whether there is 0, 1, 2, or 3 FD inputs in coincidence (the order doesn't matter).  
- Bit 5 seems to indicate when there are hits in the 'top' and 'bottom' scintillators, but not in either middle one.  
- Bits 4 and 6 together both indicate when there are hits in the top three scintillators, but not the bottom one.  This detects a muon that stopped in the third scintillator.  
- It looks like the logic replaces bit 7 by the external trigger input (so it doesn't matter here)

Here's how you can set the mask:

| Mask Setting   | Binary      | Valid adc_fd signals               | Description                                             |
|----------------|-------------|------------------------------------|---------------------------------------------------------|
| 0xFF           | 0b1111,1111 | None                               | Ignores everything                                      |
| 0xFE           | 0b1111,1110 | 0001, 0010, 0100, 1000             | At least one input has an FD signal high                |
| 0xFD           | 0b1111,1101 | 0011, 0101, 0110, 1001, 1010, 1100 | At least two inputs have FD signals high                |
| 0xFB           | 0b1111,1011 | 0111, 1011, 1101, 1110             | At least three inputs have FD signals high              |
| 0xF7           | 0b1111,0101 | 1111                               | All four FD inputs are high                             |
| 0x7F (default) | 0b0111,1111 | Ignores adc_fd                     | External trigger is high (ignores FD signals)           |
| 0xEF           | 0b1110,1111 | 0111                               | Stopped particle trigger (hits in top 3 but not bottom) |
| 0x00           | 0b0000,0000 | Anything                           | Allow any trigger condition                             | 


Set the trigger mask by doing in the `minicomA` window: `poke cf00003c <mask setting>`. The current default is `poke cf00003c 0x7f` to take input from the external trigger only. 

The current adc_fd status can be read from register `cf000000`, which contains a combination of many status registers. The full register returns:

- `fmc228_csr(31 downto 24) & adc_fd_r & fmc228_csr(19 downto 18) & trig_in & trig_busy & lmk_sysref_req & fmc228_csr(14 downto 12) & hmc_ldo & fmc228_csr(10 downto 5) & lmk_status_ld & fmc228_csr(2 downto 0);`

Our "adc_fd_r" of interest is bits 23 to 20 of the register, and can be read by doing in the `minicomA` window: `peek cf000000`. An example return value of `00030930` (binary `0000_0000_*0000*_0011_0000_1001_0011_0000`) would mean that the adc_fd register is 0b0000, which means currently none of the channels are triggering on the fast detect system.

### FD Setting Registers

There are some FD settings that I have not yet tested changing, but they are as described below:

```
# spi settings are defined in mu2e_UEM_firmware.sdk/monitor_amc502/src/ad9234.h
# ↓address   ↓val. ↓power-on-default
{ 0x0040, 3, 0x3F, 0x3F, "[7:6] PDWN function [5:3] FD_B [2:0] FD_A 0:Fast detect 1:LMFC 2:SYNC~ 3:temp. diode 7:disabled"},
{ 0x0228, 3, 0x00, 0x00, "Customer offset (+127~-128 2's complement)"},
{ 0x0245, 3, 0x00, 0x00, "FD ctrl [3] force [2] force value [0] enable"},
{ 0x0247, 3, 0x00, 0x00, "Fast detect upper threshold [7:0]"},
{ 0x0248, 3, 0x00, 0x00, "[4:0] Fast detect upper threshold [12:8]"},
{ 0x0249, 3, 0x00, 0x00, "Fast detect lower threshold [7:0]"},
{ 0x024A, 3, 0x00, 0x00, "[4:0] Fast detect lower threshold [12:8]"},
{ 0x024B, 3, 0x00, 0x00, "Fast detect dwell time [7:0]"},
{ 0x024C, 3, 0x00, 0x00, "Fast detect dwell time [15:8]"},
{ 0x0550, 3, 0x00, 0x00, "ADC test modes [7] user ptn 0: cont. 1: single [5] reset PN long gen [4] reset PN short gen [3:0] test mode sel"}

# Set in setup script as following:
wspi adc1 40 0
wspi adc0 40 0
wspi adc0 247 00
wspi adc1 247 00
wspi adc0 248 08
wspi adc1 248 08
wspi adc0 249 40
wspi adc1 249 40
wspi adc0 24b 40
wspi adc1 24b 40
wspi adc0 245 1
wspi adc1 245 1
```

The way to read this is, for example with 0x0040, it's an eight-bit setting register, and the description on the right tells you what settings each of the eight bits control. It defaults to 0x3F (binary 0b0011_1111), and you look at the text description to see what each of those does. [7:6] is PDWN function, and that is set to "00". [5:3] is FD_B, that are set to "0b111=7", [2:0] is FD_A which is also set to "0b111=7", which means "disabled"! The setup script overrides this register to "0", which is "00" for PDWN function, "000=0" for FD_A and FD_B which is "Fast detect".

An interesting test would be to set 245 to 0xF which would "force" value to "1" and enable FD. Currently the ADC is never reading high on any of the FD values.

The setup script sets "fast detect upper threshold" to 0x0800, "fast detect lower threshold" to 0x0040, "fast detect dwell time" to 0x0040, and "FD ctrl" to 0x1 = 0b0001 (enable=1).
