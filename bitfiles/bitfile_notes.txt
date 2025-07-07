top_fmc228_pcie_newAlgPeak_v7.bit:
	Renamed from "top_fmc228_pcie_newAlgPeak_v7.bit"
	Minh's original bitfile.
	top_fmc228_pcie;UserID=0XFFFFFFFF;COMPRESS=TRUE;Version=2016.2 b 7k420tffg1156 c 2021/04/15 d 	21:21:38

------------------------------

top_fmc228_pcie_v1.bit: 
Should be default file with no modifications
top_fmc228_pcie;COMPRESS=TRUE;UserID=0XFFFFFFFF;Version=2016.2 b 7k420tffg1156 c 2024/07/03 d 	14:08:51

top_fmc228_pcie_v2.bit:
Only has modification in ignoring fifo_ready signal when tm_r = "0001" to send ADC data
top_fmc228_pcie;COMPRESS=TRUE;UserID=0XFFFFFFFF;Version=2016.2 b 7k420tffg1156 c 2024/07/10 d 	11:03:08

top_fmc228_pcie_v3.bit:
Should be same as v1
top_fmc228_pcie;COMPRESS=TRUE;UserID=0XFFFFFFFF;Version=2016.2 b 7k420tffg1156 c 2025/02/10 d 	12:29:21

top_fmc228_pcie_v4.bit:
Not sure why this was regenerated, but it was probably from the "minimal" branch of the project
top_fmc228_pcie;COMPRESS=TRUE;UserID=0XFFFFFFFF;Version=2016.2 b 7k420tffg1156 c 2025/02/12 d 	16:09:05

# ##############
Other than the date strings in the beginning (shown), the rest of the bitfiles for v1, v3, v4 are 100% identical, as well as to Minh's original file
# ##############

v5:
Removed peakfinding module

v6:
Peakfinding still gone
Added "DataLength" event to show how many ADC will be sent
Added lower two bytes of remaining ADC count into the two unused bytes of f1f2f3f4

v7: 
Same as v6, + changed format of SendDataLength to start with "ffaa"
Also, "count" variable is changed from adc_data_length to adc_data_length + 1

v8:
Trying to fix problem with some subevents reading like 1.244 for first subevent
Set "sumarea_rden" to 0 in SendDataSum_wait

v9:
v7 + Redid the way I removed peakfinding to hopefully avoid error with FF FF FF FF duplication at start of UDP packets

v10:
v7 + Reverted peakfinding to v1

v11:
I *think* it's the original bit file, normal peakfinding, normal adc event buffer, but just with the adc trigger bug fixed with second counter. Something is wrong with this bitfile, for some reason ./setup never works with this bitfile.

v12:
Bitwise exactly same as v1.

v13:
v1/v12 + Readd negative overflow fix. Lots of duplicate FF FF FF FF errors with trigger_offset at 7fcad80 or 0

v14:
v1 + if (delay_count > x"00000000") then delay_count <= delay_count - 1; end if;

v15: 
4/26/2025  Simplified peakfinding files a bit by removing comments and also converting data latches to sample arrays (completely failed! programmign fpga worked but couldn't run ./setup)

v16:
4/28/2025  Undid changes above to peakfinding modules. 
Seems I've accidentally recreated v13. I didn't mean to include the overflow fix.

v17:
4/29/2025  Removed overflow fix, and removed all comments and old code from peakfinding. Result is v01.

v18: 
5/17/2025: Converted sumarea_module.vhd to use new functions for all logic and a convenient loop. However, inserted improper threshold setting.  

v19: 
5/17/2025: Fixed threshold bug from previous version.

v20:
5/19/2025: Changed .elf file for minicom window to fix rspi/wspi spacing bug

v21:
5/21/2025: Added triangle wave test mode to adc_buffer file for testing peakfinding
