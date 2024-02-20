{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.direnv;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.direnv = {
    enable = mkEnableOption "direnv";
  };

  config = mkIf cfg.enable {
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;
  };
}
