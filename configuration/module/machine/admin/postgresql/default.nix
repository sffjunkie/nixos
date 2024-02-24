{
  config,
  lib,
  ...
}: let
  cfg = config.looniversity.admin.postgresql;

  port = lib.tool.getToolPort config "postgresql-admin";

  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.admin.postgresql = {
    enable = mkEnableOption "postgresql admin";
  };

  config = mkIf cfg.enable {
    sops.secrets."tool/pgadmin/initial_password" = {owner = config.users.users.pgadmin.name;};

    services.pgadmin = {
      enable = true;
      port = port;

      initialEmail = "siteadmin@looniversity.lan";
      initialPasswordFile = config.sops.secrets."tool/pgadmin/initial_password".path;
    };
  };
}
