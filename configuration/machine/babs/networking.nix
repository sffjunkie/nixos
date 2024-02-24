{
  config,
  lib,
  ...
}: let
  wolInterface = lib.network.netdevice config "babs" "lan";
in {
  config = {
    networking = {
      hostId = "fafececd";
      hostName = "babs";
      domain = "looniversity.net";

      interfaces.${wolInterface}.wakeOnLan.enable = true;
    };

    systemd.network = {
      enable = true;

      networks = {
        eno1 = {
          matchConfig.Name = "eno1";
          networkConfig.DHCP = "ipv4";
        };
      };

      links = {
        eno1 = {
          matchConfig.Name = "eno1";
          linkConfig = {
            GenericSegmentationOffload = false;
            GenericReceiveOffload = false;
            TCPSegmentationOffload = false;
          };
        };
      };
    };
  };
}
