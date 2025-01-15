from qtile_extras import widget  # type: ignore
from qtile_extras.widget.decorations import PowerLineDecoration  # type: ignore
from libqtile.bar import Bar as QtileBar  # type: ignore

from qbar.position import BarPosition, GroupPosition
from theme.defs import ThemeDefinition
from theme.utils import opacity_to_str


class Bar:
    def __init__(self, position: BarPosition, theme: ThemeDefinition):
        self.position = position
        self.theme = theme

        self.powerline_start = False
        self.powerline_middle = False
        self.powerline_end = False

    @property
    def theme(self):
        return self._theme

    @theme.setter
    def theme(self, value):
        self._theme = value

        self.color_scheme = self._theme["named_colors"]
        self.height = self._theme["bar"][self.position]["height"]
        self.margin = self._theme["bar"][self.position]["margin"]

        opacity = self._theme["bar"][self.position].get("opacity", 1.0)
        self.opacity_str = opacity_to_str(opacity)

        self.powerline_start = None
        self.powerline_end = None

        self.powerline = None
        if "powerline_separator" in self._theme:
            self.powerline = [
                PowerLineDecoration(path=self._theme["powerline_separator"][0]),
                PowerLineDecoration(path=self._theme["powerline_separator"][1]),
            ]

    def build(self, widgets: list[widget.base._Widget]) -> QtileBar:
        return QtileBar(
            widgets,
            size=self.height,
            margin=self.margin,
            background=f"{self.color_scheme['panel_bg']}{self.opacity_str}",
        )
