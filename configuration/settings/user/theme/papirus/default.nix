{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}: let
  cfg = config.looniversity.settings.theme.papirus;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.settings.theme.papirus = {
    enable = mkEnableOption "papirus theme";
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = osConfig.looniversity.theme.papirus.enable == true;
        message = "Papirus system-wide icon theme not enabled. Set `looniversity.theme.papirus.enable` machine module option to true";
      }
    ];

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
