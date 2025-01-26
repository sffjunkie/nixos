"""Bars for Qtile"""

import os

# from libqtile.log_utils import logger  # type: ignore
from libqtile.bar import Bar as QBar  # type: ignore
from qtile_extras.widget import Spacer as QSpacer  # type: ignore

from qbar.context import BarContext

from qmodule.context import ModuleContext
from qmodule.cpu_temp_status import CPUTempStatus
from qmodule.cpu_usage_status import CPUUsageStatus
from qmodule.current_layout import CurrentLayout
from qmodule.date_time import DateTime
from qmodule.group_box import GroupBox
from qmodule.memory_status import MemoryStatus
from qmodule.music import MusicStatus
from qmodule.network_status import NetworkStatus
from qmodule.separator import Separator
from qmodule.system_menu import SystemMenu
from qmodule.user_menu import UserMenu
from qmodule.volume_status import VolumeStatus
from qmodule.weather import Weather
from qmodule.window_name import WindowName

from qmodule.base import WidgetModule
from theme.defs.theme import ThemeDefinition

NET_INTERFACE = "wlp3s0"
TERMINAL = os.environ.get("TERMINAL", "xterm")


def build_top_bar(settings: dict, theme: ThemeDefinition) -> QBar | None:
    colors = theme["named_colors"]
    bar_context = BarContext("top", settings, theme)

    widgets = []

    separator = Separator(
        ModuleContext(
            bar_context,
            settings,
            theme,
        )
    )

    # region start
    start: list[WidgetModule] = [
        UserMenu(
            ModuleContext(
                bar_context,
                settings,
                theme,
                props={
                    "background": colors["powerline_bg"][-1],
                },
            )
        ),
        GroupBox(
            ModuleContext(
                bar_context,
                settings,
                theme,
                props={
                    "background": colors["panel_bg"],
                },
            )
        ),
        CurrentLayout(
            ModuleContext(
                bar_context,
                settings,
                theme,
                props={
                    "background": colors["panel_bg"],
                },
            )
        ),
    ]

    for idx, group in enumerate(start):
        if idx != 0:
            widgets.extend(separator.widgets())

        widgets.extend(group.widgets(group_id=idx))
    # endregion

    # region middle
    middle: list[WidgetModule] = [
        WindowName(
            ModuleContext(
                bar_context,
                settings,
                theme,
                props={
                    "group": 4,
                    "background": colors["panel_bg"],
                },
            )
        ),
    ]

    if middle == []:
        widgets.append(QSpacer())
    else:
        widgets.extend(separator.widgets())
        for idx, group in enumerate(middle, start=idx + 1):
            widgets.extend(group.widgets(group_id=idx))
        widgets.extend(separator.widgets())
    # endregion

    # region end
    weather_context = ModuleContext(
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

    volume_context = ModuleContext(
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

    date_time_context = ModuleContext(
        bar_context,
        settings,
        theme,
        props={
            "background": f"{colors['powerline_bg'][2]}",
        },
    )

    system_menu_context = ModuleContext(
        bar_context,
        settings,
        theme,
        props={
            "background": colors["powerline_bg"][-1],
        },
    )

    end: list[WidgetModule] = [
        Weather(weather_context),
        VolumeStatus(volume_context),
        DateTime(date_time_context),
        SystemMenu(system_menu_context),
    ]

    group_id = idx + 1
    for idx, group in enumerate(end):
        widgets.extend(group.widgets(group_id=group_id + idx))
        if idx != len(end) - 1:
            widgets.extend(separator.widgets())

    # endregion

    return QBar(
        widgets,
        size=bar_context.height,
        margin=bar_context.margin,
        background=f"{colors['panel_bg']}{bar_context.opacity_str}",
    )


def build_bottom_bar(settings: dict, theme: ThemeDefinition) -> QBar | None:
    colors = theme["named_colors"]
    bar_context = BarContext("bottom", settings, theme)

    widgets = []

    separator = Separator(
        ModuleContext(
            bar_context,
            settings,
            theme,
        )
    )

    # region start
    network_status_context = ModuleContext(
        bar_context,
        settings,
        theme,
        props={
            "network": {
                "interface": NET_INTERFACE,
            },
            "background": f"{colors['powerline_bg'][4]}",
        },
    )
    memory_status_context = ModuleContext(
        bar_context,
        settings,
        theme,
        props={
            "memory": {
                "format": "{MemUsed:6.0f}M/{MemTotal:.0f}M",
            },
            "background": f"{colors['powerline_bg'][5]}",
        },
    )
    cpu_usage_context = ModuleContext(
        bar_context,
        settings,
        theme,
        props={
            "background": f"{colors['powerline_bg'][6]}",
        },
    )
    cpu_temp_context = ModuleContext(
        bar_context,
        settings,
        theme,
        props={
            "background": f"{colors['powerline_bg'][7]}",
        },
    )

    start: list[WidgetModule] = [
        NetworkStatus(network_status_context),
        MemoryStatus(memory_status_context),
        CPUUsageStatus(cpu_usage_context),
        CPUTempStatus(cpu_temp_context),
    ]

    for idx, group in enumerate(start):
        if idx != 0:
            widgets.extend(separator.widgets())

        widgets.extend(group.widgets(group_id=idx))
    # endregion

    # region middle
    middle: list[WidgetModule] = []

    if middle == []:
        widgets.append(QSpacer(background="#FFFFFF00"))
    else:
        widgets.extend(separator.widgets())
        for idx, group in enumerate(middle, start=idx + 1):
            widgets.extend(group.widgets(group_id=idx))
        widgets.extend(separator.widgets())
    # endregion

    # region end
    music_status_context = ModuleContext(
        bar_context,
        settings,
        theme,
        props={
            "music": {
                "status_format": "{play_status} {title} | {artist} | {album}",
                "idle_format": "Play queue empty",
            },
            "background": f"{colors['powerline_bg'][-1]}",
        },
    )

    end: list[WidgetModule] = [
        MusicStatus(music_status_context),
    ]

    group_id = idx + 1
    for idx, group in enumerate(end):
        widgets.extend(group.widgets(group_id=group_id + idx))
        if idx != len(end) - 1:
            widgets.extend(separator.widgets())
    # endregion

    return QBar(
        widgets,
        size=bar_context.height,
        margin=bar_context.margin,
        background=f"{colors['panel_bg']}{bar_context.opacity_str}",
    )


def build_bars(settings: dict, theme: ThemeDefinition) -> dict[str, QBar]:
    bars = {}
    bars["top"] = build_top_bar(settings, theme)
    bars["bottom"] = build_bottom_bar(settings, theme)
    return bars
