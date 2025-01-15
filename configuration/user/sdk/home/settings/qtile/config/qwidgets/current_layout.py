from qtile_extras import widget  # type: ignore

from theme.defs.theme import ThemeDefinition
from qbar.bar import Bar
from qbar.position import GroupPosition
from qbar.widget_group import WidgetGroup


class CurrentLayout(WidgetGroup):
    def __init__(
        self,
        bar: Bar,
        position: GroupPosition,
        theme: ThemeDefinition,
        config: dict | None = None,
    ):
        super.__init__(bar, position, theme, config)

    def widgets(self) -> list[widget.base._Widget]:
        current_layout_props = {
            "padding": 12,
            "font": self.text_font_family,
            "fontsize": self.text_font_size,
            "foreground": self.color_scheme["panel_fg"],
            "background": f"{self.color_scheme['panel_bg']}{self.opacity_str}",
        }

        if self.config is not None:
            props = self._merge_parameters(
                current_layout_props,
                self.config,
            )
        else:
            props = current_layout_props
        current_layout = widget.CurrentLayout(**props)

        return [current_layout]
