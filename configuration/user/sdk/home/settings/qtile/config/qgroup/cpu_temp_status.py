from qtile_extras import widget  # type: ignore

from qgroup.widget_group import WidgetGroup
from theme.defs.theme import ThemeDefinition


class CPUTempStatus(WidgetGroup):
    def __init__(
        self,
        settings: dict | None = None,
        theme: ThemeDefinition | None = None,
        props: dict | None = None,
    ):
        super().__init__(settings, theme)
        self.props = props

    def widgets(self) -> list[widget]:
        temp_props = {
            "format": "{up} ",
            "font": self.bar.text_font_family,
            "fontsize": self.bar.text_font_size,
        }

        if self.props is not None:
            props = self._merge_parameters(
                temp_props,
                self.props,
            )
        else:
            props = temp_props

        temp = widget.Textbox(**props)

        temp_icon_props = {
            "name": "cpu_temp",
            "font": self.icon_font_family,
            "fontsize": self.icon_font_size,
            "padding": 8,
        }

        if self.props is not None:
            props = self._merge_parameters(
                temp_icon_props,
                self.props,
            )
        else:
            props = temp_icon_props

        temp_icon = widget.Textbox(**props)

        return [temp_icon, temp]
