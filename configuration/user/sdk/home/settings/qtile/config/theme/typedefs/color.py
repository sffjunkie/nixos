from typing import TypedDict, NotRequired


Color = str


class Base16ColorDefinitions(TypedDict):
    base00: str
    base01: str
    base02: str
    base03: str
    base04: str
    base05: str
    base06: str
    base07: str
    base08: str
    base09: str
    base0A: str
    base0B: str
    base0C: str
    base0D: str
    base0E: str
    base0F: str


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
    powerline_bg: NotRequired[list[str]]
    foreground_dark: NotRequired[Color]
    foreground_light: NotRequired[Color]
