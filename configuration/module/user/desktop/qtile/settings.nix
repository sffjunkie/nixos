{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = {
    xdg.configFile."desktop/default_settings.yaml".text = lib.generators.toYAML { } {
      apps = {
        terminal = "xterm";
        volume = "pavucontrol";
      };
      keys = {
        Alt = "mod1";
        Ctrl = "control";
        Hyper = "mod3";
        Shift = "shift";
        Super = "mod4";
      };
      commands = {
        music = {
          play = "musicctl play";
          next = "musicctl next";
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
