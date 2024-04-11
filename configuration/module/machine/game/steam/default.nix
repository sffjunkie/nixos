{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.game.steam;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.game.steam = {
    enable = mkEnableOption "steam";
  };

  config = mkIf cfg.enable {
    programs.steam.enable = true;
    hardware.opengl.driSupport32Bit = true;

    environment.systemPackages = with pkgs; [
      protonup-ng
      steam-run-native
    ];
  };
}
