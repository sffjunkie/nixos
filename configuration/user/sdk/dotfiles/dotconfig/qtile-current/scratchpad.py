from libqtile.command import lazy
from libqtile.config import Key, ScratchPad, DropDown
from .terminal import terminal_run_command


def build_scratchpads(settings) -> list[ScratchPad]:
    return [
        ScratchPad(
            "0",
            [
                DropDown(
                    "ncmpcpp",
                    terminal_run_command + ["ncmpcpp"],
                    height=0.4,
                    width=0.5,
                    x=0.1,
                    y=0.0,
                    on_focus_lost_hide=False,
                    opacity=0.85,
                    warp_pointer=False,
                ),
            ],
        )
    ]


def bind_scratchpad_keys(settings: dict, keys: list[Key]) -> None:
    keys.append(
        Key(
            [],
            "F10",
            lazy.group["0"].dropdown_toggle("ncmpcpp"),
        ),
    )
