from qtile_extras import widget  # type: ignore

from qgroup.widget_group import WidgetGroup
from qgroup.context import GroupContext
from qwidget.icon import MDIcon


class CPUTempStatus(WidgetGroup):
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

        temp_props = {
            "format": "{up} ",
            "font": self.context.text_font_family,
            "fontsize": self.context.text_font_size,
            "background": background,
        }

        props = self.context.merge_parameters(
            temp_props,
            self.context.props.get("temperature", {}),
        )

        temp = widget.Textbox(**props)

        temp_icon_props = {
            "name": "cpu_temp",
            "font": self.context.icon_font_family,
            "fontsize": self.context.icon_font_size,
            "padding": 8,
            "background": background,
        }

        props = self.context.merge_parameters(
            temp_icon_props,
            self.context.props.get("icon", {}),
        )

        temp_icon = MDIcon(**props)

        widgets = [temp_icon, temp]
        return widgets
