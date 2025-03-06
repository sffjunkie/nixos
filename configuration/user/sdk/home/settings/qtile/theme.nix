{
  config,
  lib,
  pkgs,
  ...
}:
let
  defaultFontSize = 12;
  defaultTextFont = {
    family = "Hack Nerd Font Mono";
    size = defaultFontSize;
  };

  defaultIconFont = {
    family = "Hack Nerd Font Mono";
    size = defaultFontSize;
  };

  defaultWeatherFont = {
    family = "Hack Nerd Font Mono";
    size = defaultFontSize;
  };

  defaultLogoFont = {
    family = "Hack Nerd Font Mono";
    size = defaultFontSize;
  };

  defaultBarHeight = 22;
  defaultBarOpacity = 0.8;

  defaultBase16Colors = {
    base00 = "f9f5d7";
    base01 = "ebdbb2";
    base02 = "d5c4a1";
    base03 = "bdae93";
    base04 = "665c54";
    base05 = "504945";
    base06 = "3c3836";
    base07 = "282828";
    base08 = "9d0006";
    base09 = "af3a03";
    base0A = "b57614";
    base0B = "79740e";
    base0C = "427b58";
    base0D = "076678";
    base0E = "8f3f71";
    base0F = "d65d0e";
  };

  defaultNamedColors = {
    window_border = defaultBase16Colors.base06;
    panel_fg = defaultBase16Colors.base04;
    panel_bg = defaultBase16Colors.base01;
    group_current_fg = defaultBase16Colors.base05;
    group_current_bg = defaultBase16Colors.base03;
    group_active_fg = defaultBase16Colors.base07;
    group_active_bg = defaultBase16Colors.base04;
    group_inactive_fg = defaultBase16Colors.base07;
    group_inactive_bg = defaultBase16Colors.base04;
    powerline_fg = defaultBase16Colors.base01;
    powerline_bg = [
      defaultBase16Colors.base08
      defaultBase16Colors.base09
      defaultBase16Colors.base0A
      defaultBase16Colors.base0B
      defaultBase16Colors.base0C
      defaultBase16Colors.base0D
      defaultBase16Colors.base0E
      defaultBase16Colors.base0F
    ];
  };

  defaultExtensionProps = {
    font = defaultTextFont.family;
    fontsize = defaultTextFont.size;
    foreground = defaultBase16Colors.base04;
    background = defaultBase16Colors.base00;
  };

  defaultLayoutProps = {
    margin = 3;
    border_width = 3;
    border_focus = defaultBase16Colors.base02;
    border_normal = defaultBase16Colors.base07;
  };

  defaultWidgetProps = {
    font = defaultTextFont.family;
    fontsize = defaultTextFont.size;
    margin = 0;
    padding = 0;
    foreground = defaultBase16Colors.base00;
    background = defaultBase16Colors.base07;
  };
in
{
  config = {
    xdg.configFile."desktop/default_theme.yaml".text = lib.generators.toYAML { } {
      path = null;
      logo = ""; # Nixos logo

      font = {
        text = defaultTextFont;
        icon = defaultIconFont;
        weather = defaultWeatherFont;
        logo = defaultLogoFont;
      };
      bars = {
        top = {
          height = defaultBarHeight;
          margin = [
            8
            8
            4
            8
          ];
          opacity = defaultBarOpacity;
        };
        bottom = {
          height = defaultBarHeight;
          margin = [
            4
            8
            8
            8
          ];
          opacity = defaultBarOpacity;
        };
      };

      foreground_dark = defaultBase16Colors.base00;
      foreground_light = defaultBase16Colors.base04;

      base16_scheme_colors = defaultBase16Colors;
      named_colors = defaultNamedColors;
      extension = defaultExtensionProps;
      layout = defaultLayoutProps;
      widget = defaultWidgetProps;
    };
  };
}
