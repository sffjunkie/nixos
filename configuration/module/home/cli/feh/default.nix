{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.feh;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.feh = {
    enable = mkEnableOption "feh";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.feh
    ];

    xdg.configFile."feh/buttons".source = ./buttons;
    xdg.configFile."feh/themes".source = ./themes;

    programs.zsh.shellAliases = {
      feh = "feh -Tdefault";
      fehs = "feh -Tslideshow";
    };
  };
}
