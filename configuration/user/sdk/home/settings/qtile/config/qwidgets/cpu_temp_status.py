from qtile_extras import widget  # type: ignore

from qbar.bar import Bar
from qbar.position import GroupPosition
from qbar.widget_group import WidgetGroup
from theme.defs.theme import ThemeDefinition


class CPUTempStatus(WidgetGroup):
    def __init__(
        self,
        bar: Bar,
        position: GroupPosition,
        props: dict | None = None,
        theme: ThemeDefinition | None = None,
    ) -> None:
        super.__init__(bar, position, theme, props)

    def widgets(self) -> list[widget.base._Widget]:
        temp_props = {
            "format": "{up} ",
            "font": self.bar.text_font_family,
            "fontsize": self.bar.text_font_size,
        }
        temp = widget.Textbox(
            **self._merge_parameters(
                temp_props,
                self.props,
            )
        )

        temp_icon_props = {
            "name": "cpu_temp",
            "font": self.icon_font_family,
            "fontsize": self.icon_font_size,
            "padding": 8,
        }
        temp_icon = widget.Textbox(
            **self._merge_parameters(
                temp_icon_props,
                self.props,
            )
        )

        if self.position == GroupPosition.START:
            temp["decorations"] = self.decorations.copy()
            return [temp_icon, temp]
        elif self.position == GroupPosition.END:
            temp_icon["decorations"] = self.decorations.copy()
            return [temp, temp_icon]
