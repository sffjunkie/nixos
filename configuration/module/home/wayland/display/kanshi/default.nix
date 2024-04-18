{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.wayland.display.kanshi;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.wayland.display.kanshi = {
    enable = mkEnableOption "kanshi display management";
  };

  config = mkIf cfg.enable {
    services.kanshi = {
      enable = true;
      profiles = {
        undocked = {
          outputs = [
            {
              criteria = "HDMI-A-1";
            }
          ];
        };
      };
    };
  };
}
