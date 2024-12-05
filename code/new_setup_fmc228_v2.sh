#!/bin/bash
cat << EOF  |  while read line; do echo "$line" | tee /dev/ttyUSB0; usleep 200000; done

poke cf00003c 7f  -- Trigger stuff

-- trigger time offset, 40 MHz clock (25ns), so (offset)*0.25ns = real offset
-- 1024 = 16us,   4096 = 66us,   8192 = 66us,   10234 = 0.26ms,   1312D00 = 0.5s,   7fcad80 = 3.35s
poke cf000044 7fcad80

-- raw waveform length 
-- 64 = 200ns (0x64=100 though?, 0x64 = 100 *samples*, each sample is 2ns?),  2710 = 1000
poke cf000048 64

poke cf000050 f380  -- thr of peak finding -200
poke cf000054 53    -- 0 --> 81 peak_count
poke cf000058 fb    -- 0 --> 127 sum_count

-- cf00004c: max subevn, 
-- 1d: 0-->29,   13: 0-->19
poke cf00004c 13

-- cf000038: adc buffer csr
-- 00000001: standard operation
-- 01000001: 2nd highest bit is testmode (here, mode "1")
-- peek cf000038
-- poke cf000038 00000001  -- adc buffer csr, standard operation (no test mode)

-- idk what these are
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
