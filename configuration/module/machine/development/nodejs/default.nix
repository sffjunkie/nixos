{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.development.nodejs;

  inherit (lib) mkEnableOption mkIf mkOption types;
in {
  options.looniversity.development.nodejs = {
    enable = mkEnableOption "nodejs";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.nodejs_20
    ];
  };
}
