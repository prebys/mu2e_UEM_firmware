### data_20260216_161012.dat
```
# Peakfinding Length: 300000000
Expected ADC length: 300000000
# Number of subevents: 80
Expected number of subevents: 80
# Raw Data Length: 0
# Peakfinding Threshold: -400
# Peak height event count: 150
Expected number of peak height events: 75
# Peak area event count: 450
# FPGA Test Mode: 0
# ADC 0 1 2 3 Enabled: (True, True, True, True)
# top_fmc228_pcie_v27.2.bit
```
Some repeating events, for example
```
<Event #964-11, 39 sub-events> - Total accumulated time 108.968208 ms over [2925, 542, 1180, 164]
<Event #1044-12, 238 sub-events> - Total accumulated time 24000000105.715702 ms over [11850, 993, 2235, 166]
<Event #1284-13, 310 sub-events> - Total accumulated time 22800000108.692032 ms over [17550, 1578, 3433, 280]
<Event #1684-14, 80 sub-events> - Total accumulated time 125.597200 ms over [6000, 461, 1059, 167]
```
Multiple events got compressed into event 12 and event 13 because 
they restarted without a proper `ff_ff_ff_ff` packet (but subevent number did reset)

Investigate some kind of solution to split up that big event into multiple events, 
or modify udp-recv to handle this case better (e.g. by checking for subevent number resets 
and starting a new event if it detects one)