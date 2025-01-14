from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration
from libqtile.bar import Bar as QtileBar

from qbar.location import BarLocation
from theme.defs import ThemeDefinition
from theme.utils import opacity_to_str


class Bar:
    def __init__(self, location: BarLocation, theme: ThemeDefinition):
        self.location = location
        self.theme = theme

    @property
    def theme(self):
        return self._theme

    @theme.setter
    def theme(self, value):
        self._theme = value
        self.color_scheme = value["named_colors"]
        self.height = value["bar"][self.location]["height"]
        self.margin = value["bar"][self.location]["margin"]

        opacity = value["bar"][self.location].get("opacity", 1.0)
        self.opacity_str = opacity_to_str(opacity)

        self.powerline_right = {
            "decorations": [
                PowerLineDecoration(path=value["powerline_separator"][0]),
            ]
        }

        self.powerline_left = {
            "decorations": [
                PowerLineDecoration(path=value["powerline_separator"][1]),
            ]
        }

    def build(self, widgets: list[widget]) -> QtileBar:
        return QtileBar(
            widgets,
            size=self.height,
            margin=self.margin,
            background=f"{self.color_scheme['panel_bg']}{self.opacity_str}",
        )
