{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.desktop.nord;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.theme.nord = {
    enable = mkEnableOption "nord theme";
  };

  config = mkIf cfg.enable {
    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          "cursor-theme" = "Nordic-cursors";
          "gtk-theme" = "Nordic-darker";
        };
      };
    };
  };
}
