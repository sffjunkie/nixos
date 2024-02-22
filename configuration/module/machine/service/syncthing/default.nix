{
  config,
  lib,
  pkgs,
  sops,
  ...
}: let
  cfg = config.looniversity.service.syncthing;

  inherit (lib) mkEnableOption mkIf types;
  inherit (builtins) isNull;
in {
  options.looniversity.service.syncthing = {
    enable = mkEnableOption "syncthing server";
  };

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;

      settings = {
        guiAddress = "0.0.0.0:8384";
      };
    };
  };
}
