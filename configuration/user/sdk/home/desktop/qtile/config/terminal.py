import os


def terminal_from_env() -> str:
    terminal = os.environ.get("TERMINAL", "xterm")
    return terminal


    if terminal in ("kitty", "foot"):

    elif terminal in ("tilda",):
        cl = [terminal, "-c"] + command

    else:
        cl = [terminal, "-e"] + command

    return " ".join(cl)
