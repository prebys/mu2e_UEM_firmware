#!/bin/bash
cd "$(dirname "$(readlink -f "$0")")"
# make clean
# make
sudo ip link set eth1 mtu 9000
firewall-cmd --permanent --add-port=48879/udp
while true; do
	./amc502_mux 192.168.40.245 < mux_master.txt
	echo "Did the mux configure properly? You should see a mix of 'INPUT' and 'OUTPUT'. Press 'n' to try again, or any other key to continue."
	read -t 5 -n 1 user_input
	
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

