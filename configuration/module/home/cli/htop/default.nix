{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.htop;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.htop = {
    enable = mkEnableOption "htop";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.htop
    ];
  };
}
