{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.ripgrep;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.ripgrep = {
    enable = mkEnableOption "ripgrep";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.ripgrep
    ];
  };
}
