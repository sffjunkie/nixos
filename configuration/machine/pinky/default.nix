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
    ./service

    ../common

    sops-nix.nixosModules.sops
  ];

  config = {
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    looniversity = {
      service.lldap.enable = true;
    };

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
