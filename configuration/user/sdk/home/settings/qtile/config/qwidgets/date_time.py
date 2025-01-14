from qtile_extras import widget

from qwidgets.icon import MDIcon
from qwidgets.widget_group import WidgetGroup
from theme._types import ThemeDefinition


class DateTime(WidgetGroup):
    def __init__(self, theme: ThemeDefinition) -> None:
        super.__init__(theme)

    def widgets(self, **config) -> list[widget]:
        bar_height = config["bar_height"] or self.theme["bar"]["top"]["height"]
        color_scheme = self.theme["named_colors"]

        return [
            widget.Clock(
                format="%a %Y-%m-%d",
                font=self.text_font_family(config),
                fontsize=self.text_font_size(config),
                background=f"{color_scheme['powerline_bg'][0]}{self.opacity_str}",
            ),
            # calendar symbol
            MDIcon(
                name="calendar",
                font=self.icon_font_family(config),
                fontsize=self.icon_font_size(config),
                background=f"{color_scheme['powerline_bg'][0]}{self.opacity_str}",
                width=bar_height,
            ),
            widget.Sep(
                padding=6,
                linewidth=0,
                background=f"{color_scheme['powerline_bg'][0]}{self.opacity_str}",
            ),
            widget.Clock(
                format="%H:%M",
                font=self.text_font_family(config),
                fontsize=self.text_font_size(config),
                background=f"{color_scheme['powerline_bg'][0]}{self.opacity_str}",
            ),
            # clock symbol
            MDIcon(
                name="clock",
                width=bar_height,
                font=self.icon_font_family(config),
                fontsize=self.icon_font_size(config),
                background=f"{color_scheme['powerline_bg'][0]}{self.opacity_str}",
            ),
        ]
