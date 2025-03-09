from pathlib import Path
from typing import TypedDict

from .bar import BarDefinitions
from theme.typedefs.color import Base16ColorDefinitions, NamedColorDefinitions
from theme.typedefs.font import FontDefinitions

PropertyDefinitions = dict[str, str | int]


class Theme(TypedDict):
    path: Path | None
    bars: BarDefinitions
    base16_colors: Base16ColorDefinitions
    extension: PropertyDefinitions
    font: FontDefinitions
    layout: PropertyDefinitions
    logo: str
    named_colors: NamedColorDefinitions
    widget: PropertyDefinitions
