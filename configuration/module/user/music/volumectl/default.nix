{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;

  cfg = config.looniversity.audio.volumectl;

  volume_controller = "pulsemixer";
  volume_step = 10;

  volumectl = pkgs.writeScriptBin "volumectl" ''
    #!${pkgs.runtimeShell}
    case "$1" in
        up)
            ${volume_controller} --change-volume +"${toString volume_step}"
            ;;
        down)
            ${volume_controller} --change-volume -"${toString volume_step}"
            ;;
        toggle)
            ${volume_controller} --toggle-mute
            ;;
        mute)
            ${volume_controller} --mute
            ;;
        app)
            ${pkgs.pavucontrol}/bin/pavucontrol
            ;;
    esac

    exit 0
  '';
in
{
  options.looniversity.audio.volumectl = {
    enable = mkEnableOption "volumectl";
  };

  config = mkIf cfg.enable {
    home.packages = [ volumectl ];
  };
}
