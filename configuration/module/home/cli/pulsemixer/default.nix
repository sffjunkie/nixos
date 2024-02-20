{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.pulsemixer;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.pulsemixer = {
    enable = mkEnableOption "pulsemixer";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.pulsemixer
    ];
  };
}
