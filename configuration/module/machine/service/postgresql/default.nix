{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.service.postgresql;

  inherit (lib) mkEnableOption mkIf mkOption mkOverride types;
in {
  options.looniversity.service.postgresql = {
    enable = mkEnableOption "postgresql";

    databases = mkOption {
      type = types.listOf types.str;
      default = [];
    };
  };

  config = mkIf cfg.enable {
    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_15;

      ensureDatabases = cfg.databases;
      ensureUsers =
        (map (elem: {
            name = toString elem;
            ensureDBOwnership = true;
          })
          cfg.databases)
        ++ [
          {name = "sysadmin";}
          {name = "dbadmin";}
        ];

      authentication = mkOverride 10 ''
        #type database  DBuser  auth-method optional_ident_map
        local sameuser  all     peer        map=superuser_map
      '';

      settings = {
        password_encryption = "scram-sha-256";
      };
    };
  };
}
