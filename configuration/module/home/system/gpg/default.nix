{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.gpg;
  inherit (lib) mkDefault mkEnableOption mkIf mkOption;
in {
  options.looniversity.gpg = {
    enable = mkEnableOption "gpg";
    pinentryFlavor = mkOption {
      type = lib.types.str;
      default = "gtk2";
    };
  };

  config = mkIf cfg.enable {
    programs.gpg = {
      enable = true;
      homedir = "${config.home.homeDirectory}/.local/share/gnupg";
    };

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      defaultCacheTtl = 1800;
      pinentryFlavor = cfg.pinentryFlavor;
    };
  };
}
