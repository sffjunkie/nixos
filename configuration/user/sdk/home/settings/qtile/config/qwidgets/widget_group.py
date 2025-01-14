from theme._types import ThemeDefinition
from theme.utils import opacity_to_str


class WidgetGroup:
    def __init__(self, theme: ThemeDefinition):
        self.theme = theme
        self.color_scheme = theme["named_colors"]
        self.opacity_to_str = opacity_to_str(theme["bar"]["opacity"])

    def text_font(self, config) -> str:
        return config.get("text_font", self.theme["font"]["text"])

    def text_font_family(self, config) -> str:
        return config.get("text_font", self.theme["font"]["text"]["family"])

    def text_font_size(self, config) -> str:
        return config.get("text_font", self.theme["font"]["text"]["size"])

    def icon_font_family(self, config) -> str:
        return config.get("icon_font", self.theme["font"]["icon"]["family"])

    def icon_font_size(self, config) -> str:
        return config.get("icon_font", self.theme["font"]["icon"]["size"])

    def bar(self, location, config) -> str:
        return config.get("bar", self.theme["bar"][location])
