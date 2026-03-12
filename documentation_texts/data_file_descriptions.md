### data_20260216_161012.dat (v27.2)
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

--------------------

### data_20260227_135023.dat (v27.4) 

I think useless? Not sure why. Only channel 1 / 2 have data and it's random noise.

------------

### data_20260303_134443.dat

Run from March 3rd to March 6th, including all overnight run. 
Splitting data file into parts. 

- `data_20260303_134443_part1.dat`
  - 366 events, March 3rd, 13:44-18:06
- `data_20260303_134443_2026.03.04_09.36.40.dat`:
  - Unchecked data, 337 events
  - March 4th, 09:32:40, Event #68603-1, 
  - to March 4th, 16:51:41, Event #122803-337,
  - Main day run of studies on March 4th
  - Events 1-16 (68603-70403), 9:30 - 11:30: Dual injection testing (\$9A / \$9B)
  - Events 17-333 (77703-122203), 11:30 - 16:45
  - Events 334-337 (122403-122803), 16:48 - 16:51, not sure what these are
- `data_20260303_134443_2026.03.04_16.53.41.dat` 
  - Events 1-36 (122903-127203), 16:54 - 17:27, nighttime configuration
  - Events 37-44 (127303-128203), 17:30 - 17:36
  - Events 45-110 (128303-136803), 17:37 - 18:39 (note event #110 is basically empty)
- `data_20260303_134443_2026.03.04_18.40.55.dat`
  - Events 1-914 (-248503), Mar 4 18:40 - Mar 5 7:39
- `data_20260303_134443_2026.03.05_10.05.49.dat`
  - Events - (255503-), 10:05 -