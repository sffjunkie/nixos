# from libqtile.lazy import lazy

from qtile_extras import widget

from theme._types import ThemeDefinition
from theme.utils import opacity_to_str


class UserMenuWidget(widget.TextBox):
    def __init__(self, theme: ThemeDefinition, **config):
        color_scheme = theme["named_colors"]
        opacity_str = opacity_to_str(theme["bar"]["opacity"])
        super().__init__(
            text=chr(0xF0004),
            font=theme["font"]["logo"]["family"],
            fontsize=theme["font"]["logo"]["size"],
            padding=8,
            background=f"{color_scheme['powerline_bg'][-1]}{opacity_str}",
            # mouse_callbacks={"Button1": lazy.spawn("system-menu")},
            **config,
        )
