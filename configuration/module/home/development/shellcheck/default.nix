{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.shellcheck;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.shellcheck = {
    enable = mkEnableOption "shellcheck";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.shellcheck
    ];
  };
}
