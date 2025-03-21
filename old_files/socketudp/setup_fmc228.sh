#!/bin/bash
cat << EOF  |  while read line; do echo "$line" | tee /dev/ttyUSB0; usleep 200000; done
poke cf00003c ff  -- Trigger stuff
poke cf000044 512 --1024 --1024  -- trigger time offset
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
stream 192.168.40.2 48879 on
poke cf00003c 7f
EOF
