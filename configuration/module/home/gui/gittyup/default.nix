{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.gittyup;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.gittyup = {
    enable = mkEnableOption "gittyup";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.gittyup
    ];
  };
}
