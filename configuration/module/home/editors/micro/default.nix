{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.micro;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.micro = {
    enable = mkEnableOption "micro";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.micro
    ];
    xdg.configFile."micro/bindings.json" = {
      force = true;
      text = ''
        {
          "Alt-CtrlQ": "ForceQuit"
        }
      '';
    };
  };
}
