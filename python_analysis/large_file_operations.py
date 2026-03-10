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
from datetime import datetime, timezone
from typing import Optional, List

from python_analysis.dat_io import find_data_file, read_data_file
from python_analysis.event_utils import iter_event_hex_strings, parse_timestamp_and_strip, iter_event_matches, _safe_tz

# USER CONFIGURATION ---------------------------------------------------------
# Edit these variables directly in the file before running in PyCharm.
# - Set DESIRED_FILE_PATH to a substring or filename to choose a specific .dat file.
# - Set SAMPLES to the number of uniformly-spaced events to sample/print.
# - Set TO_USE_INDEX_INCREMENT to pick older files (matches find_data_file semantics).
DESIRED_FILE_PATH: Optional[str] = "data_20260303_134443_2026.03.03_18.01.32.dat"
DESIRED_FILE_PATH: Optional[str] = "data_20260303_134443.dat"
SAMPLES: int = 200
TO_USE_INDEX_INCREMENT: int = 0

# Split datetime
# Use Chicago timezone here
SPLIT_DATETIME: Optional[datetime] = datetime(2026, 3, 3, 23, 59,
                                              tzinfo=_safe_tz("America/Chicago"))

# ---------------------------------------------------------------------------

def _read_hex_string_for_file(desired_file_path: Optional[str] = None,
                              to_use_index_increment: int = 0) -> tuple[str, datetime, List[str]]:
    """Find and read a .dat file and return a single hex string representing the binary payload,
    the file creation date, and headers list.

    Uses existing dat_io helpers to select a file when `desired_file_path` is None.
    """
    dir_name = os.path.dirname(os.path.realpath(__file__))
    file_name = find_data_file(desired_file_path, to_use_index_increment)
    hex_list, file_creation_date, headers = read_data_file(dir_name, file_name)
    hex_str = ''.join(hex_list)
    return hex_str, file_creation_date, headers


def extract_event_timestamps_from_hex(hex_str: str) -> List[Optional[datetime]]:
    """Scan the provided hex string for events and return a list of timestamps or None for each
    event found.

    Uses the shared `parse_timestamp_and_strip` helper to parse and strip timestamps.
    """
    out: List[Optional[datetime]] = []
    for event_hex in iter_event_hex_strings(hex_str):
        ts, _ = parse_timestamp_and_strip(event_hex)
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
    hex_str, creation_date, headers = _read_hex_string_for_file(desired_file_path, to_use_index_increment)
    timestamps = extract_event_timestamps_from_hex(hex_str)
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


def _write_dat_file(data_dir: str, filename: str, headers: List[str], hex_payload: str) -> str:
    """Write headers and binary payload (hex string) to a .dat file in data_dir. Returns full path."""
    path = os.path.join(data_dir, filename)
    # ensure directory exists
    os.makedirs(data_dir, exist_ok=True)
    with open(path, 'wb') as f:
        # write headers followed by newline
        for h in headers:
            # headers in read_data_file were stored without trailing newline
            f.write((h + '\n').encode('utf-8'))
        # write binary payload
        if hex_payload:
            f.write(bytes.fromhex(hex_payload))
    return path


def split_dat_file_by_event(desired_file_path: Optional[str] = None,
                            split_event: int = 1000,
                            to_use_index_increment: int = 0,
                            out_dir: Optional[str] = None) -> tuple[str, str]:
    """Split a .dat file into two files at event index `split_event` (1-based).

    - `split_event` is 1-based: split_event=1 means first file contains first event, second contains remainder.
    - The function copies the textual headers to both output files.
    - The later file will have its filename include the timestamp of its first event (if present), formatted
      as YYYY.MM.DD_HH.MM.SS; if that event has no timestamp the original file creation date is used.

    Returns (first_path, second_path).
    """
    # locate original file and read
    dir_name = os.path.dirname(os.path.realpath(__file__))
    data_dir = os.path.join(dir_name, "..", "socketudp", "data")
    file_name = find_data_file(desired_file_path, to_use_index_increment)
    hex_list, file_creation_date, headers = read_data_file(dir_name, file_name)
    hex_str = ''.join(hex_list)

    matches = list(iter_event_matches(hex_str))
    n_events = len(matches)
    if n_events == 0:
        raise ValueError("No events found in source file.")
    if not (1 <= split_event < n_events):
        raise ValueError(f"split_event must be between 1 and {n_events-1} (got {split_event}).")

    # reconstruct payloads: include any pre-event bytes only in first file, include any trailing bytes after last event in second file
    pre_event = hex_str[:matches[0].start()]
    trailing = hex_str[matches[-1].end():]
    first_parts = [m.group() for m in matches[:split_event]]
    second_parts = [m.group() for m in matches[split_event:]]

    first_hex = pre_event + ''.join(first_parts)
    second_hex = ''.join(second_parts) + trailing

    # determine filenames
    base, ext = os.path.splitext(file_name)
    first_desired = f"{base}_part1{ext}"

    # name second file using timestamp of its first event if present
    ts, _ = parse_timestamp_and_strip(second_parts[0])
    if ts is None:
        date_str = file_creation_date.strftime('%Y.%m.%d_%H.%M.%S')
    else:
        date_str = ts.strftime('%Y.%m.%d_%H.%M.%S')
    second_desired = f"{base}_{date_str}{ext}"

    out_dir = out_dir or data_dir
    first_name = _unique_filename(out_dir, first_desired)
    second_name = _unique_filename(out_dir, second_desired)

    first_path = _write_dat_file(out_dir, first_name, headers, first_hex)
    second_path = _write_dat_file(out_dir, second_name, headers, second_hex)

    print(f"Wrote first file with {split_event} events: {first_path}")
    print(f"Wrote second file with {n_events - split_event} events: {second_path}")
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
    hex_list, file_creation_date, headers = read_data_file(dir_name, file_name)
    hex_str = ''.join(hex_list)

    matches = list(iter_event_matches(hex_str))
    if not matches:
        raise ValueError("No events found in source file.")

    from python_analysis.event_utils import parse_timestamp_and_strip
    split_index = None
    for i, m in enumerate(matches):
        ts, _ = parse_timestamp_and_strip(m.group())
        if ts is not None and ts >= split_dt:
            split_index = i
            break
    if split_index is None:
        raise ValueError("No event with timestamp >= split_dt found.")

    # use the same event-based splitting logic
    return split_dat_file_by_event(desired_file_path=desired_file_path,
                                   split_event=split_index,
                                   to_use_index_increment=to_use_index_increment,
                                   out_dir=out_dir)


# Replace CLI usage with a simple main() that uses the module-level configuration above.
def main() -> None:
    """Run sampling using the module-level configuration variables so settings are editable in PyCharm."""
    mode = 2

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
    else:
        raise ValueError(f"Invalid mode {mode} in main().")


if __name__ == "__main__":
    # When run directly, use the file-level config variables instead of a CLI.
    main()