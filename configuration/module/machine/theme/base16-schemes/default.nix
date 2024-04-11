{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.theme.base16-schemes;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.looniversity.theme.base16-schemes = {
    enable = mkEnableOption "base16-schemes";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.base16-schemes
    ];
  };
}
