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

      useDHCP = lib.mkDefault true;
      interfaces.${wolInterface}.wakeOnLan = true;
    };
  };
}
