{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.lutris;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.lutris = {
    enable = mkEnableOption "lutris";
  };

  config = mkIf cfg.enable {
    hardware.opengl.driSupport32Bit = true;
    environment.systemPackages = [
      pkgs.lutris
    ];
  };
}
