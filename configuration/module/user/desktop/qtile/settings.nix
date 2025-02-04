{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  config = lib.mkIf osConfig.looniversity.desktop.environment.qtile.enable {
    xdg.configFile."desktop/default_settings.yaml".text = lib.generators.toYAML { } {
      keys = {
        Alt = "mod1";
        Ctrl = "control";
        Hyper = "mod3";
        Shift = "shift";
        Super = "mod4";
      };
    };
  };
}
