{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.pavucontrol;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.pavucontrol = {
    enable = mkEnableOption "pavucontrol";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.pavucontrol
    ];
  };
}
