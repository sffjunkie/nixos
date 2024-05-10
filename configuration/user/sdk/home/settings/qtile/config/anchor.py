from dataclasses import dataclass
from enum import Enum, auto
from typing import Annotated


@dataclass
class FloatRange:
    min: float
    max: float


ScreenFraction = Annotated[float, FloatRange(min=0.0, max=1.0)]


@dataclass
class WindowPosition:
    x: float
    y: float
    width: float
    height: float


class WindowLocation(Enum):
    Left = auto()
    Right = auto()
    Top = auto()
    Bottom = auto()
    TopLeft = auto()
    TopCenter = auto()
    TopRight = auto()
    BottomLeft = auto()
    BottomCenter = auto()
    BottomRight = auto()
    Centered = auto()


def anchor_window(
    location: WindowLocation,
    width: ScreenFraction,
    height: ScreenFraction,
) -> WindowPosition:
    if location == WindowLocation.Left:
        return WindowPosition(0.0, width, width, 1.0)
    elif location == WindowLocation.Right:
        return WindowPosition(1.0 - width, 0.0, width, 1.0)
    elif location == WindowLocation.Top:
        return WindowPosition(0.0, 0.0, 1.0, height)
    elif location == WindowLocation.Bottom:
        return WindowPosition(0.0, 1.0 - height, 1.0, height)
    elif location == WindowLocation.TopLeft:
        return WindowPosition(0.0, 0.0, width, height)
    elif location == WindowLocation.TopCenter:
        return WindowPosition((1.0 - width) / 2.0, 0.0, width, height)
    elif location == WindowLocation.TopRight:
        return WindowPosition(1.0 - width, 0.0, width, height)
    elif location == WindowLocation.BottomLeft:
        return WindowPosition(0.0, 1.0 - height, width, height)
    elif location == WindowLocation.BottomCenter:
        return WindowPosition((1.0 - width) / 2.0, 1.0 - height, width, height)
    elif location == WindowLocation.BottomRight:
        return WindowPosition(1.0 - width, 1.0 - height, width, height)
    elif location == WindowLocation.Centered:
        return WindowPosition((1.0 - width) / 2.0, (1.0 - height) / 2.0, width, height)

    raise ValueError("Unkown window position")
