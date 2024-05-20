{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.editor.nixvim;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.editor.nixvim = {
    enable = mkEnableOption "nixvim";
  };

  imports = [
    ./alpha.nix
    ./comment.nix
    ./fugitive.nix
    ./gitsigns.nix
    ./keymap.nix
    ./lualine.nix
    ./markdown.nix
    ./neogit.nix
    ./tabby.nix
    ./tree.nix
    ./telescope.nix
    ./which-key.nix

    ./lsp
  ];

  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;

      extraPackages = [
        pkgs.vimPlugins.nvim-web-devicons
      ];

      globals = {
        mapleader = " ";
        maplocalleader = " ";
        have_nerd_font = true;
      };

      opts = {
        breakindent = true;
        clipboard = "unnamedplus";
        cursorline = true;
        ignorecase = true;
        inccommand = "split";
        list = true;
        listchars = {
          tab = "» ";
          trail = "·";
          nbsp = "␣";
        };
        mouse = "a";
        number = true;
        scrolloff = 10;
        showmode = false;
        showtabline = 2;
        signcolumn = "yes";
        smartcase = true;
        splitbelow = true;
        splitright = true;
        timeoutlen = 300;
        undofile = true;
        updatetime = 250;
      };

      plugins = {
        direnv.enable = true;
        fugitive.enable = true;
        lazy.enable = true;
        sleuth.enable = true;
        treesitter.enable = true;
      };
    };
  };
}
