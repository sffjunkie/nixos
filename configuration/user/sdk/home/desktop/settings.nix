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
        app_launcher = "rofi-launcher";
        brain = "${pkgs.obsidian}/bin/obsidian";
        browser = "${pkgs.brave}/bin/brave";
        clipboard_copy = "rofi-clip -c";
        clipboard_delete = "rofi-clip -d";
        code = "${pkgs.vscode.fhs}/bin/code";
        system_menu = "system-menu";
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
