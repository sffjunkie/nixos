# Keybindings for groups are defined in groups.py

import shlex
from os import environ
from typing import List  # noqa: F401

# from libqtile import extension
from libqtile.command import lazy
from libqtile.config import Click, Drag, Key

Alt = "mod1"
Super = "mod4"
ApplicationLaunchModKey = Alt


def build_keys(settings) -> List[Key]:
    sway_lock = [
        "swaylock",
        "--color=3B4252",
        "--ring-color=D8DEE9",
        "--inside-color=4C566A",
        "--indicator-radius=100",
        "--indicator-thickness=10",
        "--key-hl-color=880033",
        "--line-color=5E81AC",
    ]

    return [
        # Browser
        Key(
            [Super, ApplicationLaunchModKey],
            "b",
            lazy.spawn(environ.get("BROWSER", "brave")),
        ),
        # Code Editor
        Key(
            [Super, ApplicationLaunchModKey],
            "c",
            lazy.spawn("code"),
        ),
        # Terminal
        Key(
            [Super, ApplicationLaunchModKey],
            "t",
            lazy.spawn(environ.get("TERMINAL", "alacritty")),
        ),
        # App launcher
        Key(
            [Super, ApplicationLaunchModKey],
            "Space",
            lazy.spawn(
                "rofi -modi drun -show drun -theme-str '@import \"looniversity\"'"
            ),
        ),
        # Lock screen
        Key(
            [Super, ApplicationLaunchModKey],
            "l",
            lazy.spawn(shlex.join(sway_lock)),
        ),
        # Power menu
        Key(
            [Super, ApplicationLaunchModKey],
            "F12",
            lazy.spawn(
                "rofi -show p -modi p:rofi-power-menu -theme-str '@import \"looniversity\"'"
            ),
        ),
        # region MPD Control
        # Play / Pause
        Key(
            [Super],
            "F8",
            lazy.spawn("musicctl toggle"),
        ),
        Key(
            [Super],
            "F7",
            lazy.spawn("musicctl previous"),
        ),
        Key(
            [Super],
            "F9",
            lazy.spawn("musicctl next"),
        ),
        # endregion
        # region QTile Control
        Key([Super, Alt], "r", lazy.reload_config(), desc="Reload QTile"),
        Key([Super, Alt], "q", lazy.shutdown(), desc="Quit QTile"),
        # endregion
        # region Window Control
        Key(
            [Super, "shift"],
            "c",
            lazy.window.kill(),
            desc="Close window",
        ),
        Key(
            [Super],
            "Delete",
            lazy.window.kill(),
            desc="Close window",
        ),
        Key(
            [Super, "mod1"],
            "Left",
            lazy.screen.prev_group(),
            desc="Switch to next group",
        ),
        Key(
            [Super, "mod1"],
            "Right",
            lazy.screen.next_group(),
            desc="Switch to previous group",
        ),
        Key(
            [Super, Alt],
            "f",
            lazy.window.toggle_floating(),
            desc="Toggle floating window",
        ),
        # endregion
        # region Toggle between different layouts as defined below
        Key([Super], "grave", lazy.next_layout(), desc="Switch to next layout"),
        # endregion
        # region Move window in stack
        Key(
            [Super, "shift"],
            "Right",
            lazy.layout.shuffle_down(),
            desc="Move window down in stack",
        ),
        Key(
            [Super, "shift"],
            "Left",
            lazy.layout.shuffle_up(),
            desc="Move window up in stack",
        ),
        Key(
            [Super, "shift"],
            "l",
            lazy.layout.shuffle_down(),
            desc="Move window down in stack",
        ),
        Key(
            [Super, "shift"],
            "h",
            lazy.layout.shuffle_up(),
            desc="Move window up in stack",
        ),
        # endregion
        # region Switch between windows in current stack pane
        Key([Super], "h", lazy.layout.up(), desc="Previous window"),
        Key([Super], "l", lazy.layout.down(), desc="Next window"),
        Key([Super], "Left", lazy.layout.up(), desc="Previous window"),
        Key([Super], "Right", lazy.layout.down(), desc="Next window"),
        # endregion
        # region Resize
        Key(
            [Super, "control"],
            "Right",
            lazy.layout.grow_main(),
            desc="Increase Main Window Size",
        ),
        Key(
            [Super, "control"],
            "l",
            lazy.layout.grow_main(),
            desc="Increase Main Window Size",
        ),
        Key(
            [Super, "control"],
            "Left",
            lazy.layout.shrink_main(),
            desc="Decrease Main Window Size",
        ),
        Key(
            [Super, "control"],
            "h",
            lazy.layout.shrink_main(),
            desc="Decrease Main Window Size",
        ),
        Key(
            [Super, "control"],
            "Up",
            lazy.layout.grow(),
            desc="Increase Sub Window Size",
        ),
        Key(
            [Super, "control"],
            "j",
            lazy.layout.grow(),
            desc="Increase Sub Window Size",
        ),
        Key(
            [Super, "control"],
            "Down",
            lazy.layout.shrink(),
            desc="Decrease Sub Window Size",
        ),
        Key(
            [Super, "control"],
            "k",
            lazy.layout.shrink(),
            desc="Decrease Sub Window Size",
        ),
        # endregion
        # region VT Switching
        Key(["control", "mod1"], "F1", lazy.core.change_vt(1), desc="Switch to VT 1"),
        Key(["control", "mod1"], "F2", lazy.core.change_vt(2), desc="Switch to VT 2"),
        Key(["control", "mod1"], "F3", lazy.core.change_vt(3), desc="Switch to VT 3"),
        Key(["control", "mod1"], "F4", lazy.core.change_vt(4), desc="Switch to VT 4"),
        Key(["control", "mod1"], "F5", lazy.core.change_vt(5), desc="Switch to VT 5"),
        Key(["control", "mod1"], "F6", lazy.core.change_vt(6), desc="Switch to VT 6"),
        # endregion
    ]


# Drag floating layouts.
def bind_mouse_buttons(settings):
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