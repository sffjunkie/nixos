import os
from socket import gethostname

from qtile_extras import widget

from theme._types import Theme
from theme.utils import opacity_to_str


class UserHostWidget(widget.TextBox):
    def __init__(self, theme: Theme, **config):
        user = os.environ["USER"]
        hostname = gethostname()

        font_family = theme["font"]["text"]["family"]
        font_size = theme["font"]["text"]["size"]
        color_scheme = theme["named_colors"]
        opacity_str = opacity_to_str(theme["bar"]["opacity"])
        super().__init__(
            text=f"{user}@{hostname}",
            font=font_family,
            fontsize=font_size,
            foreground=color_scheme["panel_fg"],
            background=f"{color_scheme['panel_bg']}{opacity_str}",
            padding=12,
            **config,
        )
