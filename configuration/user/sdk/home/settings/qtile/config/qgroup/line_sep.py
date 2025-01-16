from qtile_extras import widget  # type: ignore

from theme.defs.theme import ThemeDefinition
from qgroup.widget_group import WidgetGroup


class LineSeparator(WidgetGroup):
    def __init__(
        self,
        settings: dict | None = None,
        theme: ThemeDefinition | None = None,
        props: dict | None = None,
    ):
        super().__init__(settings, theme)
        self.props = props

    def widgets(self) -> list[widget]:
        separator_props = {
            "size_percent": 50,
            "linewidth": 1,
            "padding": 12,
            "foreground": self.theme["named_colors"]["panel_fg"],
            "background": f"{self.theme['named_colors']['panel_bg']}{self.opacity_str}",
        }

        if self.config is not None:
            props = self._merge_parameters(
                separator_props,
                self.props,
            )
        else:
            props = separator_props

        separator = widget.Sep(**props)

        return [separator]
