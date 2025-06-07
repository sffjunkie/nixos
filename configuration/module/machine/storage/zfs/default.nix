{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.looniversity.system.zfs.autoscrub;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.looniversity.system.zfs.autoscrub = {
    enable = mkEnableOption "ZFS auto scrubbing";
  };

  config = mkIf cfg.enable {
    services.zfs.autoScrub.enable = true;
  };
}
