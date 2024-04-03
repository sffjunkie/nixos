{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.libnotify;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.libnotify = {
    enable = mkEnableOption "libnotify";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.libnotify
    ];
  };
}
