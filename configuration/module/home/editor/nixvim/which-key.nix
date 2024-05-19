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
        which-key = {
          enable = true;
          plugins.spelling.enabled = true;
        };
      };
    };
  };
}
