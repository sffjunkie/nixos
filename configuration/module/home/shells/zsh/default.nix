{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.zsh;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.zsh = {
    enable = mkEnableOption "zsh";
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
      enableCompletion = true;
      enableAutosuggestions = true;
      shellAliases = {
        nano = "nano -l --guidestripe=72";
        free = "free -h";
        df = "df -h";
      };
      syntaxHighlighting.enable = true;
      initExtra = ''
        bindkey '^f' autosuggest-accept
      '';
    };

    programs.zsh.antidote = {
      enable = true;
      plugins = [
        "ohmyzsh/ohmyzsh path:lib"
        "ohmyzsh/ohmyzsh path:plugins/git"
        "ohmyzsh/ohmyzsh path:plugins/sudo"
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-completions"
        "zsh-users/zsh-syntax-highlighting"
      ];
    };
  };
}
