{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.mount.backup;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.mount.backup = {
    enable = mkEnableOption "backup mount";
  };

  config = mkIf cfg.enable {
    fileSystems."/mnt/backup" = {
      device = "10.44.0.3:/tank0/backup";
      fsType = "nfs";
      options = ["x-systemd.automount" "x-systemd.requires=network-online.target" "noauto"];
    };
  };
}
