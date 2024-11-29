{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.mount.movies;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.mount.movies = {
    enable = mkEnableOption "Movies";
  };

  config = mkIf cfg.enable {
    fileSystems."/mnt/iso" = {
      device = "10.44.0.3:/tank1/movies";
      fsType = "nfs";
      options = ["x-systemd.automount" "x-systemd.requires=network-online.target" "noauto"];
    };
  };
}
