{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.inkscape;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.inkscape = {
    enable = mkEnableOption "inkscape";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.inkscape
    ];
  };
}
