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

      image = ./nix-wallpaper-stripes-logo.png;

      fonts = {
        monospace = {
          name = "Hack Nerd Font Mono";
          package = nerdfonts;
        };

        sizes = {
          terminal = 13;
        };
      };
    };
  };
}
