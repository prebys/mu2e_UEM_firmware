## `udp_recv` program debugging steps

What to do when the `socketudp/udp_recv` program isn't receiving data.

First of all, make sure `stream on` is enabled in the minicomA window! If you can't type in the minicomA window, you need to [reload the FPGA firmware](#programming-the-fpga).

Most of the debug steps will revolve around checking `tcpdump`
From empty terminal, start a tcpdump session    
- `sudo tcpdump -i eth1 udp port 48879 -v -X`  

With the `udp` option in the command, this will show *all* incoming UDP packets. You'll observe one of two things:

1. #### `tcpdump` shows a bunch of packets, but they don't show up in `udp_recv`

This means the FPGA is receiving data events and attempting to send packets to the `mu2euem` computer, but the packets are not being accepted by the computer. The `tcpdump` command is special because it shows all UDP packets being received raw to the system before the system has any chance to do processing them. What can often happen is the FPGA will send UDP packets with somehow wrong or incorrect formatting or headers, and this will cause the mu2euem computer to discard those packets. The exact cause of the FPGA sometimes sending bad headers is unknown, but it is most likely an issue with the initial setup, because it either happens everytime or not at all. 

To fix this, try just running the whole setup process again, starting with `./setup.sh`, and then if the problem persists, starting from reloading the FPGA firmware completely. You may also try power-cycling the AMC502 board (possible from the [ScorpionWare software](#scorpionware-system)).

2. #### `tcpdump` doesn't show any incoming packets
This means either the FPGA is not sending any packets or the `mu2euem` computer's network settings are denying them. First, with `tcpdump` still running in one terminal window, from the `minicomA` window:  
- `stream on`  
- `send 192.168.40.02 48879`

If `udp_recv` or `tcpdump` receives this packet, then your system's network is configured properly, then the FPGA is not sending any packets. Confirm that there are pulses going into the trigger input properly, and that you ran all the setup steps properly. Try redoing the setup process, and potentially power-cycle the FPGA (possible from the [ScorpionWare software](#scorpionware-system)).

If you can't receive the test packet, then some network settings on your device may be wrong. Some of these steps are in the `setup.sh` script, but here are the main network configuration steps.

1. Check if the UDP port is allowed in the IP tables:   
  `sudo iptables -L INPUT -n | grep 48879`
2. If nothing comes up from the above command:  
  `sudo iptables -A INPUT -p udp -m udp --dport 48879 -j ACCEPT`
3. Increase allowed UDP packet size:  
  `sudo ip link set eth1 mtu 9000`
4. Allow the UDP port in the firewall:  
  `firewall-cmd --permanent --add-port=48879/udp && firewall-cmd --reload`
5. Not recommended, but try disabling firewall completely (don't ever just leave it disabled!)
  `systemctl stop firewalld`