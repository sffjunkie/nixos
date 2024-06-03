# Keybindings for groups are defined in groups.py

from os import environ

from keys import Alt, Ctrl, Hyper, Shift, Super
from libqtile.config import Click, Drag, Key

from libqtile.lazy import lazy
from window import float_to_front


def build_keys(settings) -> list[Key]:
    return [
        # Browser
        Key(
            [Super, Alt],
            "w",
            lazy.spawn(environ.get("BROWSER", "brave")),
            desc="Start the browser",
        ),
        # Brain
        Key(
            [Super, Alt],
            "b",
            lazy.spawn("obsidian"),
            desc="Start the Brain (Obsidian)",
        ),
        # Code Editor
        Key(
            [Super, Alt],
            "c",
            lazy.spawn("code"),
            desc="Start Coding (VSCode)",
        ),
        # Terminal
        Key(
            [Super, Alt],
            "t",
            lazy.spawn(environ.get("TERMINAL", "alacritty")),
            desc="Start a terminal",
        ),
        Key(
            [Super, Alt],
            "Return",
            lazy.spawn("rofi-launcher"),
            desc="Show the rofi app launcher (drun)",
        ),
        # Lock screen
        Key(
            [Super, Alt],
            "l",
            lazy.spawn("loginctl lock-session"),
            desc="Lock the screen",
        ),
        # Power menu
        Key(
            [Super, Alt],
            "F12",
            lazy.spawn("system-menu"),
            desc="Show the system menu",
        ),
        # region Clipboard
        Key(
            [Super, Alt],
            "Insert",
            lazy.spawn(
                "rofi-clip -c",
            ),
            desc="Copy an item from the clipboard history",
        ),
        Key(
            [Super, Alt],
            "Delete",
            lazy.spawn(
                "rofi-clip -d",
            ),
            desc="Delete an item from the clipboard history",
        ),
        # endregion
        # region MPD Control
        # Play / Pause
        Key(
            [Super, Alt],
            "F8",
            lazy.spawn("musicctl toggle"),
            desc="Toggle music play/pause",
        ),
        Key(
            [Super, Alt],
            "F7",
            lazy.spawn("musicctl previous"),
            desc="Switch to previous music track",
        ),
        Key(
            [Super, Alt],
            "F9",
            lazy.spawn("musicctl next"),
            desc="Switch to next music track",
        ),
        # endregion
        # region QTile Control
        Key([Super, Alt, Ctrl], "Return", lazy.reload_config(), desc="Reload QTile"),
        Key([Super, Alt, Ctrl], "Backspace", lazy.shutdown(), desc="Quit QTile"),
        # endregion
        # region Window Control
        Key(
            [Super, Alt],
            "Left",
            lazy.screen.prev_group(),
            desc="Switch to next group",
        ),
        Key(
            [Super, Alt],
            "Right",
            lazy.screen.next_group(),
            desc="Switch to previous group",
        ),
        Key(
            [Super, Ctrl],
            "c",
            lazy.window.kill(),
            desc="Close window",
        ),
        Key(
            [Super, Ctrl],
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
            [Super, Shift],
            "Right",
            lazy.layout.shuffle_down(),
            desc="Move window down in stack",
        ),
        Key(
            [Super, Shift],
            "Left",
            lazy.layout.shuffle_up(),
            desc="Move window up in stack",
        ),
        Key(
            [Super, Shift],
            "l",
            lazy.layout.shuffle_down(),
            desc="Move window down in stack",
        ),
        Key(
            [Super, Shift],
            "h",
            lazy.layout.shuffle_up(),
            desc="Move window up in stack",
        ),
        # endregion
        # region Screen switching
        Key(
            [Super, Alt, Ctrl],
            "Right",
            lazy.next_scren(),
            desc="Switch to next screen",
        ),
        Key(
            [Super, Alt, Ctrl],
            "Left",
            lazy.prev_scren(),
            desc="Switch to previous screen",
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
            [Super, Ctrl],
            "Right",
            lazy.layout.grow_main(),
            desc="Increase Main Window Size",
        ),
        Key(
            [Super, Ctrl],
            "l",
            lazy.layout.grow_main(),
            desc="Increase Main Window Size",
        ),
        Key(
            [Super, Ctrl],
            "Left",
            lazy.layout.shrink_main(),
            desc="Decrease Main Window Size",
        ),
        Key(
            [Super, Ctrl],
            "h",
            lazy.layout.shrink_main(),
            desc="Decrease Main Window Size",
        ),
        Key(
            [Super, Ctrl],
            "Up",
            lazy.layout.grow(),
            desc="Increase Sub Window Size",
        ),
        Key(
            [Super, Ctrl],
            "j",
            lazy.layout.grow(),
            desc="Increase Sub Window Size",
        ),
        Key(
            [Super, Ctrl],
            "Down",
            lazy.layout.shrink(),
            desc="Decrease Sub Window Size",
        ),
        Key(
            [Super, Ctrl],
            "k",
            lazy.layout.shrink(),
            desc="Decrease Sub Window Size",
        ),
        # endregion
        # region VT Switching
        Key([Ctrl, Alt], "F1", lazy.core.change_vt(1), desc="Switch to VT 1"),
        Key([Ctrl, Alt], "F2", lazy.core.change_vt(2), desc="Switch to VT 2"),
        Key([Ctrl, Alt], "F3", lazy.core.change_vt(3), desc="Switch to VT 3"),
        Key([Ctrl, Alt], "F4", lazy.core.change_vt(4), desc="Switch to VT 4"),
        Key([Ctrl, Alt], "F5", lazy.core.change_vt(5), desc="Switch to VT 5"),
        Key([Ctrl, Alt], "F6", lazy.core.change_vt(6), desc="Switch to VT 6"),
        # endregion
        Key([Super, Shift], "f", float_to_front),
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
