import os
from pathlib import Path

import yaml  # type: ignore
from libqtile.log_utils import logger  # type: ignore

from .typedefs import NamedColors, Base16Colors, Theme

# from theme.default import BASE16_DEFAULT_COLOR_SCHEME
from .utils import is_base16, is_color


# def base16_to_named_colors(base16: Base16Colors) -> NamedColor:
#     return {
#         "window_border": base16["base06"],
#         "panel_fg": base16["base04"],
#         "panel_bg": base16["base00"],
#         "group_current_fg": base16["base05"],
#         "group_current_bg": base16["base03"],
#         "group_active_fg": base16["base07"],
#         "group_active_bg": base16["base04"],
#         "group_inactive_fg": base16["base07"],
#         "group_inactive_bg": base16["base04"],
#         "powerline_fg": base16["base01"],
#         "powerline_bg": [
#             base16["base08"],
#             base16["base09"],
#             base16["base0A"],
#             base16["base0B"],
#             base16["base0C"],
#             base16["base0D"],
#             base16["base0E"],
#             base16["base0F"],
#         ],
#     }


def _deref_colors(
    theme_info: dict, base16_colors: Base16Colors, named_colors: NamedColors
) -> dict:
    d = {}
    for name, value in theme_info.items():
        if not isinstance(value, (int, float, bool)) and not is_color(value):
            if isinstance(value, dict):
                value = _deref_colors(value, base16_colors, named_colors)
            elif is_base16(value):
                value = base16_colors[value]
            elif value in named_colors:
                value = named_colors[value]

        d[name] = value
    return d


def _theme_path(filepath: Path | None = None) -> Path | None:
    if filepath is not None and filepath.is_absolute():
        theme_path = filepath
    else:
        if filepath is None:
            filepath = Path("theme.yaml")

        xdg_config = Path(
            os.environ.get(
                "XDG_CONFIG_HOME",
                os.path.expanduser("~/.config"),
            )
        )
        theme_path = xdg_config / "desktop" / filepath

    if not theme_path.exists():
        logger.warning(f"No theme found in {theme_path}")
        theme_path = None

    return theme_path


def _theme_yaml(filepath: Path | None = None) -> Theme | None:
    theme = None
    if filepath is not None:
        try:
            with open(filepath, "r") as fp:
                theme = yaml.load(fp, yaml.SafeLoader)
        except (IOError, yaml.YAMLError):
            theme = None

    return theme


def _theme_base16_colors(theme_yaml: dict, default_theme_yaml: dict) -> Base16Colors:
    base16_colors = None
    base16 = theme_yaml["color"].get("base16", None)
    if base16 is not None:
        base16_colors = base16.get("colors", None)
        if base16_colors is None:
            scheme_dir = base16.get("scheme_dir", None)
            scheme_name = base16.get("scheme_name", None)
            base16_colors = _load_base16_color_scheme(scheme_name, scheme_dir)

    if base16_colors is None:
        base16_colors = default_theme_yaml["color"]["base16"]["colors"]

    return base16_colors


def _theme_named_colors(theme_yaml: dict, default_theme_yaml: dict) -> NamedColors:
    named_colors = theme_yaml["color"].get("named", None)
    default_named_colors = default_theme_yaml["color"]["named"]
    if named_colors is None:
        return default_named_colors
    else:
        return default_named_colors | named_colors


def load_theme(filepath: Path | None = None) -> Theme:
    default_theme_path = _theme_path(Path("default_theme.yaml"))
    default_theme_yaml = _theme_yaml(default_theme_path) or {}

    theme_path = _theme_path(filepath)
    logger.warning(f"Loading theme from {theme_path}")
    theme_yaml = _theme_yaml(theme_path) or {}

    base16_colors = _theme_base16_colors(theme_yaml, default_theme_yaml)
    logger.warning(f"base16_colors: {base16_colors}")

    named_colors = _theme_named_colors(theme_yaml, default_theme_yaml)
    logger.warning(f"named_colors: {named_colors}")

    widget = default_theme_yaml["widget"].copy()
    if "widget" in theme_yaml:
        widget.update(theme_yaml["widget"])

    tc = _deref_colors(widget, base16_colors, named_colors)
    widget.update(tc)

    bars = default_theme_yaml["bar"].copy()
    if "bar" in theme_yaml:
        bars.update(theme_yaml["bar"])

    extension = default_theme_yaml["extension"].copy()
    if "extension" in theme_yaml:
        extension.update(theme_yaml["extension"])

    tc = _deref_colors(extension, base16_colors, named_colors)
    extension.update(tc)

    layout = default_theme_yaml["layout"].copy()
    if "layout" in theme_yaml:
        layout.update(theme_yaml["layout"])

    tc = _deref_colors(layout, base16_colors, named_colors)
    layout.update(tc)

    theme_def = Theme(
        path=filepath,
        bar=bars,
        color={
            "base16": {
                "scheme_name": None,
                "scheme_dir": None,
            },
            "named": named_colors,
        },
        extension=extension,
        font=theme_yaml.get("font", default_theme_yaml["font"]),
        layout=layout,
        logo=theme_yaml.get("logo", default_theme_yaml["logo"]),
        widget=widget,
    )
    logger.warning(f"XXX {theme_def}")

    return theme_def


def _load_base16_color_scheme(
    scheme_file: str, scheme_folder: str | None = None
) -> Base16Colors | None:
    if scheme_folder is None:
        xdg_data_home = os.environ.get("XDG_DATA_HOME", None)
        if xdg_data_home is not None:
            search_folder = Path(xdg_data_home) / "base16" / "schemes"
        else:
            search_folder = Path(__file__).parent / "schemes"
    else:
        search_folder = Path(scheme_folder)

    scheme_path = Path(scheme_file)
    if scheme_path.suffix != ".yaml":
        scheme_path = scheme_path.with_suffix(".yaml")

    for file_path in search_folder.rglob(os.path.join("**", "*.yaml")):
        if file_path.name.endswith(scheme_path.name):
            with open(file_path, "r") as fp:
                colors = yaml.load(fp, Loader=yaml.SafeLoader)
                return colors["palette"]

    return None
