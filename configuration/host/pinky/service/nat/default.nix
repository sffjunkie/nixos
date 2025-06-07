# nixos/modules/services/networking/nat.nix
{
  config,
  lib,
  ...
}:
let
  wanDev = lib.network.netdevice config "pinky" "wan";
  lanDev = lib.network.netdevice config "pinky" "lan";
in
{
  config = {
    networking.nat = {
      enable = true;
      externalInterface = wanDev;
      internalInterfaces = [ lanDev ];
    };
  };
}
