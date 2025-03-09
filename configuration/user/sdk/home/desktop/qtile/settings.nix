{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  config = {
    xdg.configFile."desktop/settings.yaml".text = lib.generators.toYAML { } {
      app = {
        brain = "${pkgs.obsidian}/bin/obsidian";
        browser = "${pkgs.brave}/bin/brave";
        code = "${pkgs.vscode.fhs}/bin/code";
        system-menu = "rofi-launcher";
        terminal = "${pkgs.alacritty}/bin/alacritty";
        volume = "${pkgs.pavucontrol}/bin/pavucontrol";
      };

      controller = {
        music = {
          next = "musicctl next";
          play = "musicctl play";
          previous = "musicctl previous";
          stop = "musicctl stop";
          toggle = "musicctl toggle";
        };

        volume = {
          down = "volumectl down";
          mute = "volumectl mute";
          toggle = "volumectl toggle";
          up = "volumectl up";
        };
      };

      device = {
        net = "wlp3s0";
      };

      key = {
        alt = "mod1";
        ctrl = "control";
        hyper = "mod3";
        shift = "shift";
        cmd = "mod4";
      };
    };
  };
}
