{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.nodejs;

  inherit (lib) mkEnableOption mkIf mkOption types;
in {
  options.looniversity.nodejs = {
    enable = mkEnableOption "nodejs";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.nodejs_20
    ];
  };
}
