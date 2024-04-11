import os
import shlex
import subprocess
import sys

from libqtile import __path__ as libqtile_path
from libqtile import layout, hook
from libqtile.config import Screen
from libqtile.backend.wayland import InputConfig
from libqtile.log_utils import logger

import bars
import group
import kbdmouse
import rule
import scratchpad
import secret
import setting
import wallpaper

is_nixos = os.path.exists("/etc/NIXOS")

logger.info(f"python prefix: {sys.prefix}")
logger.info(f"python version: {sys.version}")
logger.info(f"python platform: {sys.platform}")
logger.info(f"libqtile path: {libqtile_path}")

secrets = secret.load_secrets()
settings = setting.load_settings()

groups = group.build_groups(settings) + scratchpad.build_scratchpads(settings)

dgroups_app_rules = rule.build_rules()

keys = (
    kbdmouse.build_keys(settings)
    + group.build_keys(settings)
    + scratchpad.build_keys(settings)
)
mouse = kbdmouse.bind_mouse_buttons(settings)

theme = settings["theme"]
layouts = [
    layout.MonadTall(**theme["layout"]),
    layout.Max(**theme["layout"]),
]

top_bar, bottom_bar = bars.build_bars(settings, secrets)
screens = [
    Screen(
        top=top_bar,
        bottom=bottom_bar,
        wallpaper=wallpaper.get_wallpaper(),
        wallpaper_mode="fill",
    ),
]

auto_fullscreen = True
bring_front_click = "floating_only"
cursor_warp = False
extension_defaults = theme["extension"].copy()
focus_on_window_activation = "smart"
follow_mouse_focus = False
widget_defaults = theme["widget"].copy()
wmname = "QTile"


# to get ids use `qtile cmd-obj -o core -f get_inputs`
wl_input_rules = {
    "1452:591:Keychron Keychron K1": InputConfig(
        kb_options="altwin:swap_lalt_lwin", kb_layout="us"
    ),
    "1133:45082:MX Anywhere 2S Mouse": InputConfig(natural_scroll=True),
}


def systemd_run(command: list[str]) -> list[str]:
    return [
        "systemd-run",
        "--collect",
        "--user",
        f"--unit={command[0]}",
        "--",
        *command,
    ]


@hook.subscribe.startup_once
def start_once():
    commands = [
        [
            "systemctl",
            "--user",
            "import-environment",
            "WAYLAND_DISPLAY",
            "MPD_HOST",
        ],
    ]
    for command in commands:
        subprocess.Popen(systemd_run(command))


@hook.subscribe.startup
def start():
    sway_lock = [
        "swaylock",
        "--clock",
        "--indicator-radius 100",
        "--indicator-thickness 7",
        "--ring-color bb00cc",
        "--key-hl-color 880033",
        "--line-color 00000000",
        "--inside-color 00000088",
    ]
    commands = [
        [
            "swayidle",
            "-w",
            "timeout",
            "300",
            shlex.join(sway_lock),
            "before-sleep",
            shlex.join(sway_lock),
        ],
    ]
    for command in commands:
        subprocess.Popen(systemd_run(command))
