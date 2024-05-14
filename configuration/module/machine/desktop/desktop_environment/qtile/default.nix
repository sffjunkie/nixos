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
        greeter.tuigreet.enable = true;
        window_manager.qtile.enable = true;
      };

      system = {
        polkit.enable = true;
      };

      wayland = {
        lockscreen.swaylock.enable = true;
      };
    };

    xdg.portal = {
      enable = true;
      configPackages = [pkgs.xdg-desktop-portal-wlr];
    };
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
