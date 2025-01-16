"""Bars for Qtile"""

import os
from libqtile.log_utils import logger

from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration
from libqtile.bar import Bar as QtileBar

from qgroup.line_sep import LineSeparator
from qgroup.user_menu import UserMenu
from qgroup.system_menu import SystemMenu
from qgroup.date_time import DateTime
from qgroup.volume import Volume
from qgroup.group_box import GroupBox
from qgroup.current_layout import CurrentLayout
from qgroup.weather import Weather
from qgroup.window_name import WindowName
from qgroup.network_status import NetworkStatus
from qgroup.memory_status import MemoryStatus
from qgroup.cpu_usage_status import CPUUsageStatus
from qgroup.cpu_temp_status import CPUTempStatus
from qgroup.spacer import Spacer
from qgroup.music import MusicStatus

from theme.utils import opacity_to_str
from theme.defs.theme import ThemeDefinition

NET_INTERFACE = "wlp3s0"
TERMINAL = os.environ.get("TERMINAL", "xterm")


def build_top_bar(settings: dict, theme: ThemeDefinition) -> QtileBar | None:
    colors = theme["named_colors"]
    height = theme["bar"]["top"]["height"]
    margin = theme["bar"]["top"]["margin"]
    opacity = theme["bar"]["top"].get("opacity", 1.0)
    opacity_str = opacity_to_str(opacity)

    powerline = None
    if "powerline_separator" in theme:
        powerline = [
            PowerLineDecoration(path=theme["powerline_separator"][0]),
            PowerLineDecoration(path=theme["powerline_separator"][1]),
        ]

    user_menu_opts = {"background": f"{colors['powerline_bg'][-1]}{opacity_str}"}
    weather_opts = {
        "background": f"{colors['powerline_bg'][0]}{opacity_str}",
        "app_key": os.environ.get("OWM_API_KEY", ""),
        "coordinates": {
            "latitude": os.environ.get("USER_LOCATION_LATITUDE", "51.5"),
            "longitude": os.environ.get("USER_LOCATION_LONGITUDE", "-0.15"),
        },
        "format": "{main_temp}/{main_feels_like}°{units_temperature} {icon}",
    }
    volume_opts = {
        "background": f"{colors['powerline_bg'][1]}{opacity_str}",
        "volume_up_command": settings["volume"]["up"],
        "volume_down_command": settings["volume"]["down"],
        "mute_command": settings["volume"]["toggle"],
        "volume_app": settings["volume"]["app"],
    }
    date_time_opts = {
        "background": f"{colors['powerline_bg'][2]}{opacity_str}",
    }
    system_menu_opts = {"background": f"{colors['powerline_bg'][-1]}{opacity_str}"}

    start = [
        UserMenu(settings, theme, user_menu_opts),
        LineSeparator(settings, theme),
        GroupBox(settings, theme),
        LineSeparator(settings, theme),
        CurrentLayout(settings, theme),
    ]

    middle = [
        WindowName(settings, theme),
    ]

    end = [
        Weather(settings, theme, weather_opts),
        Volume(settings, theme, volume_opts),
        DateTime(settings, theme, date_time_opts),
        SystemMenu(settings, theme, system_menu_opts),
    ]

    widgets = []
    for idx, group in enumerate(start):
        if idx != 0 and powerline is not None:
            group.decorations.append(powerline[0])
        widgets.extend(group.widgets())

    for idx, group in enumerate(middle):
        widgets.extend(group.widgets())

    for idx, group in enumerate(end):
        if idx != len(end) - 1 and powerline is not None:
            group.decorations.append(powerline[1])
        widgets.extend(group.widgets())

    return QtileBar(
        widgets,
        size=height,
        margin=margin,
        background=f"{colors['panel_bg']}{opacity_str}",
    )


def build_bottom_bar(settings: dict, theme: ThemeDefinition) -> QtileBar | None:
    colors = theme["named_colors"]
    height = theme["bar"]["top"]["height"]
    margin = theme["bar"]["top"]["margin"]
    opacity = theme["bar"]["top"].get("opacity", 1.0)
    opacity_str = opacity_to_str(opacity)

    powerline = None
    if "powerline_separator" in theme:
        powerline = [
            PowerLineDecoration(path=theme["powerline_separator"][0]),
            PowerLineDecoration(path=theme["powerline_separator"][1]),
        ]

    network_status_opts = {
        "interface": NET_INTERFACE,
        "background": f"{colors['powerline_bg'][4]}{opacity_str}",
    }
    memory_status_opts = {
        "format": "{MemUsed:6.0f}M/{MemTotal:.0f}M",
        "background": f"{colors['powerline_bg'][5]}{opacity_str}",
    }
    cpu_usage_opts = {
        "background": f"{colors['powerline_bg'][6]}{opacity_str}",
    }
    cpu_temp_opts = {
        "background": f"{colors['powerline_bg'][7]}{opacity_str}",
    }
    music_status_opts = {
        "status_format": "{play_status} {title} | {artist} | {album}",
        "idle_format": "Play queue empty",
    }

    start = [
        NetworkStatus(settings, theme, network_status_opts),
        MemoryStatus(settings, theme, memory_status_opts),
        CPUUsageStatus(settings, theme, cpu_usage_opts),
        CPUTempStatus(settings, theme, cpu_temp_opts),
    ]

    middle = [
        Spacer(settings, theme),
    ]

    end = [
        MusicStatus(settings, theme, music_status_opts),
    ]

    widgets = []
    for idx, group in enumerate(start):
        if idx != 0 and powerline is not None:
            group.decorations.append(powerline[0])
        widgets.extend(group.widgets())

    for idx, group in enumerate(middle):
        widgets.extend(group.widgets())

    for idx, group in enumerate(end):
        if idx != len(end) - 1 and powerline is not None:
            group.decorations.append(powerline[1])
        widgets.extend(group.widgets())

    return QtileBar(
        widgets,
        size=height,
        margin=margin,
        background=f"{colors['panel_bg']}{opacity_str}",
    )


def build_bars(settings: dict, theme: ThemeDefinition) -> list[QtileBar]:
    bars = []
    top = build_top_bar(settings, theme)
    if top is not None:
        bars.append(top)
    bottom = build_bottom_bar(settings, theme)
    if bottom is not None:
        bars.append(bottom)
    return bars
