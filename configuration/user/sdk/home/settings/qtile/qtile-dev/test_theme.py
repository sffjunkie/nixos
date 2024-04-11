#!python3
import theme
from collections import ChainMap
from pprint import pprint

from utils import Theme


def test_BaseTheme():
    t = theme._load_base_theme()
    assert "powerline" in t


def test_QTileTheme():
    t = theme._load_theme("qtile.yaml")
    assert "layout" in t


def test_SystemTheme():
    t = theme._load_theme("system.yaml")
    assert "fontsize" in t


def test_ThemeChainMap():
    b = theme._load_base_theme()
    s = theme._load_theme("system.yaml")
    q = theme._load_theme("qtile.yaml")
    t = ChainMap(q, s, b)
    assert t["layout"]["margin"] == 9


def test_LoadTheme():
    t = theme.load_theme()
    print(t["bar"])
    assert "bar" in t
    assert "foreground" in t["bar"]


def test_ThemeClass():
    a = {"bar": {"height": 34}}
    b = {"bar": {"height": 4, "foreground": "123456", "background": "654321"}}
    t = Theme(a, b)
    print(t["bar.foreground"])

test_ThemeClass()

# test_BaseTheme()
# test_QTileTheme()
# test_SystemTheme()
# test_ThemeChainMap()
# test_LoadTheme()
