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
      service.elasticsearch.enable = true;
      service.mongodb.enable = true;
      service.graylog = {
        enable = true;
        extraConfig = "http_bind_address = 127.0.0.1:9011";
        elasticsearchHosts = ["http://localhost:9200"];
      };
    };
  };
}
