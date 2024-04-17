from typing import TypedDict, NotRequired

Color = str

Base16Colors = dict[str, Color]

Properties = dict[str, str | int]


class NamedColors(TypedDict):
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


FontType = str


class FontInfo(TypedDict):
    family: str
    size: int


Fonts = dict[FontType, FontInfo]


BarName = str


class Bar(TypedDict):
    height: int
    opacity: float
    margin: tuple[int, int, int, int]


Bars = dict[BarName, Bar]


class Theme(TypedDict):
    base16_colors: Base16Colors
    named_colors: NamedColors
    font: Fonts
    logo: str
    bar: Bars
    widget: Properties
    extension: Properties
    layout: Properties
    powerline_separator: list[str]
    powerline_color_repeat: Properties
