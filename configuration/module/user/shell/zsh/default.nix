{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.looniversity.shell.zsh;
  inherit (lib) mkDefault mkEnableOption mkIf mkOption types;
in
{
  options.looniversity.shell.zsh = {
    enable = mkEnableOption "zsh";

    initExtra = mkOption {
      default = "";
      type = types.lines;
      description = "Extra commands that should be added to {file}`.zshrc`.";
    };
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initExtra = config.looniversity.shell.zsh.initExtra;
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
