from qtile_extras import widget  # type: ignore

from qwidget.icon import MDIcon
from qgroup.widget_group import WidgetGroup
from qgroup.context import GroupContext


class DateTime(WidgetGroup):
    def __init__(
        self,
        context: GroupContext,
    ):
        self.position = context.position
        super().__init__(context)

    def widgets(self, **config) -> list[widget]:
        background_color = self.context.props.get(
            "background", self.context.bar.background_color
        )
        background = f"{background_color}{self.context.bar.opacity_str}"

        bar_height = self.context.bar.height

        date_text_props = {
            "format": "%a %Y-%m-%d",
            "font": self.context.text_font_family,
            "fontsize": self.context.text_font_size,
            "background": background,
        }

        props = self.context.merge_parameters(
            date_text_props,
            self.context.props.get("date", {}),
        )

        date_text = widget.Textbox(**props)

        date_icon_props = {
            "name": "calendar",
            "font": self.context.icon_font_family,
            "fontsize": self.context.icon_font_size,
            "background": background,
            "width": bar_height,
        }

        props = self.context.merge_parameters(
            date_icon_props,
            self.context.props.get("icon", {}),
        )

        date_icon = MDIcon(**props)

        separator_props = {
            "padding": 6,
            "linewidth": 0,
            "background": background,
        }

        props = self.context.merge_parameters(
            separator_props,
            self.context.props.get("separator", {}),
        )

        separator = widget.Sep(**props)

        time_text_props = {
            "format": "%a %Y-%m-%d",
            "font": self.context.text_font_family,
            "fontsize": self.context.text_font_size,
            "background": background,
        }

        props = self.context.merge_parameters(
            time_text_props,
            self.context.props.get("time", {}),
        )

        time_text = widget.Textbox(**props)

        time_icon_props = {
            "name": "calendar",
            "font": self.context.icon_font_family,
            "fontsize": self.context.icon_font_size,
            "background": background,
            "width": bar_height,
        }

        props = self.context.merge_parameters(
            time_icon_props,
            self.context.props.get("icon", {}),
        )

        time_icon = MDIcon(**props)

        widgets = [date_text, date_icon, separator, time_text, time_icon]
        return widgets
