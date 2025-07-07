Simple instructions for taking data

1. SSH into the mu2euem computer at `mu2euem@mu2euem.dhcp.fnal.gov`.

2. Navigate to the mu2e directory by typing `mu2e` in terminal.

3. In a separate window, open a new terminal window and type `minicomA` to open a minicom window.

4. The bitfiles are all stored in the `bitfiles` directory. `v01` is the original bitfile and can work for tests. 

5. Load a bitfile by running in the `socketudp` directory the `fpga_upgrade` script. For example, 
```
cd socketudp
./fpga_upgrade ../bitfiles/top_fmc228_pcie_v01.bit
```

5. This will start a long process of configurations. Eventually it will ask you to check the minicom window to make sure it says "Ready". Push any key when you see that. It will run one last stage of configurations.

6. Run `./udp_recv` in `socketudp` directory.

7. In minicom window, type `stream on` to start the streaming of data.

8. Type `stream off` in minicom then press `Ctrl + C` in the `udp_recv` window to stop datataking whenever you're ready.

9. The datafile will be saved in the `socketudp/data/` directory. Plot it using `python3 hex_check.py`. It will automatically take the newest data file from the /data/ directory.

To change ADC and trigger settings easily, find the `../code/adc_trigger_settings.py` file and open it and modify the settings at the top of the file. Once you have the settings you want, run the file with `python3 adc_trigger_settings.py`.
