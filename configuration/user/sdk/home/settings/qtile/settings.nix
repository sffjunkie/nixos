{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  config = lib.mkIf osConfig.looniversity.desktop.environment.qtile.enable {
    xdg.configFile."desktop/settings.yaml".text = lib.generators.toYAML { } {
      apps = {
        browser = "qutebrowser";
        music = "musicctl";
        terminal = "alacritty";
        volume = "volumectl";
      };

      devices = {
        net = "wlp3s0";
      };

      keys = {
        alt = "mod1";
        ctrl = "control";
        hyper = "mod3";
        shift = "shift";
        cmd = "mod4";
      };

      commands = {
        music = {
          play = "musicctl play";
          stop = "musicctl stop";
          next = "musicctl next";
          previous = "musicctl previous";
          toggle = "musicctl toggle";
        };
        volume = {
          up = "volumectl up";
          down = "volumectl down";
          mute = "volumectl mute";
          toggle = "volumectl toggle";
        };
      };
    };
  };
}
