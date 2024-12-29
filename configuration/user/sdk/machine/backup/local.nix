{ config
, lib
, pkgs
, ...
}:
let
  mkHome = p: "/home/sdk/${p}";
in
{
  config = {
    sops.secrets."restic/repositories/sdk/local/password" = {
      owner = config.users.users.sdk.name;
      sopsFile = config.sopsFiles.tool;
    };

    services.restic.backups.sdk_local = {
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
      repository = "/home/sdk/backup/";
      passwordFile = config.sops.secrets."restic/repositories/sdk/local/password".path;
    };

    system.activationScripts."restic_sdk_local" = ''
      mkdir /home/sdk/backup 2>/dev/null && chown sdk:users /home/sdk/backup
    '';
  };
}
