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


2025/05/16
data_20250516_182203.dat

Recording 10 events with 1 subevent each, 100 raw data per event. Function generator is set to 10,000ns period of modulation for a 100ns sine wave. We should expect a decrease of about 50μV per ns, or 5mV per 100ns, assuming starting amplitude of +/- 0.5V.

Peakfinding window length is set to hex 0x4E20 = 20000.

Note that originally the start of the sine wave was synchronized to the start of the modulation but now it's not, so the start of the data right now is with the sine wave already at -0.001V for peaks.

Example peaks for first event:

<Event 14000040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (80 ns)>
<Event f2ff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event 1c000060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (112 ns)>
<Event f7ff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event 34000040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (208 ns)>
<Event f4ff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event 59000060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (356 ns)>
<Event feff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event 64000050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (400 ns)>
<Event 06000000 #200297-1-0-1 (peak_height_data_2) = 0 (0.0 V)>
<Event 6f000060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (444 ns)>
<Event f5ff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event 90000050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (576 ns)>
<Event f6ff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event 91000060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (580 ns)>
<Event feff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event ae000050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (696 ns)>
<Event f7ff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event d8000040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (864 ns)>
<Event e2ff0000 #200297-1-0-1 (peak_height_data_2) = -2 (-0.001 V)>
<Event dd000050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (884 ns)>
<Event f7ff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event e5000050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (916 ns)>
<Event fcff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event f0000040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (960 ns)>
<Event 03000000 #200297-1-0-1 (peak_height_data_2) = 0 (0.0 V)>
<Event 04010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1040 ns)>
<Event f5ff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event 0e010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1080 ns)>
<Event fcff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event 19010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1124 ns)>
<Event f4ff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event 20010050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (1152 ns)>
<Event f6ff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event 2c010050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (1200 ns)>
<Event e0ff0000 #200297-1-0-1 (peak_height_data_2) = -2 (-0.001 V)>
<Event 39010050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (1252 ns)>
<Event 09000000 #200297-1-0-1 (peak_height_data_2) = 0 (0.0 V)>
<Event 5e010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1400 ns)>
<Event f1ff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event 60010050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (1408 ns)>
<Event eeff0000 #200297-1-0-1 (peak_height_data_2) = -2 (-0.001 V)>
<Event 70010050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (1472 ns)>
<Event f7ff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event 7b010050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (1516 ns)>
<Event 02000000 #200297-1-0-1 (peak_height_data_2) = 0 (0.0 V)>
<Event 82010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1544 ns)>
<Event f4ff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event 84010040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (1552 ns)>
<Event f4ff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event 94010050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (1616 ns)>
<Event edff0000 #200297-1-0-1 (peak_height_data_2) = -2 (-0.001 V)>
<Event 96010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1624 ns)>
<Event 04000000 #200297-1-0-1 (peak_height_data_2) = 0 (0.0 V)>
<Event 9d010050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (1652 ns)>
<Event f8ff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event 9f010050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (1660 ns)>
<Event faff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event a1010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1668 ns)>
<Event fcff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event b6010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1752 ns)>
<Event f1ff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event c5010040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (1812 ns)>
<Event e2ff0000 #200297-1-0-1 (peak_height_data_2) = -2 (-0.001 V)>
<Event d2010070 #200297-1-0-1 (peak_height_data_1) = Peak #3 (1864 ns)>
<Event f5ff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event ed010070 #200297-1-0-1 (peak_height_data_1) = Peak #3 (1972 ns)>
<Event e3ff0000 #200297-1-0-1 (peak_height_data_2) = -2 (-0.001 V)>
<Event fe010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (2040 ns)>
<Event fcff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event 15020040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (2132 ns)>
<Event fdff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event 16020040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (2136 ns)>
<Event f0ff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event 34020060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (2256 ns)>
<Event 00000000 #200297-1-0-1 (peak_height_data_2) = 0 (0.0 V)>
<Event 3b020060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (2284 ns)>
<Event f9ff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event 4b020060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (2348 ns)>
<Event f6ff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event 5c020040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (2416 ns)>
<Event f8ff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event 5e020050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (2424 ns)>
<Event f4ff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event 20000060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (128 ns)>
<Event 00000000 #200297-1-0-1 (peak_height_data_2) = 0 (0.0 V)>
<Event 27000070 #200297-1-0-1 (peak_height_data_1) = Peak #3 (156 ns)>
<Event 18000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event 35000050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (212 ns)>
<Event 12000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event 37000040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (220 ns)>
<Event 11000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event 44000060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (272 ns)>
<Event 16000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event 6f000060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (444 ns)>
<Event 05000000 #200297-1-0-1 (peak_height_data_2) = 0 (0.0 V)>
<Event 70000070 #200297-1-0-1 (peak_height_data_1) = Peak #3 (448 ns)>
<Event 24000000 #200297-1-0-1 (peak_height_data_2) = 2 (0.001 V)>
<Event 78000040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (480 ns)>
<Event 1b000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event 7f000050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (508 ns)>
<Event 11000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event 90000060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (576 ns)>
<Event 16000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event 97000070 #200297-1-0-1 (peak_height_data_1) = Peak #3 (604 ns)>
<Event 16000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event 9a000070 #200297-1-0-1 (peak_height_data_1) = Peak #3 (616 ns)>
<Event 1c000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event ba000060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (744 ns)>
<Event 14000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event e6000040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (920 ns)>
<Event 17000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event 12010040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (1096 ns)>
<Event 09000000 #200297-1-0-1 (peak_height_data_2) = 0 (0.0 V)>
<Event 2b010050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (1196 ns)>
<Event 10000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event 2d010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1204 ns)>
<Event 11000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event 35010040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (1236 ns)>
<Event 16000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event 47010050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (1308 ns)>
<Event 17000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event 4e010050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (1336 ns)>
<Event 04000000 #200297-1-0-1 (peak_height_data_2) = 0 (0.0 V)>
<Event 63010050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (1420 ns)>
<Event 14000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event 79010040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (1508 ns)>
<Event 12000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event 96010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1624 ns)>
<Event 14000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event a9010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1700 ns)>
<Event 0a000000 #200297-1-0-1 (peak_height_data_2) = 0 (0.0 V)>
<Event c0010050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (1792 ns)>
<Event 14000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event c4010050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (1808 ns)>
<Event 13000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event c9010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1828 ns)>
<Event 14000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event e3010050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (1932 ns)>
<Event 09000000 #200297-1-0-1 (peak_height_data_2) = 0 (0.0 V)>
<Event ee010070 #200297-1-0-1 (peak_height_data_1) = Peak #3 (1976 ns)>
<Event 1d000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event ff010070 #200297-1-0-1 (peak_height_data_1) = Peak #3 (2044 ns)>
<Event 1d000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event 01020040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (2052 ns)>
<Event 12000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event 03020070 #200297-1-0-1 (peak_height_data_1) = Peak #3 (2060 ns)>
<Event 11000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event 2c020060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (2224 ns)>
<Event 0b000000 #200297-1-0-1 (peak_height_data_2) = 0 (0.0 V)>
<Event 2f020050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (2236 ns)>
<Event 19000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event 37020040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (2268 ns)>
<Event 00000000 #200297-1-0-1 (peak_height_data_2) = 0 (0.0 V)>
<Event 3f020070 #200297-1-0-1 (peak_height_data_1) = Peak #3 (2300 ns)>
<Event 17000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event 42020050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (2312 ns)>
<Event 04000000 #200297-1-0-1 (peak_height_data_2) = 0 (0.0 V)>
<Event 44020050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (2320 ns)>
<Event 1c000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event 6c020060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (2480 ns)>
<Event 1e000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event 7d020040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (2548 ns)>
<Event 01000000 #200297-1-0-1 (peak_height_data_2) = 0 (0.0 V)>
<Event 84020060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (2576 ns)>
<Event 1d000000 #200297-1-0-1 (peak_height_data_2) = 1 (0.001 V)>
<Event d2020050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (2888 ns)>
<Event 22000000 #200297-1-0-1 (peak_height_data_2) = 2 (0.001 V)>
<Event 09000050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (36 ns)>
<Event 03000000 #200297-1-0-1 (peak_height_data_2) = 0 (0.0 V)>
<Event 0e000070 #200297-1-0-1 (peak_height_data_1) = Peak #3 (56 ns)>
<Event 0b000000 #200297-1-0-1 (peak_height_data_2) = 0 (0.0 V)>
<Event 10000050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (64 ns)>
<Event 06000000 #200297-1-0-1 (peak_height_data_2) = 0 (0.0 V)>
<Event 12000060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (72 ns)>
<Event f1ff0000 #200297-1-0-1 (peak_height_data_2) = -1 (-0.001 V)>
<Event 24000050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (144 ns)>
<Event abfd0000 #200297-1-0-1 (peak_height_data_2) = -38 (-0.023 V)>
<Event 26000070 #200297-1-0-1 (peak_height_data_1) = Peak #3 (152 ns)>
<Event 62fd0000 #200297-1-0-1 (peak_height_data_2) = -42 (-0.026 V)>
<Event 28000060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (160 ns)>
<Event b5fb0000 #200297-1-0-1 (peak_height_data_2) = -69 (-0.042 V)>
<Event 2a000070 #200297-1-0-1 (peak_height_data_1) = Peak #3 (168 ns)>
<Event c3fb0000 #200297-1-0-1 (peak_height_data_2) = -68 (-0.042 V)>
<Event 2d000040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (180 ns)>
<Event 19fc0000 #200297-1-0-1 (peak_height_data_2) = -63 (-0.039 V)>
<Event 2e000060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (184 ns)>
<Event 23fc0000 #200297-1-0-1 (peak_height_data_2) = -62 (-0.038 V)>
<Event 43000040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (268 ns)>
<Event 10fd0000 #200297-1-0-1 (peak_height_data_2) = -47 (-0.029 V)>
<Event 45000050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (276 ns)>
<Event 11fd0000 #200297-1-0-1 (peak_height_data_2) = -47 (-0.029 V)>
<Event 5a000070 #200297-1-0-1 (peak_height_data_1) = Peak #3 (360 ns)>
<Event 84fd0000 #200297-1-0-1 (peak_height_data_2) = -40 (-0.025 V)>
<Event 91000050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (580 ns)>
<Event dcfd0000 #200297-1-0-1 (peak_height_data_2) = -35 (-0.022 V)>
<Event 9a000040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (616 ns)>
<Event e1fd0000 #200297-1-0-1 (peak_height_data_2) = -34 (-0.021 V)>
<Event a0000040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (640 ns)>
<Event edfd0000 #200297-1-0-1 (peak_height_data_2) = -34 (-0.021 V)>
<Event ac000060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (688 ns)>
<Event e3fd0000 #200297-1-0-1 (peak_height_data_2) = -34 (-0.021 V)>
<Event e0000050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (896 ns)>
<Event 2afe0000 #200297-1-0-1 (peak_height_data_2) = -30 (-0.018 V)>
<Event e2000040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (904 ns)>
<Event 1bfe0000 #200297-1-0-1 (peak_height_data_2) = -31 (-0.019 V)>
<Event e9000040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (932 ns)>
<Event 28fe0000 #200297-1-0-1 (peak_height_data_2) = -30 (-0.018 V)>
<Event f6000070 #200297-1-0-1 (peak_height_data_1) = Peak #3 (984 ns)>
<Event 26fe0000 #200297-1-0-1 (peak_height_data_2) = -30 (-0.018 V)>
<Event 06010050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (1048 ns)>
<Event 17fe0000 #200297-1-0-1 (peak_height_data_2) = -31 (-0.019 V)>
<Event 07010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1052 ns)>
<Event 19fe0000 #200297-1-0-1 (peak_height_data_2) = -31 (-0.019 V)>
<Event 0b010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1068 ns)>
<Event 21fe0000 #200297-1-0-1 (peak_height_data_2) = -30 (-0.018 V)>
<Event 16010050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (1112 ns)>
<Event 35fe0000 #200297-1-0-1 (peak_height_data_2) = -29 (-0.018 V)>
<Event 1a010040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (1128 ns)>
<Event 3dfe0000 #200297-1-0-1 (peak_height_data_2) = -29 (-0.018 V)>
<Event 1b010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1132 ns)>
<Event 32fe0000 #200297-1-0-1 (peak_height_data_2) = -29 (-0.018 V)>
<Event 28010040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (1184 ns)>
<Event 25fe0000 #200297-1-0-1 (peak_height_data_2) = -30 (-0.018 V)>
<Event 2f010070 #200297-1-0-1 (peak_height_data_1) = Peak #3 (1212 ns)>
<Event 45fe0000 #200297-1-0-1 (peak_height_data_2) = -28 (-0.017 V)>
<Event 42010040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (1288 ns)>
<Event 48fe0000 #200297-1-0-1 (peak_height_data_2) = -28 (-0.017 V)>
<Event 4a010040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (1320 ns)>
<Event 4efe0000 #200297-1-0-1 (peak_height_data_2) = -28 (-0.017 V)>
<Event 55010070 #200297-1-0-1 (peak_height_data_1) = Peak #3 (1364 ns)>
<Event 3efe0000 #200297-1-0-1 (peak_height_data_2) = -29 (-0.018 V)>
<Event 5e010040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (1400 ns)>
<Event 5afe0000 #200297-1-0-1 (peak_height_data_2) = -27 (-0.017 V)>
<Event 62010070 #200297-1-0-1 (peak_height_data_1) = Peak #3 (1416 ns)>
<Event 5afe0000 #200297-1-0-1 (peak_height_data_2) = -27 (-0.017 V)>
<Event 74010070 #200297-1-0-1 (peak_height_data_1) = Peak #3 (1488 ns)>
<Event 57fe0000 #200297-1-0-1 (peak_height_data_2) = -27 (-0.017 V)>
<Event 76010050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (1496 ns)>
<Event 54fe0000 #200297-1-0-1 (peak_height_data_2) = -27 (-0.017 V)>
<Event 79010040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (1508 ns)>
<Event 61fe0000 #200297-1-0-1 (peak_height_data_2) = -26 (-0.016 V)>
<Event 82010050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (1544 ns)>
<Event 73fe0000 #200297-1-0-1 (peak_height_data_2) = -25 (-0.015 V)>
<Event 8d010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1588 ns)>
<Event 62fe0000 #200297-1-0-1 (peak_height_data_2) = -26 (-0.016 V)>
<Event 99010070 #200297-1-0-1 (peak_height_data_1) = Peak #3 (1636 ns)>
<Event 55fe0000 #200297-1-0-1 (peak_height_data_2) = -27 (-0.017 V)>
<Event 9b010070 #200297-1-0-1 (peak_height_data_1) = Peak #3 (1644 ns)>
<Event 79fe0000 #200297-1-0-1 (peak_height_data_2) = -25 (-0.015 V)>
<Event ad010040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (1716 ns)>
<Event 77fe0000 #200297-1-0-1 (peak_height_data_2) = -25 (-0.015 V)>
<Event 81000070 #200297-1-0-1 (peak_height_data_1) = Peak #3 (516 ns)>
<Event 12ff0000 #200297-1-0-1 (peak_height_data_2) = -15 (-0.009 V)>
<Event 87000040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (540 ns)>
<Event 12ff0000 #200297-1-0-1 (peak_height_data_2) = -15 (-0.009 V)>
<Event aa000050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (680 ns)>
<Event 19010000 #200297-1-0-1 (peak_height_data_2) = 17 (0.01 V)>
<Event bf000050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (764 ns)>
<Event 66000000 #200297-1-0-1 (peak_height_data_2) = 6 (0.004 V)>
<Event d3000040 #200297-1-0-1 (peak_height_data_1) = Peak #0 (844 ns)>
<Event 74de0000 #200297-1-0-1 (peak_height_data_2) = -537 (-0.331 V)>
<Event e8000060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (928 ns)>
<Event 5ad00000 #200297-1-0-1 (peak_height_data_2) = -763 (-0.47 V)>
<Event 01010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1028 ns)>
<Event f4d00000 #200297-1-0-1 (peak_height_data_2) = -753 (-0.463 V)>
<Event 1a010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1128 ns)>
<Event 7dd10000 #200297-1-0-1 (peak_height_data_2) = -745 (-0.459 V)>
<Event 33010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1228 ns)>
<Event fcd10000 #200297-1-0-1 (peak_height_data_2) = -737 (-0.454 V)>
<Event 4c010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1328 ns)>
<Event 8fd20000 #200297-1-0-1 (peak_height_data_2) = -728 (-0.448 V)>
<Event 65010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1428 ns)>
<Event 03d30000 #200297-1-0-1 (peak_height_data_2) = -720 (-0.443 V)>
<Event 7e010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1528 ns)>
<Event 84d30000 #200297-1-0-1 (peak_height_data_2) = -712 (-0.438 V)>
<Event 97010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1628 ns)>
<Event 05d40000 #200297-1-0-1 (peak_height_data_2) = -704 (-0.433 V)>
<Event c9010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1828 ns)>
<Event 08d50000 #200297-1-0-1 (peak_height_data_2) = -688 (-0.423 V)>
<Event e2010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (1928 ns)>
<Event 89d50000 #200297-1-0-1 (peak_height_data_2) = -680 (-0.419 V)>
<Event fb010060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (2028 ns)>
<Event 17d60000 #200297-1-0-1 (peak_height_data_2) = -671 (-0.413 V)>
<Event 14020060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (2128 ns)>
<Event 9fd60000 #200297-1-0-1 (peak_height_data_2) = -663 (-0.408 V)>
<Event 2d020060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (2228 ns)>
<Event f5d60000 #200297-1-0-1 (peak_height_data_2) = -657 (-0.404 V)>
<Event 46020050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (2328 ns)>
<Event 78d70000 #200297-1-0-1 (peak_height_data_2) = -649 (-0.399 V)>
<Event 5f020060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (2428 ns)>
<Event fed70000 #200297-1-0-1 (peak_height_data_2) = -641 (-0.395 V)>
<Event 78020050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (2528 ns)>
<Event 86d80000 #200297-1-0-1 (peak_height_data_2) = -632 (-0.389 V)>
<Event 91020060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (2628 ns)>
<Event f7d80000 #200297-1-0-1 (peak_height_data_2) = -625 (-0.385 V)>
<Event dc020060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (2928 ns)>
<Event 5cda0000 #200297-1-0-1 (peak_height_data_2) = -603 (-0.371 V)>
<Event f5020060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (3028 ns)>
<Event dbda0000 #200297-1-0-1 (peak_height_data_2) = -595 (-0.366 V)>
<Event 0e030060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (3128 ns)>
<Event 67db0000 #200297-1-0-1 (peak_height_data_2) = -586 (-0.361 V)>
<Event 27030060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (3228 ns)>
<Event efdb0000 #200297-1-0-1 (peak_height_data_2) = -578 (-0.356 V)>
<Event 59030050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (3428 ns)>
<Event d2dc0000 #200297-1-0-1 (peak_height_data_2) = -563 (-0.347 V)>
<Event 72030060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (3528 ns)>
<Event 4add0000 #200297-1-0-1 (peak_height_data_2) = -556 (-0.342 V)>
<Event 8b030060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (3628 ns)>
<Event d0dd0000 #200297-1-0-1 (peak_height_data_2) = -547 (-0.337 V)>
<Event a4030060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (3728 ns)>
<Event 3ede0000 #200297-1-0-1 (peak_height_data_2) = -541 (-0.333 V)>
<Event bd030060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (3828 ns)>
<Event bede0000 #200297-1-0-1 (peak_height_data_2) = -533 (-0.328 V)>
<Event d6030050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (3928 ns)>
<Event 48df0000 #200297-1-0-1 (peak_height_data_2) = -524 (-0.323 V)>
<Event ef030050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (4028 ns)>
<Event b7df0000 #200297-1-0-1 (peak_height_data_2) = -517 (-0.318 V)>
<Event 08040060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (4128 ns)>
<Event 27e00000 #200297-1-0-1 (peak_height_data_2) = -510 (-0.314 V)>
<Event 21040060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (4228 ns)>
<Event a7e00000 #200297-1-0-1 (peak_height_data_2) = -502 (-0.309 V)>
<Event 3a040060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (4328 ns)>
<Event 1ae10000 #200297-1-0-1 (peak_height_data_2) = -495 (-0.305 V)>
<Event 53040060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (4428 ns)>
<Event a7e10000 #200297-1-0-1 (peak_height_data_2) = -486 (-0.299 V)>
<Event 6c040060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (4528 ns)>
<Event 10e20000 #200297-1-0-1 (peak_height_data_2) = -479 (-0.295 V)>
<Event 85040060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (4628 ns)>
<Event 60e20000 #200297-1-0-1 (peak_height_data_2) = -474 (-0.292 V)>
<Event 9e040060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (4728 ns)>
<Event f2e20000 #200297-1-0-1 (peak_height_data_2) = -465 (-0.286 V)>
<Event d0040060 #200297-1-0-1 (peak_height_data_1) = Peak #2 (4928 ns)>
<Event 06e40000 #200297-1-0-1 (peak_height_data_2) = -448 (-0.276 V)>
<Event e9040050 #200297-1-0-1 (peak_height_data_1) = Peak #1 (5028 ns)>
<Event 80e40000 #200297-1-0-1 (peak_height_data_2) = -440 (-0.271 V)>

Event counts:

<EventType 'begin_event', regex 'ffffffff'>: 10
<EventType 'begin_sub_event', regex '00ffffff'>: 10
<EventType 'byte_order', regex 'f4f3f2f1'>: 10
<EventType 'fmc228_number', regex '..ccccfc'>: 10
<EventType 'sub_event_number_evn', regex '........'>: 10
<EventType 'event_number_evn', regex '........'>: 10
<EventType 'begin_raw_data', regex 'fdfdfdfd'>: 10
<EventType 'byte_order2', regex 'f4f3f2f1'>: 10
<EventType 'event_number_evn2', regex '........'>: 10
<EventType 'channel_header', regex 'fafa..fa'>: 40
<EventType 'waveform', regex 'ffff....'>: 40
<EventType 'fragment_trig_mask', regex '0000....'>: 40
<EventType 'stat', regex '........'>: 40
<EventType 'status_word', regex '........'>: 40
<EventType 'bco_low', regex '........'>: 40
<EventType 'bco_high', regex '........'>: 40
<EventType 'data_length', regex '....aaff'>: 0
<EventType 'raw_data', regex '........'>: 4000
<EventType 'end_of_channel', regex 'fbfbfbfb'>: 40
<EventType 'end_raw_data', regex 'fefefefe'>: 10
<EventType 'begin_peak_data', regex 'efefefef'>: 10
<EventType 'channel_number', regex 'eeee....'>: 40
<EventType 'peak_finding_header', regex 'aaaaaaaa'>: 40
<EventType 'peak_height_header', regex 'cccccccc'>: 40
<EventType 'peak_height_data_1', regex '....00..'>: 1680
<EventType 'peak_height_data_2', regex '........'>: 1680
<EventType 'peak_height_end', regex 'cececece'>: 40
<EventType 'peak_area_header', regex 'dddddddd'>: 40
<EventType 'peak_area_data_1', regex '....1111'>: 85
<EventType 'peak_area_data_2', regex '........'>: 85
<EventType 'peak_area_data_3', regex '........'>: 85
<EventType 'peak_area_data_4', regex '......0.'>: 85
<EventType 'peak_area_data_5', regex '......0.'>: 85
<EventType 'peak_area_data_6', regex '......0.'>: 85
<EventType 'peak_area_end', regex 'dededede'>: 40
<EventType 'end_peak_data', regex 'bbbbbbbb'>: 40
<EventType 'end_peak_channel', regex 'ecececec'>: 40
<EventType 'end_peak_stream_data', regex 'edededed'>: 10
<EventType 'end_sub_event', regex '00fcfcfc'>: 10
<EventType 'end_event', regex 'fcfcfcfc'>: 10
Used input file data_20250516_182203.dat

First event had 336 / 2 = 168 peaks.
Total number of peaks is 1680, so perfectly 168 peaks per event.

For peak area, it's

--



v20 bitfile
Peakfinding Length: 1500
Number of subevents: 1
Raw Data Length: 100
Peakfinding Threshold: -20000
Peak height event count: 4
Peak area event count: 12
data_20250521_202901.dat

<EventType 'begin_event', regex 'ffffffff'>: 1
<EventType 'begin_sub_event', regex '00ffffff'>: 1
<EventType 'byte_order', regex 'f4f3f2f1'>: 1
<EventType 'fmc228_number', regex '..ccccfc'>: 1
<EventType 'sub_event_number_evn', regex '........'>: 1
<EventType 'event_number_evn', regex '........'>: 1
<EventType 'begin_raw_data', regex 'fdfdfdfd'>: 1
<EventType 'byte_order2', regex 'f4f3f2f1'>: 1
<EventType 'event_number_evn2', regex '........'>: 1
<EventType 'channel_header', regex 'fafa..fa'>: 4
<EventType 'waveform', regex 'ffff....'>: 4
<EventType 'fragment_trig_mask', regex '0000....'>: 4
<EventType 'stat', regex '........'>: 4
<EventType 'status_word', regex '........'>: 4
<EventType 'bco_low', regex '........'>: 4
<EventType 'bco_high', regex '........'>: 4
<EventType 'data_length', regex '....aaff'>: 0
<EventType 'raw_data', regex '........'>: 400
<EventType 'end_of_channel', regex 'fbfbfbfb'>: 4
<EventType 'end_raw_data', regex 'fefefefe'>: 1
<EventType 'begin_peak_data', regex 'efefefef'>: 1
<EventType 'channel_number', regex 'eeee..ee'>: 4
<EventType 'peak_finding_header', regex 'aaaaaaaa'>: 4
<EventType 'peak_height_header', regex 'cccccccc'>: 4
<EventType 'peak_height_data_1', regex '....00..'>: 0
<EventType 'peak_height_data_2', regex '........'>: 0
<EventType 'peak_height_end', regex 'cececece'>: 4
<EventType 'peak_area_header', regex 'dddddddd'>: 4
<EventType 'peak_area_data_1', regex '....1111'>: 0
<EventType 'peak_area_data_2', regex '........'>: 0
<EventType 'peak_area_data_3', regex '........'>: 0
<EventType 'peak_area_data_4', regex '......0.'>: 0
<EventType 'peak_area_data_5', regex '......0.'>: 0
<EventType 'peak_area_data_6', regex '......0.'>: 0
<EventType 'peak_area_end', regex 'dededede'>: 4
<EventType 'end_peak_data', regex 'bbbbbbbb'>: 4
<EventType 'end_peak_channel', regex 'ecececec'>: 4
<EventType 'end_peak_stream_data', regex 'edededed'>: 1
<EventType 'end_sub_event', regex '00fcfcfc'>: 1
<EventType 'end_event', regex 'fcfcfcfc'>: 1
Used input file data_20250521_202901.dat



Peakfinding Length: 20000
Number of subevents: 1
Raw Data Length: 100
Peakfinding Threshold: -20000
Peak height event count: 4
Peak area event count: 12
v20

Still zero peak events



Peakfinding Length: 20000
Number of subevents: 1
Raw Data Length: 100
Peakfinding Threshold: -20000
Peak height event count: 84
Peak area event count: 252

