{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.looniversity.service.gitea;

  postgresql_hostname = lib.network.serviceHandlerFQDN "postgresql";
  git_hostname = lib.network.serviceFQDN "git";
  http_port = lib.network.serviceHandlerMainPort "gitea";

  inherit (lib) mkDefault mkEnableOption mkIf;
in
{
  options.looniversity.service.gitea = {
    enable = mkEnableOption "gitea";
  };

  config = mkIf cfg.enable {
    sops.secrets."gitea/root_password" = {
      owner = config.users.users.gitea.name;
      sopsFile = config.sopsFiles.service;
    };
    sops.secrets."gitea/db_password" = {
      owner = config.users.users.gitea.name;
      sopsFile = config.sopsFiles.service;
    };

    services.gitea = {
      enable = true;
      appName = "Looniversity gitea server";

      database = {
        type = "postgres";
        host = postgresql_hostname;
        user = "gitea";
        passwordFile = config.sops.secrets."gitea/db_password".path;
      };

      setings = {
        server = {
          DOMAIN = git_hostname;
          HTTP_PORT = http_port;
          DISABLE_REGISTRATION = true;
          COOKIE_SECURE = true;
        };
      };
    };

    config.looniversity.service.postgresql.databases = "gitea";
  };
}
