{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.looniversity.system.bluetooth;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.looniversity.system.bluetooth = {
    enable = mkEnableOption "bluetooth";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    services.blueman.enable = true;
  };
}
