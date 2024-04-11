{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.theme.stylix;

  nerdfonts = pkgs.nerdfonts.override {
    fonts = [
      "Hack"
    ];
  };

  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.theme.stylix = {
    enable = mkEnableOption "stylix";
  };

  config = mkIf cfg.enable {
    stylix = {
      cursor = {
        package = pkgs.nordzy-cursor-theme;
        name = "Nordzy-cursors";
      };

      image = ./nix-wallpaper-stripes-logo.png;

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
