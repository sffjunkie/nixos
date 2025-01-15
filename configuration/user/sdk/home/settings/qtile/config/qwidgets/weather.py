from qtile_extras import widget  # type: ignore

from theme.defs.theme import ThemeDefinition
from qbar.bar import Bar
from qbar.position import GroupPosition
from qbar.widget_group import WidgetGroup


class Weather(WidgetGroup):
    def __init__(
        self,
        bar: Bar,
        position: GroupPosition,
        theme: ThemeDefinition,
        config: dict | None = None,
    ):
        super.__init__(bar.position, position, theme, config)

    def widgets(self) -> list[widget.base._Widget]:
        weather_props = {
            "padding": 12,
            "font": self.text_font_family,
            "fontsize": self.text_font_size,
            "background": f"{self.color_scheme['powerline_bg'][3]}{self.opacity_str}",
        }

        if self.config is not None:
            props = self._merge_parameters(
                weather_props,
                self.config,
            )
        else:
            props = weather_props
        weather = widget.OpenWeather(**props)

        return [weather]
