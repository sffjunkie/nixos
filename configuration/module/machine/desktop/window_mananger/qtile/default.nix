{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.window_manager.qtile;

  startScript = pkgs.writeScript "startqtile" ''
    #! ${pkgs.bash}/bin/bash

    # first import environment variables from the login manager
    export XDG_DATA_DIRS=/run/current-system/sw/share/gsettings-schemas:$XDG_DATA_DIRS
    systemctl --user unset-environment DISPLAY WAYLAND_DISPLAY

    ${pkgs.zsh}/bin/zsh --login -c "systemctl --user import-environment XDG_DATA_DIRS PATH"

    # then start the service
    exec systemctl --user --wait start qtile.service
  '';

  inherit (lib) mkEnableOption mkIf mkOption;
in {
  options.looniversity.window_manager.qtile = {
    enable = mkEnableOption "qtile";
  };

  config = mkIf cfg.enable {
    services.xserver.windowManager.qtile = {
      enable = true;
      backend = "wayland";
      extraPackages = python3Packages:
        with python3Packages; [
          qtile-extras

          # Add packages required by the qtile config
          pyyaml
          requests
        ];
    };

    looniversity.display_manager.tuigreet.script = startScript;

    environment.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "qtile";
      SDL_VIDEODRIVER = "wayland";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };

    environment.systemPackages = [
      pkgs.qtile
    ];

    systemd.user.targets.qtile-session = {
      description = "Qtile compositor session";
      documentation = ["man:systemd.special(7)"];
      bindsTo = ["graphical-session.target"];
      wants = ["graphical-session-pre.target"];
      after = ["graphical-session-pre.target"];
    };

    systemd.user.services.qtile = let
      pyEnv = pkgs.python3.withPackages (_p: [
        pkgs.python3.pkgs.qtile
        pkgs.python3.pkgs.iwlib
      ]);
    in {
      description = "Qtile - Wayland window manager";
      documentation = ["man:qtile(5)"];
      bindsTo = ["graphical-session.target"];
      wants = ["graphical-session-pre.target"];
      after = ["graphical-session-pre.target"];
      # We explicitly unset PATH here, as we want it to be set by
      # systemctl --user import-environment in startqtile
      environment.PATH = lib.mkForce null;
      environment.PYTHONPATH = lib.mkForce null;
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pyEnv}/bin/qtile start -b wayland";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}