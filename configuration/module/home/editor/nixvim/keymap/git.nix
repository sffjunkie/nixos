{
  config = {
    programs.nixvim = {
      keymaps = [
        {
          action = ":Neogit<CR>";
          key = "<leader>gg";
          mode = "n";
        }
        {
          action = ":Neogit log h<CR>";
          key = "<leader>gl";
          mode = "n";
          options = {
            desc = "Git log";
          };
        }
        {
          action = ":Neogit Pull<CR>";
          key = "<leader>gp";
          mode = "n";
          options = {
            desc = "Git pull";
          };
        }
        {
          action = ":Neogit Push<CR>";
          key = "<leader>gP";
          mode = "n";
          options = {
            desc = "Git push";
          };
        }
      ];
    };
  };
}
