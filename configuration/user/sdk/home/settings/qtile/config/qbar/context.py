from qtile_extras.widget.decorations import PowerLineDecoration  # type: ignore

from theme.defs.theme import ThemeDefinition
from theme.utils import opacity_to_str
from enum import StrEnum


class BarPosition(StrEnum):
    TOP = "top"
    BOTTOM = "bottom"
    LEFT = "left"
    RIGHT = "right"


class BarContext:
    def __init__(
        self,
        position: BarPosition,
        settings: dict,
        theme: ThemeDefinition,
        props: dict | None = None,
    ):
        self.position = position
        self.settings = settings
        self.theme = theme
        self.props = props

        self.height = props.get("height", theme["bar"][self.position]["height"])
        self.margin = props.get("margin", theme["bar"][self.position]["margin"])

        self.text_font_family = props.get(
            "text_font_family", theme["font"]["text"]["family"]
        )
        self.text_font_size = props.get("text_font_size", theme["font"]["text"]["size"])
        self.icon_font_family = props.get(
            "icon_font_family", theme["font"]["icon"]["family"]
        )
        self.icon_font_size = props.get("icon_font_size", theme["font"]["icon"]["size"])
        self.logo_font_family = props.get(
            "logo_font_family", theme["font"]["logo"]["family"]
        )
        self.logo_font_size = props.get("logo_font_size", theme["font"]["logo"]["size"])

        self.background = props.get(
            "background", theme["bar"][self.position]["background"]
        )
        self.opacity = props.get(
            "opacity", theme["bar"][self.position].get("opacity", 1.0)
        )
        self.opacity_str = opacity_to_str(self.opacity)
        self.background_color = f"{self.background}{self.opacity_str}"

        self.powerline_start = theme["bar"][self.position].get("powerline_start", False)
        self.powerline_middle = theme["bar"][self.position].get(
            "powerline_middle", False
        )
        self.powerline_end = theme["bar"][self.position].get("powerline_end", False)

        self.powerline = None
        if "powerline_separator" in theme:
            self.powerline = [
                PowerLineDecoration(path=theme["powerline_separator"][0]),
                PowerLineDecoration(path=theme["powerline_separator"][1]),
            ]

        self.powerline_bg = theme["named_colors"]["powerline_bg"]
