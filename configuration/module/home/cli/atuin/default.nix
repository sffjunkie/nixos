{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.atuin;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.atuin = {
    enable = mkEnableOption "atuin";
  };

  config = mkIf cfg.enable {
    programs.atuin = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      flags = [
        "--disable-up-arrow"
      ];
    };
    programs.zsh.initExtra = ''
      bindkey '^[[1;5A' _atuin_search_widget
    '';
  };
}
