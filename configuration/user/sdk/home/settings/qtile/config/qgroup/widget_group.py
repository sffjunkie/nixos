from theme.defs.theme import ThemeDefinition


class WidgetGroup:
    def __init__(
        self,
        settings: dict | None = None,
        theme: ThemeDefinition | None = None,
    ):
        self.settings = settings
        self.theme = theme

    @property
    def text_font_family(self) -> str:
        return self.settings.get(
            "text_font_family", self.theme["font"]["text"]["family"]
        )

    @property
    def text_font_size(self) -> str:
        return self.settings.get("text_font_size", self.theme["font"]["text"]["size"])

    @property
    def icon_font_family(self) -> str:
        return self.settings.get(
            "icon_font_family", self.theme["font"]["icon"]["family"]
        )

    @property
    def icon_font_size(self) -> str:
        return self.settings.get("icon_font_size", self.theme["font"]["icon"]["size"])

    @property
    def logo_font_family(self) -> str:
        return self.settings.get(
            "logo_font_family", self.theme["font"]["logo"]["family"]
        )

    @property
    def logo_font_size(self) -> str:
        return self.settings.get("logo_font_size", self.theme["font"]["logo"]["size"])

    def _merge_parameters(self, base, overrides):
        cfg = base.copy()
        if overrides is not None:
            cfg.update(overrides)
        return cfg
