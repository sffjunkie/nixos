from libqtile.lazy import lazy  # type: ignore
from libqtile.config import Key, ScratchPad, DropDown  # type: ignore
from terminal import terminal_run_command
from anchor import anchor_window, WindowLocation
from keys import Super, Alt


def build_scratchpads(settings: dict) -> list[ScratchPad]:
    ncmpcpp_dimension = anchor_window(
        location=WindowLocation.TopCenter,
        width=0.5,
        height=0.4,
    )
    home_automation_dimension = anchor_window(
        location=WindowLocation.BottomCenter,
        width=0.5,
        height=0.5,
    )

    return [
        ScratchPad(
            "0",
            dropdowns=[
                DropDown(
                    name="ncmpcpp",
                    cmd=terminal_run_command("alacritty", ["ncmpcpp"]),
                    height=ncmpcpp_dimension.height,
                    width=ncmpcpp_dimension.width,
                    x=ncmpcpp_dimension.x,
                    y=ncmpcpp_dimension.y,
                    opacity=1.0,
                    warp_pointer=False,
                ),
            ],
            single=True,
        ),
        ScratchPad(
            "home-automation",
            dropdowns=[
                DropDown(
                    name="home-automation",
                    cmd="qutebrowser https://hass.looniversity.net",
                    height=home_automation_dimension.height,
                    width=home_automation_dimension.width,
                    x=home_automation_dimension.x,
                    y=home_automation_dimension.y,
                    opacity=1.0,
                    warp_pointer=False,
                ),
            ],
            single=True,
        ),
    ]


def build_keys(settings: dict) -> list[Key]:
    return [
        Key(
            [Super, Alt],
            "F8",
            lazy.group["0"].dropdown_toggle("ncmpcpp"),
        ),
        Key(
            [Super, Alt],
            "Home",
            lazy.group["home-automation"].dropdown_toggle("home-automation"),
        ),
    ]
