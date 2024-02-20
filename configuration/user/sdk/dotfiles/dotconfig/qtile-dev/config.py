import os
import socket
import subprocess
import sys
from pathlib import Path
from typing import List  # noqa: F401

from libqtile import bar, extension, hook, layout, widget
from libqtile.command import lazy
from libqtile.config import Screen

import yaml

import bar
import group
import kbdmouse
import rule
import secret
import settings

sec = secret.load_secrets()
s = settings.load_settings()
keys = kbdmouse.bind_keys(s)
mouse = kbdmouse.bind_mouse_buttons(s)
groups = group.build_groups(s)
group.bind_group_keys(s, keys)
bars = bar.build_bars(s, sec)

theme = s["theme"]
layouts = [
    layout.MonadTall(**theme["layout"]),
    layout.Max(**theme["layout"]),
]

screens = [Screen(top=bars[0], bottom=bars[1])]

widget_defaults = theme["widget"].copy()
extension_defaults = theme["extension"].copy()

dgroups_key_binder = None
dgroups_app_rules = rule.build_rules()  # type: List
main = None
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"


@hook.subscribe.client_new
def client_to_group(client):
    wm_class = client.window.get_wm_class()[0]
    group_name = group.find_group_for(wm_class)
    if group_name:
        client.togroup(group_name)
        lazy.group[group_name].cmd_toscreen(toggle=False)


wmname = "qtile"
