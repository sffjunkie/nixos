from qtile_extras import widget  # type: ignore

from qwidgets.icon import MDIcon
from qbar.widget_group import WidgetGroup
from theme.defs.theme import ThemeDefinition
from qbar.position import GroupPosition
from qbar.bar import Bar


class Volume(WidgetGroup):
    def __init__(
        self,
        bar: Bar,
        position: GroupPosition,
        theme: ThemeDefinition,
        config: dict | None = None,
    ) -> None:
        super.__init__(bar, position, theme, config)

    def widgets(self) -> list[widget.base._Widget]:
        volume_text_props = {
            "menu_font": self.text_font_family,
            "menu_fontsize": int(self.text_font_size * 0.8),
            "menu_width": 500,
            "menu_offset_x": -250,
            "padding": 12,
            "font": self.text_font_family,
            "fontsize": self.text_font_size,
        }

        volume_text = widget.PulseVolume(
            **self._merge_parameters(
                volume_text_props,
                self.config,
            )
        )

        volume_icon_props = {
            "name": "volume",
            "font": self.icon_font_family,
            "fontsize": self.icon_font_size,
            "background": f"{self.color_scheme['powerline_bg'][2]}{self.opacity_str}",
        }

        volume_icon = MDIcon(
            **self._merge_parameters(
                volume_icon_props,
                self.config,
            )
        )

        return [volume_text, volume_icon]
