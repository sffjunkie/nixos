from .typedefs.theme import PropertyDefinitions, ThemeDefinition
from .typedefs.color import Base16ColorDefinitions, NamedColorDefinitions

DEFAULT_FONT = "Hack Nerd Font Mono"
DEFAULT_ICON_FONT = "Material Design Icons"
DEFAULT_WEATHER_FONT = "Weather Icons"
DEFAULT_LOGO_FONT = "Material Design Icons"
DEFAULT_FONT_SIZE = 12
DEFAULT_BAR_HEIGHT = 22

BASE16_DEFAULT_COLOR_SCHEME: Base16ColorDefinitions = {
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

DEFAULT_NAMED_COLORS: NamedColorDefinitions = {
    "window_border": BASE16_DEFAULT_COLOR_SCHEME["base06"],
    "panel_fg": BASE16_DEFAULT_COLOR_SCHEME["base04"],
    "panel_bg": BASE16_DEFAULT_COLOR_SCHEME["base01"],
    "group_current_fg": BASE16_DEFAULT_COLOR_SCHEME["base05"],
    "group_current_bg": BASE16_DEFAULT_COLOR_SCHEME["base03"],
    "group_active_fg": BASE16_DEFAULT_COLOR_SCHEME["base07"],
    "group_active_bg": BASE16_DEFAULT_COLOR_SCHEME["base04"],
    "group_inactive_fg": BASE16_DEFAULT_COLOR_SCHEME["base07"],
    "group_inactive_bg": BASE16_DEFAULT_COLOR_SCHEME["base04"],
    "powerline_fg": BASE16_DEFAULT_COLOR_SCHEME["base01"],
    "powerline_bg": [
        BASE16_DEFAULT_COLOR_SCHEME["base08"],
        BASE16_DEFAULT_COLOR_SCHEME["base09"],
        BASE16_DEFAULT_COLOR_SCHEME["base0A"],
        BASE16_DEFAULT_COLOR_SCHEME["base0B"],
        BASE16_DEFAULT_COLOR_SCHEME["base0C"],
        BASE16_DEFAULT_COLOR_SCHEME["base0D"],
        BASE16_DEFAULT_COLOR_SCHEME["base0E"],
        BASE16_DEFAULT_COLOR_SCHEME["base0F"],
    ],
    "foreground_light": BASE16_DEFAULT_COLOR_SCHEME["base04"],
    "foreground_dark": BASE16_DEFAULT_COLOR_SCHEME["base00"],
}

DEFAULT_EXTENSION_PROPS: PropertyDefinitions = {
    "font": DEFAULT_FONT,
    "fontsize": DEFAULT_FONT_SIZE,
    "foreground": BASE16_DEFAULT_COLOR_SCHEME["base04"],
    "background": BASE16_DEFAULT_COLOR_SCHEME["base00"],
}

DEFAULT_LAYOUT_PROPS: PropertyDefinitions = {
    "margin": 3,
    "border_width": 3,
    "border_focus": "d5c4a1",
    "border_normal": "282828",
}

DEFAULT_WIDGET_PROPS: PropertyDefinitions = {
    "font": DEFAULT_FONT,
    "fontsize": DEFAULT_FONT_SIZE,
    "margin": 0,
    "padding": 0,
    "foreground": BASE16_DEFAULT_COLOR_SCHEME["base00"],
    "background": BASE16_DEFAULT_COLOR_SCHEME["base07"],
}

DEFAULT_BAR_PROPS = {
    "top": {
        "opacity": 1.0,
        "height": DEFAULT_BAR_HEIGHT,
        "margin": (8, 8, 0, 8),
    },
    "bottom": {
        "opacity": 1.0,
        "height": DEFAULT_BAR_HEIGHT,
        "margin": (0, 8, 8, 8),
    },
}

DEFAULT_THEME: ThemeDefinition = {
    "path": None,
    "base16_colors": BASE16_DEFAULT_COLOR_SCHEME,
    "named_colors": DEFAULT_NAMED_COLORS,
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
    "bars": DEFAULT_BAR_PROPS,
    "extension": DEFAULT_EXTENSION_PROPS,
    "layout": DEFAULT_LAYOUT_PROPS,
    "widget": DEFAULT_WIDGET_PROPS,
}
