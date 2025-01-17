from socket import gethostname

from libqtile.lazy import lazy  # type: ignore
from qtile_extras import widget  # type: ignore

from qgroup.widget_group import WidgetGroup
from qgroup.context import GroupContext


class SystemMenu(WidgetGroup):
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

        hostname_props = {
            "text": gethostname(),
            "font": self.context.text_font_family,
            "fontsize": self.context.text_font_size,
            "padding": 8,
            "mouse_callbacks": {"Button1": lazy.spawn("system-menu")},
            "background": background,
        }

        props = self.context.merge_parameters(
            hostname_props,
            self.context.props.get("layout", {}),
        )

        hostname = widget.Textbox(**props)

        icon_props = {
            "text": self.theme["logo"],
            "font": self.context.icon_font_family,
            "fontsize": self.context.icon_font_size,
            "padding": 8,
            "mouse_callbacks": {"Button1": lazy.spawn("system-menu")},
            "background": background,
        }

        props = self.context.merge_parameters(
            icon_props,
            self.context.props.get("layout", {}),
        )

        icon = widget.Textbox(**props)

        widgets = [hostname, icon]
        return widgets
