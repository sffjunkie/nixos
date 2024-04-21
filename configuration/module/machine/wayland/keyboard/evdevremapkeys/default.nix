{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.wayland.keyboard.evdevremapkeys;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.wayland.keyboard.evdevremapkeys = {
    enable = mkEnableOption "evdevremapkeys";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      evdevremapkeys
    ];
  };
}
