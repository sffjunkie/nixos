from qtile_extras import widget

from theme._types import Theme
from theme.utils import opacity_to_str
from qwidgets.icon import MDIcon


class UserMenuWidget(MDIcon):
    def __init__(self, theme: Theme, **config):
        color_scheme = theme["named_colors"]
        opacity_str = opacity_to_str(theme["bar"]["opacity"])
        super().__init__(
            name="user",
            font=theme["font"]["icon"]["family"],
            fontsize=theme["font"]["icon"]["size"],
            foreground=color_scheme["panel_bg"],
            background=f"{color_scheme['panel_fg']}{opacity_str}",
            **config,
        )
