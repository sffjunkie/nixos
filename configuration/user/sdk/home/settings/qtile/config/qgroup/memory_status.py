from qtile_extras import widget  # type: ignore
from qgroup.widget_group import WidgetGroup
from qwidget.icon import MDIcon
from qgroup.context import GroupContext


class MemoryStatus(WidgetGroup):
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

        memory_props = {
            "format": "{up} ",
            "font": self.text_font_family,
            "fontsize": self.text_font_size,
            "background": background,
        }

        props = self.context.merge_parameters(
            memory_props,
            self.context.props.get("memory", {}),
        )

        memory = widget.Memory(**props)

        icon_props = {
            "name": "net_up",
            "background": background,
        }

        props = self.context.merge_parameters(
            icon_props,
            self.context.props.get("icon", {}),
        )

        icon = MDIcon(**props)

        return [icon, memory]
