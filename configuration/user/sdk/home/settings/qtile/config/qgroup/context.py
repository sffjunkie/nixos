from enum import StrEnum

from theme.defs.theme import ThemeDefinition
from qbar.context import BarContext
from theme.utils import opacity_to_str


class GroupPosition(StrEnum):
    START = "start"
    MIDDLE = "middle"
    END = "end"


class GroupContext:
    def __init__(
        self,
        position: GroupPosition,
        bar: BarContext,
        settings: dict,
        theme: ThemeDefinition,
        props: dict | None = None,
    ):
        self.position = position
        self.bar = bar
        self.settings = settings
        self.theme = theme
        self.props = props

        self.text_font_family = props.get("text_font_family", bar.text_font_family)
        self.text_font_size = props.get("text_font_size", bar.text_font_size)
        self.icon_font_family = props.get("icon_font_family", bar.icon_font_family)
        self.icon_font_size = props.get("icon_font_size", bar.icon_font_size)
        self.logo_font_family = props.get("logo_font_family", bar.logo_font_family)
        self.logo_font_size = props.get("logo_font_size", bar.logo_font_size)

        self.opacity = props.get("opacity", self.context.bar.opacity)
        self.opacity_str = opacity_to_str(self.opacity)
        self.background_color = self.context.props.get(
            "background", self.context.bar.background_color
        )
        self.background = f"{self.background_color}{self.opacity_str}"

    def merge_parameters(self, base, overrides):
        cfg = base.copy()
        if overrides is not None:
            cfg.update(overrides)
        return cfg
