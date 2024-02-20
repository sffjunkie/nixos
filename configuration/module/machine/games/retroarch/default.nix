{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.retroarch;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.retroarch = {
    enable = mkEnableOption "retroarch";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      (pkgs.retroarch.override {
        cores = with pkgs.libretro; [
          fuse
          mame2003-plus
          # mupen64plus
        ];
      })
    ];
  };
}
