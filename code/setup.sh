#!/bin/bash
cd "$(dirname "$(readlink -f "$0")")"
# make clean
# make

sudo ip link set eth1 mtu 9000
sudo firewall-cmd --permanent --add-port=48879/udp


while true; do
	ping 192.168.40.245 -c 1
	./amc502_mux 192.168.40.245 < mux_master.txt
	./amc502_mux 192.168.40.245 < mux_master.txt
	echo -e "\n\n"
	echo "-- Did the mux configure properly?" 
	echo "-- You should see a mix of 'INPUT' and 'OUTPUT'. "
	echo "----------------"
	echo "-- Good Example:"
	echo "-- MUX1 =  40 84 00 00 40 00 00 00 00 00 84 00 00 00 84 00"
	echo "--   Port 00 (FMCEXPA) :  input Z=100 Ohm"
	echo "--   Port 01 (FMCEXPB) :  output <-- 4 (PLLCLKA_out)"
	echo "--   [ ... ]"
	echo "----------------"
	echo "-- Bad Example:"
	echo "-- MUX1 =  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff"
	echo "--   Port 00 (FMCEXPA) :  output <-- 15 (FMC1_CLK3_BIDIR)"
	echo "--   Port 01 (FMCEXPB) :  output <-- 15 (FMC1_CLK3_BIDIR)"
	echo -e "--\n--"
	echo "-- Press 'n' to try again, or any other key to continue."
	read -t 15 -n 1 user_input
	
	if [ $? -eq 0 ]; then
		if [[ "$user_input" =~ ^[Nn]$ ]]; then
			echo "Retrying mux configuration"
		else
			break
		fi
	else
		echo "Retrying mux configuration"
	fi
	
	# sleep 5
done

./amc502_pll 192.168.40.245 < pll_config.txt
./setup_fmc228.sh

