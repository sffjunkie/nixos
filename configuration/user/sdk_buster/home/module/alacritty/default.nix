{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.alacritty;
  inherit (lib) mkIf mkForce;
in {
  config = mkIf cfg.enable {
    programs.alacritty.settings.font.size = mkForce 9;
  };
}
