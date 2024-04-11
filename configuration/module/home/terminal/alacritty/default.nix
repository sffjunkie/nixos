{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.terminal.alacritty;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.terminal.alacritty = {
    enable = mkEnableOption "alacritty";
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          padding = {
            x = 4;
            y = 6;
          };
          dynamic_padding = true;
        };

        scrolling = {
          history = 20000;
        };

        hints = {
          enabled = [
            {
              regex = "(mailto:|gemini:|gopher:|https:|http:|news:|file:|git:|ssh:|ftp:)[^\\u0000-\\u001F\\u007F-\\u009F<>\"\\\\s{-}\\\\^⟨⟩`]+";
              hyperlinks = true;
              command = "linkhandler";
              post_processing = true;
              mouse = {
                enabled = true;
                mods = "Control";
              };
            }
          ];
        };
      };
    };

    home.sessionVariables = {
      TERMINAL = "alacritty";
    };
  };
}
