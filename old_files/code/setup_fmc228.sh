#!/bin/bash
cat << EOF  |  while read line; do echo "$line" | tee /dev/ttyUSB0; usleep 200000; done

# setup_fmc228_begin.sh file

arp 192.168.40.2  -- ping 192.168.40.2 and store its MAC address in the ARP table
arp  -- display the ARP table
send 192.168.40.2 48879  -- send a test packet to 192.168.40.2 (maybe to test to make sure it gets through)

-- below three are set in mu2e_UEM_firmware.srcs/sources_1/xaui_interface.vhd
-- constant address_icmpreq_sequence : std_logic_vector(15 downto 0) := x"0074";
-- constant address_icmpreq_daddr : std_logic_vector(15 downto 0) := x"0078";
-- constant address_icmpreq_timer : std_logic_vector(15 downto 0) := x"007c";
poke c1000074 c0a82802
poke c1000078 c001beef
poke c1000070 40000000

setup all
freq
--wspi a0 40 0
--wspi a0 248 02
--wspi a0 245 1
--wspi a1 40 0
--wspi a1 248 02
--wspi a1 245 1


# setup_fmc228.sh file

poke cf00003c 7f  -- Trigger stuff
poke cf000044 1024 --1024  -- trigger time offset -- 1024 = 16us
--poke cf000044 1024 --4096  -- trigger time offset -- 4096 = 66us
--poke cf000044 1024 --8192  -- trigger time offset -- 8192 = 0.13ms
--poke cf000044 1024 --10324  -- trigger time offset -- 10324 = 0.26ms
poke cf000044 7fcad80 --10324  -- trigger time offset -- 10324 = 0.26ms
poke cf000048 01 --64  -- raw waveform length 0x64 = 200ns
--poke cf00004c 00  -- max subevn
poke cf000050 f380  -- thr of peak finding -200
poke cf000054 53    -- 0 --> 81 peak_count
poke cf000058 fb    -- 0 --> 127 sum_count
poke cf00004c 1d    -- 0 --> 29 subevent

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
# { 0x0245, 3, 0x00, 0x00, "FD ctrl [3] force [2] force value [0] enable"},
# { 0x0247, 3, 0x00, 0x00, "Fast detect upper threshold [7:0]"},
# { 0x0248, 3, 0x00, 0x00, "[4:0] Fast detect upper threshold [12:8]"},
# { 0x0249, 3, 0x00, 0x00, "Fast detect lower threshold [7:0]"},
# { 0x024A, 3, 0x00, 0x00, "[4:0] Fast detect lower threshold [12:8]"},
# { 0x024B, 3, 0x00, 0x00, "Fast detect dwell time [7:0]"},
# { 0x024C, 3, 0x00, 0x00, "Fast detect dwell time [15:8]"}
# { 0x0550, 3, 0x00, 0x00, "ADC test modes [7] user ptn 0: cont. 1: single [5] reset PN long gen [4] reset PN short gen [3:0] test mode sel"}
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
arp 192.168.40.2
arp 192.168.40.2
stream 192.168.40.2 48879 off
EOF
