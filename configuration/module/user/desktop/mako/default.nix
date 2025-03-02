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
      anchor = "top-right";

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
