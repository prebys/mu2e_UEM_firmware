top_fmc228_pcie_v1.bit: 
	Should be default file with no modifications (it is unclear whether this is the original "top_fmc228_pcie_newAlgPeak_v7.bit", or a recompiled bitfile from the Vivado project)

top_fmc228_pcie_v2.bit:
	Only has modification in ignoring fifo_ready signal when tm_r = "0001" to send ADC data

top_fmc228_pcie_v3.bit: 
	A recompiled bitfile from the default Vivado project. Ideally should work (testing result: seems fine, see /socketudp/img/2025.02.11_16.57.57_data_20250211_165709.dat/)
