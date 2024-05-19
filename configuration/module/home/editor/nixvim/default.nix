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

      opts = {
        number = true;
        mouse = "a";
        showmode = false;
        clipboard = "unnamedplus";
        breakindent = true;
        undofile = true;
        ignorecase = true;
        smartcase = true;
        signcolumn = "yes";
        updatetime = 250;
        timeoutlen = 300;
        splitright = true;
        splitbelow = true;
        list = true;
        listchars = {
          tab = "» ";
          trail = "·";
          nbsp = "␣";
        };
        inccommand = "split";
        cursorline = true;
        scrolloff = 10;
      };

      plugins = {
        lazy.enable = true;
        treesitter.enable = true;
      };
    };
  };
}
