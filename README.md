This repository documents the Xilinx Vivado project required to run the FPGA in the Vadatech microTCA crate. Main instructions are found here: https://eprebys.faculty.ucdavis.edu/mu2e-uem-microtca-firmware-notes/

For help installing ROOT and Vivado on AlmaLinux, see [this page](documentation_texts/software_installation_tips.md).

The original state of this repository as it was left by Minh on the UEM computer before the recompiling and reformatting can be found in the [original-minh branch](https://github.com/prebys/mu2e_UEM_firmware/tree/original-minh). 

Minh's original instructions for operation of the Vadatech crate are found in [Mu2e-doc-40514](https://mu2e-docdb.fnal.gov/cgi-bin/sso/ShowDocument?docid=40514).

For a list of ways to contribute / a to-do list, see the [to_contribute](documentation_texts/to_contribute.md) page.


## Programming the FPGA
Two methods. First, using Vivado:
1. SSH into `mu2euem@mu2euem.dhcp.fnal.gov` (ask someone for device password).
2. In one terminal window, type the command `minicomA` to open a minicom terminal window.
3. In a new terminal window, navigate to `/disk2/mu2e/mu2e_UEM_firmware/` (this is the location of the base directory of this GitHub repository on the mu2euem device).
4. Run the command `vivado mu2e_UEM_firmware.xpr`. A Vivado window should open up.
5. Go to `Hardware Manager` ⇨ `Open Target` ⇨ `Auto Connect` ⇨ `Program Device` ⇨ Choose a bitfile. Main bitfile to be used when programming the FPGA is [`bitfiles/top_fmc228_pcie_v1.bit`](bitfiles/top_fmc228_pcie_v1.bit)
6. In the `minicomA` window, once the programming is finished, a message should pop saying "Purdue debug monitor 1.00 - AMC502+XAUI+FMC228(1) version.", and you should be able to start typing into the minicom window.

Second method, using SSH to upload the bit file directly

1. Navigate to [`/disk2/mu2e/mu2e_UEM_firmware/socketudp/`](socketudp)
2. Run [`./fpga_upgrade`](socketudp/fpga_upgrade). It should run a bunch of commands. Ask someone on the project for the root password. By default, this command will use the most recently compiled bit file from the Vivado project at [`mu2e_UEM_firmware.runs/impl_1/top_fmc228_pcie.bit`](mu2e_UEM_firmware.runs/impl_1/top_fmc228_pcie.bit). However, if you call `./fpga_upgrade original`, it will use the original bitfile packaged with the project from Minh at [`.../impl_1_old/top_fmc228_pcie_default.bit`](mu2e_UEM_firmware.runs/impl_1_old/top_fmc228_pcie_default.bit)

As a potential third method, one can run Vivado in TCL command line mode and program it remotely through that. Here is someone's GitHub project of [them doing this](https://github.com/HackerFoo/nitefury-popr/blob/master/scripts/program.tcl).

## Configuring FPGA registers for data taking

1. SSH into `mu2euem@mu2euem.dhcp.fnal.gov` (ask someone for device password).
2. Enter the command `minicomA` to open a minicom terminal window (if you haven't already)
3. If you push enter a few times, new lines should appear prefixed by `$ ` dollar signs. If nothing happens when you push enter, you need to program the FPGA (see [Programming the FPGA](#programming-the-fpga))
4. In a second SSH window, navigate to `/disk2/mu2e/mu2e_UEM_firmware/socketudp/`
5. Run [`./setup.sh`](code/setup.sh). This compiles all the required setup steps from Minh's original document into one script, along with newer recommended settings. Ask someone on the project for the root password. You should also see many of the steps the script is taking being reflected in the `minicomA` window. If they're not, the FPGA may not be properly programmed. Once this step is complete, the FPGA should be fully ready for data taking.

## Taking data
Assuming you've properly [programmed the FPGA](#programming-the-fpga) and [set up the configuration registers](#configuring-fpga-registers-for-data-taking), you can take data using the [`./udp-recv`](socketudp/udp-recv.c) program.

1. In the `/socketudp/` directory, run [`./udp-recv`](socketudp/udp-recv.c).
2. In the `minicomA` window, an important configuration is `stream off` or `stream on`. This determines whether the uTCA crate will be sending data over UDP. By default, it is off. Once the `udp-recv` file is open and waiting for data, type `stream on` in the minicomA window. After a second or two, data events should start filling the screen. If nothing comes in, check the [debugging help file](documentation_texts/debugging.md) for potential debugging steps.
3. Once you're done taking data, FIRST type `stream off` then `Ctrl+C` to stop data taking in the `/socketudp/` window. Ending the data-taking while stream is still on could result in a final corrupted data event.

## Plotting data

### Using ROOT files
- Run `make clean` and `make` in the directory: [`/FMC228_v4/`](FMC228_v4)
- Inside [`FMC228_v4/convertFMC228`](FMC228_v4/convertFMC228): [`./read_binary_FMC228_longpeakfinding_v6 <path to input root file> <path to output> <no. of events>`](FMC228_v4/convertFMC228/read_binary_FMC228_longpeakfinding_v6)
- To read this tree and plot several things : [`ShowProf_rawevent1.C`](FMC228_v4/macros/ShowProf_rawevent1.C) inside [`/FMC228_v4/macros/`](FMC228_v4/macros).

### Using `hex_check.py`
You can also use [`/socketudp/hex_check.py`](socketudp/hex_check.py) to plot data. Images go into [`/socketudp/img/`](socketudp/img). Usage of the file is like:

``python3 hex_check.py <.dat data file>``

Inside the Python file at the top in the first few lines are various configuration options that are explained by the comments in the file.

## Other misc. info
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
Following are the configurable setting registers for the FPGA operation. Their addresses are defined in the [fmc228_interface.vhd](https://github.com/prebys/mu2e_UEM_firmware/blob/ada1936a3941501a399a5fa5aaa5d0d2bbe46b55/mu2e_UEM_firmware.srcs/sources_1/fmc228_interface.vhd#L366-L396) file, and can be set by using the `poke` command in the `minicomA` window, or by modifying the setup scripts. Currently, these are all set in the [code/setup_fmc228.sh](code/setup_fmc228.sh) file, which is called by the overall [code/setup.sh](code/setup.sh) file, so unless you want to explicitly change a setting, you don't need to manual set all these configuations. 
- `cf00003c` = `0x7f` (accelerator trigger, using “trigger in” input)
- `cf000044` = `0x7fcad80` (trigger time offset)
  - How long to wait after trigger to start taking data; shorter time means more events happen more quickly
- `cf000048` = `0x64` = 100 (raw waveform length in number of packets)
  - Minh had defaulted this setting to `0x01` which resulted in *zero* raw data sent. 
  - Each network packet sent contains two raw data events, so a setting of 100 means 100 network packets which means 200 samples (200ns). Also with a setting of 100, only 198 data points come through, so looks like it's `2(n-1)`.
- `cf00004c` = `0x13` = 19 (max subevn)
  - How many subevents to record per event
  - Minh's setting of 0x1d (29) had subevents being cut off by new events before they could finish around 24~26 subevents
- `cf000038` = `0x00000001` (ADC CSR buffer)
  - Setting the second-highest byte here is what controls testmode settings. For example, setting it to `0x01000001` would output a "checkerboard" pattern through the ADC. See [testmode settings](#testmode-settings) for more info on testmode possibilities.

#### Testmode settings
Testmode settings are defined in the [adc_buffer_streamer.vhd](https://github.com/prebys/mu2e_UEM_firmware/blob/ada1936a3941501a399a5fa5aaa5d0d2bbe46b55/mu2e_UEM_firmware.srcs/sources_1/adc_buffer_streamer.vhd#L330-L347) file. They can be set by setting the second-highest bit of the ADC CSR buffer setting. For example, `poke cf000038 01000001` (`01000001` is an 8-byte hex value, not 8-bit binary).

To summarize,
- `0000`: Sends actual ADC data (testmode off, standard operation).
- `0001` (`0x1`): "checkerboard" pattern: alternates between `0xAAAA5555` and `0x5555AAAA` every clock cycle.
- `0010` (`0x2`): Permanently sends `0xFFFF0000`.
- `0011` (`0x3`): Sends one `0` bit and then 31 bits of random data every clock cycle.
- `0101` (`0x5`): Sends 17 bits of `0` and 15 bits of random data every clock cycle.
- `1001` (`0x9`): Sends the value of the variable `count`, which is defined as the value of `data_adc_length`, which shows the amount of raw_data packets that are left to be sent.
- All other testmode options will send `0xF8F8F8F8`.

Input the desired hex value into the second-highest bit in `cf000038`, so for example, `05000001` or `09000001`.

#### Trigger settings
Set the trigger mask by doing in the `minicomA` window: `poke cf00003c <mask setting`. The current default is `poke cf00003c 7f` to take input from the external trigger only. 

See more info about the trigger system in [`trigger_settings.md`](documentation_texts/trigger_settings.md).

#### ScorpionWare System
With ScorpionWare, you can power-cycle the FMC card remotely. 

1. On the mu2euem computer, type `sysmanager` in any directory. A new window should open.
2. One of the options should be for a "carrier" called uTCA. If it's not there, add a new carrier with ip address 192.168.16.1.
3. When logging in, leave username/password boxes *blank*.
4. To power-cycle the FMC card, click on it in the program and click "deactivate" then "activate". There are other options for restarting, but I'm not sure what they do.

After power-cycling the card in ScorpionWare, you'll have to [reprogram the FPGA firmware](#programming-the-fpga) and re-do [setup](#configuring-fpga-registers-for-data-taking).