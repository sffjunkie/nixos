from qtile_extras import widget  # type: ignore
from qgroup.widget_group import WidgetGroup
from theme.defs.theme import ThemeDefinition


class Spacer(WidgetGroup):
    def __init__(
        self,
        settings: dict | None = None,
        theme: ThemeDefinition | None = None,
        props: dict | None = None,
    ):
        super().__init__(settings, theme)
        self.props = props

    def widgets(self) -> list[widget]:
        spacer_props = {}
        spacer = widget.Spacer(
            **self._merge_parameters(
                spacer_props,
                self.props,
            )
        )

        return [spacer]
