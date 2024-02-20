{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.looniversity.sops;
  inherit (lib) mkEnableOption mkIf;
in {
  options.looniversity.sops = {
    enable = mkEnableOption "sops";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.sops
      pkgs.ssh-to-age
    ];

    sops.age.sshKeyPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
    ];
  };
}
