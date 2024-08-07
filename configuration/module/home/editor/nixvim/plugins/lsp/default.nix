{
  imports = [
    ./python.nix
  ];

  config = {
    programs.nixvim = {
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
            nil-ls.enable = true;
            yamlls.enable = true;
          };
        };
      };
    };
  };
}
