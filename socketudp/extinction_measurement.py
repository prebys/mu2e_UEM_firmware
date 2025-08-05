import re

import numpy as np
from matplotlib import pyplot as plt
from scipy.optimize import curve_fit
from scipy.stats import norm

from hex_check import hex_check
from histogram_2d import plot_2d_histogram_delta_train

last_event = hex_check.event_buffer[-1]
print(f"# Events / Subevents: {last_event.internal_event_number} / {last_event.sub_event_number}")

periods = []
frequencies = []
delta_trains = []
normalized_delta_trains = []
delta_histograms = []

# all times in this file are in nanoseconds unless otherwise specified
signal_period = 1 / 589.9801  # ns, the nominal period of the signal, 1694.97242 ns
sample_rate = 4  # ns, the sampling rate of the signal (4 ns per sample)

use = "real_data"  # "real_data" or "simulated_data"
# FOR SIMULATED DATA
length_ms = 30
length_ns: int = int(length_ms * 1e6)  # ns, total time for the delta train
# arrival_jitter derived based on requirement for ~99.99893% of protons within ±125 ns
arrival_jitter_ns = 27.14
particle_num_mean = 3
particle_num_width = 2
noise_num_mean = 0.1
noise_num_width = 0.15
phase_offset_deg = 0
gradual_phase_shift_speed_ns = 5  # ns, the speed of the gradual phase shift in the signal

# OTHER SETTINGS
desired_f_resolution = 0.01  # kHz, desired frequency resolution for the FFT
# zero_padding_ratio = 7
common_title_text = ""  # leave unfilled, is set at beginning of main()


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


def correct_period(_deltas, _normalized_deltas, period, focus_middle=False):
    # first, if there's an error in detected_period, there will be a drift in the mean value after modulo
    # get the mean value of the first and last 5% of the normalized delta_train
    if focus_middle:
        _normalized_deltas = _normalized_deltas[np.abs(_normalized_deltas) < 150]
    five_percent = int(len(_normalized_deltas) * 0.05)
    starting_mean = np.mean(_normalized_deltas[:five_percent])
    ending_mean = np.mean(_normalized_deltas[-five_percent:])
    n_cycles = length_ns / period  # number of cycles in the delta train (with the period error, but should be fine)
    error = (ending_mean - starting_mean) / n_cycles
    print(f"Starting mean: {starting_mean:.2f} ns, Ending mean: {ending_mean:.2f} ns, "
          f"Error: {error:.3f} ns, Old Period: {period:.3f} ns, "
          f"New Period: {period + error:.3f} ns")
    return period + error, symmetric_mod(_deltas, period + error)


def subtract_mean(_deltas, _normalized_deltas, period, focus_middle=False):
    _normalized_deltas_window = _normalized_deltas
    if focus_middle:
        _normalized_deltas_window = _normalized_deltas[np.abs(_normalized_deltas) < 150]
    correction = int(np.mean(_normalized_deltas_window))
    _deltas -= correction
    _normalized_deltas -= correction
    _normalized_deltas = symmetric_mod(_normalized_deltas, period)
    return _deltas, _normalized_deltas


def create_delta_train():
        """
        Create a delta train with a given length, creation probability, and duplication probability.

        Length and all other times are in nanoseconds. Nominally the delta train will have deltas every
        1695 ns, +/- a jitter of "arrival_jitter_ns".

        - creation_prob: Probability of creating a delta at 1695 ns stop.
        - arrival_jitter_ns: The jitter in nanoseconds for the arrival of each delta.
        - particle_num_mean: The mean number of particles per delta (gaussian)
        - particle_num_width: The width for a gaussian distribution of particle numbers. Round the
            particle number to the nearest integer to determine number of particles in each delta.
            Each particle will come at a different time according to the jitter.
        - length_ns: The total length of the delta train in nanoseconds.
        """
        _delta_train = []
        time = signal_period - (phase_offset_deg / 360) * signal_period  # start at the first delta time
        phase_shift = 0
        while time < length_ns:
            # Create a delta at the current time
            particle_num = round(np.random.normal(particle_num_mean, particle_num_width))
            if particle_num < 0:
                particle_num = 0
            for _ in range(particle_num):
                jitter = np.random.normal(0, arrival_jitter_ns)

                # add a phase shift that is windowed to have the biggest effect in the center
                # of the length_ns data run
                mu = length_ns / 2
                centered_phase_shift = 0.01 * (
                        norm.pdf(time, loc=mu, scale=mu / 4) / norm.pdf(mu, loc=mu, scale=mu / 4)
                )
                phase_shift += centered_phase_shift
                signal_time = time + jitter + phase_shift
                # assume 4ns sampling time, so we round to the nearest 4ns
                signal_time = round(signal_time / sample_rate) * sample_rate
                _delta_train.append(signal_time)

            # Add noise events with a probability of noise_probability
            if np.random.rand() < round(np.random.normal(noise_num_mean, noise_num_width)):
                noise_time = time + np.random.randint(0, signal_period)
                # assume 4ns sampling time, so we round to the nearest 4ns
                _delta_train.append(round(noise_time / sample_rate) * sample_rate)

            # Move to the next delta time
            time += signal_period

        return np.array(sorted(_delta_train))


def main(channel: int, three_fold: bool = False):
    """

    :param channel: Which channel number to use
    :param three_fold: Whether to limit data events to three-fold coincidence events only
    :return:
    """
    global signal_period
    global length_ns
    global common_title_text
    if use == 'real_data':
        common_title_text = f"{hex_check.file_name} - Channel {channel}"
    else:
        common_title_text = f"Simulated Delta Train (length: {length_ms} ms, "
        common_title_text += f"signal period: {signal_period} ns, sample rate: {sample_rate} ns)"

    # #######################################################
    # Parameter Setup
    # #######################################################

    if use == "real_data":
        peak_height_dataframe = hex_check.peak_height_dataframe
        delta_train = peak_height_dataframe[peak_height_dataframe['channel_number'] == channel].time_ns.values
        delta_train = np.sort(delta_train)
        fft_time_range_ns = (delta_train[0], delta_train[-1])
        # fft_time_range_ns = (29e6, delta_train[-1])

        # mask time window
        time_mask = (fft_time_range_ns[0] <= delta_train) & (delta_train <= fft_time_range_ns[1])
        # time_mask = (0 <= delta_train) & (delta_train <= 5e6)
        delta_train = delta_train[time_mask]  # filter to only include events in this time range
        common_title_text += (f"\nTime Range: {delta_train[0] * 1e-6:.2f} "
                              f"to {delta_train[-1] * 1e-6:.2f} ms")

        print(f"Using real data from channel {channel} with {len(delta_train)} events.")
    elif use == "simulated_data":
        delta_train = create_delta_train()
        fft_time_range_ns = (delta_train[0], delta_train[-1])  # default to full range
    else:
        raise ValueError("Invalid use case. Use 'real_data' or 'simulated_data'.")

    # 4 ns sample rate
    # total_time = 1695 * 501 ns = 849,195 ns = 0.849195 ms
    # fs = 1 / (4e-9) = 250 MHz
    # fn = fs / 2 = 125 MHz
    print(f"Sampling rate (fs): {1 / sample_rate * 1e6} MHz ({sample_rate} ns)")
    print(f"Nyquist frequency (fn): {1 / (2 * sample_rate) * 1e6} MHz ({2 * sample_rate} ns)")
    length_ns = int(delta_train[-1] - delta_train[0])  # total time in ns
    print(f"Total time: {length_ns * 1e-6} ms")
    # to calc. minimum allowed sampling frequency, use Nyquist theorem:
    # know we want to measure 1 / 1695 ns = 590.5 kHz, so we need at least 2 * 590.5 kHz = 1.181 MHz
    # corresponds to a sampling time of 1 / 1.181 MHz = 846.5 ns
    # anything outside of that will be aliased
    theoretical_peak_width: float = 1 / length_ns * 1e6  # kHz, theoretical peak width in kHz
    print(f"Expected theoretical peak width: {theoretical_peak_width:.4f} kHz")

    # start creating bins
    n_bins = int(np.round((fft_time_range_ns[1] - fft_time_range_ns[0]) / sample_rate)) + 1
    t = np.arange(n_bins) * sample_rate + fft_time_range_ns[0]  # time bins in ns, starting at first absolute time

    bin_counts = np.zeros(len(t)).astype(int)  # initialize bin counts
    zero_start_delta_train = delta_train - t[0]  # zero start time
    bin_indices = np.round(zero_start_delta_train / sample_rate).astype(int)  # bin indices for each delta
    # add counts to the corresponding bins
    bin_counts[bin_indices] += 1
    delta_histograms.append((t, bin_counts))

    # calculate zero_padding ratio based on desired frequncy resolution
    zero_padding_ratio: int = round(1e6 / length_ns / desired_f_resolution)  # zero padding ratio
    zero_padded_width = 1 / (length_ns * zero_padding_ratio) * 1e6
    print(f"Zero padding ratio: {zero_padding_ratio} (to achieve {zero_padded_width:.4f} kHz "
          f"interpolated resolution)")

    # #######################################################
    # FFT Calculation
    # #######################################################

    # optional, apply window if you wish
    # sometimes helps, sometimes doesn't
    # window = windows.hann(len(bin_counts))
    # bin_counts *= window  # Apply a Hann window to the signal

    # Take the FFT
    amp_exponent = 1  # exponent for amplitude, can be 1 for amplitude or 2 for power spectrum
    fft_result = 1 / len(t) * np.fft.fft(bin_counts, n=zero_padding_ratio * len(t))
    fft_abs = np.abs(fft_result) ** amp_exponent
    fft_freqs = np.fft.fftfreq(len(fft_result), d=sample_rate * 1e-6)  # convert to kHz
    df = fft_freqs[1] - fft_freqs[0]  # frequency resolution in kHz
    unpadded_df = 1 / (sample_rate * 1e-6) / len(bin_counts)

    # keep positive frequencies only
    fft_abs = fft_abs[:len(fft_abs) // 2]
    fft_freqs = fft_freqs[:len(fft_freqs) // 2]
    # mask out DC component (less than 1 kHz)
    fft_mask = fft_freqs >= 1
    fft_abs = fft_abs[fft_mask]
    fft_freqs = fft_freqs[fft_mask]

    # mini range from just above 589 kHz to just below 591 kHz
    expected_peak = 590
    f_range = (expected_peak - 8 * theoretical_peak_width,
               expected_peak + 8 * theoretical_peak_width)
    fft_mask = (f_range[0] <= fft_freqs) & (fft_freqs <= f_range[1])
    mini_fft_abs = fft_abs[fft_mask]
    mini_fft_freqs = fft_freqs[fft_mask]
    max_indices = np.argsort(mini_fft_abs)[::-1]  # Get indices of the top 10 max values

    # #######################################################
    # Plotting
    # #######################################################

    plt.figure(figsize=(10, 5))
    plt.bar(mini_fft_freqs, mini_fft_abs, width=df * 0.9, color='blue', label='FFT Amplitude')
    title = "FFT of Delta Train (zoom on first peak)"
    if amp_exponent == 2:
        title += " (Power Spectrum)"
    elif amp_exponent == 1:
        title += " (Amplitude Spectrum)"
    plt.title(title + f"\n{common_title_text}")

    plt.xlabel("Frequency (kHz)")
    plt.ylabel("Normalized Amplitude")
    plt.tight_layout()

    fit_func_label = ""

    def sinc(_f, A, f0, sigma, offset):
        nonlocal fit_func_label
        fit_func_label = "Sinc Fit"
        x = (_f - f0) / sigma
        val = A * np.abs(np.sinc(x)) + offset
        return val

    def lorentzian(_f, A, f0, sigma, offset):
        nonlocal fit_func_label
        fit_func_label = "Lorentzian Fit"
        return (1 / np.pi) * (A * sigma / 2) / ((_f - f0) ** 2 + (sigma / 2) ** 2) + offset

    def sinc_lorentzian(_f, f0, A_sinc, A_lor, sigma_lor, sigma_sinc):
        nonlocal fit_func_label
        fit_func_label = "Sinc-Lorentzian Fit"
        # return A * (
        #         alpha * np.abs(np.sinc((_f - f0) / sigma_lor)) +
        #         (1 - alpha) * (1 / np.pi) * (sigma_sinc / 2) / ((_f - f0)**2 + (sigma_sinc / 2)**2)
        #             ) + offset
        return (
                A_sinc * np.sinc((_f - f0) / sigma_sinc) +
                A_lor * (1 / np.pi) * (sigma_lor / 2) / ((_f - f0) ** 2 + (sigma_lor / 2) ** 2)
        )

    # print first ten max values of the FFT
    detected_mini_bin, detected_frequency, detected_period = None, None, None
    print(f"Top 10 FFT values:")
    for j, idx in enumerate(max_indices[:3]):
        idx: int
        fit_func = lorentzian
        fft_fit_window_mask = (np.abs(mini_fft_freqs - mini_fft_freqs[idx]) < theoretical_peak_width * 5)  # +/- 0.5 kHz
        freq_window = mini_fft_freqs[fft_fit_window_mask]
        amp_window = mini_fft_abs[fft_fit_window_mask]
        f = mini_fft_freqs[idx]
        amp = mini_fft_abs[idx]
        # p0 = [f,
        #       0.0001,  # A_sinc
        #       0.0007,       # A_lor
        #       0.3,  # sigma lor
        #       theoretical_peak_width,   # sigma sinc
        #       # 0  # offset
        #       ]  # Initial guess for Gaussian
        p0 = [amp, f, theoretical_peak_width, 0]
        # fit
        popt, pcov = curve_fit(fit_func, freq_window, amp_window, p0=p0, maxfev=10000)
        # f0_fit, A_sigma_fit, A_lor_fit, sigma_lor_fit, sigma_sinc_fit = popt
        A_fit, f0_fit, sigma_fit, offset_fit = popt
        # sigma_fit = np.sqrt(sigma_lor_fit**2 + sigma_sinc_fit**2)
        # A_fit = A_sigma_fit + A_lor_fit
        sigma_T = sigma_fit / f0_fit ** 2 * 1e6
        # uncertainty on sigma_fit
        sigma_sigma_fit = np.sqrt(np.diag(pcov))[2]

        t = 1 / f0_fit * 1e6  # ns, looks like 1694.99 ns
        print(
            f"Frequency: {f0_fit:.3f} ± {sigma_fit:.3f} ± {sigma_sigma_fit:.3f} kHz, "
            f"Period: {t:.2f} ± {sigma_T:.2f} ns, Amplitude: {A_fit:.2e}")

        if j == 0:
            print(popt)
            plt.scatter(freq_window, amp_window, color='green', label='Fit Input Points', s=10)
            fit_t = np.arange(mini_fft_freqs[0], mini_fft_freqs[-1], 0.001)

            plt.plot(fit_t, fit_func(fit_t, *popt),
                     color='red', alpha=0.7, label=fit_func_label)
            plt.legend()
            detected_mini_bin = idx
            detected_frequency = f0_fit
            detected_period = t

            # add box showing number of points, as well as frequency and period peak
            plt.text(0.05, 0.95, f"Counts: {len(mini_fft_freqs)}\n"
                                 f"Frequency: {f0_fit:.3f} kHz\n"
                                 f"Period: {t:.2f} ns", transform=plt.gca().transAxes,
                     fontsize=10, verticalalignment='top', bbox=dict(facecolor='white', alpha=0.5))

    plt.show()

    # print(f"Max detected in bin {detected_mini_bin}")
    print(f"Frequency in this bin: {mini_fft_freqs[detected_mini_bin]:.3f} kHz with df = {df:.3f}")
    print(f"Actual detected frequency: {detected_frequency:.3f} kHz, relative position in bin: "
          f"{(detected_frequency - mini_fft_freqs[detected_mini_bin]) / df:.3f} kHz")

    # #######################################################
    # ERROR CALCULATION
    # #######################################################

    # https://dsp.stackexchange.com/questions/78926/error-estimation-for-frequency
    # calcualte SNR-based error value
    # f_rms = 1.219 / sqrt(T^3 * S/N)
    # N is the single-sided noise density in W/Hz
    # S is the power in the sinusoidal tone in W
    # T is the duration of the captured signal in seconds.

    # estimate noise density
    # find bins around 300 kHz (far away from 0 Hz DC and 590 kHz signal)
    noise_bins = np.where((fft_freqs >= 200) & (fft_freqs <= 400))[0]
    # average noise power in these bins
    average_noise_power = np.mean(fft_abs[noise_bins] ** 2)
    noise_density = average_noise_power / (unpadded_df * 1e3)  # W/Hz, convert kHz-->Hz  # incorrect, I think
    # noise_density = average_noise_power  # changing zero padding does not change magnitude

    # get signal power: peak bin squared
    signal_power = np.abs(mini_fft_abs[detected_mini_bin]) ** 2
    print(f"Signal power: {signal_power:.3e} W, Average noise bin: {average_noise_power:.3e} W, "
          f"Noise density: {noise_density:.3e} W/Hz")
    print(f"SNR: {signal_power / noise_density:.2f} (T = {length_ms} ms, zero padding ratio = {zero_padding_ratio})")

    # calcualte f_rms
    f_rms = 1.219 / np.sqrt((length_ns * 1e-9) ** 3 * (signal_power / noise_density))  # Hz
    f_rms /= 1e3  # convert to kHz
    print(f"Estimated frequency: {detected_frequency:.3f} ± {f_rms:.3f} kHz (SNR-based error)")

    # propagate this unceratinty to period
    t_rms = f_rms / detected_frequency ** 2 * 1e6  # ns
    print(f"Estimated period: {detected_period:.2f} ± {t_rms:.2f} ns (SNR-based error)")

    # #######################################################
    # Pulse Centering
    # #######################################################

    # detected_period = signal_period  # ← ⚠️ THIS LINE IS CHEATING, ONLY USE FOR TESTING ⚠️



    # normalize delta train by detected period once, but we will slightly nudge it to make it better now
    normalized_delta_train = symmetric_mod(delta_train, detected_period)
    print(f"Delta train mean value: {np.mean(normalized_delta_train):.2f} ns")

    # calculate new period based on the shift of the mean value,
    # renormalize delta train with the new detected period
    new_detected_period, normalized_delta_train = correct_period(delta_train, normalized_delta_train, detected_period)

    # correct once by subtracting from the mean of the modulated delta train (it'll be offset from zero by some amnt.)
    delta_train, normalized_delta_train = subtract_mean(delta_train, normalized_delta_train, new_detected_period)

    # once the pulse is *mostly* centered,
    # now specifically center it by just the mean of the  middle 300 ns of points
    delta_train, normalized_delta_train = subtract_mean(delta_train, normalized_delta_train, new_detected_period,
                                                        focus_middle=True)

    # one last time, on this almost completely centered straight train,
    # correct for mean deviation using just the center 300 ns
    new_detected_period, normalized_delta_train = correct_period(delta_train, normalized_delta_train,
                                                                 new_detected_period,
                                                                 focus_middle=True)

    # just kidding, last time for real
    delta_train, normalized_delta_train = subtract_mean(delta_train, normalized_delta_train, new_detected_period,
                                                        focus_middle=True)
    new_detected_frequency = 1 / new_detected_period * 1e6  # convert to kHz

    # #######################################################
    # PLOT 2D HISTOGRAM
    # #######################################################
    plot_2d_histogram_delta_train(delta_train, new_detected_period, common_title_text=common_title_text,
                                  colors=['inferno', 'Blues'])

    # #######################################################
    # EXTINCTION MEASUREMENT
    # #######################################################

    # define +/- 125 ns window as "in-time", and everything else as "out-of-time"
    in_time_counts = np.sum(np.abs(normalized_delta_train) <= 125)
    out_of_time_counts = len(normalized_delta_train) - in_time_counts
    print(f"In-time counts: {in_time_counts}, Out-of-time counts: {out_of_time_counts}")
    extinction_ratio = out_of_time_counts / (in_time_counts + out_of_time_counts)
    print(f"Extinction ratio: {extinction_ratio:.3e} (out-of-time / total counts)")

    # add data to lists
    periods.append(new_detected_period)
    frequencies.append(new_detected_frequency)  # convert to kHz
    delta_trains.append(delta_train)
    normalized_delta_trains.append(normalized_delta_train)


main(1, three_fold=True)
print('\n\n\n')
main(2, three_fold=True)
print('\n\n\n')
main(3, three_fold=True)
n_plots = len(delta_trains)
colors = ['blue', 'orange', 'green']
common_title_text = re.sub(r' - Channel \d', '', common_title_text)  # remove channel number from title


def plot_delta_histogram(normalized=False):
    """Plot all three normalized delta trains together as histograms with normalized amplitudes"""
    fig1, ax1 = plt.subplots(1, 1, figsize=(10, 5))
    for j, _train in enumerate(normalized_delta_trains):
        counts, bins = np.histogram(_train, bins=100)
        if normalized:
            counts = counts / counts.max()  # normalize amplitude
        bin_centers = (bins[:-1] + bins[1:]) / 2
        ax1.hist(bin_centers, bins=100, weights=counts, color=colors[j], alpha=0.7, label=f'Channel {j + 1}')

    # Add labels, titles, and legends to the figures
    if normalized:
        ax1.set_xlabel("Normalized Time (ns)")
        ax1.set_ylabel("Normalized Amplitude")
        ax1.set_title("Normalized Delta Trains Histogram")
    else:
        ax1.set_xlabel("Time (ns)")
        ax1.set_ylabel("Counts")
        ax1.set_title("Delta Trains Histogram")
    ax1.legend()

    # add box showing counts per channel
    counts_per_channel = [len(_train) for _train in normalized_delta_trains]
    ax1.text(0.05, 0.95, f"Counts per channel: {counts_per_channel}", transform=ax1.transAxes,
             fontsize=10, verticalalignment='top', bbox=dict(facecolor='white', alpha=0.5))

    plt.show()


plot_delta_histogram(normalized=False)
# plot_delta_histogram(normalized=True)

fig2, ax2 = plt.subplots(n_plots, 1, figsize=(10, 10))  # , sharex='all', sharey='all')
if not isinstance(ax2, np.ndarray):
    # noinspection PyTypeChecker
    ax2: plt.Axes | list[plt.Axes] = [ax2]  # ensure ax2 is an array for consistent indexing

for i, train in enumerate(delta_trains):
    ax2[i].hist(train / 1e6, bins=100, color=colors[i], alpha=0.7, label=f'Channel {i + 1} ({len(train)} events)')

min_t = min([train.min() for train in delta_trains]) / 1e6  # convert to ms
max_t = max([train.max() for train in delta_trains]) / 1e6  # convert to ms

for i, train in enumerate(delta_trains):
    ax2[i].set_xlim(min_t, max_t)
    ax2[i].set_xlabel("Time (ms)")
    ax2[i].set_ylabel("Counts")
    ax2[i].set_title(f"Delta Train Histogram - Channel {i + 1}")
    ax2[i].legend()

fig2.tight_layout()
plt.show()

# ############################
# THREE FOLD COINCIDENCE
# ############################

# Parameters
coincidence_window_ns = 10  # events within this window are considered coincident

# Get the three channels
ch1 = delta_trains[0]
ch2 = delta_trains[1]
ch3 = delta_trains[2]

# Store coincidences as three lists of the ch1, ch2, ch3 times
three_fold_coincidences = []

for t1 in ch1:
    # example: t1 = 1000ns
    # search for (t1 - dt) and (t1 + dt) in ch2, so 990 ns and 1010 ns
    # if there are any events in that range, let's say for example 995 ns
    # then i2_lo will come below 995 and i2_hi will come above 995
    # so ch2[i2_lo:i2_hi] will give you the indices for the range of numbers between 990 - 1010
    # Find indices in ch2 within the coincidence window of t1
    i2_lo = np.searchsorted(ch2, t1 - coincidence_window_ns, side='left')
    i2_hi = np.searchsorted(ch2, t1 + coincidence_window_ns, side='right')
    possible_t2s = ch2[i2_lo:i2_hi]

    for t2 in possible_t2s:
        # For each t2 in window of t1, check ch3
        t_center = (t1 + t2) // 2  # optional: center the time
        i3_lo = np.searchsorted(ch3, t_center - coincidence_window_ns, side='left')
        i3_hi = np.searchsorted(ch3, t_center + coincidence_window_ns, side='right')
        possible_t3s = ch3[i3_lo:i3_hi]

        for t3 in possible_t3s:
            if (
                abs(t1 - t3) <= coincidence_window_ns and
                abs(t2 - t3) <= coincidence_window_ns
            ):
                three_fold_coincidences.append((t1, t2, t3))

average_points = np.array([np.mean(i) for i in three_fold_coincidences]).astype(int)
three_fold_title = re.sub(r"\nTime Range: .*? ms","", common_title_text)

# average points is now a simple list of timestamps, plot on a histogram
plt.figure(figsize=(10, 5))
plt.hist(average_points / 1e6, bins=100, color='purple', alpha=0.7)
plt.xlabel("Time (ms)")
plt.ylabel("Counts")
plt.title("Three-Fold Coincidence Histogram")
plt.tight_layout()
plt.show()

# plot 2d histogram of this as well
plot_2d_histogram_delta_train(average_points, np.mean(periods),
                              common_title_text="(Three-Fold Coincidence Events)\n" + three_fold_title,
                              colors=['inferno', 'Blues'])

normalized_three_fold = symmetric_mod(average_points, np.mean(periods))


print()