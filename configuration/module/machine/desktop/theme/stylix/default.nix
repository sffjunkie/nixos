{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.desktop.stylix;

  nerdfonts = pkgs.nerdfonts.override {
    fonts = [
      "Hack"
    ];
  };

  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  options.looniversity.desktop.stylix = {
    enable = mkEnableOption "stylix";
  };

  config = mkIf cfg.enable {
    stylix = {
      homeManagerIntegration.autoImport = false;

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
