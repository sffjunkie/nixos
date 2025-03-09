# Keybindings for groups are defined in groups.py

from libqtile.config import Click, Drag, Key  # type: ignore
from libqtile.lazy import lazy  # type: ignore

from window import float_to_front
from settings.typedefs import Settings


def user_menu(settings: Settings):
    # cmd = settings["key"]["cmd"]
    # alt = settings["key"]["alt"]
    return [
        # Key(
        #     [cmd, alt],
        #     "F1",
        #     lazy.spawn("user-menu"),
        #     desc="Show the user menu",
        # ),
    ]


def system_menu(settings: Settings):
    cmd = settings["key"]["cmd"]
    alt = settings["key"]["alt"]
    return [
        Key(
            [cmd, alt],
            "F12",
            lazy.spawn("system-menu"),
            desc="Show the system menu",
        ),
    ]


def application(settings: Settings):
    cmd = settings["key"]["cmd"]
    alt = settings["key"]["alt"]
    return [
        # Launcher
        Key(
            [cmd, alt],
            "Return",
            lazy.spawn(settings["app"]["system-menu"]),
            desc="Show the rofi app launcher (drun)",
        ),
        # Browser
        Key(
            [cmd, alt],
            "w",
            lazy.spawn(settings["app"]["browser"]),
            desc="Start the browser",
        ),
        # Brain
        Key(
            [cmd, alt],
            "b",
            lazy.spawn(settings["app"]["brain"]),
            desc="Start the Brain",
        ),
        # Code Editor
        Key(
            [cmd, alt],
            "c",
            lazy.spawn(settings["app"]["code"]),
            desc="Start Coding",
        ),
        # Terminal
        Key(
            [cmd, alt],
            "t",
            lazy.spawn(settings["app"]["terminal"]),
            desc="Start the terminal",
        ),
    ]


def layout(settings: Settings):
    cmd = settings["key"]["cmd"]
    return [
        Key(
            [cmd],
            "grave",
            lazy.next_layout(),
            desc="Switch to next layout",
        ),
    ]


def window(settings: Settings):
    cmd = settings["key"]["cmd"]
    alt = settings["key"]["alt"]
    shift = settings["key"]["shift"]
    ctrl = settings["key"]["ctrl"]
    return [
        # region Switch
        Key(
            [cmd, alt],
            "h",
            lazy.layout.up(),
            desc="Previous window",
        ),
        Key(
            [cmd, alt],
            "l",
            lazy.layout.down(),
            desc="Next window",
        ),
        Key(
            [cmd, alt],
            "Left",
            lazy.layout.up(),
            desc="Previous window",
        ),
        Key(
            [cmd, alt],
            "Right",
            lazy.layout.down(),
            desc="Next window",
        ),
        # endregion
        # region Move
        Key(
            [cmd, shift],
            "Right",
            lazy.layout.shuffle_down(),
            desc="Move window down in stack",
        ),
        Key(
            [cmd, shift],
            "Left",
            lazy.layout.shuffle_up(),
            desc="Move window up in stack",
        ),
        Key(
            [cmd, shift],
            "l",
            lazy.layout.shuffle_down(),
            desc="Move window down in stack",
        ),
        Key(
            [cmd, shift],
            "h",
            lazy.layout.shuffle_up(),
            desc="Move window up in stack",
        ),
        # endregion
        # region Control
        Key([cmd, shift], "f", float_to_front),
        Key(
            [cmd, ctrl],
            "c",
            lazy.window.kill(),
            desc="Close window",
        ),
        Key(
            [cmd, ctrl],
            "f",
            lazy.window.toggle_floating(),
            desc="Toggle floating window",
        ),
        # endregion
        # region Size
        Key(
            [cmd, ctrl],
            "Right",
            lazy.layout.grow_main(),
            desc="Increase Main Window Size",
        ),
        Key(
            [cmd, ctrl],
            "l",
            lazy.layout.grow_main(),
            desc="Increase Main Window Size",
        ),
        Key(
            [cmd, ctrl],
            "Left",
            lazy.layout.shrink_main(),
            desc="Decrease Main Window Size",
        ),
        Key(
            [cmd, ctrl],
            "h",
            lazy.layout.shrink_main(),
            desc="Decrease Main Window Size",
        ),
        Key(
            [cmd, ctrl],
            "Up",
            lazy.layout.grow(),
            desc="Increase Sub Window Size",
        ),
        Key(
            [cmd, ctrl],
            "j",
            lazy.layout.grow(),
            desc="Increase Sub Window Size",
        ),
        Key(
            [cmd, ctrl],
            "Down",
            lazy.layout.shrink(),
            desc="Decrease Sub Window Size",
        ),
        Key(
            [cmd, ctrl],
            "k",
            lazy.layout.shrink(),
            desc="Decrease Sub Window Size",
        ),
        # endregion
    ]


def group(settings: Settings):
    cmd = settings["key"]["cmd"]
    return [
        Key(
            [cmd],
            "Left",
            lazy.screen.prev_group(),
            desc="Switch to next group",
        ),
        Key(
            [cmd],
            "Right",
            lazy.screen.next_group(),
            desc="Switch to previous group",
        ),
    ]


def screen(settings: Settings):
    cmd = settings["key"]["cmd"]
    alt = settings["key"]["alt"]
    ctrl = settings["key"]["ctrl"]
    return [
        Key(
            [cmd, alt, ctrl],
            "Right",
            lazy.next_scren(),
            desc="Switch to next screen",
        ),
        Key(
            [cmd, alt, ctrl],
            "Left",
            lazy.prev_scren(),
            desc="Switch to previous screen",
        ),
    ]


def clipboard(settings: Settings):
    cmd = settings["key"]["cmd"]
    alt = settings["key"]["alt"]
    return [
        Key(
            [cmd, alt],
            "Insert",
            lazy.spawn(
                "rofi-clip -c",
            ),
            desc="Copy an item from the clipboard history",
        ),
        Key(
            [cmd, alt],
            "Delete",
            lazy.spawn(
                "rofi-clip -d",
            ),
            desc="Delete an item from the clipboard history",
        ),
    ]


def qtile(settings: Settings):
    cmd = settings["key"]["cmd"]
    alt = settings["key"]["alt"]
    ctrl = settings["key"]["ctrl"]
    return [
        Key(
            [cmd, alt, ctrl],
            "Return",
            lazy.reload_config(),
            desc="Reload QTile",
        ),
        Key(
            [cmd, alt, ctrl],
            "Backspace",
            lazy.shutdown(),
            desc="Quit QTile",
        ),
    ]


def music(settings: Settings):
    cmd = settings["key"]["cmd"]
    alt = settings["key"]["alt"]
    ctrl = settings["key"]["ctrl"]
    return [
        # Play / Pause
        Key(
            [cmd],
            "F8",
            lazy.spawn("musicctl toggle"),
            desc="Toggle music play/pause",
        ),
        Key(
            [cmd],
            "F7",
            lazy.spawn("musicctl previous"),
            desc="Switch to previous music track",
        ),
        Key(
            [cmd],
            "F9",
            lazy.spawn("musicctl next"),
            desc="Switch to next music track",
        ),
        Key(
            [cmd, alt, ctrl],
            "F8",
            lazy.spawn("pavucontrol"),
            desc="Pavucontrol",
        ),
    ]


def vt(settings: Settings):
    alt = settings["key"]["alt"]
    ctrl = settings["key"]["ctrl"]
    return [
        Key(
            [ctrl, alt],
            "F1",
            lazy.core.change_vt(1),
            desc="Switch to VT 1",
        ),
        Key(
            [ctrl, alt],
            "F2",
            lazy.core.change_vt(2),
            desc="Switch to VT 2",
        ),
        Key(
            [ctrl, alt],
            "F3",
            lazy.core.change_vt(3),
            desc="Switch to VT 3",
        ),
        Key(
            [ctrl, alt],
            "F4",
            lazy.core.change_vt(4),
            desc="Switch to VT 4",
        ),
        Key(
            [ctrl, alt],
            "F5",
            lazy.core.change_vt(5),
            desc="Switch to VT 5",
        ),
        Key(
            [ctrl, alt],
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
    cmd = settings["key"]["cmd"]
    return [
        Drag(
            [cmd],
            "Button1",
            lazy.window.set_position_floating(),
            start=lazy.window.get_position(),
        ),
        Drag(
            [cmd],
            "Button3",
            lazy.window.set_size_floating(),
            start=lazy.window.get_size(),
        ),
        Click([cmd], "Button2", lazy.window.bring_to_front()),
    ]
