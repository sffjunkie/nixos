{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.editor.nixvim;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  config = mkIf cfg.enable {
    programs.nixvim = {
      # autoCmd = [
      #   {
      #     event = "LspAttach";
      #     group = "vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true })";
      #     callback = ''
      #     '';
      #   }
      # ];

      plugins = {
        lsp = {
          enable = true;
          keymaps = {
            diagnostic = {
              "[d" = "vim.diagnostic.goto_prev";
              "]d" = "vim.diagnostic.goto_next";
            };
          };

          servers = {
            bashls.enable = true;
            jsonls.enable = true;
            lua-ls.enable = true;
            ruff = {
              enable = true;
            };
            yamlls.enable = true;
          };
        };
      };
    };
  };
}
