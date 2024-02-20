{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.bottom;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.bottom = {
    enable = mkEnableOption "bottom";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.bottom
    ];
  };
}
