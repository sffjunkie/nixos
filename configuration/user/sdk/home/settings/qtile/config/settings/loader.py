import os
from pathlib import Path

import yaml  # type: ignore

from libqtile.log_utils import logger  # type: ignore

from .typedefs import Settings
from .default import DEFAULT_SETTINGS


def _settings_path(filepath: Path | None = None) -> str:
    if filepath is None or not filepath.is_absolute():
        if filepath is None:
            filepath = "settings.yaml"

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


def load_settings(filepath: Path | None = None) -> Settings:
    settings_path = _settings_path(filepath)
    logger.info(f"Loading settings from {settings_path}")
    settings_yaml = _settings_yaml(settings_path) or {}

    default_settings_path = _settings_path(Path("default_settings.yaml"))
    default_settings_yaml = _settings_yaml(default_settings_path) or {}

    default_settings_yaml.update(settings_yaml)

    logger.info(f"Settings {default_settings_yaml}")

    return default_settings_yaml
