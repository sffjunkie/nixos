{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.lsd;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.lsd = {
    enable = mkEnableOption "lsd";
  };

  config = mkIf cfg.enable {
    programs.lsd = {
      enable = true;
      enableAliases = true;
    };
  };
}
