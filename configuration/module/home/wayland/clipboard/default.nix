{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.wayland.clipboard;
  inherit (lib) mkDefault mkEnableOption mkIf mkOption;
in {
  options.looniversity.wayland.clipboard.enable = mkEnableOption "clipboard support";

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.wl-clipboard
    ];
  };
}
