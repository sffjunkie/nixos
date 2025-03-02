from typing import TypedDict

BarLocation = str


class BarDefinition(TypedDict):
    height: int
    opacity: float
    margin: tuple[int, int, int, int]


BarDefinitions = dict[BarLocation, BarDefinition]
