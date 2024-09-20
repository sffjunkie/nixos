{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}: let
  cfg = config.looniversity.settings.theme.nord;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.settings.theme.nord = {
    enable = mkEnableOption "nord theme";
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = osConfig.looniversity.theme.nord.enable == true;
        message = "Nord system-wide icon theme not enabled. Set `looniversity.theme.nord.enable` machine module option to true";
      }
    ];

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
