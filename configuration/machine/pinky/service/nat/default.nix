# nixos/modules/services/networking/nat.nix
{
  config,
  lib,
  ...
}: let
  wanDev = lib.getNetdevice config "pinky" "wan";
  lanDev = lib.getNetdevice config "pinky" "lan";
in {
  config = {
    networking.nat = {
      enable = true;
      externalInterface = wanDev;
      internalInterfaces = [lanDev];
    };
  };
}
