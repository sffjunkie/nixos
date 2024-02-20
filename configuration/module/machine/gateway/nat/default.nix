# nixos/modules/services/networking/nat.nix
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.gateway.nat;
  wanDev = lib.getNetdevice config "pinky" "wan";
  lanDev = lib.getNetdevice config "pinky" "lan";

  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.gateway.nat = {
    enable = mkEnableOption "nat";
  };

  config = mkIf cfg.enable {
    networking.nat = {
      enable = true;
      externalInterface = wanDev;
      internalInterfaces = [lanDev];
    };
  };
}
