{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.looniversity.service.openvpn;
in {
  options.looniversity.service.openvpn = {
    enable = mkEnableOption "openvpn";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.openvpn
    ];
  };
}
