from libqtile.widget import base  # type: ignore
from qtile_extras.widget import Sep  # type: ignore

from qmodule.base import WidgetModule
from qmodule.context import ModuleContext


class LineSeparator(WidgetModule):
    def __init__(
        self,
        context: ModuleContext,
    ):
        self.context = context

    def widgets(self, group_id: int = -1) -> list[base._Widget]:
        background_color = self.context.props.get(
            "background", self.context.bar.background
        )
        background = f"{background_color}00"

        separator_props = {
            "size_percent": 50,
            "linewidth": 1,
            "padding": 12,
            "foreground": self.context.theme["named_colors"]["panel_fg"],
            "background": background,
        }

        props = self.context.merge_parameters(
            separator_props,
            self.context.props.pop("separator", {}),
        )

        separator = Sep(**props)

        widgets = [separator]
        return widgets
