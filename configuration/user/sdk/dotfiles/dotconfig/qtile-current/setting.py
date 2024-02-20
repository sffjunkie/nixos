import os
from enum import Enum
from pathlib import Path
from typing import Optional

import yaml

from secret import load_secrets
from theme import load_theme

__settings = None

DEFAULT_SETTINGS = {
    "mod": "mod4",
    "term": "alacritty",
    "wifi": "wlan0",
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


def load_settings() -> dict:
    settings = {
        "theme": load_theme(),
        "volume": volume_control_commands(),
    }

    settings.update(DEFAULT_SETTINGS)

    settings["secrets"] = load_secrets()

    settings_file = Path(__file__).parent / "settings.yaml"
    if settings_file.exists():
        with settings_file.open() as fp:
            settings_yaml = yaml.load(fp, yaml.SafeLoader)
        settings.update(settings_yaml)

    return settings
