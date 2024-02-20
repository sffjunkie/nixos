{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.ranger;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.ranger = {
    enable = mkEnableOption "ranger";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.ranger
    ];

    xdg.configFile = {
      "ranger/rc.conf".source = ./rc.conf;
      "ranger/rifle.conf".source = ./rifle.conf;
    };
  };
}
