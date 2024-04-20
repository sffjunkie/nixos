"""Bars for Qtile"""

import os
from socket import gethostname

from libqtile.command import lazy
from libqtile import bar

from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration

# from qwidgets.volume import FixedWidthVolume
from qwidgets.net_min import NetMin
from qwidgets.icon import MDIcon
from qwidgets.line_sep import LineSeparator
from qwidgets.user_menu import UserMenuWidget
from qwidgets.user_host import UserHostWidget
from qwidgets.logo_menu import LogoMenuWidget
from theme.utils import opacity_to_str
from theme._types import Theme


NET_INTERFACE = "wlp3s0"
TERMINAL = os.environ.get("TERMINAL", "xterm")


powerline_right = {"decorations": [PowerLineDecoration(path="forward_slash")]}
powerline_left = {"decorations": [PowerLineDecoration(path="back_slash")]}


def build_top_bar(settings: dict, theme: Theme) -> bar.Bar | None:
    top_bar_defs = theme["bar"].get("top", None)
    if top_bar_defs is None:
        return None

    color_scheme = theme["named_colors"]
    bar_height = theme["bar"]["top"]["height"]
    text_font = theme["font"]["text"]["family"]
    text_font_size = theme["font"]["text"]["size"]
    icon_font = theme["font"]["icon"]["family"]
    icon_font_size = theme["font"]["icon"]["size"]
    opacity = theme["bar"].get("opacity", 1.0)
    opacity_str = opacity_to_str(opacity)

    bar_widgets = [
        # region LHS
        UserMenuWidget(theme, width=bar_height),
        UserHostWidget(theme),
        LineSeparator(theme, width=bar_height),
        widget.GroupBox(
            borderwidth=0,
            margin_y=3,
            padding_y=4,
            margin_x=6,
            padding_x=6,
            font=text_font,
            fontsize=text_font_size,
            foreground=color_scheme["panel_fg"],
            background=f"{color_scheme['panel_bg']}{opacity_str}",
            active=color_scheme["group_active_fg"],
            inactive=color_scheme["group_inactive_fg"],
            rounded=True,
            highlight_method="block",
            this_current_screen_border=color_scheme["group_current_bg"],
            this_screen_border=color_scheme["group_current_bg"],
            use_mouse_wheel=False,
            # other_current_screen_border=theme_colors["panel_bg"],
            # other_screen_border=theme_colors["panel_bg"],
        ),
        LineSeparator(theme, width=bar_height),
        widget.CurrentLayout(
            font=text_font,
            fontsize=text_font_size,
            foreground=color_scheme["panel_fg"],
            background=f"{color_scheme['panel_bg']}{opacity_str}",
            padding=12,
        ),
        widget.Spacer(
            background=f"{color_scheme['panel_bg']}{opacity_str}",
        ),
        widget.WindowName(
            font=text_font,
            fontsize=text_font_size,
            foreground=color_scheme["panel_fg"],
            background=f"{color_scheme['panel_bg']}{opacity_str}",
        ),
        widget.Spacer(
            background=f"{color_scheme['panel_bg']}{opacity_str}",
            **powerline_right,
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
            font=text_font,
            fontsize=text_font_size,
            foreground=color_scheme["powerline_fg"],
            background=f"{color_scheme['powerline_bg'][3]}{opacity_str}",
            **powerline_right,
            padding=12,
        ),
        widget.PulseVolume(
            # iconfont = "Material Design Icons",
            volume_up_command=settings["volume"]["up"],
            volume_down_command=settings["volume"]["down"],
            mute_command=settings["volume"]["toggle"],
            volume_app=settings["volume"]["app"],
            font=text_font,
            fontsize=text_font_size,
            foreground=color_scheme["powerline_fg"],
            background=f"{color_scheme['powerline_bg'][2]}{opacity_str}",
            menu_font=text_font,
            menu_fontsize=int(text_font_size * 0.8),
            menu_width=500,
            menu_offset_x=-250,
            **powerline_right,
            padding=12,
        ),
        widget.Sep(
            linewidth=0,
            background=f"{color_scheme['powerline_bg'][0]}{opacity_str}",
            padding=12,
        ),
        widget.Clock(
            format="%a %Y-%m-%d",
            font=text_font,
            fontsize=text_font_size,
            foreground=color_scheme["powerline_fg"],
            background=f"{color_scheme['powerline_bg'][0]}{opacity_str}",
        ),
        # calendar symbol
        MDIcon(
            name="calendar",
            font=icon_font,
            fontsize=icon_font_size,
            foreground=color_scheme["powerline_fg"],
            background=f"{color_scheme['powerline_bg'][0]}{opacity_str}",
            width=bar_height,
        ),
        widget.Sep(
            linewidth=0,
            background=f"{color_scheme['powerline_bg'][0]}{opacity_str}",
            padding=12,
        ),
        widget.Clock(
            format="%H:%M",
            font=text_font,
            fontsize=text_font_size,
            foreground=color_scheme["powerline_fg"],
            background=f"{color_scheme['powerline_bg'][0]}{opacity_str}",
        ),
        # clock symbol
        MDIcon(
            name="clock",
            font=icon_font,
            fontsize=icon_font_size,
            foreground=color_scheme["powerline_fg"],
            background=f"{color_scheme['powerline_bg'][0]}{opacity_str}",
            width=bar_height,
        ),
        # endregion
        LogoMenuWidget(
            theme,
            width=bar_height,
        ),
    ]

    return bar.Bar(
        bar_widgets,
        size=bar_height,
        background=f"{color_scheme['panel_bg']}{opacity_str}",
        margin=theme["bar"]["top"]["margin"],
    )


def build_bottom_bar(settings: dict, theme: Theme) -> bar.Bar | None:
    bottom_bar_defs = theme["bar"].get("bottom", None)
    if bottom_bar_defs is None:
        return None

    color_scheme = theme["named_colors"]
    bar_height = theme["bar"]["bottom"]["height"]
    text_font = theme["font"]["text"]["family"]
    text_font_size = theme["font"]["text"]["size"]
    icon_font = theme["font"]["icon"]["family"]
    icon_font_size = theme["font"]["icon"]["size"]
    opacity = theme["bar"].get("opacity", 1.0)
    opacity_str = opacity_to_str(opacity)

    bar_widgets = [
        # region LHS
        # region Net
        MDIcon(
            name="net_up",
            font=icon_font,
            fontsize=icon_font_size,
            foreground=color_scheme["powerline_fg"],
            background=f"{color_scheme['powerline_bg'][4]}{opacity_str}",
            width=bar_height,
        ),
        NetMin(
            font=text_font,
            fontsize=text_font_size,
            interface=NET_INTERFACE,
            format="{up} ",
            foreground=color_scheme["powerline_fg"],
            background=f"{color_scheme['powerline_bg'][4]}{opacity_str}",
        ),
        MDIcon(
            name="net_down",
            font=icon_font,
            fontsize=icon_font_size,
            foreground=color_scheme["powerline_fg"],
            background=f"{color_scheme['powerline_bg'][4]}{opacity_str}",
            width=bar_height,
        ),
        NetMin(
            font=text_font,
            fontsize=text_font_size,
            interface=NET_INTERFACE,
            format="{down}",
            foreground=color_scheme["powerline_fg"],
            background=f"{color_scheme['powerline_bg'][4]}{opacity_str}",
        ),
        widget.Sep(
            linewidth=0,
            background=f"{color_scheme['powerline_bg'][4]}{opacity_str}",
            padding=12,
            **powerline_left,
        ),
        # endregion
        # region Memory
        MDIcon(
            name="memory",
            font=icon_font,
            fontsize=icon_font_size,
            foreground=color_scheme["powerline_fg"],
            background=f"{color_scheme['powerline_bg'][5]}{opacity_str}",
            width=bar_height,
        ),
        widget.Memory(
            format="{MemUsed:6.0f}M/{MemTotal:.0f}M",
            font=text_font,
            fontsize=text_font_size,
            foreground=color_scheme["powerline_fg"],
            background=f"{color_scheme['powerline_bg'][5]}{opacity_str}",
        ),
        widget.Sep(
            linewidth=0,
            background=f"{color_scheme['powerline_bg'][5]}{opacity_str}",
            padding=12,
            **powerline_left,
        ),
        # endregion
        # region CPU
        MDIcon(
            name="cpu_usage",
            font=icon_font,
            fontsize=icon_font_size + 4,
            foreground=color_scheme["powerline_fg"],
            background=f"{color_scheme['powerline_bg'][6]}{opacity_str}",
            width=bar_height,
        ),
        widget.CPU(
            format="{load_percent:4.1f}%",
            update_interval=5,
            font=text_font,
            fontsize=text_font_size,
            foreground=color_scheme["powerline_fg"],
            background=f"{color_scheme['powerline_bg'][6]}{opacity_str}",
        ),
        widget.Sep(
            linewidth=0,
            background=f"{color_scheme['powerline_bg'][6]}{opacity_str}",
            padding=12,
            **powerline_left,
        ),
        # endregion
        # region Temps
        MDIcon(
            name="cpu_temp",
            font=icon_font,
            fontsize=icon_font_size,
            foreground=color_scheme["powerline_fg"],
            background=f"{color_scheme['powerline_bg'][7]}{opacity_str}",
            width=bar_height,
        ),
        widget.ThermalSensor(
            font=text_font,
            fontsize=text_font_size,
            foreground=color_scheme["powerline_fg"],
            background=f"{color_scheme['powerline_bg'][7]}{opacity_str}",
        ),
        widget.Sep(
            linewidth=0,
            background=f"{color_scheme['powerline_bg'][7]}{opacity_str}",
            padding=12,
            **powerline_left,
        ),
        # endregion
        # endregion
        widget.Spacer(
            background=f"{color_scheme['panel_bg']}{opacity_str}",
            **powerline_right,
        ),
        # region Bottom RHS
        widget.Sep(
            linewidth=0,
            background=f"{color_scheme['powerline_bg'][1]}{opacity_str}",
            padding=12,
        ),
        widget.Mpd2(
            status_format="{play_status} {title} | {artist} | {album}",
            idle_format="Play queue empty",
            font=text_font,
            fontsize=text_font_size,
            foreground=color_scheme["powerline_fg"],
            background=f"{color_scheme['powerline_bg'][1]}{opacity_str}",
        ),
        MDIcon(
            name="music",
            font=icon_font,
            fontsize=icon_font_size,
            foreground=color_scheme["powerline_fg"],
            background=f"{color_scheme['powerline_bg'][1]}{opacity_str}",
            width=bar_height,
        ),
        # endregion
    ]

    return bar.Bar(
        bar_widgets,
        size=bar_height,
        background=f"{color_scheme['panel_bg']}{opacity_str}",
        margin=[0, 8, 8, 8],
    )


def build_bars(settings: dict, theme: Theme):
    return [
        build_top_bar(settings, theme),
        build_bottom_bar(settings, theme),
    ]
