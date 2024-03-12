{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.gramps;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.gramps = {
    enable = mkEnableOption "gramps";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.gramps
    ];
  };
}
