from qtile_extras import widget  # type: ignore

from theme.defs.theme import ThemeDefinition
from qgroup.widget_group import WidgetGroup


class GroupBox(WidgetGroup):
    def __init__(
        self,
        settings: dict | None = None,
        theme: ThemeDefinition | None = None,
        props: dict | None = None,
    ):
        super().__init__(settings, theme)
        self.props = props

    def widgets(self) -> list[widget]:
        group_box_props = {
            "margin_y": 3,
            "padding_y": 4,
            "margin_x": 6,
            "padding_x": 6,
            "borderwidth": 0,
            "font": self.text_font_family,
            "fontsize": self.text_font_size,
            "foreground": self.theme["named_colors"]["panel_fg"],
            "background": f"{self.theme['named_colors']['panel_bg']}{self.opacity_str}",
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

        if self.config is not None:
            props = self._merge_parameters(
                group_box_props,
                self.props,
            )
        else:
            props = group_box_props

        group_box = widget.GroupBox(**props)

        return [group_box]
