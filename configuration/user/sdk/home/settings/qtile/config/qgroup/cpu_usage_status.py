from qtile_extras import widget  # type: ignore
from qgroup.widget_group import WidgetGroup
from qgroup.context import GroupContext
from qwidget.icon import MDIcon


class CPUUsageStatus(WidgetGroup):
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

        usage_props = {
            "format": "{up} ",
            "font": self.context.text_font_family,
            "fontsize": self.context.text_font_size,
            "background": background,
        }

        props = self.context.merge_parameters(
            usage_props,
            self.context.props.get("temperature", {}),
        )

        usage = widget.Textbox(**props)

        usage_icon_props = {
            "name": "cpu_usage",
            "font": self.context.icon_font_family,
            "fontsize": self.context.icon_font_size,
            "padding": 8,
            "background": background,
        }

        props = self.context.merge_parameters(
            usage_icon_props,
            self.context.props.get("icon", {}),
        )

        usage_icon = MDIcon(**props)

        widgets = [usage_icon, usage]
        return widgets
