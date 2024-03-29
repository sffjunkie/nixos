{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.rofi;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.rofi = {
    enable = mkEnableOption "rofi";
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      theme = ./nord.rasi;
    };

    home.packages = [
      pkgs.rofi-power-menu
    ];
  };
}
