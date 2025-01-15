from qbar.position import GroupPosition
from theme.defs.theme import ThemeDefinition
from theme.utils import opacity_to_str
from qbar.bar import Bar


class WidgetGroup:
    def __init__(
        self,
        bar: Bar,
        position: GroupPosition,
        props: dict | None = None,
        theme: ThemeDefinition | None = None,
    ):
        self.widgets = []
        self.position = position

        self.props = props
        self.theme = theme
        self.color_scheme = theme["named_colors"]
        self.opacity_str = opacity_to_str(bar.opacity)
        self.decorations = []

    @property
    def text_font_family(self) -> str:
        return self.config.get("text_font_family", self.theme["font"]["text"]["family"])

    @property
    def text_font_size(self) -> str:
        return self.config.get("text_font_size", self.theme["font"]["text"]["size"])

    @property
    def icon_font_family(self) -> str:
        return self.config.get("icon_font_family", self.theme["font"]["icon"]["family"])

    @property
    def icon_font_size(self) -> str:
        return self.config.get("icon_font_size", self.theme["font"]["icon"]["size"])

    @property
    def logo_font_family(self) -> str:
        return self.config.get("logo_font_family", self.theme["font"]["logo"]["family"])

    @property
    def logo_font_size(self) -> str:
        return self.config.get("logo_font_size", self.theme["font"]["logo"]["size"])

    def _merge_parameters(self, base, overrides):
        cfg = base.copy()
        if overrides is not None:
            cfg.update(overrides)
        return cfg
