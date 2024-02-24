{
  config,
  lib,
  ...
}: let
  wanDev = lib.network.getNetdevice config "pinky" "wan";
  lanDev = lib.network.getNetdevice config "pinky" "lan";
in {
  config = {
    networking = {
      hostId = "dbe3c39e";
      hostName = "pinky";
      domain = "looniversity.net";

      interfaces = {
        "${wanDev}" = {
          useDHCP = lib.mkDefault false;
          # ipv4 set by pppd
        };

        "${lanDev}" = {
          useDHCP = lib.mkDefault false;
          ipv4 = {
            addresses = [
              {
                address = "10.44.0.1";
                prefixLength = 21;
              }
            ];
          };
        };

        guest = {
          useDHCP = lib.mkDefault false;
          ipv4 = {
            addresses = [
              {
                address = "10.44.10.1";
                prefixLength = 24;
              }
            ];
          };
        };

        iot = {
          useDHCP = lib.mkDefault false;
          ipv4 = {
            addresses = [
              {
                address = "10.44.20.1";
                prefixLength = 24;
              }
            ];
          };
        };

        not = {
          useDHCP = lib.mkDefault false;
          ipv4 = {
            addresses = [
              {
                address = "10.44.30.1";
                prefixLength = 24;
              }
            ];
          };
        };
      };

      vlans = {
        guest = {
          id = 10;
          interface = "${lanDev}";
        };
        iot = {
          id = 20;
          interface = "${lanDev}";
        };
        not = {
          id = 30;
          interface = "${lanDev}";
        };
      };
    };
  };
}
