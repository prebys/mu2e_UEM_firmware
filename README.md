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

Other to-do:

1. Simplify GitHub project by expanding the .gitignore file. This will require Google searches + repeatedly cloning the GitHub repo and trying to build the .bit file from what just what the repo gives and see what files are necessary and what can be rebuilt. Obviously for example, not including the project file would break it, as would not including the .vhd source files, but I'm sure there are many files that are being included that aren't necessary. 

### How to take data

1. SSH into `mu2euem@mu2euem.dhcp.fnal.gov` (ask someone for device password).
2. Enter the command `minicomA`
3. If you push enter a few times, new lines should appear prefixed by `$ ` dollar signs. If nothing happens when you push enter, you need to program the FPGA (see [Programming the FPGA](#programming-the-fpga))
4. In a second SSH window, navigate to `/disk2/mu2e/mu2e_UEM_firmware/socketudp/`
5. Run `./newsetup.sh`. This compiles all the required setup steps from Minh's original document into one script, along with newer recommended settings. Ask someone on the project for the root password.
6. In the `/socketudp/` directory, run `./udp-recv`.
7. In the `minicomA` window, an important configuration is `stream off` or `stream on`. This determines whether the uTCA crate will be sending data over UDP. By default, it is off. Once the `udp-recv` file is open and waiting for data, type `stream on` in the minicomA window.
8. Once you're done taking data, FIRST type `stream off` then `Ctrl+C` to stop data taking in the `/socketudp/` window. It will create images in the `/socketudp/img/` directory.

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
- Run `make clean` and `make` in the directory: `/FMC228_v4`
- Inside `FMC228_v4/convertFMC228`: `./read_binary_FMC228_longpeakfinding_v6 <path to input root file> <path to output> <no. of events>`
- To read this tree and plot several things : `ShowProf_rawevent1.C` inside /macros.

### `udp_recv` program debugging steps

What to do when the `socketudp/udp_recv` program isn't receiving data.

First of all, make sure `stream on` is enabled in the minicomA window! If you can't type in the minicomA window, you need to [reload the FPGA firmware](#programming-the-fpga).

Most of the debug steps will revolve around checking `tcpdump`
From empty terminal, start a tcpdump session    
- `sudo tcpdump -i eth1 udp port 48879 -v -X`  

With the `udp` option in the command, this will show *all* incoming UDP packets. You'll observe one of two things:

1. #### `tcpdump` shows a bunch of packets, but they don't show up in `udp_recv`

This means the FPGA is receiving data events and attempting to send packets to the `mu2euem` computer, but the packets are not being accepted by the computer. The `tcpdump` command is special because it shows all UDP packets being received raw to the system before the system has any chance to do processing them. What can often happen is the FPGA will send UDP packets with somehow wrong or incorrect formatting or headers, and this will cause the mu2euem computer to discard those packets. The exact cause of the FPGA sometimes sending bad headers is unknown, but it is most likely an issue with the initial setup, because it either happens everytime or not at all. 

To fix this, try just running the whole setup process again, starting with `./newsetup.sh`, and then if the problem persists, starting from reloading the FPGA firmware completely. You may also try power-cycling the AMC502 board (possible from the [ScorpionWare software](#scorpionware-system)).

2. #### `tcpdump` doesn't show any incoming packets
This means either the FPGA is not sending any packets or the `mu2euem` computer's network settings are denying them. First, with `tcpdump` still running in one terminal window, from the `minicomA` window:  
- `stream on`  
- `send 192.168.40.02 48879`

If `udp_recv` or `tcpdump` receives this packet, then your system's network is configured properly, then the FPGA is not sending any packets. Confirm that there are pulses going into the trigger input properly, and that you ran all the setup steps properly. Try redoing the setup process, and potentially power-cycle the FPGA (possible from the [ScorpionWare software](#scorpionware-system)).

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

### Other misc. info
#### IP addresses:  
- `192.160.40.02`: network box utc-002 / mu2euem computer ip
- `192.168.40.245`: fmc-228 utc-002
- `192.168.16.1` / `192.168.40.250`: vtipmi
- `192.168.40.252`: amc502A (currently on the right)
- `192.168.40.253`: amc502B (currently on the left)

#### Current signal generator settings:  
- TTL pulse: 3.3 Vrms, 40ms period, negative pulse, 0.001% duty cycle
- DC ramp, -2.5V to +2.5V, 500μs period

#### Current physical crate port setup:
- PMT 1 → μTCA 1
- PMT 2 → μTCA 2
- PMT 3 → μTCA 3 / Scope 3
- DC Ramp → μTCA 4
- RF Pulse → μTCA Trig
- RF6 Trigger → Scope 4

#### Configurable bit options and their current settings:
Following are the configurable setting registers for the FPGA operation. Their addresses are defined in the [fmc228_interface.vhd](https://github.com/prebys/mu2e_UEM_firmware/blob/ada1936a3941501a399a5fa5aaa5d0d2bbe46b55/mu2e_UEM_firmware.srcs/sources_1/fmc228_interface.vhd#L366-L396) file, and can be set by using the `poke` command in the `minicomA` window, or by modifying the setup scripts.
- `cf00003c` = `0x7f` (accelerator trigger, using “trigger in” input)
- `cf000044` = `0x7fcad80` (trigger time offset)
  - How long to wait after trigger to start taking data; shorter time means more events happen more quickly
- `cf000048` = `0x64` = 100 (raw waveform length in number of packets)
  - Minh had defaulted this setting to `0x01` which resulted in *zero* raw data sent. 
  - Each network packet sent contains two raw data events, so a setting of 100 means 100 network packets which means 200 samples (200ns).
- `cf00004c` = `0x13` = 19 (max subevn)
  - How many subevents to record per event
  - Minh's setting of 0x1d (29) had subevents being cut off by new events before they could finish around 24~26 subevents
- `cf000038` = `0x00000001` (ADC CSR buffer)
  - Setting the second-highest byte here is what controls testmode settings. For example, setting it to `0x01000001` would output a "checkerboard" pattern through the ADC. See [testmode settings](#testmode-settings) for more info on testmode possibilities.

#### Testmode settings
Testmode settings are defined in the [adc_buffer_streamer.vhd](https://github.com/prebys/mu2e_UEM_firmware/blob/ada1936a3941501a399a5fa5aaa5d0d2bbe46b55/mu2e_UEM_firmware.srcs/sources_1/adc_buffer_streamer.vhd#L330-L347) file. They can be set by setting the second-highest bit of the ADC CSR buffer setting. For example, `poke cf000038 0x01000001`.
```vhd
case tm_r is
when "0000" =>
  dout <= din(to_integer(nchannel));
when "0001" =>
  dout <= checker_board;
when "0010" =>
  dout <= x"ffff0000";
when "0011" =>
  dout <= "0" & lfsr31;
when "0101" =>
  dout <= "00000000000000000" & lfsr15;
when "1001" =>
  dout <= std_logic_vector(count);
when others =>
  dout <= x"f8f8f8f8";
end case;
[ ... ]
checker_board <= x"aaaa5555" when even_clock = '1' else x"5555aaaa";
count <= unsigned(data_adc_length);
```
To summarize,
- `0000`: Sends actual ADC data (testmode off, standard operation).
- `0001` (`0x1`): "checkerboard" pattern: alternates between `0xAAAA5555` and `0x5555AAAA` every clock cycle.
- `0010` (`0x2`): Permanently sends `0xFFFF0000`.
- `0011` (`0x3`): Sends one `0` bit and then 31 bits of random data every clock cycle.
- `0101` (`0x5`): Sends 17 bits of `0` and 15 bits of random data every clock cycle.
- `1001` (`0x9`): Sends the value of the variable `count`, which is defined as the value of `data_adc_length`, which shows the amount of raw_data packets that are left to be sent.
- All other testmode options will send `0xF8F8F8F8`.

#### Trigger settings
There are three settings for the trigger. Set the trigger with the `cf00003c` register. Note, "fe" and "f7" descriptions may be wrong here. An email has been sent out to Matthew for clarification.
- `fe`: self trigger: internal clock will run as a trigger (apparently this didn't work before, but it hasn't been tried in a while)
- `7f`: accelerator trigger: using the "trigger in" input on the front of the board (normal setting)
- `f7`: self trigger (fe) + requirement for four coincidence

The `adc_fd` variable in the code is a project-level input hardware pin described in the [FMC228 Hardware Reference Manual](https://mu2e.fnal.gov/public/workgroups/mu2etest/vadatech_protected/documentation_and_software/fmc228/Hardware%20Reference%20Manual/VadaTech%20FMC228%20Hardware%20Reference%20Manual_v1.1.pdf) as "**F**ast **D**etect Outputs". These are binary logic signals telling you if the ADC channel is detecting data.

#### ScorpionWare System
With ScorpionWare, you can power-cycle the FMC card remotely. 

1. On the mu2euem computer, type `sysmanager` in any directory. A new window should open.
2. One of the options should be for a "carrier" called uTCA. If it's not there, add a new carrier with ip address 192.168.16.1.
3. When logging in, leave username/password boxes *blank*.
4. To power-cycle the FMC card, click on it in the program and click "deactivate" then "activate". There are other options for restarting, but I'm not sure what they do.

After doing this, you'll have to [reprogram the FPGA firmware](#programming-the-fpga)..