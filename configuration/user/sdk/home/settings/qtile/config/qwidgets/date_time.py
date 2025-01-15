from qtile_extras import widget  # type: ignore

from qwidgets.icon import MDIcon
from qbar.widget_group import WidgetGroup
from theme.defs.theme import ThemeDefinition
from qbar.position import GroupPosition
from qbar.bar import Bar


class DateTime(WidgetGroup):
    def __init__(
        self,
        bar: Bar,
        position: GroupPosition,
        theme: ThemeDefinition,
        config: dict | None = None,
    ) -> None:
        super.__init__(bar, position, theme, config)

    def widgets(self, **config) -> list[widget]:
        bar_height = config["bar_height"] or self.theme["bar"]["top"]["height"]
        color_scheme = self.theme["named_colors"]

        date_text_props = {
            "format": "%a %Y-%m-%d",
            "font": self.text_font_family(config),
            "fontsize": self.text_font_size(config),
            "background": f"{color_scheme['powerline_bg'][0]}{self.opacity_str}",
        }
        date_text = widget.Textbox(**self._merge_parameters(config, date_text_props))

        date_icon_props = {
            "name": "calendar",
            "font": self.icon_font_family(config),
            "fontsize": self.icon_font_size(config),
            "background": f"{color_scheme['powerline_bg'][0]}{self.opacity_str}",
            "width": bar_height,
        }
        date_icon = MDIcon(**self._merge_parameters(config, date_icon_props))

        separator_props = {
            "padding": 6,
            "linewidth": 0,
            "background": f"{color_scheme['powerline_bg'][0]}{self.opacity_str}",
        }
        separator = widget.Sep(**self._merge_parameters(config, separator_props))

        time_text_props = {
            "format": "%a %Y-%m-%d",
            "font": self.text_font_family(config),
            "fontsize": self.text_font_size(config),
            "background": f"{color_scheme['powerline_bg'][0]}{self.opacity_str}",
        }
        time_text = widget.Textbox(**self._merge_parameters(config, time_text_props))

        time_icon_props = {
            "name": "calendar",
            "font": self.icon_font_family(config),
            "fontsize": self.icon_font_size(config),
            "background": f"{color_scheme['powerline_bg'][0]}{self.opacity_str}",
            "width": bar_height,
        }
        time_icon = MDIcon(**self._merge_parameters(config, time_icon_props))

        return [date_text, date_icon, separator, time_text, time_icon]
