{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.greetd;

  inherit (lib) mkEnableOption mkIf mkOption types;
in {
  options.looniversity.greetd = {
    enable = mkEnableOption "greetd";

    script = mkOption {
      type = types.string;
      default = "";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = config.looniversity.greetd.script != "";
        message = "looniversity.greetd.script must be set";
      }
    ];

    services.greetd = {
      enable = true;
      settings.default_session.command = config.looniversity.greetd.script;
    };
  };
}
