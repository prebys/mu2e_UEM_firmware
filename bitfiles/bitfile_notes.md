top_fmc228_pcie_newAlgPeak_v7.bit:
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

Other than the date strings in the beginning (shown), the rest of the bitfiles for v1, v3, v4 are 100% identical, as well as to Minh's original file

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
