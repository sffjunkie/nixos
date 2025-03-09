import os


def terminal_from_env():
    terminal = os.environ.get("TERMINAL", "xterm")
    return terminal


def terminal_run_command(terminal: str, command: list[str]) -> str:
    if terminal in ("kitty",):
        cl = [terminal] + command

    elif terminal in ("tilda",):
        cl = [terminal, "-c"] + command

    else:
        cl = [terminal, "-e"] + command

    return " ".join(cl)
