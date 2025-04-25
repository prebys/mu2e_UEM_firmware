# Checking counting of events

Below data from `data_20250423_010250.dat` (10 events, 5 subevents per event, Trigger Delay = 1,000,000, Input = 100ns sine wave + Ext. Trig.)
See [images](../socketudp/img/2025.04.23_15.03.22_data_20250423_010250.dat/)
```
<EventType 'begin_event', regex 'ffffffff'>: 10
<EventType 'begin_sub_event', regex '00ffffff'>: 50
<EventType 'byte_order', regex 'f4f3f2f1'>: 50
<EventType 'fmc228_number', regex '..ccccfc'>: 50
<EventType 'sub_event_number_evn', regex '........'>: 50
<EventType 'event_number_evn', regex '........'>: 50
<EventType 'begin_raw_data', regex 'fdfdfdfd'>: 50
<EventType 'byte_order2', regex 'f4f3f2f1'>: 50
<EventType 'event_number_evn2', regex '........'>: 50
<EventType 'channel_header', regex 'fafa..fa'>: 200
<EventType 'waveform', regex 'ffff....'>: 200
<EventType 'fragment_trig_mask', regex '0000....'>: 200
<EventType 'stat', regex '........'>: 200
<EventType 'status_word', regex '........'>: 200
<EventType 'bco_low', regex '........'>: 200
<EventType 'bco_high', regex '........'>: 200
<EventType 'data_length', regex '....aaff'>: 0
<EventType 'raw_data', regex '........'>: 20000
<EventType 'end_of_channel', regex 'fbfbfbfb'>: 200
<EventType 'end_raw_data', regex 'fefefefe'>: 50
<EventType 'begin_peak_data', regex 'efefefef'>: 50
<EventType 'channel_number', regex 'eeee....'>: 200
<EventType 'peak_finding_header', regex 'aaaaaaaa'>: 200
<EventType 'peak_height_header', regex 'cccccccc'>: 200
<EventType 'peak_height_data_1', regex '........'>: 2100
<EventType 'peak_height_data_2', regex '........'>: 2100
<EventType 'peak_height_end', regex 'cececece'>: 200
<EventType 'peak_area_header', regex 'dddddddd'>: 200
<EventType 'peak_area_data', regex '........'>: 12600
<EventType 'peak_area_end', regex 'dededede'>: 200
<EventType 'end_peak_data', regex 'bbbbbbbb'>: 200
<EventType 'end_peak_channel', regex 'ecececec'>: 200
<EventType 'end_peak_stream_data', regex 'edededed'>: 50
<EventType 'end_sub_event', regex '00fcfcfc'>: 50
<EventType 'end_event', regex 'fcfcfcfc'>: 10
```

Counting events:

- Begin Event: 10
- Begin Sub Event: 50  (five subevents per event)
- Channel Header: 200 (four channels per subevent)
- Raw Data: 20,000 (100 events per channel) (20000 = 200 * 100 = 50 * 4 * 100)
- Peak Height Data 1: 2,100 (42 peaks per channel per subevent, 50 subevents total, only one channel with negative data for peaks)
  - 100ns per peak, total time = 42 * 100ns = 4.2us

Example list of peaks (half of them, headers only, not height value events) Event 0, Subevents 0 to 4 (total, 5), Channel 1
```
x = event number
y = subevent number
z = channel number
                        x y z
<Event 12000040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (72 ns)>
<Event 27e3c7e2 #125930-1-0-1 (raw_data) = DoubleADCTuple(adc1=-462, adc2=-468) (extra bytes: 119)>
<Event 67e247e2 #125930-1-0-1 (raw_data) = DoubleADCTuple(adc1=-474, adc2=-476) (extra bytes: 119)>
<Event 35e255e2 #125930-1-0-1 (raw_data) = DoubleADCTuple(adc1=-477, adc2=-475) (extra bytes: 85)>
<Event 65e2c5e2 #125930-1-0-1 (raw_data) = DoubleADCTuple(adc1=-474, adc2=-468) (extra bytes: 85)>
<Event 28e3b8e3 #125930-1-0-1 (raw_data) = DoubleADCTuple(adc1=-462, adc2=-453) (extra bytes: 136)>
# 474, 476, 477, 475, 474
# normal peak

# missing peak @ t = 172
<Event b6e426e4 #125930-1-0-1 (raw_data) = DoubleADCTuple(adc1=-437, adc2=-446) (extra bytes: 102)>
<Event 9ce33ce3 #125930-1-0-1 (raw_data) = DoubleADCTuple(adc1=-455, adc2=-461) (extra bytes: 204)>
<Event cce2bce2 #125930-1-0-1 (raw_data) = DoubleADCTuple(adc1=-468, adc2=-469) (extra bytes: 204)>
<Event dbe2dbe2 #125930-1-0-1 (raw_data) = DoubleADCTuple(adc1=-467, adc2=-467) (extra bytes: 187)>
<Event ebe23be3 #125930-1-0-1 (raw_data) = DoubleADCTuple(adc1=-466, adc2=-461) (extra bytes: 187)>
<Event aae32ae4 #125930-1-0-1 (raw_data) = DoubleADCTuple(adc1=-454, adc2=-446) (extra bytes: 170)>
# 461, 468, 469, 467, 467
# partial flat

<Event 44000040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (272 ns)>
<Event 16e4a6e3 #125931-1-1-1 (raw_data) = DoubleADCTuple(adc1=-447, adc2=-454) (extra bytes: 102)>
<Event 56e336e3 #125931-1-1-1 (raw_data) = DoubleADCTuple(adc1=-459, adc2=-461) (extra bytes: 102)>
<Event 26e336e3 #125931-1-1-1 (raw_data) = DoubleADCTuple(adc1=-462, adc2=-461) (extra bytes: 102)>
<Event 56e3b6e3 #125931-1-1-1 (raw_data) = DoubleADCTuple(adc1=-459, adc2=-453) (extra bytes: 102)>
<Event 2ee4aee4 #125931-1-1-1 (raw_data) = DoubleADCTuple(adc1=-446, adc2=-438) (extra bytes: 238)>
# 459, 461, **462**, 461, 459
# normal peak

<Event 5d000050 #125930-1-0-1 (peak_height_data_1) = Peak #1 (372 ns)>
<Event 9fe50fe5 #125931-1-1-1 (raw_data) = DoubleADCTuple(adc1=-423, adc2=-432) (extra bytes: 255)>
<Event 7fe42fe4 #125931-1-1-1 (raw_data) = DoubleADCTuple(adc1=-441, adc2=-446) (extra bytes: 255)>
<Event cfe3cfe3 #125931-1-1-1 (raw_data) = DoubleADCTuple(adc1=-452, adc2=-452) (extra bytes: 255)>
<Event cde3bde3 #125931-1-1-1 (raw_data) = DoubleADCTuple(adc1=-452, adc2=-453) (extra bytes: 221)>
<Event dde32de4 #125931-1-1-1 (raw_data) = DoubleADCTuple(adc1=-451, adc2=-446) (extra bytes: 221)>
<Event 81e421e5 #125931-1-1-1 (raw_data) = DoubleADCTuple(adc1=-440, adc2=-430) (extra bytes: 17)>
# 452, 452, 452, **453**, 453, 451, 446
# partial flat

<Event 76000040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (472 ns)>
<Event 44e4c4e3 #125935-2-0-1 (raw_data) = DoubleADCTuple(adc1=-444, adc2=-452) (extra bytes: 68)>
<Event 24e3b4e2 #125935-2-0-1 (raw_data) = DoubleADCTuple(adc1=-462, adc2=-469) (extra bytes: 68)>
<Event 72e262e2 #125935-2-0-1 (raw_data) = DoubleADCTuple(adc1=-473, adc2=-474) (extra bytes: 34)>
<Event 32e242e2 #125935-2-0-1 (raw_data) = DoubleADCTuple(adc1=-477, adc2=-476) (extra bytes: 34)>
<Event 69e2c9e2 #125935-2-0-1 (raw_data) = DoubleADCTuple(adc1=-474, adc2=-468) (extra bytes: 153)>
<Event 29e3a9e3 #125935-2-0-1 (raw_data) = DoubleADCTuple(adc1=-462, adc2=-454) (extra bytes: 153)>
<Event 5de42de5 #125935-2-0-1 (raw_data) = DoubleADCTuple(adc1=-443, adc2=-430) (extra bytes: 221)>
# 469, 473, 474, **477**, 476, 474, 468

<Event a8000040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (672 ns)>



<Event 0c010040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (1072 ns)>
<Event 3e010040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (1272 ns)>
<Event 57010040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (1372 ns)>
<Event 70010040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (1472 ns)>
<Event a2010040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (1672 ns)>
<Event ba010070 #125930-1-0-1 (peak_height_data_1) = Peak #3 (1768 ns)>
<Event d3010070 #125930-1-0-1 (peak_height_data_1) = Peak #3 (1868 ns)>
<Event ec010070 #125930-1-0-1 (peak_height_data_1) = Peak #3 (1968 ns)>
<Event 1f020040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (2172 ns)>
<Event 37020070 #125930-1-0-1 (peak_height_data_1) = Peak #3 (2268 ns)>
<Event 51020040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (2372 ns)>
<Event 83020040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (2572 ns)>
<Event 9c020040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (2672 ns)>
<Event b4020070 #125930-1-0-1 (peak_height_data_1) = Peak #3 (2768 ns)>
<Event ce020040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (2872 ns)>
<Event e6020070 #125930-1-0-1 (peak_height_data_1) = Peak #3 (2968 ns)>
<Event 00030050 #125930-1-0-1 (peak_height_data_1) = Peak #1 (3072 ns)>
<Event 32030040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (3272 ns)>
<Event 4b030040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (3372 ns)>
<Event 64030040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (3472 ns)>
<Event 38060070 #125930-1-0-1 (peak_height_data_1) = Peak #3 (6368 ns)>
<Event 52060040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (6472 ns)>
<Event 6b060040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (6572 ns)>
<Event 83060070 #125930-1-0-1 (peak_height_data_1) = Peak #3 (6668 ns)>
<Event 9d060040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (6772 ns)>
<Event b5060070 #125930-1-0-1 (peak_height_data_1) = Peak #3 (6868 ns)>
<Event e8060040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (7072 ns)>
<Event 01070040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (7172 ns)>
<Event 1a070040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (7272 ns)>
<Event 33070040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (7372 ns)>
<Event 4c070040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (7472 ns)>
<Event 65070040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (7572 ns)>
<Event 7d070070 #125930-1-0-1 (peak_height_data_1) = Peak #3 (7668 ns)>
<Event 96070070 #125930-1-0-1 (peak_height_data_1) = Peak #3 (7768 ns)>
<Event af070070 #125930-1-0-1 (peak_height_data_1) = Peak #3 (7868 ns)>
<Event c9070040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (7972 ns)>
<Event e2070040 #125930-1-0-1 (peak_height_data_1) = Peak #0 (8072 ns)>
<Event fa070070 #125931-1-1-1 (peak_height_data_1) = Peak #3 (8168 ns)>
<Event 14080040 #125931-1-1-1 (peak_height_data_1) = Peak #0 (8272 ns)>
<Event 2d080040 #125931-1-1-1 (peak_height_data_1) = Peak #0 (8372 ns)>
<Event 46080040 #125931-1-1-1 (peak_height_data_1) = Peak #0 (8472 ns)>
<Event 5f080040 #125931-1-1-1 (peak_height_data_1) = Peak #0 (8572 ns)>
<Event 77080070 #125931-1-1-1 (peak_height_data_1) = Peak #3 (8668 ns)>
<Event 91080040 #125931-1-1-1 (peak_height_data_1) = Peak #0 (8772 ns)>
<Event aa080040 #125931-1-1-1 (peak_height_data_1) = Peak #0 (8872 ns)>
<Event c2080070 #125931-1-1-1 (peak_height_data_1) = Peak #3 (8968 ns)>
<Event dc080040 #125931-1-1-1 (peak_height_data_1) = Peak #0 (9072 ns)>
<Event f5080040 #125931-1-1-1 (peak_height_data_1) = Peak #0 (9172 ns)>
<Event 0e090040 #125931-1-1-1 (peak_height_data_1) = Peak #0 (9272 ns)>
<Event 27090040 #125931-1-1-1 (peak_height_data_1) = Peak #0 (9372 ns)>
<Event 3f090070 #125931-1-1-1 (peak_height_data_1) = Peak #3 (9468 ns)>
<Event 58090070 #125931-1-1-1 (peak_height_data_1) = Peak #3 (9568 ns)>
<Event 71090070 #125931-1-1-1 (peak_height_data_1) = Peak #3 (9668 ns)>
<Event 8b090040 #125931-1-1-1 (peak_height_data_1) = Peak #0 (9772 ns)>
<Event a3090070 #125931-1-1-1 (peak_height_data_1) = Peak #3 (9868 ns)>
<Event bd090040 #125931-1-1-1 (peak_height_data_1) = Peak #0 (9972 ns)>
<Event d6090040 #125931-1-1-1 (peak_height_data_1) = Peak #0 (10072 ns)>
<Event ef090040 #125931-1-1-1 (peak_height_data_1) = Peak #0 (10172 ns)>
<Event 080a0040 #125931-1-1-1 (peak_height_data_1) = Peak #0 (10272 ns)>
<Event 200a0070 #125931-1-1-1 (peak_height_data_1) = Peak #3 (10368 ns)>
<Event 390a0070 #125931-1-1-1 (peak_height_data_1) = Peak #3 (10468 ns)>
<Event 850a0040 #125931-1-1-1 (peak_height_data_1) = Peak #0 (10772 ns)>
<Event 9e0a0040 #125931-1-1-1 (peak_height_data_1) = Peak #0 (10872 ns)>
<Event b60a0070 #125931-1-1-1 (peak_height_data_1) = Peak #3 (10968 ns)>
<Event cf0a0070 #125931-1-1-1 (peak_height_data_1) = Peak #3 (11068 ns)>
<Event e90a0040 #125931-1-1-1 (peak_height_data_1) = Peak #0 (11172 ns)>
<Event 1a0b0070 #125931-1-1-1 (peak_height_data_1) = Peak #3 (11368 ns)>
<Event 330b0070 #125931-1-1-1 (peak_height_data_1) = Peak #3 (11468 ns)>
<Event 660b0040 #125931-1-1-1 (peak_height_data_1) = Peak #0 (11672 ns)>
<Event 7f0b0050 #125931-1-1-1 (peak_height_data_1) = Peak #1 (11772 ns)>
<Event 970b0060 #125931-1-1-1 (peak_height_data_1) = Peak #2 (11868 ns)>
<Event ca0b0040 #125931-1-1-1 (peak_height_data_1) = Peak #0 (12072 ns)>
<Event e30b0040 #125931-1-1-1 (peak_height_data_1) = Peak #0 (12172 ns)>
<Event fb0b0060 #125931-1-1-1 (peak_height_data_1) = Peak #2 (12268 ns)>
<Event 140c0070 #125931-1-1-1 (peak_height_data_1) = Peak #3 (12368 ns)>
<Event 780c0070 #125931-1-1-1 (peak_height_data_1) = Peak #3 (12768 ns)>
<Event 910c0060 #125931-1-1-1 (peak_height_data_1) = Peak #2 (12868 ns)>
<Event c40c0040 #125931-1-1-1 (peak_height_data_1) = Peak #0 (13072 ns)>
<Event 0f0d0040 #125931-1-1-1 (peak_height_data_1) = Peak #0 (13372 ns)>
<Event fc0f0070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (16368 ns)>
<Event 15100070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (16468 ns)>
<Event 2e100070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (16568 ns)>
<Event 2f100040 #125932-1-2-1 (peak_height_data_1) = Peak #0 (16572 ns)>
<Event 47100070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (16668 ns)>
<Event 60100070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (16768 ns)>
<Event 79100070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (16868 ns)>
<Event 93100040 #125932-1-2-1 (peak_height_data_1) = Peak #0 (16972 ns)>
<Event ab100070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (17068 ns)>
<Event c5100040 #125932-1-2-1 (peak_height_data_1) = Peak #0 (17172 ns)>
<Event dd100070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (17268 ns)>
<Event f6100070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (17368 ns)>
<Event 0f110070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (17468 ns)>
<Event 28110070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (17568 ns)>
<Event 5a110070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (17768 ns)>
<Event 74110040 #125932-1-2-1 (peak_height_data_1) = Peak #0 (17872 ns)>
<Event 8c110070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (17968 ns)>
<Event a5110070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (18068 ns)>
<Event bf110040 #125932-1-2-1 (peak_height_data_1) = Peak #0 (18172 ns)>
<Event f0110070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (18368 ns)>
<Event 09120070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (18468 ns)>
<Event 23120040 #125932-1-2-1 (peak_height_data_1) = Peak #0 (18572 ns)>
<Event 3b120060 #125932-1-2-1 (peak_height_data_1) = Peak #2 (18668 ns)>
<Event 54120070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (18768 ns)>
<Event 6d120070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (18868 ns)>
<Event 87120040 #125932-1-2-1 (peak_height_data_1) = Peak #0 (18972 ns)>
<Event a0120040 #125932-1-2-1 (peak_height_data_1) = Peak #0 (19072 ns)>
<Event b8120070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (19168 ns)>
<Event d2120040 #125932-1-2-1 (peak_height_data_1) = Peak #0 (19272 ns)>
<Event ea120070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (19368 ns)>
<Event 36130040 #125932-1-2-1 (peak_height_data_1) = Peak #0 (19672 ns)>
<Event 4e130060 #125932-1-2-1 (peak_height_data_1) = Peak #2 (19768 ns)>
<Event 67130070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (19868 ns)>
<Event 9a130040 #125932-1-2-1 (peak_height_data_1) = Peak #0 (20072 ns)>
<Event b3130040 #125932-1-2-1 (peak_height_data_1) = Peak #0 (20172 ns)>
<Event fd130060 #125932-1-2-1 (peak_height_data_1) = Peak #2 (20468 ns)>
<Event 16140060 #125932-1-2-1 (peak_height_data_1) = Peak #2 (20568 ns)>
<Event 2f140070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (20668 ns)>
<Event 48140070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (20768 ns)>
<Event 62140040 #125932-1-2-1 (peak_height_data_1) = Peak #0 (20872 ns)>
<Event 93140070 #125932-1-2-1 (peak_height_data_1) = Peak #3 (21068 ns)>
<Event f7140060 #125932-1-2-1 (peak_height_data_1) = Peak #2 (21468 ns)>
<Event 10150070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (21568 ns)>
<Event 29150070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (21668 ns)>
<Event 43150040 #125933-1-3-1 (peak_height_data_1) = Peak #0 (21772 ns)>
<Event 75150040 #125933-1-3-1 (peak_height_data_1) = Peak #0 (21972 ns)>
<Event a6150070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (22168 ns)>
<Event bf150070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (22268 ns)>
<Event d8150070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (22368 ns)>
<Event f1150070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (22468 ns)>
<Event 3c160070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (22768 ns)>
<Event 6f160040 #125933-1-3-1 (peak_height_data_1) = Peak #0 (22972 ns)>
<Event a0160070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (23168 ns)>
<Event b9160070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (23268 ns)>
<Event d2160060 #125933-1-3-1 (peak_height_data_1) = Peak #2 (23368 ns)>
<Event c0190070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (26368 ns)>
<Event d9190070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (26468 ns)>
<Event f3190040 #125933-1-3-1 (peak_height_data_1) = Peak #0 (26572 ns)>
<Event 0c1a0040 #125933-1-3-1 (peak_height_data_1) = Peak #0 (26672 ns)>
<Event 241a0070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (26768 ns)>
<Event 3d1a0070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (26868 ns)>
<Event 571a0040 #125933-1-3-1 (peak_height_data_1) = Peak #0 (26972 ns)>
<Event 6f1a0070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (27068 ns)>
<Event 891a0040 #125933-1-3-1 (peak_height_data_1) = Peak #0 (27172 ns)>
<Event a11a0070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (27268 ns)>
<Event ba1a0070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (27368 ns)>
<Event d31a0070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (27468 ns)>
<Event ec1a0070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (27568 ns)>
<Event 061b0040 #125933-1-3-1 (peak_height_data_1) = Peak #0 (27672 ns)>
<Event 1e1b0060 #125933-1-3-1 (peak_height_data_1) = Peak #2 (27768 ns)>
<Event 371b0070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (27868 ns)>
<Event 501b0070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (27968 ns)>
<Event 6a1b0040 #125933-1-3-1 (peak_height_data_1) = Peak #0 (28072 ns)>
<Event 821b0070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (28168 ns)>
<Event 9c1b0040 #125933-1-3-1 (peak_height_data_1) = Peak #0 (28272 ns)>
<Event b51b0040 #125933-1-3-1 (peak_height_data_1) = Peak #0 (28372 ns)>
<Event ce1b0040 #125933-1-3-1 (peak_height_data_1) = Peak #0 (28472 ns)>
<Event e61b0070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (28568 ns)>
<Event 001c0040 #125933-1-3-1 (peak_height_data_1) = Peak #0 (28672 ns)>
<Event 181c0060 #125933-1-3-1 (peak_height_data_1) = Peak #2 (28768 ns)>
<Event 311c0070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (28868 ns)>
<Event 4a1c0070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (28968 ns)>
<Event 631c0070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (29068 ns)>
<Event 7c1c0070 #125933-1-3-1 (peak_height_data_1) = Peak #3 (29168 ns)>
<Event ae1c0060 #125934-1-4-1 (peak_height_data_1) = Peak #2 (29368 ns)>
<Event c71c0060 #125934-1-4-1 (peak_height_data_1) = Peak #2 (29468 ns)>
<Event e01c0070 #125934-1-4-1 (peak_height_data_1) = Peak #3 (29568 ns)>
<Event f91c0070 #125934-1-4-1 (peak_height_data_1) = Peak #3 (29668 ns)>
<Event 121d0070 #125934-1-4-1 (peak_height_data_1) = Peak #3 (29768 ns)>
<Event 2b1d0060 #125934-1-4-1 (peak_height_data_1) = Peak #2 (29868 ns)>
<Event 441d0070 #125934-1-4-1 (peak_height_data_1) = Peak #3 (29968 ns)>
<Event 5e1d0040 #125934-1-4-1 (peak_height_data_1) = Peak #0 (30072 ns)>
<Event 761d0070 #125934-1-4-1 (peak_height_data_1) = Peak #3 (30168 ns)>
<Event a91d0040 #125934-1-4-1 (peak_height_data_1) = Peak #0 (30372 ns)>
<Event c11d0070 #125934-1-4-1 (peak_height_data_1) = Peak #3 (30468 ns)>
<Event da1d0060 #125934-1-4-1 (peak_height_data_1) = Peak #2 (30568 ns)>
<Event f31d0070 #125934-1-4-1 (peak_height_data_1) = Peak #3 (30668 ns)>
<Event f41d0040 #125934-1-4-1 (peak_height_data_1) = Peak #0 (30672 ns)>
<Event 0c1e0060 #125934-1-4-1 (peak_height_data_1) = Peak #2 (30768 ns)>
<Event 251e0070 #125934-1-4-1 (peak_height_data_1) = Peak #3 (30868 ns)>
<Event 3e1e0060 #125934-1-4-1 (peak_height_data_1) = Peak #2 (30968 ns)>
<Event bb1e0070 #125934-1-4-1 (peak_height_data_1) = Peak #3 (31468 ns)>
<Event bc1e0040 #125934-1-4-1 (peak_height_data_1) = Peak #0 (31472 ns)>
<Event d41e0060 #125934-1-4-1 (peak_height_data_1) = Peak #2 (31568 ns)>
<Event ed1e0070 #125934-1-4-1 (peak_height_data_1) = Peak #3 (31668 ns)>
<Event 061f0060 #125934-1-4-1 (peak_height_data_1) = Peak #2 (31768 ns)>
<Event 1f1f0070 #125934-1-4-1 (peak_height_data_1) = Peak #3 (31868 ns)>
<Event 381f0070 #125934-1-4-1 (peak_height_data_1) = Peak #3 (31968 ns)>
<Event 6a1f0060 #125934-1-4-1 (peak_height_data_1) = Peak #2 (32168 ns)>
<Event 841f0040 #125934-1-4-1 (peak_height_data_1) = Peak #0 (32272 ns)>
<Event b51f0070 #125934-1-4-1 (peak_height_data_1) = Peak #3 (32468 ns)>
<Event ce1f0070 #125934-1-4-1 (peak_height_data_1) = Peak #3 (32568 ns)>
<Event 19200050 #125934-1-4-1 (peak_height_data_1) = Peak #1 (32868 ns)>
<Event 32200070 #125934-1-4-1 (peak_height_data_1) = Peak #3 (32968 ns)>
<Event 65200040 #125934-1-4-1 (peak_height_data_1) = Peak #0 (33172 ns)>
<Event 97200040 #125934-1-4-1 (peak_height_data_1) = Peak #0 (33372 ns)>
<Event 84230060 #125934-1-4-1 (peak_height_data_1) = Peak #2 (36368 ns)>
<Event 9d230060 #125934-1-4-1 (peak_height_data_1) = Peak #2 (36468 ns)>
<Event b6230060 #125934-1-4-1 (peak_height_data_1) = Peak #2 (36568 ns)>
<Event cf230070 #125934-1-4-1 (peak_height_data_1) = Peak #3 (36668 ns)>
<Event e8230060 #125934-1-4-1 (peak_height_data_1) = Peak #2 (36768 ns)>
<Event 01240070 #125934-1-4-1 (peak_height_data_1) = Peak #3 (36868 ns)>
<Event 1a240070 #125934-1-4-1 (peak_height_data_1) = Peak #3 (36968 ns)>
<Event 33240070 #125934-1-4-1 (peak_height_data_1) = Peak #3 (37068 ns)>
<Event 4c240070 #125934-1-4-1 (peak_height_data_1) = Peak #3 (37168 ns)>
<Event 65240070 #125934-1-4-1 (peak_height_data_1) = Peak #3 (37268 ns)>
```