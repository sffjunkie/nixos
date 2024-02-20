{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.mount.music;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.mount.music = {
    enable = mkEnableOption "music";
  };

  config = mkIf cfg.enable {
    fileSystems."/mnt/music" = {
      device = "10.44.0.3:/tank0/music";
      fsType = "nfs";
    };
  };
}
