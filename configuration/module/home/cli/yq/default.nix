{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.yq;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.yq = {
    enable = mkEnableOption "yq";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.yq
    ];
  };
}
