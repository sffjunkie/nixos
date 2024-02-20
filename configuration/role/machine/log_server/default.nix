{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.looniversity.role.log_server;
in {
  options.looniversity.role.log_server = {
    enable = mkEnableOption "log server role";
  };

  config = mkIf cfg.enable {
    looniversity = {
      elasticsearch.enable = true;
      graylog = {
        enable = true;
      };
      mongodb.enable = true;
    };
  };
}
