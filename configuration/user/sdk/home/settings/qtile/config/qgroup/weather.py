from qtile_extras import widget  # type: ignore

from qgroup.context import GroupContext
from qgroup.widget_group import WidgetGroup


class Weather(WidgetGroup):
    def __init__(
        self,
        context: GroupContext,
    ):
        self.position = context.position
        super().__init__(context)

    def widgets(self) -> list[widget]:
        background_color = self.context.props.get(
            "background", self.context.bar.background_color
        )
        background = f"{background_color}{self.context.bar.opacity_str}"

        weather_props = {
            "padding": 12,
            "font": self.context.text_font_family,
            "fontsize": self.context.text_font_size,
            "background": background,
        }

        props = self.context.merge_parameters(
            weather_props,
            self.context.props.get("weather", {}),
        )

        weather = widget.OpenWeather(**props)

        widgets = [weather]
        return widgets
