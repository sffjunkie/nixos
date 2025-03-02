# Keybindings for groups are defined in groups.py

from os import environ

from libqtile.config import Click, Drag, Key  # type: ignore
from libqtile.lazy import lazy  # type: ignore

from window import float_to_front

Alt = "mod1"
Ctrl = "control"
Shift = "shift"
Hyper = "mod3"
Super = "mod4"

    return [
        Drag(
            [Super],
            "Button1",
            lazy.window.set_position_floating(),
            start=lazy.window.get_position(),
        ),
        Drag(
            [Super],
            "Button3",
            lazy.window.set_size_floating(),
            start=lazy.window.get_size(),
        ),
        Click([Super], "Button2", lazy.window.bring_to_front()),
    ]
