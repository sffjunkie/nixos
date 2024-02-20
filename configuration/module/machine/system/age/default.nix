{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.age;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.age = {
    enable = mkEnableOption "age";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.age
    ];
  };
}
