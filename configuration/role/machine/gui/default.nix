{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.role.xserver;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.role.gui = {
    enable = mkEnableOption "gui role";
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
        gnome.enable = false;
        qtile.enable = true;
      };
    };
  };
}
