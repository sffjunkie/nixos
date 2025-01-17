from qtile_extras import widget  # type: ignore
from qgroup.widget_group import WidgetGroup
from qwidget.icon import MDIcon
from qwidget.net_min import NetMin
from qgroup.context import GroupContext


class NetworkStatus(WidgetGroup):
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

        up_props = {
            "format": "{up} ",
            "font": self.bar.text_font_family,
            "fontsize": self.bar.text_font_size,
            "background": background,
        }

        props = self.context.merge_parameters(
            up_props,
            self.context.props.get("up", {}),
        )

        up = NetMin(**props)

        up_icon_props = {
            "name": "net_up",
            "font": self.context.icon_font_family,
            "fontsize": self.context.icon_font_size,
            "padding": 8,
            "background": background,
        }

        props = self.context.merge_parameters(
            up_icon_props,
            self.context.props.get("icon", {}),
        )

        up_icon = widget.MDIIcon(props)

        down_props = {
            "format": "{up} ",
            "font": self.bar.text_font_family,
            "fontsize": self.bar.text_font_size,
            "background": background,
        }

        props = self.context.merge_parameters(
            down_props,
            self.context.props.get("down", {}),
        )

        down = NetMin(**props)

        down_icon_props = {
            "name": "net_down",
            "font": self.context.icon_font_family,
            "fontsize": self.context.icon_font_size,
            "padding": 8,
            "background": background,
        }

        props = self.context.merge_parameters(
            down_icon_props,
            self.context.props.get("icon", {}),
        )

        down_icon = MDIcon(**props)

        widgets = [up_icon, up, down_icon, down]
        return widgets
