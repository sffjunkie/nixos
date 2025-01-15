from socket import gethostname

from libqtile.lazy import lazy  # type: ignore
from qbar.bar import Bar
from qbar.position import GroupPosition
from qtile_extras import widget  # type: ignore
from qbar.widget_group import WidgetGroup
from theme.defs.theme import ThemeDefinition
from qwidgets.icon import MDIcon


class MemoryStatus(WidgetGroup):
    def __init__(
        self,
        bar: Bar,
        position: GroupPosition,
        props: dict | None = None,
        theme: ThemeDefinition | None = None,
    ) -> None:
        super.__init__(bar, position, theme, props)

    def widgets(self) -> list[widget.base._Widget]:
        (
            MDIcon(
                name="memory",
                width=self.bar.height,
            ),
        )
        (
            widget.Memory(
                format="{MemUsed:6.0f}M/{MemTotal:.0f}M",
                background=f"{self.bar.color_scheme['powerline_bg'][5]}{self.bar.opacity_str}",
            ),
        )

        memory_props = {
            "format": "{up} ",
            "font": self.bar.text_font_family,
            "fontsize": self.bar.text_font_size,
        }
        memory = widget.Textbox(
            **self._merge_parameters(
                memory_props,
                self.props,
            )
        )

        icon_props = {
            "name": "net_up",
            "background": f"{self.bar.color_scheme['powerline_bg'][5]}{self.bar.opacity_str}",
        }
        icon = widget.MDIIcon(
            **self._merge_parameters(
                icon_props,
                self.props,
            )
        )

        if self.position == GroupPosition.START:
            return [icon, memory]
        else:
            return [memory, icon]
