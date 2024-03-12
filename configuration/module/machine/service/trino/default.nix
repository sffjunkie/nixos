{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.service.trino;

  inherit (lib) mkEnableOption mkIf mkOption types;
in {
  options.looniversity.service.trino = {
    enable = mkEnableOption "trino";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.trino
    ];
  };
}
