import os

from qtile_extras import widget

from theme._types import ThemeDefinition
from theme.utils import opacity_to_str


class UserNameWidget(widget.TextBox):
    def __init__(self, theme: ThemeDefinition, **config):
        user = os.environ["USER"]
        font_family = theme["font"]["text"]["family"]
        font_size = theme["font"]["text"]["size"]
        color_scheme = theme["named_colors"]
        opacity_str = opacity_to_str(theme["bar"]["opacity"])
        super().__init__(
            text=user,
            font=font_family,
            fontsize=font_size,
            foreground=color_scheme["panel_fg"],
            background=f"{color_scheme['panel_bg']}{opacity_str}",
            padding=12,
            **config,
        )
