{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.music.control;
  inherit (lib) mkEnableOption mkIf;

  notify_send = "${pkgs.libnotify}/bin/notify-send";
  musicctl = pkgs.writeScriptBin "musicctl" ''
    #!${pkgs.runtimeShell}
    case "$1" in
        next)
            ${pkgs.mpc-cli}/bin/mpc next && ${notify_send} --hint=int:transient:1 -t 2000 "MPD" "$(${pkgs.mpc-cli}/bin/mpc current)"
                ;;
        previous)
            ${pkgs.mpc-cli}/bin/mpc previous && ${notify_send} --hint=int:transient:1 -t 2000 "MPD" "$(${pkgs.mpc-cli}/bin/mpc current)"
                ;;
        toggle)
            ${pkgs.mpc-cli}/bin/mpc toggle && ${notify_send} --hint=int:transient:1 -t 2000 "MPD" "$(${pkgs.mpc-cli}/bin/mpc | sed -n 2p)" && ${notify_send} --hint=int:transient:1 -t 2000 "MPD" "$(${pkgs.mpc-cli}/bin/mpc current)"
                ;;
        stop)
            ${pkgs.mpc-cli}/bin/mpc stop && ${notify_send} --hint=int:transient:1 -t 2000 "MPD" "stopped"
            ;;

        mixer)
            ${pkgs.pulsemixer}/bin/pulsemixer
            ;;

        *)
            ${pkgs.mpc-cli}/bin/mpc status
    esac

    exit 0
  '';
in {
  options.looniversity.music.control = {
    enable = mkEnableOption "music_control";
  };

  config = mkIf cfg.enable {
    home.packages = [
      musicctl
    ];
  };
}
