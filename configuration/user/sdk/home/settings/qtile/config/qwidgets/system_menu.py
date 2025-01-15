from socket import gethostname

from libqtile.lazy import lazy  # type: ignore
from qtile_extras import widget  # type: ignore

from qbar.bar import Bar
from qbar.position import GroupPosition
from qbar.widget_group import WidgetGroup
from theme.defs.theme import ThemeDefinition


class SystemMenu(WidgetGroup):
    def __init__(
        self,
        bar: Bar,
        position: GroupPosition,
        props: dict | None = None,
        theme: ThemeDefinition | None = None,
    ) -> None:
        super.__init__(bar, position, theme, props)

    def widgets(self) -> list[widget.base._Widget]:
        hostname_props = {
            "text": gethostname(),
            "font": self.text_font_family,
            "fontsize": self.text_font_size,
            "padding": 8,
            "mouse_callbacks": {"Button1": lazy.spawn("system-menu")},
        }
        hostname = widget.Textbox(
            **self._merge_parameters(
                hostname_props,
                self.props,
            )
        )

        icon_props = {
            "text": self.theme["logo"],
            "font": self.icon_font_family,
            "fontsize": self.icon_font_size,
            "padding": 8,
            "mouse_callbacks": {"Button1": lazy.spawn("system-menu")},
        }
        icon = widget.Textbox(
            **self._merge_parameters(
                icon_props,
                self.props,
            )
        )

        return [hostname, icon]
