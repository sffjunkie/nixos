import shlex
import subprocess
from typing import List

from libqtile import layout, hook
from libqtile.config import Screen
from libqtile.backend.wayland import InputConfig

import bars
import group
import kbdmouse
import rule
import secret
import setting

sec = secret.load_secrets()
s = setting.load_settings()
keys = kbdmouse.bind_keys(s)
mouse = kbdmouse.bind_mouse_buttons(s)
groups = group.build_groups(s)
group.bind_group_keys(s, keys)

theme = s["theme"]
layouts = [
    layout.MonadTall(**theme["layout"]),
    layout.Max(**theme["layout"]),
]

top_bar, bottom_bar = bars.build_bars(s, sec)
screens = [Screen(top=top_bar, bottom=bottom_bar)]

auto_fullscreen = True
bring_front_click = "floating_only"
cursor_warp = False
# dgroups_app_rules = rule.build_rules()  # type: List
dgroups_key_binder = None
extension_defaults = theme["extension"].copy()
focus_on_window_activation = "smart"
follow_mouse_focus = False
widget_defaults = theme["widget"].copy()
wmname = "QTile"

# @hook.subscribe.client_new
# def client_to_group(client):
#     wm_class = client.window.get_wm_class()[0]
#     group_name = group.find_group_for(wm_class)
#     if group_name:
#         client.togroup(group_name)
# lazy.group[group_name].cmd_toscreen()

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


@hook.subscribe.startup
def autostart():
    subprocess.run(
        [
            "systemctl",
            "--user",
            "import-environment",
            "WAYLAND_DISPLAY",
        ]
    )
    sway_lock = [
        "swaylock",
        "--screenshots",
        "--clock",
        "--indicator",
        "--indicator-radius 100",
        "--indicator-thickness 7",
        "--ring-color bb00cc",
        "--key-hl-color 880033",
        "--line-color 00000000",
        "--inside-color 00000088",
        "--separator-color 00000000",
        "--grace 10",
        "--fade-in 0.2",
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
        [
            "waypaper",
            "--restore",
        ],
    ]
    for command in commands:
        subprocess.Popen(systemd_run(command))
