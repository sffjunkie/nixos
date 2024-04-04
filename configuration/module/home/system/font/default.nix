{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.font;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.font = {
    enable = mkEnableOption "font";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.font-awesome
      pkgs.material-design-icons
      pkgs.roboto
      (pkgs.nerdfonts.override {
        fonts = [
          "Hack"
          "DroidSansMono"
        ];
      })
    ];
  };
}
