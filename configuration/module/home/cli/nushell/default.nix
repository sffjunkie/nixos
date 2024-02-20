{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.nushell;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.nushell = {
    enable = mkEnableOption "nushell";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.nushell
    ];
  };
}
