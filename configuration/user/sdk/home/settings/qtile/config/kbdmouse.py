# Keybindings for groups are defined in groups.py

from os import environ

from libqtile.config import Click, Drag, Key  # type: ignore
from libqtile.lazy import lazy  # type: ignore

from window import float_to_front
from setting.defs import Settings

Alt = "mod1"
Ctrl = "control"
Shift = "shift"
Hyper = "mod3"
Super = "mod4"


def user_menu(settings: Settings):
    return [
        # Key(
        #     [Super, Alt],
        #     "F1",
        #     lazy.spawn("user-menu"),
        #     desc="Show the user menu",
        # ),
    ]


def system_menu(settings: Settings):
    return [
        Key(
            [Super, Alt],
            "F12",
            lazy.spawn("system-menu"),
            desc="Show the system menu",
        ),
    ]


def application(settings: Settings):
    return [
        # Launcher
        Key(
            [Super, Alt],
            "Return",
            lazy.spawn("rofi-launcher"),
            desc="Show the rofi app launcher (drun)",
        ),
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
    ]


def layout(settings: Settings):
    return [
        Key(
            [Super],
            "grave",
            lazy.next_layout(),
            desc="Switch to next layout",
        ),
    ]


def window(settings: Settings):
    return [
        # region Switch
        Key(
            [Super, Alt],
            "h",
            lazy.layout.up(),
            desc="Previous window",
        ),
        Key(
            [Super, Alt],
            "l",
            lazy.layout.down(),
            desc="Next window",
        ),
        Key(
            [Super, Alt],
            "Left",
            lazy.layout.up(),
            desc="Previous window",
        ),
        Key(
            [Super, Alt],
            "Right",
            lazy.layout.down(),
            desc="Next window",
        ),
        # endregion
        # region Move
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
        # region Control
        Key([Super, Shift], "f", float_to_front),
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
        # region Size
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
    ]


def group(settings: Settings):
    return [
        Key(
            [Super],
            "Left",
            lazy.screen.prev_group(),
            desc="Switch to next group",
        ),
        Key(
            [Super],
            "Right",
            lazy.screen.next_group(),
            desc="Switch to previous group",
        ),
    ]


def screen(settings: Settings):
    return [
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
    ]


def clipboard(settings: Settings):
    return [
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
    ]


def qtile(settings: Settings):
    return [
        Key(
            [Super, Alt, Ctrl],
            "Return",
            lazy.reload_config(),
            desc="Reload QTile",
        ),
        Key(
            [Super, Alt, Ctrl],
            "Backspace",
            lazy.shutdown(),
            desc="Quit QTile",
        ),
    ]


def music(settings: Settings):
    return [
        # Play / Pause
        Key(
            [Super],
            "F8",
            lazy.spawn("musicctl toggle"),
            desc="Toggle music play/pause",
        ),
        Key(
            [Super],
            "F7",
            lazy.spawn("musicctl previous"),
            desc="Switch to previous music track",
        ),
        Key(
            [Super],
            "F9",
            lazy.spawn("musicctl next"),
            desc="Switch to next music track",
        ),
        Key(
            [Super, Alt, Ctrl],
            "F8",
            lazy.spawn("pavucontrol"),
            desc="Pavucontrol",
        ),
    ]


def vt(settings: Settings):
    return [
        Key(
            [Ctrl, Alt],
            "F1",
            lazy.core.change_vt(1),
            desc="Switch to VT 1",
        ),
        Key(
            [Ctrl, Alt],
            "F2",
            lazy.core.change_vt(2),
            desc="Switch to VT 2",
        ),
        Key(
            [Ctrl, Alt],
            "F3",
            lazy.core.change_vt(3),
            desc="Switch to VT 3",
        ),
        Key(
            [Ctrl, Alt],
            "F4",
            lazy.core.change_vt(4),
            desc="Switch to VT 4",
        ),
        Key(
            [Ctrl, Alt],
            "F5",
            lazy.core.change_vt(5),
            desc="Switch to VT 5",
        ),
        Key(
            [Ctrl, Alt],
            "F6",
            lazy.core.change_vt(6),
            desc="Switch to VT 6",
        ),
    ]


def build_keys(settings: Settings) -> list[Key]:
    return (
        user_menu(settings)
        + system_menu(settings)
        + application(settings)
        + layout(settings)
        + window(settings)
        + group(settings)
        + screen(settings)
        + clipboard(settings)
        + qtile(settings)
        + music(settings)
        + vt(settings)
    )


def build_mouse_buttons(settings):
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
