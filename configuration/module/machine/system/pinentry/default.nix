{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.pinentry;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.pinentry = {
    enable = mkEnableOption "pinentry";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.pinentry-gtk2
      pkgs.pinentry-curses
    ];
  };
}
