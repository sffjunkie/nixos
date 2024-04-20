from qtile_extras import widget

from theme._types import Theme
from theme.utils import opacity_to_str


class LineSeparator(widget.Sep):
    def __init__(self, theme: Theme, **config):
        color_scheme = theme["named_colors"]
        opacity_str = opacity_to_str(theme["bar"]["opacity"])
        super().__init__(
            size_percent=50,
            linewidth=1,
            padding=12,
            foreground=color_scheme["panel_fg"],
            background=f"{color_scheme['panel_bg']}{opacity_str}",
            **config,
        )
