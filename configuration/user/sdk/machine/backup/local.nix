{
  config,
  lib,
  pkgs,
  ...
}: let
  mkHome = p: "/home/sdk/${p}";
in {
  config = lib.mkIf config.looniversity.restic.enable {
    sops.secrets."restic/repositories/sdk/local/password" = {
      sopsFile = config.sopsFiles.tool;
    };

    services.restic.backups.local = {
      paths = map mkHome [
        "secrets"
        "development"
        "documents"
        "persona"
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
      mkdir /home/sdk/backup 2>/dev/null
    '';
  };
}
