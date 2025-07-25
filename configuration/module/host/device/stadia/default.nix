{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.looniversity.device.stadia;

  udev_rule = pkgs.writeTextFile {
    name = "stadia_udev";
    text = ''
      # SDP protocol
      KERNEL=="hidraw*", ATTRS{idVendor}=="1fc9", MODE="0666"
      ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="1fc9", MODE="0666"
      ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0d28", MODE="0666"
      # Flashloader
      KERNEL=="hidraw*", ATTRS{idVendor}=="15a2", MODE="0666"
      # Controller
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="18d1", MODE="0666"
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="18d1", ATTRS{idProduct}=="9400", MODE="0660", TAG+="uaccess"
    '';
    destination = "/lib/udev/rules.d/70-stadiacontroller-flash.rules";
  };

  inherit (lib) mkEnableOption mkIf;
in
{
  options.looniversity.device.stadia = {
    enable = mkEnableOption "stadia controller updating";
  };

  config = mkIf cfg.enable {
    services.udev.packages = [
      udev_rule
    ];
  };
}
