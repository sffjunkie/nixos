{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.gnomeApps;
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs) gnome;
in {
  options.looniversity.gnomeApps = {
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
