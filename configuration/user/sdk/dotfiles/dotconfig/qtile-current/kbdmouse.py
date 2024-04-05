# Keybindings for groups are defined in groups.py

from os import environ
from typing import List  # noqa: F401

# from libqtile import extension
from libqtile.command import lazy
from libqtile.config import Key, Drag, Click

Alt = "mod1"


def bind_keys(settings) -> List[Key]:
    return [
        Key(
            [settings["mod"], "shift"],
            "t",
            lazy.spawn(environ.get("TERMINAL", "alacritty")),
        ),
        # App launcher
        Key(
            [settings["mod"]],
            "Space",
            lazy.spawn("rofi -modi drun -show drun"),
        ),
        # Lock screen
        Key(
            [settings["mod"], Alt],
            "l",
            lazy.spawn("swaylock -f -c 000000"),
        ),
        # Power menu
        Key(
            [settings["mod"], Alt],
            "F12",
            lazy.spawn("rofi -show p -modi p:rofi-power-menu"),
        ),
        # region MPD Control
        # Play / Pause
        Key(
            [settings["mod"]],
            "F8",
            lazy.spawn("musicctl toggle"),
        ),
        Key(
            [settings["mod"]],
            "F7",
            lazy.spawn("musicctl previous"),
        ),
        Key(
            [settings["mod"]],
            "F9",
            lazy.spawn("musicctl next"),
        ),
        # endregion
        # region QTile Control
        Key([settings["mod"], Alt], "r", lazy.reload_config(), desc="Reload QTile"),
        Key([settings["mod"], Alt], "q", lazy.shutdown(), desc="Quit QTile"),
        # endregion
        # region Window Control
        Key(
            [settings["mod"], "shift"],
            "c",
            lazy.window.kill(),
            desc="Close window",
        ),
        Key(
            [settings["mod"]],
            "Delete",
            lazy.window.kill(),
            desc="Close window",
        ),
        Key(
            [settings["mod"], "mod1"],
            "Left",
            lazy.screen.prev_group(),
            desc="Switch to next group",
        ),
        Key(
            [settings["mod"], "mod1"],
            "Right",
            lazy.screen.next_group(),
            desc="Switch to previous group",
        ),
        Key(
            [settings["mod"], Alt],
            "f",
            lazy.window.toggle_floating(),
            desc="Toggle floating window",
        ),
        # endregion
        # region Toggle between different layouts as defined below
        Key(
            [settings["mod"]], "grave", lazy.next_layout(), desc="Switch to next layout"
        ),
        # endregion
        # region Move window in stack
        Key(
            [settings["mod"], "shift"],
            "Right",
            lazy.layout.shuffle_down(),
            desc="Move window down in stack",
        ),
        Key(
            [settings["mod"], "shift"],
            "Left",
            lazy.layout.shuffle_up(),
            desc="Move window up in stack",
        ),
        Key(
            [settings["mod"], "shift"],
            "l",
            lazy.layout.shuffle_down(),
            desc="Move window down in stack",
        ),
        Key(
            [settings["mod"], "shift"],
            "h",
            lazy.layout.shuffle_up(),
            desc="Move window up in stack",
        ),
        # endregion
        # region Switch between windows in current stack pane
        Key([settings["mod"]], "h", lazy.layout.up(), desc="Previous window"),
        Key([settings["mod"]], "l", lazy.layout.down(), desc="Next window"),
        Key([settings["mod"]], "Left", lazy.layout.up(), desc="Previous window"),
        Key([settings["mod"]], "Right", lazy.layout.down(), desc="Next window"),
        # endregion
        # region Resize
        Key(
            [settings["mod"], "control"],
            "Right",
            lazy.layout.grow_main(),
            desc="Increase Main Window Size",
        ),
        Key(
            [settings["mod"], "control"],
            "l",
            lazy.layout.grow_main(),
            desc="Increase Main Window Size",
        ),
        Key(
            [settings["mod"], "control"],
            "Left",
            lazy.layout.shrink_main(),
            desc="Decrease Main Window Size",
        ),
        Key(
            [settings["mod"], "control"],
            "h",
            lazy.layout.shrink_main(),
            desc="Decrease Main Window Size",
        ),
        Key(
            [settings["mod"], "control"],
            "Up",
            lazy.layout.grow(),
            desc="Increase Sub Window Size",
        ),
        Key(
            [settings["mod"], "control"],
            "j",
            lazy.layout.grow(),
            desc="Increase Sub Window Size",
        ),
        Key(
            [settings["mod"], "control"],
            "Down",
            lazy.layout.shrink(),
            desc="Decrease Sub Window Size",
        ),
        Key(
            [settings["mod"], "control"],
            "k",
            lazy.layout.shrink(),
            desc="Decrease Sub Window Size",
        ),
        # endregion
    ]


# Drag floating layouts.
def bind_mouse_buttons(settings):
    return [
        Drag(
            [settings["mod"]],
            "Button1",
            lazy.window.set_position_floating(),
            start=lazy.window.get_position(),
        ),
        Drag(
            [settings["mod"]],
            "Button3",
            lazy.window.set_size_floating(),
            start=lazy.window.get_size(),
        ),
        Click([settings["mod"]], "Button2", lazy.window.bring_to_front()),
    ]
