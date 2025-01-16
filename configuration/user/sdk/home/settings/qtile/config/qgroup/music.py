from qtile_extras import widget  # type: ignore
from qgroup.widget_group import WidgetGroup
from theme.defs.theme import ThemeDefinition
from qwidget.icon import MDIcon


class MusicStatus(WidgetGroup):
    def __init__(
        self,
        settings: dict | None = None,
        theme: ThemeDefinition | None = None,
        props: dict | None = None,
    ):
        super().__init__(settings, theme)
        self.props = props

    def widgets(self) -> list[widget]:
        mpd2_props = {
            "font": self.bar.text_font_family,
            "fontsize": self.bar.text_font_size,
        }

        if self.props is not None:
            props = self._merge_parameters(
                mpd2_props,
                self.props,
            )
        else:
            props = mpd2_props

        mpd2 = widget.Mpd2(**props)

        music_icon_props = {
            "name": "music",
            "font": self.icon_font_family,
            "fontsize": self.icon_font_size,
            "padding": 8,
        }

        if self.props is not None:
            props = self._merge_parameters(
                music_icon_props,
                self.props,
            )
        else:
            props = music_icon_props

        music_icon = MDIcon(**props)

        return [music_icon, mpd2]
