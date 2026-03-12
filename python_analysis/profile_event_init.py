#!/usr/bin python3
import cProfile
import io
import os
import pstats
from time import perf_counter

from python_analysis.dat_io import read_data_file
from python_analysis.event_utils import iter_event_bytes, split_logical_events_on_subevent_reset
from python_analysis.hex_check_classes import Event


TARGET_FILE = "data_20260303_134443_2026.03.04_16.53.41.dat"
NUM_EVENTS = 20
TOP_N = 40


def load_logical_events(file_name: str, limit: int) -> list[bytes]:
    dir_name = os.path.dirname(os.path.realpath(__file__))
    data, _, _ = read_data_file(dir_name, file_name)

    logical_events: list[bytes] = []
    for raw_event in iter_event_bytes(data):
        logical_events.extend(split_logical_events_on_subevent_reset(raw_event))
        if len(logical_events) >= limit:
            break
    return logical_events[:limit]


def main() -> None:
    events = load_logical_events(TARGET_FILE, NUM_EVENTS)
    if len(events) < NUM_EVENTS:
        raise ValueError(f"Only found {len(events)} logical events in {TARGET_FILE}.")

    profiler = cProfile.Profile()
    t1 = perf_counter()
    profiler.enable()
    parsed_events = [Event(i + 1, event_bytes) for i, event_bytes in enumerate(events)]
    profiler.disable()
    t2 = perf_counter()

    print(f"Profiled {len(parsed_events)} Event() initializations from {TARGET_FILE}")
    print(f"Elapsed wall time: {t2 - t1:.2f} seconds")

    stats_buffer = io.StringIO()
    stats = pstats.Stats(profiler, stream=stats_buffer).sort_stats("cumtime")
    stats.print_stats(TOP_N)
    print(stats_buffer.getvalue())


if __name__ == "__main__":
    main()
