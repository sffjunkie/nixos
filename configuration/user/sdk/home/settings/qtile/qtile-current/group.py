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


def build_groups(settings: dict) -> list[Group]:
    return [Group(name, **kwargs) for name, kwargs in group_config]


def build_keys(settings: dict) -> list[Key]:
    keys = []
    for i, (name, _) in enumerate(group_config, 1):
        keys.append(
            Key(
                [settings["mod"]],
                str(i),
                lazy.group[name].toscreen(),
                desc=f"Switch to group {name}",
            )
        )
        keys.append(
            Key(
                [settings["mod"], "shift"],
                str(i),
                lazy.window.togroup(name),
                desc=f"Send current window to group {name}",
            )
        )
    return keys
