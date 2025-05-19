{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.looniversity.desktop.mako;
  inherit (lib) mkIf mkEnableOption;
in
{
  options.looniversity.desktop.mako = {
    enable = mkEnableOption "mako user service";
  };

  config = mkIf cfg.enable {
    services.mako = {
      enable = true;
      settings = {
        anchor = "top-right";
        outer-margin = "45,8";

        "app-name=music-notify" = {
          width = 600;
          max-icon-size = 256;
          anchor = "bottom-right";
          outer-margin = "60,8";
          format = "%b";
        };
      };
    };

    systemd.user.services.mako = {
      Install.WantedBy = [ "graphical-session.target" ];

      Unit = {
        Description = "Lightweight Wayland notification daemon.";
        Documentation = "man:mako(1)";
        PartOf = "graphical-session.target";
        After = "graphical-session.target";
      };

      Service = {
        Type = "dbus";
        BusName = "org.freedesktop.Notifications";
        # ExecCondition = "${lib.getExe pkgs.bash} -c '[ -n \"$WAYLAND_DISPLAY\" ]'";
        ExecStart = "${lib.getExe pkgs.mako}";
        ExecReload = "${pkgs.mako}/bin/makoctl reload";
      };
    };
  };
}
