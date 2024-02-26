{
  config,
  lib,
  ...
}: let
  wanDev = lib.network.netdevice config "pinky" "wan";
  lanDev = lib.network.netdevice config "pinky" "lan";

  vlans = config.looniversity.network.vlans;
  vlanInterfaces =
    lib.mapAttrs
    (
      name: value: let
        vlanInfo = vlans.${name};
      in {
        useDHCP = false;
        ipv4 = {
          addresses = [
            {
              address = lib.ipv4.constructIpv4Address vlanInfo.network "1";
              prefixLength = vlanInfo.prefixLength;
            }
          ];
        };
      }
    )
    vlans;
in {
  config = {
    networking = {
      hostId = "dbe3c39e";
      hostName = "pinky";
      domain = "looniversity.net";

      interfaces =
        {
          "${wanDev}" = {
            useDHCP = lib.mkDefault false;
            # ipv4 set by pppd
          };

          "${lanDev}" = {
            useDHCP = lib.mkDefault false;
            ipv4 = {
              addresses = [
                {
                  address = lib.ipv4.constructIpv4Address config.looniversity.network.network "1";
                  prefixLength = config.looniversity.network.prefixLength;
                }
              ];
            };
          };
        }
        // vlanInterfaces;
    };
  };
}
