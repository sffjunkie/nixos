from typing import Optional  # noqa: F401

from libqtile.command import lazy
from libqtile.config import Key, Group

group_config = [
    ("WWW", {"layout": "monadtall"}),
    ("DEV", {"layout": "monadtall"}),
    ("SYS", {"layout": "monadtall"}),
    ("DOC", {"layout": "monadtall"}),
    ("VxM", {"layout": "monadtall"}),
    ("CHAT", {"layout": "monadtall"}),
    ("MUS", {"layout": "monadtall"}),
    ("VID", {"layout": "monadtall"}),
    ("GFX", {"layout": "max"}),
]


def build_groups(settings: dict) -> list[Group]:
    named_groups = [Group(name, **kwargs) for name, kwargs in group_config]
    return named_groups


def bind_group_keys(settings: dict, keys: list[Key]) -> None:
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
