import collections
import os
import glob
from logging import getLogger
from pathlib import Path
from typing import Any, Optional
import yaml

from utils import is_base16, is_color

FONT = "Roboto Mono for Powerline"
ICON_FONT = "Material Design Icons"
FONT_SIZE = 14
BAR_HEIGHT = 22

COLOR_SCHEME = {
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

WIDGET = {
    "font": FONT,
    "fontsize": FONT_SIZE,
    "margin": 0,
    "padding": 0,
    "foreground": "base07",
    "background": "base01",
}


EXTENSION = {
    "font": FONT,
    "fontsize": FONT_SIZE,
    "foreground": "base07",
    "background": "base01",
}

LAYOUT = {
    "margin": 3,
    "border_width": 3,
    "border_focus": "d5c4a1",
    "border_normal": "282828",
}


DEFAULT_THEME = {
    "font": FONT,
    "iconfont": ICON_FONT,
    "fontsize": FONT_SIZE,
    "barheight": BAR_HEIGHT,
    "color": COLOR_SCHEME,
    "widget": WIDGET,
    "layout": LAYOUT,
    "extension": EXTENSION,
}

def _get_color(name, color_defs):
    if is_color(name) or name not in color_defs:
        return name

    color = color_defs[name]
    if color in color_defs:
        pass


def _deref_colors(colors:dict) -> dict:
    c = {}
    for name, value in colors.items():
        if not is_color(value) and is_base16(value) and value in colors:
            value = colors[value]

        c[name] = value
    return c


def _deref_item_colors(item:Any, colors:dict):
    if isinstance(item, (dict, collections.ChainMap)):
        i = {}
        for key, value in item.items():
            if isinstance(value, dict):
                i[key] = _deref_item_colors(value, colors)
            elif isinstance(value, list):
                i[key] = _deref_item_colors(value, colors)
            else:
                i[key] = colors.get(value, value)
        return i
    elif isinstance(item, list):
        return [colors.get(value, value) for value in item]
    else:
        return colors.get(item, item)


def _find_scheme(search_folder:Path, search_file:Path):
    for file_path in search_folder.rglob(os.path.join("**", "*.yaml")):
        if file_path.name.endswith(search_file.name):
            return file_path
    return None


def _load_color_scheme_base16(
    scheme_file: str, scheme_folder: Optional[str] = None
) -> Optional[dict]:
    home = os.environ["HOME"]
    if not scheme_folder:
        xdg_data_home = os.environ.get("XDG_DATA_HOME", f"{home}/.local/share")
        scheme_folder = [ Path(xdg_data_home) / "base16" / "schemes", Path(__file__).parent.parent / "schemes"]

    scheme_file = Path(scheme_file)
    if scheme_file.suffix != ".yaml":
        scheme_file = scheme_file.with_suffix(".yaml")

    file_path = _find_scheme(scheme_folder[0], scheme_file)
    if not file_path:
        file_path = _find_scheme(scheme_folder[1], scheme_file)

    if file_path:
        with open(file_path, "r") as fp:
            colors = yaml.load(fp, Loader=yaml.SafeLoader)
            return colors

    return COLOR_SCHEME


def _load_base_theme() -> dict:
    theme_conf = Path(__file__).parent / "theme.yaml"
    with open(theme_conf, "r") as fp:
        return yaml.load(fp, yaml.SafeLoader)


def _load_theme(filename: str) -> dict:
    if filename[0] != "/":
        xdg_config = os.environ.get("XDG_CONFIG_HOME", None)
        if xdg_config:
            p = Path(xdg_config)
            user_theme_file = p / "theme" / filename
    else:
        user_theme_file = Path(filename)

    if user_theme_file.exists():
        with open(user_theme_file, "r") as fp:
            return yaml.load(fp, yaml.SafeLoader)


class _MergedMapping:
    def __init__(self, *maps):
        self.maps = maps
        self._all_keys = []
        for n, m in enumerate(maps):
            self._add_dict(str(n), m)

        map_indexes = []
        map_keys = []
        for k in self._all_keys:
            idx, key = k.split(".", maxsplit=1)
            map_indexes.append(idx)
            map_keys.append(key)

        map_indexes.reverse()
        map_keys.reverse()

        self._map_keys = []
        for idx, key in enumerate(map_keys):
            if key not in map_keys[idx + 1:]:
                self._map_indexes.append(int(map_indexes[idx]))
                self._map_keys.append(key)

    def _add_dict(self, parent, d):
        for k, v in d.items():
            name = f"{parent}.{k}"
            self._all_keys.append(name)
            if isinstance(v, dict):
                self._add_dict(name, v)

    def __getitem__(self, key):
        if isinstance(key, list):
            key = '.'.join(key)

        for idx, k in enumerate(self._map_keys):
            if key == k:
                look_in = self.maps[self._map_indexes[idx]]
                route = k.split(".")
                for elem in route:
                    look_in = look_in[elem]
                return look_in
        return None


def load_theme() -> dict:
    base_theme = _load_base_theme()
    system_theme = _load_theme("system.yaml")
    qtile_theme = _load_theme("qtile.yaml")
    _theme = _MergedMapping(qtile_theme, system_theme, base_theme)

    if theme and "base16_scheme_name" in theme:
        base16_scheme = _load_color_scheme_base16(theme["base16_scheme_name"])
        theme["color"].update(base16_scheme)

    colors = _deref_colors(theme["color"])
    theme = _deref_item_colors(theme, colors)

    widget = WIDGET.copy()
    if "widget" in theme:
        widget.update(theme["widget"])

    extension = EXTENSION.copy()
    if "extension" in theme:
        extension.update(theme["extension"])

    layout = LAYOUT.copy()
    if "layout" in theme:
        layout.update(theme["layout"])

    theme["color"] = colors
    theme["widget"] = widget
    theme["extension"] = extension
    theme["layout"] = layout

    return theme
