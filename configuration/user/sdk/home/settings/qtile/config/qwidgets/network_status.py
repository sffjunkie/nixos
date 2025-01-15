from socket import gethostname

from libqtile.lazy import lazy  # type: ignore
from qbar.bar import Bar
from qbar.position import GroupPosition
from qtile_extras import widget  # type: ignore
from qbar.widget_group import WidgetGroup
from theme.defs.theme import ThemeDefinition


class NetworkStatus(WidgetGroup):
    def __init__(
        self,
        bar: Bar,
        position: GroupPosition,
        props: dict | None = None,
        theme: ThemeDefinition | None = None,
    ) -> None:
        super.__init__(bar, position, theme, props)

    def widgets(self) -> list[widget.base._Widget]:
        up_props = {
            "format": "{up} ",
            "font": self.bar.text_font_family,
            "fontsize": self.bar.text_font_size,
        }
        up = widget.Textbox(
            **self._merge_parameters(
                up_props,
                self.props,
            )
        )

        up_icon_props = {
            "name": "net_up",
            "font": self.icon_font_family,
            "fontsize": self.icon_font_size,
            "padding": 8,
        }
        up_icon = widget.Textbox(
            **self._merge_parameters(
                up_icon_props,
                self.props,
            )
        )

        down_props = {
            "format": "{up} ",
            "font": self.bar.text_font_family,
            "fontsize": self.bar.text_font_size,
        }
        down = widget.Textbox(
            **self._merge_parameters(
                down_props,
                self.props,
            )
        )

        down_icon_props = {
            "name": "net_down",
            "font": self.icon_font_family,
            "fontsize": self.icon_font_size,
            "padding": 8,
        }
        down_icon = widget.Textbox(
            **self._merge_parameters(
                down_icon_props,
                self.props,
            )
        )

        return [up_icon, up, down_icon, down]
