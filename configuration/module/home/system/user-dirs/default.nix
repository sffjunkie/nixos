{
  config,
  lib,
  pkgs,
  sops,
  ...
}: let
  cfg = config.looniversity.user-dirs;

  inherit (lib) mkEnableOption mkIf types;
in {
  options.looniversity.user-dirs = {
    enable = mkEnableOption "user-dirs";
  };

  config = mkIf cfg.enable {
    xgd.userDirs = {
      enable = true;
      desktop.default = "${config.home.homeDirectory}/desktop";
      documents.default = "${config.home.homeDirectory}/documents";
      download.default = "${config.home.homeDirectory}/downloads";
      music.default = "${config.home.homeDirectory}/music";
      pictures.default = "${config.home.homeDirectory}/pictures";
      publicShare.default = "${config.home.homeDirectory}/public";
      templates.default = "${config.home.homeDirectory}/templates";
      videos.default = "${config.home.homeDirectory}/videos";
    };

    networking.firewall = {
      allowedTCPPorts = [8384];
    };
  };
}
