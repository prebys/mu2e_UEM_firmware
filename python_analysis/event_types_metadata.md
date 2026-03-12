# Event Chain Metadata

This document describes the event chain used by the Mu2e firmware data stream in the same order as `event_types.py`, but in human-readable form.

The parser reads the stream as a sequence of 32-bit words. Each word is shown below as an 8-hex-character regex pattern.

Conventions:

- `.` means any hex character
- each pair of hex characters is one byte
- `........` means one unconstrained 32-bit word
- names like `peak_area_data_1` match the symbolic event names from the parser

## Top-Level Event Chain

### `begin_event`

- Regex: `ffffffff`
- Meaning: start of one event
- Next: `begin_event`, `begin_sub_event`

### `begin_sub_event`

- Regex: `00ffffff`
- Meaning: start of one subevent inside the event
- Next: `byte_order`

### `byte_order`

- Regex: `f4f3f2f1`
- Meaning: byte-order marker
- Next: `fmc228_number`

### `fmc228_number`

- Regex: `..ccccfc`
- Meaning: FMC228 card identifier word
- Next: `sub_event_number_evn`

### `sub_event_number_evn`

- Regex: `........`
- Meaning: subevent number
- Next: `event_number_evn`

### `event_number_evn`

- Regex: `........`
- Meaning: event number
- Next: `begin_raw_data`

## Raw Data Chain

### `begin_raw_data`

- Regex: `fdfdfdfd`
- Meaning: start of the raw-data section
- Next: `byte_order2`

### `byte_order2`

- Regex: `f4f3f2f1`
- Meaning: byte-order marker for raw data
- Next: `event_number_evn2`

### `event_number_evn2`

- Regex: `........`
- Meaning: repeated event number in the raw-data block
- Next: `channel_header`

### `channel_header`

- Regex: `fafa..fa`
- Meaning: start of one raw-data channel block
- Next: `waveform`

### `waveform`

- Regex: `ffff....`
- Meaning: waveform-related header word
- Next: `fragment_trig_mask`

### `fragment_trig_mask`

- Regex: `0000....`
- Meaning: fragment trigger mask
- Next: `stat`

### `stat`

- Regex: `........`
- Meaning: status/statistics word
- Next: `status_word`

### `status_word`

- Regex: `........`
- Meaning: status word
- Next: `bco_low`

### `bco_low`

- Regex: `........`
- Meaning: low bits of the BCO counter
- Next: `bco_high`

### `bco_high`

- Regex: `........`
- Meaning: high bits of the BCO counter
- Next: `data_length`, `end_of_channel`, `raw_data`

### `data_length`

- Regex: `....aaff`
- Meaning: raw-data length word
- Next: `end_of_channel`, `raw_data`

### `raw_data`

- Regex: `........`
- Meaning: raw ADC data word
- Next: `end_of_channel`, `raw_data`

The current parser comments describe three decoding modes for raw ADC words:

- `s12`: two signed 12-bit ADC values plus count bits packed into one 32-bit word
- `s16`: two signed 16-bit values packed into one 32-bit word
- `s32`: one signed 32-bit value per word

### `end_of_channel`

- Regex: `fbfbfbfb`
- Meaning: end of one raw-data channel
- Next: `end_raw_data`, `channel_header`

### `end_raw_data`

- Regex: `fefefefe`
- Meaning: end of the raw-data section
- Next: `begin_peak_data`

## Peak Data Chain

### `begin_peak_data`

- Regex: `efefefef`
- Meaning: start of the peak-data stream
- Next: `channel_number`

### `channel_number`

- Regex: `eeee..ee`
- Meaning: identifies which channel the following peak block belongs to
- Next: `peak_finding_header`

### `peak_finding_header`

- Regex: `aaaaaaaa`
- Meaning: peak-finding header word
- Next: `peak_height_header`

## Peak Height Chain

### `peak_height_header`

- Regex: `cccccccc`
- Meaning: start of peak-height records
- Next: `peak_height_end`, `peak_height_data_1`

### `peak_height_data_1`

- Regex: `......[4567].`
- Meaning: first 32-bit word of one peak-height record
- Next: `peak_height_data_2`

The parser comments describe this word as:

- a leading `01` marker in the top bits
- a 2-bit peak position code
- a 28-bit counter

The 28-bit counter is converted to time in ns by multiplying by 4.

### `peak_height_data_2`

- Regex: `....0000`
- Meaning: second 32-bit word of one peak-height record
- Next: `peak_height_end`, `peak_height_data_1`

The parser comments describe this word as:

- upper 16 bits fixed at `0x0000`
- lower 16 bits holding the signed peak height

### `peak_height_end`

- Regex: `cececece`
- Meaning: end of the peak-height section
- Next: `peak_area_header`

## Peak Area Chain

### `peak_area_header`

- Regex: `dddddddd`
- Meaning: start of peak-area records
- Next: `peak_area_end`, `peak_area_data_1`

### `peak_area_data_1`

- Regex: `....1111`
- Meaning: first 32-bit word of one peak-area record
- Next: `peak_area_data_2`

The parser comments and the PDF describe this word as:

- upper 16 bits fixed at `0x1111`
- lower 16 bits holding the maximum peak value in the pulse

### `peak_area_data_2`

- Regex: `........`
- Meaning: area from pulse beginning to the maximum peak
- Next: `peak_area_data_3`

### `peak_area_data_3`

- Regex: `........`
- Meaning: total pulse area
- Next: `peak_area_data_4`

### `peak_area_data_4`

- Regex: `......0.`
- Meaning: time from trigger to the maximum peak
- Next: `peak_area_data_5`

The parser treats the lower 28 bits as a counter and converts to ns by multiplying by 4.

### `peak_area_data_5`

- Regex: `......0.`
- Meaning: time from trigger to the beginning of the pulse
- Next: `peak_area_data_6`

### `peak_area_data_6`

- Regex: `......0.`
- Meaning: time from trigger to the end of the pulse
- Next: `peak_area_end`, `peak_area_data_1`

### `peak_area_end`

- Regex: `dededede`
- Meaning: end of the peak-area section
- Next: `end_peak_data`

## Peak Stream Closing Words

### `end_peak_data`

- Regex: `bbbbbbbb`
- Meaning: end of peak data for one channel
- Next: `end_peak_channel`

### `end_peak_channel`

- Regex: `ecececec`
- Meaning: end marker for one peak-data channel block
- Next: `end_peak_stream_data`, `channel_number`

### `end_peak_stream_data`

- Regex: `edededed`
- Meaning: end of the peak-data stream for the subevent
- Next: `end_sub_event`

## Subevent and Event Closure

### `end_sub_event`

- Regex: `00fcfcfc`
- Meaning: end of one subevent
- Next: `end_event`, `begin_sub_event`, `begin_event`

### `end_event`

- Regex: `fcfcfcfc`
- Meaning: end of one event
- Next: `begin_event`

## Compact Event Order

One full event is therefore read in this order:

1. `begin_event`
2. one or more repetitions of:
   `begin_sub_event`
   `byte_order`
   `fmc228_number`
   `sub_event_number_evn`
   `event_number_evn`
   raw-data chain
   peak-data chain
   `end_sub_event`
3. `end_event`

Within each raw-data chain:

1. `begin_raw_data`
2. `byte_order2`
3. `event_number_evn2`
4. one or more channel blocks
5. `end_raw_data`

Within each peak-data chain:

1. `begin_peak_data`
2. one or more channel blocks
3. `end_peak_stream_data`

Within each peak-data channel:

1. `channel_number`
2. `peak_finding_header`
3. zero or more peak-height records
4. zero or more peak-area records
5. `end_peak_data`
6. `end_peak_channel`

## Notes From Current Parser Behavior

- The parser can split one raw event into multiple logical events if the subevent number resets unexpectedly.
- A peak-area record with an invalid `peak_area_data_1` marker is skipped without aborting the rest of the event.
- An event is considered empty if it contains no raw samples, no peak-height entries, and no peak-area entries.
