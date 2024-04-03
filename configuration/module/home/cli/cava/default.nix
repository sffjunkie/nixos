{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.looniversity.cava;

  iniFmt = pkgs.formats.ini {};

  camelCaseToSnakeCase =
    replaceStrings upperChars (map (s: "_${s}") lowerChars);
in {
  meta.maintainers = [maintainers.bddvlpr];

  options.looniversity.cava = {
    enable = mkEnableOption "Cava audio visualizer";

    package = mkPackageOption pkgs "cava" {};

    settings = mkOption {
      type = iniFmt.type;
      default = {};
      example = literalExpression ''
        {
          general.framerate = 60;
          input.method = "alsa";
          smoothing.noiseReduction = 88;
          color = {
            background = "'#000000'";
            foreground = "'#FFFFFF'";
          };
        }
      '';
      description = ''
        Settings to be written to the Cava configuration file.
        See <link xlink:href="https://github.com/karlstav/cava/blob/master/example_files/config" /> for all available options.
      '';
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = [cfg.package];

      file."${config.xdg.configHome}/cava/config" = mkIf (cfg.settings != {}) {
        text = ''
          ; Generated by Home Manager

          ${generators.toINI {
              mkKeyValue = k: v:
                generators.mkKeyValueDefault {} "=" (camelCaseToSnakeCase k) v;
            }
            cfg.settings}
        '';
      };
    };
  };
}
