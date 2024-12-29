{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.looniversity.settings.qtile;

  inherit (lib) mkEnableOption mkIf mkOption types;
in
{
  options.looniversity.settings.qtile = {
    enable = mkEnableOption "qtile settings";
  };

  config = mkIf (cfg.enable) {
    xdg.configFile = {
      "qtile" = {
        source = ./config;
        recursive = true;
      };
    };

    looniversity.script = {
      system-menu.enable = true;
      rofi-clip.enable = true;
      rofi-launcher.enable = true;
    };
  };
}
