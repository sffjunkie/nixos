{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.gimp;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.gimp = {
    enable = mkEnableOption "gimp";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.gimp
    ];
  };
}
