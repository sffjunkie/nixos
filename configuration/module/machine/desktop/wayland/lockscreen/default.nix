{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.lockscreen;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.lockscreen = {
    enable = mkEnableOption "wayland lockscreen";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.swaylock
      pkgs.swayidle
    ];

    security.pam.services.swaylock.text = ''
      auth include login
    '';
  };
}
