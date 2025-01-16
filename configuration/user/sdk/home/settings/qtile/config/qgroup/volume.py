from qtile_extras import widget  # type: ignore

from qwidget.icon import MDIcon
from qgroup.widget_group import WidgetGroup
from theme.defs.theme import ThemeDefinition


class Volume(WidgetGroup):
    def __init__(
        self,
        settings: dict | None = None,
        theme: ThemeDefinition | None = None,
        props: dict | None = None,
    ):
        super().__init__(settings, theme)
        self.props = props

    def widgets(self) -> list[widget]:
        volume_text_props = {
            "menu_font": self.text_font_family,
            "menu_fontsize": int(self.text_font_size * 0.8),
            "menu_width": 500,
            "menu_offset_x": -250,
            "padding": 12,
            "font": self.text_font_family,
            "fontsize": self.text_font_size,
        }

        if self.props is not None:
            props = self._merge_parameters(
                volume_text_props,
                self.props,
            )
        else:
            props = volume_text_props

        volume_text = widget.PulseVolume(**props)

        volume_icon_props = {
            "name": "volume",
            "font": self.icon_font_family,
            "fontsize": self.icon_font_size,
            "background": f"{self.theme['named_colors']['powerline_bg'][2]}{self.opacity_str}",
        }

        if self.props is not None:
            props = self._merge_parameters(
                volume_icon_props,
                self.props,
            )
        else:
            props = volume_icon_props

        volume_icon = MDIcon(**props)

        return [volume_text, volume_icon]
