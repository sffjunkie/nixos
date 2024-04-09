{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.desktop.stylix;
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
    };
  };
}
