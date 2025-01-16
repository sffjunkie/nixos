from qtile_extras import widget  # type: ignore

from theme.defs.theme import ThemeDefinition
from qgroup.widget_group import WidgetGroup


class WindowName(WidgetGroup):
    def __init__(
        self,
        settings: dict | None = None,
        theme: ThemeDefinition | None = None,
        props: dict | None = None,
    ):
        super().__init__(settings, theme)
        self.props = props

    def widgets(self) -> list[widget]:
        spacer = widget.Spacer(
            background=f"{self.theme['named_colors']['panel_bg']}{self.opacity_str}",
        )

        window_name_props = {
            "padding": 12,
            "font": self.text_font_family,
            "fontsize": self.text_font_size,
            "foreground": self.theme["named_colors"]["panel_fg"],
            "background": f"{self.theme['named_colors']['panel_bg']}{self.opacity_str}",
        }

        if self.config is not None:
            props = self._merge_parameters(
                window_name_props,
                self.props,
            )
        else:
            props = window_name_props

        window_name = widget.WindowName(**props)

        return [spacer, window_name, spacer]
