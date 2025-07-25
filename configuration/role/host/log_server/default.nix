{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.looniversity.role.log_server;

  inherit (lib) enabled mkEnableOption mkIf;
in
{
  options.looniversity.role.log_server = {
    enable = mkEnableOption "log server role";
  };

  config = mkIf cfg.enable {
    looniversity = {
      service.elasticsearch = enabled;
      service.mongodb = enabled;
      service.graylog = {
        enable = true;
        package = pkgs.graylog-6_1;

        extraConfig = "http_bind_address = 0.0.0.0:9011";
        elasticsearchHosts = [ "http://localhost:9200" ];
      };
    };
  };
}
