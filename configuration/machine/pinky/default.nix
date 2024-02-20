{
  config,
  inputs,
  lib,
  pkgs,
  sops-nix,
  ...
}: {
  imports = [
    ./boot.nix
    ./fs.nix
    ./hardware.nix
    ./networking.nix

    ../common
    ../../module/machine
    ../../module/mount

    ../../role/machine

    sops-nix.nixosModules.sops
  ];

  config = {
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    looniversity = {
      role.gateway.enable = true;
      service.lldap.enable = true;
    };

    sops.defaultSopsFile = ../../secret/secrets.yaml;
    sops.defaultSopsFormat = "yaml";

    programs.zsh = {
      enable = true;
      loginShellInit = ''
        # do not glob # as it conflicts with nix flakes
        disable -p '#'
      '';
    };

    environment.localBinInPath = true;

    system.stateVersion = "23.05";
  };
}
