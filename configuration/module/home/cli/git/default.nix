{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.git;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.git = {
    enable = mkEnableOption "git";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "Simon Kennedy";
      userEmail = "sffjunkie+code@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";

        credential.helper = "${
          pkgs.git.override {withLibsecret = true;}
        }/bin/git-credential-libsecret";
        http.postBuffer = "157286400";
      };
    };

    programs.zsh.shellAliases = mkIf config.looniversity.zsh.enable {
      gvl = "git config --list --show-origin";
    };
  };
}
