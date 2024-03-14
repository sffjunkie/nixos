{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.theme.nordic;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.theme.nordic = {
    enable = mkEnableOption "nordic theme";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.nordic];
  };
}
