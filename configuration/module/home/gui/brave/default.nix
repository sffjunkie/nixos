{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.brave;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.brave = {
    enable = mkEnableOption "brave";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.brave
    ];
  };
}
