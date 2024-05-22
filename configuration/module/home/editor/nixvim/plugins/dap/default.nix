{
  imports = [
    ./python
  ];

  config = {
    programs.nixvim = {
      plugins = {
        dap = {
        };
      };
    };
  };
}
