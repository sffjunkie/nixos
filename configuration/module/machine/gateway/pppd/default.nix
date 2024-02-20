{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.gateway.pppd;
  wanDev = lib.getNetdevice config "pinky" "wan";

  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.gateway.pppd = {
    enable = mkEnableOption "pppd";
  };

  config = mkIf cfg.enable {
    services.pppd = {
      enable = true;
      peers = {
        bt = {
          enable = true;
          autostart = true;

          config = ''
            plugin pppoe.so
            ${wanDev}
            user "homehub@btinternet.com"

            persist
            maxfail 0
            holdoff 5
            mtu 1492
            noaccomp

            noipdefault
            defaultroute
          '';
        };
      };
    };
  };
}
