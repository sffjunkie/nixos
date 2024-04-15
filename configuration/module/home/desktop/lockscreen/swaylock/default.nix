{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.desktop.swaylock;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.desktop.swaylock = {
    enable = mkEnableOption "swaylock/swayidle lockscreen";
  };

  config = mkIf cfg.enable {
    programs.swaylock = {
      enable = true;
      # style set by stylix
    };

    services.swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 180;
          command = "${pkgs.swaylock}/bin/swaylock -fF";
        }
        {
          timeout = 300;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.swaylock}/bin/swaylock -fF";
        }
        {
          event = "lock";
          command = "${pkgs.swaylock}/bin/swaylock -fF";
        }
      ];
    };
  };
}
