{
  config,
  lib,
  pkgs,
  sops,
  ...
}: let
  cfg = config.looniversity.service.nextcloud;

  inherit (lib) mkEnableOption mkIf mkOption types;
in {
  options.looniversity.service.nextcloud = {
    enable = mkEnableOption "nextcloud";
  };

  config = mkIf cfg.enable {
    sops.secrets."service/nextcloud/admin_password" = {
      owner = config.users.users.nextcloud.name;
    };
    sops.secrets."service/nextcloud/db_password" = {
      owner = config.users.users.nextcloud.name;
    };

    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud28;
      hostName = "cloud.looniversity.net";

      autoUpdateApps.enable = true;
      autoUpdateApps.startAt = "05:00:00";

      settings = {
        overwriteprotocol = "https";
      };

      config = {
        dbtype = "pgsql";
        dbuser = "nextcloud";
        dbhost = "/run/postgresql";
        dbname = "nextcloud";
        dbpassFile = config.sops.secrets."service/nextcloud/db_password".path;

        adminpassFile = config.sops.secrets."service/nextcloud/admin_password".path;
      };
    };

    looniversity.service.postgresql = {
      enable = true;
      databases = [config.services.nextcloud.config.dbname];
    };
  };
}
