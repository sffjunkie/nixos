{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.settings.qt;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.settings.qt = {
    enable = mkEnableOption "qt";
  };

  config = mkIf cfg.enable {
    qt = {
      enable = true;
      platformTheme = "gnome";
      style.name = "adwaita";
    };
  };
}
