{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.settings.qtile;

  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.settings.qtile = {
    enable = mkEnableOption "qtile settings";
  };

  config = mkIf (cfg.enable) {
    xdg.configFile = {
      "qtile" = {
        source = ../../../dotfiles/dotconfig/qtile-current;
        recursive = true;
      };
    };
  };
}
