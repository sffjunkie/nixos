{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.desktop.qtile;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.desktop.qtile = {
    enable = mkEnableOption "qtile desktop";
  };

  config = mkIf cfg.enable {
    looniversity = {
      display_manager.greetd.enable = true;
      display_manager.tuigreet.enable = true;

      window_manager.qtile.enable = true;

      polkit.enable = true;
      lockscreen.enable = true;
    };

    xdg.portal.enable = true;
    xdg.portal.wlr.enable = true;

    environment.systemPackages = [
      pkgs.gsettings-desktop-schemas
    ];

    programs = {
      dconf.enable = true;
      xwayland.enable = true;
    };
  };
}
