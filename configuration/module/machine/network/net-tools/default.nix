{ config
, lib
, pkgs
, ...
}:
let
  cfg = config.looniversity.network.net-tools;

  inherit (lib) mkEnableOption mkIf;
in
{
  options.looniversity.network.net-tools = {
    enable = mkEnableOption "networking tools";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bridge-utils
      dig
      nfs-utils
    ];

    environment.shellAliases = {
      dig = "dig @10.44.0.1";
    };
  };
}
