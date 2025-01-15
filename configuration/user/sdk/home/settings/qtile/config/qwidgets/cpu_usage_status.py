from libqtile.lazy import lazy  # type: ignore
from qbar.bar import Bar
from qbar.position import GroupPosition
from qtile_extras import widget  # type: ignore
from qbar.widget_group import WidgetGroup
from theme.defs.theme import ThemeDefinition


class CPUUsageStatus(WidgetGroup):
    def __init__(
        self,
        bar: Bar,
        position: GroupPosition,
        props: dict | None = None,
        theme: ThemeDefinition | None = None,
    ) -> None:
        super.__init__(bar, position, theme, props)

    def widgets(self) -> list[widget.base._Widget]:
        usage_props = {
            "format": "{up} ",
            "font": self.bar.text_font_family,
            "fontsize": self.bar.text_font_size,
        }
        usage = widget.Textbox(
            **self._merge_parameters(
                usage_props,
                self.props,
            )
        )

        usage_icon_props = {
            "name": "cpu_usage",
            "font": self.icon_font_family,
            "fontsize": self.icon_font_size,
            "padding": 8,
        }
        usage_icon = widget.Textbox(
            **self._merge_parameters(
                usage_icon_props,
                self.props,
            )
        )

        if self.position == GroupPosition.START:
            return [usage_icon, usage]
        else:
            return [usage, usage_icon]
