{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.htmldoc;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.htmldoc = {
    enable = mkEnableOption "htmldoc";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.htmldoc
    ];
  };
}
