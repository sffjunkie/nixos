{
  config,
  lib,
  sops,
  ...
}: let
  cfg = config.looniversity.service.minio;

  listenPort = lib.network.serviceHandlerNamedPort config "minio" "listen";
  consolePort = lib.network.serviceHandlerNamedPort config "minio" "console";

  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.service.minio = {
    enable = mkEnableOption "minio";
  };

  config = mkIf cfg.enable {
    sops.secrets."service/minio/root_user" = {owner = config.users.users.minio.name;};
    sops.secrets."service/minio/root_password" = {owner = config.users.users.minio.name;};

    sops.templates."minio_env_file" = {
      content = ''
        MINIO_ROOT_USER=${config.sops.placeholder."service/minio/root_user"}
        MINIO_ROOT_PASSWORD=${config.sops.placeholder."service/minio/root_password"}
      '';
      owner = config.users.users.minio.name;
    };

    services.minio = {
      enable = true;
      listenAddress = ":${toString listenPort}";
      consoleAddress = ":${toString consolePort}";
      rootCredentialsFile = config.sops.templates."minio_env_file".path;
    };

    networking.firewall.allowedTCPPorts = [listenPort consolePort];
  };
}
