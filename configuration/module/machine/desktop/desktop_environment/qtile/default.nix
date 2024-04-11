{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.desktop.environment.qtile;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.desktop.environment.qtile = {
    enable = mkEnableOption "qtile desktop";
  };

  config = mkIf cfg.enable {
    looniversity = {
      desktop = {
        display_manager.greetd.enable = true;
        display_manager.tuigreet.enable = true;
        lockscreen.swaylock.enable = true;
        window_manager.qtile.enable = true;
      };

      system = {
        polkit.enable = true;
      };
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
