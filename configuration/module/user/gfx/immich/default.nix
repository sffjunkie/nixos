{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.looniversity.gui.immich;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.looniversity.gui.immich = {
    enable = mkEnableOption "immich";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.immich
      pkgs.immich-go
    ];
  };
}
