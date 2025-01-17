from qtile_extras import widget  # type: ignore
from qgroup.widget_group import WidgetGroup
from qgroup.context import GroupContext


class Spacer(WidgetGroup):
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

        spacer_props = {
            "background": background,
        }

        props = self.context.merge_parameters(
            spacer_props,
            self.context.props.get("layout", {}),
        )

        spacer = widget.Spacer(**props)

        widgets = [spacer]
        return widgets
