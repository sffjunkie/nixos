{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.obs-studio;
  obs-plugins = pkgs.obs-studio-plugins;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.obs-studio = {
    enable = mkEnableOption "obs-studio";
  };

  config = mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      plugins = [
        obs-plugins.droidcam-obs
      ];
    };
  };
}
