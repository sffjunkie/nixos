{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.pywal;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.pywal = {
    enable = mkEnableOption "pywal";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.pywal
    ];
  };
}
