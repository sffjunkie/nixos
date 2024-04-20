import os
from pathlib import Path

import yaml

from theme._types import Base16Colors, Theme, NamedColors
from theme.base import (
    BASE16_DEFAULT_COLOR_SCHEME,
    DEFAULT_THEME,
)
from theme.utils import is_base16, is_color


def base16_to_named_colors(base16: Base16Colors) -> NamedColors:
    return {
        "window_border": base16["base06"],
        "panel_fg": base16["base07"],
        "panel_bg": base16["base01"],
        "group_current_fg": base16["base05"],
        "group_current_bg": base16["base03"],
        "group_active_fg": base16["base07"],
        "group_active_bg": base16["base04"],
        "group_inactive_fg": base16["base07"],
        "group_inactive_bg": base16["base04"],
        "powerline_fg": base16["base01"],
        "powerline_bg": [
            base16["base08"],
            base16["base09"],
            base16["base0A"],
            base16["base0B"],
            base16["base0C"],
            base16["base0D"],
            base16["base0E"],
            base16["base0F"],
        ],
    }


def load_theme(filepath: Path) -> Theme:
    theme_yaml = _load_theme_yaml(filepath)

    base16_scheme: Base16Colors = theme_yaml.get("base16_scheme", None)
    # if base16_scheme is None and "base16_scheme_name" in theme_yaml:
    #     base16_scheme = _load_color_scheme()
    if base16_scheme is None:
        base16_scheme = BASE16_DEFAULT_COLOR_SCHEME

    named_colors = base16_to_named_colors(base16_scheme)

    widget = DEFAULT_THEME["widget"].copy()
    if "widget" in theme_yaml:
        widget.update(theme_yaml["widget"])

    tc = _deref_colors(widget, base16_scheme, named_colors)
    widget.update(tc)

    extension = DEFAULT_THEME["extension"].copy()
    if "extension" in theme_yaml:
        extension.update(theme_yaml["extension"])

    tc = _deref_colors(extension, base16_scheme, named_colors)
    extension.update(tc)

    layout = DEFAULT_THEME["layout"].copy()
    if "layout" in theme_yaml:
        layout.update(theme_yaml["layout"])

    tc = _deref_colors(layout, base16_scheme, named_colors)
    layout.update(tc)

    theme = Theme(
        base16_colors=base16_scheme,
        named_colors=named_colors,
        font=theme_yaml.get("font", DEFAULT_THEME["font"]),
        logo=theme_yaml.get("logo", DEFAULT_THEME["logo"]),
        bar=theme_yaml.get("bar", DEFAULT_THEME["bar"]),
        widget=widget,
        extension=extension,
        layout=layout,
        powerline_separator=theme_yaml.get(
            "powerline_separator",
            DEFAULT_THEME["powerline_separator"],
        ),
        powerline_color_repeat=theme_yaml.get(
            "powerline_color_repeat",
            DEFAULT_THEME["powerline_color_repeat"],
        ),
    )

    return theme


def _load_theme_yaml(filepath: Path) -> dict:
    if filepath.is_absolute():
        theme_conf = filepath
    else:
        xdg_config = os.environ.get("XDG_CONFIG_HOME", None)
        if xdg_config is not None:
            p = Path(xdg_config)
            theme_conf = p / "qtile" / filepath
        else:
            theme_conf = Path(__file__).parent / filepath

    if theme_conf.exists():
        with open(theme_conf, "r") as fp:
            theme = yaml.load(fp, yaml.SafeLoader)
            return theme
    else:
        return DEFAULT_THEME


# def _load_color_scheme(
#     scheme_file: str, scheme_folder: str | None = None
# ) -> dict | None:
#     if scheme_folder is None:
#         xdg_data_home = os.environ.get("XDG_DATA_HOME", None)
#         if xdg_data_home is not None:
#             search_folder = Path(xdg_data_home) / "base16" / "schemes"
#         else:
#             search_folder = Path(__file__).parent / "schemes"
#     else:
#         search_folder = Path(scheme_folder)

#     scheme_path = Path(scheme_file)
#     if scheme_path.suffix != ".yaml":
#         scheme_path = scheme_path.with_suffix(".yaml")

#     for file_path in search_folder.rglob(os.path.join("**", "*.yaml")):
#         if file_path.name.endswith(scheme_path.name):
#             with open(file_path, "r") as fp:
#                 colors = yaml.load(fp, Loader=yaml.SafeLoader)
#                 return colors
#     return BASE16_DEFAULT_COLOR_SCHEME


def _deref_colors(theme_info, color_scheme, colors):
    d = {}
    for name, value in theme_info.items():
        if not isinstance(value, (int, float, bool)) and not is_color(value):
            if is_base16(value):
                if color_scheme is None:
                    color_scheme = BASE16_DEFAULT_COLOR_SCHEME
                value = color_scheme[value]
            elif value in colors:
                value = colors[value]

        d[name] = value
    return d
