# ports: 27017 - 27020
{
  config,
  lib,
  pkgs,
  sops,
  ...
}: let
  cfg = config.looniversity.service.mongodb;

  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.service.mongodb = {
    enable = mkEnableOption "mongodb";
  };

  config = mkIf cfg.enable {
    services.mongodb = {
      enable = true;
      # Use 5.x as 6 build broken https://github.com/NixOS/nixpkgs/issues/244336
      package = pkgs.mongodb-5_0;
      # bind_ip = "0.0.0.0";
    };
  };
}
