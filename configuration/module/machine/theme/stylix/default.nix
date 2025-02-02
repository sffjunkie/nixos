{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.looniversity.theme.stylix;

  nerdfonts = pkgs.nerdfonts.override {
    fonts = [
      "Hack"
    ];
  };

  inherit (lib) mkDefault mkEnableOption mkIf;
in
{
  options.looniversity.theme.stylix = {
    enable = mkEnableOption "stylix";
  };

  config = mkIf cfg.enable {
    stylix = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

      cursor = {
        name = "Nordzy-cursors";
        package = pkgs.nordzy-cursor-theme;
      };

      fonts = {
        monospace = {
          name = "Hack Nerd Font Mono";
          package = nerdfonts;
        };

        sizes = {
          popups = 13;
          terminal = 13;
        };
      };

      polarity = "dark";
    };
  };
}
