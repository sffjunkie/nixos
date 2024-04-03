{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.desktop.gnome;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.desktop.gnome = {
    enable = mkEnableOption "gnome";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      displayManager.defaultSession = "gnome";
    };
  };
}
