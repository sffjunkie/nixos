{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.imagemagick;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.imagemagick = {
    enable = mkEnableOption "imagemagick";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.imagemagick
    ];
  };
}
