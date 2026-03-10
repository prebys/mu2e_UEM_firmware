"""Shared utilities for parsing events and timestamps from the .dat hex stream.

This module centralizes the event-finding regex and the timestamp extraction logic so other
modules (hex_check, hex_check_classes, large_file_operations) can share the implementation.
"""
from __future__ import annotations

import re
import struct
from datetime import datetime, timezone
from typing import Iterator, Optional, Tuple
from zoneinfo import ZoneInfo

# Event regex copied from previous duplications in the repo (kept synchronized).
# Important: end-of-sub-event is "...00fcfcfc" while end-of-event is
# "...00fcfcfcfcfcfcfc". Requiring the full event trailer prevents matching each
# sub-event as if it were a whole event.
EVENT_RE = re.compile(
    r'(?:ffffff11[0-9a-f]{16})?'  # optional timestamp packet
    r'ffffffff00fffffff4f3f2f1'   # event header
    r'.*?edededed00fcfcfcfcfcfcfc',  # full event trailer
    re.DOTALL,
)

SUBEVENT_RE = re.compile(
    r'00ffffff'
    r'f4f3f2f1'
    r'.*?'
    r'edededed'
    r'00fcfcfc',
    re.DOTALL,
)


def iter_event_matches(hex_str: str) -> Iterator[re.Match]:
    """Yield successive regex Match objects for events found in `hex_str`."""
    yield from EVENT_RE.finditer(hex_str)


def iter_event_hex_strings(hex_str: str) -> Iterator[str]:
    """Yield the matched hex substring for each event."""
    for m in iter_event_matches(hex_str):
        yield m.group()


def _decode_le_u32(hex_word: str) -> int:
    """Decode an 8-char little-endian hex word to an unsigned integer."""
    return struct.unpack("<I", bytes.fromhex(hex_word))[0]


def _safe_tz(tz_name: str):
    """Resolve an IANA timezone, falling back to UTC if tzdata is unavailable."""
    try:
        return ZoneInfo(tz_name)
    except Exception:
        return timezone.utc


def parse_timestamp_and_strip(event_hex: str, tz_name: str = "America/Chicago") -> Tuple[Optional[datetime], str]:
    """If `event_hex` starts with the optional timestamp packet ("ffffff11" followed by 16 hex
    chars), parse the 8-byte microsecond timestamp and return a tuple (timestamp, stripped_hex).

    If no valid timestamp is present, returns (None, event_hex) unchanged.
    """
    if event_hex.startswith('ffffff11') and len(event_hex) >= 24:
        try:
            us = int(event_hex[8:24], 16)
            ts = datetime.fromtimestamp(us / 1e6, tz=_safe_tz(tz_name))
            stripped = event_hex[24:]
            return ts, stripped
        except Exception:
            return None, event_hex
    return None, event_hex


def split_logical_events_on_subevent_reset(event_hex: str) -> list[str]:
    """Split one regex-matched event into multiple logical events if subevent numbering resets.

    Some captures contain a second event body that starts at a new subevent sequence without a
    fresh `ffffffff` event marker. When the decoded subevent number decreases, start a new
    synthetic event at that subevent boundary.
    """
    timestamp, payload = parse_timestamp_and_strip(event_hex)
    timestamp_prefix = event_hex[:24] if timestamp is not None and event_hex.startswith("ffffff11") else ""

    if not payload.startswith("ffffffff"):
        return [event_hex]

    sub_events = SUBEVENT_RE.findall(payload)
    if len(sub_events) < 2:
        return [event_hex]

    groups: list[list[str]] = []
    current_group: list[str] = []
    last_sub_event_number: Optional[int] = None

    for sub_event_hex in sub_events:
        sub_event_number = _decode_le_u32(sub_event_hex[8 * 3:8 * 4])
        if current_group and last_sub_event_number is not None and sub_event_number <= last_sub_event_number:
            groups.append(current_group)
            current_group = []
        current_group.append(sub_event_hex)
        last_sub_event_number = sub_event_number

    if current_group:
        groups.append(current_group)

    if len(groups) == 1:
        return [event_hex]

    logical_events = []
    for i, group in enumerate(groups):
        prefix = "ffffffff"
        if i == 0 and timestamp_prefix:
            prefix = timestamp_prefix + prefix
        logical_events.append(prefix + "".join(group) + "fcfcfcfc")
    return logical_events
