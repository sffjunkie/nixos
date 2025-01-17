import os
from libqtile.lazy import lazy  # type: ignore
from qtile_extras import widget  # type: ignore

from qgroup.context import GroupContext
from qgroup.widget_group import WidgetGroup


class UserMenu(WidgetGroup):
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

        icon_props = {
            "text": self.context.theme["logo"],
            "font": self.context.icon_font_family,
            "fontsize": self.context.icon_font_size,
            "padding": 8,
            "mouse_callbacks": {"Button1": lazy.spawn("user-menu")},
            "background": background,
        }
        props = self.context.merge_parameters(
            icon_props,
            self.context.props.get("icon", {}),
        )

        icon = widget.Textbox(**props)

        username_props = {
            "text": os.environ["USER"],
            "font": self.context.text_font_family,
            "fontsize": self.context.text_font_size,
            "padding": 8,
            "mouse_callbacks": {"Button1": lazy.spawn("user-menu")},
            "background": background,
        }
        props = self.context.merge_parameters(
            username_props,
            self.context.props.get("username", {}),
        )

        username = widget.Textbox(**props)

        widgets = [icon, username]
        return widgets
