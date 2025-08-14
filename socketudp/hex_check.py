#!/usr/bin python3
import os
import traceback
import unittest

from collections import Counter
from dataclasses import field, dataclass
from typing import Optional

import numpy as np
import pandas
from matplotlib import pyplot as plt, gridspec
import pandas as pd

from hex_check_config import config
from hex_check_classes import Event, EventType, convert_voltage, name_to_event, find_data_file, read_data_file, Peak

file_path = os.path.dirname(os.path.realpath(__file__))
os.chdir(file_path)


# sample of beginning of file:
# ffffffff 00ffffff f4f3f2f1 00ccccfc
# 00000000 2804ac00 fdfdfdfd f4f3f2f1
# 2804ac00 fafa03fa ffff9c10 00000000 ...

# #############################################################################
# #############################################################################
# #############################################################################
# ################### *START* FILE CONFIGURATION SETTINGS #####################
# #############################################################################
# #############################################################################
# #############################################################################



# #############################################################################
# #############################################################################
# #############################################################################
# ################### *END* FILE CONFIGURATION SETTINGS #######################
# #############################################################################
# #############################################################################
# #############################################################################



class HexCheck:
    def __init__(self, to_use_index_increment: int = 0):
        self.name_to_event: dict[str, EventType] = {}
        self.event_counts: dict[EventType, int] = Counter()
        self.event_buffer: list[Event] = []  # buffer of all events
        self.raw_data_buffer: list[Event] = []  # buffer of just raw data events
        self.peak_height_buffer: list[Peak] = []  # buffer of just peak height events
        self.raw_data_dataframe: Optional[pandas.DataFrame] = None  # buffer of raw data events in a pandas DataFrame
        self.peak_height_dataframe: Optional[pandas.DataFrame] = None  # buffer of peak height events in a DataFrame
        self.headers = []  # list of headers from the data file
        
        # if __name__ == "__main__":
        self.dir_name: str = os.path.dirname(os.path.realpath(__file__)).replace("\\", "/")  # Directory of the script
        self.file_name: str = find_data_file(config.desired_file_path, to_use_index_increment)  # Name of the data file
        self.full_hex_data, self.file_creation_date, self.headers = read_data_file(self.dir_name, self.file_name)  # Full hex data and file creation date
        self.date_str = self.file_creation_date.strftime('%Y.%m.%d_%H.%M.%S')
        self.folder_name = f"{self.date_str}_{self.file_name}"  # folder name inside /img directory
        # end commented if statement
        
        # value of how many raw data points are remaining to be sent in current run of raw data
        # will only have value for raw_data event types
        self.raw_data_remaining = None
        self.adc_length = None
        
        # set mode for data processing
        if config.integer_mode != 's12':
            self.folder_name += f"_{config.integer_mode}"
        
        # full_hex_data is a list of strings, each string is 8 characters long (4 bytes)
        # one "byte" in hex is two characters, for example, "ff"
    
    def get_event_types(self, _name_to_event):
        """Get all EventType objects from the global name_to_event dictionary
        and store them in the name_to_event dictionary."""
        self.name_to_event = _name_to_event

    
    def main(self, plot=True):
        number_of_printed_logs = 0
        current_event = None
        # print("\n\nStart printing of data")
        for current_event_hex in self.full_hex_data:
            # detect current event type
            try:
                current_event = Event(
                    new_hex=current_event_hex,
                    previous_event=current_event  # this "current_event" is the event from the previous loop
                )
            except Exception as e:
                if "Failed to detect the kind of event" in str(e):
                    # print(f"Error: {current_event_hex} (unknown event). "
                    #       f"Will continue searching for first recognizable event.")
                    raise e
            
            # end file processing if the event number and subevent number
            # are greater than the configured values
            if current_event.internal_event_number > config.n_events:
                break
            
            # current_event object contains:
            # - current_event.hex: the current hex value
            # - current_event.previous_event: the previous event object
            # - current_event.type: the current event type object
            # - current_event.matched: whether the current event type was matched
            # - current_event.event_number: the event number of the current event
            # - current_event.sub_event_number: the sub-event number of the current event
            # - current_event.channel_number: the channel number of the current event
            # - current_event.internal_event_number: the internal event number of the current event
            # - current_event.data: the data of the current event
            
            if not current_event.matched:
                # print(f"Error: {current_event.hex} (unknown event). "
                #       f"Will continue searching for first recognizable event.")
                continue
            
            self.event_counts[current_event.type] += 1
            self.event_buffer.append(current_event)
            if current_event.type == "raw_data":
                self.raw_data_buffer.append(current_event)
            elif current_event.type == "peak_height_data_1":
                peak = Peak.from_event(current_event)
                self.peak_height_buffer.append(peak)
            elif current_event.type == "peak_height_data_2":
                if not self.peak_height_buffer[-1].time_ns:
                    raise RuntimeError("Got peak_height_data_2 without prior peak_height_data_1.")
                self.peak_height_buffer[-1].height = current_event.peak_height
            
            if current_event.type.show and number_of_printed_logs < config.n_logs_to_show:
                number_of_printed_logs += 1
                if current_event.channel_number != 5:
                    print(current_event)
                if number_of_printed_logs == config.n_logs_to_show:
                    print(f"[INFO] Printing of data has been "
                          f"limited to {config.n_logs_to_show} logs.")
        
        for _, event_type in self.name_to_event.items():
            count = self.event_counts.get(event_type, 0)
            # print(f"{event_type}: {count}")
        
        print(f"Used input file {self.file_name}")
        # for header in self.headers:
            # print(header)
        # print(f"Starting collection of data")
        
        # add raw data to the dataframe
        self.raw_data_dataframe = self.make_raw_data_dataframe()
        self.peak_height_dataframe = self.make_peak_height_dataframe()
        
        # show number of data points per event
        # for (_event_number, _channel_number), group in group_by_event:
        #     print(f"Event {_event_number} (ch{_channel_number}): {len(group)} data points, "
        #           f"mean value: {convert_voltage(group['data'].mean()):.3f} V")
        
        if config.plotting_mode in ['raw_data', 'both']:
            self.plot_raw_data()
        elif config.plotting_mode in ['peak_height', 'both']:
            self.plot_peak_height()
        elif config.plotting_mode == 'peak_time':
            self.plot_peak_time()
        elif config.plotting_mode == 'peak_separation':
            self.plot_peak_separation()
        elif config.plotting_mode is None:
            print("No plotting mode specified. Skipping plotting.")
        else:
            raise ValueError("Invalid plotting mode. Please choose 'raw_data', 'peak_height', or 'both'.")
        
        return self.event_counts
    
    def make_raw_data_dataframe(self):
        panda_entry = []
        if config.integer_mode in ["s12", "s16"]:
            for event in self.raw_data_buffer:
                panda_entry.append((event.internal_event_number, event.sub_event_number,
                                    event.channel_number, event.raw_data[0]))
                panda_entry.append((event.internal_event_number, event.sub_event_number,
                                    event.channel_number, event.raw_data[1]))
        elif config.integer_mode == "s32":
            for event in self.raw_data_buffer:
                panda_entry.append((event.internal_event_number, event.sub_event_number,
                                    event.channel_number, event.raw_data[0]))
        
        panda_frame = pd.DataFrame(panda_entry,
                                    columns=["internal_event_number",
                                             "sub_event_number",
                                             "channel_number",
                                             "data"])
        return panda_frame
    
    def make_peak_height_dataframe(self):
        panda_entry = []
        for peak in self.peak_height_buffer:
            if peak.channel_number == 4:
                continue
            panda_entry.append((peak.internal_event_number,
                                peak.channel_number,
                                peak.sub_event_number,
                                peak.time_ns,
                                peak.height))
        panda_frame = pd.DataFrame(self.peak_height_buffer,
                                   columns=["internal_event_number",
                                            "channel_number",
                                            "sub_event_number",
                                            "time_ns",
                                            "height"])
        
        # save peak height data to CSV file
        output_path = f"img/{self.folder_name}/peak_height_data_{self.file_name}.csv"
        if not os.path.exists(f"img/{self.folder_name}"):
            os.makedirs(f"img/{self.folder_name}")
        panda_frame.to_csv(output_path, index=False)
        print(f"Peak height data saved to {output_path}")
        
        return panda_frame
    
    def plot_event_grid(self,
                        grouped_data: list[list[float]],
                        internal_event: int,
                        title_prefix: str = '',
                        file_prefix: str = '',
                        sub_event: int = None,
                        t_data: list[list[float]] = None
                        ):
        """
        Plots a 2x2 grid using the grouped data.

        Parameters:
            grouped_data: List of 4 lists (one per channel). Each list contains Y-axis values to plot.
            internal_event: Event number for labeling and saving.
            title_prefix: Title string prefix (e.g. "Raw Data - Event").
            file_prefix: File prefix for saved image (e.g. "raw").
            sub_event: (Optional) Sub-event number for labeling.
            t_data: Optional list of 4 lists (one per channel). Each list contains X-axis values to plot.
        """
        fig, axes = plt.subplots(2, 2, figsize=(10, 8))
        
        title = f"{title_prefix} - Event {internal_event}"
        if sub_event is not None:
            title += f", Subevent {sub_event}"
        if config.integer_mode != 's12':
            title += f" (Mode: {config.integer_mode})"
        time_str = self.file_creation_date.strftime("%Y-%m-%d %H:%M:%S")
        title += f"\n{self.file_name} ({time_str})"

        fig.suptitle(title, fontsize=14)
        
        output_path = f"img/{self.folder_name}/{file_prefix}_{internal_event}.png"
        if not os.path.exists(f"img/{self.folder_name}"):
            os.mkdir(f"img/{self.folder_name}")
            
        if config.optional_note:
            # annotate below the bottom-right axis
            axes[1, 1].annotate(config.optional_note, xy = (1.0, -0.2), xycoords = 'axes fraction',
                            ha='right', va='top', fontsize=10)
        
        if not t_data:
            t_data = [[], [], [], []]  # Initialize t_data if not provided
        
        # grouped_data and t_data are lists like:
        # [  [ channel_1 data],
        #    [ channel_2 data],
        #    [ channel_3 data],
        #    [ channel_4 data],  ]
        # with the possibility of some of those lists being empty if that channel has no data
        
        for i, (ax, channel_t, channel_data) in enumerate(zip(axes.flatten(), t_data, grouped_data)):
            channel = i + 1
            if channel_data:
                if channel_t:
                    # if the range is too large, convert to us or ms
                    if max(channel_t) - min(channel_t) > 1e6:
                        channel_t = [t / 1e6 for t in channel_t]
                        units = 'ms'
                    elif max(channel_t) - min(channel_t) > 1e3:
                        channel_t = [t / 1e3 for t in channel_t]
                        units = 'μs'
                    else:
                        units = 'ns'
                    ax.plot(channel_t, channel_data, label=f"Channel {channel}")
                else:
                    ax.plot(channel_data, label=f"Channel {channel}")
                    units = 'ns'
                ax.set_title(f"Channel {channel}")
                ax.legend()
                ax.grid(True)
            else:
                units = 'ns'
                ax.text(0.5, 0.5, "No Data", fontsize=12, ha="center", va="center")
                ax.set_title(f"Channel {channel}")
            
            if i >= 2 or units != 'ns':
                ax.set_xlabel(f"Time ({units})")
            if i % 2 == 0:
                ax.set_ylabel("Voltage (V)" if config.plotting_units == "volts" else "Raw Data")
        
        plt.tight_layout(rect=(0, 0.03, 1, 0.95))
        plt.savefig(output_path)
        if config.show_plots:
            plt.show()
        plt.close()
    
    def plot_raw_data(self):
        grouped = self.raw_data_dataframe.groupby(["internal_event_number", "sub_event_number"])
        for (internal_event, sub_event), group in grouped:
            if sub_event + 1 > config.n_subevents or internal_event > config.n_events:
                continue
            channel_arrays = []
            for ch in [1, 2, 3, 4]:
                ch_data = group[group["channel_number"] == ch]["data"].values
                y_vals = convert_voltage(ch_data) if config.plotting_units == "volts" else ch_data
                channel_arrays.append(y_vals.tolist())
            self.plot_event_grid(channel_arrays, 
                                 internal_event, 
                                 "Raw Data - Event", 
                                 "raw",
                                 sub_event=sub_event)
    
    def plot_peak_height(self):
        grouped = self.peak_height_dataframe.groupby("internal_event_number")
        # group is basically a collection of DataFrames, one for each internal event number.
        for internal_event, group in grouped:
            # internal_event is an integer
            # "group" is the same dataframe as before, but only with events from the chosen internal event
            internal_event: int
            if internal_event > config.n_events:
                continue
            t_arrays = []
            channel_arrays = []
            for ch in [1, 2, 3, 4]:
                # (group['channel_number'] == ch) is a list like [(0, True), (1, True), (2, True), ...]
                # group[group["channel_number"] == ch] is a dataframe with only the rows where channel_number == ch
                # group[group["channel_number"] == ch]["time_ns"].values is a numpy array of the time_ns values
                t_data = group[group["channel_number"] == ch]["time_ns"].values
                t_arrays.append(t_data.tolist())  # this will have up to 4 entries, one for each channel
                ch_data = group[group["channel_number"] == ch]["height"].values
                y_vals = convert_voltage(ch_data) if config.plotting_units == "volts" else ch_data
                channel_arrays.append(y_vals.tolist())
            self.plot_event_grid(channel_arrays,
                                 internal_event,
                                 "Peak Height - Event",
                                 "peak",
                                 t_data = t_arrays)
    
    def plot_peak_time(self, merge_events = True):
        """Generate one 2x2 histogram grid per event, showing peak times for each channel."""
        
        if merge_events:
            self.histogram_grid(self.peak_height_dataframe, None)
        else:
            grouped_by_event = self.peak_height_dataframe.groupby("internal_event_number")
            for internal_event, group in grouped_by_event:
                internal_event: int
                if internal_event > config.n_events:
                    continue
                self.histogram_grid(group, internal_event)
    
    def histogram_grid(self, group, internal_event):
        fig, axes = plt.subplots(3, 1, figsize=(10, 8))
        # fig = plt.figure(figsize=(10, 8))
        # gs = gridspec.GridSpec(2, 4, height_ratios=[1, 1])
        #
        # # Top row
        # ax1 = fig.add_subplot(gs[0, :2])  # Channel 1
        # ax2 = fig.add_subplot(gs[0, 2:])  # Channel 2
        # # Bottom row: single axis in middle
        # ax3 = fig.add_subplot(gs[1, 1:3])  # Channel 3 (centered)
        #
        # axes = [ax1, ax2, ax3]
        
        if internal_event is not None:
            title = f"Peak Times - Event {internal_event}"
            n_events = 1
        else:
            title = "Peak Times - Merged Events"
            n_events = group["internal_event_number"].nunique()
        
        if config.integer_mode != 's12':
            title += f" (Mode: {config.integer_mode})"
        time_str = self.file_creation_date.strftime("%Y-%m-%d %H:%M:%S")
        title += f"\n{self.file_name} ({time_str})"
        fig.suptitle(title, fontsize=14)
        
        scale_down = 1
        times_all = group[group['channel_number'] != 4]["time_ns"].values / scale_down  # all times in μs
        min_time = np.min(times_all)
        max_time = np.max(times_all)
        # print(times_all)
        # print(min_time)
        # print(max_time)
        while max_time > 1000:
            scale_down *= 1e3
            min_time /= 1e3
            max_time /= 1e3
        bin_width = 1200e-6  # 400 ns bin width
        # min_time = 10
        # max_time = 15 + bin_width

        # bin_edges = np.linspace(min_time, max_time, 6000)  # 100 bins = 101 edges
        bin_edges = np.arange(min_time, max_time, bin_width)  # assuming ms, 4e-6 is 4ns
        print(f"Bin width: {bin_width * 1e6} ns")
        
        for i, ch in enumerate([1, 2, 3]):
            ax = axes[i]
            ch_data = group[group["channel_number"] == ch]
            
            if not ch_data.empty:
                times = ch_data["time_ns"].values / scale_down  # convert to μs
                # print(f"Channel {i} unique time values:", len(np.unique(times)))
                log_scale = False
                ax.hist(times, bins=bin_edges,
                        color='blue', alpha=0.7, log=log_scale,
                        width=15*bin_width)
                ax_title = f"Channel {ch}"
                if log_scale:
                    ax_title += " (log scale)"
                ax.set_title(ax_title)
                if scale_down == 1:
                    ax.set_xlabel("Time (ns)")
                elif scale_down == 1e3:
                    ax.set_xlabel("Time (us)")
                elif scale_down == 1e6:
                    ax.set_xlabel("Time (ms)")
                else:
                    raise ValueError(f"Invalid scale_down value: {scale_down}. ")

                ax.set_ylabel("Counts")
                ax.grid(True)
                ax.set_xlim(min_time, max_time)
                
                # Add box with stats
                num_points = len([i for i in times if min_time < i < max_time])
                stats_text = f"{num_points} peaks\n{n_events} event{'s' if n_events > 1 else ''}"
                ax.text(0.98, 0.95, stats_text, transform=ax.transAxes,
                        fontsize=10, ha='right', va='top',
                        bbox=dict(boxstyle="round,pad=0.3", edgecolor='black', facecolor='white',
                                  alpha=0.7))
            else:
                ax.text(0.5, 0.5, "No Data", fontsize=12, ha="center", va="center")
                ax.set_title(f"Channel {ch}")
        
        plt.tight_layout(rect=(0, 0.03, 1, 0.95))
        
        if internal_event is not None:
            output_path = f"img/{self.folder_name}/peak_time_event_{self.file_name}_{internal_event}.png"
        else:
            output_path = f"img/{self.folder_name}/peak_time_merged_{self.file_name}.png"
        
        if not os.path.exists(f"img/{self.folder_name}"):
            os.mkdir(f"img/{self.folder_name}")
        
        # Standardize x-limits
        # min_xlim = float('inf')
        # max_xlim = float('-inf')
        # for ax in axes:
        #     xlim = ax.get_xlim()
        #     min_xlim = min(min_xlim, xlim[0])
        #     max_xlim = max(max_xlim, xlim[1])
        # for ax in axes.flatten()[:3]:
        #     ax.set_xlim(min_xlim, max_xlim)
        # #     # ax.set_xlim(80, 85)
        
        plt.savefig(output_path)
        if config.show_plots:
            plt.show()
        plt.close()
        

        # plot ffts, get counts and bin width from each axis in axes
        # self.fft(axes)
        # for i, ax in enumerate(axes):
        #     counts = [patch.get_height() for patch in ax.patches]
        #     bin_width = ax.patches[0].get_x() + ax.patches[0].get_width() - ax.patches[0].get_x()
        #     if counts and bin_width > 0:
        #         self.fft(counts, bin_edges, ax.patches)
        
    def plot_peak_separation(self):
        """Plot histogram for the separation between peaks in channel 4."""
        grouped = self.peak_height_dataframe.groupby("channel_number")
        for channel, group in grouped:
            if channel != 4:
                continue
            
            # Calculate the time differences between consecutive peaks
            times = group["time_ns"].values
            if len(times) < 2:
                print(f"Not enough data to calculate peak separation for channel {channel}.")
                continue
            
            # Calculate the differences (ignoring negative values)
            separations = []
            for i in range(1, len(times)):
                separation = times[i] - times[i - 1]
                if separation > 0:
                    separations.append(separation)
            
            plt.figure(figsize=(10, 6))
            plt.hist(separations, bins=100, color='green', alpha=0.7)
            plt.title(f"Peak Separations for Channel {channel}")
            plt.xlabel("Separation (ns)")
            plt.ylabel("Frequency")
            plt.grid(True)
            output_path = f"img/{self.folder_name}/peak_separation_channel_{channel}.png"
            if not os.path.exists(f"img/{self.folder_name}"):
                os.mkdir(f"img/{self.folder_name}")
            plt.savefig(output_path)
            if config.show_plots:
                plt.show()
            plt.close()

    def fft(self, axes_in):
        """Perform FFT on the histogram counts and plot the result."""
        num_plots = len(axes_in)
        fig, axes = plt.subplots(num_plots, 1, figsize=(10, 8))
        fig.suptitle(f"FFT of Histogram Counts\n{self.file_name}", fontsize=14)
        for i in range(num_plots):
            ax = axes[i]
            # Get the counts and bin edges from the histogram
            counts = [patch.get_height() for patch in axes_in[i].patches]
            bin_edges = [round(patch.get_x(), 10) for patch in axes_in[i].patches]
            bin_edges.append(axes_in[i].patches[-1].get_x() + axes_in[i].patches[-1].get_width())
            if not counts or len(bin_edges) < 2:
                print(f"No data to perform FFT on channel {i + 1}.")
                continue

            # Calculate the bin width
            bin_width = round(bin_edges[1] - bin_edges[0], 10)

            # Perform FFT on the counts
            fft_result = np.fft.fft(counts)
            fft_freq = np.fft.fftfreq(len(fft_result), d=bin_width)

            # Only keep the positive frequencies
            positive_freqs = fft_freq[:len(fft_freq) // 2]
            positive_magnitudes = np.abs(fft_result[:len(fft_result) // 2])

            # Skip first bins to remove DC component
            mask = positive_freqs > 10  # remove frequencies below 10 kHz
            positive_freqs = positive_freqs[mask]
            positive_magnitudes = positive_magnitudes[mask]
            print(len(positive_freqs))

            # # Convert x-axis to us instead of kHz
            periods_us = 1e3 / positive_freqs  # kHz --> us
            
            # Filter out very large or invalid periods
            mask = np.isfinite(periods_us) & (periods_us < 10)  # remove inf, NaN, etc
            # periods_us = periods_us[mask]
            # positive_magnitudes = positive_magnitudes[mask]
            
            # Sort by period (for clean bar display)
            sorted_indices = np.argsort(periods_us)
            # above is a list of indices that would sort periods_us
            sorted_periods_us = periods_us[sorted_indices]  # apply indices to sort
            sorted_positive_magnitudes = positive_magnitudes[sorted_indices]  # sort mags in the same order

            # print value of max frequency peak (excluding DC)
            if len(sorted_positive_magnitudes) > 1:
                max_index = np.argmax(sorted_positive_magnitudes)
                # max_period_us = periods_us[max_index]
                # max_freq_hz = 1e3 / max_period_us  # convert back to Hz
                # max_freq_mhz = max_freq_hz / 1e3
                max_magnitude = sorted_positive_magnitudes[max_index]
                max_period_us = sorted_periods_us[max_index]
                max_freq_khz = 1e3 / max_period_us  # convert to khz
                print(f"Max frequency peak (excluding DC): {max_freq_khz:.2f} kHz, "
                      f"period: {max_period_us:.4f} us, magnitude: {max_magnitude:.2f}")

            # print top 10 frequency peaks
            top_indices = np.argsort(positive_magnitudes)[-30:][::-1]
            top_frequencies = positive_freqs[top_indices]
            top_magnitudes = positive_magnitudes[top_indices]
            print("Top 10 frequency peaks (sorted by magnitude):")
            for freq, mag in zip(top_frequencies, top_magnitudes):
                print(f"  Frequency: {freq:.4f} kHz, Period: {1e3 / freq:.4f} us, "
                      f"Magnitude: {mag:.2f}")

            # Plot the FFT result
            ax.bar(positive_freqs, positive_magnitudes,
                   width=15 * (positive_freqs[1] - positive_freqs[0]),
                   # width=0.005,
                   color='blue', alpha=1.0)
            ax.set_xlabel("Frequency (kHz)")
            ax.set_ylabel("Magnitude")
            ax.grid(True)
            # ax.set_xlim(550, 650)
            ax.set_title(f"CH {i+1}")
            
            # Create second x-axis with periods in µs
            ax2 = ax.twiny()
            ax2.set_xlim(ax.get_xlim())  # Match the main axis limits (in kHz)
            ax2.set_xlabel("Period (µs)")
            ax2.xaxis.set_ticks_position('bottom')
            ax2.xaxis.set_label_position('bottom')
            ax2.spines['bottom'].set_position(('outward', 44))

            # Compute tick locations for ax (freq) and their labels for ax2 (period)
            freq_ticks = ax.get_xticks()
            freq_ticks = [f for f in freq_ticks if ax.get_xlim()[0] < f and f < ax.get_xlim()[1]]
            with np.errstate(divide='ignore'):
                period_labels = [f"{1e3 / f:.2f}" if f > 0 else "" for f in freq_ticks]
            ax2.set_xticks(freq_ticks)
            ax2.set_xticklabels(period_labels)

            # remove x-ticks for all but the last plot
            if i != (num_plots - 1):
                # ax.set_xticks([])
                ax.set_xlabel("")
                ax2.set_xlabel("")
                ax2.set_xticks([])  # remove x-ticks for the second x-axis
                # completely hide the ax2
                ax2.spines['bottom'].set_visible(False)
                
        # margin space
        plt.tight_layout(rect=(0, 0.03, 1, 0.95))
        
        # set y-axes to be equal
        y_max = max(ax.get_ylim()[1] for ax in axes)
        for ax in axes:
            ax.set_ylim(0, y_max)

        output_path = f"img/{self.folder_name}/fft_histogram_{self.file_name}.png"
        if not os.path.exists(f"img/{self.folder_name}"):
            os.mkdir(f"img/{self.folder_name}")
        plt.savefig(output_path)
        if config.show_plots:
            plt.show()
        plt.close()
        
        # assuming Nyquist frequency is 1250 kHz, sampling freq 2500 kHz
        # and incoming signal is delta comb / train of pulses at 590 kHz
        # one would expect a peak at 590 kHz, then peaks at every integer harmonic
        # peaks are produced at:
        # 590 kHz: the main peak (1695 ns)
        # 1180 kHz: the second harmonic
        # 1770 kHz: the third harmonic
        #   reflected back since max freq is 1250 kHz, so
        #   it becomes 2500 - 1770 = 730 kHz
        # 520 kHz: 1250 - 730 kHz
        
        
def main():
    try:
        hex_check = HexCheck()
    except Exception as e:
        print(f"Error initializing HexCheck: {e}")
        traceback.print_exc()
    else:
        hex_check.get_event_types(name_to_event)
        
        # make hex_check available in hex_check_classes.py
        from hex_check_classes import hex_check_state
        hex_check_state[
            "hex_check"] = hex_check  # set global variable to the current instance of HexCheck
        
        try:
            hex_check.main(plot=True)
        except Exception as e:
            print(f"Error processing file {hex_check.file_name}: {e}")
            raise
        
        return hex_check


# hex_check = None


if __name__ == "__main__":
    try:
        hex_check: Optional[HexCheck] = HexCheck()
    except Exception as e:
        print(f"Error initializing HexCheck: {e}")
        traceback.print_exc()
    else:
        hex_check.get_event_types(name_to_event)
        
        # make hex_check available in hex_check_classes.py
        from hex_check_classes import hex_check_state
        
        hex_check_state[
            "hex_check"] = hex_check  # set global variable to the current instance of HexCheck
        
        try:
            hex_check.main(plot=True)
        except Exception as e:
            print(f"Error processing file {hex_check.file_name}: {e}")
            raise
        
        # return hex_check
    # result = unittest.TextTestRunner().run(unittest.defaultTestLoader.discover("tests"))
    #
    # if result.wasSuccessful():
    #     print("\nAll tests passed. Running hex_check...")
    #     hex_check.main(plot=True)
    # else:
    #     print("\nTests failed. Exiting.")
    #     exit()

    # df = hex_check.peak_height_dataframe
    #
    # result = (
    #     df.groupby(['internal_event_number', 'channel_number', 'sub_event_number'])['time_ns']
    #     .agg(min_time='min', max_time='max')
    #     .reset_index()
    # )
    #
    # # Convert to µs and format with commas
    # result['min_time_us'] = (result['min_time'] / 1_000).map('{:,.1f}'.format)
    # result['max_time_us'] = (result['max_time'] / 1_000).map('{:,.1f}'.format)
    #
    # # Drop raw ns columns if you only want µs
    # result = result.drop(columns=['min_time', 'max_time'])
    #
    # pd.set_option('display.max_rows', None)
    #
    # print(result)
    #
    # min_height = df['height'].min()
    # max_height = df['height'].max()
    #
    # print(f"Min height: {min_height}")
    # print(f"Max height: {max_height}")
    
else:
    hex_check: HexCheck = main()

hex_check: HexCheck

print()