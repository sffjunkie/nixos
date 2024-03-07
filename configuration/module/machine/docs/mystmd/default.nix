{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.mystmd;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.mystmd = {
    enable = mkEnableOption "mystmd";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.mystmd
    ];

    looniversity = {
      nodejs.enable = true;
    };
  };
}
