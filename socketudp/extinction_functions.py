import numpy as np

from scipy.stats import norm


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


def center_pulses(delta_trains, period):
    """
    Center the pulses in the delta trains by correcting the period and subtracting the mean.
    :param delta_trains: A list of the three delta trains. Operations should be performed equally on all three channels.
    :param period: The period averaged between the three delta trains.
    :return: A new array of three delta trains, and a new period.
    """
    starting_period = period
    sss = np.concatenate(delta_trains)  # all three lists are concatenated into one array
    sss_norm = symmetric_mod(sss, period)  # the normalized version of above
    
    individual_means = np.array([np.mean(symmetric_mod(train, period)) for train in delta_trains])
    print(f"Initial means for each of the three trains: {individual_means} ns")

    normalized_delta_train = symmetric_mod(sss_norm, period)
    print(f"Delta train mean value (combined channels): {np.mean(normalized_delta_train):.2f} ns")

    # (1 - Period)
    # calculate new period based on the shift of the mean value,
    period, normalized_delta_train = correct_period(sss, normalized_delta_train, period)

    # (2 - Mean)
    # correct by subtracting from the mean of the modulated delta train (it'll be offset from zero by some amnt.)
    delta_train, delta_correction = subtract_mean(sss, period, focus_beginning=True)

    # (3 - Mean, Middle Focus)
    # once the pulse is *mostly* centered,
    # now specifically center it by just the mean of the  middle 300 ns of points
    delta_train, new_delta_correction = subtract_mean(delta_train, period, focus_middle=True, focus_beginning=True)
    delta_correction += new_delta_correction

    # (4 - Period, Middle Focus)
    # correct for mean deviation using just the center 300 ns
    period, normalized_delta_train = correct_period(delta_train, normalized_delta_train, period, focus_middle=True)

    # (5 - Mean, Middle Focus)
    delta_train, new_delta_correction = subtract_mean(delta_train, period, focus_middle=True, focus_beginning=True)
    delta_correction += new_delta_correction
    
    # Report result
    print(f"Total correction on the mean: {delta_correction} ns")
    delta_trains = [train + delta_correction for train in delta_trains]
    
    # Fix individual delta means just one time
    for i, train in enumerate(delta_trains):
        train, correction = subtract_mean(train, period, focus_middle=True, focus_beginning=False)
        delta_trains[i] = train

    means = [np.mean(train) for train in delta_trains]
    print(f"New means for each of the three trains:", end="")
    for mean in means:
        print(f"{mean * 1e-6:.2f} ms, ", end="")
    print()

    return delta_trains, period


def correct_period(delta_train: np.ndarray,
                   normalized_deltas: np.ndarray,
                   period: float, focus_middle=False) -> tuple[float, np.ndarray]:
    """

    :param delta_train: Three delta trains concatenated into one array.
    :param normalized_deltas: The normalized version of the delta train, using symmetric_mod.
    :param period: Average of three periods
    :param focus_middle:
    :return: (1) The new period, (2) The new modulated delta train
    """
    # first, if there's an error in detected_period, there will be a drift in the mean value after modulo
    # get the mean value of the first and last 5% of the normalized delta_train
    if focus_middle:
        normalized_deltas = normalized_deltas[np.abs(normalized_deltas) < 200]
    five_percent = int(len(normalized_deltas) * 0.15)

    # check to make sure there is enough data to make a good correction
    starting_window: np.ndarray = normalized_deltas[:five_percent]
    ending_window = normalized_deltas[-five_percent:]
    ending_mean_error = np.std(ending_window, ddof=1) / np.sqrt(len(ending_window))  # standard error of the mean
    starting_mean_error = np.std(starting_window, ddof=1) / np.sqrt(len(starting_window))  # standard error of the mean
    if starting_window.size < 2 or ending_window.size < 2:
        print("Warning: Not enough data to calculate starting or ending mean, aborting period correction.")
        return period, normalized_deltas
    if starting_mean_error > 5 or ending_mean_error > 5:
        print(f"Warning: Starting mean error {starting_mean_error:.2f} ns or "
              f"ending mean error {ending_mean_error:.2f} ns is too high, "
              f"aborting period correction.")
        return period, normalized_deltas

    # calculate the mean of the first and last 5% of the normalized delta train
    starting_mean = np.mean(normalized_deltas[:five_percent])
    ending_mean = np.mean(normalized_deltas[-five_percent:])
    print(f"Starting first {five_percent}/{len(normalized_deltas)} points: {normalized_deltas[:five_percent]}")
    print(f"Ending last {five_percent}/{len(normalized_deltas)} points: {normalized_deltas[-five_percent:]}")

    # number of cycles in the delta train (with the period error, but should be fine)
    n_cycles = (delta_train[-1] - delta_train[0]) / period

    # error per cycle is deviation in the mean over the number of cycles
    error = (ending_mean - starting_mean) / n_cycles

    print(f"Starting mean: {starting_mean:.2f} ns, Ending mean: {ending_mean:.2f} ns, "
          f"Error: {error:.4f} ns, Old Period: {period:.4f} ns, "
          f"New Period: {period + error:.4f} ns")

    return period + error, symmetric_mod(delta_train, period + error)


def subtract_mean(deltas: np.ndarray, period: float, focus_middle=False, focus_beginning=True
                  ) -> tuple[np.ndarray, int]:
    """
    :param deltas: Three delta trains concatenated into one array.
    :param period: Period, averaged between three detected periods
    :param focus_middle:
    :param focus_beginning:
    :return: 1) The new concatenated delta train with the mean subtracted, 2) The value of correction made to the train
    """
    if len(deltas) < 2:
        print("Warning: Not enough data to calculate mean, aborting mean subtraction.")
        return deltas, 0

    # potentially, focus on just the first 5% of the delta train
    delta_window = deltas
    if focus_beginning:
        delta_range = deltas[-1] - deltas[0]
        five_p = deltas[0] + int(delta_range * 0.1)
        delta_window = deltas[deltas < five_p]  # first five percent of the delta points

    # initial normalization
    normalized_delta_window = symmetric_mod(delta_window, period)

    # potentially, focus on just the middle +/- 250 ns of the normalized delta train
    if focus_middle:
        normalized_delta_window = normalized_delta_window[np.abs(normalized_delta_window) < 250]

    if not normalized_delta_window.size > 0:
        print("Warning: Not enough data to calculate mean, aborting mean subtraction.")
        return deltas, 0
    correction = -round(np.mean(normalized_delta_window))  # make the correction be the opposite of whatever the mean is
    centered = " (center of) " if focus_middle else " "
    print(f"Correcting phase of{centered}delta train by {correction} ns, "
          f"new mean: {np.mean(normalized_delta_window + correction):.2f} ns")
    deltas += correction  # add correction to deltas (sss)
    return deltas, correction


def simulate_delta_train(signal_period, phase_offset_deg, arrival_jitter_ns,
                         particle_num_mean, particle_num_width, noise_num_mean, noise_num_width,
                         length_ns, sample_rate):
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
    delta_train = []
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
            delta_train.append(signal_time)

        # Add noise events with a probability of noise_probability
        if np.random.rand() < round(np.random.normal(noise_num_mean, noise_num_width)):
            noise_time = time + np.random.randint(0, signal_period)
            # assume 4ns sampling time, so we round to the nearest 4ns
            delta_train.append(round(noise_time / sample_rate) * sample_rate)

        # Move to the next delta time
        time += signal_period

    return np.array(sorted(delta_train))


def get_delta_trains_from_hex(hex_check, channel,
                              fft_time_range_ns: tuple[float, float]
                              ) -> tuple[np.ndarray, tuple[float, float]]:
    peak_height_dataframe = hex_check.peak_height_dataframe
    delta_train = peak_height_dataframe[peak_height_dataframe['channel_number'] == channel].time_ns.values
    if delta_train.size == 0:
        print(f"[CH{channel}] No events found for channel {channel}.")
        return np.array([]), fft_time_range_ns
    print(f"[CH{channel}] Using real data from channel {channel} with {len(delta_train)} events.")
    print(f"[CH{channel}] First event time: {delta_train[0]:.2f} ns, ")
    delta_train = np.sort(delta_train)
    if fft_time_range_ns[0] is None:
        fft_time_range_ns = (delta_train[0], fft_time_range_ns[1])
    if fft_time_range_ns[1] is None:
        fft_time_range_ns = (fft_time_range_ns[0], delta_train[-1])

    # mask time window
    time_mask = (fft_time_range_ns[0] <= delta_train) & (delta_train <= fft_time_range_ns[1])
    # time_mask = (0 <= delta_train) & (delta_train <= 5e6)
    delta_train = delta_train[time_mask]
    # print(f"[CH{channel}] After time mask, {np.sum(time_mask)} events remain in the time range "
    #       f"{delta_train[0]:.2f} to {delta_train[-1]:.2f} ms")
    return delta_train, fft_time_range_ns


def get_delta_trains_per_event_from_hex(hex_check, channel, fft_time_range_ns, period=None,
                                        units='ns'):
    assert channel != 0, "Channel 0 is invalid, this function assumes channel numbers 1-4."
    peak_height_dataframe = hex_check.peak_height_dataframe
    grouped = peak_height_dataframe[peak_height_dataframe['channel_number'] == channel] \
                .groupby('internal_event_number')

    # grouped is a dataframe with length equal to # of events, even if some of those

    delta_trains = []
    start_ns, end_ns = fft_time_range_ns  # don’t mutate the caller’s tuple
    for event_number, group in grouped:
        arr = np.sort(group.time_ns.values)
        if units == 'ms':
            arr = arr / 1e6
        elif units == 'us':
            arr = arr / 1e3
        if arr.size == 0:
            continue

        if start_ns is None: start_ns = arr[0]
        if end_ns   is None: end_ns   = arr[-1]

        mask = (start_ns <= arr) & (arr <= end_ns)
        new_arr = arr[mask]
        print(f"[CH{channel}] Event {event_number}: {len(arr)} peaks heights"
              f"({len(new_arr)} from t = {start_ns} to {end_ns} ns).")

        # change below comparison to ">" to ignore empty events
        if new_arr.size >= 0:
            # print AFTER confirming nonempty; also fix the units in the text
            # print(f"[CH{channel}] After time mask, {new_arr.size} events remain in "
            #       f"{(new_arr[0]/1e6):.2f}–{(new_arr[-1]/1e6):.2f} ms")
            if period:
                new_arr = symmetric_mod(new_arr, period)
            delta_trains.append(new_arr)
        else:
            pass
            # print(f"[CH{channel}] No events left after time mask for event {event_number}, skipping.")

    if not delta_trains:
        # print(f"[CH{channel}] No events found for channel {channel} in the specified time range.")
        return np.array([], dtype=object), (start_ns, end_ns)

    # print(f"[CH{channel}] Found {len(delta_trains)} events for channel {channel}.")
    return np.array(delta_trains, dtype=object), (start_ns, end_ns)


def lorentzian(_f, A, f0, sigma, offset):
    gamma = sigma / 2
    return A * (gamma ** 2) / ((_f - f0) ** 2 + gamma ** 2) + offset


def report_results_with_error(fft_freqs, fft_abs, unpadded_df, mini_fft_abs, max_idx, zero_padding_ratio,
                              detected_frequency,
                              length_ns, detected_period, frequency_fit_error, channel):
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
    signal_power = np.abs(mini_fft_abs[max_idx]) ** 2
    print(f"[CH{channel}] Signal power: {signal_power:.3e} W, "
          f"Average noise bin: {average_noise_power:.3e} W, "
          f"Noise density: {noise_density:.3e} W/Hz, "
          f"SNR: {signal_power / noise_density:.2f} (T = {length_ns / 1e6} ms, "
          f"zero padding ratio = {zero_padding_ratio})")

    # calcualte f_rms
    f_rms = 1.219 / np.sqrt((length_ns * 1e-9) ** 3 * (signal_power / noise_density))  # Hz
    f_rms /= 1e3  # convert to kHz

    # propagate this unceratinty to period
    t_rms = f_rms / detected_frequency ** 2 * 1e6  # ns
    period_fit_error = frequency_fit_error / detected_frequency ** 2 * 1e6  # ns
    print(f"[CH{channel}] Fitted frequency: {detected_frequency:.3f} ± {f_rms:.4f} ± {frequency_fit_error:.4f} kHz (SNR error, fit error)")
    print(f"[CH{channel}] Fitted period: {detected_period:.4f} ± {t_rms:.4f} ± {period_fit_error:.4f} ns (SNR error, fit error)")
    return np.sqrt(t_rms ** 2 + period_fit_error ** 2)



def get_three_fold_coincidence_points(delta_trains: list[np.ndarray]):
    # Parameters
    coincidence_window_ns = 300  # events within this window are considered coincident

    # Get the three channels
    ch1: np.ndarray = np.array(delta_trains[0])
    ch2: np.ndarray = np.array(delta_trains[1])
    ch3: np.ndarray = np.array(delta_trains[2])

    # Track which particles (timestamps) have already been used
    used1 = np.full(len(ch1), False)
    used2 = np.full(len(ch2), False)
    used3 = np.full(len(ch3), False)

    # Store coincidences as three-tuples of the ch1, ch2, ch3 times
    three_fold_coincidences = []

    for i1, t1 in enumerate(ch1):
        i1: int
        t1: int
        if used1[i1]:
            continue  # skip if this ch1 timestamp is already used in a coincidence

        # np.searchsorted returns the indices where this range starts and ends
        # Example: t1 = 1000ns
        # Search for events in ch2 that are within ±100ns of t1 (i.e., 900–1100ns)
        # if there are any events in that range, let's say for example 995 ns
        # then i2_lo will come below 995 and i2_hi will come above 995
        # so ch2[i2_lo:i2_hi] will give you the indices for the range of numbers between 990 - 1010
        # Find indices in ch2 within the coincidence window of t1
        i2_lo = np.searchsorted(ch2, t1 - coincidence_window_ns, side='left')
        i2_hi = np.searchsorted(ch2, t1 + coincidence_window_ns, side='right')
        possible_i2s = range(i2_lo, i2_hi)

        for i2 in possible_i2s:
            if used2[i2]:
                continue  # skip if this ch2 timestamp is already used

            t2 = ch2[i2]

            # Optional: center the search around the average of t1 and t2
            # This helps better target ch3 events that are likely involved in the same interaction
            t_center = (t1 + t2) // 2

            # Search for events in ch3 that are within ±100ns of the center
            i3_lo = np.searchsorted(ch3, t_center - coincidence_window_ns, side='left')
            i3_hi = np.searchsorted(ch3, t_center + coincidence_window_ns, side='right')
            possible_i3s = range(i3_lo, i3_hi)

            for i3 in possible_i3s:
                if used3[i3]:
                    continue  # skip if this ch3 timestamp is already used

                t3 = ch3[i3]

                # Make sure all pairs are within the coincidence window
                if (
                    abs(t1 - t3) <= coincidence_window_ns and
                    abs(t2 - t3) <= coincidence_window_ns
                ):
                    # Found a valid 3-fold coincidence
                    three_fold_coincidences.append((t1, t2, t3))

                    # Mark all three timestamps as used so they can't be reused
                    used1[i1] = True
                    used2[i2] = True
                    used3[i3] = True

                    # Break to avoid reusing t1 or t2 with a different t3
                    break

            if used1[i1]:
                # We've already used t1 in a coincidence; move to the next one
                break

    # Return the average time of each coincidence (rounded to int)
    average_points = np.array([np.mean(i) for i in three_fold_coincidences]).astype(int)
    return average_points


def combine_periods(mean_value: float, periods: list[float], errors: list[float]) -> tuple[float, float]:
    """
    Combine multiple period measurements with their associated errors into a single
    weighted mean period and error.
    Uses the Birge ratio to scale the error if the measurements are inconsistent.
    :param mean_value: The initial mean value to report alongside the weighted mean.
    :param periods: List of measured periods.
    :param errors: List of associated errors for each measured period.
    :return: A tuple containing the weighted mean period and its final error.
    """
    # Convert to numpy arrays
    if len(periods) < 2:
        print("Not enough period measurements to combine.")
        return periods[0], errors[0]
    periods = np.array(periods, dtype=float)
    errors = np.array(errors, dtype=float)

    # Compute weights
    weights = 1.0 / errors ** 2
    
    # Weighted mean
    weighted_mean = np.sum(weights * periods) / np.sum(weights)

    # Error on weighted mean
    weighted_error = 1.0 / np.sqrt(np.sum(weights))

    # Chi-square and Birge ratio
    residuals = periods - weighted_mean
    chi2 = np.sum((residuals / errors) ** 2)
    dof = len(periods) - 1
    birge_ratio = np.sqrt(chi2 / dof)

    # Decide final error (do not shrink if Birge < 1)
    if birge_ratio > 1:
        final_error = weighted_error * birge_ratio
    else:
        final_error = weighted_error

    # Print results
    print(f"Input mean: {mean_value:.9f} ns")
    print(f"Weighted mean: {weighted_mean:.9f} ns")
    print(f"Weighted error (uncorrelated only): ±{weighted_error:.6f} ns")
    print(f"Chi²/dof: {chi2:.4f} / {dof} = {chi2 / dof:.4f}")
    print(f"Birge ratio: {birge_ratio:.3f}")
    print(f"Final result: {weighted_mean:.9f} ± {final_error:.6f} ns")
    return weighted_mean, final_error


if __name__ == "__main__":
    print("don't run this file")