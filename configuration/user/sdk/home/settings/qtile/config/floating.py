from libqtile import layout
from libqtile.config import Match, Rule
from theme._types import Theme

wmclass_float = [
    "pavucontrol",
    "org.gnome.Calculator",
    "org.gnome.Characters",
    "ssh-askpass",
    "waypaper",
]


def float_rules() -> list[Rule]:
    return [
        Match(wm_class=float_match) for float_match in wmclass_float
    ] + layout.Floating.default_float_rules


def build_layout(theme: Theme) -> layout.Floating:
    color_scheme = theme["named_colors"]
    return layout.Floating(
        float_rules=float_rules(),
        border_normal=color_scheme["window_border"],
        border_focus=color_scheme["window_border"],
    )
