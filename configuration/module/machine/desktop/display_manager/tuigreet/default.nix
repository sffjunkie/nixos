{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.display_manager.tuigreet;

  inherit (lib) mkEnableOption mkIf mkOption types;
in {
  options.looniversity.display_manager.tuigreet = {
    enable = mkEnableOption "tuigreet";

    script = mkOption {
      type = types.string;
      default = "";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = config.looniversity.display_manager.greetd.enable;
        message = "greetd service must be enabled";
      }
      {
        assertion = config.looniversity.display_manager.tuigreet.script != "";
        message = "looniversity.display_manager.tuigreet.script must be set";
      }
    ];

    environment.systemPackages = [
      pkgs.greetd.tuigreet
    ];

    services.greetd.settings.default_session.command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --cmd ${config.looniversity.display_manager.tuigreet.script}";
  };
}
