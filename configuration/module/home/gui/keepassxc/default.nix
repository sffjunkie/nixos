{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.keepassxc;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.keepassxc = {
    enable = mkEnableOption "keepassxc";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.keepassxc
    ];
  };
}
