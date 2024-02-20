{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.darktable;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.darktable = {
    enable = mkEnableOption "darktable";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.darktable
    ];
  };
}
