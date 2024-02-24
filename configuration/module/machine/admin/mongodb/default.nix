{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.admin.mongodb;

  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.admin.mongodb = {
    enable = mkEnableOption "mongodb admin";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.mongodb-compass
    ];
  };
}
