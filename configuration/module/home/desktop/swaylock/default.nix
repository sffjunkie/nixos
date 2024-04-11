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
    programs.swaylock.enable = true;
    services.swayidle.enable = true;
  };
}
