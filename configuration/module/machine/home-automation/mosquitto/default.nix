{
  config,
  lib,
  sops,
  ...
}: let
  cfg = config.looniversity.service.mosquitto;

  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.service.mosquitto = {
    enable = mkEnableOption "mosquitto";
  };

  config = mkIf cfg.enable {
    sops.secrets."service/mosquitto/passwords" = {owner = config.users.users.mosquitto.name;};

    services.mosquitto = {
      enable = true;
      passwordFile = config.sops.secrets."service/mosquitto/passwords".path;

      listeners = {
        port = 1883;
      };
    };
  };
}
