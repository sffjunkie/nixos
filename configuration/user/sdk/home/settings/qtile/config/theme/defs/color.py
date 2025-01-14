from typing import TypedDict, NotRequired


Color = str

Base16ColorDefinitions = dict[str, Color]


class NamedColorDefinitions(TypedDict):
    window_border: NotRequired[Color]
    panel_fg: NotRequired[Color]
    panel_bg: NotRequired[Color]
    group_current_fg: NotRequired[Color]
    group_current_bg: NotRequired[Color]
    group_active_fg: NotRequired[Color]
    group_active_bg: NotRequired[Color]
    group_inactive_fg: NotRequired[Color]
    group_inactive_bg: NotRequired[Color]
    powerline_fg: NotRequired[Color]
    powerline_bg: NotRequired[list[Color]]
