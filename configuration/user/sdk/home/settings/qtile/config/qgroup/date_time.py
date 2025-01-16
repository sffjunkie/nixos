from qtile_extras import widget  # type: ignore

from qwidget.icon import MDIcon
from qgroup.widget_group import WidgetGroup
from theme.defs.theme import ThemeDefinition


class DateTime(WidgetGroup):
    def __init__(
        self,
        settings: dict | None = None,
        theme: ThemeDefinition | None = None,
        props: dict | None = None,
    ):
        super().__init__(settings, theme)
        self.props = props

    def widgets(self, **config) -> list[widget]:
        bar_height = config["bar_height"] or self.theme["bar"]["top"]["height"]
        color_scheme = self.theme["named_colors"]

        date_text_props = {
            "format": "%a %Y-%m-%d",
            "font": self.text_font_family(config),
            "fontsize": self.text_font_size(config),
            "background": f"{color_scheme['powerline_bg'][0]}{self.opacity_str}",
        }

        if self.config is not None:
            props = self._merge_parameters(
                date_text_props,
                self.props,
            )
        else:
            props = date_text_props

        date_text = widget.Textbox(**props)

        date_icon_props = {
            "name": "calendar",
            "font": self.icon_font_family(config),
            "fontsize": self.icon_font_size(config),
            "background": f"{color_scheme['powerline_bg'][0]}{self.opacity_str}",
            "width": bar_height,
        }

        if self.config is not None:
            props = self._merge_parameters(
                date_icon_props,
                self.props,
            )
        else:
            props = date_icon_props

        date_icon = MDIcon(**props)

        separator_props = {
            "padding": 6,
            "linewidth": 0,
            "background": f"{color_scheme['powerline_bg'][0]}{self.opacity_str}",
        }

        if self.config is not None:
            props = self._merge_parameters(
                separator_props,
                self.props,
            )
        else:
            props = separator_props

        separator = widget.Sep(**props)

        time_text_props = {
            "format": "%a %Y-%m-%d",
            "font": self.text_font_family(config),
            "fontsize": self.text_font_size(config),
            "background": f"{color_scheme['powerline_bg'][0]}{self.opacity_str}",
        }

        if self.config is not None:
            props = self._merge_parameters(
                time_text_props,
                self.props,
            )
        else:
            props = time_text_props

        time_text = widget.Textbox(**props)

        time_icon_props = {
            "name": "calendar",
            "font": self.icon_font_family(config),
            "fontsize": self.icon_font_size(config),
            "background": f"{color_scheme['powerline_bg'][0]}{self.opacity_str}",
            "width": bar_height,
        }

        if self.config is not None:
            props = self._merge_parameters(
                time_icon_props,
                self.props,
            )
        else:
            props = time_icon_props

        time_icon = MDIcon(**props)

        return [date_text, date_icon, separator, time_text, time_icon]
