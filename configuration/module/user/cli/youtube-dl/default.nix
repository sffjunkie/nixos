{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.cli.youtubeDl;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.cli.youtubeDl = {
    enable = mkEnableOption "youtube-dl";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.yt-dlp
    ];
  };
}
