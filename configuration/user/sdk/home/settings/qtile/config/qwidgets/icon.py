from qtile_extras import widget


MDICONS = {
    "calendar": chr(983277),
    "clock": chr(983376),
    "cpu_temp": chr(984335),
    "cpu_usage": chr(986848),
    "memory": chr(983899),
    "music": chr(984922),
    "net_down": chr(985999),
    "net_up": chr(986631),
    "user": chr(0xF0004),
}


class MDIcon(widget.TextBox):
    def __init__(self, name, **config):
        super().__init__(
            text=MDICONS[name],
            **config,
        )

    def _configure(self, qtile, bar):
        widget.TextBox._configure(self, qtile, bar)
        self.layout.width = self.length
