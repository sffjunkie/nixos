{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.editor.neovim;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.editor.neovim = {
    enable = mkEnableOption "neovim";
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;

      globals = {
        mapleader = " ";
        maplocalleader = " ";
        have_nerd_font = true;
      };


      plugins = {
        lazy.enable = true;
        treesitter.enable = true;
      };
    };
  };
}
