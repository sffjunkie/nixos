{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.dunst;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.dunst = {
    enable = mkEnableOption "dunst";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.dunst
    ];
  };
}
