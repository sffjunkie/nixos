{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.restic;

  inherit (lib) mkEnableOption mkIf mkOption types;
in {
  options.looniversity.restic = {
    enable = mkEnableOption "restic";
  };

  config = mkIf cfg.enable {
    services.restic = {
      enable = true;
    };
  };
}
