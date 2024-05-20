{
  imports = [
    ./python.nix
  ];

  config = {
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
              "[d" = "goto_prev";
              "]d" = "goto_next";
            };
          };

          servers = {
            bashls.enable = true;
            jsonls.enable = true;
            lua-ls.enable = true;
            nil_ls.enable = true;
            yamlls.enable = true;
          };
        };
      };
    };
  };
}
