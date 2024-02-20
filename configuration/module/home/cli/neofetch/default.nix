{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.neofetch;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.neofetch = {
    enable = mkEnableOption "neofetch";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.neofetch
    ];
  };
}
