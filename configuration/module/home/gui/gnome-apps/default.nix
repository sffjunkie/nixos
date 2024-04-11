{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.gui.gnomeApps;
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs) gnome;
in {
  options.looniversity.gui.gnomeApps = {
    enable = mkEnableOption "gnomeApps";
  };

  config = mkIf cfg.enable {
    home.packages = [
      gnome.adwaita-icon-theme
      gnome.dconf-editor
      gnome.ghex
      gnome.gnome-boxes
      gnome.gnome-characters
      gnome.gnome-tweaks
    ];
  };
}
