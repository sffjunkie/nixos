{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.dunst;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    services.dunst = {
      enable = true;
      settings = {
        global = {
          width = 500;
          height = 300;
          origin = "top-right";
          offset = "10x50";
          font = "\"Hack Nerd Font\": 12";
          notification_limit = 20;
          transparency = 0;
          separator_height = 2;
          padding = 8;
          horizontal_padding = 8;
          frame_color = "#aaaaaa";
          separator_color = "frame";
          markup = "full";
          icon_position = "left";
          min_icon_size = 32;
          max_icon_size = 128;
        };
      };
    };
  };
}
