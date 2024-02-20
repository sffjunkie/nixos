{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.bat;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.bat = {
    enable = mkEnableOption "bat";
  };

  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [batdiff batman batgrep];
      config = {
        theme = "Nord";
      };
    };

    programs.zsh.shellAliases = {
      man = "batman";
    };

    home.sessionVariables = {
      PAGER = "bat";
    };
  };
}
