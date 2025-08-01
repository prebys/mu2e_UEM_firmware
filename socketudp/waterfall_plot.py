import numpy as np
from matplotlib import pyplot as plt

from matplotlib.colors import LogNorm


def symmetric_mod(x, mod):
    """
    Symmetric modulo operation that returns values in the range [-mod/2, mod/2).
    Examples:
        18 %% 5 -> -2
        19 %% 5 -> -1
        20 %% 5 -> 0
        21 %% 5 -> 1
        22 %% 5 -> 2
    """
    return np.round(((x + mod / 2) % mod) - (mod / 2)).astype(int)


def plot_waterfall_delta_train(delta_trains, periods, channel_index: int, bin_width_ns: int = 10,
                               slice_duration_ms: int = 1):
    """
    Create a waterfall plot of delta train histograms over time.

    Parameters:
    - channel_index: 0-based index into delta_trains[]
    - bin_width_ns: width of each histogram bin (x-axis resolution)
    - slice_duration_ms: time window per slice (y-axis resolution), in ms
    """
    delta_train = delta_trains[channel_index]
    detected_period_ns = periods[channel_index]

    # Setup slicing parameters
    slice_duration_ns = slice_duration_ms * 1e6
    total_duration_ns = delta_train[-1] - delta_train[0]
    num_slices = int(np.ceil(total_duration_ns / slice_duration_ns))

    # x-axis histogram bin edges (centered around ±detected_period/2)
    hist_range = (-detected_period_ns / 2, detected_period_ns / 2)
    bins = np.arange(hist_range[0], hist_range[1] + bin_width_ns, bin_width_ns)
    all_histograms = []

    # Create normalized deltas
    normalized_delta_train = symmetric_mod(delta_train, detected_period_ns)

    for i in range(num_slices):
        t_start = delta_train[0] + i * slice_duration_ns
        t_end = t_start + slice_duration_ns
        mask = (delta_train >= t_start) & (delta_train < t_end)
        slice_deltas = normalized_delta_train[mask]

        counts, _ = np.histogram(slice_deltas, bins=bins)
        all_histograms.append(counts)

    all_histograms = np.array(all_histograms)

    # Plot as waterfall
    fig, ax = plt.subplots(figsize=(12, 6))
    extent = [bins[0], bins[-1], 0, num_slices]  # [x_min, x_max, y_min, y_max]
    aspect = 'auto'

    # noinspection PyTypeChecker
    im = ax.imshow(all_histograms + 1,  # +1 to prevent log(0) errors
                   extent=extent, origin='lower',
                   interpolation='nearest', aspect=aspect, cmap='viridis',
                   norm=LogNorm(vmin=1, vmax=np.max(all_histograms)))

    ax.set_xlabel("Normalized Time (ns)")
    ax.set_ylabel("Slice (ms)")
    ax.set_title(f"Waterfall Histogram - Channel {channel_index + 1}")
    fig.colorbar(im, ax=ax, label='Counts (Log Scale)')

    plt.tight_layout()
    plt.show()