"""Bars for Qtile"""

import os

from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration
from libqtile.bar import Bar as QtileBar

from qbar.bar import Bar
from qbar.position import BarPosition, GroupPosition
from qwidgets.icon import MDIcon
from qwidgets.line_sep import LineSeparator
from qwidgets.user_menu import UserMenu
from qwidgets.system_menu import SystemMenu
from qwidgets.date_time import DateTime
from qwidgets.volume import Volume
from qwidgets.group_box import GroupBox
from qwidgets.current_layout import CurrentLayout
from qwidgets.weather import Weather
from qwidgets.window_name import WindowName
from qwidgets.network_status import NetworkStatus
from qwidgets.memory_status import MemoryStatus
from qwidgets.cpu_usage_status import CPUUsageStatus
from qwidgets.cpu_temp_status import CPUTempStatus
from qwidgets.spacer import Spacer
from qwidgets.music import MusicStatus
from theme.defs import ThemeDefinition

NET_INTERFACE = "wlp3s0"
TERMINAL = os.environ.get("TERMINAL", "xterm")


def build_top_bar(settings: dict, theme: ThemeDefinition) -> QtileBar | None:
    if BarPosition.TOP not in theme["bars"]:
        return None

    bar = Bar(BarPosition.TOP, theme)

    user_menu_opts = {
        "background": f"{theme.color_scheme['powerline_bg'][-1]}{bar.opacity_str}"
    }
    weather_opts = {
        "background": f"{theme.color_scheme['powerline_bg'][0]}{bar.opacity_str}",
        "app_key": os.environ.get("OWM_API_KEY", ""),
        "coordinates": {
            "latitude": os.environ.get("USER_LOCATION_LATITUDE", "51.5"),
            "longitude": os.environ.get("USER_LOCATION_LONGITUDE", "-0.15"),
        },
        "format": "{main_temp}/{main_feels_like}°{units_temperature} {icon}",
    }
    volume_opts = {
        "background": f"{theme.color_scheme['powerline_bg'][1]}{bar.opacity_str}",
        "volume_up_command": settings.config["volume"]["up"],
        "volume_down_command": settings.config["volume"]["down"],
        "mute_command": settings.config["volume"]["toggle"],
        "volume_app": settings.config["volume"]["app"],
    }
    date_time_opts = {
        "background": f"{theme.color_scheme['powerline_bg'][2]}{bar.opacity_str}",
    }
    system_menu_opts = {
        "background": f"{theme.color_scheme['powerline_bg'][-1]}{bar.opacity_str}"
    }

    start = [
        UserMenu(bar, theme, user_menu_opts),
        LineSeparator(bar, theme),
        GroupBox(bar, theme),
        LineSeparator(bar, theme),
        CurrentLayout(bar, theme),
    ]

    middle = [
        WindowName(bar, theme),
    ]

    end = [
        Weather(bar, theme, weather_opts),
        Volume(bar, theme, volume_opts),
        DateTime(bar, theme, date_time_opts),
        SystemMenu(bar, theme, system_menu_opts),
    ]

    widgets = []
    for idx, group in enumerate(start):
        if idx != 0 and bar.powerline is not None and bar.powerline_start:
            group.decorations.append(bar.powerline[0])
        widgets.extend(group.widgets())

    for idx, group in enumerate(middle):
        widgets.extend(group.widgets())

    for idx, group in enumerate(end):
        if idx != len(end) - 1 and bar.powerline is not None and bar.powerline_end:
            group.decorations.append(bar.powerline[1])
        widgets.extend(group.widgets())

    return bar.build(widgets)


def build_bottom_bar(settings: dict, theme: ThemeDefinition) -> QtileBar | None:
    if BarPosition.BOTTOM not in theme["bars"]:
        return None

    bar = Bar(BarPosition.BOTTOM, theme)

    network_status_opts = {
        "interface": NET_INTERFACE,
        "background": f"{bar.color_scheme['powerline_bg'][4]}{bar.opacity_str}",
    }
    memory_status_opts = {
        "format": "{MemUsed:6.0f}M/{MemTotal:.0f}M",
        "background": f"{bar.color_scheme['powerline_bg'][5]}{bar.opacity_str}",
    }
    cpu_usage_opts = {
        "background": f"{bar.color_scheme['powerline_bg'][6]}{bar.opacity_str}",
    }
    cpu_temp_opts = {
        "background": f"{bar.color_scheme['powerline_bg'][7]}{bar.opacity_str}",
    }
    music_status_opts = {
        "status_format": "{play_status} {title} | {artist} | {album}",
        "idle_format": "Play queue empty",
    }

    widgets = []
    for group in [
        NetworkStatus(bar, GroupPosition.START, theme, network_status_opts),
        MemoryStatus(bar, GroupPosition.START, theme, memory_status_opts),
        CPUUsageStatus(bar, GroupPosition.START, theme, cpu_usage_opts),
        CPUTempStatus(bar, GroupPosition.START, theme, cpu_temp_opts),
        Spacer(bar, GroupPosition.START, theme),
        MusicStatus(bar, GroupPosition.START, theme, music_status_opts),
    ]:
        widgets.extend(group.widgets())

    bar_widgets = [
        # region Temps
        MDIcon(
            name="cpu_temp",
            width=bar.height,
            font=bar.icon_font_family,
            fontsize=bar.icon_font_size,
            background=f"{bar.color_scheme['powerline_bg'][7]}{bar.opacity_str}",
        ),
        widget.ThermalSensor(
            font=bar.text_font_family,
            fontsize=bar.text_font_size,
            background=f"{bar.color_scheme['powerline_bg'][7]}{bar.opacity_str}",
        ),
        widget.Sep(
            padding=12,
            linewidth=0,
            background=f"{bar.color_scheme['powerline_bg'][7]}{bar.opacity_str}",
            **bar.powerline_left,
        ),
        # endregion
        # endregion
        widget.Spacer(
            background=f"{bar.color_scheme['panel_bg']}{bar.opacity_str}",
            **bar.powerline_right,
        ),
        # region Bottom RHS
        widget.Sep(
            padding=12,
            linewidth=0,
            background=f"{bar.color_scheme['powerline_bg'][1]}{bar.opacity_str}",
        ),
        widget.Mpd2(
            status_format="{play_status} {title} | {artist} | {album}",
            idle_format="Play queue empty",
            font=bar.text_font_family,
            fontsize=bar.text_font_size,
            background=f"{bar.color_scheme['powerline_bg'][1]}{bar.opacity_str}",
        ),
        MDIcon(
            name="music",
            width=bar.height,
            font=bar.icon_font_family,
            fontsize=bar.icon_font_size,
            background=f"{bar.color_scheme['powerline_bg'][1]}{bar.opacity_str}",
        ),
        # endregion
    ]

    return QtileBar(
        bar_widgets,
        size=bar.height,
        background=f"{bar.color_scheme['panel_bg']}{bar.opacity_str}",
        margin=theme["bar"]["bottom"]["margin"],
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
