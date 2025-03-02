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
      extraConfig = ''
        width=384
        max-icon-size=128
        outer-margin=45,5
      '';
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
