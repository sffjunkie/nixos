{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.waylock;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.waylock = {
    enable = mkEnableOption "waylock";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.waylock];
  };
}
