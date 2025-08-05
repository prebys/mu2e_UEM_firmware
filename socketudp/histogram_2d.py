import numpy as np
from matplotlib import pyplot as plt

from matplotlib.colors import LogNorm
from mpl_toolkits.axes_grid1 import make_axes_locatable


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


def plot_2d_histogram_delta_train(delta_train, detected_period_ns, common_title_text: str, colors: list[str],
                                  bin_width_ns: int = 10, n_slices: int = 20,
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
    # detected_period_ns = 1 / 589.9801 * 1e6  # convert kHz to ns, use real theoretical value

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
        all_histograms.append(counts)

    all_histograms = np.array(all_histograms)

    # Plot as 2D histogram
    for color in colors:
        fig, ax = plt.subplots(figsize=(8, 6))
        extent = [bins[0], bins[-1], delta_train[0] / 1e6, delta_train[-1] / 1e6]  # [x_min, x_max, y_min, y_max]
        aspect = 'auto'

        # noinspection PyTypeChecker
        im = ax.imshow(all_histograms + 1,  # +1 to prevent log(0) errors
                       extent=extent, origin='lower',
                       interpolation='nearest', aspect=aspect, cmap=color,
                       norm=LogNorm(vmin=1, vmax=np.max(all_histograms)))

        ax.set_xlabel("Modulo Time (ns)")
        ax.set_ylabel("Time (ms)")
        ax.set_title(f"{common_title_text}")

        divider = make_axes_locatable(ax)
        cax = divider.append_axes("right", size="3%", pad=0.05)
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
        num_points = len(delta_train)
        box_text = (f"{len(delta_train)} points\n"
                    f"Detected Period: {detected_period_ns:.3f} ns\n"
                    f"In/Out Particles: {in_time_counts}/{out_of_time_counts}\n"
                    f"Extinction Ratio: {extinction_ratio:.2e}")
        if total == in_time_counts:
            box_text += "\n(Add 1 OOT particle for calc.)"
        ax.text(0.95, 0.95, box_text, transform=ax.transAxes, fontsize=10,
                verticalalignment='top', horizontalalignment='right', bbox=dict(facecolor='white', alpha=0.8))

        # Add thin red vertical lines at +/- 125 ns
        if color == 'inferno':
            linecolor = 'red'
        elif color == 'Blues':
            linecolor = 'blue'
        else:
            linecolor = 'red'
        ax.axvline(-125, color=linecolor, linestyle='--', linewidth=1.5)
        ax.axvline(125, color=linecolor, linestyle='--', linewidth=1.5)

        plt.tight_layout(rect=(0, 0, 1, 1))

        plt.show()


if __name__ == "__main__":
    # Example usage
    start = 59e5 - 59e5 % 1695
    finish = 201e5
    period = 1695  # Example detected period in ns
    delta_train = np.arange(start, finish, 1695)
    delta_train += np.random.normal(0, 15, len(delta_train)).astype(int)  # Simulated delta train errors
    common_title_text = "Example Delta Train Histogram"

    plot_2d_histogram_delta_train(delta_train, period, common_title_text, colors=['inferno'])