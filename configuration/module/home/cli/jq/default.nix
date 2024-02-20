{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.jq;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.jq = {
    enable = mkEnableOption "jq";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.jq
    ];
  };
}
