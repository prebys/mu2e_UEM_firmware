import re
from typing import Optional

import numpy as np
from IPython.core.display_functions import clear_output
from matplotlib import pyplot as plt, cm

from matplotlib.colors import LogNorm, SymLogNorm, TwoSlopeNorm
from mpl_toolkits.axes_grid1 import make_axes_locatable

from extinction_functions import lorentzian, symmetric_mod, get_delta_trains_from_hex


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
        print("Warning: delta_train is empty, skipping 2D histogram plot.")
        return

    # detected_period_ns = 1 / 589.9801 * 1e6  # convert kHz to ns, use real theoretical value

    # adjust timing window if specified (defaults to zero to inf)
    delta_train = delta_train[(delta_train >= t_range[0]) & (delta_train <= t_range[1])]

    # Setup slicing parameters
    total_duration_ns = delta_train[-1] - delta_train[0]
    slice_duration_ns = total_duration_ns / n_slices
    num_slices = int(np.ceil(total_duration_ns / slice_duration_ns))

    # x-axis histogram bin edges (centered around ±detected_period/2)
    hist_range = (-detected_period_ns / 2, detected_period_ns / 2)
    bins = np.arange(hist_range[0], hist_range[1] + bin_width_ns, bin_width_ns)
    delta_slices = []
    all_histograms = []
    means = []

    # Create normalized deltas
    normalized_delta_train = symmetric_mod(delta_train, detected_period_ns)

    for i in range(num_slices):
        t_start = delta_train[0] + i * slice_duration_ns
        t_end = t_start + slice_duration_ns
        mask = (delta_train >= t_start) & (delta_train < t_end)
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

    # Plot as 2D histogram
    for color in colors:
        if fig_ax is None:
            fig, ax = plt.subplots(figsize=figsize)
        else:
            fig_ax: tuple[plt.Figure, plt.Axes]
            fig, ax = fig_ax
        extent = [bins[0], bins[-1], delta_train[0] / 1e6, delta_train[-1] / 1e6]  # [x_min, x_max, y_min, y_max]
        aspect = 'auto'

        # noinspection PyTypeChecker
        im = ax.imshow(all_histograms,  # +1e-3 to prevent log(0) errors
                       extent=extent, origin='lower', alpha=alpha,
                       interpolation='nearest', aspect=aspect, cmap=color,
                       norm=LogNorm(vmin=1, vmax=np.max(all_histograms)))

        divider = make_axes_locatable(ax)
        if subplot_no == 2:
            cax = divider.append_axes("right", size="3%", pad=0.05)
            fig.colorbar(im, cax=cax, label=None)
        else:
            cax = divider.append_axes("right", size="3%", pad=0.01)
            fig.colorbar(im, cax=cax, label='Counts (Log Scale)')

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
        box_text = (f"{len(delta_train)} points\n"
                    f"Detected Period: {detected_period_ns:.3f} ns\n"
                    f"In/Out Particles: {in_time_counts}/{out_of_time_counts}\n"
                    f"Extinction Ratio: {extinction_ratio:.2e}")
        if total == in_time_counts:
            box_text += "\n(Add 1 OOT particle for calc.)"
        if textbox:
            ax.text(0.95, 0.95, box_text, transform=ax.transAxes, fontsize=10,
                    verticalalignment='top', horizontalalignment='right', bbox=dict(facecolor='white', alpha=0.8))
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

        # if subplot_no == 1:
        #     # don't show x-ticks
        #     ax.set_xticks([])

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


def plot_1d_histogram(data_lists: list[np.ndarray], sample_period: float = 0,
                      common_title_text: str = "", include_sample_peaks=False, title: Optional[str] = None,
                      units: Optional[str] = None,   # 'ns' or 'ms'
                      **kwargs):
    """Plot a 1D histogram of multiple data lists."""
    hist_range: Optional[tuple] = kwargs.pop("hist_range", None)
    log: Optional[bool] = kwargs.pop("log", None)
    loc: Optional[str] = kwargs.pop("loc", None)
    alpha: Optional[float] = kwargs.pop("alpha", 0.5)
    bin_size_ns: Optional[int] = kwargs.pop("bin_size_ns", None)  # default bin size in ms
    fig_size: tuple[int, int] = kwargs.pop("fig_size", (10, 6))  # default figure width in inches
    legend: bool = kwargs.pop("legend", True)
    file_name: str = kwargs.pop("file_name", "histogram_plot.svg")
    sample_offset: int = kwargs.pop("sample_offset", 0)  # offset for sample peaks

    fig, ax = plt.subplots(figsize=fig_size)

    # check for empty data lists
    for i, l in enumerate(data_lists):
        if not l.any():
            print(f"Warning: Data list #{i + 1} is empty, skipping histogram plot.")
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
            data = np.clip(data, 1e-3, None)

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
        ax.set_yscale('symlog', linthresh=150)
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
                              title: str = None):
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
        counts, bins = np.histogram(train, bins=100, range=(min_x, max_x))
        if normalized:
            counts = counts / counts.max()  # normalize amplitude
        bin_centers = (bins[:-1] + bins[1:]) / 2
        ax.hist(bin_centers, bins=100, weights=counts,
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

    if log:
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


if __name__ == "__main__":
    print("don't run this file")