from pathlib import Path
from typing import TypedDict

from .bar import BarDefinitions
from theme.typedefs.color import Colors
from theme.typedefs.font import FontDefinitions

PropertyDefinitions = dict[str, str | int]


class Theme(TypedDict):
    bar: BarDefinitions
    color: Colors
    extension: PropertyDefinitions
    font: FontDefinitions
    layout: PropertyDefinitions
    logo: str
    path: Path | None
    widget: PropertyDefinitions
