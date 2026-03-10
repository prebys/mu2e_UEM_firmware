"""Shared utilities for parsing events and timestamps from the .dat hex stream.

This module centralizes the event-finding regex and the timestamp extraction logic so other
modules (hex_check, hex_check_classes, large_file_operations) can share the implementation.
"""
from __future__ import annotations

import re
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


def iter_event_matches(hex_str: str) -> Iterator[re.Match]:
    """Yield successive regex Match objects for events found in `hex_str`."""
    yield from EVENT_RE.finditer(hex_str)


def iter_event_hex_strings(hex_str: str) -> Iterator[str]:
    """Yield the matched hex substring for each event."""
    for m in iter_event_matches(hex_str):
        yield m.group()


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