{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.looniversity.role.gateway;
in {
  options.looniversity.role.gateway = {
    enable = mkEnableOption "gateway role";
  };

  config = mkIf cfg.enable {
    looniversity = {
      service.sshd.enable = true;
      gateway = {
        nat.enable = true;
        pppd.enable = true;
      };
    };
  };
}
