from dataclasses import dataclass
from typing import Optional, Union

from python_analysis.hex_check_config import config

name_to_event: dict[str, "EventType"] = {}


@dataclass(frozen=True, slots=True)
class EventType:
    """Describes an event type (pattern + allowed next event names)."""

    regex_pattern: str
    _next_event_names: tuple[str, ...]
    _name: Optional[str] = None
    _show: bool = False

    @property
    def name(self) -> str:
        if self._name is None:
            raise ValueError("EventType.name not set; pass name=... when constructing EventType")
        return self._name

    @property
    def data_chars(self) -> list[int]:
        try:
            start_index = self.regex_pattern.index(".")
        except ValueError:
            start_index = None
        try:
            end_index = self.regex_pattern.rindex(".") + 1
        except ValueError:
            end_index = None

        if start_index is None and end_index is None:
            return [0, 0]
        return [start_index or 0, end_index or 0]

    @property
    def show(self) -> bool:
        if config.show_all and config.show_nothing:
            raise ValueError("Both show_all and show_nothing are True. Please set one to False.")
        if config.show_all:
            return True
        if config.show_nothing:
            return False
        for show_this_event_name in config.only_show:
            if show_this_event_name in self.name:
                return True
        return self._show

    @property
    def next_event(self) -> list["EventType"]:
        ret = [name_to_event[name] for name in self._next_event_names]

        assert len(ret) == len(self._next_event_names), \
            f"Expected {len(self._next_event_names)} events, got {len(ret)}."

        # move "free" patterns to end (e.g. raw_data = "........")
        for e in list(ret):
            if e.regex_pattern == "........":
                ret.remove(e)
                ret.append(e)
        return ret

    def __repr__(self) -> str:
        return f"<EventType `{self.name}`, regex `{self.regex_pattern}`>"
    
    def __eq__(self, other: Union[str, "EventType"]):
        """Allow comparison of EventType and string event type names.
        For example, begin_event<EventType> == "begin_event"<str> would return True. """
        if isinstance(other, str):
            return self.name == other
        elif isinstance(other, EventType):
            return self.name == other.name
        else:
            raise ValueError("Can only compare an EventType with other EventTypes or strings.")


def _create_event_type(
    regex_pattern: str,
    next_event_names: tuple[str, ...],
    name: Optional[str],
    show: bool = False,
) -> EventType:
    """Create an EventType and register it in name_to_event (if name is not None)."""
    event_type = EventType(regex_pattern, next_event_names, name, show)
    if name is not None:
        name_to_event[name] = event_type
    return event_type


begin_event = _create_event_type(
    regex_pattern="ffffffff",
    next_event_names=("begin_event", "begin_sub_event"),
    name="begin_event",
)

begin_sub_event = _create_event_type(
    regex_pattern="00ffffff",
    next_event_names=("byte_order",),
    name="begin_sub_event",
)

byte_order = _create_event_type(
    regex_pattern="f4f3f2f1",
    next_event_names=("fmc228_number",),
    name="byte_order",
)

fmc228_number = _create_event_type(
    regex_pattern="..ccccfc",
    next_event_names=("sub_event_number_evn",),
    name="fmc228_number",
)

sub_event_number_evn = _create_event_type(
    regex_pattern="........",
    next_event_names=("event_number_evn",),
    name="sub_event_number_evn",
)

event_number_evn = _create_event_type(
    regex_pattern="........",
    next_event_names=("begin_raw_data",),
    name="event_number_evn",
)

begin_raw_data = _create_event_type(
    regex_pattern="fdfdfdfd",
    next_event_names=("byte_order2",),
    name="begin_raw_data",
)

byte_order2 = _create_event_type(
    regex_pattern="f4f3f2f1",
    next_event_names=("event_number_evn2",),
    name="byte_order2",
)

event_number_evn2 = _create_event_type(
    regex_pattern="........",
    next_event_names=("channel_header",),
    name="event_number_evn2",
)

channel_header = _create_event_type(
    regex_pattern="fafa..fa",
    next_event_names=("waveform",),
    name="channel_header",
)

waveform = _create_event_type(
    regex_pattern="ffff....",
    next_event_names=("fragment_trig_mask",),
    name="waveform",
)

fragment_trig_mask = _create_event_type(
    regex_pattern="0000....",
    next_event_names=("stat",),
    name="fragment_trig_mask",
)

stat = _create_event_type(
    regex_pattern="........",
    next_event_names=("status_word",),
    name="stat",
)

status_word = _create_event_type(
    regex_pattern="........",
    next_event_names=("bco_low",),
    name="status_word",
)

bco_low = _create_event_type(
    regex_pattern="........",
    next_event_names=("bco_high",),
    name="bco_low",
)

bco_high = _create_event_type(
    regex_pattern="........",
    next_event_names=("data_length", "end_of_channel", "raw_data"),
    name="bco_high",
)

data_length = _create_event_type(
    regex_pattern="....aaff",
    next_event_names=("end_of_channel", "raw_data"),
    name="data_length",
)

raw_data = _create_event_type(
    regex_pattern="........",
    next_event_names=("end_of_channel", "raw_data"),
    name="raw_data",
)

end_of_channel = _create_event_type(
    regex_pattern="fbfbfbfb",
    next_event_names=("end_raw_data", "channel_header"),
    name="end_of_channel",
)

end_raw_data = _create_event_type(
    regex_pattern="fefefefe",
    next_event_names=("begin_peak_data",),
    name="end_raw_data",
)

begin_peak_data = _create_event_type(
    regex_pattern="efefefef",
    next_event_names=("channel_number",),
    name="begin_peak_data",
)

channel_number = _create_event_type(
    regex_pattern="eeee..ee",
    next_event_names=("peak_finding_header",),
    name="channel_number",
)

peak_finding_header = _create_event_type(
    regex_pattern="aaaaaaaa",
    next_event_names=("peak_height_header",),
    name="peak_finding_header",
)

peak_height_header = _create_event_type(
    regex_pattern="cccccccc",
    next_event_names=("peak_height_end", "peak_height_data_1"),
    name="peak_height_header",
)

peak_height_data_1 = _create_event_type(
    regex_pattern="......[4567].",
    next_event_names=("peak_height_data_2",),
    name="peak_height_data_1",
)

peak_height_data_2 = _create_event_type(
    regex_pattern="....0000",
    next_event_names=("peak_height_end", "peak_height_data_1"),
    name="peak_height_data_2",
)

peak_height_end = _create_event_type(
    regex_pattern="cececece",
    next_event_names=("peak_area_header",),
    name="peak_height_end",
)

peak_area_header = _create_event_type(
    regex_pattern="dddddddd",
    next_event_names=("peak_area_end", "peak_area_data_1"),
    name="peak_area_header",
)

peak_area_data_1 = _create_event_type(
    regex_pattern="....1111",
    next_event_names=("peak_area_data_2",),
    name="peak_area_data_1",
)

peak_area_data_2 = _create_event_type(
    regex_pattern="........",
    next_event_names=("peak_area_data_3",),
    name="peak_area_data_2",
)

peak_area_data_3 = _create_event_type(
    regex_pattern="........",
    next_event_names=("peak_area_data_4",),
    name="peak_area_data_3",
)

peak_area_data_4 = _create_event_type(
    regex_pattern="......0.",
    next_event_names=("peak_area_data_5",),
    name="peak_area_data_4",
)

peak_area_data_5 = _create_event_type(
    regex_pattern="......0.",
    next_event_names=("peak_area_data_6",),
    name="peak_area_data_5",
)

peak_area_data_6 = _create_event_type(
    regex_pattern="......0.",
    next_event_names=("peak_area_end", "peak_area_data_1"),
    name="peak_area_data_6",
)

peak_area_end = _create_event_type(
    regex_pattern="dededede",
    next_event_names=("end_peak_data",),
    name="peak_area_end",
)

end_peak_data = _create_event_type(
    regex_pattern="bbbbbbbb",
    next_event_names=("end_peak_channel",),
    name="end_peak_data",
)

end_peak_channel = _create_event_type(
    regex_pattern="ecececec",
    next_event_names=("end_peak_stream_data", "channel_number"),
    name="end_peak_channel",
)

end_peak_stream_data = _create_event_type(
    regex_pattern="edededed",
    next_event_names=("end_sub_event",),
    name="end_peak_stream_data",
)

end_sub_event = _create_event_type(
    regex_pattern="00fcfcfc",
    next_event_names=("end_event", "begin_sub_event", "begin_event"),
    name="end_sub_event",
)

end_event = _create_event_type(
    regex_pattern="fcfcfcfc",
    next_event_names=("begin_event",),
    name="end_event",
)
