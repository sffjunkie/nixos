import os
from pathlib import Path

import yaml  # type: ignore

from libqtile.log_utils import logger  # type: ignore

DEFAULT_SETTINGS = {
    "mod": "mod4",
    "term": "alacritty",
    "netdevice": "wifi",
}


def volume_control_commands() -> dict:
    command = ["~/.local/bin/vol"]
    return {
        "up": command + ["up"],
        "down": command + ["down"],
        "mute": command + ["mute"],
        "toggle": command + ["toggle"],
        "app": "pulsemixer",
    }


def _settings_path(filepath: Path | None = None) -> str:
    if filepath is None or not filepath.is_absolute():
        if filepath is None:
            filepath = "theme.yaml"

        xdg_config = Path(
            os.environ.get(
                "XDG_CONFIG_HOME",
                os.path.expanduser("~/.config"),
            )
        )
        settings_path = xdg_config / "desktop" / filepath
    else:
        settings_path = filepath

    return settings_path


def _settings_yaml(filepath: Path | None = None) -> dict | None:
    settings_path = _settings_path(filepath)

    settings = None
    if settings_path.exists():
        logger.info(f"Loading settings from {settings_path}")
        with open(settings_path, "r") as fp:
            settings = yaml.load(fp, yaml.SafeLoader)

    return settings


def load_settings() -> dict:
    settings = DEFAULT_SETTINGS
    settings.update(
        {
            "volume": volume_control_commands(),
        }
    )

    settings.update(DEFAULT_SETTINGS)

    settings_file = Path(__file__).parent.parent / "settings.yaml"
    if settings_file.exists():
        with settings_file.open() as fp:
            settings_yaml = yaml.load(fp, yaml.SafeLoader)
        settings.update(settings_yaml)

    return settings
