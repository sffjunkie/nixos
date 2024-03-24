{
  config,
  lib,
  pkgs,
  sops,
  ...
}: let
  cfg = config.looniversity.service.unifi;

  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.service.unifi = {
    enable = mkEnableOption "unifi";
  };

  config = mkIf cfg.enable {
    services.unifi = {
      enable = true;
      openFirewall = true;
    };
  };
}
