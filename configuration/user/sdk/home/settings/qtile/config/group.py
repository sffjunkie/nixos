from libqtile.config import Match, Rule
from libqtile.command import lazy
from libqtile.config import Key, Group

group_config = [
    ("WWW", {"layout": "monadtall"}),
    ("BRAIN", {"layout": "max"}),
    ("DEV", {"layout": "max"}),
    ("TERM", {"layout": "monadtall"}),
    ("DOC", {"layout": "monadtall"}),
    ("CHAT", {"layout": "monadtall"}),
    ("MUS", {"layout": "monadtall"}),
    ("VID", {"layout": "monadtall"}),
    ("GFX", {"layout": "max"}),
]

wmclass_group = {
    "brave-browser|chromium|firefox": "WWW",
    "obsidian": "BRAIN",
    "code-url-handler": "DEV",
    "Darktable": "GFX",
    "Gimp": "GFX",
    "discord": "CHAT",
}

SUPERSCRIPT = ["⁰", "¹", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹"]
SUBSCRIPT = ["₀", "₁", "₂", "₃", "₄", "₅", "₆", "₇", "₈", "₉"]

DECORATION = ""


def decoration(group_idx: int) -> str:
    if DECORATION == "superscript":
        return SUPERSCRIPT[group_idx]
    elif DECORATION == "subscript":
        return SUBSCRIPT[group_idx]
    else:
        return ""


def build_groups(settings: dict) -> list[Group]:
    return [
        Group(name + decoration(i), **kwargs)
        for i, (name, kwargs) in enumerate(group_config, 1)
    ]


def build_keys(settings: dict) -> list[Key]:
    keys = []
    for i, (name, _) in enumerate(group_config, 1):
        group_name = name + decoration(i)
        keys.append(
            Key(
                [settings["mod"]],
                str(i),
                lazy.group[group_name].toscreen(),
                desc=f"Switch to group {group_name}",
            )
        )
        keys.append(
            Key(
                [settings["mod"], "shift"],
                str(i),
                lazy.window.togroup(group_name),
                desc=f"Send current window to group {group_name}",
            )
        )
    return keys


def build_rules() -> list[Rule]:
    return [
        Rule(Match(wm_class=wmclass), group=group)
        for wmclass, group in wmclass_group.items()
    ]
