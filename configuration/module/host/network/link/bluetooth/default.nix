{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.looniversity.network.link.bluetooth;
  inherit (lib) enabled mkEnableOption mkIf;
in
{
  options.looniversity.network.link.bluetooth = {
    enable = mkEnableOption "bluetooth";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    services.blueman = enabled;
  };
}
