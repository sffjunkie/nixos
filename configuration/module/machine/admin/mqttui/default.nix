{
  config,
  lib,
  pkgs,
  sops,
  ...
}: let
  cfg = config.looniversity.admin.mqtt;

  mqttHost = lib.network.serviceHandlerHostName "mosquitto";

  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.mqtt = {
    enable = mkEnableOption "mqtt";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.mqttui
    ];

    environment.shellAliases = {
      mqttui = "mqttui --broker \"mqtt://${mqttHost}";
    };
  };
}
