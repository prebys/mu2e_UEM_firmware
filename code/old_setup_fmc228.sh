#!/bin/bash
cat << EOF  |  while read line; do echo "$line" | tee /dev/ttyUSB0; usleep 200000; done
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
--stream 192.168.40.2 48879 off
--poke cf00003c f7
stream 192.168.40.2 48879 off
-- poke cf00003c fe
EOF
