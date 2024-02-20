{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.obsidian;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.obsidian = {
    enable = mkEnableOption "obsidian";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.obsidian
    ];
  };
}
