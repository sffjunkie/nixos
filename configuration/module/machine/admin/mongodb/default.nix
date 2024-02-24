{
  config,
  lib,
  ...
}: let
  cfg = config.looniversity.admin.mongodb;

  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.admin.mongodb = {
    enable = mkEnableOption "mongodb";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      mongodb-compass
    ];
  };
}
