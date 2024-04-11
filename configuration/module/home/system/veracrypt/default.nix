{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.system.veracrypt;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.system.veracrypt = {
    enable = mkEnableOption "veracrypt";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.veracrypt
    ];
  };
}
