{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.lazydocker;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.lazydocker = {
    enable = mkEnableOption "lazydocker";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.lazydocker
    ];
  };
}
