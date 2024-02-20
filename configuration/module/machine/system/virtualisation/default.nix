{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.virtualisation;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.virtualisation = {
    enable = mkEnableOption "virtualisation";
  };

  config = mkIf cfg.enable {
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
          ovmf = {
            enable = true;
            packages = [pkgs.OVMFFull.fd];
          };
        };
      };
      spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;

    environment.variables = {
      LIBVIRT_DEFAULT_URI = "qemu:///system";
    };

    environment.systemPackages = [
      pkgs.spice
      pkgs.spice-gtk
      pkgs.spice-protocol
      pkgs.vagrant
      pkgs.virt-manager
      pkgs.virt-viewer
      pkgs.python3Packages.libvirt
    ];
  };
}
