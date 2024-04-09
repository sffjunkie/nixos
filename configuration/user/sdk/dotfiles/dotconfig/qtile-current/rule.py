import re

from typing import List

from libqtile.config import Match, Rule

wmclass_float = [
    "Pavucontrol",
    "Volumeicon",
    "Gnome-calculator",
    "Gucharmap",
    "ssh-askpass",
]

wmclass_group = {
    "brave-browser|chromium|firefox": "WWW",
    "code-url-handler": "DEV",
    "Darktable": "GFX",
    "Gimp": "GFX",
    "discord": "CHAT",
}


def build_rules() -> List[Rule]:
    rules = [
        Rule(
            Match(wm_class=wmclass_float),
            float=True,
            break_on_match=False,
        ),
    ]

    for wmclass, group in wmclass_group.items():
        rules.append(Rule(Match(wm_class=wmclass), group=group))

    return rules
