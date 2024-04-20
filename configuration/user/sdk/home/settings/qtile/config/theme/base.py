from theme._types import Base16Colors, Properties

DEFAULT_FONT = "Hack Nerd Font Mono"
DEFAULT_ICON_FONT = "Material Design Icons"
DEFAULT_WEATHER_FONT = "Weather Icons"
DEFAULT_LOGO_FONT = "Material Design Icons"
DEFAULT_FONT_SIZE = 12
DEFAULT_BAR_HEIGHT = 22

BASE16_DEFAULT_COLOR_SCHEME: Base16Colors = {
    "base00": "f9f5d7",
    "base01": "ebdbb2",
    "base02": "d5c4a1",
    "base03": "bdae93",
    "base04": "665c54",
    "base05": "504945",
    "base06": "3c3836",
    "base07": "282828",
    "base08": "9d0006",
    "base09": "af3a03",
    "base0A": "b57614",
    "base0B": "79740e",
    "base0C": "427b58",
    "base0D": "076678",
    "base0E": "8f3f71",
    "base0F": "d65d0e",
}


DEFAULT_EXTENSION_PROPS: Properties = {
    "font": DEFAULT_FONT,
    "fontsize": DEFAULT_FONT_SIZE,
    "foreground": BASE16_DEFAULT_COLOR_SCHEME["base07"],
    "background": BASE16_DEFAULT_COLOR_SCHEME["base01"],
}

DEFAULT_LAYOUT_PROPS: Properties = {
    "margin": 3,
    "border_width": 3,
    "border_focus": "d5c4a1",
    "border_normal": "282828",
}

DEFAULT_WIDGET_PROPS: Properties = {
    "font": DEFAULT_FONT,
    "fontsize": DEFAULT_FONT_SIZE,
    "margin": 0,
    "padding": 0,
    "foreground": BASE16_DEFAULT_COLOR_SCHEME["base07"],
    "background": BASE16_DEFAULT_COLOR_SCHEME["base01"],
}

DEFAULT_THEME: dict = {
    "base16_colors": {},
    "named_colors": {},
    "font": {
        "text": {
            "family": DEFAULT_FONT,
            "size": 12,
        },
        "icon": {
            "family": DEFAULT_ICON_FONT,
            "size": 12,
        },
        "weather": {
            "family": DEFAULT_WEATHER_FONT,
            "size": 12,
        },
        "logo": {
            "family": DEFAULT_LOGO_FONT,
            "size": 12,
        },
    },
    "logo": "\uf313",
    "bar": {
        "opacity": 1.0,
        "top": {
            "height": DEFAULT_BAR_HEIGHT,
            "margin": (8, 8, 0, 8),
        },
        "bottom": {
            "height": DEFAULT_BAR_HEIGHT,
            "margin": (0, 8, 8, 8),
        },
    },
    "extension": DEFAULT_EXTENSION_PROPS,
    "layout": DEFAULT_LAYOUT_PROPS,
    "widget": DEFAULT_WIDGET_PROPS,
    "powerline_separator": ["\ue0b2", "\ue0b0"],
    "powerline_color_repeat": {
        "function": "cycle",
        "indices": [0, 3],
    },
}
