{
  config,
  lib,
  ...
}: let
  wolInterface = lib.getNetdevice config "babs" "lan";
in {
  config = {
    networking = {
      hostId = "fafececd";
      hostName = "babs";
      domain = "looniversity.net";

      systemd.network = {
        enable = true;

        networks = {
          matchConfig.Name = "eno1";
          networkConfig.DHCP = "ipv4";
          linkConfig = {
            GenericSegmentationOffload = false;
            GenericReceiveOffload = false;
            TCPSegmentationOffload = false;
          };
        };
      };

      interfaces.${wolInterface}.wakeOnLan.enable = true;
    };
  };
}
