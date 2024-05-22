{pkgs, ...}: {
  config = {
    programs.nixvim = {
      plugins = {
        dap = {
          extensions.dap-python = {
            adapterPythonPath = pkgs.python3;
          };
        };
      };
    };
  };
}
