from typing import TypedDict


class Settings(TypedDict):
    keys: dict[str, str]
    netdev: str
