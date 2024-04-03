{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.wallpaper;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.theme.wallpaper = {
    enable = mkEnableOption "wallpaper management";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.swww
      pkgs.waypaper
    ];
  };
}
