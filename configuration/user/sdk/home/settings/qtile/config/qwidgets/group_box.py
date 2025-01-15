from qtile_extras import widget  # type: ignore

from theme.defs.theme import ThemeDefinition
from qbar.bar import Bar
from qbar.position import GroupPosition
from qbar.widget_group import WidgetGroup


class GroupBox(WidgetGroup):
    def __init__(
        self,
        bar: Bar,
        position: GroupPosition,
        theme: ThemeDefinition,
        config: dict | None = None,
    ):
        super.__init__(bar, position, theme, config)

    def widgets(self) -> list[widget.base._Widget]:
        group_box_props = {
            "margin_y": 3,
            "padding_y": 4,
            "margin_x": 6,
            "padding_x": 6,
            "borderwidth": 0,
            "font": self.text_font_family,
            "fontsize": self.text_font_size,
            "foreground": self.color_scheme["panel_fg"],
            "background": f"{self.color_scheme['panel_bg']}{self.opacity_str}",
            "active": self.color_scheme["group_active_fg"],
            "inactive": self.color_scheme["group_inactive_fg"],
            "rounded": True,
            "highlight_method": "block",
            "this_current_screen_border": self.color_scheme["group_current_bg"],
            "this_screen_border": self.color_scheme["group_current_bg"],
            "use_mouse_wheel": False,
            # other_current_screen_border=theme_colors["panel_bg"],
            # other_screen_border=theme_colors["panel_bg"],
        }

        if self.config is not None:
            props = self._merge_parameters(
                group_box_props,
                self.config,
            )
        else:
            props = group_box_props
        group_box = widget.GroupBox(**props)

        return [group_box]
