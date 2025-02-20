{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.looniversity.desktop.mako;
  inherit (lib) mkIf mkEnableOption;
in
{
  options.looniversity.desktop.mako = {
    enable = mkEnableOption "mako user service";
  };

  config = mkIf cfg.enable {
    services.mako = {
      enable = true;
      anchor = "top-right";
    };
  };
}
