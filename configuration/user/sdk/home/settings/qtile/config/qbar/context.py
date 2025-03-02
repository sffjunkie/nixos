from qtile_extras.widget.decorations import PowerLineDecoration  # type: ignore

from theme.typedefs.theme import ThemeDefinition
from theme.utils import opacity_to_str
from enum import StrEnum


class BarPosition(StrEnum):
    TOP = "top"
    BOTTOM = "bottom"
    LEFT = "left"
    RIGHT = "right"


class BarContext:
    height: int
    margin: tuple[int, int, int, int]
    powerline_start: list[PowerLineDecoration]
    powerline_end: list[PowerLineDecoration]

    text_font_family: str
    text_font_size: int
    icon_font_family: str
    icon_font_size: int
    logo_font_family: str
    logo_font_size: int

    background: str
    opacity: float

    def __init__(
        self,
        position: BarPosition,
        settings: dict,
        theme: ThemeDefinition,
        props: dict = {},
    ):
        self.position = position
        self.settings = settings
        self.theme = theme
        self.props = props

        self.height = props.get("height", theme["bars"][self.position]["height"])
        self.margin = props.get("margin", theme["bars"][self.position]["margin"])

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
            "background",
            theme["bars"][self.position].get(
                "background", theme["named_colors"]["panel_bg"]
            ),
        )
        self.opacity = props.get(
            "opacity", theme["bars"][self.position].get("opacity", 1.0)
        )
        self.opacity_str = opacity_to_str(self.opacity)
        self.background_color = f"{self.background}{self.opacity_str}"

        powerline = theme["bars"][self.position].get("powerline", None)
        if powerline is not None:
            start = powerline.get("start", None)
            if start is not None:
                self.powerline_start = [PowerLineDecoration(path=start)]
                self.powerline_start = []

            if (end := powerline.get("end", None)) is not None:
                self.powerline_end = [PowerLineDecoration(path=end)]
            else:
                self.powerline_end = []

        else:
            self.powerline_start = []
            self.powerline_end = []
