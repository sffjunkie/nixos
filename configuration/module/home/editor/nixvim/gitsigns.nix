{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.editor.nixvim;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  config = mkIf cfg.enable {
    programs.nixvim = {
      plugins = {
        gitsigns = {
          enable = true;
          settings = {
            signs = {
              add = {text = "+";};
              change = {text = "~";};
              delete = {text = "_";};
              topdelete = {text = "‾";};
              changedelete = {text = "~";};
            };
          };
        };
      };
    };
  };
}
