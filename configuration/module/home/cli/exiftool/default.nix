{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.exiftool;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.exiftool = {
    enable = mkEnableOption "exiftool";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.exiftool
    ];
  };
}
