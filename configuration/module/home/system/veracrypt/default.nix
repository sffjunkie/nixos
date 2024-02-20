{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.veracrypt;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.veracrypt = {
    enable = mkEnableOption "veracrypt";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.veracrypt
    ];
  };
}
