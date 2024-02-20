{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.keyring;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.keyring = {
    enable = mkEnableOption "keyring";
  };

  config = mkIf cfg.enable {
    services.gnome.gnome-keyring.enable = true;
  };
}
