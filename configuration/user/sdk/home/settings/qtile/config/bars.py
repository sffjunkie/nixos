"""Bars for Qtile"""

import os
from libqtile.log_utils import logger

from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration
from libqtile.bar import Bar as QtileBar

from qbar.context import BarContext

from qgroup.context import GroupPosition, GroupContext
from qgroup.cpu_temp_status import CPUTempStatus
from qgroup.cpu_usage_status import CPUUsageStatus
from qgroup.current_layout import CurrentLayout
from qgroup.date_time import DateTime
from qgroup.group_box import GroupBox
from qgroup.line_sep import LineSeparator
from qgroup.memory_status import MemoryStatus
from qgroup.music import MusicStatus
from qgroup.network_status import NetworkStatus
from qgroup.spacer import Spacer
from qgroup.system_menu import SystemMenu
from qgroup.user_menu import UserMenu
from qgroup.volume import Volume
from qgroup.weather import Weather
from qgroup.window_name import WindowName

from theme.defs.theme import ThemeDefinition

NET_INTERFACE = "wlp3s0"
TERMINAL = os.environ.get("TERMINAL", "xterm")


def build_top_bar(settings: dict, theme: ThemeDefinition) -> QtileBar | None:
    colors = theme["named_colors"]
    bar_context = BarContext("top", settings, theme)

    powerline = None
    if "powerline_separator" in theme:
        powerline = [
            PowerLineDecoration(path=theme["powerline_separator"][0]),
            PowerLineDecoration(path=theme["powerline_separator"][1]),
        ]

    widgets = []

    # region start
    user_menu_context = GroupContext(
        GroupPosition.START,
        bar_context,
        settings,
        theme,
        props={"background": colors["powerline_bg"][-1]},
    )

    start = [
        UserMenu(user_menu_context),
        LineSeparator(
            GroupContext(
                GroupPosition.START,
                bar_context,
                settings,
                theme,
                props={"background": colors["panel_bg"]},
            )
        ),
        GroupBox(
            GroupContext(
                GroupPosition.START,
                bar_context,
                settings,
                theme,
                props={"background": colors["panel_bg"]},
            )
        ),
        LineSeparator(
            GroupContext(
                GroupPosition.START,
                bar_context,
                settings,
                theme,
                props={"background": colors["panel_bg"]},
            )
        ),
        CurrentLayout(
            GroupContext(
                GroupPosition.START,
                bar_context,
                settings,
                theme,
                props={"background": colors["panel_bg"]},
            )
        ),
    ]

    for idx, group in enumerate(start):
        if idx != 0 and powerline is not None:
            group.decorations.append(powerline[0])
        widgets.extend(group.widgets())
    # endregion

    # region middle
    middle = [
        WindowName(
            GroupContext(
                GroupPosition.MIDDLE,
                bar_context,
                settings,
                theme,
                props={"background": colors["panel_bg"]},
            )
        ),
    ]

    for idx, group in enumerate(middle):
        widgets.extend(group.widgets())
    # endregion

    # region end
    weather_context = GroupContext(
        GroupPosition.END,
        bar_context,
        settings,
        theme,
        props={
            "background": colors["powerline_bg"][0],
            "weather": {
                "app_key": os.environ.get("OWM_API_KEY", ""),
                "coordinates": {
                    "latitude": os.environ.get("USER_LOCATION_LATITUDE", "51.5"),
                    "longitude": os.environ.get("USER_LOCATION_LONGITUDE", "-0.15"),
                },
                "format": "{main_temp}/{main_feels_like}°{units_temperature} {icon}",
            },
        },
    )

    volume_context = GroupContext(
        GroupPosition.END,
        bar_context,
        settings,
        theme,
        props={
            "background": colors["powerline_bg"][1],
            "volume": {
                "volume_up_command": settings["volume"]["up"],
                "volume_down_command": settings["volume"]["down"],
                "mute_command": settings["volume"]["toggle"],
                "volume_app": settings["volume"]["app"],
            },
        },
    )

    date_time_context = GroupContext(
        GroupPosition.END,
        bar_context,
        settings,
        theme,
        props={
            "background": f"{colors['powerline_bg'][2]}",
        },
    )

    system_menu_context = GroupContext(
        GroupPosition.END,
        bar_context,
        settings,
        theme,
        props={"background": colors["powerline_bg"][-1]},
    )

    end = [
        Weather(weather_context),
        Volume(volume_context),
        DateTime(date_time_context),
        SystemMenu(system_menu_context),
    ]

    for idx, group in enumerate(end):
        if idx != len(end) - 1 and powerline is not None:
            group.decorations.append(powerline[1])
        widgets.extend(group.widgets())
    # endregion

    return QtileBar(
        widgets,
        size=bar_context.height,
        margin=bar_context.margin,
        background=f"{colors['panel_bg']}{bar_context.opacity_str}",
    )


def build_bottom_bar(settings: dict, theme: ThemeDefinition) -> QtileBar | None:
    colors = theme["named_colors"]
    bar_context = BarContext("bottom", settings, theme)

    widgets = []

    powerline = None
    if "powerline_separator" in theme:
        powerline = [
            PowerLineDecoration(path=theme["powerline_separator"][0]),
            PowerLineDecoration(path=theme["powerline_separator"][1]),
        ]

    # region start
    network_status_context = GroupContext(
        GroupPosition.START,
        bar_context,
        settings,
        theme,
        props={
            "network": {
                "interface": NET_INTERFACE,
            },
            "background": f"{colors['powerline_bg'][4]}{bar_context.opacity_str}",
        },
    )
    memory_status_context = GroupContext(
        GroupPosition.START,
        bar_context,
        settings,
        theme,
        props={
            "memory": {
                "format": "{MemUsed:6.0f}M/{MemTotal:.0f}M",
            },
            "background": f"{colors['powerline_bg'][5]}{bar_context.opacity_str}",
        },
    )
    cpu_usage_context = GroupContext(
        GroupPosition.START,
        bar_context,
        settings,
        theme,
        props={
            "background": f"{colors['powerline_bg'][6]}{bar_context.opacity_str}",
        },
    )
    cpu_temp_context = GroupContext(
        GroupPosition.START,
        bar_context,
        settings,
        theme,
        props={
            "background": f"{colors['powerline_bg'][7]}{bar_context.opacity_str}",
        },
    )

    start = [
        NetworkStatus(network_status_context),
        MemoryStatus(memory_status_context),
        CPUUsageStatus(cpu_usage_context),
        CPUTempStatus(cpu_temp_context),
    ]

    for idx, group in enumerate(start):
        if idx != 0 and powerline is not None:
            group.decorations.append(powerline[0])
        widgets.extend(group.widgets())
    # endregion

    # region middle
    middle = [
        Spacer(
            GroupContext(
                GroupPosition.MIDDLE,
                bar_context,
                settings,
                theme,
                props={"background": colors["panel_bg"]},
            )
        ),
    ]

    for idx, group in enumerate(middle):
        widgets.extend(group.widgets())
    # endregion

    # region
    music_status_context = GroupContext(
        GroupPosition.START,
        bar_context,
        settings,
        theme,
        props={
            "music": {
                "status_format": "{play_status} {title} | {artist} | {album}",
                "idle_format": "Play queue empty",
            }
        },
    )

    end = [
        MusicStatus(music_status_context),
    ]

    for idx, group in enumerate(end):
        if idx != len(end) - 1 and powerline is not None:
            group.decorations.append(powerline[1])
        widgets.extend(group.widgets())
    # endregion

    return QtileBar(
        widgets,
        size=bar_context.height,
        margin=bar_context.margin,
        background=f"{colors['panel_bg']}{bar_context.opacity_str}",
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
