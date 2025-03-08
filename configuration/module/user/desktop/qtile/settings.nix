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
          next = "msuicctl next";
        };
        volume = {
          up = ''pulsemixer --change-volume +"$NUM"'';
          down = ''pulsemixer --change-volume -"$NUM"'';
          mute = "pulsemixer --mute";
          toggle = "pulsemixer --toggle-mute";
        };
      };
    };
  };
}
