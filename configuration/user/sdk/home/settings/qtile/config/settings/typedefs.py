from typing import TypedDict, NotRequired


class Apps(TypedDict):
    brain: NotRequired[str]
    browser: NotRequired[str]
    code: NotRequired[str]
    terminal: NotRequired[str]

    cliboard_copy: NotRequired[str]
    cliboard_delete: NotRequired[str]

    music_toggle: NotRequired[str]
    music_next: NotRequired[str]
    music_previous: NotRequired[str]
    music_audio: NotRequired[str]


class Keys(TypedDict):
    Alt: NotRequired[str]
    Ctrl: NotRequired[str]
    Shift: NotRequired[str]
    Hyper: NotRequired[str]
    Super: NotRequired[str]


class Settings(TypedDict):
    apps: Apps
    keys: Keys
    netdev: str
