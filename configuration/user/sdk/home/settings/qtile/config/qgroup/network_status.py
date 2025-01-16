from qtile_extras import widget  # type: ignore
from qgroup.widget_group import WidgetGroup
from theme.defs.theme import ThemeDefinition
from qwidget.icon import MDIcon
from qwidget.net_min import NetMin


class NetworkStatus(WidgetGroup):
    def __init__(
        self,
        settings: dict | None = None,
        theme: ThemeDefinition | None = None,
        props: dict | None = None,
    ):
        super().__init__(settings, theme)
        self.props = props

    def widgets(self) -> list[widget]:
        up_props = {
            "format": "{up} ",
            "font": self.bar.text_font_family,
            "fontsize": self.bar.text_font_size,
        }

        if self.props is not None:
            props = self._merge_parameters(
                up_props,
                self.props,
            )
        else:
            props = up_props

        up = NetMin(**props)

        up_icon_props = {
            "name": "net_up",
            "font": self.icon_font_family,
            "fontsize": self.icon_font_size,
            "padding": 8,
        }

        if self.props is not None:
            props = self._merge_parameters(
                up_icon_props,
                self.props,
            )
        else:
            props = up_icon_props

        up_icon = widget.MDIIcon(props)

        down_props = {
            "format": "{up} ",
            "font": self.bar.text_font_family,
            "fontsize": self.bar.text_font_size,
        }

        if self.props is not None:
            props = self._merge_parameters(
                down_props,
                self.props,
            )
        else:
            props = down_props

        down = NetMin(**props)

        down_icon_props = {
            "name": "net_down",
            "font": self.icon_font_family,
            "fontsize": self.icon_font_size,
            "padding": 8,
        }

        if self.props is not None:
            props = self._merge_parameters(
                down_icon_props,
                self.props,
            )
        else:
            props = down_icon_props

        down_icon = MDIcon(**props)

        return [up_icon, up, down_icon, down]
