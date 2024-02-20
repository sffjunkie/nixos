{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.jc;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.jc = {
    enable = mkEnableOption "jc";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.jc
    ];
  };
}
