{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.desktop.papirus;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.theme.papirus = {
    enable = mkEnableOption "papirus theme";
  };

  config = mkIf cfg.enable {
    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          "icon-theme" = "Papirus-Dark";
        };
      };
    };
  };
}
