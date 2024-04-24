{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.wayland.keyboard.evdevremapkeys;

  udev_rule = pkgs.writeTextFile {
    name = "evdevremapkeys_udev";
    text = ''
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="05ac", ATTRS{idProduct}=="024f", TAG+="uaccess", MODE="0660"
    '';
    destination = "/lib/udev/rules.d/71-evdevremapkeys.rules";
  };

  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.wayland.keyboard.evdevremapkeys = {
    enable = mkEnableOption "evdevremapkeys udev rule";
  };

  config = mkIf cfg.enable {
    services.udev.packages = [
      udev_rule
    ];
  };
}
