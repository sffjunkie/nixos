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
          width = 600;
          max-icon-size = 256;
          anchor = "bottom-right";
          outer-margin = "60,8";
          format = "%b";
        };
      };
    };
  };
}
