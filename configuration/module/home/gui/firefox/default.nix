{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.firefox;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.firefox = {
    enable = mkEnableOption "firefox";
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
    };
  };
}
