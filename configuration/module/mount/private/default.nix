{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.mount.private;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.mount.private = {
    enable = mkEnableOption "Private";
  };

  config = mkIf cfg.enable {
    fileSystems."/mnt/iso" = {
      device = "10.44.0.3:/tank1/private";
      fsType = "nfs";
      options = ["x-systemd.automount" "x-systemd.requires=network-online.target" "noauto"];
    };
  };
}
