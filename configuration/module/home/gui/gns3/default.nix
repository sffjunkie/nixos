{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.gns3;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.gns3 = {
    enable = mkEnableOption "gns3";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.gns3-gui
      pkgs.gns3-server
    ];

    xdg.configFile = {
      "GNS3/2.2/gns3_server.conf".source = ./server.conf;
      "GNS3/2.2/gns3_controller.conf".source = ./controller.conf;
    };
  };
}
