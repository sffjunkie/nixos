from libqtile.widget import base  # type: ignore
from qtile_extras import widget  # type: ignore
from qmodule.base import WidgetModule
from theme.defs.theme import ThemeDefinition


class Spacer(WidgetModule):
    def __init__(
        self,
        settings: dict | None = None,
        theme: ThemeDefinition | None = None,
        props: dict | None = None,
    ):
        super().__init__(settings, theme)
        self.props = props

    def widgets(self, group_id: int = -1) -> list[base._Widget]:
        spacer_props = {}
        spacer = widget.Spacer(
            **self._merge_parameters(
                spacer_props,
                self.props,
            )
        )

        return [spacer]
