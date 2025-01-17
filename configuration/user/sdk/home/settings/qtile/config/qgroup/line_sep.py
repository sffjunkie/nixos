from qtile_extras import widget  # type: ignore

from qgroup.widget_group import WidgetGroup
from qgroup.context import GroupContext


class LineSeparator(WidgetGroup):
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

        separator_props = {
            "size_percent": 50,
            "linewidth": 1,
            "padding": 12,
            "foreground": self.context.theme["named_colors"]["panel_fg"],
            "background": background,
        }

        props = self.context.merge_parameters(
            separator_props,
            self.context.props.get("separator", {}),
        )

        separator = widget.Sep(**props)

        widgets = [separator]
        return widgets
