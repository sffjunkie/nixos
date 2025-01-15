from qbar.bar import Bar
from qbar.position import GroupPosition
from qtile_extras import widget  # type: ignore
from qbar.widget_group import WidgetGroup
from theme.defs.theme import ThemeDefinition


class Spacer(WidgetGroup):
    def __init__(
        self,
        bar: Bar,
        position: GroupPosition,
        props: dict | None = None,
        theme: ThemeDefinition | None = None,
    ) -> None:
        super.__init__(bar, position, theme, props)

    def widgets(self) -> list[widget.base._Widget]:
        spacer_props = {}
        spacer = widget.Spacer(
            **self._merge_parameters(
                spacer_props,
                self.props,
            )
        )

        return [spacer]
