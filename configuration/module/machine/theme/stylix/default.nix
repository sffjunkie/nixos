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
      enable = true;
      image = ./dark_swirl.png;

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
