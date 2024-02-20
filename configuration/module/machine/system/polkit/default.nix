{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.looniversity.polkit;
in {
  options.looniversity.polkit = {
    enable = mkEnableOption "polkit";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.polkit_gnome
    ];
  };
}
