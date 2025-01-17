from qtile_extras import widget  # type: ignore

from qgroup.widget_group import WidgetGroup
from qgroup.context import GroupContext


class GroupBox(WidgetGroup):
    def __init__(
        self,
        context: GroupContext,
    ):
        self.position = context.position
        super().__init__(context)

    def widgets(self, **config) -> list[widget]:
        background_color = self.context.props.get(
            "background", self.context.bar.background_color
        )
        background = f"{background_color}{self.context.bar.opacity_str}"

        group_box_props = {
            "margin_y": 3,
            "padding_y": 4,
            "margin_x": 6,
            "padding_x": 6,
            "borderwidth": 0,
            "font": self.text_font_family,
            "fontsize": self.text_font_size,
            "foreground": self.theme["named_colors"]["panel_fg"],
            "background": background,
            "active": self.theme["named_colors"]["group_active_fg"],
            "inactive": self.theme["named_colors"]["group_inactive_fg"],
            "rounded": True,
            "highlight_method": "block",
            "this_current_screen_border": self.theme["named_colors"][
                "group_current_bg"
            ],
            "this_screen_border": self.theme["named_colors"]["group_current_bg"],
            "use_mouse_wheel": False,
            # other_current_screen_border=theme_colors["panel_bg"],
            # other_screen_border=theme_colors["panel_bg"],
        }

        props = self.context.merge_parameters(
            group_box_props,
            self.context.props.get("group_box", {}),
        )

        group_box = widget.GroupBox(**props)

        widgets = [group_box]
        return widgets
