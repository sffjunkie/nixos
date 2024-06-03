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
        return WindowPosition(
            x=0.0 + margin,
            y=width + margin,
            width=width - 2 * margin,
            height=1.0 - 2 * margin,
        )
    elif location == WindowLocation.Right:
        return WindowPosition(
            x=1.0 - width,
            y=0.0,
            width=width,
            height=1.0,
        )
    elif location == WindowLocation.Top:
        return WindowPosition(
            x=0.0,
            y=0.0,
            width=1.0,
            height=height,
        )
    elif location == WindowLocation.Bottom:
        return WindowPosition(
            x=0.0,
            y=1.0 - height,
            width=1.0,
            height=height,
        )
    elif location == WindowLocation.TopLeft:
        return WindowPosition(
            x=0.0,
            y=0.0,
            width=width,
            height=height,
        )
    elif location == WindowLocation.TopCenter:
        return WindowPosition(
            x=(1.0 - width) / 2.0,
            y=0.0,
            width=width,
            height=height,
        )
    elif location == WindowLocation.TopRight:
        return WindowPosition(
            x=1.0 - width,
            y=0.0,
            width=width,
            height=height,
        )
    elif location == WindowLocation.BottomLeft:
        return WindowPosition(
            x=0.0,
            y=1.0 - height,
            width=width,
            height=height,
        )
    elif location == WindowLocation.BottomCenter:
        return WindowPosition(
            x=(1.0 - width) / 2.0,
            y=1.0 - height,
            width=width,
            height=height,
        )
    elif location == WindowLocation.BottomRight:
        return WindowPosition(
            x=1.0 - width,
            y=1.0 - height,
            width=width,
            height=height,
        )
    elif location == WindowLocation.Centered:
        return WindowPosition(
            x=(1.0 - width) / 2.0,
            y=(1.0 - height) / 2.0,
            width=width,
            height=height,
        )

    raise ValueError("Unkown window position")
