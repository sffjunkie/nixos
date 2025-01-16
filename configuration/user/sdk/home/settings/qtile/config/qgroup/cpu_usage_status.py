from libqtile.lazy import lazy  # type: ignore
from qtile_extras import widget  # type: ignore
from qgroup.widget_group import WidgetGroup
from theme.defs.theme import ThemeDefinition


class CPUUsageStatus(WidgetGroup):
    def __init__(
        self,
        settings: dict | None = None,
        theme: ThemeDefinition | None = None,
        props: dict | None = None,
    ):
        super().__init__(settings, theme)
        self.props = props

    def widgets(self) -> list[widget]:
        usage_props = {
            "format": "{up} ",
            "font": self.bar.text_font_family,
            "fontsize": self.bar.text_font_size,
        }

        if self.props is not None:
            props = self._merge_parameters(
                usage_props,
                self.props,
            )
        else:
            props = usage_props

        usage = widget.Textbox(**props)
        usage_icon_props = {
            "name": "cpu_usage",
            "font": self.icon_font_family,
            "fontsize": self.icon_font_size,
            "padding": 8,
        }

        if self.props is not None:
            props = self._merge_parameters(
                usage_icon_props,
                self.props,
            )
        else:
            props = usage_icon_props

        usage_icon = widget.Textbox(**props)

        return [usage_icon, usage]
