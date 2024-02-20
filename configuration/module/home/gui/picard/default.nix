{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.picard;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.picard = {
    enable = mkEnableOption "picard";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.picard
    ];
  };
}
