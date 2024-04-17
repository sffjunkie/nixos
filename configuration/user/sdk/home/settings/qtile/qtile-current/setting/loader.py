from pathlib import Path

import yaml

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
        "volume": volume_control_commands(),
    }

    settings.update(DEFAULT_SETTINGS)

    settings_file = Path(__file__).parent.parent / "settings.yaml"
    if settings_file.exists():
        with settings_file.open() as fp:
            settings_yaml = yaml.load(fp, yaml.SafeLoader)
        settings.update(settings_yaml)

    return settings
