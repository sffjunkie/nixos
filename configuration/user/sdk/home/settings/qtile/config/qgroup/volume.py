from qtile_extras import widget  # type: ignore

from qwidget.icon import MDIcon
from qgroup.widget_group import WidgetGroup
from qgroup.context import GroupContext


class Volume(WidgetGroup):
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

        volume_text_props = {
            "menu_font": self.context.text_font_family,
            "menu_fontsize": int(self.context.text_font_size * 0.8),
            "menu_width": 500,
            "menu_offset_x": -250,
            "padding": 12,
            "font": self.context.text_font_family,
            "fontsize": self.context.text_font_size,
            "background": background,
        }

        props = self.context.merge_parameters(
            volume_text_props,
            self.context.props.get("volume", {}),
        )

        volume_text = widget.PulseVolume(**props)

        volume_icon_props = {
            "name": "volume",
            "font": self.context.icon_font_family,
            "fontsize": self.context.icon_font_size,
            "background": background,
        }

        props = self.context.merge_parameters(
            volume_icon_props,
            self.context.props.get("icon", {}),
        )

        volume_icon = MDIcon(**props)

        widgets = [volume_text, volume_icon]
        return widgets
