{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.mpv;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.mpv = {
    enable = mkEnableOption "mpv";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.mpv
    ];
  };
}
