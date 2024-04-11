{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.system.pavucontrol;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.system.pavucontrol = {
    enable = mkEnableOption "pavucontrol";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.pavucontrol
    ];
  };
}
