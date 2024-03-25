{
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
    sops.secrets."restic/repositories/sdk/s3/password" = {
      sopsFile = config.sopsFiles.tool;
    };

    sops.secrets."restic/repositories/sdk/s3/access_key" = {
      sopsFile = config.sopsFiles.tool;
    };

    sops.secrets."restic/repositories/sdk/s3/secret_key" = {
      sopsFile = config.sopsFiles.tool;
    };

    sops.templates."sdk_nas_env_file" = {
      content = ''
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
