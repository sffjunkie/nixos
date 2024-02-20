{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.neovim;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.neovim = {
    enable = mkEnableOption "neovim";
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      withPython3 = true;
      plugins = with pkgs.vimPlugins; [
        {
          plugin = nvim-treesitter.withAllGrammars; # Syntax Highlighting
          type = "lua";
          config = ''
            require('nvim-treesitter.configs').setup {
              highlight = { enable = true}
            }
          '';
        }
        {
          plugin = telescope-nvim;
          type = "lua";
          config = ''
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
            require("telescope").setup{}
          '';
        }
        {
          plugin = nordic-nvim;
          type = "lua";
        }
        {
          plugin = vim-isort;
          type = "lua";
        }
        {
          plugin = vim-airline;
        }
        {
          plugin = vim-airline-themes;
          config = ''
            let g:airline_theme = 'base16_nord'
            let g:airline_powerline_fonts = 1

            let g:airline#extensions#tabline#enabled = 1
            let g:airline#extensions#tabline#show_close_button = 0
            let g:airline#extensions#tabline#tabs_label = '''
            let g:airline#extensions#tabline#buffers_label = '''
            let g:airline#extensions#tabline#fnamemod = ':t'
            let g:airline#extensions#tabline#show_tab_count = 1
            let g:airline#extensions#tabline#show_buffers = 0
            let g:airline#extensions#tabline#tab_min_count = 1
            let g:airline#extensions#tabline#show_splits = 0
            let g:airline#extensions#tabline#show_tab_nr = 0
            let g:airline#extensions#tabline#show_tab_type = 0
          '';
        }
        {
          plugin = nvim-tree-lua;
          type = "lua";
          config = ''
            require("nvim-tree").setup()
          '';
        }
        {
          plugin = nvim-web-devicons;
        }
      ];
      extraConfig = ''
        let g:loaded_netrwPlugin = 1
        let g:loaded_netrw = 1

        let mapleader=" "
        set number
        set relativenumber
        set expandtab
        set mouse=a
        set clipboard+=unnamedplus
        set cursorlineopt=number

        if has("autocmd")
          au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
        endif

        au FileType css setlocal tabstop=2 shiftwidth=2
        au FileType haskell setlocal tabstop=2 shiftwidth=2
        au FileType nix setlocal tabstop=2 shiftwidth=2
        au FileType json setlocal tabstop=2 shiftwidth=2
        au FileType cpp setlocal tabstop=2 shiftwidth=2
        au FileType c setlocal tabstop=2 shiftwidth=2
        au FileType java setlocal tabstop=2 shiftwidth=2
        au FileType python setlocal tabstop=4 shiftwidth=4
        au FileType markdown setlocal spell
        au FileType markdown setlocal tabstop=2 shiftwidth=2
        au CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})
        au BufRead,BufNewFile *.wiki setlocal textwidth=80 spell tabstop=2 shiftwidth=2
        au FileType xml setlocal tabstop=2 shiftwidth=2
        au FileType help wincmd L
        au FileType gitcommit setlocal spell
      '';

      extraPackages = with pkgs; [
        ripgrep # Requirement for telescope
      ];
    };
  };
}
