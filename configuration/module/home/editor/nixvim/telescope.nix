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
        telescope = {
          enable = true;
          extensions = {
            file-browser.enable = true;
            fzf-native.enable = true;
          };
        };
      };

      keymaps = {
        n = {
        };
      };
    };
  };
}
