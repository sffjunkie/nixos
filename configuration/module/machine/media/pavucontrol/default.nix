{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.pavucontrol;

  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.pavucontrol = {
    enable = mkEnableOption "pavucontrol";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.pavucontrol
    ];
  };
}
