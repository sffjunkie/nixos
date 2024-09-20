{
  config = {
    programs.nixvim = {
      plugins.lualine = {
        enable = true;
        disabledFiletypes.statusline = ["NvimTree"];
      };
    };
  };
}
