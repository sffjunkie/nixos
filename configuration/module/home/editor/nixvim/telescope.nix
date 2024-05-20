{
  config = {
    programs.nixvim = {
      plugins = {
        telescope = {
          enable = true;
          extensions = {
            file-browser.enable = true;
            fzf-native.enable = true;
          };

          keymaps = {
            "<leader>sf" = {
              action = "find_files";
              options = {
                desc = "Search for files";
              };
            };
            "<leader>sg" = {
              action = "live_grep";
              options = {
                desc = "Search with grep";
              };
            };

            "<leader>sb" = {
              action = "buffers";
              options = {
                desc = "Search buffers";
              };
            };
            "<leader>sh" = {
              action = "help_tags";
              options = {
                desc = "Search help";
              };
            };
          };
        };
      };
    };
  };
}
