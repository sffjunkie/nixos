{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.system.ssh;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.system.ssh = {
    enable = mkEnableOption "ssh";
  };

  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;
    };
  };
}
