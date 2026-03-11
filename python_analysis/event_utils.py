"""Shared utilities for parsing events and timestamps from the .dat byte stream."""
from __future__ import annotations

from datetime import datetime, timezone
from typing import Iterator, Optional, Tuple
from zoneinfo import ZoneInfo

TIMESTAMP_MARKER = b"\xff\xff\xff\x11"
TIMESTAMP_PACKET_LEN = 12
EVENT_HEADER = b"\xff\xff\xff\xff"
SUBEVENT_START = b"\x00\xff\xff\xff\xf4\xf3\xf2\xf1"
SUBEVENT_END = b"\xed\xed\xed\xed\x00\xfc\xfc\xfc"
EVENT_END = b"\xfc\xfc\xfc\xfc"
FULL_EVENT_TRAILER = SUBEVENT_END + EVENT_END


def iter_event_matches(data: bytes) -> Iterator[tuple[int, int]]:
    """Yield `(start, end)` offsets for events found in `data`."""
    cursor = 0
    data_len = len(data)
    while cursor < data_len:
        start = data.find(EVENT_HEADER, cursor)
        ts_start = data.find(TIMESTAMP_MARKER, cursor)
        if ts_start != -1 and (start == -1 or ts_start <= start) and ts_start + TIMESTAMP_PACKET_LEN <= data_len:
            candidate_header = data.find(EVENT_HEADER, ts_start + TIMESTAMP_PACKET_LEN)
            if candidate_header == ts_start + TIMESTAMP_PACKET_LEN:
                start = ts_start
        if start == -1:
            break

        payload_start = start + (TIMESTAMP_PACKET_LEN if data.startswith(TIMESTAMP_MARKER, start) else 0)
        trailer = data.find(FULL_EVENT_TRAILER, payload_start)
        if trailer == -1:
            break

        end = trailer + len(FULL_EVENT_TRAILER)
        yield start, end
        cursor = end


def iter_event_bytes(data: bytes) -> Iterator[bytes]:
    """Yield each event as a byte string."""
    for start, end in iter_event_matches(data):
        yield data[start:end]


def iter_event_hex_strings(data: bytes) -> Iterator[bytes]:
    """Compatibility wrapper: callers still using the old name now receive event bytes."""
    yield from iter_event_bytes(data)


def _decode_le_u32(word_bytes: bytes) -> int:
    """Decode a 4-byte little-endian word to an unsigned integer."""
    return int.from_bytes(word_bytes, byteorder="little", signed=False)


def _safe_tz(tz_name: str):
    """Resolve an IANA timezone, falling back to UTC if tzdata is unavailable."""
    try:
        return ZoneInfo(tz_name)
    except Exception:
        return timezone.utc


def parse_timestamp_and_strip(event_bytes: bytes,
                              tz_name: str = "America/Chicago") -> Tuple[Optional[datetime], bytes]:
    """Parse and remove the optional timestamp packet at the start of an event."""
    if event_bytes.startswith(TIMESTAMP_MARKER) and len(event_bytes) >= TIMESTAMP_PACKET_LEN:
        try:
            us = int.from_bytes(event_bytes[4:12], byteorder="big", signed=False)
            ts = datetime.fromtimestamp(us / 1e6, tz=_safe_tz(tz_name))
            return ts, event_bytes[12:]
        except Exception:
            return None, event_bytes
    return None, event_bytes


def split_logical_events_on_subevent_reset(event_bytes: bytes) -> list[bytes]:
    """Split one event into multiple logical events if subevent numbering resets."""
    timestamp, payload = parse_timestamp_and_strip(event_bytes)
    timestamp_prefix = event_bytes[:TIMESTAMP_PACKET_LEN] if timestamp is not None and event_bytes.startswith(TIMESTAMP_MARKER) else b""

    if not payload.startswith(EVENT_HEADER):
        return [event_bytes]

    sub_events: list[bytes] = []
    cursor = 4
    while True:
        start = payload.find(SUBEVENT_START, cursor)
        if start == -1:
            break
        end = payload.find(SUBEVENT_END, start)
        if end == -1:
            break
        sub_events.append(payload[start:end + len(SUBEVENT_END)])
        cursor = end + len(SUBEVENT_END)

    if len(sub_events) < 2:
        return [event_bytes]

    groups: list[list[bytes]] = []
    current_group: list[bytes] = []
    last_sub_event_number: Optional[int] = None

    for sub_event_bytes in sub_events:
        sub_event_number = _decode_le_u32(sub_event_bytes[12:16])
        if current_group and last_sub_event_number is not None and sub_event_number <= last_sub_event_number:
            groups.append(current_group)
            current_group = []
        current_group.append(sub_event_bytes)
        last_sub_event_number = sub_event_number

    if current_group:
        groups.append(current_group)

    if len(groups) == 1:
        return [event_bytes]

    logical_events: list[bytes] = []
    for i, group in enumerate(groups):
        prefix = EVENT_HEADER
        if i == 0 and timestamp_prefix:
            prefix = timestamp_prefix + prefix
        logical_events.append(prefix + b"".join(group) + EVENT_END)
    return logical_events
