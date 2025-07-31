from dataclasses import dataclass, field
from typing import Optional


@dataclass
class Config:
    # set "desired_file_path" to None to use the most recent data file in the directory
    # setting to a name will search for any files with that name in the directory
    # consider searching for the names 'diag_0x1', 'diag_0x2', 'diag_0x3', 'diag_0x5', 'diag_0x9', 'diag_0xF'
    # desired_file_path = "test20241112_145129.dat"
    desired_file_path: Optional[str] = "data_20250710_233404.dat"
    
    # set to "1" to use the newest file in the directory
    # "2" for example will use the second-newest file
    to_use_file_index: int = 9
    
    # data processing mode
    # s12: 12-bit signed integer (normal ADC operation, split 32-bits into two 16-bit values, take top 12-bits)
    # s16: 16-bit signed integer (split 32-bits into two 16-bit values, take all 16-bits)
    # s32: 32-bit signed integer (take all 32-bits as one data point)
    integer_mode: str = 's12'
    
    # show plots
    # set to True to visually display plots as they are created, or False to just save them and not display them
    # in an SSH client, "False" is recommended
    show_plots: bool = True
    
    # plot raw data or peak height
    plotting_mode = None  # "raw_data" or "peak_height" or "both"
    # or "peak_time" to plot a histogram of peak times for channel 4
    # or "peak_separation" to plot a histogram of the separation between peaks in channel 4
    
    # set number of events and subevents
    n_events: int = 1000
    n_subevents: int = 100
    
    # search for cosmic events
    # set to True to only plot subevents where the voltage range in one of the three channels is greater than 0.5V
    search_for_cosmics: bool = False
    
    # plotting units
    # volts: standard operation, plot data in volts (convert from raw values)
    # raw: plot data in raw values (no conversion)
    plotting_units: str = "volts"  # "volts" or "raw"
    
    # if True, will print all event types regardless of the "only_show" list below
    show_all: bool = False
    
    # if True, will print NO EVENTS regardless of the "only_show" list
    show_nothing: bool = True
    
    # if this contains entries, then this code will only print the events in this list
    only_show: list[str] = field(default_factory=lambda: ['peak_height_data',
                                                          'peak_area_data'])  # ["peak_height_data_1"])  # , "event_number_evn", etc.
    # set to empty list [] to use the "show" attribute of the name_to_event dictionary
    
    # maximum number of logs to show
    n_logs_to_show = float('inf')
    
    # optional footnote below axes in plot
    # optional_note = "CH1: 100ns (10MHz) sine wave, CH2: Ext. Trig., trigger_delay = 1,000,000"
    optional_note = None
    
    def __post_init__(self):
        assert self.plotting_units in ["volts", "raw"], \
            "Invalid plotting_units. Please choose 'volts' or 'raw'."
        

config = Config()