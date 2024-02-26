{
  config,
  lib,
  ...
}: let
  wanDev = lib.network.netdevice config "pinky" "wan";
  lanDev = lib.network.netdevice config "pinky" "lan";

  vlans = config.looniversity.network.vlans;
  vlanInterfaces =
    map
    (
      name: let
        vlanInfo = vlans.${name};
      in {
        ${name} = {
          useDHCP = false;
          ipv4 = {
            addresses = [
              {
                address = lib.ipv4.constructIpv4Address vlanInfo.network "1";
                prefixLength = vlanInfo.prefixLength;
              }
            ];
          };
        };
      }
    )
    (lib.attrNames vlans);
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
