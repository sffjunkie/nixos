{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.settings.qtile;

  inherit (lib) mkEnableOption mkIf mkOption types;
in {
  options.looniversity.settings.qtile = {
    enable = mkEnableOption "qtile settings";

    version = mkOption {
      type = types.str;
      default = "current";
    };
  };

  config = mkIf (cfg.enable) {
    xdg.configFile = {
      "qtile" = {
        source = ./qtile-${config.looniversity.settings.qtile.version};
        recursive = true;
      };
    };
  };
}
