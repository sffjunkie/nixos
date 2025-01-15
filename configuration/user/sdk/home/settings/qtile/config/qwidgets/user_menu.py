import os
from libqtile.lazy import lazy  # type: ignore
from qtile_extras import widget  # type: ignore

from theme.defs.theme import ThemeDefinition
from qbar.position import GroupPosition
from qbar.widget_group import WidgetGroup
from qbar.bar import Bar


class UserMenu(WidgetGroup):
    def __init__(
        self,
        bar: Bar,
        position: GroupPosition,
        theme: ThemeDefinition,
        config: dict | None = None,
    ):
        super.__init__(bar, position, theme, config)

    def widgets(self) -> list[widget.base._Widget]:
        background = f"{self.color_scheme['powerline_bg'][-1]}{self.opacity_str()}"

        icon_props = {
            "text": self.theme["logo"],
            "font": self.icon_font_family,
            "fontsize": self.icon_font_size,
            "padding": 8,
            "background": background,
            "mouse_callbacks": {"Button1": lazy.spawn("user-menu")},
        }
        if self.config is not None:
            props = self._merge_parameters(
                icon_props,
                self.config,
            )
        else:
            props = icon_props
        icon = widget.Textbox(**props)

        username_props = {
            "text": os.environ["USER"],
            "font": self.text_font_family,
            "fontsize": self.text_font_size,
            "padding": 8,
            "background": background,
            "mouse_callbacks": {"Button1": lazy.spawn("user-menu")},
        }
        if self.config is not None:
            props = self._merge_parameters(
                username_props,
                self.config,
            )
        else:
            props = username_props
        username = widget.Textbox(**props)

        return [icon, username]
