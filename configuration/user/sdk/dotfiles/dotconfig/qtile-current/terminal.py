import os

TERMINAL = os.environ.get("TERMINAL", None)


def terminal_run_command(command: str) -> str:
    if TERMINAL is None or TERMINAL in (
        "alacritty",
        "terminator",
        "guake",
        "tilix",
        "st",
        "xterm",
    ):
        return [TERMINAL, "-e", command]

    elif TERMINAL in ("kitty",):
        return [TERMINAL, command]

    elif TERMINAL == ("tilda",):
        return [TERMINAL, "-c", command]
