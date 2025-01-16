import os
from libqtile.lazy import lazy  # type: ignore
from qtile_extras import widget  # type: ignore

from theme.defs.theme import ThemeDefinition
from qgroup.widget_group import WidgetGroup


class UserMenu(WidgetGroup):
    def __init__(
        self,
        settings: dict | None = None,
        theme: ThemeDefinition | None = None,
        props: dict | None = None,
    ):
        super().__init__(settings, theme)
        self.props = props

    def widgets(self) -> list[widget]:
        background = (
            f"{self.theme['named_colors']['powerline_bg'][-1]}{self.opacity_str()}"
        )

        icon_props = {
            "text": self.theme["logo"],
            "font": self.icon_font_family,
            "fontsize": self.icon_font_size,
            "padding": 8,
            "background": background,
            "mouse_callbacks": {"Button1": lazy.spawn("user-menu")},
        }
        if self.props is not None:
            props = self._merge_parameters(icon_props, self.props)
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
        if self.props is not None:
            props = self._merge_parameters(username_props, self.props)
        else:
            props = username_props
        username = widget.Textbox(**props)

        return [icon, username]
