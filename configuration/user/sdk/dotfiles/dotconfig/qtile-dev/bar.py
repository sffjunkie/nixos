"""Bars for Qtile"""

import os
from enum import Enum
from getpass import getuser
from socket import gethostname
from subprocess import run
from typing import List

from libqtile import bar, widget, config
from libqtile.command import lazy

from widgets import NetMin, EscapedWindowName, FixedWidthVolume, OpenWeatherMap

HOME = os.environ.get("HOME")

class Side(Enum):
    LEFT = 1
    RIGHT = 2


def build_bars(settings: dict, secrets: dict = {}) -> List[bar.Bar]:
    theme = settings["theme"]
    barheight = theme["barheight"]
    font = theme["font"]
    fontsize = int(theme["fontsize"] * theme["dpi"] / 96)
    iconfont = theme["iconfont"]
    iconfontsize = fontsize + 8
    theme_colors = theme["color"]

    owm_location_args = {}
    if "latitude" in secrets:
        owm_location_args["latitude"] = secrets["latitude"]
    if "longitude" in secrets:
        owm_location_args["longitude"] = secrets["longitude"]

    def _sep(padding:int, color:str) -> widget.Sep:
        return widget.Sep(linewidth=0, padding=padding, background=color,)

    def _fg_sep(padding:int=6) -> widget.Sep:
        return _sep(background=theme_colors["panel_fg"],)

    def _bg_sep(padding:int=6) -> widget.Sep:
        return _sep(background=theme_colors["panel_bg"],)

    def _line_sep() -> widget.Sep:
        return widget.Sep(
            linewidth=1,
            size_percent=50,
            padding=18,
            foreground="888888",
            background=theme_colors["panel_bg"],
        )

    def _segment_sep(foreground:str, background:str, side: Side=Side.LEFT) -> widget.Sep:
        text = theme["powerline"]["separator"][0] if side == Side.LEFT else theme["powerline"]["separator"][1]
        return widget.TextBox(
            text=text,
            font=font,
            fontsize=barheight,
            margin=0,
            padding=0,
            foreground=foreground,
            background=background,
        )

    top_bar_widgets = [
        # region LHS
        _fg_sep(),
        # person icon
        widget.TextBox(
            text=chr(983044),
            font=iconfont,
            fontsize=iconfontsize,
            foreground=theme_colors["panel_bg"],
            background=theme_colors["panel_fg"],
            padding=6,
        ),
        _fg_sep(),
        _bg_sep(),
        widget.TextBox(
            text=f"{getuser()}@{gethostname()}",
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
            foreground=theme_colors["panel_fg"], background=theme_colors["panel_bg"],
            font=font,
            fontsize=fontsize,
        ),
        _line_sep(),
        EscapedWindowName(
            padding=5,
            font=font,
            fontsize=fontsize,
            foreground=theme_colors["panel_fg"],
            background=theme_colors["panel_bg"],
        ),
        # endregion
        # region RHS
        # Systray
        _segment_sep(theme_colors["powerline_bg"][4], theme_colors["panel_bg"], Side.RIGHT),
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][4],),
        widget.Systray(
            font=font,
            fontsize=barheight - 4,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][4],
        ),
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][4],),
        # Systray icon
        widget.TextBox(
            text=chr(987798),
            font=iconfont,
            fontsize=iconfontsize,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][4],
        ),
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][4],),
        # OpenWeatherMap
        _segment_sep(theme_colors["powerline_bg"][3], theme_colors["powerline_bg"][4], Side.RIGHT),
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][3],),
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
            padding=6,
            foreground=theme_colors["panel_fg"],
            background=theme_colors["powerline_bg"][3],
        ),
        # volume control
        _segment_sep(theme_colors["powerline_bg"][2], theme_colors["powerline_bg"][3], Side.RIGHT),
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][2],),
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
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][2],),
        # Clock
        _segment_sep(theme_colors["powerline_bg"][0], theme_colors["powerline_bg"][2], Side.RIGHT),
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][0],),
        widget.Clock(
            format="%a %Y-%m-%d",
            font=font,
            fontsize=fontsize,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][0],
        ),
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][0],),
        # calendar symbol
        widget.TextBox(
            text=chr(983277),
            font=iconfont,
            fontsize=iconfontsize,
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
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][0],
        ),
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][0],),
        # endregion
    ]

    if "logo" in theme:
        top_bar_widgets.extend([
            widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][-1],),
            widget.TextBox(
                text=f"{theme['logo']}",
                font=theme["logofont"],
                fontsize=iconfontsize,
                foreground=theme_colors["powerline_fg"],
                background=theme_colors["powerline_bg"][-1],
                mouse_callbacks={"Button1": lambda qtile: run([os.path.expanduser("~/.local/bin/menu/system-rofi")])},
                padding=6,
            ),
            widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][-1],),
        ])

    bottom_bar_widgets = [
        # Updates
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][3],),
        widget.TextBox(
            text=chr(984752),
            font=iconfont,
            fontsize=iconfontsize,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][3],
            mouse_callbacks={"Button1": lambda qtile: run(["alacritty" , "-e", os.path.expanduser("~/.local/bin/updateinfo")])},
        ),
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][3],),
        widget.CheckUpdates(
            distro="Arch",
            mouse_callbacks={"Button1": lambda qtile: run([os.path.expanduser("~/.local/bin/updateinfo")])},
            update_interval=1800,
            display_format="{updates} Updates",
            colour_no_updates=theme_colors["powerline_fg"],
            colour_have_updates=theme_colors["panel_bg"],
            font=font,
            fontsize=fontsize,
            background=theme_colors["powerline_bg"][3],
        ),
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][3],),
        _segment_sep(theme_colors["powerline_bg"][3], theme_colors["powerline_bg"][4], Side.LEFT),
        # region Net
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][4],),
        widget.TextBox(
            text=chr(986631),
            font=iconfont,
            fontsize=iconfontsize,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][4],
        ),
        NetMin(
            font=font,
            fontsize=fontsize,
            interface="wlan0",
            format="{up} ",
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][4],
        ),
        widget.TextBox(
            text=chr(985999),
            font=iconfont,
            fontsize=iconfontsize,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][4],
        ),
        NetMin(
            font=font,
            fontsize=fontsize,
            interface="wlan0",
            format="{down}",
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][4],
        ),
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][4],),
        _segment_sep(theme_colors["powerline_bg"][4], theme_colors["powerline_bg"][5], Side.LEFT),
        # endregion
        # region Memory
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][5],),
        widget.TextBox(
            text=chr(983899),
            font=iconfont,
            fontsize=iconfontsize,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][5],
        ),
        widget.Memory(
            format="{MemUsed:5d}M/{MemTotal}M",
            font=font,
            fontsize=fontsize,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][5],
        ),
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][5],),
        _segment_sep(theme_colors["powerline_bg"][5], theme_colors["powerline_bg"][6], Side.LEFT),
        # endregion
        # region CPU
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][6],),
        widget.TextBox(
            text=chr(986848),
            font=iconfont,
            fontsize=iconfontsize,
            padding=0,
            margin=0,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][6],
        ),
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][6],),
        widget.CPU(
            format="{load_percent:4.1f}%",
            update_interval=5,
            font=font,
            fontsize=fontsize,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][6],
        ),
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][6],),
        _segment_sep(theme_colors["powerline_bg"][6], theme_colors["powerline_bg"][7], Side.LEFT),
        # endregion
        # region Temps
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][7],),
        widget.TextBox(
            text=chr(984335),
            font=iconfont,
            fontsize=iconfontsize,
            padding=0,
            margin=0,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][7],
        ),
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][7],),
        widget.ThermalSensor(
            font=font,
            fontsize=fontsize,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][7],
        ),
        widget.Sep(
            linewidth=0, padding=12, background=theme_colors["powerline_bg"][7],
        ),
        _segment_sep(theme_colors["powerline_bg"][7], theme_colors["panel_bg"], Side.LEFT),
        # endregion
        widget.Spacer(background=theme_colors["panel_bg"],),
        # region Bottom RHS
        _segment_sep(theme_colors["powerline_bg"][1], theme_colors["panel_bg"], Side.RIGHT),
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][1],),
        widget.Mpd2(
            status_format="{title} | {artist} | {album} {play_status}",
            idle_format="Play queue empty",
            font=font,
            fontsize=fontsize,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][1],
        ),
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][1],),
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][0],),
        widget.TextBox(
            text=chr(0xF02CB),
            font=iconfont,
            fontsize=iconfontsize,
            foreground=theme_colors["powerline_fg"],
            background=theme_colors["powerline_bg"][0],
        ),
        widget.Sep(linewidth=0, padding=6, background=theme_colors["powerline_bg"][0],),
        # endregion
    ]

    # bottom_pl = Powerline(
    #     theme_colors["powerline_fg"], theme_colors["powerline_bg"], barheight,
    # )
    # ud = Segment(
    #     [
    #         widget.TextBox(
    #             text=chr(984752),
    #             font=iconfont,
    #             foreground=self.fg,
    #             background=self.segment_colors[3],
    #         ),
    #         widget.Sep(linewidth=0, padding=6, background=self.segment_colors[3],),
    #         widget.CheckUpdates(
    #             distro="Arch",
    #             execute="alacritty",
    #             update_interval=1800,
    #             display_format="{updates} Updates",
    #             colour_no_updates=self.fg,
    #             colour_have_updates=theme_colors["panel_fg"],
    #             background=self.segment_colors[3],
    #         ),
    #     ]
    # )

    return [
        bar.Bar(top_bar_widgets, size=barheight, background=theme_colors["panel_bg"]),
        bar.Bar(
            bottom_bar_widgets, size=barheight, background=theme_colors["panel_bg"],
        ),
    ]
