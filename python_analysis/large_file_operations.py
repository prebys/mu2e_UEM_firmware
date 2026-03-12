"""
Tools for operating on large .dat hex data files.

Primary functions:
- sample_event_timestamps(desired_file_path=None, samples=20):
    Find a data file (or use provided filename), read it, locate events, and print a small
    uniformly-spaced sample of events showing their approximate index and timestamp (if present).

This module intentionally uses the same event-finding regex as `hex_check.HexCheck` so the
sampled indices map roughly to the events that will be parsed later. It focuses on light-weight
inspection (timestamps + approximate offsets) and avoids constructing the full Event objects,
so it remains reasonably fast on large files.

Configuration
- Edit the variables under "USER CONFIGURATION" to run interactively from PyCharm (no CLI required).
"""

from __future__ import annotations

import logging
import os
import re
from datetime import datetime, timezone
from typing import Optional, List

from python_analysis.dat_io import find_data_file, read_data_file
from python_analysis.event_utils import (
    iter_event_bytes,
    parse_timestamp_and_strip,
    split_logical_events_on_subevent_reset,
    _safe_tz,
)

# USER CONFIGURATION ---------------------------------------------------------
# Edit these variables directly in the file before running in PyCharm.
# - Set DESIRED_FILE_PATH to a substring or filename to choose a specific .dat file.
# - Set SAMPLES to the number of uniformly-spaced events to sample/print.
# - Set TO_USE_INDEX_INCREMENT to pick older files (matches find_data_file semantics).
DESIRED_FILE_PATH: Optional[str] = "data_20260303_134443_2026.03.04_16.53.41.dat"
# DESIRED_FILE_PATH: Optional[str] = "data_20260303_134443.dat"
SAMPLES: int = 200
TO_USE_INDEX_INCREMENT: int = 0

# Split datetime
# Use Chicago timezone here
SPLIT_DATETIME: Optional[datetime] = datetime(2026, 3, 3, 23, 59,
                                              tzinfo=_safe_tz("America/Chicago"))

# ---------------------------------------------------------------------------

def _read_bytes_for_file(desired_file_path: Optional[str] = None,
                         to_use_index_increment: int = 0) -> tuple[bytes, datetime, List[str]]:
    """Find and read a .dat file and return the binary payload,
    the file creation date, and headers list.

    Uses existing dat_io helpers to select a file when `desired_file_path` is None.
    """
    dir_name = os.path.dirname(os.path.realpath(__file__))
    file_name = find_data_file(desired_file_path, to_use_index_increment)
    payload, file_creation_date, headers = read_data_file(dir_name, file_name)
    return payload, file_creation_date, headers


def extract_event_timestamps_from_bytes(data: bytes) -> List[Optional[datetime]]:
    """Scan the provided byte payload for events and return a list of timestamps or None for each
    event found.

    Uses the shared `parse_timestamp_and_strip` helper to parse and strip timestamps.
    """
    out: List[Optional[datetime]] = []
    for event_bytes in iter_event_bytes(data):
        ts, _ = parse_timestamp_and_strip(event_bytes)
        out.append(ts)
    return out


def sample_event_timestamps(desired_file_path: Optional[str] = None,
                            samples: int = 20,
                            to_use_index_increment: int = 0) -> None:
    """Find a .dat file (or use provided path), scan for events and print a small uniform sample.

    Prints lines of the form:
      Sample 1/10 -> event 1 of 2345: 2026-02-16T16:10:12-06:00
    or
      Sample 2/10 -> event 500 of 2345: <no timestamp>

    Arguments:
      desired_file_path: optional substring or filename to select a specific .dat file (same
                         semantics as `dat_io.find_data_file`).
      samples: how many sampled events to print (will be clamped to number of events found).
      to_use_index_increment: passed through to `find_data_file` to select older files.
    """
    print(f"Scanning for events in file (matching '{desired_file_path or ''}')...")
    data, creation_date, headers = _read_bytes_for_file(desired_file_path, to_use_index_increment)
    timestamps = extract_event_timestamps_from_bytes(data)
    n_events = len(timestamps)
    if n_events == 0:
        print("No events found in file.")
        return

    samples = max(1, int(samples))
    if samples > n_events:
        samples = n_events

    # choose indices evenly spaced across 0..n_events-1
    if samples == 1:
        chosen = [0]
    else:
        chosen = [int(round(i * (n_events - 1) / (samples - 1))) for i in range(samples)]

    print(f"Found {n_events} events in file created {creation_date.isoformat()} with {len(headers)} headers.")
    for i, idx in enumerate(chosen):
        ts = timestamps[idx]
        ts_str = ts.isoformat() if ts is not None else "<no timestamp>"
        print(f"Sample {i+1}/{samples} -> event {idx+1} of {n_events}: {ts_str}")


def _unique_filename(directory: str, desired_name: str) -> str:
    """Return a filename that does not yet exist in directory by adding _1, _2 suffixes as needed."""
    base, ext = os.path.splitext(desired_name)
    candidate = desired_name
    i = 1
    while os.path.exists(os.path.join(directory, candidate)):
        candidate = f"{base}_{i}{ext}"
        i += 1
    return candidate


def _base_name_through_capture_datetime(file_name: str) -> str:
    """Keep filename content only through the first data_YYYYMMDD_HHMMSS-style capture datetime."""
    base, _ = os.path.splitext(file_name)
    match = re.match(r"^(.*?\d{8}_\d{6})", base)
    if match:
        return match.group(1)
    return base


def _timestamp_for_output_name(first_event_bytes: bytes, fallback_dt: datetime) -> str:
    """Format the first event timestamp for an output filename, falling back to file creation time."""
    ts, _ = parse_timestamp_and_strip(first_event_bytes)
    if ts is None:
        ts = fallback_dt
    return ts.strftime('%Y.%m.%d_%H.%M.%S')


def _collect_nonempty_logical_events(data: bytes) -> list[bytes]:
    """Split raw events into logical events and drop ones that contain no raw/peak data."""
    from python_analysis.hex_check_classes import Event

    logical_events: list[bytes] = []
    skipped_empty = 0
    for raw_event_idx, raw_event_bytes in enumerate(iter_event_bytes(data), start=1):
        for logical_event_bytes in split_logical_events_on_subevent_reset(raw_event_bytes):
            event = Event(raw_event_idx, logical_event_bytes, verbosity=logging.INFO)
            if event.empty_event:
                skipped_empty += 1
                continue
            logical_events.append(logical_event_bytes)

    if skipped_empty:
        print(f"Skipped {skipped_empty} empty logical events while splitting.")
    return logical_events


def _write_dat_file(data_dir: str, filename: str, headers: List[str], payload: bytes) -> str:
    """Write headers and binary payload to a .dat file in data_dir. Returns full path."""
    path = os.path.join(data_dir, filename)
    # ensure directory exists
    os.makedirs(data_dir, exist_ok=True)
    with open(path, 'wb') as f:
        # write headers followed by newline
        for h in headers:
            # headers in read_data_file were stored without trailing newline
            f.write((h + '\n').encode('utf-8'))
        if payload:
            f.write(payload)
    return path


def split_dat_file_by_event(desired_file_path: Optional[str] = None,
                            split_event: int = 1000,
                            to_use_index_increment: int = 0,
                            out_dir: Optional[str] = None) -> tuple[str, str]:
    """Split a .dat file into two files at non-empty logical event index `split_event` (1-based).

    - `split_event` is 1-based: split_event=1 means first file contains first non-empty logical event,
      second contains the remainder.
    - The function copies the textual headers to both output files.
    - Raw regex events are first split on subevent-number resets, then empty logical events are removed.

    Returns (first_path, second_path).
    """
    # locate original file and read
    dir_name = os.path.dirname(os.path.realpath(__file__))
    data_dir = os.path.join(dir_name, "..", "socketudp", "data")
    file_name = find_data_file(desired_file_path, to_use_index_increment)
    print(f"[1/4] Loading source file {file_name}...")
    data, file_creation_date, headers = read_data_file(dir_name, file_name)

    print("[2/4] Collecting non-empty logical events...")
    events = _collect_nonempty_logical_events(data)
    n_events = len(events)
    if n_events == 0:
        raise ValueError("No non-empty logical events found in source file.")
    if not (1 <= split_event < n_events):
        raise ValueError(f"split_event must be between 1 and {n_events-1} (got {split_event}).")

    first_parts = events[:split_event]
    second_parts = events[split_event:]

    first_hex = b''.join(first_parts)
    second_hex = b''.join(second_parts)
    print(f"[3/4] Split at event {split_event} of {n_events}. Building output payloads...")

    # determine filenames from the original capture stem plus the first event timestamp in each output
    base_stem = _base_name_through_capture_datetime(file_name)
    _, ext = os.path.splitext(file_name)
    first_date_str = _timestamp_for_output_name(first_parts[0], file_creation_date)
    second_date_str = _timestamp_for_output_name(second_parts[0], file_creation_date)
    first_desired = f"{base_stem}_{first_date_str}{ext}"
    second_desired = f"{base_stem}_{second_date_str}{ext}"

    out_dir = out_dir or data_dir
    first_name = _unique_filename(out_dir, first_desired)
    second_name = _unique_filename(out_dir, second_desired)

    first_path = _write_dat_file(out_dir, first_name, headers, first_hex)
    second_path = _write_dat_file(out_dir, second_name, headers, second_hex)
    print("[4/4] Finished writing split files.")

    print(f"Wrote first file with {split_event} non-empty logical events: {first_path}")
    print(f"Wrote second file with {n_events - split_event} non-empty logical events: {second_path}")
    return first_path, second_path


def split_dat_file_by_datetime(desired_file_path: Optional[str] = None,
                               split_dt: datetime = None,
                               to_use_index_increment: int = 0,
                               out_dir: Optional[str] = None) -> tuple[str, str]:
    """Split a .dat file into two files at the first event with timestamp >= split_dt.

    If an event has no timestamp, it's considered to not satisfy the >= check.
    Returns (first_path, second_path) similarly to split_dat_file_by_event.
    """
    if split_dt is None:
        raise ValueError("split_dt must be provided for datetime splitting.")

    dir_name = os.path.dirname(os.path.realpath(__file__))
    data_dir = os.path.join(dir_name, "..", "socketudp", "data")
    file_name = find_data_file(desired_file_path, to_use_index_increment)
    print(f"[1/4] Loading source file {file_name}...")
    data, file_creation_date, headers = read_data_file(dir_name, file_name)

    print("[2/4] Collecting non-empty logical events...")
    events = _collect_nonempty_logical_events(data)
    if not events:
        raise ValueError("No non-empty logical events found in source file.")

    print(f"[3/4] Searching for first event at or after {split_dt.isoformat()}...")
    split_index = None
    for i, event_bytes in enumerate(events):
        ts, _ = parse_timestamp_and_strip(event_bytes)
        if ts is not None and ts >= split_dt:
            split_index = i
            break
    if split_index is None:
        raise ValueError("No event with timestamp >= split_dt found.")

    print(f"[4/4] Found split point at event index {split_index}. Delegating to event-based split...")
    # use the same event-based splitting logic
    return split_dat_file_by_event(desired_file_path=desired_file_path,
                                   split_event=split_index,
                                   to_use_index_increment=to_use_index_increment,
                                   out_dir=out_dir)


# Replace CLI usage with a simple main() that uses the module-level configuration above.
def main() -> None:
    """Run sampling using the module-level configuration variables so settings are editable in PyCharm."""
    mode = 1

    if mode == 1:
        sample_event_timestamps(desired_file_path=DESIRED_FILE_PATH,
                                samples=SAMPLES,
                                to_use_index_increment=TO_USE_INDEX_INCREMENT)
    elif mode == 2:
        split_dat_file_by_datetime(
            desired_file_path=DESIRED_FILE_PATH,
            split_dt=SPLIT_DATETIME,
            to_use_index_increment=TO_USE_INDEX_INCREMENT,
            out_dir=None
        )
    elif mode == 3:
        split_dat_file_by_event(
            desired_file_path=DESIRED_FILE_PATH,
            split_event=337,
            to_use_index_increment=TO_USE_INDEX_INCREMENT,
            out_dir=None
        )
    else:
        raise ValueError(f"Invalid mode {mode} in main().")


if __name__ == "__main__":
    # When run directly, use the file-level config variables instead of a CLI.
    main()