{
  config,
  lib,
  pkgs,
  ...
}: let
  mkHome = p: "/home/sdk/${p}";
in {
  config = {
    sops.secrets."restic/repositories/sdk/s3/password" = {
      owner = config.users.users.${config.services.restic.backups.sdk_nas.user}.name;
      sopsFile = config.sopsFiles.tool;
    };

    sops.secrets."restic/repositories/sdk/s3/access_key" = {
      owner = config.users.users.${config.services.restic.backups.sdk_nas.user}.name;
      sopsFile = config.sopsFiles.tool;
    };

    sops.secrets."restic/repositories/sdk/s3/secret_key" = {
      owner = config.users.users.${config.services.restic.backups.sdk_nas.user}.name;
      sopsFile = config.sopsFiles.tool;
    };

    sops.templates."sdk_nas_env_file" = {
      content = ''
        AWS_DEFAULT_REGION="eu-west-2"
        AWS_ACCESS_KEY_ID=${config.sops.placeholder."restic/repositories/sdk/s3/access_key"}
        AWS_SECRET_ACCESS_KEY=${config.sops.placeholder."restic/repositories/sdk/s3/secret_key"}
      '';
    };

    services.restic.backups.sdk_nas = {
      user = "sdk";
      initialize = true;
      paths = map mkHome [
        "development"
        "documents"
        "persona"
        "pictures"
        "secrets"
      ];
      exclude = [
        "__pycache__"
        ".mypy_cache"
        ".pdm-build"
        ".pytest_cache"
        ".tox"
        ".venv"
        "**/obj/"
      ];
      repository = "s3:https://s3.service.looniversity.net/restic-sdk";
      passwordFile = config.sops.secrets."restic/repositories/sdk/s3/password".path;

      environmentFile = config.sops.templates."sdk_nas_env_file".path;
    };
  };
}
