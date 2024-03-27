{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.yubikeyManager;

  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.yubikeyManager = {
    enable = mkEnableOption "Yubikey Manager";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.yubikey-manager
      pkgs.yubikey-manager-qt
    ];
  };
}
