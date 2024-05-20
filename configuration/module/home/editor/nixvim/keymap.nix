{
  config = {
    programs.nixvim = {
      keymaps = [
        {
          action = "<cmd>nohlsearch<CR>";
          key = "<Esc>";
          mode = "n";
        }
        {
          action = "<C-w><C-h>";
          key = "<C-h>";
          mode = "n";
        }
        {
          action = "<C-w><C-h>";
          key = "<C-left>";
          mode = "n";
        }
        {
          action = "<C-w><C-j>";
          key = "<C-j>";
          mode = "n";
        }
        {
          action = "<C-w><C-k>";
          key = "<C-k>";
          mode = "n";
        }
        {
          action = "<C-w><C-l>";
          key = "<C-right>";
          mode = "n";
        }
        {
          action = ":NvimTreeFindFileToggle<CR>";
          key = "<leader>e";
          mode = "n";
          options = {
            desc = "Toggle file tree";
          };
        }
        {
          action = ":MarkdownPreviewToggle<CR>";
          key = "<leader>mp";
          mode = "n";
          options = {
            desc = "Toggle markdown preview";
          };
        }
        {
          action = ":CommentToggle<CR>";
          key = "<leader>/";
          mode = ["n" "v"];
          options = {
            desc = "Toggle comments";
          };
        }
      ];
    };
  };
}
