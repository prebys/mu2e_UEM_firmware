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
