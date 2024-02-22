{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.syncthing;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.syncthing = {
    enable = mkEnableOption "syncthing";
  };

  config = mkIf cfg.enable {
    services.syncthing.enable = true;
  };
}
