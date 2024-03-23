{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.minio-client;
  inherit (lib) mkEnableOption mkIf mkOption types;
in {
  options.looniversity.minio-client = {
    enable = mkEnableOption "minio-client";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.minio-client
    ];
  };
}
