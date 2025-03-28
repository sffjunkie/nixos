{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.looniversity.keyboard.input-remapperr;

  inherit (lib) mkEnableOption mkIf;
in
{
  options.looniversity.keyboard.input-remapper = {
    enable = mkEnableOption "input-remapper";
  };

  config = mkIf cfg.enable {
    services.input-remapper = {
      enabled = true;
    };
  };
}
