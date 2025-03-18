{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.looniversity.script.displays;

  displays-script = pkgs.writers.writePython3 "displays" { } (lib.readFile ./displays.py);

  inherit (lib) mkDefault mkEnableOption mkIf;
in
{
  options.looniversity.script.displays = {
    enable = mkEnableOption "displays script";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      displays-script
    ];
  };
}
