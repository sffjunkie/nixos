{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.yubikey_plus;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.yubikey_plus = {
    enable = mkEnableOption "Yubikey Plus udev rule";
  };

  config = mkIf cfg.enable {
    services.udev.extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1050", ATTRS{idProduct}=="0010", TAG+="uaccess"
    '';
  };
}
