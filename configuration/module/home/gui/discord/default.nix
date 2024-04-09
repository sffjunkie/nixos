{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.discord;

  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.discord = {
    enable = mkEnableOption "discord";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.discord
    ];
  };
}
