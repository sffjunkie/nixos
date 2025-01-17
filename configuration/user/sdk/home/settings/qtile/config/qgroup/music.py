from qtile_extras import widget  # type: ignore
from qgroup.widget_group import WidgetGroup
from qwidget.icon import MDIcon
from qgroup.context import GroupContext


class MusicStatus(WidgetGroup):
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

        mpd2_props = {
            "font": self.context.text_font_family,
            "fontsize": self.context.text_font_size,
            "background": background,
        }

        props = self.context.merge_parameters(
            mpd2_props,
            self.context.props.get("player", {}),
        )

        mpd2 = widget.Mpd2(**props)

        music_icon_props = {
            "name": "music",
            "font": self.context.icon_font_family,
            "fontsize": self.context.icon_font_size,
            "padding": 8,
            "background": background,
        }

        props = self.context.merge_parameters(
            music_icon_props,
            self.context.props.get("icon", {}),
        )

        music_icon = MDIcon(**props)

        widgets = [music_icon, mpd2]
        return widgets
