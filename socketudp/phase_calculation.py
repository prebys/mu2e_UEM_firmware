import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import windows
from scipy.stats import linregress

# Parameters
scaling_factor = 1000000
A = 0.5                     # Amplitude of the cosine wave
fc = 9.1234 * scaling_factor  #  Frequency of the cosine wave (Hz)
phase_deg = 30             # Phase shift in degrees
fs = 500 * scaling_factor   # Sampling frequency (oversampling factor = 32)
T = 30 / scaling_factor    # Duration in seconds
t = np.arange(0, T, 1/fs)  # Time vector
unpadded_df = fs / len(t)
print(f"Starting test with: {len(t)} samples, fs = {fs} Hz, unpadded df = {unpadded_df:.6f} Hz")
print(f"Cosine frequency: {fc:.4f} Hz, phase shift: {phase_deg} degrees")

# Convert phase to radians
phi = np.deg2rad(phase_deg)

# Time domain signal with phase shift plus noise
x = A * np.cos(2 * np.pi * fc * t + phi) + np.random.normal(0, 1.5, len(t))  # Adding noise
# window = windows.hann(len(x))
# x = x * window  # Apply a Hann window to the signal

# Plot time-domain signal
plt.figure()
plt.plot(t, x)
plt.title("Cosine wave with phase shift")
plt.xlabel("Time (s)")
plt.ylabel("Amplitude")
plt.grid(True)
plt.tight_layout()

# FFT parameters
n = len(x) * 10
X = 1 / len(x) * np.fft.fft(x, n=n)  # N-point FFT with fftshift for symmetry
f = np.fft.fftfreq(len(X), d=1/fs)  # Frequency bins for positive frequencies

# mask fft to keep only positive frequencies and eliminate dc
mask = (f >= 5 * scaling_factor) & (f <= 15 * scaling_factor)
full_X = X
full_f = f
X = X[mask]
f = f[mask]

# Magnitude spectrum
plt.figure()
plt.stem(f, np.abs(X), use_line_collection=True)
plt.title("Amplitude Spectrum")
plt.xlabel("Frequency (Hz)")
plt.ylabel("|X(k)|")
plt.grid(True)
plt.tight_layout()

# Phase spectrum (initial computation — may be noisy)
phase = np.angle(X, deg=True)
high_mag_phase = phase.copy()
high_mag_phase[np.abs(X) < 0.1] = np.nan  # Mask low magnitude values


plt.figure()
plt.scatter(f, high_mag_phase)
plt.title("Initial Phase Spectrum (possibly noisy)")
plt.xlabel("Frequency (Hz)")
plt.ylabel("Phase (degrees)")
plt.grid(True)
plt.tight_layout()

# max magnitude index
max_index = np.argmax(np.abs(X))
# magnitude there
max_magnitude = np.abs(X[max_index])
# frequency at max magnitude
max_frequency = f[max_index]
print(f"Max magnitude: {max_magnitude:.4f} at frequency: {max_frequency:.2f} Hz")
# phase at that index
max_phase = phase[max_index]
print(f"Phase at max magnitude: {max_phase:.2f} degrees")
print(f"Other magnitudes: {np.abs(X)[max_index-1:max_index+2]}")
print(f"Other phases: {phase[max_index-1:max_index+2]} degrees")
print(f"Other frequencies: {f[max_index-1:max_index+2]} Hz")
print(f"Other FFT values: {X[max_index-1:max_index+2]}")

# Step 1: Compute sub-bin offset using log-magnitude parabolic interpolation
m1, m0, m2 = np.abs(X)[max_index - 1:max_index + 2]
a = np.log(m1)
b = np.log(m0)
c = np.log(m2)
p = 0.5 * (a - c) / (a - 2*b + c)  # interpolation offset from center bin

# Step 2: Interpolate complex FFT value
X_m1, X_0, X_p1 = X[max_index - 1 : max_index + 2]

# Complex-valued interpolation
X_interp = X_0 + 0.5 * p * (X_p1 - X_m1)

# Step 3: Extract interpolated phase
interp_phase_deg = np.angle(X_interp, deg=True)
interp_freq = f[max_index] + p * (f[max_index + 1] - f[max_index])

# # Use contributing bins (X_m1, X_0, X_p1)
# vecs = np.array([X_m1, X_0, X_p1])
# unit_vecs = vecs / np.abs(vecs)  # project to unit circle
#
# # Circular mean resultant length R
# R = np.abs(np.mean(unit_vecs))
# # Convert R to angular standard deviation (in radians)
# if R < 1.0:
#     phase_std_rad = np.sqrt(-2 * np.log(R))
# else:
#     phase_std_rad = 0.0
# phase_std_deg = np.rad2deg(phase_std_rad)
#
# # Step 4: Print results
# print(f"Interpolated frequency: {interp_freq:.6f} Hz")
# # print(f"Interpolated phase: {interp_phase_deg:.2f} degrees")
# print(f"Estimated complex-interpolated phase: {interp_phase_deg:.2f}° ± {phase_std_deg:.2f}° (1σ)")
#
# # Phase uncertainty estimate using local FFT bins
# # Choose a window of bins around the peak
# k = max_index
# bin_range = np.arange(k - 4, k + 5)
# valid = (bin_range >= 0) & (bin_range < len(X))  # avoid index errors
# bin_range = bin_range[valid]
#
# # Extract magnitudes and phases
# magnitudes = np.abs(X[bin_range])
# phases = np.angle(X[bin_range], deg=True)
#
# # Weighted mean phase
# weights = magnitudes
# mean_phase = np.average(phases, weights=weights)
#
# # Weighted standard deviation (phase uncertainty)
# phase_variance = np.average((phases - mean_phase) ** 2, weights=weights)
# phase_std_deg = np.sqrt(phase_variance)
# print(f"Estimated local phase uncertainty: ±{phase_std_deg:.2f} degrees (1σ)")
#
# # estimate phase based on straight line interpolation of phase points
# # do linear interpolation
# slope, intercept, r, p, se = linregress(f[bin_range], phases[valid])
# # calculate phase at interpolated frequency
# interp_phase_linear_deg = slope * interp_freq + intercept
# print(f"Interpolated phase (linear): {interp_phase_linear_deg:.2f} ± {se:.2f} degrees")
#
# # Estimate frequency uncertainty based on 1 / time_measured (Nyquist)
# print(f"Estimated frequency uncertainty: ±{1 / T:.6f} Hz")  # ± 0.033333 Hz
# # propagate uncertainty, if sigma_f is ±0.033333 Hz, and interpolation error is "se"
# # phase = slope * f + intercept
# # sigma_phase^2 = σ(φ∣slope)^2 + σ(φ∣f)^2 = se^2 + (dφ/df)^2 * σ(f)^2 = se^2 + (slope^2 * σ(f)^2)
# sigma_phase = np.sqrt(se**2 + (slope**2 * (1 / T)**2))
# print(f"Estimated phase uncertainty: ±{sigma_phase:.2f} degrees (1σ)")
#
# # Local slope estimate from 3-bin fit
# f_bins = f[max_index - 1:max_index + 2]
# phi_bins = np.unwrap(np.angle([X_m1, X_0, X_p1]))
# slope_local, intercept = np.polyfit(f_bins, phi_bins, 1)  # rad/Hz
#
# # Propagate frequency uncertainty
# sigma_f = 1 / T
# sigma_phi_rad = abs(slope_local) * sigma_f
# sigma_phi_deg = np.rad2deg(sigma_phi_rad)
#
# print(f"Phase slope near peak: {slope_local:.2f} rad/Hz")
# print(f"Estimated phase uncertainty from freq ±1/T: ±{sigma_phi_deg:.3f}°")
#
# # Signal power: peak bin squared
# signal_power = np.abs(X[max_index])**2
#
# # Noise power: average of side bins (skip ±1 bins)
# noise_bins = full_X[np.abs(full_X) < 1500]  # exclude bins close to peak
# noise_power = np.mean(np.abs(noise_bins)**2)
#
# snr = signal_power / noise_power  # linear SNR
# delta_f = 1 / T  # actual frequency resolution from unpadded FFT
# sigma_f = delta_f / (snr * np.sqrt(len(x)))  # freq uncertainty
#
# # Phase slope near peak (as before)
# slope_local = np.polyfit(f[max_index - 1:max_index + 2], np.unwrap(np.angle([X_m1, X_0, X_p1])), 1)[0]
# sigma_phi_rad = abs(slope_local) * sigma_f
# sigma_phi_deg = np.rad2deg(sigma_phi_rad)
#
# print(f"SNR-based frequency uncertainty: ±{sigma_f:.6f} Hz")
# print(f"Estimated phase uncertainty: ±{sigma_phi_deg:.3f}° (1σ)")

# https://dsp.stackexchange.com/questions/78926/error-estimation-for-frequency
# Step 1: Signal and noise power estimation
signal_power = np.abs(X[max_index])**2

# Select surrounding bins (excluding the peak itself)
noise_bins = full_X[:1000]  # exclude bins close to peak
noise_power_per_bin = np.mean(np.abs(noise_bins)**2)

# Estimate single-sided noise spectral density N0 (in units of power per Hz)

N0 = noise_power_per_bin / unpadded_df

# Step 2: Compute frequency uncertainty (from StackExchange formula)
sigma_f = 1.219 / np.sqrt(T**3 * (signal_power / N0))

# Step 3: Estimate phase slope near the peak (in radians/Hz)
# Use central difference to approximate dφ/df
k = max_index
phi_m1 = np.angle(X[k - 1])
phi_p1 = np.angle(X[k + 1])
df_local = f[k + 1] - f[k - 1]
dphi_df = (phi_p1 - phi_m1) / df_local

# Step 4: Propagate to phase uncertainty
sigma_phi_rad = np.abs(dphi_df) * sigma_f
sigma_phi_deg = np.degrees(sigma_phi_rad)

# Step 5: Report
print(f"Signal power: {signal_power:.4e} W")
print(f"Noise power per bin: {noise_power_per_bin:.4e} W")
print(f"Estimated single-sided noise spectral density N0: {N0:.4e} W/Hz")
print(f"SNR: {signal_power / N0:.3e}")
print(f"Estimated frequency uncertainty: ±{sigma_f:.3e} Hz")
print(f"Phase slope near peak: {dphi_df:.2f} rad/Hz")
print(f"Estimated phase uncertainty: ±{sigma_phi_deg:.2f}° (1σ)")

print()
print("Final Results:")
print(f"Interpolated frequency: {interp_freq:.3f} ± {sigma_f:.3e} Hz")
print(f"Interpolated phase: {interp_phase_deg:.2f}° ± {sigma_phi_deg:.2f}° (1σ)")


plt.show()
print()
