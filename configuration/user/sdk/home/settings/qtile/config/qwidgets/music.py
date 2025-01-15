from qbar.bar import Bar
from qbar.position import GroupPosition
from qtile_extras import widget  # type: ignore
from qbar.widget_group import WidgetGroup
from theme.defs.theme import ThemeDefinition


class MusicStatus(WidgetGroup):
    def __init__(
        self,
        bar: Bar,
        position: GroupPosition,
        props: dict | None = None,
        theme: ThemeDefinition | None = None,
    ) -> None:
        super.__init__(bar, position, theme, props)

    def widgets(self) -> list[widget.base._Widget]:
        mpd2_props = {
            "font": self.bar.text_font_family,
            "fontsize": self.bar.text_font_size,
        }
        mpd2 = widget.Mpd2(
            **self._merge_parameters(
                mpd2_props,
                self.props,
            )
        )

        music_icon_props = {
            "name": "music",
            "font": self.icon_font_family,
            "fontsize": self.icon_font_size,
            "padding": 8,
        }
        music_icon = widget.Textbox(
            **self._merge_parameters(
                music_icon_props,
                self.props,
            )
        )

        if self.position == GroupPosition.START:
            return [music_icon, mpd2]
        else:
            return [mpd2, music_icon]
