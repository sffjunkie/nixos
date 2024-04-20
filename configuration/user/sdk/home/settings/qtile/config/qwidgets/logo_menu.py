from libqtile.command import lazy

from qtile_extras import widget

from theme._types import Theme
from theme.utils import opacity_to_str


class LogoMenuWidget(widget.TextBox):
    def __init__(self, theme: Theme, **config):
        color_scheme = theme["named_colors"]
        opacity_str = opacity_to_str(theme["bar"]["opacity"])
        super().__init__(
            text=f"{theme['logo']}",
            font=theme["font"]["logo"]["family"],
            fontsize=theme["font"]["logo"]["size"],
            padding=8,
            foreground=color_scheme["powerline_fg"],
            background=f"{color_scheme['powerline_bg'][-1]}{opacity_str}",
            mouse_callbacks={"Button1": lazy.spawn("rofi-power")},
            **config,
        )
