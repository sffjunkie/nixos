{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.scripts.paths;
  inherit (lib) mkDefault mkEnableOption mkIf;

  paths = pkgs.writeScriptBin "paths" ''
    echo $PATH | tr : '\n'
  '';
in {
  options.looniversity.scripts.paths = {
    enable = mkEnableOption "paths";
  };

  config = mkIf cfg.enable {
    home.packages = [paths];
  };
}
