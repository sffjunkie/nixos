from libqtile.widget import base  # type: ignore
from qtile_extras.widget import Sep  # type: ignore

from qgroup.widget_group import WidgetGroup
from qgroup.context import GroupContext


class Separator(WidgetGroup):
    def __init__(
        self,
        context: GroupContext,
    ):
        self.context = context

    def widgets(self, group_id: int = -1) -> list[base._Widget]:
        background_color = self.context.props.get(
            "background", self.context.bar.background
        )
        background = f"{background_color}00"

        separator_props = {
            "padding": 12,
            "background": background,
        }

        props = self.context.merge_parameters(
            separator_props,
            self.context.props.pop("separator", {}),
        )

        separator = Sep(**props)

        widgets = [separator]
        return widgets
