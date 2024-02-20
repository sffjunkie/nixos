{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.gnumake;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.gnumake = {
    enable = mkEnableOption "gnumake";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.gnumake
    ];
  };
}
