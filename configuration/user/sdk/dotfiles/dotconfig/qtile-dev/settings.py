import os
from enum import Enum
from pathlib import Path
from typing import Optional

import yaml

from secret import load_secrets
from theme import load_theme

__settings = None

DEFAULT_TERMINAL = "xterm"
DEFAULT_MIXER = "pulsemixer"
DEFAULT_VOLUME_CMD = "~/.local/bin/vol"

DEFAULT_SETTINGS = {
    "mod": "mod4",
    "terminal": DEFAULT_TERMINAL,
    "mixer": DEFAULT_MIXER,
    "vol_cmd": DEFAULT_VOLUME_CMD,
}


def volume_control_commands() -> dict:
    mixer = os.environ.get("AUDIO_MIXER", DEFAULT_MIXER)
    vol_cmd = os.environ.get("AUDIO_VOLUME_CMD", DEFAULT_VOLUME_CMD)

    return {
        "up": [vol_cmd, "up"],
        "down": [vol_cmd, "down"],
        "mute": [vol_cmd, "mute"],
        "toggle": [vol_cmd, "toggle"],
        "app": mixer,
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
