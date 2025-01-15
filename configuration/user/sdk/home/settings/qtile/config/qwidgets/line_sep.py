from qtile_extras import widget  # type: ignore

from theme.defs.theme import ThemeDefinition
from qbar.position import GroupPosition
from qbar.widget_group import WidgetGroup
from qbar.bar import Bar


class LineSeparator(WidgetGroup):
    def __init__(
        self,
        bar: Bar,
        position: GroupPosition,
        theme: ThemeDefinition,
        config: dict | None = None,
    ):
        super.__init__(bar, position, theme, config)

    def widgets(self) -> list[widget.base._Widget]:
        separator_props = {
            "size_percent": 50,
            "linewidth": 1,
            "padding": 12,
            "foreground": self.color_scheme["panel_fg"],
            "background": f"{self.color_scheme['panel_bg']}{self.opacity_str}",
        }

        if self.config is not None:
            props = self._merge_parameters(
                separator_props,
                self.config,
            )
        else:
            props = separator_props
        separator = widget.Sep(**props)

        return [separator]
