{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.spotify;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.spotify = {
    enable = mkEnableOption "spotify";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      spotify
    ];
  };
}
