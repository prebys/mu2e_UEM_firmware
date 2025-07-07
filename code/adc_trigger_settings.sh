#!/bin/bash
cat << EOF  |  while read line; do echo "$line" | tee /dev/ttyUSB0; usleep 200000; done

# spi settings are defined in mu2e_UEM_firmware.sdk/monitor_amc502/src/ad9234.h
#   ↓address   ↓val. ↓power-on-default
# { 0x0040, 3, 0x3F, 0x3F, "[7:6] PDWN function [5:3] FD_B [2:0] FD_A 0:Fast detect 1:LMFC 2:SYNC~ 3:temp. diode 7:disabled"},
# { 0x0228, 3, 0x00, 0x00, "Customer offset (+127~-128 2's complement)"},
# { 0x0245, 3, 0x00, 0x00, "FD ctrl [3] force [2] force value [0] enable"},
# { 0x0247, 3, 0x00, 0x00, "Fast detect upper threshold [7:0]"},
# { 0x0248, 3, 0x00, 0x00, "[4:0] Fast detect upper threshold [12:8]"},
# { 0x0249, 3, 0x00, 0x00, "Fast detect lower threshold [7:0]"},
# { 0x024A, 3, 0x00, 0x00, "[4:0] Fast detect lower threshold [12:8]"},
# { 0x024B, 3, 0x00, 0x00, "Fast detect dwell time [7:0]"},
# { 0x024C, 3, 0x00, 0x00, "Fast detect dwell time [15:8]"},
# { 0x0550, 3, 0x00, 0x00, "ADC test modes [7] user ptn 0: cont. 1: single [5] reset PN long gen [4] reset PN short gen [3:0] test mode sel"}

-- threshold is calculated with a max value of 2^13 = 8192
lower_threshold=1000
upper_threshold=2000

-- dwell time is in number of clock cycles, from 1000 MSPS, so 1 cycle = 1 ns
-- it means if the signal drops below threshold but comes back up high within the dwell time, it won't detrigger
dwell_time=50


-- set adc values
lower_threshold_lower=$(( lower_threshold & 0xFF ))
lower_threshold_upper=$(( (lower_threshold >> 8) & 0x1F ))

upper_threshold_lower=$(( upper_threshold & 0xFF ))
upper_threshold_upper=$(( (upper_threshold >> 8) & 0x1F ))

dwell_time_lower=$(( dwell_time & 0xFF ))
dwell_time_upper=$(( (dwell_time >> 8) & 0xFF ))

wspi adc0 247 $lower_threshold_lower
wspi adc0 248 $lower_threshold_upper
wspi adc1 247 $lower_threshold_lower
wspi adc1 248 $lower_threshold_upper

wspi adc0 249 $upper_threshold_lower
wspi adc0 24A $upper_threshold_upper
wspi adc1 249 $upper_threshold_lower
wspi adc1 24A $upper_threshold_upper

wspi adc0 24B $dwell_time_lower
wspi adc0 24C $dwell_time_upper

EOF