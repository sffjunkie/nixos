{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.looniversity.desktop.mako;
  inherit (lib) mkIf mkEnableOption;
in
{
  options.looniversity.desktop.mako = {
    enable = mkEnableOption "mako notifications";
  };

  config = mkIf cfg.enable {
    services.mako = {
      enable = true;
      settings = {
        anchor = "top-right";
        outer-margin = "45,8";

        "app-name=music-notify" = {
          width = config.looniversity.music.notify.iconSize * 2.25;
          height = config.looniversity.music.notify.iconSize;
          max-icon-size = config.looniversity.music.notify.iconSize;
          anchor = "bottom-right";
          outer-margin = "60,8";
          format = "%b";
        };
      };
    };
  };
}
