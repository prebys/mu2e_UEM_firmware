import json
from collections import deque
from typing import Any
import numpy as np

from matplotlib import pyplot as plt


# --- Data Generation ---
def generate_noisy_sine_wave(
    num_points: int = 1000,
    points_per_period: int = 100,
    amplitude: int = 500,
    noise_level: int = 10,
    save_to_disk: bool = False,
    get_from_disk: bool = False,
) -> tuple[list[int], list[int], list[int]]:
    if get_from_disk:
        with open("sine_wave.csv", "r") as f:
            data = json.loads(f.read())
            x = data["x"]
            noisy_wave = data["wave"]
            expected_peaks = data["expected_peaks"]
        return x, noisy_wave, expected_peaks
    
    x = np.arange(num_points)
    base_wave = -np.sin(2 * np.pi * x / points_per_period) * amplitude
    base_wave = base_wave.astype(int)

    noisy_wave = []
    i = 0
    while i < len(base_wave):
        val = base_wave[i]
        noise = int(np.random.normal(0, noise_level))
        noisy_val = val + noise

        noisy_wave.append(int(noisy_val))
        i += 1

    expected_peaks = []
    peak_offset = int(points_per_period * 0.25)
    for start in range(peak_offset, num_points, points_per_period):
        if start < len(base_wave):
            expected_peaks.append(start)

    if save_to_disk:
        to_save_json = {
            "x": x.tolist(),
            "wave": noisy_wave,
            "expected_peaks": expected_peaks
        }
        with open("sine_wave.csv", "w") as f:
            f.write(json.dumps(to_save_json))

    return x, noisy_wave, expected_peaks


# --- Peakfinding Algorithms ---
def peak_fn_middle_min(window: deque) -> None | tuple[int, int]:
    """Returns the index of the minimum value in the middle four points of the window."""
    min_val = min(window)
    for i in range(4, 8):
        if window[i] == min_val:
            return i, window[i]
    return None

def peak_fn_middle_min_unique(window: deque) -> None | tuple[int, int]:
    """Same as previous function, but only returns the peak if it is unique."""
    min_val = min(window)
    for i in range(4, 8):
        if window[i] == min_val:
            outer_indices = list(range(0, 4)) + list(range(8, 12))
            if all(window[j] != min_val for j in outer_indices):
                return i, window[i]
            break
    return None

def peak_fn_middle_min_lower_than_ends(window) -> None | tuple[int, int]:
    min_val = min(window)
    for i in range(4, 8):
        if window[i] == min_val:
            if min_val < window[0] and min_val < window[11]:
                return i, window[i]
            break
    return None

def peak_fn_unique_to_left(window) -> None | tuple[int, int]:
    """Return a peak if the minimum value is not found in the leftwards window"""
    min_val = min(window)
    for i in range(4, 8):
        if window[i] == min_val:
            left_window = list(window)[0:4]
            if min_val not in left_window:
                return i, window[i]
            break
    return None

def min_in_window(window: list) -> tuple[int, int]:
    """Returns the value of the minimum in the window."""
    current_min = (0, window[0])
    for i, val in enumerate(window):
        if val < current_min[1]:
            current_min = (i, val)
    return current_min
    

def find_min(min_pipeline):
    # Ensure min_pipeline is a list or array of at least 5 elements
    assert len(min_pipeline) == 5

    min01 = 0 if min_pipeline[0] <= min_pipeline[1] else 1
    min23 = 2 if min_pipeline[2] <= min_pipeline[3] else 3
    min0123 = min01 if min_pipeline[min01] <= min_pipeline[min23] else min23
    min01234 = min0123 if min_pipeline[min0123] <= min_pipeline[4] else 4
    abs_min = min_pipeline[min01234]
    
    return abs_min, min01234  # returning both the min value and its index

def five_window_queue(data_queue: deque) -> None | tuple[int, int]:
    """This queue allows for five windows (20 points). Reimplement above algo"""
    min_pipeline = deque(maxlen=5)
    data_queue = list(data_queue)  # Convert deque to list for slicing
    min_pipeline.append(min_in_window(data_queue[0:4])[1])
    min_pipeline.append(min_in_window(data_queue[4:8])[1])
    min_window_index, min_val = min_in_window(data_queue[8:12])
    min_pipeline.append(min_val)
    min_pipeline.append(min_in_window(data_queue[12:16])[1])
    min_pipeline.append(min_in_window(data_queue[16:20])[1])
    abs_min, min01234 = find_min(min_pipeline)
    if min01234 == 2:
        print(min_pipeline, abs_min, min01234)
        return min_window_index, min_val
    return None
    # for i in range(8, 12):
    #     if window[i] == min_val:
    #         left_window = list(window)[0:8]
    #         if min_val not in left_window:
    #             return i, window[i]
    #         break
    # return None


# --- PeakFinder Engine ---
class PeakFinder:
    def __init__(self, data_in: list[int], peak_function: callable, queue_length: int = 12):
        self.data: list[int] = data_in
        self.window = deque(data_in[:queue_length], maxlen=queue_length)
        self.peak_function = peak_function
        self.results = []  # list of tuples of (index, height)
        self.current_index = queue_length
        self.queue_length = queue_length
        
        # put in four data points at a time
        while self.current_index < len(self.data) - 1:
            self.process_window()
            self.window.extend(self.data[self.current_index:self.current_index + 4])
            self.current_index += 4
            
    @property
    def peak_locations(self) -> list[int]:
        """Returns just peak locations"""
        return [index for index, _ in self.results]
    
    @property
    def peak_heights(self) -> list[int]:
        """Returns just peak heights"""
        return [height for _, height in self.results]
            
    def process_window(self):
        # peakfinding algorithms will return an index in the window, along with the peak height
        result = self.peak_function(self.window)
        print(self.current_index, result)
        if not result:
            return
        window_index = result[0]
        peak_height = result[1]
        # find the index of the peak in the original data
        # current_index is currently the index of the final deque item in the data list
        # for example
        # deque: [..., 12, 13, 14] (last item is index 11)
        # data: [..., 12, 13, 14, 15, 16, ...]
        # current_index points to location of "14" in "self.data" list
        
        # peak_index is location of peak in "self.data" list
        peak_index = self.current_index - self.queue_length + window_index
        
        # add the peak index to the results
        self.results.append((peak_index, peak_height))


# --- Comparison ---
def compare_peaks(peakfinder: PeakFinder, expected):   # , tolerance=2):
    matched = 0
    # unmatched_expected = expected.copy()
    # used_detected = set()
    print(peakfinder.peak_function.__name__)
    expected_interval = expected[1] - expected[0]
    detected = peakfinder.results
    
    detected_last = None
    for i, (peak_index, peak_height) in enumerate(detected):
        peak_index: int
        peak_height: int
        if not detected_last:
            detected_last = peak_index
            continue
            
        diff = abs(peak_index - detected_last)
        error = abs(diff - expected_interval)
        if error > expected_interval * 0.25:
            print(f"Detected peaks are not evenly spaced: {detected_last} and {peak_index} ({error})")
            # print peak heights around the detected peak
            
            # find start of peak window assuming four points per peak
            # example, if peak_index is 6, start_of_peak_window is 4 (assuming [0 1 2 3] [4 5 6 7] [8 9 10 11])
            peak_index_in_window = peak_index % 4
            start_of_peak_window = peak_index - peak_index_in_window
            prev_prev_window = peakfinder.data[start_of_peak_window - 8:start_of_peak_window - 4]
            previous_window = peakfinder.data[start_of_peak_window - 4:start_of_peak_window]
            current_window = peakfinder.data[start_of_peak_window:start_of_peak_window + 4]
            next_window = peakfinder.data[start_of_peak_window + 4:start_of_peak_window + 8]
            next_next_window = peakfinder.data[start_of_peak_window + 8:start_of_peak_window + 12]
            
            # Print with formatting
            def fmt(window, highlight_idx=None):
                return "[" + ", ".join(
                    f"**{v}**" if ii == highlight_idx else f"{v}"
                    for ii, v in enumerate(window)
                ) + "]"
            
            print("Nearby peak heights:", end=" ")
            print(f"{prev_prev_window if prev_prev_window else '[]'},", end=" ")
            print(f"{previous_window if previous_window else '[]'},", end=" ")
            print(fmt(current_window, peak_index % 4) + ",", end=" ")
            print(f"{next_window if next_window else '[]'}")
            print(f"{next_next_window if next_next_window else '[]'}")
            print()
            
        detected_last = peak_index



def main(x, wave, expected_peaks):
    # pf1 = PeakFinder(wave, peak_fn_middle_min)
    # pf2 = PeakFinder(wave, peak_fn_middle_min_unique)
    # pf3 = PeakFinder(wave, peak_fn_middle_min_lower_than_ends)
    # pf4 = PeakFinder(wave, peak_fn_unique_to_left)
    pf5 = PeakFinder(wave, five_window_queue, queue_length=20)
    
    # results1 = pf1.results
    # results2 = pf2.results
    # results3 = pf3.results
    # results4 = pf4.results
    results5 = pf5.results
    
    # compare_peaks(pf1, expected_peaks)
    # compare_peaks(pf2, expected_peaks)
    # compare_peaks(pf3, expected_peaks)
    # compare_peaks(pf4, expected_peaks)
    compare_peaks(pf5, expected_peaks)
    
    # comparison_df = pd.DataFrame([
    #     {"Algorithm": "Algorithm 1", **compare_peaks(pf1.results, expected_peaks)},
    #     {"Algorithm": "Algorithm 2", **compare_peaks(pf2.results, expected_peaks)},
    #     {"Algorithm": "Algorithm 3", **compare_peaks(pf3.results, expected_peaks)},
    # ])
    
    xy_points = list(zip(x, wave))
    
    def alternating_colors(n, group_size=4, colors=('r', 'b')):
        result = []
        for i in range(n):
            group_index = (i // group_size) % len(colors)
            result.append(colors[group_index])
        return result
    
    colors = alternating_colors(len(wave))
    plt.plot(wave)
    plt.scatter(x, wave, c=colors, s=0.25)
    plt.grid(which='both', axis='y', color='gray', linestyle='--', linewidth=0.2)
    plt.xlim(0, 200)
    plt.show()
    
    def s(point, d: int = 5, s=0.25):
        colors_clip = colors[point - d:point + d + 2]
        wave_clip = wave[point - d:point + d + 2]
        x_clip = list(range(len(wave_clip)))
        plt.plot(wave_clip)
        plt.scatter(x_clip, wave_clip, c=colors_clip, s=s)
        # plt.xlim(point - d, point + d + 1)
        # plt.ylim(min_v - 10, max_v + 10)
        plt.xticks(x_clip)
        plt.yticks(list(set(wave_clip)))
        plt.grid(axis='y', color='gray', linestyle='--', linewidth=0.2, which='both')
        plt.show()
        
    breakpoint()
        
# Run example
_x, _wave, _expected_peaks = generate_noisy_sine_wave(
    num_points=50000,
    points_per_period=100,
    amplitude=500,
    noise_level=35,
    save_to_disk=False,
    get_from_disk=True
)

main(_x, _wave, _expected_peaks)




