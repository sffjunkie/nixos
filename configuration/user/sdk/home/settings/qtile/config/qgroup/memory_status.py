from libqtile.lazy import lazy  # type: ignore
from qtile_extras import widget  # type: ignore
from qgroup.widget_group import WidgetGroup
from theme.defs.theme import ThemeDefinition
from qwidget.icon import MDIcon


class MemoryStatus(WidgetGroup):
    def __init__(
        self,
        settings: dict | None = None,
        theme: ThemeDefinition | None = None,
        props: dict | None = None,
    ):
        super().__init__(settings, theme)
        self.props = props

    def widgets(self) -> list[widget]:
        memory_props = {
            "format": "{up} ",
            "font": self.bar.text_font_family,
            "fontsize": self.bar.text_font_size,
        }

        if self.props is not None:
            props = self._merge_parameters(
                memory_props,
                self.props,
            )
        else:
            props = memory_props

        memory = widget.Memory(**props)

        icon_props = {
            "name": "net_up",
            "background": f"{self.bar.color_scheme['powerline_bg'][5]}{self.bar.opacity_str}",
        }

        if self.props is not None:
            props = self._merge_parameters(
                icon_props,
                self.props,
            )
        else:
            props = icon_props

        icon = MDIcon(**props)

        return [icon, memory]
