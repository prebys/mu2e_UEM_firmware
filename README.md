This repository documents the Xilinx Vivado project required to run the FPGA in the Vadatech microTCA crate. Main instructions are found here: https://eprebys.faculty.ucdavis.edu/mu2e-uem-microtca-firmware-notes/

For help installing ROOT and Vivado on AlmaLinux, see [this page](documentation_texts/software_installation_tips.md).

The original state of this repository as it was left by Minh on the UEM computer before the recompiling and reformatting can be found in the [original-minh branch](https://github.com/prebys/mu2e_UEM_firmware/tree/original-minh). 

Minh's original instructions for operation of the Vadatech crate are found in [mu2e-docdb:40514](https://mu2e-docdb.fnal.gov/cgi-bin/sso/ShowDocument?docid=40514).

Main bitfile to be used when programming the FPGA is [bitfiles/top_fmc228_pcie_v1.bit](bitfiles/top_fmc228_pcie_v1.bit)

### How to take data

1. SSH into `mu2euem@mu2euem.dhcp.fnal.gov`. 
2. Enter the command `minicomA`
3. If you push enter a few times, new lines should appear prefixed by `$ ` dollar signs. If nothing happens when you push enter, you need to program the FPGA (see [Programming the FPGA](#programming-the-fpga))
4. In a second SSH window, navigate to `/disk2/mu2e/mu2e_UEM_firmware/socketudp/`
5. Run `./newsetup.sh`. This compiles all the required setup steps from Minh's original document into one script, along with newer recommended settings. Ask someone on the project for the root password.
6. In the /socketudp/ directory, run `./udp-recv`.
7. In the minicomA window, an important configuration is `stream off` or `stream on`. This determines whether the uTCA crate will be sending data over UDP. By default, it is off. Once the `udp-recv` file is open and waiting for data, type `stream on` in the minicomA window.
8. Once you're done taking data, FIRST type `stream off` then `Ctrl+C` to stop data taking in the /socketudp/ window.

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
- make clean and make in the directory: FMC228_v4
- Inside FMC228_v4/convertFMC228: `./read_binary_FMC228_longpeakfinding_v6 <path to input root file> <path to output> <no. of events>`
- To read this tree and plot several things : `ShowProf_rawevent1.C` inside /macros.
