{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.script.rofi-power;

  rofi-power-script = pkgs.writeScriptBin "rofi-power" ''
    #!${lib.getExe pkgs.bash}
    swapon --show | grep "dev" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
      hibernate_choice="/hibernate"
    else
      hibernate_choice=""
    fi

    choices="suspend/lockscreen''${hibernate_choice}/reboot/shutdown"
    ${lib.getExe pkgs.rofi} \
      -theme-str '@import "looniversity"' \
      -show power-menu \
      -modi "power-menu:rofi-power-menu --choices=''${choices}"
  '';
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.script.rofi-power = {
    enable = mkEnableOption "rofi-power script";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.rofi-power-menu
      rofi-power-script
    ];
  };
}
