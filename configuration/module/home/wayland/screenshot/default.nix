{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.wayland.screenshot;

  sshot = pkgs.writeShellScriptBin ''
    ${pkgs.grim}/bin/grim -g "''$(${pkgs.slurp}/bin/slurp)"
  '';

  inherit (lib) mkDefault mkEnableOption mkIf mkOption;
in {
  options.looniversity.wayland.screenshot.enable = mkEnableOption "screenshot support";

  config = mkIf cfg.enable {
    home.packages = [
      sshot
    ];
  };
}
