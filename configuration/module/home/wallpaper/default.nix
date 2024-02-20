{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.wallpaper;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.wallpaper = {
    enable = mkEnableOption "wallpaper";
  };

  config = mkIf cfg.enable {
    home.file.".local/share/backgrounds/2023-08-15-18-13-10-img19.jpg".source = ./2023-08-15-18-13-10-img19.jpg;
  };
}
