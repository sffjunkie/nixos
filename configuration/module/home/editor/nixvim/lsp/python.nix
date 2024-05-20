{
  config = {
    programs.nixvim = {
      plugins = {
        lsp = {
          servers = {
            # https://github.com/astral-sh/ruff-lsp#example-neovim
            pyright = {
              enable = true;
              extraOptions = {
                pyright = {
                  # Using Ruff's import organizer
                  disableOrganizeImports = true;
                };
                python = {
                  analysis = {
                    # Ignore all files for analysis to exclusively use Ruff for linting
                    ignore = ["*"];
                  };
                };
              };
            };

            ruff-lsp = {
              enable = true;
              onAttach.function = ''
                if client.name == 'ruff_lsp' then
                  -- Disable hover in favor of Pyright
                  client.server_capabilities.hoverProvider = false
                end
              '';
            };
          };
        };
      };
    };
  };
}
