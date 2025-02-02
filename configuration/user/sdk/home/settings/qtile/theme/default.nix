{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  config = lib.mkIf osConfig.looniversity.desktop.environment.qtile.enable {
    xdg.configFile."desktop/theme.yaml".text = ''
      ---
      logo: "" # Nixos logo

      font:
        text:
          family: "Hack Nerd Font"
          size: 16
        icon:
          family: "Material Design Icons"
          size: 22
        weather:
          family: "Hack Nerd Font"
          size: 22
        logo:
          family: "Hack Nerd Font"
          size: 22

      bar:
        top:
          height: 40
          margin:
          - 8
          - 8
          - 0
          - 8
          opacity: 0.8
        bottom:
          height: 40
          margin:
          - 0
          - 8
          - 8
          - 8
          opacity: 0.8

      # base16_scheme_colors:
      #   base00: "24273a" # base
      #   base01: "1e2030" # mantle
      #   base02: "363a4f" # surface0
      #   base03: "494d64" # surface1
      #   base04: "5b6078" # surface2
      #   base05: "cad3f5" # text
      #   base06: "f4dbd6" # rosewater
      #   base07: "b7bdf8" # lavender
      #   base08: "ed8796" # red
      #   base09: "f5a97f" # peach
      #   base0A: "eed49f" # yellow
      #   base0B: "a6da95" # green
      #   base0C: "8bd5ca" # teal
      #   base0D: "8aadf4" # blue
      #   base0E: "c6a0f6" # mauve
      #   base0F: "f0c6c6" # flamingo
      base16_scheme_name: nord
      base16_scheme_dir: ${pkgs.base16-schemes}/share/themes

      layout:
        margin: 9
        border_width: 4
        border_focus: "base08"

      widget:
        font: "DejaVu Sans"
        fontsize: 16
        foreground: "base01"
        # background: "panel_bg"
    '';
  };
}
