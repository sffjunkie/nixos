{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.storage.udiskie;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.storage.udiskie = {
    enable = mkEnableOption "udiskie";
  };

  config = mkIf cfg.enable {
    services.udiskie = {
      enable = true;
      tray = "never";
    };
  };
}
