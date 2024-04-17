"""Bars for Qtile"""

import os
from socket import gethostname

from libqtile.command import lazy
from libqtile import bar, widget

from widgets import NetMin, FixedWidthVolume
from qtile_extras.widget import PulseVolume

from theme._types import Theme

NET_INTERFACE = "wlp3s0"
TERMINAL = os.environ.get("TERMINAL", "xterm")


def opacity_to_str(opacity: float) -> str:
    return hex(int(opacity * 255.0))[2:]


class ForegroundSeparator(widget.Sep):
    def __init__(self, theme: Theme, bar_name: str):
        color_scheme = theme["named_colors"]
        opacity_str = opacity_to_str(theme["bar"][bar_name]["opacity"])
        super().__init__(
            linewidth=0,
            padding=12,
            background=f"{color_scheme['panel_fg']}{opacity_str}",
        )


class BackgroundSeparator(widget.Sep):
    def __init__(self, theme: Theme, bar_name: str):
        color_scheme = theme["named_colors"]
        opacity_str = opacity_to_str(theme["bar"][bar_name]["opacity"])
        super().__init__(
            linewidth=0,
            padding=12,
            background=f"{color_scheme['panel_bg']}{opacity_str}",
        )


class LineSeparator(widget.Sep):
    def __init__(self, theme: Theme, bar_name: str):
        color_scheme = theme["named_colors"]
        opacity_str = opacity_to_str(theme["bar"][bar_name]["opacity"])
        super().__init__(
            size_percent=50,
            padding=18,
            linewidth=1,
            foreground=color_scheme["panel_fg"],
            background=f"{color_scheme['panel_bg']}{opacity_str}",
        )


class UserMenuWidget(widget.TextBox):
    def __init__(self, theme: Theme, bar_name: str):
        color_scheme = theme["named_colors"]
        opacity_str = opacity_to_str(theme["bar"][bar_name]["opacity"])
        super().__init__(
            text=chr(0xF0004),
            font=theme["font"]["icon"]["family"],
            fontsize=theme["font"]["icon"]["size"],
            padding=12,
            foreground=color_scheme["panel_bg"],
            background=f"{color_scheme['panel_fg']}{opacity_str}",
        )


class UserHostWidget(widget.TextBox):
    def __init__(self, theme: Theme, bar_name: str):
        user = os.environ["USER"]
        hostname = gethostname()

        font_family = theme["font"]["text"]["family"]
        font_size = theme["font"]["text"]["size"]
        color_scheme = theme["named_colors"]
        opacity_str = opacity_to_str(theme["bar"][bar_name]["opacity"])
        super().__init__(
            text=f"{user}@{hostname}",
            font=font_family,
            fontsize=font_size,
            foreground=color_scheme["panel_fg"],
            background=f"{color_scheme['panel_bg']}{opacity_str}",
        )


class LogoMenuWidget(widget.TextBox):
    def __init__(self, theme: Theme, bar_name: str):
        color_scheme = theme["named_colors"]
        opacity_str = opacity_to_str(theme["bar"][bar_name]["opacity"])
        (
            super().__init__(
                text=f"{theme['logo']}",
                width=theme["bar"][bar_name]["height"],
                font=theme["font"]["logo"]["family"],
                fontsize=theme["font"]["logo"]["size"],
                padding=8,
                foreground=color_scheme["powerline_fg"],
                background=f"{color_scheme['powerline_bg'][-1]}{opacity_str}",
                mouse_callbacks={"Button1": lazy.spawn("rofi-power")},
            ),
        )


def build_top_bar(settings: dict, theme: Theme) -> bar.Bar | None:
    top_bar_defs = theme["bar"].get("top", None)
    if top_bar_defs is None:
        return None

    print(theme)

    color_scheme = theme["named_colors"]
    top_bar_height = theme["bar"]["top"]["height"]
    text_font = theme["font"]["text"]["family"]
    text_font_size = theme["font"]["text"]["size"]
    icon_font = theme["font"]["icon"]["family"]
    icon_font_size = theme["font"]["icon"]["size"]
    opacity = theme["bar"]["top"].get("opacity", 1.0)
    opacity_str = opacity_to_str(opacity)

    bar_widgets = [
        # region LHS
        UserMenuWidget(theme, bar_name="top"),
        BackgroundSeparator(theme, bar_name="top"),
        UserHostWidget(theme, bar_name="top"),
        LineSeparator(theme, bar_name="top"),
        widget.GroupBox(
            borderwidth=0,
            margin_y=2,
            padding_y=4,
            margin_x=4,
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
        LineSeparator(theme, bar_name="top"),
        widget.CurrentLayout(
            font=text_font,
            fontsize=text_font_size,
            foreground=color_scheme["panel_fg"],
            background=f"{color_scheme['panel_bg']}{opacity_str}",
        ),
        widget.Spacer(
            background=f"{color_scheme['panel_bg']}{opacity_str}",
        ),
        widget.WindowName(
            padding=5,
            font=text_font,
            fontsize=text_font_size,
            foreground=color_scheme["panel_fg"],
            background=f"{color_scheme['panel_bg']}{opacity_str}",
        ),
        widget.Spacer(
            background=f"{color_scheme['panel_bg']}{opacity_str}",
        ),
        # endregion
        # region RHS
        # OpenWeatherMap
        widget.TextBox(
            text=theme["powerline_separator"][0],
            font=icon_font,
            fontsize=top_bar_height,
            margin=0,
            padding=0,
            foreground=color_scheme["powerline_bg"][3],
            background=f"{color_scheme['panel_bg']}{opacity_str}",
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=color_scheme["powerline_bg"][3],
        ),
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
            background=color_scheme["powerline_bg"][3],
        ),
        widget.Sep(
            linewidth=0,
            padding=10,
            foreground=color_scheme["panel_fg"],
            background=color_scheme["powerline_bg"][3],
        ),
        # volume control
        widget.TextBox(
            text=theme["powerline_separator"][0],
            font=icon_font,
            fontsize=top_bar_height,
            margin=0,
            padding=0,
            foreground=color_scheme["powerline_bg"][2],
            background=color_scheme["powerline_bg"][3],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=color_scheme["powerline_bg"][2],
        ),
        PulseVolume(
            # iconfont = "Material Design Icons",
            volume_up_command=settings["volume"]["up"],
            volume_down_command=settings["volume"]["down"],
            mute_command=settings["volume"]["toggle"],
            volume_app=settings["volume"]["app"],
            font=text_font,
            fontsize=text_font_size,
            foreground=color_scheme["powerline_fg"],
            background=color_scheme["powerline_bg"][2],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=color_scheme["powerline_bg"][2],
        ),
        # Clock
        widget.TextBox(
            text=theme["powerline_separator"][0],
            font=icon_font,
            fontsize=top_bar_height,
            padding=0,
            margin=0,
            foreground=color_scheme["powerline_bg"][0],
            background=color_scheme["powerline_bg"][2],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=color_scheme["powerline_bg"][0],
        ),
        widget.Clock(
            format="%a %Y-%m-%d",
            font=text_font,
            fontsize=text_font_size,
            foreground=color_scheme["powerline_fg"],
            background=color_scheme["powerline_bg"][0],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=color_scheme["powerline_bg"][0],
        ),
        # calendar symbol
        widget.TextBox(
            text=chr(983277),
            font=icon_font,
            fontsize=icon_font_size,
            padding=6,
            foreground=color_scheme["powerline_fg"],
            background=color_scheme["powerline_bg"][0],
        ),
        widget.Sep(
            linewidth=0,
            padding=12,
            foreground=color_scheme["powerline_fg"],
            background=color_scheme["powerline_bg"][0],
        ),
        widget.Clock(
            format="%H:%M",
            font=text_font,
            fontsize=text_font_size,
            foreground=color_scheme["powerline_fg"],
            background=color_scheme["powerline_bg"][0],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            foreground=color_scheme["powerline_fg"],
            background=color_scheme["powerline_bg"][0],
        ),
        # clock symbol
        widget.TextBox(
            text=chr(983376),
            font=icon_font,
            fontsize=icon_font_size,
            padding=6,
            foreground=color_scheme["powerline_fg"],
            background=color_scheme["powerline_bg"][0],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=color_scheme["powerline_bg"][0],
        ),
        # endregion
        LogoMenuWidget(theme, bar_name="top"),
    ]

    return bar.Bar(
        bar_widgets,
        size=top_bar_height,
        background=f"{color_scheme['panel_bg']}{opacity_str}",
        margin=theme["bar"]["top"]["margin"],
    )


def build_bottom_bar(settings: dict, theme: Theme) -> bar.Bar | None:
    bottom_bar_defs = theme["bar"].get("bottom", None)
    if bottom_bar_defs is None:
        return None

    color_scheme = theme["named_colors"]
    bottom_bar_height = theme["bar"]["bottom"]["height"]
    text_font = theme["font"]["text"]["family"]
    text_font_size = theme["font"]["text"]["size"]
    icon_font = theme["font"]["icon"]["family"]
    icon_font_size = theme["font"]["icon"]["size"]
    opacity = theme["bar"]["bottom"].get("opacity", 1.0)
    opacity_str = opacity_to_str(opacity)

    bar_widgets = [
        # region Net
        widget.Sep(
            linewidth=0,
            padding=6,
            background=color_scheme["powerline_bg"][4],
        ),
        widget.TextBox(
            text=chr(986631),
            font=icon_font,
            fontsize=icon_font_size,
            padding=6,
            foreground=color_scheme["powerline_fg"],
            background=color_scheme["powerline_bg"][4],
        ),
        NetMin(
            font=text_font,
            fontsize=text_font_size,
            interface=NET_INTERFACE,
            format="{up} ",
            foreground=color_scheme["powerline_fg"],
            background=color_scheme["powerline_bg"][4],
        ),
        widget.TextBox(
            text=chr(985999),
            font=icon_font,
            fontsize=icon_font_size,
            padding=6,
            foreground=color_scheme["powerline_fg"],
            background=color_scheme["powerline_bg"][4],
        ),
        NetMin(
            font=text_font,
            fontsize=text_font_size,
            interface=NET_INTERFACE,
            format="{down}",
            foreground=color_scheme["powerline_fg"],
            background=color_scheme["powerline_bg"][4],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=color_scheme["powerline_bg"][4],
        ),
        widget.TextBox(
            text=theme["powerline_separator"][1],
            font=icon_font,
            fontsize=bottom_bar_height - 4,
            padding=0,
            margin=0,
            foreground=color_scheme["powerline_bg"][4],
            background=color_scheme["powerline_bg"][5],
        ),
        # endregion
        # region Memory
        widget.Sep(
            linewidth=0,
            padding=6,
            background=color_scheme["powerline_bg"][5],
        ),
        widget.TextBox(
            text=chr(983899),
            font=icon_font,
            fontsize=icon_font_size,
            padding=6,
            foreground=color_scheme["powerline_fg"],
            background=color_scheme["powerline_bg"][5],
        ),
        widget.Memory(
            format="{MemUsed:6.0f}M/{MemTotal:.0f}M",
            font=text_font,
            fontsize=text_font_size,
            foreground=color_scheme["powerline_fg"],
            background=color_scheme["powerline_bg"][5],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=color_scheme["powerline_bg"][5],
        ),
        widget.TextBox(
            text=theme["powerline_separator"][1],
            font=icon_font,
            fontsize=bottom_bar_height - 4,
            padding=0,
            margin=0,
            foreground=color_scheme["powerline_bg"][5],
            background=color_scheme["powerline_bg"][6],
        ),
        # endregion
        # region CPU
        widget.Sep(
            linewidth=0,
            padding=6,
            background=color_scheme["powerline_bg"][6],
        ),
        widget.TextBox(
            text=chr(986848),
            font=icon_font,
            fontsize=icon_font_size + 4,
            padding=6,
            margin=0,
            foreground=color_scheme["powerline_fg"],
            background=color_scheme["powerline_bg"][6],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=color_scheme["powerline_bg"][6],
        ),
        widget.CPU(
            format="{load_percent:4.1f}%",
            update_interval=5,
            font=text_font,
            fontsize=text_font_size,
            foreground=color_scheme["powerline_fg"],
            background=color_scheme["powerline_bg"][6],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=color_scheme["powerline_bg"][6],
        ),
        widget.TextBox(
            text=theme["powerline_separator"][1],
            font=icon_font,
            fontsize=bottom_bar_height - 4,
            padding=0,
            margin=0,
            foreground=color_scheme["powerline_bg"][6],
            background=color_scheme["powerline_bg"][7],
        ),
        # endregion
        # region Temps
        widget.Sep(
            linewidth=0,
            padding=6,
            background=color_scheme["powerline_bg"][7],
        ),
        widget.TextBox(
            text=chr(984335),
            font=icon_font,
            fontsize=icon_font_size,
            padding=6,
            margin=0,
            foreground=color_scheme["powerline_fg"],
            background=color_scheme["powerline_bg"][7],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=color_scheme["powerline_bg"][7],
        ),
        widget.ThermalSensor(
            font=text_font,
            fontsize=text_font_size,
            foreground=color_scheme["powerline_fg"],
            background=color_scheme["powerline_bg"][7],
        ),
        widget.Sep(
            linewidth=0,
            padding=12,
            background=color_scheme["powerline_bg"][7],
        ),
        widget.TextBox(
            text=theme["powerline_separator"][1],
            font=text_font,
            fontsize=bottom_bar_height - 4,
            padding=0,
            margin=0,
            foreground=color_scheme["powerline_bg"][7],
            background=f"{color_scheme['panel_bg']}{opacity_str}",
        ),
        # endregion
        widget.Spacer(
            background=f"{color_scheme['panel_bg']}{opacity_str}",
        ),
        # region Bottom RHS
        widget.TextBox(
            text=theme["powerline_separator"][0],
            font=icon_font,
            fontsize=bottom_bar_height,
            padding=0,
            margin=0,
            foreground=color_scheme["powerline_bg"][1],
            background=f"{color_scheme['panel_bg']}{opacity_str}",
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=color_scheme["powerline_bg"][1],
        ),
        widget.Mpd2(
            status_format="{play_status} {title} | {artist} | {album}",
            idle_format="Play queue empty",
            font=text_font,
            fontsize=text_font_size,
            foreground=color_scheme["powerline_fg"],
            background=color_scheme["powerline_bg"][1],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=color_scheme["powerline_bg"][1],
        ),
        widget.TextBox(
            text=chr(984922),
            font=icon_font,
            fontsize=icon_font_size,
            padding=6,
            foreground=color_scheme["powerline_fg"],
            background=color_scheme["powerline_bg"][1],
        ),
        widget.Sep(
            linewidth=0,
            padding=6,
            background=color_scheme["powerline_bg"][1],
        ),
        # endregion
    ]

    return bar.Bar(
        bar_widgets,
        size=bottom_bar_height,
        background=color_scheme["panel_bg"],
        margin=[0, 8, 8, 8],
    )


def build_bars(settings: dict, theme: Theme):
    return [
        build_top_bar(settings, theme),
        build_bottom_bar(settings, theme),
    ]
