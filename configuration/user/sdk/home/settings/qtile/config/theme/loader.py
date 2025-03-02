import os
from pathlib import Path

import yaml  # type: ignore
from libqtile.log_utils import logger  # type: ignore

from theme.typedefs.color import Base16ColorDefinitions, NamedColorDefinitions
from theme.typedefs.theme import ThemeDefinition
from theme.default import BASE16_DEFAULT_COLOR_SCHEME
from .utils import is_base16, is_color


def base16_to_named_colors(base16: Base16ColorDefinitions) -> NamedColorDefinitions:
    return {
        "window_border": base16["base06"],
        "panel_fg": base16["base04"],
        "panel_bg": base16["base00"],
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


def _theme_yaml(filepath: Path | None = None) -> dict | None:
    theme = None
    if filepath is not None:
        try:
            with open(filepath, "r") as fp:
                theme = yaml.load(fp, yaml.SafeLoader)
        except (IOError, yaml.YAMLError):
            theme = None

    return theme


def load_theme(filepath: Path | None = None) -> ThemeDefinition:
    theme_path = _theme_path(filepath)
    logger.info(f"Loading theme from {theme_path}")
    theme_yaml = _theme_yaml(theme_path) or {}

    default_theme_path = _theme_path(Path("default_theme.yaml"))
    default_theme_yaml = _theme_yaml(default_theme_path) or {}

    base16_scheme: Base16ColorDefinitions = theme_yaml.get(
        "base16_scheme_colors",
        None,
    )
    if base16_scheme is None and "base16_scheme_name" in theme_yaml:
        scheme_name = theme_yaml["base16_scheme_name"]
        scheme_dir = theme_yaml["base16_scheme_dir"]
        base16_scheme = _load_color_scheme(scheme_name, scheme_dir)

    if base16_scheme is None:
        base16_scheme = BASE16_DEFAULT_COLOR_SCHEME

    named_colors = base16_to_named_colors(base16_scheme)

    widget = default_theme_yaml["widget"].copy()
    if "widget" in theme_yaml:
        widget.update(theme_yaml["widget"])

    tc = _deref_colors(widget, base16_scheme, named_colors)
    widget.update(tc)

    bars = default_theme_yaml["bars"].copy()
    if "bars" in theme_yaml:
        bars.update(theme_yaml["bars"])

    extension = default_theme_yaml["extension"].copy()
    if "extension" in theme_yaml:
        extension.update(theme_yaml["extension"])

    tc = _deref_colors(extension, base16_scheme, named_colors)
    extension.update(tc)

    layout = default_theme_yaml["layout"].copy()
    if "layout" in theme_yaml:
        layout.update(theme_yaml["layout"])

    tc = _deref_colors(layout, base16_scheme, named_colors)
    layout.update(tc)

    theme_def = ThemeDefinition(
        path=filepath,
        bars=bars,
        base16_colors=base16_scheme,
        extension=extension,
        font=theme_yaml.get("font", default_theme_yaml["font"]),
        layout=layout,
        logo=theme_yaml.get("logo", default_theme_yaml["logo"]),
        named_colors=named_colors,
        widget=widget,
    )

    return theme_def


def _load_color_scheme(
    scheme_file: str, scheme_folder: str | None = None
) -> Base16ColorDefinitions | None:
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

    return BASE16_DEFAULT_COLOR_SCHEME


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
