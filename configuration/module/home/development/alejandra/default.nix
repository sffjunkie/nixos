{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.alejandra;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.alejandra = {
    enable = mkEnableOption "alejandra";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.alejandra
    ];
  };
}
