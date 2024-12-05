#!/bin/bash
cd "$(dirname "$(readlink -f "$0")")"
make clean
make
./amc502_mux 192.168.40.02 < mux_master.txt
./amc502_pll 192.168.40.02 < pll_config.txt
./setup_fmc228_begin.sh
./setup_fmc228.sh
sudo ip link set eth1 mtu 9000
