{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.display_manager.greetd;

  inherit (lib) mkEnableOption mkIf mkMerge mkOption types;
in {
  options.looniversity.display_manager.greetd = {
    enable = mkEnableOption "greetd display manager";
  };

  config = mkIf cfg.enable {
    services.greetd.enable = true;
  };
}
