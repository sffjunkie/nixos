{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.role.workstation;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.role.workstation = {
    enable = mkEnableOption "workstation role";
  };

  config = mkIf cfg.enable {
    looniversity = {
      admin.mqtt.enable = true;
      libnotify.enable = true;
      keyring.enable = true;
      pipewire.enable = true;
      service.sshd.enable = true;
      pinentry.enable = true;
      role.xserver.enable = true;
    };

    networking.networkmanager.enable = true;
    networking.firewall.enable = false;

    hardware.bluetooth.enable = true;
  };
}
