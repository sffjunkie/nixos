{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.cli.nushell;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.cli.nushell = {
    enable = mkEnableOption "nushell";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.nushell
    ];
  };
}
