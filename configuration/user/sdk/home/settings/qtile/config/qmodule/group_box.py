from libqtile.widget import base  # type: ignore
from qtile_extras.widget import GroupBox as QGroubBox  # type: ignore
from qtile_extras.widget.decorations import RectDecoration  # type: ignore

from qmodule.base import WidgetModule
from qmodule.context import ModuleContext


class GroupBox(WidgetModule):
    def __init__(
        self,
        context: ModuleContext,
    ):
        self.context = context

    def widgets(self, group_id: int = -1) -> list[base._Widget]:
        background_color = self.context.props.get(
            "background", self.context.bar.background
        )

        decorations = None
        if group_id != -1:
            decorations = [
                RectDecoration(
                    colour=f"{background_color}{self.context.bar.opacity_str}",
                    radius=5,
                    filled=True,
                    group=True,
                    group_id=group_id,
                )
            ]

        group_box_props = {
            "margin_y": 3,
            "padding_y": 4,
            "margin_x": 6,
            "padding_x": 6,
            "borderwidth": 0,
            # "font": self.context.text_font_family,
            # "fontsize": self.context.text_font_size,
            "foreground": self.context.theme["named_colors"]["panel_fg"],
            "background": f"{background_color}00",
            "active": self.context.theme["named_colors"]["group_active_fg"],
            "inactive": self.context.theme["named_colors"]["group_inactive_fg"],
            "rounded": True,
            "highlight_method": "block",
            "this_current_screen_border": self.context.theme["named_colors"][
                "group_current_bg"
            ],
            "this_screen_border": self.context.theme["named_colors"][
                "group_current_bg"
            ],
            "use_mouse_wheel": False,
            # other_current_screen_border=theme_colors["panel_bg"],
            # other_screen_border=theme_colors["panel_bg"],
        }

        props = self.context.merge_parameters(
            group_box_props,
            self.context.props.pop("group_box", {}),
        )

        if decorations is not None:
            props["decorations"] = decorations

        group_box = QGroubBox(**props)

        widgets = [group_box]
        return widgets
