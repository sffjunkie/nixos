{
  config,
  lib,
  pkgs,
  ...
}: let
  mkHome = p: "/home/sdk/${p}";
in {
  config = {
    sops.secrets."restic/s3_access_key" = {
      owner = config.users.users.${config.services.restic.backups.sdk_nas.user}.name;
      sopsFile = config.sopsFiles.tool;
    };

    sops.secrets."restic/s3_secret_key" = {
      owner = config.users.users.${config.services.restic.backups.sdk_nas.user}.name;
      sopsFile = config.sopsFiles.tool;
    };

    sops.templates."sdk_nas_env_file" = {
      content = ''
        AWS_DEFAULT_REGION="us-east-1"
        AWS_ACCESS_KEY_ID=${config.sops.placeholder."restic/s3_access_key"}
        AWS_SECRET_ACCESS_KEY=${config.sops.placeholder."restic/s3_secret_key"}
      '';
    };

    sops.secrets."restic/repositories/sdk/s3/password" = {
      owner = config.users.users.${config.services.restic.backups.sdk_nas.user}.name;
      sopsFile = config.sopsFiles.tool;
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
