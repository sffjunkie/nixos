{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.zellij;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.zellij = {
    enable = mkEnableOption "zellij";
  };

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        keybinds = {
          unbind = ["Ctrl q"];
        };
      };
    };
  };
}
