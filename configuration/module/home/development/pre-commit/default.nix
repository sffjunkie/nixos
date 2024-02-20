{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.preCommit;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.preCommit = {
    enable = mkEnableOption "pre-commit";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.pre-commit
    ];
  };
}
