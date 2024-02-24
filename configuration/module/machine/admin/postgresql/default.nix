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
    services.pgadmin = {
      enable = true;
      port = port;
    };
  };
}
