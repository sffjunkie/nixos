# nixos/modules/services/networking/nat.nix
{
  config,
  lib,
  ...
}: let
  wanDev = lib.network.getNetdevice config "pinky" "wan";
  lanDev = lib.network.getNetdevice config "pinky" "lan";
in {
  config = {
    networking.nat = {
      enable = true;
      externalInterface = wanDev;
      internalInterfaces = [lanDev];
    };
  };
}
