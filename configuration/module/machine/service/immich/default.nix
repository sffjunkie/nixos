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
    services.immich = {
      enable = true;
      port = 2283;
    };
    # home.packages = [
    #   pkgs.immich-go
    # ];
  };
}
