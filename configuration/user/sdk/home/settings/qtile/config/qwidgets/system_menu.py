from socket import gethostname
from libqtile.lazy import lazy

from qtile_extras import widget

from theme._types import ThemeDefinition
from qwidgets.widget_group import WidgetGroup


class SystemMenu(WidgetG):
    def __init__(self, theme: ThemeDefinition):
        self.theme = theme

    def widgets(self, **config) -> list[widget]:
        hostname = gethostname()
        background = f"{self.color_scheme()['powerline_bg'][-1]}{self.opacity_str()}"

        return [
            widget.Textbox(
                text=hostname,
                font=self.text_font_family(config),
                fontsize=self.text_font_size(config),
                padding=8,
                background=background,
                mouse_callbacks={"Button1": lazy.spawn("system-menu")},
                **config,
            ),
            widget.Textbox(
                text=self.theme["logo"],
                font=self.icon_font_family(config),
                fontsize=self.icon_font_size(config),
                padding=8,
                background=background,
                mouse_callbacks={"Button1": lazy.spawn("system-menu")},
                **config,
            ),
        ]
