{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.just;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.just = {
    enable = mkEnableOption "just";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.just
    ];
  };
}
