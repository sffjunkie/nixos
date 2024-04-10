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
    float_escaped = [re.escape(item) for item in wmclass_float]
    float_match = "|".join(float_escaped)

    rules = [
        Rule(
            Match(wm_class=f"^({float_match})$"),
            float=True,
            break_on_match=True,
        ),
    ]

    for wmclass, group in wmclass_group.items():
        rules.append(Rule(Match(wm_class=wmclass), group=group))

    return rules
