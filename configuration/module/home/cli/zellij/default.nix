{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.zellij;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.zellij = {
    enable = mkEnableOption "zellij";
  };

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        keybinds = {
          unbind = ["Ctrl q"];
        };

        theme = "nord";
        themes = {
          nord = {
            fg = "#D8DEE9";
            bg = "#2E3440";
            black = "#3B4252";
            red = "#BF616A";
            green = "#A3BE8C";
            yellow = "#EBCB8B";
            blue = "#81A1C1";
            magenta = "#B48EAD";
            cyan = "#88C0D0";
            white = "#E5E9F0";
            orange = "#D08770";
          };
        };
      };
    };
  };
}
