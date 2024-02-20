{
  config,
  lib,
  ...
}: let
  cfg = config.looniversity.role.server;
  inherit (lib) mkEnableOption mkIf optionals;
in {
  options.looniversity.role.server = {
    enable = mkEnableOption "server role";
  };

  config = mkIf cfg.enable {
    looniversity = {
      pinentry.enable = true;

      profile.hardened.enable = true;

      service.autoUpgrade.enable = true;
      service.fail2ban.enable = true;
      service.sshd.enable = true;
    };

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [80 443];
    };
  };
}
