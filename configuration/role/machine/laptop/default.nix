{
  config,
  lib,
  nixos-hardware,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.looniversity.role.laptop;
in {
  options.looniversity.role.laptop = {
    enable = mkEnableOption "laptop role";
  };

  config = mkIf cfg.enable {
    looniversity = {
      libnotify.enable = true;
      keyring.enable = true;
      pipewire.enable = true;
      pinentry.enable = true;
      role.xserver.enable = true;
    };

    boot.initrd.kernelModules = [
      "intel_lpss"
      "intel_lpss_pci"
      "8250_dw"
      "pinctrl_icelake"
      "surface_aggregator"
      "surface_aggregator_registry"
      "surface_aggregator_hub"
      "surface_hid_core"
      "surface_hid"
    ];
    # nixos-hardware.microsoft-surface.ipts.enable = true;

    networking.networkmanager.enable = true;
    networking.firewall.enable = false;

    hardware.bluetooth.enable = true;
    services.xserver.libinput.enable = true;
  };
}
