{
  config,
  lib,
  ...
}: let
  cfg = config.looniversity.service.node-red;

  inherit (lib) mkEnableOption mkIf mkOption types;
in {
  options.looniversity.service.node-red = {
    enable = mkEnableOption "node-red";

    nodes = mkOption {
      type = types.attrsOf types.str;
      default = {};
    }

    nodes = mkOption {
      type = types.attrsOf types.str;
      default = {};
    }
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      nodejs
    ];

    environment.shellAliases = {
      node-red-pm = "npm --prefix=${config.services.node-red.userDir} --save";
    };

    services.node-red = {
      enable = true;
      openFirewall = true;
    };

    # system.activationScripts.installNodes = ''
    #   npm --prefix=${config.services.node-red.userDir} --save
    # '';
  };
}
