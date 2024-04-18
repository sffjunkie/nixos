from ._types import NamedColors, Base16Colors


def base16_to_named_colors(base16: Base16Colors) -> NamedColors:
    return {
        "panel_fg": base16["base07"],
        "panel_bg": base16["base01"],
        "group_current_fg": base16["base05"],
        "group_current_bg": base16["base03"],
        "group_active_fg": base16["base07"],
        "group_active_bg": base16["base04"],
        "group_inactive_fg": base16["base07"],
        "group_inactive_bg": base16["base04"],
        "powerline_fg": base16["base01"],
        "powerline_bg": [
            base16["base08"],
            base16["base09"],
            base16["base0A"],
            base16["base0B"],
            base16["base0C"],
            base16["base0D"],
            base16["base0E"],
            base16["base0F"],
        ],
    }
