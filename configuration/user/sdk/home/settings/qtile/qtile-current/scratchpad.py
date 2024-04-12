from libqtile.command import lazy
from libqtile.config import Key, ScratchPad, DropDown
from terminal import terminal_run_command


def build_scratchpads(settings) -> list[ScratchPad]:
    return [
        ScratchPad(
            "0",
            dropdowns=[
                DropDown(
                    "ncmpcpp",
                    terminal_run_command("alacritty", ["ncmpcpp"]),
                    height=0.4,
                    width=0.5,
                    x=0.25,
                    y=0.0,
                    opacity=1.0,
                    warp_pointer=False,
                ),
            ],
            single=True,
        )
    ]


def build_keys(settings: dict) -> list[Key]:
    return [
        Key(
            [settings["mod"]],
            "0",
            lazy.group["0"].dropdown_toggle("ncmpcpp"),
        ),
    ]
