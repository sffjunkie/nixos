from qtile_extras import widget  # type: ignore

from theme.defs.theme import ThemeDefinition
from qgroup.widget_group import WidgetGroup


class CurrentLayout(WidgetGroup):
    def __init__(
        self,
        settings: dict | None = None,
        theme: ThemeDefinition | None = None,
        props: dict | None = None,
    ):
        super().__init__(settings, theme)
        self.props = props

    def widgets(self) -> list[widget]:
        current_layout_props = {
            "padding": 12,
            "font": self.text_font_family,
            "fontsize": self.text_font_size,
            "foreground": self.theme["named_colors"]["panel_fg"],
            "background": f"{self.theme['named_colors']['panel_bg']}{self.opacity_str}",
        }

        if self.config is not None:
            props = self._merge_parameters(
                current_layout_props,
                self.props,
            )
        else:
            props = current_layout_props

        current_layout = widget.CurrentLayout(**props)

        return [current_layout]
