#!/bin/bash
cat << EOF  |  while read line; do echo "$line" | tee /dev/ttyUSB0; usleep 200000; done
arp 192.168.40.2
arp 
send 192.168.40.2 48879
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
EOF