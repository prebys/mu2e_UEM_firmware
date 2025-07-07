In [src/sdk](../vivado_project/src/sdk) you can find the following files:

```
monitor_fmc228_pcie.c
monitor_amc502_fmc228.c
monitor_fmc228_pcie_orginal.c
monitor_amc502_fmc228_original.c             
monitor_amc502_fmc228_original_Nov11_2019.c  -- 1420 lines, all four files up top here are the same

monitor_fmc228_pcie_v2.c                     -- 1514 lines, add adc2/adc3 to rspi/wspi function compared to Nov11
monitor_amc502_fmc228_Nov24.c                -- 1845 lines, add adc2/adc3 compared to above
monitor_amc502_fmc228_new.c                  -- 1833 lines, add lmk/hmc cards to setup/rspi/wspi compared to above
```
The first five are all the same. The Vivado project uses `monitor_amc502_fmc228.c` and the generated 
`monitor_amc502_fmc228.elf` file. This document is how to make that file. 

1. Open Xilinx SDK (it's possible your installation of Vivado does not come with this)
2. Open Xilinx Tools > XMD Console
3. Navigate to [`src/sdk/monitor_amc502/Debug`](../vivado_project/src/sdk/monitor_amc502/Debug)
4. Run `make -f makefile clean all`
5. It should re-generate you a `monitor_amc502_fmc228.elf` file

If you want to try loading the project into the SDK program, it's important to disable "auto-build makefile" in the 
project settings, because otherwise it will try to build the project using the wrong makefile. I had to import the 
project, then change the setting, then use PyCharm to revert the project to the original state since importing the 
project to access the project settings changed the project files.

Then load that generated `monitor_amc502_fmc228.elf` file into the Vivado project and reassociate it with the 
microblaze IP instance.