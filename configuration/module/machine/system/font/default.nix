{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.looniversity.system.font;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.looniversity.system.font = {
    enable = mkEnableOption "font";
  };

  config = mkIf cfg.enable {
    fonts.packages = [
      pkgs.font-awesome
      pkgs.material-design-icons
      pkgs.noto-fonts
      pkgs.roboto
      pkgs.weather-icons
      (pkgs.nerdfonts.override {
        fonts = [
          "Hack"
          "DroidSansMono"
        ];
      })
    ];
  };
}
