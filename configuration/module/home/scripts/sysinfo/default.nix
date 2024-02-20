{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.scripts.sysinfo;
  inherit (lib) mkDefault mkEnableOption mkIf;

  sysinfo = pkgs.writeScriptBin "sysinfo" ''
    #!${pkgs.runtimeShell}
    width=$(tput cols)
    ${pkgs.figlet}/bin/figlet -w ''${width} "System Information"
    ${pkgs.neofetch}/bin/neofetch
    ${pkgs.inxi}/bin/inxi -v 2 --width ''${width}
  '';
in {
  options.looniversity.scripts.sysinfo = {
    enable = mkEnableOption "sysinfo";
  };

  config = mkIf cfg.enable {
    home.packages = [sysinfo];
  };
}
