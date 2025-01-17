from typing import TypedDict

from theme.defs.bar import BarDefinitions
from theme.defs.color import Base16ColorDefinitions, NamedColorDefinitions
from theme.defs.font import FontDefinitions

PropertyDefinitions = dict[str, str | int]


class ThemeDefinition(TypedDict):
    bars: BarDefinitions
    base16_colors: Base16ColorDefinitions
    extension: PropertyDefinitions
    font: FontDefinitions
    layout: PropertyDefinitions
    logo: str
    named_colors: NamedColorDefinitions
    powerline_start: bool
    powerline_middle: bool
    powerline_end: bool
    powerline_color_repeat: PropertyDefinitions
    powerline_separator: list[str]
    widget: PropertyDefinitions
