import re

from typing import List

from libqtile.config import Match, Rule

wmclass_group = {
    "brave-browser|chromium|firefox": "WWW",
    "obsidian": "BRAIN",
    "code-url-handler": "DEV",
    "Darktable": "GFX",
    "Gimp": "GFX",
    "discord": "CHAT",
}


def dgroup_rules() -> List[Rule]:
    return [
        Rule(Match(wm_class=wmclass), group=group)
        for wmclass, group in wmclass_group.items()
    ]


wmclass_float = [
    "Pavucontrol",
    "Volumeicon",
    "Gnome-calculator",
    "Gucharmap",
    "ssh-askpass",
]


def float_rules() -> List[Rule]:
    float_escaped = [re.escape(item) for item in wmclass_float]
    float_match = "|".join(float_escaped)
    return [Match(wm_class=f"^({float_match})$")]
