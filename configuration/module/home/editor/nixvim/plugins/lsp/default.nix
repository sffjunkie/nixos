{
  imports = [
    ./python.nix
  ];

  config = {
    programs.nixvim = {
      plugins = {
        lsp = {
          enable = true;

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
