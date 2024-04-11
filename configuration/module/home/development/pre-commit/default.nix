{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.development.preCommit;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.development.preCommit = {
    enable = mkEnableOption "pre-commit";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.pre-commit
    ];
  };
}
