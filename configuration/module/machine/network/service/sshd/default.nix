{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.looniversity.network.app.sshd;
in
{
  options.looniversity.network.app.sshd = {
    enable = mkEnableOption "sshd";
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = config.services.openssh.settings.AllowUsers != "";
        message = "AllowUsers config option is empty";
      }
    ];

    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}
