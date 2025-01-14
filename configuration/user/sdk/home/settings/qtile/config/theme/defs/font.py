from typing import TypedDict


FontType = str


class FontDefinition(TypedDict):
    family: str
    size: int


FontDefinitions = dict[FontType, FontDefinition]
