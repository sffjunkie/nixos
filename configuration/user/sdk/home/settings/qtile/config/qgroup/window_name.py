from qtile_extras import widget  # type: ignore

from qgroup.widget_group import WidgetGroup
from qgroup.context import GroupContext


class WindowName(WidgetGroup):
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

        window_name_props = {
            "padding": 12,
            "font": self.text_font_family,
            "fontsize": self.text_font_size,
            "foreground": self.theme["named_colors"]["panel_fg"],
            "background": background,
        }

        props = self.context.merge_parameters(
            window_name_props,
            self.context.props.get("name", {}),
        )

        window_name = widget.WindowName(**props)

        widgets = [window_name]
        return widgets
