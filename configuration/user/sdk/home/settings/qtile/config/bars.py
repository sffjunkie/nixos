"""Bars for Qtile"""

import os

from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration
from libqtile.bar import Bar as QtileBar

from qbar.bar import Bar
from qbar.location import BarLocation
from qwidgets.net_min import NetMin
from qwidgets.icon import MDIcon
from qwidgets.line_sep import LineSeparator
from qwidgets.user_menu import UserMenuWidget
from qwidgets.user_name import UserNameWidget
from qwidgets.system_menu import SystemMenuWidget
from theme.utils import opacity_to_str
from theme.defs import ThemeDefinition


NET_INTERFACE = "wlp3s0"
TERMINAL = os.environ.get("TERMINAL", "xterm")


def build_top_bar(settings: dict, theme: ThemeDefinition) -> QtileBar | None:
    if BarLocation.TOP not in theme["bars"]:
        return None

    bar = Bar(BarLocation.TOP, theme)

    widgets = [
        # region LHS
        UserMenuWidget(theme, width=bar.height),
        LineSeparator(theme, width=bar.height),
        widget.GroupBox(
            margin_y=3,
            padding_y=4,
            margin_x=6,
            padding_x=6,
            borderwidth=0,
            font=bar.text_font_family,
            fontsize=bar.text_font_size,
            foreground=bar.color_scheme["panel_fg"],
            background=f"{bar.color_scheme['panel_bg']}{bar.opacity_str}",
            active=bar.color_scheme["group_active_fg"],
            inactive=bar.color_scheme["group_inactive_fg"],
            rounded=True,
            highlight_method="block",
            this_current_screen_border=bar.color_scheme["group_current_bg"],
            this_screen_border=bar.color_scheme["group_current_bg"],
            use_mouse_wheel=False,
            # other_current_screen_border=theme_colors["panel_bg"],
            # other_screen_border=theme_colors["panel_bg"],
        ),
        LineSeparator(theme, width=bar.height),
        widget.CurrentLayout(
            padding=12,
            font=bar.text_font_family,
            fontsize=bar.text_font_size,
            foreground=bar.color_scheme["panel_fg"],
            background=f"{bar.color_scheme['panel_bg']}{bar.opacity_str}",
        ),
        widget.Spacer(
            background=f"{bar.color_scheme['panel_bg']}{bar.opacity_str}",
        ),
        widget.WindowName(
            font=bar.text_font_family,
            fontsize=bar.text_font_size,
            foreground=bar.color_scheme["panel_fg"],
            background=f"{bar.color_scheme['panel_bg']}{bar.opacity_str}",
        ),
        widget.Spacer(
            background=f"{bar.color_scheme['panel_bg']}{bar.opacity_str}",
            **bar.powerline_right,
        ),
        # endregion
        # region RHS
        widget.OpenWeather(
            app_key=os.environ.get("OWM_API_KEY", ""),
            coordinates={
                "latitude": os.environ.get("USER_LOCATION_LATITUDE", "51.5"),
                "longitude": os.environ.get("USER_LOCATION_LONGITUDE", "-0.15"),
            },
            format="{main_temp}/{main_feels_like}°{units_temperature} {icon}",
            padding=12,
            font=bar.text_font_family,
            fontsize=bar.text_font_size,
            background=f"{bar.color_scheme['powerline_bg'][3]}{bar.opacity_str}",
            **bar.powerline_right,
        ),
        widget.PulseVolume(
            volume_up_command=settings["volume"]["up"],
            volume_down_command=settings["volume"]["down"],
            mute_command=settings["volume"]["toggle"],
            volume_app=settings["volume"]["app"],
            menu_font=bar.text_font_family,
            menu_fontsize=int(bar.text_font_size * 0.8),
            menu_width=500,
            menu_offset_x=-250,
            padding=12,
            # iconfont = "Material Design Icons",
            font=bar.text_font_family,
            fontsize=bar.text_font_size,
            background=f"{bar.color_scheme['powerline_bg'][2]}{bar.opacity_str}",
        ),
        MDIcon(
            name="volume",
            font=bar.icon_font_family,
            fontsize=bar.icon_font_size,
            background=f"{bar.color_scheme['powerline_bg'][2]}{bar.opacity_str}",
            **bar.powerline_right,
        ),
        widget.Sep(
            linewidth=0,
            background=f"{bar.color_scheme['powerline_bg'][0]}{bar.opacity_str}",
            padding=12,
        ),
        widget.Clock(
            format="%a %Y-%m-%d",
            font=bar.text_font_family,
            fontsize=bar.text_font_size,
            background=f"{bar.color_scheme['powerline_bg'][0]}{bar.opacity_str}",
        ),
        # calendar symbol
        MDIcon(
            name="calendar",
            font=bar.icon_font_family,
            fontsize=bar.icon_font_size,
            background=f"{bar.color_scheme['powerline_bg'][0]}{bar.opacity_str}",
            width=bar.height,
        ),
        widget.Sep(
            padding=6,
            linewidth=0,
            background=f"{bar.color_scheme['powerline_bg'][0]}{bar.opacity_str}",
        ),
        widget.Clock(
            format="%H:%M",
            font=bar.text_font_family,
            fontsize=bar.text_font_size,
            background=f"{bar.color_scheme['powerline_bg'][0]}{bar.opacity_str}",
        ),
        # clock symbol
        MDIcon(
            name="clock",
            width=bar.height,
            font=bar.icon_font_family,
            fontsize=bar.icon_font_size,
            background=f"{bar.color_scheme['powerline_bg'][0]}{bar.opacity_str}",
        ),
        # endregion
        # HostNameWidget(theme),
        SystemMenuWidget(
            theme,
            font=bar.text_font_family,
            fontsize=bar.text_font_size,
            width=bar.height,
        ),
    ]

    return bar.build(widgets)


def build_bottom_bar(settings: dict, theme: ThemeDefinition) -> QtileBar | None:
    if BarLocation.BOTTOM not in theme["bars"]:
        return None

    bar = Bar(BarLocation.TOP, theme)

    bar_widgets = [
        # region LHS
        # region Net
        MDIcon(
            name="net_up",
            width=bar.height,
            font=bar.icon_font_family,
            fontsize=bar.icon_font_size,
            background=f"{bar.color_scheme['powerline_bg'][4]}{bar.opacity_str}",
        ),
        NetMin(
            interface=NET_INTERFACE,
            format="{up} ",
            font=bar.text_font_family,
            fontsize=bar.text_font_size,
            background=f"{bar.color_scheme['powerline_bg'][4]}{bar.opacity_str}",
        ),
        MDIcon(
            name="net_down",
            width=bar.height,
            font=bar.icon_font_family,
            fontsize=bar.icon_font_size,
            background=f"{bar.color_scheme['powerline_bg'][4]}{bar.opacity_str}",
        ),
        NetMin(
            interface=NET_INTERFACE,
            format="{down}",
            font=bar.text_font_family,
            fontsize=bar.text_font_size,
            background=f"{bar.color_scheme['powerline_bg'][4]}{bar.opacity_str}",
        ),
        widget.Sep(
            padding=12,
            linewidth=0,
            background=f"{bar.color_scheme['powerline_bg'][4]}{bar.opacity_str}",
            **bar.powerline_left,
        ),
        # endregion
        # region Memory
        MDIcon(
            name="memory",
            width=bar.height,
            font=bar.icon_font_family,
            fontsize=bar.icon_font_size,
            background=f"{bar.color_scheme['powerline_bg'][5]}{bar.opacity_str}",
        ),
        widget.Memory(
            format="{MemUsed:6.0f}M/{MemTotal:.0f}M",
            font=bar.text_font_family,
            fontsize=bar.text_font_size,
            background=f"{bar.color_scheme['powerline_bg'][5]}{bar.opacity_str}",
        ),
        widget.Sep(
            padding=12,
            linewidth=0,
            background=f"{bar.color_scheme['powerline_bg'][5]}{bar.opacity_str}",
            **bar.powerline_left,
        ),
        # endregion
        # region CPU
        MDIcon(
            name="cpu_usage",
            width=bar.height,
            font=bar.icon_font_family,
            fontsize=bar.icon_font_size,
            background=f"{bar.color_scheme['powerline_bg'][6]}{bar.opacity_str}",
        ),
        widget.CPU(
            format="{load_percent:4.1f}%",
            update_interval=5,
            font=bar.text_font_family,
            fontsize=bar.text_font_size,
            background=f"{bar.color_scheme['powerline_bg'][6]}{bar.opacity_str}",
        ),
        widget.Sep(
            padding=12,
            linewidth=0,
            background=f"{bar.color_scheme['powerline_bg'][6]}{bar.opacity_str}",
            **bar.powerline_left,
        ),
        # endregion
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
