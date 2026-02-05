# -*- coding: utf-8 -*-
import os
import re
from typing import Optional

import numpy as np
from IPython.core.display_functions import clear_output
from matplotlib import pyplot as plt, cm

from matplotlib.colors import LogNorm, SymLogNorm, TwoSlopeNorm
from matplotlib.ticker import FixedLocator, FixedFormatter
from mpl_toolkits.axes_grid1 import make_axes_locatable

from extinction_functions import (lorentzian, symmetric_mod, get_delta_trains_from_hex)
from socketudp.hex_check import HexCheck
from socketudp.hex_check_classes import convert_voltage


def plot_2d_histogram_delta_train(delta_train,
                                  detected_period_ns,
                                  common_title_text: str,
                                  colors: list[str],
                                  channel: Optional[int] = None,
                                  fig_ax: Optional[tuple[plt.Figure, plt.Axes]] = None,
                                  subplot_no : int = 0,
                                  bin_width_ns: int = 10,
                                  n_slices: int = 20,
                                  file_name: str = None,
                                  figsize: tuple[int, int] = (8, 6),
                                  textbox=True,
                                  t_range=(0, np.inf),
                                  title: Optional[str] = None,
                                  alpha: float = 1.
                                  ):
    """
    Create a 2D histogram plot of delta train histograms over time.

    Parameters:
    - channel_index: 0-based index into delta_trains[]
    - bin_width_ns: width of each histogram bin (x-axis resolution)
    - slice_duration_ms: time window per slice (y-axis resolution), in ms
    """
    if not isinstance(colors, list):
        colors = [colors]
    if not delta_train.any():
        print("⚠️⚠️ Warning: delta_train is empty, skipping 2D histogram plot. ⚠️⚠️")
        return

    # detected_period_ns = 1 / 589.9801 * 1e6  # convert kHz to ns, use real theoretical value

    # adjust timing window if specified (defaults to zero to inf)
    new_delta_train = delta_train[(delta_train >= t_range[0]) & (delta_train <= t_range[1])]
    
    if len(new_delta_train) == 0:
        # display "No Data" on fig_ax variable, the axis variable from subplots
        if fig_ax is None:
            fig, ax = plt.subplots(figsize=figsize)
        else:
            _, ax = fig_ax
        ax.clear()
        ax.text(0.5, 0.5, "No Data in selected t_range", ha="center", va="center",
                transform=ax.transAxes, fontsize=12,
                bbox=dict(facecolor='white', alpha=0.8))
        ax.set_xticks([])
        ax.set_yticks([])
        
        
        print(f"Original delta_train length: {len(delta_train)}, "
              f"range: {delta_train[0]} to {delta_train[-1]}")
        print(f"After applying t_range {t_range}, new length: {len(new_delta_train)}")
        print("No data in specified t_range; nothing to plot.")
        return

    # Setup slicing parameters
    total_duration_ns = new_delta_train[-1] - new_delta_train[0]
    slice_duration_ns = total_duration_ns / n_slices
    num_slices = int(np.ceil(total_duration_ns / slice_duration_ns))

    # x-axis histogram bin edges (centered around ±detected_period/2)
    hist_range = (-detected_period_ns / 2, detected_period_ns / 2)
    bins = np.arange(hist_range[0], hist_range[1] + bin_width_ns, bin_width_ns)
    delta_slices = []
    all_histograms = []
    means = []

    # Create normalized deltas
    normalized_delta_train = symmetric_mod(new_delta_train, detected_period_ns)

    for i in range(num_slices):
        t_start = new_delta_train[0] + i * slice_duration_ns
        t_end = t_start + slice_duration_ns
        mask = (new_delta_train >= t_start) & (new_delta_train < t_end)
        delta_slice = normalized_delta_train[mask]
        if delta_slice.any():
            means.append(np.mean(delta_slice))
        else:
            means.append(None)
        delta_slices.append(delta_slice)

        counts, _ = np.histogram(delta_slice, bins=bins)
        counts += 1  # Add small constant to avoid log(0) issues
        all_histograms.append(counts)

    all_histograms = np.array(all_histograms)
    all_histograms_log = np.log10(all_histograms)
    
    # Plot as 2D histogram
    for color in colors:
        if fig_ax is None:
            fig, ax = plt.subplots(figsize=figsize)
        else:
            fig_ax: tuple[plt.Figure, plt.Axes]
            fig, ax = fig_ax
        extent = [bins[0], bins[-1], new_delta_train[0] / 1e6, new_delta_train[-1] / 1e6]  # [x_min, x_max, y_min, y_max]
        aspect = 'auto'

        # noinspection PyTypeChecker
        im = ax.imshow(all_histograms_log,  # +1e-3 to prevent log(0) errors
                       extent=extent, origin='lower', alpha=alpha,
                       interpolation='nearest', aspect=aspect, cmap=color,)
                       # norm=LogNorm(vmin=1, vmax=np.max(all_histograms)))

        divider = make_axes_locatable(ax)
        if subplot_no == 2:
            cax = divider.append_axes("right", size="3%", pad=0.05)
            fig.colorbar(im, cax=cax, label=None)
        else:
            cax = divider.append_axes("right", size="3%", pad=0.01)
            fig.colorbar(im, cax=cax, label='Counts (Log Scale)')
            
            # disable x-axis labels, ticks, etc., everything on plot #1
            # ax.set_xticks([])
            # ax.set_xlabel("")
            

        # quick extinction measurement, divide particles within +/- 125ns over particles outside of that window
        in_time_counts = np.sum(np.abs(normalized_delta_train) <= 125)
        out_of_time_counts = len(normalized_delta_train) - in_time_counts
        total = in_time_counts + out_of_time_counts
        if total == in_time_counts:
            # Avoid "perfect" extinction number
            extinction_ratio = (out_of_time_counts + 1) / total
        else:
            extinction_ratio = out_of_time_counts / total

        # Add box showing (1) number of points, (2) detected period, and (3) extinction ratio
        box_text = (f"{len(new_delta_train)} points\n"
                    f"Detected Period: {detected_period_ns:.3f} ns\n"
                    f"In/Out Particles: {in_time_counts}/{out_of_time_counts}\n"
                    f"Extinction Ratio: {extinction_ratio:.2e}")
        if total == in_time_counts:
            box_text += "\n(Add 1 OOT particle for calc.)"
        if textbox:
            ax.text(0.05, 0.95, box_text, transform=ax.transAxes, fontsize=10,
                    verticalalignment='top', horizontalalignment='left', bbox=dict(facecolor='white', alpha=0.8))
        else:
            print(box_text)

        # Add thin red vertical lines at +/- 125 ns
        if color == 'inferno':
            linecolor = 'red'
        elif color == 'Blues':
            linecolor = 'blue'
        else:
            linecolor = 'red'
        ax.axvline(-125, color=linecolor, linestyle='--', linewidth=1.5)
        ax.axvline(125, color=linecolor, linestyle='--', linewidth=1.5)

        if subplot_no != 1:
            ax.set_xlabel("Modulo Time (ns)")
        ax.set_ylabel("Time (ms)")

        if subplot_no != 2:
            if title:
                # a custom title was passed in
                ax.set_title(title)
            else:
                if channel:
                    ax.set_title(f"{common_title_text} - Channel {channel}")
                else:
                    ax.set_title(f"{common_title_text}")
        plt.tight_layout(rect=(0, 0, 1, 1))

        if not fig_ax:
            if file_name:
                file_type = file_name.split('.')[-1]
                plt.savefig(file_name, format=file_type, dpi=300, bbox_inches="tight", pad_inches=0)
            plt.show()


def plot_1d_histogram(data_lists: list[np.ndarray],
                      sample_period: float = 0,
                      common_title_text: str = "",
                      include_sample_peaks=False,
                      title: Optional[str] = None,
                      units: Optional[str] = None,   # 'ns' or 'ms'
                      hist_range: Optional[tuple] = None,
                      log: Optional[bool] = None,
                      loc: Optional[str] = None,
                      alpha: Optional[float] = 0.5,
                      bin_size_ns: Optional[int | float] = 40,  # default bin size in ms
                      fig_size: tuple[int, int] = (10, 6),  # default figure width in inches
                      legend: bool = True,
                      file_name: str = "histogram_plot.svg",
                      sample_offset: int = 0,  # offset for sample peaks
                      **kwargs):
    """Plot a 1D histogram of multiple data lists."""
    fig, ax = plt.subplots(figsize=fig_size)

    # check for empty data lists
    for i, l in enumerate(data_lists):
        if not l.any():
            print(f"⚠️⚠️ Warning: Data list #{i + 1} is empty, skipping histogram plot. ⚠️⚠️")
            data_lists.pop(i)

    # calculate range of histogram
    if not hist_range:
        hist_min = np.min([data.min() for data in data_lists if data.any()])
        hist_max = np.max([data.max() for data in data_lists if data.any()])
        hist_range = (hist_min, hist_max)

    # if "units" is not passed explicitly into func args, check units of plots (ms / ns)
    if not units:
        if hist_range[1] - hist_range[0] < 1e6:
            units = "ns"
        else:
            units = "ms"

    # create bins
    original_hist_range = hist_range
    if units == "ms":
        bin_size = 0.1  # ms
        if bin_size_ns:
            bin_size = bin_size_ns / 1e6
        hist_range = (hist_range[0] / 1e6, hist_range[1] / 1e6)  # convert to ms
        bins = np.arange(hist_range[0], hist_range[1] + bin_size, bin_size)
        data_lists = [data / 1e6 for data in data_lists]  # convert to ms
    elif units == "ns":
        data_lists = [data - hist_range[0] for data in data_lists]  # shift to start at 0
        hist_range = (hist_range[0] - hist_range[0], hist_range[1] - hist_range[0])  # adjust range to start at 0
        bin_size = bin_size_ns  # ns
        bins = np.arange(np.floor(hist_range[0]), np.ceil(hist_range[1]) + bin_size, bin_size)
    else:
        raise ValueError("Invalid units. Use 'ms' or 'ns'.")

    # create sample 1695 ns period peaks for display
    if include_sample_peaks:
        if sample_period == 0:
            raise ValueError("Sample period must be specified if include_sample_peaks is True.")
        if units == "ms":
            mult = 1e-6
        else:
            mult = 1
        sample_peaks = np.arange(hist_range[0] + mult * sample_offset,
                                 hist_range[1] + mult * (1*sample_period + sample_offset),
                                 mult * sample_period).astype(float)
        data_lists.append(sample_peaks.repeat(5))

    data_lists = [data[(data >= hist_range[0]) & (data <= hist_range[1])] for data in data_lists]

    # plot data
    for i, data in enumerate(data_lists):
        
        if log:
            # Avoid log(0) by ensuring no bin has zero height
            data = np.clip(data, 1e-2, None)

        if i == 3:
            for j, x in enumerate(data):
                x: float
                if j == 0:
                    label = f"Sample Peaks ({sample_period:.1f} ns)"
                else:
                    label = None
                ax.axvline(x, color='red', linestyle='dotted', alpha=alpha, linewidth=1, label=label)
        else:
            label = f"CH.{i + 1}: {len(data)} hits"
            ax.hist(data, bins=bins, histtype='stepfilled', alpha=alpha, label=label, **kwargs)

    if log:
        ax.set_yscale('symlog', linthresh=99)
        ax.set_ylim(bottom=1e-3)

    if units == 'ns':
        ax.set_xlabel(f"Time ({units}, normalized to start at 0 ns)")
    else:
        ax.set_xlabel(f"Time ({units})")

    if log:
        ax.set_ylabel("SymLog Counts")
    else:
        ax.set_ylabel("Counts")

    # need to remove "Time Range" from common_title_text
    common_title_text = re.sub(r"\n?Time Range: .*\n?", "", common_title_text)
    if not title:
        title = (f"1D Histogram of Delta Trains - " + common_title_text +
                 f"\nTime Range: {original_hist_range[0] / 1e6:.2f} to {original_hist_range[1] / 1e6:.2f} ms")
    ax.set_title(title)
    if legend:
        ax.legend(loc=loc)
    plt.tight_layout()
    if file_name:
        file_type = file_name.split('.')[-1]
        if log:
            file_name = re.sub(f".{file_type}$", f"_log.{file_type}", file_name)
        plt.savefig(file_name, format=file_type, dpi=300, bbox_inches="tight", pad_inches=0)
    plt.show()


def plot_fft_peak(mini_fft_freqs, mini_fft_abs, freq_window, amp_window, popt, amp_exponent, common_title_text,
                  delta_train, detected_frequency, detected_period, fft_time_range_ns, file_name: str = "",
                  title: str = None,
                  figsize: tuple[int, int] = (10, 5)):
    # (1) plot the FFT result (zoomed in on peak)
    plt.figure(figsize=figsize)
    df = mini_fft_freqs[1] - mini_fft_freqs[0]  # frequency resolution
    plt.bar(mini_fft_freqs, mini_fft_abs, width=df * 0.9, color='blue', label='FFT Amplitude')

    # (2) plot the points used for the fit
    plt.scatter(freq_window, amp_window, color='green', label='Fit Input Points', s=10)

    # (3) plot the fit result
    fit_t = np.arange(mini_fft_freqs[0], mini_fft_freqs[-1], 0.001)
    plt.plot(fit_t, lorentzian(fit_t, *popt),
             color='red', alpha=0.7, label="Lorentzian Fit")

    # plot settings
    if title is None:
        title = "FFT of Delta Train (zoom on first peak)"
        if amp_exponent == 2:
            title += " (Power Spectrum)"
        elif amp_exponent == 1:
            title += " (Amplitude Spectrum)"
        plt.title(title + f"\n{common_title_text}")
    else:
        plt.title(title)

    plt.xlabel("Frequency (kHz)")
    plt.ylabel("Normalized Amplitude")
    # plt.subplots_adjust(left=0, right=1, top=0.95, bottom=0.05)
    plt.legend()

    # calculate time range in ms

    # add box showing number of points, as well as frequency and period peak
    plt.text(0.05, 0.95, f"FFT from {len(delta_train)} counts\n"
                         f"Frequency: {detected_frequency:.3f} kHz\n"
                         f"Period: {detected_period:.2f} ns", transform=plt.gca().transAxes,
             fontsize=10, verticalalignment='top', bbox=dict(facecolor='white', alpha=0.5))

    plt.tight_layout()
    if file_name:
        file_type = file_name.split('.')[-1]
        plt.savefig(file_name, format=file_type, dpi=300, bbox_inches="tight", pad_inches=0)

    plt.show()


def plot_normalized_histogram(delta_trains, normalized_delta_trains, period, normalized=False, file_name: str = None,
                              figsize=(6, 6),
                              log: bool = False,
                              symlog: bool = False,
                              title: str = None,
                              bin_count: int = 100):
    """Plot all three normalized delta trains together as histograms with normalized amplitudes"""
    fig, ax = plt.subplots(1, 1, figsize=figsize)

    min_t = min(train.min() for train in delta_trains)
    max_t = max(train.max() for train in delta_trains)
    if max_t > 1e6:  # ms
        time_range_str = f"Time Range: {min_t / 1e6:.2f} to {max_t / 1e6:.2f} ms"
    else:
        time_range_str = f"Time Range: {min_t:.2f} ns to {max_t:.2f} ns"
    min_x = min(train.min() for train in normalized_delta_trains)
    max_x = max(train.max() for train in normalized_delta_trains)
    for j, train in enumerate(normalized_delta_trains):
        counts, bins = np.histogram(train, bins=bin_count, range=(min_x, max_x))
        if normalized:
            counts = counts / counts.max()  # normalize amplitude
        bin_centers = (bins[:-1] + bins[1:]) / 2
        ax.hist(bin_centers, bins=bin_count, weights=counts,
                alpha=0.7, label=f'Ch. {j + 1} ({len(train)} counts)')


    # Add labels, titles, and legends to the figures
    if normalized:
        ax.set_xlabel("Normalized Time (ns)")
        ax.set_ylabel("Normalized Amplitude")
        ax.set_title("Normalized Delta Trains Histogram")
    else:
        ax.set_xlabel("Modulo Time (ns)")
        ax.set_ylabel("Counts")
        ax.set_title("Delta Trains Histogram")

    if log and symlog:
        raise ValueError("Cannot set both log and symlog to True.")

    if log:
        ax.set_yscale('log')
        
    if symlog:
        ax.set_yscale('symlog', linthresh=500)

    if title:
        # override title with local custom title
        ax.set_title(title)
    else:
        ax.set_title(ax.get_title() + f" - {time_range_str}")

    # add box showing counts per channel
    counts_per_channel = [len(train) for train in normalized_delta_trains]
    box_text = f"Period: {period:.3f} ns"
    # ax.text(0.05, 0.55,
    #          box_text,
    #          transform=ax.transAxes,
    #          fontsize=10, verticalalignment='top', bbox=dict(facecolor='white', alpha=0.5))

    # put box_text in empty plot to go inlegend instead
    plt.plot([], label=box_text, marker='None', color='None')

    ax.legend(loc="upper left")
    plt.legend()
    plt.tight_layout()
    if file_name:
        plt.savefig(file_name, format='svg', dpi=300, bbox_inches="tight", pad_inches=0)
    plt.show()
    plt.close(fig)


def test_2d_hist():
    # Example usage
    start = 59e5 - 59e5 % 1695
    finish = 201e5
    period = 1695  # Example detected period in ns
    delta_train = np.arange(start, finish, 1695)
    delta_train += np.random.normal(0, 15, len(delta_train)).astype(int)  # Simulated delta train errors
    common_title_text = "Example Delta Train Histogram"

    plot_2d_histogram_delta_train(delta_train, period, common_title_text, colors=['inferno'])


def just_plot_histogram(hex_check):
    ch1 = get_delta_trains_from_hex(hex_check, 1, (None, None))
    ch2 = get_delta_trains_from_hex(hex_check, 2, (None, None))
    ch3 = get_delta_trains_from_hex(hex_check, 3, (None, None))
    chs = [ch1, ch2, ch3]

    log = True
    if log:
        # to avoid error with log(0)
        ch1 += 1
        ch2 += 1
        ch3 += 1

    min_x = np.min([np.min(ch) for ch in chs])
    max_x = np.max([np.max(ch) for ch in chs])
    print(min_x, max_x)

    for ch in chs:
        print(ch[-10:])
    plot_1d_histogram([ch1, ch2, ch3], log=log, range=(min_x, max_x))


def _slice_hist(normalized_delta, t_abs, bins, t0, t1, n_slices):
    total_duration = t1 - t0
    slice_dur = total_duration / n_slices
    H = []
    for i in range(n_slices):
        s0 = t0 + i * slice_dur
        s1 = s0 + slice_dur
        m = (t_abs >= s0) & (t_abs < s1)
        counts, _ = np.histogram(normalized_delta[m], bins=bins)
        H.append(counts)
    return np.asarray(H), (t0, t1)

def _in_out_counts(norm_delta, window_ns=125):
    in_cnt = np.sum(np.abs(norm_delta) <= window_ns)
    out_cnt = len(norm_delta) - in_cnt
    total = in_cnt + out_cnt
    # avoid zero-out edge case for extinction
    if total == in_cnt:
        ext = (out_cnt + 1) / total
        note = " (+1 OOT)"
    else:
        ext = out_cnt / total
        note = ""
    return in_cnt, out_cnt, ext, note

def plot_2d_histogram_delta_train_compare(
    before_delta,
    after_delta,
    before_period_ns,
    after_period_ns,
    common_title_text="",
    fig_ax=None,
    bin_width_ns=10,
    n_slices=20,
    mode="diff",                 # "diff" or "ratio"
    t_range=(0, np.inf),
    title=None,
    show_textbox=True
):
    """
    Single-axes comparison of two delta trains using either:
      - difference heatmap: (after - before)
      - ratio heatmap: log10(after / before)

    Both datasets are histogrammed on identical (time-slice, modulo-time) grids.
    """

    # guard
    if (before_delta is None or len(before_delta)==0) or (after_delta is None or len(after_delta)==0):
        print("Empty input; nothing to plot.")
        return

    # restrict absolute time range consistently
    before = before_delta[(before_delta >= t_range[0]) & (before_delta <= t_range[1])]
    after  = after_delta [(after_delta  >= t_range[0]) & (after_delta  <= t_range[1])]
    if len(before)==0 or len(after)==0:
        print("No data in selected t_range; nothing to plot.")
        return

    # common absolute-time window & slices
    t0 = min(before[0], after[0])
    t1 = max(before[-1], after[-1])

    # common modulo bins
    halfP = after_period_ns / 2.0
    bins = np.arange(-halfP, halfP + bin_width_ns, bin_width_ns)

    # modulo-normalized deltas (use same reference period for both!)
    before_mod = symmetric_mod(before, before_period_ns)
    after_mod  = symmetric_mod(after,  after_period_ns)

    # build per-slice histograms on the same grid
    H_before, (abs0, abs1) = _slice_hist(before_mod, before, bins, t0, t1, n_slices)
    H_after,  _            = _slice_hist(after_mod,  after,  bins, t0, t1, n_slices)

    # choose comparison metric
    if mode == "diff":
        # raw difference
        H = H_after - H_before
        # diverging norm centered at 0; SymLog helps when range is wide but you want detail near 0
        # tweak linthresh if you want a wider linear region
        norm = SymLogNorm(linthresh=1.0, vmin=np.min(H), vmax=np.max(H), base=10)
        cbar_label = "ΔCounts (after − before)"
        cmap = "RdBu_r"
    elif mode == "ratio":
        # add pseudocounts to avoid divide-by-zero in empty bins
        H = np.log10((H_after + 1.0) / (H_before + 1.0))
        # center at 0 → equal; +1 → 10×; −1 → 0.1×
        v = np.nanmax(np.abs(H[np.isfinite(H)]))
        norm = TwoSlopeNorm(vmin=-v, vcenter=0.0, vmax=v)
        cbar_label = "log10(after / before)"
        cmap = "RdBu_r"
    else:
        raise ValueError("mode must be 'diff' or 'ratio'")

    # prepare axes
    if fig_ax is None:
        fig, ax = plt.subplots(figsize=(8, 4))
    else:
        fig, ax = fig_ax

    extent = [bins[0], bins[-1], abs0/1e6, abs1/1e6]  # x_min, x_max, y_min(ms), y_max(ms)

    # noinspection PyTypeChecker
    im = ax.imshow(
        H,
        extent=extent,
        origin="lower",
        interpolation="nearest",
        aspect="auto",
        cmap=cmap,
        norm=norm
    )

    # colorbar
    divider = make_axes_locatable(ax)
    cax = divider.append_axes("right", size="3.5%", pad=0.05)
    cb = fig.colorbar(im, cax=cax)
    cb.set_label(cbar_label)

    # guide lines at ±125 ns
    ax.axvline(-125, color="black", linestyle="--", linewidth=1.0, alpha=0.6)
    ax.axvline( 125, color="black", linestyle="--", linewidth=1.0, alpha=0.6)

    # labels/titles
    ax.set_xlabel("Modulo Time (ns)")
    ax.set_ylabel("Time (ms)")
    if title:
        ax.set_title(title)
    else:
        ax.set_title(f"{common_title_text}\nComparison ({mode})")

    # quick extinction stats box for both datasets
    b_in, b_out, b_ext, b_note = _in_out_counts(before_mod)
    a_in, a_out, a_ext, a_note = _in_out_counts(after_mod)
    if show_textbox:
        # Get the two endpoint colors from the colormap
        cmap_obj = cm.get_cmap(cmap)  # cmap is a string like "PuOr"
        before_text_color = cmap_obj(0.0)  # low end
        after_text_color = cmap_obj(1.0)  # high end

        # txt = (
        #     f"{common_title_text}\n"
        #     f"Before: {len(before)} pts, Ext: {b_ext:.2e}{b_note}\n"
        #     f"After : {len(after)} pts, Ext: {a_ext:.2e}{a_note}\n"
        #     f"Window: ±125 ns"
        # )
        # ax.text(0.97, 0.97, txt, transform=ax.transAxes,
        #         va="top", ha="right", fontsize=9,
        #         linespacing=1.3,
        #         bbox=dict(facecolor="white", alpha=0.9, boxstyle="round,pad=0.25"),
        #         # Here’s the trick: use per-line colors
        #         fontproperties=None)

        # Unfortunately `ax.text` doesn’t support multiple colors in one string,
        # so if you want the “Before” and “After” lines different colors,
        # you have to use separate text calls for those lines:
        ax.text(0.97, 0.97, f"Before: {len(before)} pts, Ext: {b_ext:.2e}{b_note}",
                transform=ax.transAxes, va="top", ha="right", fontsize=9,
                color=before_text_color,
                bbox=dict(facecolor="white", alpha=0.9, boxstyle="round,pad=0.25"))
        ax.text(0.97, 0.97 - 0.08, f"After : {len(after)} pts, Ext: {a_ext:.2e}{a_note}",
                transform=ax.transAxes, va="top", ha="right", fontsize=9,
                color=after_text_color,
                bbox=dict(facecolor="white", alpha=0.9, boxstyle="round,pad=0.25"))
        ax.text(0.97, 0.97 - 0.16, f"Window: ±125 ns",
                transform=ax.transAxes, va="top", ha="right", fontsize=9,
                bbox=dict(facecolor="white", alpha=0.9, boxstyle="round,pad=0.25"))
        
        
def plot_2d_histogram_time_vs_event_number(
    delta_trains: list[np.ndarray],
    bin_width=50,
    common_title_text="",
    channel: Optional[int] = None,
    figsize=(8, 6),
    cmap="viridis",
    log_scale=True,
    file_name: Optional[str] = None,
    title: Optional[str] = None,
    units = "ns",
    t_range=(0, np.inf),
    binrange=None
):
    """
    Plot a 2D histogram of absolute hit times vs event number.

    Parameters
    ----------
    delta_trains : list[np.ndarray]
        List of per-event time arrays (ragged).
    bin_width : float | int
        Width of histogram bins in time (see "units" variable) (x-axis resolution).
    common_title_text : str
        Common title text prefix.
    channel : int, optional
        Channel number to display in title.
    figsize : tuple
        Figure size.
    cmap : str
        Colormap for imshow.
    log_scale : bool
        If True, apply logarithmic color normalization.
    file_name : str, optional
        If provided, save the figure.
    title : str, optional
        Custom plot title.
    """
    if t_range:
        # mask delta_trains to new time range
        new_delta_trains = []
        for delta_train in delta_trains:
            mask = (delta_train >= t_range[0]) & (delta_train <= t_range[1])
            masked_delta_train = delta_train[mask]
            new_delta_trains.append(masked_delta_train)
        delta_trains = new_delta_trains
        
    at_least_one_train = False
    for train in delta_trains:
        if len(train) > 0:
            at_least_one_train = True
            break
    if not at_least_one_train:
        print("No data in specified t_range; nothing to plot.")
        return
    
    # Flatten to find global time range
    all_times = np.concatenate([ev for ev in delta_trains if len(ev) > 0])
    tmin, tmax = all_times.min(), all_times.max()
    
    # potentially convert data between ns and ms
    if units == "ms":
        if tmax - tmin > 1e6:
            # delta_trains is a list of delta_train np.arrays
            print("Converting data from ns to ms for histogram plot.")
            delta_trains = [ev / 1e6 for ev in delta_trains]
            tmin /= 1e6
            tmax /= 1e6
    elif units == "ns":
        if tmax - tmin < 40:
            # convert ms to ns
            print("Converting data from ms to ns for histogram plot.")
            delta_trains = [ev * 1e6 for ev in delta_trains]
            tmin *= 1e6
            tmax *= 1e6
    
    if binrange:
        tmin, tmax = binrange[0], binrange[1]
    bins = np.arange(tmin, tmax + bin_width, bin_width)
    if len(bins) > 1000000:
        print(f"⚠️⚠️ Warning: Too many histogram bins, reduce bin_width or remove this warning. ⚠️⚠️"
              f"({len(bins)} bins from {tmin} to {tmax} with width {bin_width}) ⚠️⚠️")
        return
    
    # Build histogram: rows = events, cols = bins
    H = np.zeros((len(delta_trains), len(bins) - 1), dtype=int)
    for i, ev in enumerate(delta_trains):
        if len(ev) == 0:
            continue
        counts, _ = np.histogram(ev, bins=bins)
        H[i, :] = counts
    
    extent = [bins[0], bins[-1], 0, len(delta_trains)]  # x_min, x_max, y_min, y_max
    
    fig, ax = plt.subplots(figsize=figsize)
    if log_scale:
        # norm = LogNorm(vmin=1, vmax=np.max(H))
        H = np.log10(H + 1)  # log10(counts + 1) to avoid log(0)
        norm = None
    else:
        norm = None
    im = ax.imshow(
        H,
        extent=extent,
        aspect="auto",
        origin="lower",
        cmap=cmap,
        norm=norm,
        interpolation="nearest"
    )
    
    divider = make_axes_locatable(ax)
    cax = divider.append_axes("right", size="3%", pad=0.05)
    cbar = fig.colorbar(im, cax=cax)
    cbar.set_label("Counts" + (" (log)" if log_scale else ""))
    
    ax.set_xlabel("Time (ns)")
    if units == "ms":
        ax.set_xlabel("Time (ms)")
    ax.set_ylabel("Event Number")
    
    if not title:
        if channel:
            title = f"{common_title_text}\nCH {channel}: Peak Time vs Event Number"
        else:
            title = f"{common_title_text}\nPeak Time vs Event Number"
    ax.set_title(title)
    
    # create legend showing info like total counts, etc
    total_counts = sum(len(ev) for ev in delta_trains)
    box_text = (f"{len(delta_trains)} events\n"
                f"{total_counts} total counts\n"
                f"Time Range: {tmin:.2f} to {tmax:.2f} {units}")
    ax.text(0.05, 0.95, box_text, transform=ax.transAxes, fontsize=10,
            verticalalignment='top', horizontalalignment='left', bbox=dict(facecolor='white', alpha=0.8))
    
    plt.tight_layout()
    if file_name:
        file_type = file_name.split('.')[-1]
        plt.savefig(file_name, format=file_type, dpi=300,
                    bbox_inches="tight", pad_inches=0)
    plt.show()
    
    
def plot_raw_data(_hex_check: HexCheck, n_subevents = np.inf, event_range = (0, np.inf), plotting_units = "volts", figsize = (8, 8), t_range=(0, np.inf), y_range=None):
    # grouped = _hex_check.raw_data_dataframe.groupby(["internal_event_number", "sub_event_number"])
    grouped = _hex_check.raw_data_dataframe.groupby(["internal_event_number"])
    # for (internal_event, sub_event), group in grouped:
    for (internal_event), group in grouped:
        if isinstance(internal_event, tuple):
            internal_event = internal_event[0]
        # if sub_event + 1 > n_subevents or internal_event > n_events:
        if not (event_range[0] <= internal_event <= event_range[1]):
            continue
        t_arrays = []
        channel_arrays = []
        for ch in [1, 2, 3, 4]:
            ch_data = group[group["channel_number"] == ch]["data"].values
            y_vals = convert_voltage(ch_data) if plotting_units == "volts" else ch_data
            t_data = np.array(range(len(ch_data)))

            t_mask = (t_range[0] < t_data) & (t_data < t_range[1])
            t_data = t_data[t_mask]
            y_vals = y_vals[t_mask]

            # y_mask = (y_range[0] < y_vals) & (y_vals < y_range[1])
            # t_data = t_data[y_mask]
            # y_vals = y_vals[y_mask]

            t_arrays.append(t_data.tolist())
            channel_arrays.append(y_vals.tolist())

            print(f"Channel {ch}")
            for i in y_vals:
                # print each value in binary, including full zero padding
                if abs(i) > 10:
                    print(f"{i:08b} --> {i}")
        plot_event_grid(_hex_check, channel_arrays, internal_event,
                                   "Raw Data - Event", "raw",
                                   # sub_event=sub_event
                        n_plots=4, channel_in=2, figsize=figsize, t_data=t_arrays, y_range=y_range, plotting_units=plotting_units)


def plot_event_grid(_hex_check, grouped_data: list[list[float]],
                    internal_event: int,
                    title_prefix: str = '',
                    file_prefix: str = '',
                    sub_event: int = None,
                    t_data: list[list[float]] = None,
                    y_range: list[list[float]] = None,
                    optional_note=None, plotting_units="volts",
                    n_plots=4, channel_in=4, figsize=(10, 8)):
    """
    Plots a 2x2 grid using the grouped data.

    Parameters:
        grouped_data: List of 4 lists (one per channel). Each list contains Y-axis values to plot.
        internal_event: Event number for labeling and saving.
        title_prefix: Title string prefix (e.g. "Raw Data - Event").
        file_prefix: File prefix for saved image (e.g. "raw").
        sub_event: (Optional) Sub-event number for labeling.
        t_data: Optional list of 4 lists (one per channel). Each list contains X-axis values to plot.
        optional_note: Optional note string (e.g. "Raw Data - Event").
        plotting_units: Optional units string (e.g. "volts").
    """
    if n_plots == 1:
        fig, axes = plt.subplots(1, 1, figsize=figsize)
        axes = np.array([axes])
    else:
        fig, axes = plt.subplots(4, 1, figsize=figsize)

    title = f"{title_prefix} - Event {internal_event}"
    if sub_event is not None:
        title += f", Subevent {sub_event}"
    time_str = _hex_check.file_creation_date.strftime("%Y-%m-%d %H:%M:%S")
    title += f"\n{_hex_check.file_name} ({time_str})"

    fig.suptitle(title, fontsize=14)

    output_path = f"img/{_hex_check.folder_name}/{file_prefix}_{internal_event}.png"
    if not os.path.exists(f"img/{_hex_check.folder_name}"):
        os.mkdir(f"img/{_hex_check.folder_name}")

    if optional_note:
        # annotate below the bottom-right axis
        axes[1, 1].annotate(optional_note, xy = (1.0, -0.2), xycoords = 'axes fraction',
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
        if n_plots == 1:
            channel = channel_in
            channel_t = t_data[channel - 1]
            channel_data = grouped_data[channel - 1]
        if channel_data:
            if channel_t:
                # if the range is too large, convert to us or ms
                if max(channel_t) - min(channel_t) > 1e6:
                    channel_t = [t / 1e6 for t in channel_t]
                    units = 'ms'
                elif max(channel_t) - min(channel_t) > 3.5e3:
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

        if y_range:
            # set y-range to y_range[0] to y_range[1]
            ax.set_ylim(y_range)

        if i >= 2 or units != 'ns':
            ax.set_xlabel(f"Time ({units})")
        if i % 2 == 0:
            ax.set_ylabel("Voltage (V)" if plotting_units == "volts" else "ADC Raw Count")

    plt.tight_layout(rect=(0, 0.01, 1, 0.99))
    plt.savefig(output_path)
    plt.show()
    plt.close()


def peak_width_classification(peak_areas, type="peak_width"):
    # Config (adjust as needed)
    manual_sample_period = None  # e.g. 1/125e6  -> set to seconds/sample if you know it, otherwise None
    use_log_scales = True  # log-log scatter for width vs area
    save_figures: Optional[str] = None  # filepath (e.g. "peak_widths_summary.png") or None to skip saving
    
    # --- collect widths/areas robustly from peak_areas (assumes 'peak_areas' exists) ---
    import math
    import numpy as np
    import matplotlib.pyplot as plt
    
    try:
        import seaborn as sns
        sns.set(style="whitegrid")
        _use_sns = True
    except Exception:
        _use_sns = False
    
    # Build arrays
    _widths = []
    _areas = []
    for p in peak_areas:
        if p is None:
            continue
            
        w = getattr(p, type, None)
        if w is None:
            continue
            
        try:
            w = float(w)
        except Exception:
            continue
            
        if type == 'height':
            w = -w  # heights are usually all negative
            
        # guard against negative or nan widths
        if not math.isfinite(w) or w <= 0:
            continue
        _widths.append(w)
        
        a = getattr(p, "peak_area", None)
        try:
            a = float(a) if a is not None else np.nan
        except Exception:
            a = np.nan
        _areas.append(a)
    
    _widths = np.array(_widths)
    _areas = np.array(_areas, dtype=float) if _areas else np.array([])
    
    if _widths.size == 0:
        print("No valid peak widths found in `peak_areas`.")
    else:
        # --- detect sample_period intelligently (samples -> seconds) ---
        def detect_sample_period(objs, fallback_hc=None, manual=None):
            if manual is not None:
                return float(manual)
            # search for direct sample_period-like fields
            for attr in ("sample_period", "dt", "time_per_sample"):
                for o in objs:
                    val = getattr(o, attr, None)
                    if val is not None:
                        return float(val)
            # search for sample rate (Hz) and invert
            for attr in ("sample_rate", "sampling_rate", "fs", "sr"):
                for o in objs:
                    val = getattr(o, attr, None)
                    if val is not None:
                        try:
                            val = float(val)
                            return 1.0 / val if val != 0 else None
                        except Exception:
                            pass
            # try fallback object (hc) if provided
            if fallback_hc is not None:
                for attr in ("sample_period", "dt", "time_per_sample"):
                    val = getattr(fallback_hc, attr, None)
                    if val is not None:
                        return float(val)
                for attr in ("sample_rate", "sampling_rate"):
                    val = getattr(fallback_hc, attr, None)
                    if val is not None:
                        val = float(val)
                        return 1.0 / val if val != 0 else None
            return None
        
        sample_period = detect_sample_period(peak_areas, fallback_hc=globals().get("hc", None),
                                             manual=manual_sample_period)
        widths_time = _widths * sample_period if sample_period is not None else None
        
        # --- summary statistics ---
        import statistics
        count = _widths.size
        mean_samples = float(_widths.mean())
        med_samples = float(np.median(_widths))
        std_samples = float(_widths.std(ddof=1)) if count > 1 else 0.0
        min_samples, max_samples = float(_widths.min()), float(_widths.max())
        
        # area-weighted mean when area available and finite
        wmean_samples = None
        if _areas.size == count:
            finite_mask = np.isfinite(_areas)
            if finite_mask.any():
                denom = _areas[finite_mask].sum()
                if denom != 0:
                    wmean_samples = float(
                        np.average(_widths[finite_mask], weights=_areas[finite_mask]))
        
        # print concise summary
        print(
            f"Peak widths (n={count}): mean={mean_samples:.6g} samples, median={med_samples:.6g}, std={std_samples:.6g}")
        print(f"min={min_samples:.6g}, max={max_samples:.6g}")
        if wmean_samples is not None:
            print(f"area-weighted mean = {wmean_samples:.6g} samples")
        if sample_period is not None:
            print(
                f"Sample period detected: {sample_period:.6g} s/sample -> mean time = {mean_samples * sample_period:.6g} s")
        
        # --- plotting: histogram+KDE, violin/box, width vs area, ECDF, plus time histogram if available ---
        fig, axes = plt.subplots(2, 2, figsize=(12, 8))
        ax_hist, ax_violin, ax_scatter, ax_ecdf = axes.ravel()
        
        # Histogram + KDE (samples)
        if _use_sns:
            sns.histplot(_widths, bins="auto", kde=True, ax=ax_hist, stat="count", color="C0")
        else:
            ax_hist.hist(_widths, bins="auto", color="C0", alpha=0.7)
        ax_hist.axvline(mean_samples, color="r", linestyle="--", label=f"mean {mean_samples:.3g}")
        if wmean_samples is not None:
            ax_hist.axvline(wmean_samples, color="g", linestyle=":",
                            label=f"area-weighted {wmean_samples:.3g}")
        ax_hist.set_title("Peak widths (samples)")
        ax_hist.set_xlabel("Width (samples)")
        ax_hist.legend()
        
        # Violin or box (distribution summary)
        if _use_sns:
            sns.violinplot(x=_widths, inner="quartile", color="C1", ax=ax_violin)
        else:
            ax_violin.boxplot(_widths, vert=False, patch_artist=True, boxprops=dict(color="C1"))
        ax_violin.set_title("Distribution (violin / box)")
        ax_violin.set_xlabel("Width (samples)")
        
        # Scatter: width vs area (helpful to see size/width correlation). Use log scales if appropriate.
        if _areas.size == count:
            x = _areas
            xlabel = "Peak area"
        else:
            # if no area, use index to show spread over buffer order
            x = np.arange(count)
            xlabel = "Index (peak order)"
        ax_scatter.scatter(x, _widths, alpha=0.6)
        if use_log_scales and (_areas.size == count) and (
        np.nanmin(x[x > 0]) > 0 if np.any(x > 0) else False):
            try:
                ax_scatter.set_xscale("log")
                ax_scatter.set_yscale("log")
            except Exception:
                pass
        ax_scatter.set_xlabel(xlabel)
        ax_scatter.set_ylabel("Width (samples)")
        ax_scatter.set_title("Width vs Area (or index)")
        
        # ECDF
        sorted_w = np.sort(_widths)
        ecdf = np.arange(1, count + 1) / count
        ax_ecdf.plot(sorted_w, ecdf, marker=".", linestyle="none")
        q = [0.01, 0.05, 0.25, 0.5, 0.75, 0.95, 0.99]
        quantiles = np.quantile(sorted_w, q)
        # annotate median and a couple quantiles
        ax_ecdf.axvline(med_samples, color="r", linestyle="--", label=f"median {med_samples:.3g}")
        ax_ecdf.set_title("ECDF of widths")
        ax_ecdf.set_xlabel("Width (samples)")
        ax_ecdf.set_ylabel("ECDF")
        ax_ecdf.legend()
        
        plt.tight_layout()
        
        # If we can convert to time, make a small time histogram too (new figure)
        if widths_time is not None:
            fig2, ax2 = plt.subplots(1, 1, figsize=(6, 3.5))
            if _use_sns:
                sns.histplot(widths_time, bins="auto", kde=True, ax=ax2, color="C2")
            else:
                ax2.hist(widths_time, bins="auto", color="C2", alpha=0.7)
            ax2.set_title("Peak widths (time)")
            ax2.set_xlabel("Seconds")
            ax2.axvline(np.mean(widths_time), color="r", linestyle="--",
                        label=f"mean {np.mean(widths_time):.3g}s")
            if wmean_samples is not None:
                ax2.axvline(wmean_samples * sample_period, color="g", linestyle=":",
                            label=f"area-weighted {wmean_samples * sample_period:.3g}s")
            ax2.legend()
            plt.tight_layout()
            if save_figures:
                fig2.savefig(save_figures.replace(".png", "_time.png") if save_figures.endswith(
                    ".png") else save_figures)
            plt.show()
        else:
            plt.show()
        
        if save_figures:
            fig.savefig(save_figures)
            print(f"Saved summary figure to: {save_figures}")
            

if __name__ == "__main__":
    print("don't run this file")