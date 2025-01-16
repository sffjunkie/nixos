from qtile_extras import widget  # type: ignore

from theme.defs.theme import ThemeDefinition
from qgroup.widget_group import WidgetGroup


class Weather(WidgetGroup):
    def __init__(
        self,
        settings: dict | None = None,
        theme: ThemeDefinition | None = None,
        props: dict | None = None,
    ):
        super().__init__(settings, theme)
        self.props = props

    def widgets(self) -> list[widget]:
        weather_props = {
            "padding": 12,
            "font": self.text_font_family,
            "fontsize": self.text_font_size,
            "background": f"{self.theme['named_colors']['powerline_bg'][3]}{self.opacity_str}",
        }

        if self.props is not None:
            props = self._merge_parameters(
                weather_props,
                self.props,
            )
        else:
            props = weather_props

        weather = widget.OpenWeather(**props)

        return [weather]
