{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.thunderbird;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.thunderbird = {
    enable = mkEnableOption "thunderbird";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.thunderbird
    ];
  };
}
