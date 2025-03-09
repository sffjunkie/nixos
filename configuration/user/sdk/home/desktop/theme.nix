{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  config = {
    xdg.configFile."desktop/theme.yaml".text = lib.generators.toYAML { } {
      logo = ""; # Nixos logo

      font = {
        text = {
          family = "JetBrainsMono Nerd Font";
          size = 16;
        };
        icon = {
          family = "Material Design Icons";
          size = 22;
        };
        weather = {
          family = "Hack Nerd Font";
          size = 22;
        };
        logo = {
          family = "Hack Nerd Font";
          size = 22;
        };
      };

      bars = {
        top = {
          height = 40;
          margin = [
            8
            8
            4
            8
          ];
          opacity = 0.8;
        };
        bottom = {
          height = 40;
          margin = [
            4
            8
            8
            8
          ];
          opacity = 0.8;
        };
      };

      base16_scheme_name = "catppuccin-macchiato";
      base16_scheme_dir = "${pkgs.base16-schemes}/share/themes";

      foreground_dark = "base00";
      foreground_light = "base04";
    };
  };
}
