{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.pass;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.pass = {
    enable = mkEnableOption "pass";
  };

  config = mkIf cfg.enable {
    programs.password-store = {
      enable = true;
    };
  };
}
