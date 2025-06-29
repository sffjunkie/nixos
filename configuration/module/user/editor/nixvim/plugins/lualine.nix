{
  config = {
    programs.nixvim = {
      plugins.lualine = {
        enable = true;
        settings.options.disabled_filetypes.statusline = [ "NvimTree" ];
      };
    };
  };
}
