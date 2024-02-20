import re

from typing import List

from libqtile.config import Match, Rule

wmclass_float = [
    "Nitrogen",
    "Pavucontrol",
    "Volumeicon",
    "Gnome-calculator",
    "Arandr",
    "Gucharmap",
    re.compile("VirtualBox"),
    "visualizer",  # wm_class set by alacritty when started by sxhkd
]

wmtype_float = [
    "dock",
    "toolbar",
    "menu",
    "utility",
    "splash",
    "dialog",
    "tooltip",
    "notification",
]

wmclass_group = {
    "code-oss": "DEV",
    "darktable": "GFX",
    "discord": "CHAT",
    "firefox": "WWW",
    r"gimp\-.*": "GFX",
}


def build_rules() -> List[Rule]:
    rules = [
        Rule(
            Match(wm_class=wmclass_float),
            float=True,
            break_on_match=False,
        ),
        Rule(
            Match(wm_type=wmtype_float),
            float=True,
            break_on_match=True,
        ),
    ]

    for wmclass, group in wmclass_group.items():
        rules.append(Rule(Match(wm_instance_class=[re.compile(wmclass)]), group=group))

    return rules
