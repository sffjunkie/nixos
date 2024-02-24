{
  config,
  lib,
  ...
}: let
  cfg = config.looniversity.admin.postgresql;

  port = lib.network.get

  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.admin.postgresql = {
    enable = mkEnableOption "postgresql";
  };

  config = mkIf cfg.enable {
    services.pgadmin = {
      enable = true;
    };
  };
}
