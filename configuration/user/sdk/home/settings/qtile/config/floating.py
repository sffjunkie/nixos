from libqtile import layout  # type: ignore
from libqtile.config import Match, Rule  # type: ignore
from theme.defs.theme import ThemeDefinition

wmclass_float = [
    "com.github.wwmm.easyeffects",
    "org.pulseaudio.pavucontrol",
    "org.gnome.Calculator",
    "org.gnome.Characters",
    "Pinentry",
    "ssh-askpass",
    "waypaper",
    "yubico.org.",
]


def float_rules() -> list[Rule]:
    return [
        Match(wm_class=float_match) for float_match in wmclass_float
    ] + layout.Floating.default_float_rules


def build_layout(theme: ThemeDefinition) -> layout.Floating:
    color_scheme = theme["named_colors"]
    return layout.Floating(
        float_rules=float_rules(),
        border_normal=color_scheme["window_border"],
        border_focus=color_scheme["window_border"],
    )
