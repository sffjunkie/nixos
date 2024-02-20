{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.zathura;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.zathura = {
    enable = mkEnableOption "zathura";
  };

  config = mkIf cfg.enable {
    programs.zathura.enable = true;
  };
}
