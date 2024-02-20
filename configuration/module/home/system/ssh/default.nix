{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.ssh;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.ssh = {
    enable = mkEnableOption "ssh";
  };

  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;
    };
  };
}
