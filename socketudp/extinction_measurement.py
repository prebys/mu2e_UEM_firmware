import numpy as np
from matplotlib import pyplot as plt
from scipy.optimize import curve_fit
from scipy.signal import windows, correlate
from scipy.stats import linregress, norm

from hex_check import hex_check
from waterfall_plot import plot_waterfall_delta_train

periods = []
frequencies = []
delta_trains = []
normalized_delta_trains = []
delta_histograms = []

# all times in this file are in nanoseconds unless otherwise specified
signal_period = 1695  # ns, the nominal period of the signal
sample_rate = 4  # ns, the sampling rate of the signal (4 ns per sample)

use = "simulated_data"  # "real_data" or "simulated_data"
# FOR SIMULATED DATA
length_ms = 10
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
desired_f_resolution = 0.04  # kHz, desired frequency resolution for the FFT
# zero_padding_ratio = 7


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


def main(channel: int):
    global signal_period
    global length_ns
    if use == 'real_data':
        common_title_text = f"{hex_check.file_name} - Channel {channel}"
    else:
        common_title_text = f"Simulated Delta Train (length: {length_ms} ms, "
        common_title_text += f"signal period: {signal_period} ns, sample rate: {sample_rate} ns)"


    
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
                centered_phase_shift = 60 * norm.pdf(time, loc=length_ns / 2, scale=length_ns / 2)
                signal_time = time + jitter + phase_shift + centered_phase_shift
                # assume 4ns sampling time, so we round to the nearest 4ns
                signal_time = round(signal_time / sample_rate) * sample_rate
                _delta_train.append(signal_time)
                print(f"Adding delta at {signal_time} ns (jitter: {jitter:.2f} ns, "
                      f"phase shift: {phase_shift:.2f} ns, anomalous shift: {centered_phase_shift:.2f} ns)")

            # Add noise events with a probability of noise_probability
            if np.random.rand() < round(np.random.normal(noise_num_mean, noise_num_width)):
                noise_time = time + np.random.randint(0, signal_period)
                # assume 4ns sampling time, so we round to the nearest 4ns
                _delta_train.append(round(noise_time / sample_rate) * sample_rate)

            # Move to the next delta time
            time += signal_period

        return np.array(sorted(_delta_train))
        
    if use == "real_data":
        peak_height_dataframe = hex_check.peak_height_dataframe
        delta_train = peak_height_dataframe[peak_height_dataframe['channel_number'] == channel].time_ns.values
        delta_train = np.sort(delta_train)
        fft_time_range_ns = (delta_train[0], delta_train[-1])

        # mask time window
        time_mask = (fft_time_range_ns[0] <= delta_train) & (delta_train <= fft_time_range_ns[1])
        # time_mask = (0 <= delta_train) & (delta_train <= 5e6)
        delta_train = delta_train[time_mask]  # filter to only include events in this time range

        print(f"Using real data from channel {channel} with {len(delta_train)} events.")
    elif use == "simulated_data":
        delta_train = create_delta_train()
        fft_time_range_ns = (delta_train[0], delta_train[-1])  # default to full range
        channel = None
    else:
        raise ValueError("Invalid use case. Use 'real_data' or 'simulated_data'.")
    
    # take fft
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
    t = np.arange(fft_time_range_ns[0], fft_time_range_ns[1] + sample_rate, sample_rate)  # time bins in ns
    zero_padding_ratio: int = round(1e6 / length_ns / desired_f_resolution)  # zero padding ratio
    zero_padded_width = 1 / (length_ns * zero_padding_ratio) * 1e6
    print(f"Zero padding ratio: {zero_padding_ratio} (to achieve {zero_padded_width:.4f} kHz "
          f"interpolated resolution)")

    bin_counts = np.zeros(len(t)).astype(int)  # initialize bin counts
    zero_start_delta_train = delta_train - t[0]  # zero start time
    bin_indices = np.round(zero_start_delta_train / sample_rate).astype(int)  # bin indices for each delta
    # add counts to the corresponding bins
    bin_counts[bin_indices] += 1
    delta_histograms.append((t, bin_counts))
    
    # plt.hist(t, bins=t, weights=bin_counts, alpha=0.5, label='Delta Train Histogram',
    #          width=sample_rate*5)
    # plt.show()
    
    # fft
    # window = windows.hann(len(bin_counts))
    # bin_counts *= window  # Apply a Hann window to the signal
    fft_result = 1 / len(t) * np.fft.fft(bin_counts, n=zero_padding_ratio*len(t))
    amp_exponent = 1  # exponent for amplitude, can be 1 for amplitude or 2 for power spectrum
    fft_abs = np.abs(fft_result)**amp_exponent
    fft_freqs = np.fft.fftfreq(len(fft_result), d=sample_rate * 1e-6)  # convert to kHz
    df = fft_freqs[1] - fft_freqs[0]  # frequency resolution in kHz
    unpadded_fft_freqs = np.fft.fftfreq(len(bin_counts), d=sample_rate * 1e-6)  # unpadded frequency bins in kHz
    unpadded_df = unpadded_fft_freqs[1] - unpadded_fft_freqs[0]
    
    # keep positive frequencies only
    fft_result = fft_result[:len(fft_result)//2]
    fft_abs = fft_abs[:len(fft_abs)//2]
    fft_freqs = fft_freqs[:len(fft_freqs)//2]
    # mask out DC component (less than 1 kHz)
    fft_mask = fft_freqs >= 1
    fft_result = fft_result[fft_mask]
    fft_abs = fft_abs[fft_mask]
    fft_freqs = fft_freqs[fft_mask]
    
    # mini range from just above 589 kHz to just below 591 kHz
    expected_peak = 590
    f_range = (expected_peak - 8*theoretical_peak_width,
               expected_peak + 8*theoretical_peak_width)
    fft_mask = (f_range[0] <= fft_freqs) & (fft_freqs <= f_range[1])
    mini_fft_result = fft_result[fft_mask]
    mini_fft_abs = fft_abs[fft_mask]
    mini_fft_freqs = fft_freqs[fft_mask]
    
    # angles
    max_indices = np.argsort(mini_fft_abs)[::-1]  # Get indices of the top 10 max values
    mini_fft_angles = np.angle(mini_fft_result, deg=False)
    angle_mask = mini_fft_abs > mini_fft_abs[max_indices[3]]
    mini_fft_angles = mini_fft_angles[angle_mask]  # set everything outside of top 10 amplitudes to NaN
    mini_fft_angles = np.unwrap(mini_fft_angles)
    mini_fft_angle_freqs = mini_fft_freqs[angle_mask]
    
    # #######################################################
    #
    # #######################################################
    
    # # plot fft result
    # plt.figure(figsize=(10, 5))
    # plt.xlim(0, 2500)
    # plt.plot(fft_freqs, fft_abs, color='blue', label='FFT Amplitude')
    # plt.title(f"FFT of Delta Train\n{common_title_text}")
    
    plt.figure(figsize=(10, 5))
    plt.bar(mini_fft_freqs, mini_fft_abs, width=df*0.9, color='blue', label='FFT Amplitude')
    title = "FFT of Delta Train (zoom on first peak)"
    if amp_exponent == 2:
        title += " (Power Spectrum)"
    elif amp_exponent == 1:
        title += " (Amplitude Spectrum)"
    plt.title(title + f"\n{common_title_text}")
    
    fit_func_label = ""
    
    # define gaussian
    def gaussian_maker(offset=0):
        nonlocal fit_func_label
        fit_func_label = "Gaussian Fit"
        def gaussian(_f, A, f0, sigma):
            return A * np.exp(-(_f - f0)**2 / (2 * sigma**2)) + offset
        return gaussian
    
    
    def sinc(_f, A, f0, sigma, offset):
        nonlocal fit_func_label
        fit_func_label = "Sinc Fit"
        x = (_f - f0) / sigma
        val = A * np.abs(np.sinc(x)) + offset
        return val
    
    def sinc2(_f, A, f0, sigma, offset):
        nonlocal fit_func_label
        fit_func_label = "Sinc^2 Fit"
        x = (_f - f0) / sigma
        val = A * np.sinc(x)**2 + offset
        return val
    
    def lorentzian(_f, A, f0, sigma, offset):
        nonlocal fit_func_label
        fit_func_label = "Lorentzian Fit"
        return (1 / np.pi) * (A * sigma / 2) / ((_f - f0)**2 + (sigma / 2)**2) + offset

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
    for i, idx in enumerate(max_indices[:3]):
        idx: int
        # average_noise_level = np.mean(mini_fft_abs[idx - 10000 : idx - 1000])
        # fit_func = gaussian_maker(average_noise_level)
        fit_func = lorentzian
        fft_fit_window_mask = (np.abs(mini_fft_freqs - mini_fft_freqs[idx]) < theoretical_peak_width*5)  # +/- 0.5 kHz
        freq_window = mini_fft_freqs[fft_fit_window_mask]
        amp_window = mini_fft_abs[fft_fit_window_mask]
        f = mini_fft_freqs[idx]
        amp = mini_fft_abs[idx]
        phase = mini_fft_result[idx]
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
        
        t = 1/f0_fit * 1e6  # ns, looks like 1694.99 ns
        print(f"Frequency: {f0_fit:.3f} ± {sigma_fit:.3f} ± {sigma_sigma_fit:.3f} kHz, Period: {t:.2f} ± {sigma_T:.2f} ns, Amplitude: {A_fit:.2e}")
        
        if i == 0:
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
    
    # # plot angles
    # plt.figure(figsize=(10, 5))
    # plt.scatter(mini_fft_angle_freqs, mini_fft_angles, 5, color='orange', label='Phase Angles')
    # plt.title(f"Phase Angles of FFT Result\n{common_title_text}")
    # plt.xlabel("Frequency (kHz)")
    # plt.ylabel("Phase Angle (radians)")
    # plt.legend()
    # plt.show()
    
    # get freq vs phase angles for linear regression fit
    # fit a linear function to the phase angles
    # do linear interpolation
    slope, intercept, r, p, se = linregress(mini_fft_angle_freqs, np.rad2deg(mini_fft_angles))
    # calculate phase at interpolated frequency
    interp_phase_linear_deg = slope * detected_frequency + intercept
    while interp_phase_linear_deg < -180:
        interp_phase_linear_deg += 360
    print(f"Interpolated phase (linear): {interp_phase_linear_deg:.2f} ± {se:.2f} degrees")
    
    
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
    average_noise_power = np.mean(fft_abs[noise_bins]**2)
    noise_density = average_noise_power / (unpadded_df * 1e3)  # W/Hz, convert kHz-->Hz  # incorrect, I think
    # noise_density = average_noise_power  # changing zero padding does not change magnitude
    
    # get signal power: peak bin squared
    signal_power = np.abs(mini_fft_abs[detected_mini_bin])**2
    print(f"Signal power: {signal_power:.3e} W, Average noise bin: {average_noise_power:.3e} W, "
          f"Noise density: {noise_density:.3e} W/Hz")
    print(f"SNR: {signal_power / noise_density:.2f} (T = {length_ms} ms, zero padding ratio = {zero_padding_ratio})")
    
    # calcualte f_rms
    f_rms = 1.219 / np.sqrt((length_ns * 1e-9)**3 * (signal_power / noise_density))  # Hz
    f_rms /= 1e3  # convert to kHz
    print(f"Estimated frequency: {detected_frequency:.3f} ± {f_rms:.3f} kHz (SNR-based error)")
    
    # propagate this unceratinty to period
    t_rms = f_rms / detected_frequency**2 * 1e6  # ns
    print(f"Estimated period: {detected_period:.2f} ± {t_rms:.2f} ns (SNR-based error)")
    # propagate both slope error (se) and frequency uncertainty (f_rms) into angle error
    slope_term = se                       # uncertainty in phase slope calculation assuming correct f_0
    freq_term = slope * f_rms             # from uncertainty in frequency
    angle_rms_total = np.sqrt(slope_term**2 + freq_term**2)
    phase_ns = (interp_phase_linear_deg / 360) * detected_period  # convert phase to ns
    angle_rms_ns = (angle_rms_total / 360) * detected_period  # convert angle uncertainty to ns
    print(f"Interpolated phase: {interp_phase_linear_deg:.2f} ± {angle_rms_total:.2f} degrees "
          f"(1σ total)")
    print(f"Interpolated phase (ns): {phase_ns:.2f} ± {angle_rms_ns:.2f} ns (1σ total)")
    # #######################################################
    # EXTINCTION MEASUREMENT
    # #######################################################
    
    # shift delta_train by phase shift interp_phase_linear_deg
    # a positive phase shift means the signal is delayed, so we add the phase shift
    # shifted_delta_train = delta_train + (interp_phase_linear_deg / 360) * detected_period
    # normalize the delta train to the detected period
    normalized_delta_train = symmetric_mod(delta_train, detected_period)
    print(f"Delta train mean value: {np.mean(normalized_delta_train):.2f} ns")
    normalized_delta_train -= int(np.mean(normalized_delta_train))
    mid_300_deltas = normalized_delta_train[np.abs(normalized_delta_train) < 150]
    normalized_delta_train -= int(np.mean(mid_300_deltas))  # center the delta train around 0 ns
    normalized_delta_train = symmetric_mod(normalized_delta_train, detected_period)
    
    # define +/- 125 ns window as "in-time", and everything else as "out-of-time"
    in_time_counts = np.sum(np.abs(normalized_delta_train) <= 125)
    out_of_time_counts = len(normalized_delta_train) - in_time_counts
    print(f"In-time counts: {in_time_counts}, Out-of-time counts: {out_of_time_counts}")
    extinction_ratio = out_of_time_counts / (in_time_counts + out_of_time_counts)
    print(f"Extinction ratio: {extinction_ratio:.3e} (out-of-time / total counts)")
    
    # add data to lists
    periods.append(detected_period)
    frequencies.append(detected_frequency)
    delta_trains.append(delta_train)
    normalized_delta_trains.append(normalized_delta_train)


main(1)
print('\n\n\n')
main(2)
print('\n\n\n')
main(3)
n_plots = len(delta_trains)

colors = ['blue', 'orange', 'green']
def plot_delta_histogram(normalized=False):
    """Plot all three normalized delta trains together as histograms with normalized amplitudes"""
    fig1, ax1 = plt.subplots(1, 1, figsize=(10, 5))
    for i, train in enumerate(normalized_delta_trains):
        counts, bins = np.histogram(train, bins=100)
        if normalized:
            counts = counts / counts.max()  # normalize amplitude
        bin_centers = (bins[:-1] + bins[1:]) / 2
        ax1.hist(bin_centers, bins=100, weights=counts, color=colors[i], alpha=0.7, label=f'Channel {i+1}')

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
    counts_per_channel = [len(train) for train in normalized_delta_trains]
    ax1.text(0.05, 0.95, f"Counts per channel: {counts_per_channel}", transform=ax1.transAxes,
                fontsize=10, verticalalignment='top', bbox=dict(facecolor='white', alpha=0.5))

    plt.show()


plot_delta_histogram(normalized=False)
plot_delta_histogram(normalized=True)

fig2, ax2 = plt.subplots(n_plots, 1, figsize=(10, 10))  # , sharex='all', sharey='all')

for i, train in enumerate(delta_trains):
    ax2[i].hist(train / 1e6, bins=100, color=colors[i], alpha=0.7, label=f'Channel {i + 1} ({len(train)} events)')

min_t = min([train.min() for train in delta_trains]) / 1e6  # convert to ms
max_t = max([train.max() for train in delta_trains]) / 1e6  # convert to ms

for i, train in enumerate(delta_trains):
    ax2[i].set_xlim(min_t, max_t)
    ax2[i].set_xlabel("Time (ms)")
    ax2[i].set_ylabel("Counts")
    ax2[i].set_title(f"Delta Train Histogram - Channel {i+1}")
    ax2[i].legend()

fig2.tight_layout()
plt.show()

# CROSS-CORRELATION
offset_matrix = np.zeros((n_plots, n_plots), dtype=object)
correlation_matrix = np.zeros((n_plots, n_plots))

for i in range(n_plots):
    for j in range(n_plots):
        x = delta_histograms[i][1]
        y = delta_histograms[j][1]
        corr = correlate(y, x, mode='full')  # j rel to i
        lags = np.arange(-len(x) + 1, len(y))
        max_corr = np.max(corr)
        max_lags = lags[corr == max_corr]
        # lag = lags[np.argmax(corr)]
        offsets = symmetric_mod(max_lags * sample_rate, np.mean(periods))
        offset_matrix[i, j] = offsets
        correlation_matrix[i, j] = max_corr
        print()

print(correlation_matrix)
print(offset_matrix)

plot_waterfall_delta_train(delta_trains, periods, channel_index=0)  # for channel 1
plot_waterfall_delta_train(delta_trains, periods, channel_index=1)  # for channel 2
plot_waterfall_delta_train(delta_trains, periods, channel_index=2)  # for channel 3

print()