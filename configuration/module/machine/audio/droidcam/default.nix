{
  config,
  lib,
  ...
}: let
  cfg = config.looniversity.droidcam;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.droidcam = {
    enable = mkEnableOption "droidcam";
  };

  config = mkIf cfg.enable {
    programs.droidcam = {
      enable = true;
    };
  };
}
