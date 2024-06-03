{
  config = {
    programs.nixvim = {
      keymaps = {
        diagnostic = {
          "[d" = "goto_prev";
          "]d" = "goto_next";
        };
      };
    };
  };
}
