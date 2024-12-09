This repository documents the Xilinx Vivado project required to run the FPGA in the Vadatech microTCA crate. Main instructions are found here: https://eprebys.faculty.ucdavis.edu/mu2e-uem-microtca-firmware-notes/

For help installing ROOT and Vivado on AlmaLinux, see [this page](documentation_texts/software_installation_tips.md).

The original state of this repository as it was left by Minh on the UEM computer before the recompiling and reformatting can be found in the [original-minh branch](https://github.com/prebys/mu2e_UEM_firmware/tree/original-minh). 

Minh's original instructions for operation of the Vadatech crate are found in [mu2e-docdb:40514](https://mu2e-docdb.fnal.gov/cgi-bin/sso/ShowDocument?docid=40514).

Main bitfile to be used when programming the FPGA is [bitfiles/top_fmc228_pcie_v1.bit](bitfiles/top_fmc228_pcie_v1.bit)

### Things for Jinglu to try doing (if you're reading this!)
This section of course won't be in the final real documentation, it's just here while I'm drafting things
1. Follow the below steps and practice trying to take data
2. Try changing some of the parameters by doing in the minicomA window `poke cf000048 c8` while stream if off and then turn it back on and take new data. This will set the raw waveform window from 200ns to 400ns. See if it still takes data.
3. There is some kind of maximum amount of time allowed for the raw waveform window. If you set the setting too high, then all data stops coming, and even if you turn the setting back down, the data won't come until you completely reload the firmware from the original bit file. We need to investigate this.
4. Channels 1-3 of the data should be PMTs producing pretty much just 0V. Channel 4 should be the DC ramp from -2.3V to +2.3V, but right now it seems to be stuck around 0V. We should investigate this. (I'm assuming the signal generator is properly putting out a signal!)

You can try any of these above things. Even just step one is a good starting point without worrying about any of the other things. 

### How to take data

1. SSH into `mu2euem@mu2euem.dhcp.fnal.gov`. 
2. Enter the command `minicomA`
3. If you push enter a few times, new lines should appear prefixed by `$ ` dollar signs. If nothing happens when you push enter, you need to program the FPGA (see [Programming the FPGA](#programming-the-fpga))
4. In a second SSH window, navigate to `/disk2/mu2e/mu2e_UEM_firmware/socketudp/`
5. Run `./newsetup.sh`. This compiles all the required setup steps from Minh's original document into one script, along with newer recommended settings. Ask someone on the project for the root password.
6. In the /socketudp/ directory, run `./udp-recv`.
7. In the minicomA window, an important configuration is `stream off` or `stream on`. This determines whether the uTCA crate will be sending data over UDP. By default, it is off. Once the `udp-recv` file is open and waiting for data, type `stream on` in the minicomA window.
8. Once you're done taking data, FIRST type `stream off` then `Ctrl+C` to stop data taking in the /socketudp/ window. It will create images in the /socketudp/img/ directory.

#### Programming the FPGA
Two methods. First, using Vivado:
1. In a new terminal window, navigate to `/disk2/mu2e/mu2e_UEM_firmware/`.
2. Run the command `vivado mu2e_UEM_firmware.xpr`. A Vivado window should open up.
3. Go to Hardware Manager --> Open Target --> Auto Connect --> Program Device --> Choose a bitfile.
4. In the `minicomA` window, once the programming is finished, a message should pop saying "Purdue debug monitor 1.00 - AMC502+XAUI+FMC228(1) version.", and you should be able to start typing into the minicom window.

Second method, using SSH to upload the bit file directly

1. Navigate to `/disk2/mu2e/mu2e_UEM_firmware/socketudp/`
2. Run `./fpga_upgrade`. It should run a bunch of commands. Ask someone on the project for the root password.

#### Using ROOT Files
- Run `make clean` and `make` in the directory: /FMC228_v4
- Inside FMC228_v4/convertFMC228: `./read_binary_FMC228_longpeakfinding_v6 <path to input root file> <path to output> <no. of events>`
- To read this tree and plot several things : `ShowProf_rawevent1.C` inside /macros.

### `udp_recv` program debugging steps

What to do when the `socketudp/udp_recv` program isn't receiving data.

First of all, make sure `stream on` is enabled in the minicomA window! If you can't type in the minicomA window, you need to [reload the FPGA firmware](#programming-the-fpga).

#### Check `tcpdump`
From empty terminal, start a tcpdump session    
- `sudo tcpdump -i eth1 udp port 48879 -v -X`  

With the `udp` option in the command, this will show *all* incoming UDP packets. 

#### `tcpdump` shows a bunch of packets, but they don't show up in `udp_recv`
This means the FPGA is receiving data events and attempting to send packets to the `mu2euem` computer, but the packets are not being accepted by the computer. The `tcpdump` command is special because it shows all UDP packets being received raw to the system before the system has any chance to do processing them. What can often happen is the FPGA will send UDP packets with somehow wrong or incorrect formatting or headers, and this will cause the mu2euem computer to discard those packets. The exact cause of the FPGA sometimes sending bad headers is unknown, but it is most likely an issue with the initial setup, because it either happens everytime or not at all. 

To fix this, try just running the whole setup process again, starting with `./newsetup.sh`, and then if the problem persists, starting from reloading the FPGA firmware completely. You may also try power-cycling the AMC502 board (possible from the ScorpionWare software).

#### If `tcpdump` doesn't show any incoming packets
This means either the FPGA is not sending any packets or the `mu2euem` computer's network settings are denying them. First, with `tcpdump` still running in one terminal window, from the `minicomA` window:  
- `stream on`  
- `send 192.168.40.02 48879`

If `udp_recv` or `tcpdump` receives this packet, then your system's network is configured properly, then the FPGA is not sending any packets. Confirm that there are pulses going into the trigger input properly, and that you ran all the setup steps properly. Try redoing the setup process, and potentially power-cycle the FPGA (possible from the ScorpionWare software).

If you can't receive the test packet, then some network settings on your device may be wrong. Some of these steps are in the `newsetup.sh` script, but here are the main network configuration steps.

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

#### Other misc. info
Minicom setup: https://mu2e.fnal.gov/public/workgroups/mu2etest/uTCA_Linux_Setup.html#Minicom_Program

IP addresses:  
- 192.160.40.02: network box utc-002 / mu2euem computer ip
- 192.168.40.245: fmc-228 utc-002
- 192.168.16.1 / 192.168.40.250: vtipmi
- 192.168.40.252: amc502A
- 192.168.40.253: amc502B

Signal generator settings:  
TTL pulse: 3.3v pulse, around 25 Hz, tiny impulse square wave (0.001% duty cycle)