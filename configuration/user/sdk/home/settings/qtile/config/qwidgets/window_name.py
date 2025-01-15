from qtile_extras import widget  # type: ignore

from theme.defs.theme import ThemeDefinition
from qbar.bar import Bar
from qbar.position import GroupPosition
from qbar.widget_group import WidgetGroup


class WindowName(WidgetGroup):
    def __init__(
        self,
        bar: Bar,
        position: GroupPosition,
        theme: ThemeDefinition,
        config: dict | None = None,
    ):
        super.__init__(bar, position, theme, config)

    def widgets(self) -> list[widget.base._Widget]:
        spacer = widget.Spacer(
            background=f"{self.color_scheme['panel_bg']}{self.opacity_str}",
        )

        window_name_props = {
            "padding": 12,
            "font": self.text_font_family,
            "fontsize": self.text_font_size,
            "foreground": self.color_scheme["panel_fg"],
            "background": f"{self.color_scheme['panel_bg']}{self.opacity_str}",
        }

        if self.config is not None:
            props = self._merge_parameters(
                window_name_props,
                self.config,
            )
        else:
            props = window_name_props
        window_name = widget.WindowName(**props)

        return [spacer, window_name, spacer]
