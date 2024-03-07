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
    environemnt.systemPackages = [
      pkgs.mystmd
    ];
  };
}
