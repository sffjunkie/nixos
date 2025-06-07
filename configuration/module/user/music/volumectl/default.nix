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
      *)
        if [ -t 0 ] ; then
            ${pkgs.pulsemixer}/bin/pulsemixer
        else
            ${pkgs.pavucontrol}/bin/pavucontrol -t 3
        fi
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
