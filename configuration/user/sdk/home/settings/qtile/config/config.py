import os
import subprocess
import sys
from pathlib import Path

from libqtile import __path__ as libqtile_path
from libqtile import hook, layout
from libqtile.backend.wayland import InputConfig
from libqtile.config import Screen
from libqtile.log_utils import logger

import bars
import floating
import group
import kbdmouse
import scratchpad
import wallpaper
from secret import load_secrets
from setting import load_settings
from theme import load_theme

is_nixos = os.path.exists("/etc/NIXOS")

logger.warning(f"python prefix: {sys.prefix}")
logger.warning(f"python version: {sys.version}")
logger.warning(f"python platform: {sys.platform}")
logger.warning(f"python path: {sys.path}")
logger.warning(f"libqtile path: {libqtile_path}")

secrets = load_secrets()
settings = load_settings()

fwd = Path(__file__).parent
theme_path = fwd / "theme.yaml"
theme = load_theme(theme_path.absolute())
logger.warning(f"theme path: {theme_path}")

top_bar, bottom_bar = bars.build_bars(settings=settings, theme=theme)
screens = [
    Screen(
        top=top_bar,
        bottom=bottom_bar,
        wallpaper=wallpaper.get_wallpaper(),
        wallpaper_mode="fill",
    ),
]

groups = group.build_groups(settings) + scratchpad.build_scratchpads(settings)

dgroups_app_rules = group.build_rules()

keys = (
    kbdmouse.build_keys(settings)
    + group.build_keys(settings)
    + scratchpad.build_keys(settings)
)
mouse = kbdmouse.bind_mouse_buttons(settings)

floating_layout = floating.build_layout(theme=theme)
layouts = [
    layout.MonadTall(**theme["layout"]),
    layout.Max(**theme["layout"]),
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
        ],
    ]
    for command in commands:
        subprocess.Popen(systemd_run(command))
