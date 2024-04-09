{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.desktop.wallpaper;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.desktop.wallpaper = {
    enable = mkEnableOption "wallpaper management";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.swww
      pkgs.waypaper
    ];

    home.file.".local/share/backgrounds/nix-wallpaper-stripes-logo.png".source = ./nix-wallpaper-stripes-logo.png;
    stylix.image = ./nix-wallpaper-stripes-logo.png;
  };
}
