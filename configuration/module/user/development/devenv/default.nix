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
  };
}
