"""Bars for Qtile"""

import os
from socket import gethostname
from typing import List

from libqtile.command import lazy
from libqtile import bar, widget

from widgets import NetMin, EscapedWindowName, FixedWidthVolume, OpenWeatherMap

NET_INTERFACE = "wlp3s0"
TERMINAL = os.environ.get("TERMINAL", "xterm")

USER = os.environ["USER"]
HOSTNAME = gethostname()


def build_bars(settings: dict, secrets: dict = {}) -> List[bar.Bar]:
    theme = settings["theme"]
    barheight = theme["barheight"]
    font = theme["font"]
    fontsize = theme["fontsize"]
    iconfont = theme["iconfont"]
    iconfontsize = theme["iconfontsize"]
    theme_colors = theme["color"]

    owm_location_args = {}
    if "latitude" in secrets:
        owm_location_args["latitude"] = secrets["latitude"]
    if "longitude" in secrets:
        owm_location_args["longitude"] = secrets["longitude"]

    def _fg_sep():
        return widget.Sep(
            linewidth=0,
            padding=6,
            background=theme_colors["panel_fg"],
        )

    def _bg_sep(padding=6):
        return widget.Sep(
            linewidth=0,
            padding=padding,
            background=theme_colors["panel_bg"],
        )

    def _line_sep():
        return widget.Sep(
            linewidth=1,
            size_percent=50,
            padding=18,
            foreground="888888",
            background=theme_colors["panel_bg"],
        )

    top_bar_widgets = [
        # region LHS
        _fg_sep(),
        # person icon
        widget.TextBox(
            text=chr(0xF0004),
            font=iconfont,
            fontsize=iconfontsize,
            padding=6,
            foreground=theme_colors["panel_bg"],
            background=theme_colors["panel_fg"],
        ),
        _fg_sep(),
        _bg_sep(),
        widget.TextBox(
            text=f"{USER}@{HOSTNAME}",
            font=font,
            fontsize=fontsize,
            foreground=theme_colors["panel_fg"],
            background=theme_colors["panel_bg"],
        ),
        _line_sep(),
        widget.GroupBox(
            margin_y=3,
            margin_x=2,
            padding_y=5,
            padding_x=5,
            borderwidth=0,
            font=font,
            fontsize=fontsize,
            foreground=theme_colors["panel_fg"],
            background=theme_colors["panel_bg"],
            active=theme_colors["group_active_fg"],
            inactive=theme_colors["group_inactive_fg"],
            rounded=True,
            highlight_method="block",
            this_current_screen_border=theme_colors["group_current_bg"],
            this_screen_border=theme_colors["group_current_bg"],
            use_mouse_wheel=False,
            # other_current_screen_border=theme_colors["panel_bg"],
            # other_screen_border=theme_colors["panel_bg"],
        ),
        _line_sep(),
        widget.CurrentLayout(
            fontsize=fontsize,
            foreground=theme_colors["panel_fg"],
            background=theme_colors["panel_bg"],
        ),
        # _line_sep(),
        widget.Spacer(),
        EscapedWindowName(
            padding=5,
            font=font,
            fontsize=fontsize,
            foreground=theme_colors["panel_fg"],
            background=theme_colors["panel_bg"],
        ),
        widget.Spacer(),
        # endregion
        # region RHS
        # OpenWeatherMap
        widget.TextBox(
            text=theme["powerline_separator"][0],
            font=iconfont,
            fontsize=barheight,
            margin=0,
            padding=0,
            foreground=theme_colors["powerline_bg"][3],
            background=theme_colors["panel_bg"],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=theme_colors["powerline_bg"][3],
        ),
        OpenWeatherMap(
            api_key=secrets["owm_apikey"],
            font=font,
            fontsize=fontsize,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][3],
            **owm_location_args,
        ),
        widget.Sep(
            linewidth=0,
            padding=10,
            foreground=theme_colors["panel_fg"],
            background=theme_colors["powerline_bg"][3],
        ),
        # volume control
        widget.TextBox(
            text=theme["powerline_separator"][0],
            font=iconfont,
            fontsize=barheight,
            margin=0,
            padding=0,
            foreground=theme_colors["powerline_bg"][2],
            background=theme_colors["powerline_bg"][3],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=theme_colors["powerline_bg"][2],
        ),
        FixedWidthVolume(
            # iconfont = "Material Design Icons",
            volume_up_command=settings["volume"]["up"],
            volume_down_command=settings["volume"]["down"],
            mute_command=settings["volume"]["toggle"],
            volume_app=settings["volume"]["app"],
            font=font,
            fontsize=fontsize,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][2],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=theme_colors["powerline_bg"][2],
        ),
        # Clock
        widget.TextBox(
            text=theme["powerline_separator"][0],
            font=iconfont,
            fontsize=barheight,
            padding=0,
            margin=0,
            foreground=theme_colors["powerline_bg"][0],
            background=theme_colors["powerline_bg"][2],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=theme_colors["powerline_bg"][0],
        ),
        widget.Clock(
            format="%a %Y-%m-%d",
            font=font,
            fontsize=fontsize,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][0],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=theme_colors["powerline_bg"][0],
        ),
        # calendar symbol
        widget.TextBox(
            text=chr(983277),
            font=iconfont,
            fontsize=iconfontsize,
            padding=6,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][0],
        ),
        widget.Sep(
            linewidth=0,
            padding=12,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][0],
        ),
        widget.Clock(
            format="%H:%M",
            font=font,
            fontsize=fontsize,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][0],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][0],
        ),
        # clock symbol
        widget.TextBox(
            text=chr(983376),
            font=iconfont,
            fontsize=iconfontsize,
            padding=6,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][0],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=theme_colors["powerline_bg"][0],
        ),
        # endregion
        widget.TextBox(
            text=f"{theme['logo']}",
            width=barheight,
            font=theme["logofont"],
            fontsize=iconfontsize,
            padding=8,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][-1],
            mouse_callbacks={
                "Button1": lazy.spawn(
                    "rofi -show p -modi p:rofi-power-menu -theme-str '@import \"looniversity\"'"
                )
            },
        ),
    ]

    bottom_bar_widgets = [
        # region Net
        widget.Sep(
            linewidth=0,
            padding=6,
            background=theme_colors["powerline_bg"][4],
        ),
        widget.TextBox(
            text=chr(986631),
            font=iconfont,
            fontsize=iconfontsize,
            padding=6,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][4],
        ),
        NetMin(
            font=font,
            fontsize=fontsize,
            interface=NET_INTERFACE,
            format="{up} ",
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][4],
        ),
        widget.TextBox(
            text=chr(985999),
            font=iconfont,
            fontsize=iconfontsize,
            padding=6,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][4],
        ),
        NetMin(
            font=font,
            fontsize=fontsize,
            interface=NET_INTERFACE,
            format="{down}",
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][4],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=theme_colors["powerline_bg"][4],
        ),
        widget.TextBox(
            text=theme["powerline_separator"][1],
            font=iconfont,
            fontsize=barheight - 4,
            padding=0,
            margin=0,
            foreground=theme_colors["powerline_bg"][4],
            background=theme_colors["powerline_bg"][5],
        ),
        # endregion
        # region Memory
        widget.Sep(
            linewidth=0,
            padding=6,
            background=theme_colors["powerline_bg"][5],
        ),
        widget.TextBox(
            text=chr(983899),
            font=iconfont,
            fontsize=iconfontsize,
            padding=6,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][5],
        ),
        widget.Memory(
            format="{MemUsed:6.0f}M/{MemTotal:.0f}M",
            font=font,
            fontsize=fontsize,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][5],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=theme_colors["powerline_bg"][5],
        ),
        widget.TextBox(
            text=theme["powerline_separator"][1],
            font=iconfont,
            fontsize=barheight - 4,
            padding=0,
            margin=0,
            foreground=theme_colors["powerline_bg"][5],
            background=theme_colors["powerline_bg"][6],
        ),
        # endregion
        # region CPU
        widget.Sep(
            linewidth=0,
            padding=6,
            background=theme_colors["powerline_bg"][6],
        ),
        widget.TextBox(
            text=chr(986848),
            font=iconfont,
            fontsize=iconfontsize + 4,
            padding=6,
            margin=0,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][6],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=theme_colors["powerline_bg"][6],
        ),
        widget.CPU(
            format="{load_percent:4.1f}%",
            update_interval=5,
            font=font,
            fontsize=fontsize,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][6],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=theme_colors["powerline_bg"][6],
        ),
        widget.TextBox(
            text=theme["powerline_separator"][1],
            font=iconfont,
            fontsize=barheight - 4,
            padding=0,
            margin=0,
            foreground=theme_colors["powerline_bg"][6],
            background=theme_colors["powerline_bg"][7],
        ),
        # endregion
        # region Temps
        widget.Sep(
            linewidth=0,
            padding=6,
            background=theme_colors["powerline_bg"][7],
        ),
        widget.TextBox(
            text=chr(984335),
            font=iconfont,
            fontsize=iconfontsize,
            padding=6,
            margin=0,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][7],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=theme_colors["powerline_bg"][7],
        ),
        widget.ThermalSensor(
            font=font,
            fontsize=fontsize,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][7],
        ),
        widget.Sep(
            linewidth=0,
            padding=12,
            background=theme_colors["powerline_bg"][7],
        ),
        widget.TextBox(
            text=theme["powerline_separator"][1],
            font=font,
            fontsize=barheight - 4,
            padding=0,
            margin=0,
            foreground=theme_colors["powerline_bg"][7],
            background=theme_colors["panel_bg"],
        ),
        # endregion
        widget.Spacer(
            background=theme_colors["panel_bg"],
        ),
        # region Bottom RHS
        widget.TextBox(
            text=theme["powerline_separator"][0],
            font=iconfont,
            fontsize=barheight,
            padding=0,
            margin=0,
            foreground=theme_colors["powerline_bg"][1],
            background=theme_colors["panel_bg"],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=theme_colors["powerline_bg"][1],
        ),
        widget.Mpd2(
            status_format="{play_status} {title} | {artist} | {album}",
            idle_format="Play queue empty",
            font=font,
            fontsize=fontsize,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][1],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=theme_colors["powerline_bg"][1],
        ),
        widget.TextBox(
            text=chr(984922),
            font=iconfont,
            fontsize=iconfontsize,
            padding=6,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][1],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=theme_colors["powerline_bg"][1],
        ),
        # endregion
    ]

    return [
        bar.Bar(top_bar_widgets, size=barheight, background=theme_colors["panel_bg"]),
        bar.Bar(
            bottom_bar_widgets,
            size=barheight,
            background=theme_colors["panel_bg"],
        ),
    ]
