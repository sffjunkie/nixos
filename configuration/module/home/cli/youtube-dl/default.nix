{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.youtubeDl;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.youtubeDl = {
    enable = mkEnableOption "youtube-dl";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.yt-dlp
    ];
  };
}
