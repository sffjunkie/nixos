{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.gh;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.gh = {
    enable = mkEnableOption "gh";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.gh
    ];
  };
}
