{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.looniversity.role.workstation;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.looniversity.role.workstation = {
    enable = mkEnableOption "workstation role";
  };

  config = mkIf cfg.enable {
    looniversity = {
      admin = {
        mqtt.enable = true;
        mqttx.enable = true;
        mongodb.enable = true;
      };

      device = {
        wacom.enable = true;
        yubikey.enable = true;
      };

      role = {
        gui.enable = true;
      };

      desktop = {
        notification.libnotify.enable = true;
      };

      storage = {
        minio-client.enable = true;
      };

      media = {
        pipewire.enable = true;
      };

      network = {
        sshd.enable = true;
      };

      service = {
        homepage-dashboard.enable = true;
      };

      system = {
        font.enable = true;
        keyring.enable = true;
        nix-index.enable = true;
      };
    };

    environment.systemPackages = [
      pkgs.deploy-rs
      pkgs.pinentry-gtk2
      pkgs.d-spy
    ];

    networking.networkmanager.enable = true;
    networking.firewall.enable = false;

    hardware.bluetooth.enable = true;

    services.libinput.enable = true;
    services.pcscd.enable = true;
  };
}
