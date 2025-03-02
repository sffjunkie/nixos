from typing import TypedDict


class Apps(TypedDict):
    brain: str
    browser: str
    code: str
    terminal: str

    cliboard_copy: str
    cliboard_delete: str

    music_toggle: str
    music_next: str
    music_previous: str
    music_audio: str


class Keys(TypedDict):
    Alt: str
    Ctrl: str
    Shift: str
    Hyper: str
    Super: str


class Settings(TypedDict):
    apps: Apps
    keys: Keys
    netdev: str
