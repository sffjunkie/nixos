{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.development.devenv;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.development.devenv = {
    enable = mkEnableOption "devenv";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.devenv
    ];

    nix.settings = {
      extra-substituters = "https://devenv.cachix.org";
      extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    };
  };
}
