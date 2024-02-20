{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.libreoffice;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.libreoffice = {
    enable = mkEnableOption "libreoffice";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.libreoffice
    ];
  };
}
