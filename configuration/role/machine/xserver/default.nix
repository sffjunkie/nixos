{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.role.xserver;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.role.xserver = {
    enable = mkEnableOption "xserver role";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;

      # Configure keymap
      xkb.layout = "us";
      xkb.variant = "";
      xkb.options = "altwin:swap_lalt_lwin";
    };

    looniversity = {
      desktop = {
        gnome.enable = true;
        qtile.enable = false;
      };
    };
  };
}
