from typing import Protocol
from qtile_extras import widget  # type: ignore


class WidgetGroup(Protocol):
    def widgets(self) -> list[widget]: ...
